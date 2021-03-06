require 'test_helper'

class UserFriendshipsControllerTest < ActionController::TestCase

	context "#new" do 

		context "when not logged in" do 
			should "redirect to the login page" do 
				get :new
				assert_response :redirect
			end
		end


		context "when logged in" do 

			setup do 
				sign_in users(:daniel)
			end	

				should "be successfull" do 
					get :new
					assert_response :success
				end

				should "should set a flash error if the friend_id params is missing" do 
					get :new, {}
					assert_equal "Friend Required", flash[:error]
				end

				should "display friends name" do 
					get :new, friend_id: users(:olivia)
					assert_match /#{users(:olivia).full_name}/, response.body
				end

				should "assign a new user friendship" do 
					get :new, friend_id: users(:olivia)
					assert assigns(:user_friendship)
				end

				should "assigns a new user friendship to the correct friend" do 
					get :new, friend_id: users(:olivia)
					assert_equal users(:olivia), assigns(:user_friendship).friend
				end

				should "assign a new user friendship to the currenlty logged in user" do  
					get :new, friend_id: users(:olivia)
					assert_equal users(:daniel), assigns(:user_friendship).user
				end

				should "returns a 404 status if no friend is found" do 
					get :new, friend_id: 'invlaid'
					assert_response :not_found
				end
			
				should "ask if you want to friend the user" do  
					get :new, friend_id: users(:olivia)
					assert_match /Do you really want to friend #{users(:olivia).full_name}?/, response.body
				end
		end
	end

	context "#create" do
		context "when not logged in" do 
			
			should "redirect to the login page" do 
				get :new
				assert_response :redirect
				assert_redirected_to login_path
			end
		end

		context "when logged in" do 
			setup do
				sign_in users(:daniel)
			end

			context "with no friend_id" do 
				setup do 
					post :create
				end

				should "set the flash error message" do
					assert !flash[:error].empty?
				end

				should "redirect to the site root" do 
					assert_redirected_to root_path
				end
			end

			context "with a valid friend id" do
				setup do 
					post :create, user_friendship: { friend_id: users(:jackson) }
				end

				should "assign a friend object" do
					assert assigns(:friend)
					assert_equal users(:jackson), assigns(:friend)
				end

				should "assign a user-friendship object" do 
					assert assigns(:user_friendship)
					assert_equal users(:daniel), assigns(:user_friendship).user
					assert_equal users(:jackson), assigns(:user_friendship).friend
				end

				should "create a friendship" do 
					assert users(:daniel).friends.include?(users(:jackson))
				end

				should "redirect to the profile page of the friend" do 
					assert_response :redirect
					assert_redirected_to profile_path(users(:jackson))
				end

				should "show flash success message confirming friendship" do
					assert flash[:success]
					assert_equal "You are now friends with #{users(:jackson).full_name}!", flash[:success]
				end


			end
		end
	end
end
