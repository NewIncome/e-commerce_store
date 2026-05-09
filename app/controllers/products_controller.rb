class ProductsController < ApplicationController
  before_action :set_product, only: %i[ show edit update destroy ]
  def index
    @products = Product.all
  end

  def show
  end

  def new
    @product = Product.new   # needed to display the form fields
  end

  def create
    @product = Product.new(product_params)
    if @product.save
     redirect_to @product
    else
     render :new, status: :unprocessable_entity  # http status 422
    end
  end

  def edit
  end

  def update
    if @product.update(product_params)
      flash[:success] = "Object was successfully updated"
      redirect_to @product
    else
      render "edit", status: :unprocessable_entity
    end
  end

  def destroy
    @product.destroy
    redirect_to products_path
  end


  private
    def set_product
      @product = Product.find(params[:id])
    end

    def product_params
      params.expect(product: [ :name ])
    end
end

=begin
      Prefix  Verb    URI Pattern                  Controller#Action
        root  GET     /                              products#index
    products  GET     /products(.:format)            products#index
              POST    /products(.:format)            products#create
 new_product  GET     /products/new(.:format)        products#new
edit_product  GET     /products/:id/edit(.:format)   products#edit
     product  GET     /products/:id(.:format)        products#show
              PATCH   /products/:id(.:format)        products#update
              PUT     /products/:id(.:format)        products#update
              DELETE  /products/:id(.:format)        products#destroy
=end
