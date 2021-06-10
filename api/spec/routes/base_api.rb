require "httparty"

class BaseApi
  include HTTParty
  #propriedade do httparty
  base_uri "http://rocklov-api:3333"
end
