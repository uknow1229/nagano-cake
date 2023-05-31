class Admin::ItemsController < ApplicationController
  def index
    @items = Item.page(params[:page])
  end

  def new
    @item = Item.new
    @genres = Genre.all
    @genre = Genre.new
  end
  
  def create
    @item = Item.new(item_params)
    if @item.save
      redirect_to admin_item_path(@item.id),notice: "商品の登録が完了しました"
    else
      @genres = Genre.all
      render :new
    end
  end

  def show
    @item = Item.find(params[:id])
  end

  def edit
    @item = Item.find(params[:id])
    @genres = Genre.all
  end
  
  def update
    @item = Item.find(params[:id])
    if @item.update(item_params)
      redirect_to admin_item_path(@item.id), notice: "商品情報が更新されました"
    else
      @genres = Genre.all
      render :edit
    end
  end
  
  private
  
  def item_params
    params.require(:item).permit(:image,:genre_id,:name,:description,
                                 :price_without_tax,:is_on_sale)
  end
  
end
