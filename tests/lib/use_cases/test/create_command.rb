context do |*args|
  puts "My context"
end

command do |item|
  MyRepo.items<< item
end
