class BooksController < ApplicationController

  layout 'books_and_chunks'
  before_filter :authenticate_user!
  before_filter :find_all_users, :only => [:new, :edit, :new_edition]

  # GET /books
  # GET /books.json
  def index
    @books = current_user.books

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @books }
    end
  end

  # GET /books/1
  # GET /books/1.json
  def show
    @book = Book.find(params[:id])

    @authorship = Authorship.find_by_book_id_and_user_id(@book.id, current_user.id)
    @exportSettings = @authorship.pdf_export_setting

    if (@exportSettings == nil)
      @exportSettings = PdfExportSetting.create!
      @authorship.pdf_export_setting = @exportSettings
      @authorship.save!
    end


    respond_to do |format|
      format.html { render_check_template }
      format.json { render json: @book }
    end
  end

  def print
    @book = Book.find(params[:id])

    @authorship = Authorship.find_by_book_id_and_user_id(@book.id, current_user.id)
    @exportSettings = @authorship.pdf_export_setting

    foot = @exportSettings.insertFoot ? @exportSettings.foot : ''
    head = @exportSettings.insertHead ? @exportSettings.head : ''

    respond_to do |format|
      format.pdf do
        pdfRenderOptions = {
            :pdf => @book.title,
            :cover => "0.0.0.0:3000/cover.html?title=#{@book.title}&authors=#{@book.users_list_real_names}&edition=#{@book.edition}&publish=#{@book.publishedGerFormat}",
            :footer => { :right => '[page]', :center => foot },
            :header => { :center => head },
            :margin => { #in cm
                         :top => @exportSettings.marginTop * 10,
                         :right => @exportSettings.marginRight * 10,
                         :bottom => @exportSettings.marginBottom * 10,
                         :left => @exportSettings.marginLeft * 10,
            },
            :layout => 'print'
        }

        if @exportSettings.tableOfContent
          pdfRenderOptions.merge!(:toc => {
              :depth => 6,
              :header_text => "Inhaltsverzeichnis"
          })
        end

        render pdfRenderOptions
      end
    end
  end

  # GET /books/new
  # GET /books/new.json
  def new
    @book = Book.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @book }
    end
  end

  # GET /books/1/edit
  def edit
    @book = Book.find(params[:id])

    unless @book.closed?
      render_check_template
    else
      flash[:error] = I18n.t('views.book.flash_errors.book_is_closed')
      render_check_template 'show'
    end
  end

  # POST /books
  # POST /books.json
  def create
    @book = Book.new(params[:book])

    old_book_id = session[:old_book_id]

    respond_to do |format|
      if @book.save
        unless old_book_id.nil?
          old_book = Book.find(old_book_id)
          old_book.chunks.each do |old_chunk|
            chunk = Chunk.new(old_chunk.sliced_attributes)
            chunk.book = @book
            chunk.save
            @book.chunks << chunk
          end
          session[:old_book_id] = nil
        end
        format.html { redirect_to @book, notice: I18n.t('views.book.flash_messages.book_was_successfully_created') }
        format.json { render json: @book, status: :created, location: @book }
      else
        format.html do
          @users ||= User.all
          render action: 'new'
        end
        format.json { render json: @book.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /books/1
  # PUT /books/1.json
  def update
    @book = Book.find(params[:id])

    if params[:update_chunk_order_only] == 'true'
      chunk_ids = params[:chunk_order].split(',')
      chunk_ids.each_with_index do |chunk_id, i|
        chunk = Chunk.find(chunk_id)
        chunk.update_attribute(:position, i)
      end
    else
      params[:book][:user_ids] ||= []
    end

    respond_to do |format|
      if params[:update_chunk_order_only] == 'true'
        format.html { render 'show', layout: false }
      else
        if @book.update_attributes(params[:book])
          format.html { redirect_to @book, notice: I18n.t('views.book.flash_messages.book_was_successfully_updated') }
          format.json { head :no_content }
        else
          format.html { render action: "edit" }
          format.json { render json: @book.errors, status: :unprocessable_entity }
        end
      end
    end
  end

  def close
    @book = Book.find(params[:id])

    respond_to do |format|
      if @book.update_attributes(:closed => true, :published => Time.now)
        format.html { redirect_to @book, notice: I18n.t('views.book.flash_messages.book_was_successfully_closed') }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @book.errors, status: :unprocessable_entity }
      end
    end
  end

  def new_edition
    old_book = Book.find(params[:id])
    @book = Book.new(old_book.sliced_attributes)
    @book.users = old_book.users

    session[:old_book_id] = old_book.id
    render 'new'
  end

# DELETE /books/1
# DELETE /books/1.json
  def destroy
    @book = Book.find(params[:id])
    @book.destroy

    respond_to do |format|
      format.html { redirect_to books_url }
      format.json { head :no_content }
    end
  end

  private
  def find_all_users
    @users = User.all
  end

end
