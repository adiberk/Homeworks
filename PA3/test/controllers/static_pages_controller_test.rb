require 'test_helper'

class StaticPagesControllerTest < ActionDispatch::IntegrationTest
  def setup
    @user = users(:michael)
  end
  test "should get root" do
    get root_url
    assert_response :success
  end
  # test "should get home" do
  #   get static_pages_home_url
  #   assert_response :success
  # end

  test "should get subjects" do
    get login_path
    post login_path, params: { session: { email:    @user.email,
                                          password: 'password' } }
    assert_redirected_to @user
    follow_redirect!
    get subjects_path
    assert_response :success
  end

  test "should get courses" do
    get login_path
    post login_path, params: { session: { email:    @user.email,
                                          password: 'password' } }
    assert_redirected_to @user
    follow_redirect!
    get courses_path
    assert_response :success
  end

  test "should get instructors" do
    get login_path
    post login_path, params: { session: { email:    @user.email,
                                          password: 'password' } }
    assert_redirected_to @user
    follow_redirect!
    get instructors_path
    assert_response :success
  end

end
