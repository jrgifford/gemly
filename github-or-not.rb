require_relative 'load'

total_count = @gems.length

github_count = @gems.select(&:source_code_uri).select do |gem|
  gem.source_code_uri.include?("github")
end.length

maybe_github_count = @gems.reject(&:source_code_uri).select do |gem|
  [gem.homepage_uri,
    gem.wiki_uri,
    gem.documentation_uri,
    gem.bug_tracker_uri,
    gem.projet_uri].compact.any? { |uri| uri.include?('github') }
end.length

no_repository_count = @gems.reject(&:source_code_uri).count

github_percentage = (github_count.to_f / total_count.to_f * 100).round(2)
maybe_percentage = (maybe_github_count / total_count.to_f * 100).round(2)
no_repo_percentage = (no_repository_count / total_count.to_f * 100).round(2)

puts <<-DOC
  - #{github_percentage}% (#{github_count}/#{total_count}) of gems have repositories at Github, based on their Source Code URI.
  - #{maybe_percentage} (#{maybe_github_count}/#{total_count}) gems might have repositories at Github, based on multiple given URIs.
  - #{no_repo_percentage} (#{no_repository_count}/#{total_count}) of gems have no listed repository.
DOC
