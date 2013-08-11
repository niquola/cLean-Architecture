class System
  class Action
    attr :context

    def self.param(*args)
      puts "Define param #{args}"
    end

    def self.context(*args, &block)
      self.send(:define_method,:call, &block)
    end

    def self.command(*args, &block)
      self.send(:define_method,:call, &block)
    end

    def self.query(*args, &block)
      self.send(:define_method,:call, &block)
    end


    def initialize(context = nil)
      @context = context
    end

    def call(*args)
      puts "Action not implemented"
    end
  end

  attr :use_cases

  def initialize(path)
    @use_cases = {}
    read_interactions(path)
  end

  def use_case(name, context)
    use_cases[name].create(context)
  end

  class UseCase
    attr :definition
    attr :context

    def initialize(definition, context)
      @definition = definition
      @context = if definition.context
		   definition.context.new.call(context)
		 else
		   context
		 end
    end

    def q(name, params)
      act = definition.queries[name.to_sym]
      raise "No aciton #{name} in #{definition.queries.keys}" unless act
      act.new(context).call(params)
    end

    def c(name, params)
      act = definition.commands[name.to_sym]
      raise "No aciton #{name} in #{definition.commands.keys}" unless act
      act.new(context).call(params)
    end
  end

  class UseCaseDefinition
    attr :name
    attr :commands
    attr :queries

    attr_accessor :context

    def initialize(name)
      @name = name
      @commands = {}
      @queries = {}
    end

    def create(context)
      UseCase.new(self, context)
    end
  end

  def read_interactions(path)
    Dir.chdir path do
      Dir["*"].each do |file|
	read_use_case_dir(file) if File.directory?(file)
      end
    end
  end

  def read_use_case_dir(dir)
    puts "use case #{dir}"
    uc = UseCaseDefinition.new(dir)
    Dir.chdir(dir) do
      Dir["*.rb"].each do |file|
	name = File.basename(file, '.rb')
	case name
	when /_query$/
	  uc.queries[name.gsub('_query','').to_sym] = create_action(file)
	when /_command$/
	  uc.commands[name.gsub('_command','').to_sym] = create_action(file)
	when 'context'
	  uc.context = create_action(file)
	end
      end
    end
    use_cases[dir.to_sym] = uc
  end

  def create_action(file)
    cls = Class.new(Action)
    cls.class_eval(File.read(file), file, 0)
    cls
  end
end
