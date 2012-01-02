require_relative 'main'

class Gemly < OpenStruct
  APIURL = 'http://rubygems.org/api/v1/gems/'

  def parse(raw)
    gemly = new pull_spec_for raw
    puts "#{gemly.name} was retrieved!"
  end

  def pull_spec_from(raw)
    name = raw.split.first
    begin
      url = APIURL + name + '.json'
      body = Curl::Easy.http_get(json_url).body_str
      @spec = Yajl::Parser.parse body, symbolize_keys: true
    rescue
      pull_spec_from raw
    end
  end

  def attributes
    marshal_dump
  end
end
