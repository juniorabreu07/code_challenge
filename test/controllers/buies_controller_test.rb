require "test_helper"

class BuiesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @buy = buies(:one)
  end

  test "should get index" do
    get buies_url, as: :json
    assert_response :success
  end

  test "should create buy" do
    assert_difference("Buy.count") do
      post buies_url, params: { buy: { product_id: @buy.product_id } }, as: :json
    end

    assert_response :created
  end

  test "should show buy" do
    get buy_url(@buy), as: :json
    assert_response :success
  end

  test "should update buy" do
    patch buy_url(@buy), params: { buy: { product_id: @buy.product_id } }, as: :json
    assert_response :success
  end

  test "should destroy buy" do
    assert_difference("Buy.count", -1) do
      delete buy_url(@buy), as: :json
    end

    assert_response :no_content
  end
end
