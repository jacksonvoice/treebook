require 'test_helper'

class CustomRoutesTest < ActionDispatch::IntegrationTest
  test "that /login route opens the login page" do
  	get '/login'
  	assert_response :success
  end

  test "that /logout route open the logout page" do
  get '/logout'
  assert_response :redirect
  assert_redirected_to '/'
end

test "that /register route opens the sign in page" do 
	get '/register'
	assert_response :success
	end

  test "that a profile page works" do
    get '/jacksonvoice1'
    assert_response :success
  end
end
