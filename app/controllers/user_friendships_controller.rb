class UserFriendshipsController < ApplicationController
before_action :authenticate_user!, only: [:new]

	def new
		if params[:friend_id]
			@friend = User.where(profile_name: params[:friend_id]).first
			raise ActiveRecord::RecordNotFound if @friend.nil?
			@user_friendship = current_user.user_friendships.new(friend: @friend)
		else
			flash[:error] = "Friend Required"
		end
		rescue ActiveRecord::RecordNotFound
		render file: 'public/404', status: :not_found
	end

	def create
		if params[:friend_id]
			@friend = User.where(profile_name: params[:friend_id]).first
			@user_friendship = current_user.user_friendships.new(friend: @friend)
			@user_friendship.save
			redirect_to profile_path(@friend)
			flash[:success] = "You are now friends with #{@friend.full_name}!"
		else
			flash[:error] = "Friend required"
			redirect_to root_path
		end
	end


# private
	
# 	# def user_friendship_params
# 	# 	params.require(:friend).permit(:friend_id, :user_id)
# 	# end
end
