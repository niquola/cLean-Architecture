query do |filter|
  puts "Filter #{filter}"
  [OpenStruct.new(login: 'oleg@com.com')]
end
