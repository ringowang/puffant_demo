class MeetupsController < ApplicationController
  before_action :find_user

  def index
    @meetups = @user.meetups
  end

  def show
    @meetup = @user.meetups.find(params[:id])
  end

  def new
    @meetup = @user.meetups.new
  end

  def create
    @meetup = @user.meetups.new(meetup_params)
    if @meetup.save
      redirect_to user_meetups_path(@user)
    else
      render  :new
    end
  end

  def edit
    @meetup = @user.meetups.find(params[:id])
  end

  def update
    @meetup = @user.meetups.find(params[:id])

    if @meetup.update(meetup_params)
      redirect_to user_meetups_path(@user)
    else
      render edit_user_meetup(@user)
    end
  end


private
    def find_user
      @user = User.find(params[:user_id])
    end

    def meetup_params
      params.require(:meetup).permit(:comment, :name)
    end
end
