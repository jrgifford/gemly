require_relative 'load'

total_count = @gems.length

dependency_count = @gems.select { |gem|
  development_names = gem.dependencies["development"].map { |dep| dep["name"] }
  runtime_names = gem.dependencies["runtime"].map { |dep| dep["name"] }
  development_names.include?("bundler") or runtime_names.include?("bundler")
}.length

def github_source_links_from(gems)
  puts "Gathering links from Github"
  gems.select(&:source_code_uri).map(&:source_code_uri).select { |repo| repo.include?('github') }
end

def repo_page_with(links)
  grouped_links = [*links.each_slice(10).to_a]
  @pages = []
  grouped_links.each do |group|
    group.map do |link|
      Thread.new do
        page = false
        until page
          begin
            @pages << Curl::Easy.http_get(link).body_str
            page = true
          rescue
            page = false
          end
        end
      end
    end.map(&:join)
  end
  @pages
end


def check_for_bundler_using(pages)
  pages.select do |page|
    page.include?('Gemfile') or page.include?('Gemfile.lock')
  end.length
end

github_count = check_for_bundler_using repo_page_with github_source_links_from @gems

dependency_percentage = (dependency_count.to_f / total_count.to_f * 100).round(2)
github_percentage = (github_count.to_f / total_count.to_f * 100).round(2)

puts <<-DOC
  - #{dependency_percentage}% (#{dependency_count}/#{total_count}) of gems have Bundler as a dependency.
  - #{github_percentage}% (#{github_count}/#{total_count}) of gems have Gemfile or Gemfile.lock in their repository.
DOC
