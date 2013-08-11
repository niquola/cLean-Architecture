param :filter,
  options: %w[draft published]

query do |opts|
  arr = Post.all
  filter = opts[:filter] || 'published'
  filter ?  arr.select{|p| p.status == filter} : arr
end
