require_relative "../test_helper"

describe 'cross testing' do

  def system
    @system ||= System
    .new("#{File.dirname(__FILE__)}/../../use_cases")
  end

  def registration
    @registration ||= system
    .use_case(:registration,
	      user_identity: 'niquola')
  end

  def user_administration
    @user_administration ||= system
    .use_case(:user_administration,
	      user_identity: 'niquola')
  end

  def auth
    @auth ||= system
    .use_case(:authentication,
	      user_identity: 'niquola')
  end


  it "cases" do
    reg = registration.c(:register,
		   login:'oleg@com.com',
		   password: 'pass1',
		   password_confirmation: 'pass1')

    assert { reg.ok? == true }

    users =  user_administration.q(:list, filter: 'awaiting_confirmation')

    assert { users.find{|u| u.login == 'oleg@com.com' } != nil }

    key = registration.q(:confirmation_for, user_identity: 'oleg@com.com')
    registration.c(:confirm, key: key)

    session_key = auth.c(:login, login: 'oleg@com.com', password: 'pass1')

    session = auth.q(:session, session_key: session_key)
    assert {  session.identity != nil }
    auth.c(:logout, sesession_key: session_key)

    # assert { q(:session, session_key) == nil }

    users =  user_administration.q(:list, filter: 'active')
    assert { users.find{|u| u.login == 'oleg@com.com'} != nil }
  end
end
