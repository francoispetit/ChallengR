class CategoriesController < ApplicationController
  def create
    @category = Category.create(category_params)
  end

  def update
    @category = Category.update(category_params)
  end

  def delete
    Category.find(params).destroy
  end

private

  def category_params
    params.require(:category).permit(:category_name)
  end
end
