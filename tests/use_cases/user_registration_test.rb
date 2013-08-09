require_relative "../test_helper"

describe UserRegistrationUseCase do
  include UseCaseTestHelper

  def registration
    @registration ||= UserRegistrationUseCase.new
  end

  def user_administration
    @user_administration ||= UserAdministrationUseCase
    .new('admin')
  end

  def auth
    @auth ||= UserAuthenticationUseCase
    .new('admin')
  end

  c(:register) do
    registration
    .register(login:'oleg@com.com',
	      password: 'pass1',
	      password_confirmation: 'pass1')
  end

  q(:awaiting_confirmation_users) do
    user_administration
    .users(filter: :awaiting_confirmation)
  end

  q(:active_users) do
    user_administration
    .users(filter: :active)
  end

  c(:confirm) do |key|
    registration
    .confirm(key: key)
  end

  q(:confirmation) do
    registration
    .confirmaton_for('oleg@com.com')
  end

  c(:login) do
    auth
    .authenticate(login: 'oleg@com.com',
		      password: 'pass1')
  end

  q(:session) do |session_key|
    auth
    .session(session_key)
  end

  c(:logout) do |session_key|
    auth
    .close_session(session_key)
  end

  it "cases" do
    reg = c(:register)
    assert { reg.ok? == true }

    users = q(:awaiting_confirmation_users)
    assert { users.find{|u| u.login == 'oleg@com.com' } != nil }

    key = q(:confirmation)
    c(:confirm, key)

    session_key = c(:login)
    session = q(:session, session_key)
    assert {  session.identity != nil }
    c(:logout, session_key)

    # assert { q(:session, session_key) == nil }

    users = q(:active_users)
    assert { users.find{|u| u.login == 'oleg@com.com'} != nil }
  end
end
