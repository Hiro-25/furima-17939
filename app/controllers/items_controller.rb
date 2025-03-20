class ItemsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]
  # before_action :move_to_index, only: [:edit, :update, :destroy]

  def index
    @items = Item.all
  end

  def new
    @item = Item.new
  end

  def create
    @item = Item.new(item_params)
    if @item.save
      redirect_to root_path, notice: '商品が出品されました。'
    else
      render :new
    end
  end

  # def destroy
  # @item.destroy
  # redirect_to root_path, notice: '商品が削除されました。'
  # end

  # def edit
  # end

  # def update
  # if @item.update(item_params)
  # redirect_to root_path, notice: '商品情報が更新されました。'
  # else
  # render :edit
  # end
  # end

  # def show
  # end

  # private

  # def move_to_index
  # redirect_to root_path unless current_user == @item.user
  # end
end
