function customMenu(node) {
    var items = {
        "edit": {
            "label": "Bearbeiten",
            "action": function () {
                var edit_path = node.attr("data-edit_path");
                $.get(edit_path, { 'render_template': false }, function (new_data) {
                    $("div#content").html(new_data);
                });
            }
        },
        "delete": {
            "label": "Löschen",
            "action": function () {
                if (!confirm("Sind Sie sicher?")) {
                    return;
                }
                var delete_path = node.attr("data-delete_path");
                var parent_url = this._get_parent(node).children("a").attr("href");
                var token = $("meta[name=csrf-token]").attr("content");
                $.post(delete_path, { '_method': 'delete', 'authenticity_token': token});
                $("div#books_tree").jstree('delete_node', node);
                $.get(parent_url, { 'render_template': false }, function (new_data) {
                    $("div#content").html(new_data);
                });
            }
        },
        "new_chunk": {
            "label": "Neuer Textabschnitt",
            "action": function () {
                var new_chunk_path = node.attr("data-new_chunk_path");
                $.get(new_chunk_path, { 'render_template': false }, function (new_data) {
                    $("div#content").html(new_data);
                });
            }
        }
    };

    if ($(node).hasClass("book")) {
        delete items.delete;
        if (node.attr("data-closed") == "true") {
            delete items.edit;
            delete items.new_chunk;
        }
    }

    if ($(node).hasClass("chunk")) {
        delete items.new_chunk
        delete items.edit
        if (this._get_parent(node).attr("data-closed") == "true") {
            delete items.delete;
        }
    }

    return items;
}

$(document).ready(function () {
    $("div#books_tree").jstree({
        "themes": { "theme": "apple", "dots": true, "icons": true },
        "ui": { "select_limit": 1 },
        "contextmenu": { "items": customMenu},
        "crrm": {
            "move": {
                "check_move": function (m) {
                    var p = this._get_parent(m.o);
                    if (!p || p.attr("data-closed") == "true") return false;
                    p = p == -1 ? this.get_container() : p;
                    if (p === m.np) return true;
                    if (p[0] && m.np[0] && p[0] === m.np[0]) return true;
                    return false;
                }
            }
        },
        "dnd": {
            "drop_finish": function (data) {
                var book = this._get_parent(data.r);
                var chunks = this._get_children(book);
                var chunk_ids = new Array(chunks.length);
                for (var i = 0; i < chunks.length; i++) {
                    chunk_ids[i] = chunks[i].id.replace(/chunk/g, "");
                }
                var book_url = book.children("a").attr("href");
                var token = $("meta[name=csrf-token]").attr("content");
                $.post(book_url, { '_method': 'put', 'authenticity_token': token, 'update_chunk_order_only': true, 'chunk_order': chunk_ids.toString() }, function (new_data) {
                    $("div#content").html(new_data);
                });
            },
            "drop_target": true,
            "drag_target": false
        },
        "plugins": [ "themes", "html_data", "ui", "contextmenu", "crrm", "dnd"]
    }).bind("select_node.jstree", function (event, data) {
            var node_url = data.rslt.obj.children("a").attr("href");
            $.get(node_url, { 'render_template': false }, function (new_data) {
                $("div#content").html(new_data);
            });
        });
});
