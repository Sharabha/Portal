Factory.define :checker do |t|
  t.association :problem
end

Factory.define :checker_data do |t|
  t.association :checker
  t.sequence(:input)  {|n| "#{n} #{n+1} #{n+2}"}
  t.sequence(:output) {|m| "#{m*7}"}
end
