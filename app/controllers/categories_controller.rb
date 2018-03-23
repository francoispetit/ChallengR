class CategoriesController < ApplicationController
  def create
    @category = Category.create(category_params)
    Challenge.find(params[:challid]).categories << @category
    redirect_to challenge_path(params[:challid])
  end

  def update
    @category = Category.update(category_params)
  end

  def destroy
    Category.find(params).destroy
  end

private

  def category_params
    params.permit(:category_name)
  end
end
