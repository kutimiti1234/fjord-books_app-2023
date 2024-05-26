# frozen_string_literal: true

class CommentsController < ApplicationController
  before_action :set_commentable, only: %i[new create]

  # GET /comments/1
  def show
    @comment = Comment.find(params[:id])
    @commentable = @comment.commentable
  end

  # GET /comments/new
  def new
    @comment = @commentable.comments.new
  end

  # GET /comments/1/edit
  def edit
    @comment = current_user.comments.find(params[:id])
    @commentable = @comment.commentable
  end

  # POST /comments
  def create
    @comment = @commentable.comments.new(comment_params) do |c|
      c.user = current_user
    end

    if @comment.save
      redirect_to comment_url(@comment), notice: t('controllers.common.notice_create', name: Comment.model_name.human)

    else
      render :new, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /comments/1
  def update
    @comment = current_user.comments.find(params[:id])

    if @comment.update(comment_params)
      redirect_to comment_url(@comment), notice: t('controllers.common.notice_update', name: Comment.model_name.human)
    else
      render :new, status: :unprocessable_entity
    end
  end

  # DELETE /comments/1
  def destroy
    @comment = current_user.comments.find(params[:id])
    @commentable = @comment.commentable

    @comment.destroy

    redirect_to polymorphic_url(@commentable), notice: t('controllers.common.notice_destroy', name: Comment.model_name.human)
  end

  private

  # Only allow a list of trusted parameters through.
  def comment_params
    params.require(:comment).permit(:title, :body)
  end
end
