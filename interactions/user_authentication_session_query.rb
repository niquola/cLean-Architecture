class UserAuthenticationSessionQuery
  def initialize(*args)
  end

  def call(filter)
    OpenStruct.new(identity: 'oleg@com.com')
  end
end
