require 'test_helper'

class UserFriendshipTest < ActiveSupport::TestCase

	should belong_to(:user)
	should belong_to(:friend)

	test "that creating a user friendship is successful without raising an exception" do
		assert_nothing_raised do
		UserFriendship.create user: users(:daniel), friend: users(:olivia)
	end
	
  end

  
  test "that creating a friendship based on user id and friend id works" do
    UserFriendship.create user_id: users(:daniel).id, friend_id: users(:olivia).id
    assert users(:daniel).friends.include?(users(:olivia))
  end

end
