class BillsController < ApplicationController
  before_action :authenticate_user!

  def index
    u = User.find_by_uuid(@user_uuid)
    render_json_success(u.bills)
  end
end
