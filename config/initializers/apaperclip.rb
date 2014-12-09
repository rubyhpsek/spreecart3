Paperclip.interpolates(:s3_eu_url) { |attachment, style|
  "#{attachment.s3_protocol}://s3-eu-west-1.amazonaws.com/#{attachment.bucket_name}/#{attachment.path(style).gsub(%r{^/}, "")}"


}

# config/initializers/paperclip.rb
Paperclip::Attachment.default_options[:s3_host_name] = 's3-eu-west-1.amazonaws.com'


