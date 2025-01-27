class PrototypesController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create]
  before_action :ensure_correct_user, only: [:edit]
  def index
    @prototypes = Prototype.all
  end

  def new
    @prototype = Prototype.new
  end

  def create
    @prototype = Prototype.new(prototype_params.merge(user_id: current_user.id))
    if @prototype.save
    redirect_to root_path(@prototype)
    else
    render :new,  status: :unprocessable_entity
    end
  end

  def show
    @prototype = Prototype.find(params[:id])
    @comment = Comment.new
    @comments = @prototype.comments.includes(:user) 
  end

  def edit
    @prototype = Prototype.find(params[:id])

  end

  def update
    @prototype = Prototype.find(params[:id])
    
    if params[:prototype][:title].blank? || params[:prototype][:catch_copy].blank? || params[:prototype][:concept].blank? || params[:prototype][:image].blank?
      return render :edit
    end

    if @prototype.update(prototype_params)
      redirect_to @prototype, notice: 'プロトタイプが更新されました'
    else
      render :edit
    end
  end

  def destroy
      @prototype = Prototype.find(params[:id])
      @prototype.destroy
      redirect_to root_path
  end


  private 

  def prototype_params
   params.require(:prototype).permit(:title, :catch_copy, :concept, :image)
  end

  def ensure_correct_user
    @prototype = Prototype.find(params[:id])
    unless current_user && current_user.id == @prototype.user_id
      redirect_to root_path, alert: 'You are not authorized to edit this prototype.'
    end

  end
end
