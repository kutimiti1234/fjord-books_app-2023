# frozen_string_literal: true

class CommentsController < ApplicationController
  before_action :set_commentable, only: %i[new create]

  # GET /comments/1 or /comments/1.json
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
    @comment = Comment.find(params[:id])
    @commentable = @comment.commentable

    return unless @comment.user_id != current_user.id

    redirect_to polymorphic_url(@comment), status: :forbidden
  end

  # POST /comments or /comments.json
  def create
    @comment = @commentable.comments.new(comment_params) do |c|
      c.user_id = current_user.id
    end

    if @comment.save
      redirect_to comment_url(@comment), notice: 'Comment was successfully created.'
    else
      render :new, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /comments/1 or /comments/1.json
  def update
    @comment = Comment.find(params[:id])
    if @comment.user_id != current_user.id
      redirect_to polymorphic_url(@comment), status: :forbidden
      return
    end

    if @comment.update(comment_params)
      redirect_to comment_url(@comment), notice: 'Comment was successfully updated.'
    else
      render :new, status: :unprocessable_entity
    end
  end

  # DELETE /comments/1 or /comments/1.json
  def destroy
    @comment = Comment.find(params[:id])
    @commentable = @comment.commentable
    if @comment.user_id != current_user.id
      redirect_to polymorphic_url(@comment), status: :forbidden
      return
    end

    @comment.destroy

    redirect_to polymorphic_url(@commentable), notice: 'Comment was successfully destroyed.'
  end

  private

  # Only allow a list of trusted parameters through.
  def comment_params
    params.require(:comment).permit(:title, :body)
  end
end
