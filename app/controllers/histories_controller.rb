class HistoriesController < ApplicationController

	# カート画面の購入確定ボタンを押した時のアクション
  def create
    @cart = Cart.find(params[:id])
    @cart_items = @cart.cart_items
    @cart_item_error_status = nil
    @cart_item_error_product = nil
    for cart_item in @cart_items
      @product = cart_item.product
      if @product.stock == 0
        cart_item.destroy
        @cart_item_error_status = "sold_out"
        @cart_item_error_product = cart_item.product.product_name
      elsif @product.stock < cart_item.count
        cart_item.count = @product.stock
        cart_item.save
        @cart_item_error_status = "change_count"
        @cart_item_error_product = cart_item.product.product_name
      end
    end
    if @cart_item_error_status == "sold_out"
      flash[:notice] = @cart_item_error_product + "は、カートに入れている間に売り切れになりました"
      redirect_to cart_path(@cart.id)
    elsif @cart_item_error_status == "change_count"
      flash[:notice] = @cart_item_error_product + "は在庫が不足しているため、購入枚数を変更させていただきました"
      redirect_to cart_path(@cart.id)
    else
      @cart_items.each do |cart_item|
        cart_item.product.stock -= cart_item.count
        cart_item.product.save
      end
      @cart.done = true
      @cart.save
  	  @history = History.create(
  		  cart_id: @cart.id,
        user_id: @cart.user.id,
  	  	name: @cart.destination.name,
  	  	name_kana: @cart.destination.name_kana,
  	  	postal_code: @cart.destination.postal_code,
  	  	address: @cart.destination.address,
  	  	phone_number: @cart.destination.phone_number,
        )
      redirect_to history_path(@history.id)
    end
  end

  def show
    @history = History.find(params[:id])
    @history_cart_items = @history.cart.cart_items.page(params[:page]).per(10)
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
      @histories = @user.histories.page(params[:page]).per(10)
    else
      @histories = History.page(params[:page]).per(10)
    end
  end


  private
  def history_params
    params.require(:history).permit(:shipping_status)
  end
end
