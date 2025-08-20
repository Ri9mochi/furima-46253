class OrdersController < ApplicationController
  before_action :authenticate_user!
  before_action :set_item, only: [:index, :create]
  before_action :redirect_if_ineligible, only: [:index, :create]

  def index
    gon.public_key = ENV['PAYJP_PUBLIC_KEY']
    @order_form = OrderForm.new
  end

  def create
    @order_form = OrderForm.new(order_form_params)
    unless @order_form.valid?
      gon.public_key = ENV['PAYJP_PUBLIC_KEY']
      return render :index, status: :unprocessable_entity
    end

    pay_item
    @order_form.save
    redirect_to root_path
  rescue Payjp::CardError => e
    gon.public_key = ENV['PAYJP_PUBLIC_KEY']
    @order_form.errors.add(:base, e.message)
    render :index, status: :unprocessable_entity
  end

  private

  def pay_item
    Payjp.api_key = ENV['PAYJP_SECRET_KEY']
    Payjp::Charge.create(
      amount: @item.price, # 商品の値段
      card: order_form_params[:token], # カードトークン
      currency: 'jpy' # 通貨の種類（日本円）
    )
  end

  def order_form_params
    params.require(:order_form).permit(:postal_code, :prefecture_id, :city, :address, :building_name, :phone_number).merge(
      user_id: current_user.id, item_id: @item.id, token: params[:token]
    )
  end

  def set_item
    @item = Item.find(params[:item_id])
  end

  def redirect_if_ineligible
    return unless current_user.id == @item.user_id || @item.order.present?

    redirect_to root_path
  end
end
