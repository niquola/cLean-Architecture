module UseCase
  def command(name, &bloc)
    if block_given?
      self.send('define_method', name, &bloc)
    else
      command_class = "#{self.name.gsub(/UseCase$/,'')}#{name.to_s.camelize}Command".constantize
      self.send('define_method',name) do |*args|
        puts  "Command: #{command_class}"
        command_class.new(*args).call
      end
    end
  end

  def query(name, &bloc)
    if block_given?
      self.send('define_method', name, &bloc)
    else
      command_class = "#{self.name.gsub(/UseCase$/,'')}#{name.to_s.camelize}Query".constantize
      self.send('define_method',name) do |*args|
        puts  "Query: #{command_class}"
        command_class.new.call(*args)
      end
    end
  end
end
