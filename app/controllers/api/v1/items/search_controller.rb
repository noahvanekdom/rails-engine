class Api::V1::Items::SearchController < ApplicationController
  def show
    if search_name?
      item = Item.name_search(params[:name], 1).first
      if item == nil
        render json: {data: {}} #ItemSerializer.new(item)
      elsif item != nil
        render json: ItemSerializer.new(item)
      end
    elsif search_price?
      render json: ItemSerializer.new(Item.price_search(params[:min_price], params[:max_price], 1))
    else
      render json: {
        message: "your query could not be completed",
        error: "bad inputs", id: nil, attributes: [] }, status: 400
    end
  end


  private

  def search_name?
    params[:name] && !params[:min_price] && !params[:max_price] && !params[:name].empty?
  end

  def search_price?
    min = params[:min_price]
    max = params[:max_price]
    if min && max && !params[:name]
      max.to_f >= min.to_f && min.to_f >= 0 && !min.empty
    else
    end
  end
end



