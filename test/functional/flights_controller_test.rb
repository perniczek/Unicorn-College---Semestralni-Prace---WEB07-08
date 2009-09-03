require File.dirname(__FILE__) + '/../test_helper'

class FlightsControllerTest < ActionController::TestCase
  def test_should_get_index
    get :index
    assert_response :success
    assert_not_nil assigns(:flight)
  end

  def test_should_get_new
    get :new
    assert_response :success
  end

  def test_should_create_flight
    assert_difference('Flight.count') do
      post :create, :flight => { }
    end

    assert_redirected_to flight_path(assigns(:flight))
  end

  def test_should_show_flight
    get :show, :id => flight(:one).id
    assert_response :success
  end

  def test_should_get_edit
    get :edit, :id => flight(:one).id
    assert_response :success
  end

  def test_should_update_flight
    put :update, :id => flight(:one).id, :flight => { }
    assert_redirected_to flight_path(assigns(:flight))
  end

  def test_should_destroy_flight
    assert_difference('Flight.count', -1) do
      delete :destroy, :id => flight(:one).id
    end

    assert_redirected_to flight_path
  end
end
