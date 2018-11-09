#
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#
Pod::Spec.new do |s|
  s.name             = 'flutter_libphonenumber'
  s.version          = '0.0.1'
  s.summary          = 'Flutter plugin wrapper to Google&#x27;s libphonenumber'
  s.description      = <<-DESC
Flutter plugin wrapper to Google&#x27;s libphonenumber
                       DESC
  s.homepage         = 'http://example.com'
  s.license          = { :file => '../LICENSE' }
  s.author           = { 'Your Company' => 'email@example.com' }
  s.source           = { :path => '.' }
  s.source_files = 'Classes/**/*'
  s.public_header_files = 'Classes/**/*.h'
  s.dependency 'Flutter'
  
  s.dependency 'PhoneNumberKit', '~> 2.5'

  s.ios.deployment_target = '9.0'
end

