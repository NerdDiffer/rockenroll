source 'https://rubygems.org'

gem 'rails', '4.2.5.2'
gem 'pg', '~> 0.18.4'

# front-end
gem 'bourbon', '5.0.0.beta.5'
gem 'neat', '~> 1.7.4'
gem 'uglifier', '>= 2.7.2'
gem 'coffee-rails', '~> 4.1.1'
gem 'jquery-rails', '~> 4.1.1'
gem 'sass-rails', '~> 5.0.4'
gem 'turbolinks',   '~> 2.5.3'
gem 'draper', '~> 2.1.0'
gem 'font-awesome-rails', '~> 4.6'

# See https://github.com/rails/execjs#readme for more supported runtimes
# gem 'therubyracer', platforms: :ruby

# Use pry instead of irb when calling `$ rails console` from command line
gem 'pry-rails', '~> 0.3.4'
# Time of day: https://github.com/jackc/tod
gem 'tod', '~> 2.0.2'

group :development, :test do
  gem 'byebug', '~> 8.2.2', require: false
  gem 'codeclimate-test-reporter', '~> 0.4.8', require: nil
end

group :development, :production do
  gem 'faker', '~> 1.6.3', require: false
end

group :development do
  gem 'web-console', '~> 3.1.1'
  gem 'spring', '~> 1.6.3'
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
