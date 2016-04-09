require 'test_helper'

class EventUsersControllerTest < ActionController::TestCase
  setup do
    @event_user = event_users(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:event_users)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create event_user" do
    assert_difference('EventUser.count') do
      post :create, event_user: { event_id: @event_user.event_id, user_id: @event_user.user_id }
    end

    assert_redirected_to event_user_path(assigns(:event_user))
  end

  test "should show event_user" do
    get :show, id: @event_user
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @event_user
    assert_response :success
  end

  test "should update event_user" do
    patch :update, id: @event_user, event_user: { event_id: @event_user.event_id, user_id: @event_user.user_id }
    assert_redirected_to event_user_path(assigns(:event_user))
  end

  test "should destroy event_user" do
    assert_difference('EventUser.count', -1) do
      delete :destroy, id: @event_user
    end

    assert_redirected_to event_users_path
  end
end
