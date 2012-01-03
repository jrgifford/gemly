require_relative 'main'

def gem_list
  `gem list -a -r`.split("\n")
end

def gemlied(gems)
  gems.map do |gem|
    Gemly.parse gem
  end
end

def json_from(gems)
  gems.map do |gem|
    gem.attributes
  end
end

def save(data)
  open "gems.#{Time.now}.yml", 'w' do |file|
    file.write Yajl::Encoder.encode data
  end
end

json_from gemlied gem_list
