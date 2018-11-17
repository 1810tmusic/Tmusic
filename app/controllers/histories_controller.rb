class HistoriesController < ApplicationController

	# カート画面の購入確定ボタンを押した時のアクション
  def create
  	@cart = Cart.find(params[:id])
    # @cart.done = true
    # @cart.update
  	@history = History.create(
  		cart_id: @cart.id,
      user_id: @cart.user.id,
  		name: @cart.destination.name,
  		name_kana: @cart.destination.name_kana,
  		postal_code: @cart.destination.postal_code,
  		address: @cart.destination.address,
  		phone_number: @cart.destination.phone_number,
  		)
  end

  def show
    @history = History.find(params[:id])
    @history_cart_items = @history.cart.cart_items.page(params[:page]).per(1)
  end

  def update
    @history = History.find(params[:id])
    if @history.update(history_params)
      flash[:notice] = "発送状況の変更が反映されました"
      redirect_to history_path(@history.id)
    else
      flash[:notice] = @history.errors.full_messages
      redirect_to history_path(@history.id)
    end
  end

  def index
    if params[:id]
      @user = User.find(params[:id])
      @histories = @user.histories.page(params[:page]).per(1)
    else
      @histories = History.page(params[:page]).per(1)
    end
  end


  private
  def history_params
    params.require(:history).permit(:shipping_status)
  end
end
