require 'test_helper'

class BookTest < ActiveSupport::TestCase

  test 'must have a title and an edition' do
    book = Book.new

    assert !book.save

    book.title = 'Testbuch'
    book.edition = 1
    assert book.save
  end

  test 'is published' do
    assert books(:rails_tests).published?
    assert !books(:javascript).published?
  end

  test 'has chunks' do
    chunk = Chunk.new
    book = Book.new

    assert !book.has_chunks?

    book.chunks << chunk
    assert book.has_chunks?
  end

end
