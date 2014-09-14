class UserFriendshipsController < ApplicationController
before_action :authenticate_user!, only: [:new]


def new
	if params[:friend_id]
		@friend = User.find(params[:friend_id])
	else
		flash[:error] = "Friend Required"
	end
end


# private
	
# 	# def user_friendship_params
# 	# 	params.require(:friend).permit(:friend_id, :user_id)
# 	# end
end
