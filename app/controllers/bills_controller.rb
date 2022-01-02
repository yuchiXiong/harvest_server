class BillsController < ApplicationController
  def index
    render_json_success(Bill.all)
  end
end
