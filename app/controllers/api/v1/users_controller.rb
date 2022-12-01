class Api::V1::UsersController < ApplicationController
  def index
    @users = User.all

    render json: @users
  end

  def show; end

  # POST /users
  def create
    @user = User.new(user_params)

    if @user.save
      render json: @user, status: :created
    else
      render json: @user.errors, status: :unprocessable_entity
    end
  end

  # DELETE /messages/1
  def destroy; end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_message
    @user = User.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def user_params
    params.require(:user).permit(:name, :email, :password)
  end
end
