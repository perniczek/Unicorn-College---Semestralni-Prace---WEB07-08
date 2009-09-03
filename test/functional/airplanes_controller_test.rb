require File.dirname(__FILE__) + '/../test_helper'

class AirplanesControllerTest < ActionController::TestCase
  def test_should_get_index
    get :index
    assert_response :success
    assert_not_nil assigns(:airplane)
  end

  def test_should_get_new
    get :new
    assert_response :success
  end

  def test_should_create_airplane
    assert_difference('Airplane.count') do
      post :create, :airplane => { }
    end

    assert_redirected_to airplane_path(assigns(:airplane))
  end

  def test_should_show_airplane
    get :show, :id => airplane(:one).id
    assert_response :success
  end

  def test_should_get_edit
    get :edit, :id => airplane(:one).id
    assert_response :success
  end

  def test_should_update_airplane
    put :update, :id => airplane(:one).id, :airplane => { }
    assert_redirected_to airplane_path(assigns(:airplane))
  end

  def test_should_destroy_airplane
    assert_difference('Airplane.count', -1) do
      delete :destroy, :id => airplane(:one).id
    end

    assert_redirected_to airplane_path
  end
end
