class CommunityRepository
  class << self
    def all
      @items ||= []
    end

    def find(id)
      all.find{|i| i.id == id}
    end

    def create(attrs)
      Community.new(attrs.merge(id: SecureRandom.uuid)).tap do |comm|
	if comm.valid?
	  all<< comm
	end
      end
    end
  end
end
