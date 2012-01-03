require_relative 'load'

total_count = @gems.length

strict_semantic = @gems.select(&:version).select do |gem|
  true if gem.version =~ /^\d+\.\d+\.\d+$/
end.length

maybe_semantic = @gems.select(&:version).select do |gem|
  true if gem.version.include?('.') and not gem.version =~ /^\d+\.\d+\.\d+$/
end.length

below_zero_five = @gems.select(&:version).select do |gem|
  true if gem.version =~ /^0\.[0-4].\d+$/
end.length

below_zero_one = @gems.select(&:version).select do |gem|
  true if gem.version =~ /^0\.0.\d+$/
end.length

strict_percentage = ( strict_semantic.to_f / total_count.to_f * 100).round(2)
maybe_percentage = ( maybe_semantic.to_f / total_count.to_f * 100).round(2)
zero_five_percentage = ( below_zero_five.to_f / total_count.to_f * 100).round(2)
zero_one_percentage = ( below_zero_one.to_f / total_count.to_f * 100).round(2)

puts <<-DOC
  - #{strict_percentage}% (#{strict_semantic}/#{total_count}) of gems use semantic versioning.
  - #{maybe_percentage}% (#{maybe_semantic}/#{total_count}) of other gems might use semantic versioning.
  - #{zero_five_percentage}% (#{below_zero_five}/#{total_count}) of gems that use semver are below 0.5.0.
  - #{zero_one_percentage}% (#{below_zero_one}/#{total_count}) of gems that use semver are below 0.1.0.
DOC
