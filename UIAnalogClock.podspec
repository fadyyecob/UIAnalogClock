#
# Be sure to run `pod lib lint UIAnalogClock.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'UIAnalogClock'
  s.version          = '1.0.0'
  s.summary          = 'A simple view to display an analog time with numbers inside your app.'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
A simple view to display an analog time with numbers inside your app. Either use UIAnalogClock directly in your storyboard or create it in code. 
                       DESC

  s.homepage         = 'https://github.com/fadyyecob/UIAnalogClock'
  s.screenshots     = 'https://github.com/fadyyecob/UIAnalogClock/blob/master/UIAnalogClock/Assets/screenshot.png'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'fadyyecob' => 'fransfadi@hotmail.com' }
  s.source           = { :git => 'https://github.com/fadyyecob/UIAnalogClock.git' , :tag => s.version.to_s}
  s.social_media_url = 'https://twitter.com/fadyyecob'

  s.ios.deployment_target = '8.0'

  s.source_files  = "UIAnalogClock", "UIAnalogClock/**/*.{h,m,swift}"
  
  s.swift_version = '4.2'
  
    s.resource_bundles = {
     'UIAnalogClock' => ['UIAnalogClock/Assets/*.png']
    }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
  # s.dependency 'AFNetworking', '~> 2.3'
end
