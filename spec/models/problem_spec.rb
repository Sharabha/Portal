require 'spec_helper'
describe Problem do
  before (:each) do
  end

  it{should have_many :guardians}
  it{should have_many :competitions}
  it{should belong_to :author}

end
