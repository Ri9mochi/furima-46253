class OrdersController < ApplicationController
  before_action :authenticate_user!
  before_action :set_item, only: [:index, :create]
  before_action :redirect_if_ineligible, only: [:index, :create]

  def index
    @order_form = OrderForm.new
  end

  def create
    @order_form = OrderForm.new(order_form_params)
    if @order_form.valid?
      @order_form.save
      redirect_to root_path
    else
      render :index, status: :unprocessable_entity
    end
  end

  private

  def order_form_params
    params.require(:order_form).permit(:postal_code, :prefecture_id, :city, :address, :building_name, :phone_number).merge(
      user_id: current_user.id, item_id: @item.id, token: params[:token]
    )
  end

  def set_item
    @item = Item.find(params[:item_id])
  end

  def redirect_if_ineligible
    redirect_to root_path if current_user.id == @item.user_id && @item.order.present?
  end
end
