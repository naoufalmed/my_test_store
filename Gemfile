source 'https://rubygems.org'

gem 'rails', '3.2.14'

gem 'pg'


# Gems used only for assets and not required
# in production environments by default.
group :assets do
  gem 'sass-rails',   '~> 3.2.3'
  gem 'coffee-rails', '~> 3.2.1'
  gem 'uglifier', '>= 1.0.3'
end

gem 'jquery-rails'

group :development do
  gem 'better_errors'
end

gem 'nokogiri', '1.5.10'

group :development, :test do
  gem 'rspec-rails', '~> 2.14.0'
  gem 'factory_girl_rails', '~> 4.2.1'
  gem 'guard', '>=2.1.0'
  gem 'guard-rspec', require: false  
end

group :test do
  # gem 'faker'
  gem 'capybara', '~> 2.1'
  gem 'database_cleaner', '~> 1.0.1'
  gem 'email_spec', '1.4.0'
  gem 'launchy'
  gem 'selenium-webdriver', '~> 2.33'
  gem 'timecop'
  gem 'webmock', '1.8.11'
end


# == Spree gems
gem 'spree', github: 'spree/spree', tag: 'v2.0.5'
gem 'spree_auth_devise', github: 'spree/spree_auth_devise', branch: '2-0-stable'

gem "spree_product_assembly", github: "spree/spree-product-assembly", branch: "2-0-stable"
gem 'spree_i18n', :git => 'git://github.com/spree/spree_i18n.git', :branch => '2-0-stable'
gem 'spree_static_content', :github => 'spree/spree_static_content', :branch => '2-0-stable'

