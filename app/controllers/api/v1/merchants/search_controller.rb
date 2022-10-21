class Api::V1::Merchants::SearchController < ApplicationController
  def index
    merchants = Merchant.name_search(params[:name])
    if params[:name] == "" || !params[:name]
      render json: { errors: {details: "Invalid Parameters"}}, status: 400
    elsif merchants == []
      render json: {data: []}, status: 404
    else
      render json: MerchantSerializer.new(Merchant.name_search(params[:name]))
    end
  end
end
