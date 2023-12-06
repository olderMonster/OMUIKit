#
# Be sure to run `pod lib lint OMUIKit.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'OMUIKit'
  s.version          = '0.1.0'
  s.summary          = 'A short description of OMUIKit.'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
TODO: Add long description of the pod here.
                       DESC

  s.homepage         = 'https://github.com/olderMonster/OMUIKit'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'olderMonster' => '406416312@qq.com' }
  s.source           = { :git => 'https://github.com/olderMonster/OMUIKit.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.ios.deployment_target = '9.0'

  s.source_files = 'OMUIKit/Classes/**/*'
  
  s.subspec 'Core' do |ss|
    ss.source_files = 'OMUIKit/Classes/BaseViewController/**/*'
    ss.dependency 'KMNavigationBarTransition'
  end
  
  s.subspec 'Web' do |ss|
    ss.source_files = 'OMUIKit/Classes/BaseWebViewController/**/*'
    ss.dependency 'OMUIKit/Core'
    ss.dependency 'WKWebViewJavascriptBridge'
  end
  
  s.subspec 'Adaptor' do |ss|
    ss.source_files = 'OMUIKit/Classes/ScreenAdaptor/**/*'
  end
  
  # s.resource_bundles = {
  #   'OMUIKit' => ['OMUIKit/Assets/*.png']
  # }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
#   s.dependency 'AFNetworking'
end
