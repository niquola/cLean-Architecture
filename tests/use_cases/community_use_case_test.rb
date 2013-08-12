require_relative "../test_helper"

describe 'cross testing' do

  def system
    @system ||= System
    .new("#{File.dirname(__FILE__)}/../../use_cases")
  end

  def uc
    system.use_case(:community, user_identity: 'niquola')
  end

  it "crud" do
    assert {
      uc.q(:list, filter: 'all') == []
    }

    community = uc.c(:create,
	 title: 'SPRUG',
	 location: 'leningrad',
	 technologies: ['ruby', 'ruby on rails'])

    assert {
      uc
      .q(:list, filter: 'all')
      .find{|c| c.title == 'SPRUG'} != nil
    }

    sprug = uc.find(community.id)

    assert {
      sprug != nil
      sprug.title == 'SPRUG'
      owner = sprug.members.first
      owner.role == :owner
      owner.name == 'nicola'
    }
  end
end
