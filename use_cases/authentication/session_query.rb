query do |params|
  OpenStruct.new(id: params[:session_id],
	     identity: 'oleg')
end
