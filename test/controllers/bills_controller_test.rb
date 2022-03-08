# frozen_string_literal: true

require 'test_helper'

class BillsControllerTest < ActionDispatch::IntegrationTest
  # * [GET] /bills.json
  # 拉取用户账目数据
  # 1. 需要登陆
  # 2. 无论有数据与否都应返回一个结构固定的数组
  # 3. 支持按时间拉取每个月的数据
  test 'need login' do
    get bills_url
    assert_response :unauthorized
  end

  test "return user's bills" do
    get bills_url, headers: {
      'access-token': users(:one).jwt,
      'accept': 'application/json'
    }
    assert_response :success
    bills = JSON.parse(@response.body)['data']['bills']
    assert_not_nil bills

    @start_at = Time.current.beginning_of_month
    ended     = @start_at + 1.month
    assert_equal Bill.where('recorded_at >= ? and recorded_at < ?', @start_at, ended).count, bills.size
  end

  test 'return bills by page' do
    test_month = Date.current - rand(0..24).month
    @start_at  = test_month.beginning_of_month
    ended      = @start_at + 1.month

    get bills_url, headers: {
      'access-token': users(:one).jwt,
      'accept': 'application/json'
    }, params:              {
      date: test_month
    }
    bills = JSON.parse(@response.body)['data']['bills']

    assert_response :success

    expected = Bill.where('recorded_at >= ? and recorded_at < ?', @start_at, ended)
    assert_equal bills.size, expected.count
    assert_equal bills.map { |bill| bill['id'] }.sort, expected.ids.sort
  end
end
