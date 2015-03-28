Pod::Spec.new do |s|
  s.name         = "Swift-Validator"
  s.version      = "2.0.1"
  s.summary      = "A UITextField Validation library for Swift"
  s.homepage     = "https://github.com/jpotts18/swift-validator"
  s.screenshots  = "https://raw.githubusercontent.com/jpotts18/swift-validator/master/swift-validator-v2.gif"
  s.license      = { :type => "Apache 2.0", :file => "LICENCE.txt" }
  s.author             = { "Jeff" => "jeff.potter6@gmail.com" }
  s.social_media_url   = "http://twitter.com/jpotts18"
  s.platform     = :ios
  s.source       = { :git => "https://github.com/jpotts18/swift-validator.git", :tag => "2.0.1" }
  s.source_files  = "Validator/*.swift"
end
