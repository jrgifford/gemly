require 'adapter/memory'

module Gemly
  class RubyGem
    include Toy::Store
    APIURL = 'http://rubygems.org/api/v1/gems/'

    store :memory, {}

    index :name

    attribute :name, String
    attribute :authors, Array
    attribute :info, String

    attribute :downloads, Integer
    attribute :version, String
    attribute :vdownloads, Integer

    attribute :project, String
    attribute :homepage, String
    attribute :documentation, String
    attribute :mailing, String
    attribute :repository, String
    attribute :issues, String
    attribute :dependencies, String

    # def parse(raw)
    #   gemly = new pull_spec_for raw
    #   puts "#{gemly.name} was retrieved!"
    # end

    # def pull_spec_from(raw)
    #   name = raw.split.first
    #   begin
    #     url = APIURL + name + '.json'
    #     body = Curl::Easy.http_get(json_url).body_str
    #     @spec = Yajl::Parser.parse body, symbolize_keys: true
    #   rescue
    #     pull_spec_from raw
    #   end
    # end

    # def attributes
    #   marshal_dump
    # end
  end
end



