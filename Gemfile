source 'https://rubygems.org'

git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?("/")
  "https://github.com/#{repo_name}.git"
end

gem 'rails', '~> 5.1.4'
gem 'pg', '~> 0.21'
gem 'puma', '~> 3.7'
gem 'sass-rails', '~> 5.0'
gem 'uglifier', '>= 1.3.0'
gem 'turbolinks', '~> 5'
gem 'jbuilder', '~> 2.5'
gem 'jquery-rails', '~> 4.3', '>= 4.3.1'
gem 'bcrypt', '~> 3.1.7'
gem 'figaro', '~> 1.1', '>= 1.1.1'
gem 'materialize-sass', '~> 0.96.1'
gem 'material_icons', '~> 2.2'
gem 'webpacker', '~> 3.2'

group :development, :test do
  gem 'byebug', platforms: [:mri, :mingw, :x64_mingw]
  gem 'rspec-rails', '~> 3.7', '>= 3.7.2'
  gem 'factory_bot_rails', '~> 4.8', '>= 4.8.2'
  gem 'faker', '~> 1.8', '>= 1.8.4'
  gem 'spring', '~> 2.0', '>= 2.0.2'
  gem 'spring-commands-rspec', '~> 1.0', '>= 1.0.4'
  gem 'bullet', '~> 5.7'
end

group :development do
  gem 'web-console', '>= 3.3.0'
  gem 'listen', '>= 3.0.5', '< 3.2'
  gem 'spring-watcher-listen', '~> 2.0.0'
  gem 'guard', '~> 2.14', '>= 2.14.1'
  gem 'guard-livereload', '~> 2.5', require: false
  gem 'rack-livereload', '~> 0.3.16'
end

group :test do
  gem 'rails-controller-testing', '~> 1.0', '>= 1.0.2'
  gem 'capybara', '~> 2.13'
  gem 'selenium-webdriver'
  gem 'launchy', '~> 2.4', '>= 2.4.3'
  gem 'database_cleaner', '~> 1.6', '>= 1.6.1'
  gem 'guard-rspec', '~> 4.7', '>= 4.7.3', require: false
  gem 'chromedriver-helper', '~> 1.1'
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]
