#FIXME: refactor it :)
class UseCaseReader
  attr :use_cases

  class Interaction
    attr :name

    def initialize(name, *args, &block)
      @name = name
      @args = args
      @block = block
    end

    def call(*args)
      @block.call(*args)
    end
  end

  class Query < Interaction
  end

  class Command < Interaction
  end

  class UseCaseInstance
    def initialize(use_case)
      @use_case = use_case
    end

    def context(context)
      @context = context
      self
    end

    def command(name, *args)
      log "command: #{@use_case.name}:#{name}"
      commands = @use_case.app.commands.commands
      key = commands.keys.find {|k| k =~ /#{@use_case.name}\/#{name}_command.rb/ }
      commands[key].new.call(*args)
    end

    def query(name, *args)
      log "query: #{@use_case.name}:#{name}"
      queries = @use_case.app.queries.commands
      key = queries.keys.find {|k| k =~ /#{@use_case.name}\/#{name}_query.rb/ }
      queries[key].new.call(*args)
    end

    private

    def log(message)
      puts message
    end
  end

  class BaseCommand
    def self.context(*args)
    end

    def self.command(*args, &block)
      self.send(:define_method,:call, &block)
    end

    def self.query(*args, &block)
      self.send(:define_method,:call, &block)
    end
  end

  class CommandsRegistry
    attr :commands
    def initialize
      @commands = {}
    end

    def add(path)
      cls = Class.new(BaseCommand)
      cls.class_eval(File.read(path), path, 0)
      @commands[path] =  cls
    end
  end

  class UseCase
    attr :name
    attr :commands
    attr :queries
    attr :app

    def initialize(name, content, app)
      @name, @content = name, content
      @app = app

      @commands = {}
      @queries = {}

      instance_eval(content)
    end

    def start(context)
      log "Initializing context for #{@name}"
      UseCaseInstance.new(self).tap do |uc|
	uc.context(context)
      end
    end

    def context(*args)
    end

    def command(name, *args, &block)
      @commands[name.to_sym] = Command.new(name, *args, &block)
    end

    def query(name, *args, &block)
      @queries[name.to_sym] = Query.new(name, *args, &block)
    end

    private

    def log(message)
      puts message
    end
  end

  attr :commands
  attr :queries

  def initialize
    @use_cases = {}
    @commands = CommandsRegistry.new
    @queries = CommandsRegistry.new
  end

  def use_case(name, *context)
    use_cases[name.to_sym].start(*context)
  end

  def add_use_case(name, content)
    @use_cases[name.to_sym] = UseCase.new(name.to_sym, content, self)
  end

  def read_dir(dir_name)
    Dir["#{dir_name}/*_use_case.rb"]
    .each do |cs|
      add_use_case(File.basename(cs,'_use_case.rb'), File.read(cs))
    end

    Dir["#{dir_name}/**/*_command.rb"]
    .each do |cmd|
      @commands.add(cmd)
    end

    Dir["#{dir_name}/**/*_query.rb"]
    .each do |cmd|
      @queries.add(cmd)
    end
  end
end
