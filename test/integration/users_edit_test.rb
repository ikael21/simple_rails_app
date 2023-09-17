# frozen_string_literal: true

require 'test_helper'

class UsersEditTest < ActionDispatch::IntegrationTest
  def setup
    @user = users(:spider)
  end

  # unsuccessful edits

  test 'unsuccessful edit with invalid name' do
    log_in_as(@user)
    get edit_user_path(@user)
    assert_template 'users/edit'

    patch user_path(@user), params: {
      user: {
        name: '', email: 'foo@example.com',
        password: 'password', password_confirmation: 'password'
      }
    }
    assert_template 'users/edit'
    assert_select 'div.alert', 'The form contains 1 error.'
  end

  test 'unsuccessful edit with invalid email' do
    log_in_as(@user)
    get edit_user_path(@user)
    assert_template 'users/edit'

    patch user_path(@user), params: {
      user: {
        name: 'Name', email: 'foo@invalid',
        password: 'password', password_confirmation: 'password'
      }
    }
    assert_template 'users/edit'
    assert_select 'div.alert', 'The form contains 1 error.'
  end

  test 'unsuccessful edit with invalid password' do
    log_in_as(@user)
    get edit_user_path(@user)
    assert_template 'users/edit'

    patch user_path(@user), params: {
      user: {
        name: 'Name', email: 'foo@example.com',
        password: 'asd', password_confirmation: 'asd'
      }
    }
    assert_template 'users/edit'
    assert_select 'div.alert', 'The form contains 1 error.'
  end

  # successful edits

  test 'successful edit with friendly forwarding' do
    get edit_user_path(@user)
    log_in_as(@user)
    assert_redirected_to edit_user_url(@user)

    name = 'Foo Bar'
    email = 'foo@bar.com'
    patch user_path(@user), params: {
      user: { name: name, email: email, password: '', password_confirmation: '' }
    }
    assert_not flash.empty?
    assert_redirected_to @user

    @user.reload
    assert_equal name, @user.name
    assert_equal email, @user.email
  end

  test 'friendly forwarding should work only once' do
    get edit_user_path(@user)
    log_in_as(@user)
    assert_redirected_to edit_user_url(@user)
    # simulate second login
    log_in_as(@user)
    assert_redirected_to @user
  end
end
