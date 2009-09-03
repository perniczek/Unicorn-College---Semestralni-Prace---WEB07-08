require File.dirname(__FILE__) + '/../test_helper'

class AirportsControllerTest < ActionController::TestCase
  def test_should_get_index
    get :index
    assert_response :success
    assert_not_nil assigns(:airport)
  end

  def test_should_get_new
    get :new
    assert_response :success
  end

  def test_should_create_airport
    assert_difference('Airport.count') do
      post :create, :airport => { }
    end

    assert_redirected_to airport_path(assigns(:airport))
  end

  def test_should_show_airport
    get :show, :id => airport(:one).id
    assert_response :success
  end

  def test_should_get_edit
    get :edit, :id => airport(:one).id
    assert_response :success
  end

  def test_should_update_airport
    put :update, :id => airport(:one).id, :airport => { }
    assert_redirected_to airport_path(assigns(:airport))
  end

  def test_should_destroy_airport
    assert_difference('Airport.count', -1) do
      delete :destroy, :id => airport(:one).id
    end

    assert_redirected_to airport_path
  end
end
