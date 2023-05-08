class Api::V1::UsersController < ApplicationController
  before_action :set_user, only: %i[show update destroy]

  def index
    @users = User.all
    if @users
      render json: @users
    else
      render 'There is no user!'
    end
  end

  # GET /users/1
  def show
    if @user
      render json: @user
    else
      render json: 'The user you are trying to find does not exist'
    end
  end

  # POST /users
  def create
    @user = User.new(user_params)

    if @user.save
      render json: @user, status: :created, location: @user
    else
      render json: @user.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /users/1
  def update
    if @user.update(user_params)
      render json: @user
    else
      render json: @user.errors, status: :unprocessable_entity
    end
  end

  # DELETE /users/1
  def destroy
    @user.destroy
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_user
    @user = User.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    @user = nil
  end

  # Only allow a list of trusted parameters through.
  def user_params
    params.require(:user).permit(:name)
  end
end
