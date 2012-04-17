#Contains custom matchers for certain tests

#used in: mychecker_spec.rb

RSpec::Matchers.define :be_json do |attribute|
  match do |response|
	value = response.headers[:content_type]
    value == :json or value == "application/json"
  end
end
