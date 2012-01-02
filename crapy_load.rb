require_relative 'main'

gem_list = Yajl::Encoder.encode File.read('../gems.yml').split("\n").map { |gem|
  Yajl::Parser.parse gem, symbolize_keys: true
}.map { |gem|
  Gemly.new gem[:spec]
}.map { |gem|
  gem.attributes
}

open 'gems.yml', 'w' do |file|
  file.write gem_list
end
