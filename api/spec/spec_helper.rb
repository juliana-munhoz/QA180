require_relative "routes/signup"
require_relative "routes/sessions"
require_relative "routes/equipos"

require_relative "libs/mongo"
require_relative "helpers"

# converter a senha para criptografia md5
require "digest/md5"

def to_md5(pass)
  return Digest::MD5.hexdigest(pass)
end

RSpec.configure do |config|
  config.expect_with :rspec do |expectations|
    expectations.include_chain_clauses_in_custom_matcher_descriptions = true
  end

  config.mock_with :rspec do |mocks|
    mocks.verify_partial_doubles = true
  end

  config.shared_context_metadata_behavior = :apply_to_host_groups

  config.before(:suite) do
    users = [
      { name: "Locatario", email: "locatario@gmail.com", password: to_md5("123") },
      { name: "Locador", email: "locador@gmail.com", password: to_md5("123") },
      { name: "Tom", email: "tom@gmail.com", password: to_md5("123") },
      { name: "Juliana", email: "juliana@gmail.com", password: to_md5("123") },
      { name: "Rosa", email: "rosa@gmail.com", password: to_md5("123") },
      { name: "Maria", email: "maria@gmail.com", password: to_md5("123") },
    ]

    MongoDB.new.drop_danger
    MongoDB.new.insert_users(users)
  end
end
