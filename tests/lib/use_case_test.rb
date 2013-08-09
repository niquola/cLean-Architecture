require_relative '../test_helper'

class MyRepo
  def self.items
    @items ||= []
  end
end

describe 'UseCase' do
  def system
    @system ||=  begin
		   UseCaseReader.new.tap do |sys|
		     sys.read_dir("#{File.dirname(__FILE__)}/use_cases")
		   end
		 end
  end

  it "should read use_case metainfo" do
    use_case_meta = system.use_cases[:test]
    assert { use_case_meta != nil? }

    assert { use_case_meta.respond_to?(:queries) }
    assert { use_case_meta.respond_to?(:commands) }

    assert { use_case_meta.commands.size > 0 }

    invite_cmd = use_case_meta.commands[:create]
    assert { invite_cmd.name == :create }
  end

  it "should execute use case" do
    use_case = system.use_case(:test, 'active_user')

    use_case
    .command(:create, 'item')

    assert {
      use_case
      .query(:list) == ['item']
    }
  end
end
