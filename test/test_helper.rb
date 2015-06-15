if ENV['CODECLIMATE_REPO_TOKEN']
  require 'codeclimate-test-reporter'
  CodeClimate::TestReporter.start
end

$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)
require 'query_bundle'
require 'yaml'
require 'minitest/autorun'
require 'minitest/pride'

`psql -c 'create database query_bundle_test;' -U postgres`
db_config = File.expand_path('../support/database.yml', __FILE__)

ActiveRecord::Base.configurations = YAML.load_file(db_config)
ActiveRecord::Base.establish_connection(:postgres)

require 'support/schema'
require 'support/models'
require 'support/fixtures'
