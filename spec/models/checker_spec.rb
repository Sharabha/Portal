require 'spec_helper'

describe Checker do
  it {should belong_to :problem}
  it {should have_many :checker_datas}

  
end
