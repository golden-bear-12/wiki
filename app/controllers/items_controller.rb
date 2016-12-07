class ItemsController < ApplicationController
  def index
    @items = Item.all
  end

  def show
    @item = Item.find(params[:id])
  end

  def new
    @item = Item.new
  end

  def create
    @item = current_user.items.new(item_params)

    if @item.save
      flash[:notice] = "Wiki was saved successfully."
      redirect_to @item
    else
      flash.now[:alert] = "There was an error saving the item. Please try again."
      render :new
    end
  end

  def edit
    @item = Item.find(params[:id])
    authorize @item
  end

  def update
    @item = Item.find(params[:id])
    authorize @item
    if @item.update_attributes(item_params)
     flash[:notice] = "Wiki was updated successfully."
      redirect_to @item
    else
     flash.now[:alert] = "There was an error saving the item. Please try again."
     render :edit
    end
  end

  def destroy
    @item = Item.find(params[:id])
    authorize @item
    if @item.destroy
      flash[:notice] = "\"#{@item.title}\" was deleted successfully."
      redirect_to items_path
    else
      flash.now[:alert] = "There was an error deleting the item."
      render :show
    end
   end

   private
   def item_params
    params.require(:item).permit(:title, :body)
   end

end
