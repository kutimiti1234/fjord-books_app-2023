# frozen_string_literal: true

class UsersController < ApplicationController
  before_action :set_user, only: %i[show edit update]

  def index
    @users = User.order(:id).page(params[:page])
  end

  def show; end

  def edit
    return if @user == current_user

    redirect_to user_url(@user), notice: t('controllers.common.alert_update', name: User.model_name.human)
  end

  # PATCH/PUT /users/1 or /users/1.json
  def update
    return if @user == current_user

    redirect_to user_url(@user), notice: t('controllers.common.notice_update', name: User.model_name.human)
  end

  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:email, :zip_code, :address, :profile)
  end
end
