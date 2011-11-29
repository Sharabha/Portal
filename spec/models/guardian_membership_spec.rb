require 'spec_helper'
describe GuardianMembership do
  it{should belong_to :guardian}
  it{should belong_to :problem_membership}
  it{should validate_presence_of :guardian_id}
  it{should validate_presence_of :problem_membership_id}
end
