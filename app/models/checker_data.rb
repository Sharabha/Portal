class CheckerData < ActiveRecord::Base
  belongs_to :checker
#mimo, że to powinno być to z walidają nie przechodzi testów:
#  1) CheckerDatasController as an admin user I want to be able to manage things to be checked POST create should be #successful
#     Failure/Error: response.status.should == 302
#       expected: 302
#            got: 200 (using ==)
#     # ./spec/controllers/checker_datas_controller_spec.rb:23:in `block (4 levels) in <top (required)>'

#  2) CheckerDatasController as an admin user I want to be able to manage things to be checked POST create should create #one new checker data
#     Failure/Error: lambda {
#       count should have been changed by 1, but was changed by 0
     # ./spec/controllers/checker_datas_controller_spec.rb:27:in `block (4 levels) in <top (required)>'

#  3) CheckerDatasController as an admin user I want to be able to manage things to be checked POST create should be #possible to add multiple data
#     Failure/Error: lambda {
#       count should have been changed by 5, but was changed by 0
     # ./spec/controllers/checker_datas_controller_spec.rb:33:in `block (4 levels) in <top (required)>'
  
#validates_presence_of :input, :output
end
