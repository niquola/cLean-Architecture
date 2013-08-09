context do |*args|
  puts "My context"
end

query do |*args|
  helper()
end

def helper
  MyRepo.items
end
