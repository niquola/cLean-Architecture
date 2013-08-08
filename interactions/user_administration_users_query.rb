class UserAdministrationUsersQuery
  def initialize(*args)
  end

  def call(filter)
    puts "Filter #{filter}"
    [OpenStruct.new(login: 'oleg@com.com')]
  end
end
