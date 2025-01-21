class CommentsController < ApplicationController
  before_action :set_prototype, only: [:create]
  
  def create
    @comment = Comment.new(comment_params)

    if @comment.save
      redirect_to prototype_path(@prototype)
    else
       @comments = @prototype.comments
       render "prototypes/show", status: :unprocessable_entity
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:content).merge(user_id: current_user.id, prototype_id: params[:prototype_id])
  end

  def set_prototype
    @prototype = Prototype.find(params[:prototype_id])
  end

  def show
    @prototype = Prototype.find(params[:id])
    @comments = @prototype.comments
  end
end
