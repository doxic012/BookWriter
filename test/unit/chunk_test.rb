require 'test_helper'

class ChunkTest < ActiveSupport::TestCase

  test 'username' do
    chunk = Chunk.new
    user = users(:mmuster)
    chunk.user = user
    assert_equal(chunk.username, user.username)
  end


end
