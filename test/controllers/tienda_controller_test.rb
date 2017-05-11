require 'test_helper'

class TiendaControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get tienda_index_url
    assert_response :success
  end

  test "should get productos" do
    get tienda_productos_url
    assert_response :success
  end

  test "should get search" do
    get tienda_search_url
    assert_response :success
  end

  test "should get producto" do
    get tienda_producto_url
    assert_response :success
  end

  test "should get carrito" do
    get tienda_carrito_url
    assert_response :success
  end

  test "should get confirmacion_pago" do
    get tienda_confirmacion_pago_url
    assert_response :success
  end

end
