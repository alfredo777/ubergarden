require 'test_helper'

class CustomersControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get customers_index_url
    assert_response :success
  end

  test "should get orders" do
    get customers_orders_url
    assert_response :success
  end

  test "should get order" do
    get customers_order_url
    assert_response :success
  end

  test "should get acount_information" do
    get customers_acount_information_url
    assert_response :success
  end

  test "should get shipments" do
    get customers_shipments_url
    assert_response :success
  end

  test "should get shipment" do
    get customers_shipment_url
    assert_response :success
  end

end
