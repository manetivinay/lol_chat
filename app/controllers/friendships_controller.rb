class FriendshipsController < ApplicationController

  # POST /friendships
  # POST /friendships.json
  def create
    @friendship = current_user.friendships.build(:friend_id => params[:friend_id])

    if @friendship.save
      flash[:notice] = 'you have Added friend to your list.'
      redirect_to root_url
    else
      flash[:notice] = 'Unable to Add friend.'
      redirect_to root_url
    end
  end


  # DELETE /friendships/1
  # DELETE /friendships/1.json
  def destroy
    @friendship = current_user.friendships.find(params[:id])
    @friendship.destroy
    flash[:notice] = 'You have removed a friend from your list successfully'
    redirect_to current_user
  end
end
