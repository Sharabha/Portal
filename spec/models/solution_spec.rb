require 'spec_helper'

describe Solution do
  it {should belong_to :problem_membership}
  it {should belong_to :team_membership}

  it {should validate_presence_of :problem_membership_id}
  it {should validate_presence_of :team_membership_id}

  it { should have_attached_file(:code) }
end
