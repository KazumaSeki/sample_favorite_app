class RecipesController < ApplicationController
before_action :authenticate_user!, except: [:index]
before_action :set_recipe, only: [:show, :edit, :update, :destroy]

  def index
    @recipes = Recipe.all
  end

  def show
  end

  def new
    @recipe = Recipe.new
  end

  def create
    @recipe = Recipe.new(recipe_params)
    @recipe.user_id = current_user.id
    if @recipe.save
      redirect_to recipe_path(@recipe), notice:'投稿に成功しました'
    else
      render :new
    end
  end

  def edit
    if @recipe.user_id != current_user.id
      redirect_to recipes_path, alert: '不正なアクセスです'
    end
  end

  def update
    if @recipe.update(recipe_params)
      redirect_to recipe_path(@recipe), notice:'変更に成功しました'
    else
      render :edit
    end
  end

  def destroy
     @recipe.destroy
     redirect_to recipes_path, notice:'削除に成功しました'
  end

  private
    def set_recipe
      @recipe = Recipe.find(params[:id])
    end

    def recipe_params
      params.require(:recipe).permit(:title, :content)
    end
end
