class OrdersController < ApplicationController
  before_action :authenticate_user!
  before_action :set_item
  before_action :redirect_if_invalid_user_or_sold_out

  def index
    @order_address = OrderAddress.new
  end

  def create
    @order_address = OrderAddress.new(order_address_params)

    if @order_address.valid?
      Payjp.api_key = 'sk_test_' # 自身のPAY.JPテスト秘密鍵を記述しましょう
      Payjp::Charge.create(
        amount: order_params[:price],  # 商品の値段
        card: order_params[:token],    # カードトークン
        currency: 'jpy' # 通貨の種類（日本円）
      )
      @order_address.save
      redirect_to root_path
    else
      puts @order_address.errors.full_messages
      render :index, status: :unprocessable_entity
    end
  end

  private

  def order_address_params
    params.require(:order_address).permit(
      :postal_code, :prefecture_id, :city, :address,
      :building, :phone_number
    ).merge(
      user_id: current_user.id,
      item_id: params[:item_id]
      # token: params[:order_address][:token]
    )
  end

  def set_item
    @item = Item.find(params[:item_id])
  end

  def redirect_if_invalid_user_or_sold_out
    return unless current_user == @item.user || @item.order.present?

    redirect_to root_path
  end

  def pay_item
    Payjp.api_key = ENV['PAYJP_SECRET_KEY']
    Payjp::Charge.create(
      amount: @item.price,
      card: order_address_params[:token],
      currency: 'jpy'
    )
  end
end
