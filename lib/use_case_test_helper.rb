module UseCaseTestHelper
  def self.included(base)
    base.send(:extend, ClassMethods)
    super
  end

  module ClassMethods
    def c(name, &block)
      define_method "#{name}_command", &block
    end

    def q(name, &block)
      define_method "#{name}_query", &block
    end
  end

  def c(name, *args)
    self.send("#{name}_command",*args)
  end

  def q(name, *args)
    self.send("#{name}_query",*args)
  end
end
