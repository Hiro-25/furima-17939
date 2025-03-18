class ItemsController < ApplicationController
  before_action :set_item, only: [:edit, :show, :update, :destroy]
  before_action :move_to_index, except: [:index, :show]

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

  def destroy
    @item.destroy
    redirect_to root_path, notice: '商品が削除されました。'
  end

  def edit
  end

  def update
    if @item.update(item_params)
      redirect_to root_path, notice: '商品情報が更新されました。'
    else
      render :edit
    end
  end

  def show
  end

  private

  def item_params
    params.require(:item).permit(:name, :description, :price, :image, :category_id, :condition_id, :shipping_fee_id,
                                 :prefecture_id, :shipping_days_id).merge(user_id: current_user.id)
  end
end
