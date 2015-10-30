class ItemsController < ApplicationController
  before_action :find_list
  def index
    @list = List.find(params[:list_id])
  end

  def new
    @item = @list.items.new
  end

  def create
    @item = @list.items.new(item_params)
    if @item.save
      flash[:success] = "Added item"
      redirect_to list_items_path
    else
      flash[:error] = "There was a problem adding that item"
      render action: :new
    end
  end

  def edit
    @item = @list.items.find(params[:id])
  end

  def update
    @item = @list.items.find(params[:id])
    if @item.update_attributes(item_params)
      flash[:success] = "Saved item."
      redirect_to list_items_path
    else
      flash[:error] = "That item could not be saved."
      render action: :edit
    end
  end

  def destroy
    @item = @list.items.find(params[:id])
    if @item.destroy
      flash[:sucess] = "Item was deleted."
    else
      flash[:error] = "Item could not be deleted"
    end
    redirect_to list_items_path
  end

  def complete
      @item = @list.items.find(params[:id])
      @item.update_attribute(:completed_at, Time.now)
      redirect_to list_items_path, notice: "Item marked as complete."
  end

  def url_options
    { list_id: params[:list_id] }.merge(super)
  end

  private
  def find_list
    @list = List.find(params[:list_id])
  end

  private
  def item_params
    params[:item].permit(:content)
  end

end
