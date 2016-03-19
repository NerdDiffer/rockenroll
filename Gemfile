source 'https://rubygems.org'

gem 'rails', '4.2.5.2'
gem 'pg', '~> 0.18.4'

# front-end
gem 'bourbon', '~> 4.2.6'
gem 'uglifier', '>= 2.7.2'
gem 'coffee-rails', '~> 4.1.1'
gem 'jquery-rails', '~> 4.1.1'
gem 'turbolinks',   '~> 2.5.3'
# See https://github.com/rails/execjs#readme for more supported runtimes
# gem 'therubyracer', platforms: :ruby

# Use pry instead of irb when calling `$ rails console` from command line
gem 'pry-rails', '~> 0.3.4'

group :development, :test do
  gem 'byebug', '~> 8.2.2', require: false
  gem 'codeclimate-test-reporter', '~> 0.4.8', require: nil
end

group :development do
  gem 'web-console', '~> 3.1.1'
  gem 'spring', '~> 1.6.3'
  gem 'faker', '~> 1.6.3', require: false
end

group :test do
  gem 'rspec-rails', '~> 3.4.2'
  gem 'factory_girl_rails', '~> 4.6.0'
end

group :production do
  # serve static assets & produce logs
  # needed b/c Rails plugin system was removed for Rails 4
  gem 'rails_12factor', '~> 0.0.3'

  # puma is better than webrick for handling incoming requests
  gem 'puma', '~> 2.12.3'
end

ruby '2.3.0'
