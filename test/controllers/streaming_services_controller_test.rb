require "test_helper"

class StreamingServicesControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get streaming_services_index_url
    assert_response :success
  end

  test "should get show" do
    get streaming_services_show_url
    assert_response :success
  end

  test "should get spotify_auth" do
    get streaming_services_spotify_auth_url
    assert_response :success
  end

  test "should get spotify_callback" do
    get streaming_services_spotify_callback_url
    assert_response :success
  end

  test "should get connect_spotify" do
    get streaming_services_connect_spotify_url
    assert_response :success
  end
end
