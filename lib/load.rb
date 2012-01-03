require_relative 'main'

@gems = Yajl::Parser.parse(File.read 'gems.yml').map { |gem| Gemly.new gem }

#<Gemly
#   name="zzzzzz",
#   downloads=340,
#   version="0.0.3",
#   version_downloads=142,
#   authors="Michael Noack",
#   info="Used to test various rubygems handlers such as does it use push date, gemspec date, etc.",
#   project_uri="http://rubygems.org/gems/zzzzzz",
#   gem_uri="http://rubygems.org/gems/zzzzzz-0.0.3.gem",
#   homepage_uri="",
#   wiki_uri=nil,
#   documentation_uri=nil,
#   mailing_list_uri=nil,
#   source_code_uri=nil,
#   bug_tracker_uri=nil,
#   dependencies={"development"=>[], "runtime"=>[]}
# >
