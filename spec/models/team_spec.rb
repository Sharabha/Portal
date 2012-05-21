require 'spec_helper'

describe Team do

it{should have_one :team_membership}
it{should have_many :user_team_memberships}
it{should have_one :competition}
it{should belong_to :leader}

end
