# frozen_string_literal: true

require 'test_helper'

class SiteLayoutTest < ActionDispatch::IntegrationTest
  def setup
    @user = users(:spider)
  end

  test 'layout links' do
    get root_path
    assert_template 'static_pages/home'
    assert_select 'a[href=?]', root_path, count: 2
    assert_select 'a[href=?]', help_path
    assert_select 'a[href=?]', about_path
    assert_select 'a[href=?]', contact_path
    assert_select 'a[href=?]', login_path
    assert_select 'a[href=?]', users_path, count: 0
    get signup_path
    assert_select 'title', full_title('Sign up')
  end

  test 'Help link -> /help' do
    get help_path
    assert_template 'static_pages/help'
    assert_select 'a[href=?]', users_path, count: 0

    log_in_as(@user)
    get help_path
    assert_select 'a[href=?]', users_path, count: 1
  end

  test 'About link -> /about' do
    get about_path
    assert_template 'static_pages/about'
    assert_select 'a[href=?]', users_path, count: 0

    log_in_as(@user)
    get about_path
    assert_select 'a[href=?]', users_path, count: 1
  end

  test 'Contact link -> /contact' do
    get contact_path
    assert_template 'static_pages/contact'
    assert_select 'a[href=?]', users_path, count: 0

    log_in_as(@user)
    get contact_path
    assert_select 'a[href=?]', users_path, count: 1
  end

  test 'Log in link -> /login' do
    get login_path
    assert_template 'sessions/new'
    assert_select 'a[href=?]', users_path, count: 0
  end

  test "not logged in user should't see Users link" do
    get root_path
    assert_template 'static_pages/home'
    assert_select 'a[href=?]', users_path, count: 0
  end

  test 'logged in user should see Users link' do
    log_in_as(@user)
    get root_path
    assert_template 'static_pages/home'
    assert_select 'a[href=?]', users_path, count: 1
  end
end
