require 'spec_helper'

describe UserTeamMembership do

it{should belong_to :user}
it{should belong_to :team}

end
