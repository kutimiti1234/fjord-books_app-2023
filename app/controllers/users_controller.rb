# frozen_string_literal: true

class UsersController < ApplicationController
  before_action :set_user, only: %i[show edit update]

  def index
    @users = User.order(:id).page(params[:page])
  end

  def show; end

  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:email, :zip_code, :address, :profile)
  end
end
