class BillsController < ApplicationController

  def index
    @start_at = Date.parse(params[:date] || Time.current.to_s).beginning_of_month
    ended     = @start_at + 1.month

    u      = User.find_by_uuid(@user_uuid)
    @bills = u.bills.where('recorded_at >= ? and recorded_at < ?', @start_at, ended)
  end
end
