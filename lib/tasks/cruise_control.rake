desc 'Custom curise task for RSpec'
task :cruise do
      CruiseControl::invoke_rake_task 'db:migrate'
      CruiseControl::invoke_rake_task 'spec'
end
