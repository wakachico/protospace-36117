class PrototypesController < ApplicationController
  before_action :set_prototype, only: [:edit, :show, :update, :destroy]
  before_action :authenticate_user!, only: [:new, :edit, :destroy]


  def index
    @prototypes = Prototype.includes(:user)
  end

  def new
    @prototype = Prototype.new
  end

  def create
    # binding.pry
    @prototype = Prototype.create(prototype_params)
      if  @prototype.save
        redirect_to root_path
      else
        render :new
      end
  end

  def show
    @comment = Comment.new
    @comments = @prototype.comments.includes(:user)
  end

  def edit
    # binding.pry
    unless current_user.id == @prototype.user.id
      redirect_to root_path
    end
  end

  def update
    # binding.pry
    @prototype.update(prototype_params)
    if  @prototype.save
      redirect_to prototype_path(@prototype.id)
    else
      render :edit
    end
  end

  def destroy
    @prototype.destroy
    redirect_to root_path
  end

  private
def set_prototype
  @prototype = Prototype.find(params[:id])
end

  def prototype_params
    params.require(:prototype).permit(:title, :catch_copy, :concept, :image).merge(user_id: current_user.id)
  end
end

