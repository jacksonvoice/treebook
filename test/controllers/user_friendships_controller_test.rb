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
					get :new, friend_id: users(:olivia).id 
					assert_match /#{users(:olivia).full_name}/, response.body
				end
		end
	end



end
