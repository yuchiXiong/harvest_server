class BillsController < ApplicationController
  def index
    @start_at = Date.parse(params[:date] || Time.current.to_s).beginning_of_month
    ended     = @start_at + 1.month

    u      = User.find_by_uuid(@user_uuid)
    @bills = u.bills.where('recorded_at >= ? and recorded_at < ?', @start_at, ended)
  end

  def create
    u = User.find_by_uuid(@user_uuid)
    b = u.bills.create(bill_params(params))

    render json: b
  end

  def bill_params(params)
    params.require(:bill).permit(:recorded_at, :in_or_out, :category, :amount, :description)
  end
end
