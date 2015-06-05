require 'database_cleaner'

RSpec.configure do |config|
 DatabaseCleaner.orm = "mongoid"
 DatabaseCleaner.strategy = :truncation

 config.before(:each) do
   DatabaseCleaner.start
   DatabaseCleaner.clean
 end
end
