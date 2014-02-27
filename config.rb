require 'closure-compiler'

###
# Compass
###

# Change Compass configuration
# compass_config do |config|
#   config.output_style = :compact
# end

#Livereload
activate :livereload

###
# Page options, layouts, aliases and proxies
###

# Per-page layout changes:
#
# With no layout
# page "/path/to/file.html", :layout => false
#
# With alternative layout
# page "/path/to/file.html", :layout => :otherlayout
#
# A path which all have the same layout
# with_layout :admin do
#   page "/admin/*"
# end

# Proxy (fake) files
# page "/this-page-has-no-template.html", :proxy => "/template-file.html" do
#   @which_fake_page = "Rendering a fake page with a variable"
# end

###
# Helpers
###

# Automatic image dimensions on image_tag helper
# activate :automatic_image_sizes

# Methods defined in the helpers block are available in templates
# helpers do
#   def some_helper
#     "Helping"
#   end
# end

set :css_dir, 'stylesheets'

set :js_dir, 'javascripts'

set :images_dir, 'images'

# foundation patch per http://wanderwort.de/2013/04/11/using-zurb-foundation-with-middleman/

bourbon_path = Gem::Specification.find_by_name('bourbon').gem_dir
sprockets.append_path File.join(root, 'components')
set :sass_assets_paths, [File.join(root, 'components/foundation/scss'), File.join(bourbon_path, 'app/assets/stylesheets')]

# pretty urls, as directories
activate :directory_indexes

# Build-specific configuration
configure :build do
  ignore 'images/*.psd'
  ignore 'stylesheets/lib/*'
  ignore 'stylesheets/vendor/*'
  ignore 'javascripts/lib/*'
  ignore 'javascripts/vendor/*'

  # For example, change the Compass output style for deployment
  activate :minify_css

  # Minify Javascript on build
  activate :minify_javascript
  
  # uncomment below to activate colosure compiler, causing issues with clearing
  set :js_compressor, ::Closure::Compiler.new

  # Create favicon/touch icon set from source/favicon_base.png
  # activate :favicon_maker
  
  # Enable cache buster
  # activate :cache_buster
  
  activate :asset_hash

  # Use relative URLs
  activate :relative_assets

  # Compress PNGs after build
  # First: gem install middleman-smusher
  # require "middleman-smusher"
  # activate :smusher

  # Or use a different image path
  # set :http_path, "/Content/images/"
end

aws_config = YAML::load(File.open('aws.yml'))

activate :s3_sync do |s3_sync|
  s3_sync.bucket                = aws_config['s3_bucket']
  s3_sync.region                = aws_config['aws_region']
  s3_sync.aws_access_key_id     = aws_config['access_key_id']
  s3_sync.aws_secret_access_key = aws_config['secret_access_key']
  s3_sync.delete                = true
  s3_sync.after_build           = true
end

activate :cloudfront do |cf|
  cf.access_key_id              = aws_config['access_key_id']
  cf.secret_access_key          = aws_config['secret_access_key']
  cf.distribution_id            = aws_config['cloud_front_dist_id']
  # cf.filter                     = /(.html|.xml)/
  cf.after_build                = true
end