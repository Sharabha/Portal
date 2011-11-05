guard 'spork', :rspec_env => { 'RAILS_ENV' => 'test' }, :cucumber => false, :rspec => true, :test_unit => false,  :wait => 60 do
  watch('config/application.rb')
  watch('config/environment.rb')
  watch(%r{^config/environments/.+\.rb$})
  watch(%r{^config/initializers/.+\.rb$})
  watch(%r{^spec/support/.+\.rb$})
  watch('spec/spec_helper.rb')
end


guard 'rspec', :cli => "--color --format nested --fail-fast --drb", :all_on_start => false, :all_after_pass => false do
  #watch('spec/spec_helper.rb')                       { "spec" }
  #watch('config/routes.rb')                          { "spec/routing" }
  watch('app/controllers/application_controller.rb')  { "spec/controllers" }
  watch(%r{^spec/.+_spec\.rb})
  watch(%r{^app/models/(.+)\.rb})                     { |m| "spec/models/#{m[1]}_spec.rb" }
  #watch(%r{^app/(.+)\.rb})                           { |m| "spec/#{m[1]}_spec.rb" }
  #watch(%r{^lib/(.+)\.rb})                           { |m| "spec/lib/#{m[1]}_spec.rb" }
  #watch(%r{^app/controllers/(.+)_(controller)\.rb})  { |m| ["spec/routing/#{m[1]}_routing_spec.rb", "spec/#{m[2]}s/#{m[1]}_#{m[2]}_spec.rb", "spec/acceptance/#{m[1]}_spec.rb"] }
  watch(%r{^app/controllers/(.+)\.rb})  { |m| "spec/controllers/#{m[1]}_spec.rb"}
end
