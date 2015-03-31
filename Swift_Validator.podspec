Pod::Spec.new do |s|
  s.name         = "Swift_Validator"
  s.version      = "2.0.3"
  s.summary      = "A UITextField Validation library for Swift"
  s.homepage     = "https://github.com/jpotts18/swift-validator"
  s.screenshots  = "https://raw.githubusercontent.com/jpotts18/swift-validator/master/swift-validator-v2.gif"
  s.license      = { :type => "Apache 2.0", :file => "LICENCE.txt" }
  s.author             = { "Jeff" => "jeff.potter6@gmail.com" }
  s.social_media_url   = "http://twitter.com/jpotts18"
  s.platform     = :ios
  s.ios.deployment_target	= '8.0'
  s.source       = { :git => "https://github.com/asotog/swift-validator.git", :tag => "2.0.3" }
  s.source_files  = "Validator/*.swift"
  s.frameworks   = ['Foundation', 'UIKit']
  s.requires_arc = true
end
