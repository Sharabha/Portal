require 'spec_helper'

describe TeamMembership do

it{should have_one :team_membership}
it{should have_many :user_team_memberships}
it{should have_many :competitions}
it{should belong_to :leader}

end
