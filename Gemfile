source 'https://rubygems.org'

gemspec

version = ENV['RAILS_VERSION'] || '4.2'

if version == 'master'
  gem 'rack', github: 'rack/rack'
  gem 'arel', github: 'rails/arel'
  gem 'rails', github: 'rails/rails'
  git 'https://github.com/rails/rails.git' do
    gem 'railties'
    gem 'activesupport'
    gem 'activemodel'
    gem 'actionpack'
    gem 'activerecord', group: :test
    gem 'actionview'
  end
else
  gem_version = "~> #{version}.0"
  gem 'rails', gem_version
  gem 'railties', gem_version
  gem 'activesupport', gem_version
  gem 'activemodel', gem_version
  gem 'actionpack', gem_version
  gem 'activerecord', gem_version, group: :test
end

gem 'tzinfo-data'

group :bench do
  gem 'benchmark-ips'
end

group :test do
  if version.start_with? '5'
    gem 'sqlite3', '~> 1.3.6'
  else
    gem 'sqlite3', '~> 1.4'
  end

  gem 'rails-controller-testing'
  gem 'minitest-reporters'

  gem 'simplecov', '~> 0.10', require: false, group: :development
end

group :development, :test do
  gem 'rubocop', '~> 0.34.0', require: false
end
