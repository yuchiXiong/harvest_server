require 'test_helper'

class BillsControllerTest < ActionDispatch::IntegrationTest

  # * [GET] /bills.json
  # 拉取用户账目数据
  # 1. 需要登陆
  # 2. 无论有数据与否都应返回一个结构固定的数组
  # 3. 支持分页拉取
  test "need login" do
    get bills_url
    assert_response :unauthorized
  end

  test "return user's bills" do
    get bills_url, headers: {
        'access-token': users(:one).jwt,
        'accept':       'application/json'
    }
    assert_response :success
    bills = JSON.parse(@response.body)['data']['bills']
    assert_not_nil bills
    assert_equal 100, bills.size
  end

  test "return bills by page" do
    bills = []
    (1..12).each do |page|
      get bills_url, headers: {
          'access-token': users(:one).jwt,
          'accept':       'application/json'
      }, params:              {
          page: page
      }
      bills << JSON.parse(@response.body)['data']['bills']
    end

    assert_response :success
    bills.flatten!
    assert_equal bills.size, Bill.count
    assert_equal bills.map { |bill| bill['id'] }.sort, Bill.ids.sort
  end

end
