require 'test_helper'

class UserTest < ActiveSupport::TestCase

  test 'must have a first and a last name' do
    user = User.new

    assert !user.save

    user.first_name = 'Max'
    user.last_name = 'Mustermann'
    user.email = "max@mustermann.de"
    user.password = "test1234"
    assert user.save
  end

end
