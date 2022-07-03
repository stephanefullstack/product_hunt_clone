class ProductsController < ApplicationController
  skip_before_action :authenticate_user!, only: :index

  def index
    @products = Product.all
  end

  def new
    @product = Product.new
  end

  def create
    @product = Product.new
    @product.name = params[:product][:product_name]
    @product.tagline = params[:product][:tagline]
    @product.save
    redirect_to root_url
  end
end
