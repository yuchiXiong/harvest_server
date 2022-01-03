class BillsController < ApplicationController

  def index
    @bills = User.find_by_uuid(@user_uuid).bills.order('recorded_at desc').page(params[:page] || 1)
  end
end
