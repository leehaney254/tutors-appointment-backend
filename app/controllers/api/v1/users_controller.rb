class Api::V1::UsersController < ApplicationController
  before_action :set_user, only: %i[show update destroy]

  def index
    @users = User.all
    if @users.empty?
      render json: { message: 'There are no user!' }, status: :not_found
    else
      render json: @users
    end
  end

  # GET /users/1
  def show
    if @user
      render json: @user
    else
      render json: 'The user you are trying to find does not exist', status: :not_found
    end
  end

  # POST /users
  def create
    @user = User.create(user_params)

    if @user.valid?
      render json: { message: "#{@user.name} created successfully" }, status: :created
    else
      render json: @user.errors, status: :unprocessable_entity
    end
  end

  def login
    @user = User.find_by(name: params[:name])
    puts @user
    if @user&.authenticate(params[:password])
      token = encode_token({ name: @user.name })
      render json: { name: @user.name, id: @user.id, token: }
    else
      render json: { error: 'Failed to login' }, status: :not_acceptable
    end
  end

  # PATCH/PUT /users/1
  def update
    if @user.update(user_params)
      render json: { message: 'Updated successfully' }
    else
      render json: @user.errors, status: :unprocessable_entity
    end
  end

  # DELETE /users/1
  def destroy
    render json: { message: 'Signed out successfully' }
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
    params.require(:user).permit(:name, :password)
  end
end
