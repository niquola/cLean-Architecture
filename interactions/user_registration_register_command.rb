class UserRegistrationRegisterCommand
  def initialize(*args)
  end

  def call
    OpenStruct.new(:ok? => true, message: 'Confirmation was sent to')
  end
end
