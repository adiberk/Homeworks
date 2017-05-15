require 'test_helper'

class SubjectsControllerTest < ActionDispatch::IntegrationTest
  def setup
    @user = users(:michael)
  end
  test "should get show" do
 	get login_path
 	post login_path, params: { session: { email:    @user.email,
 	                                      password: 'password' } }
 	assert_redirected_to @user
 	follow_redirect!
    get subjects_path
    assert_response :success
  end

end
