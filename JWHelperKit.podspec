#
# Be sure to run `pod lib lint JWHelperKit.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'JWHelperKit'
  s.version          = '0.1.0'
  s.summary          = 'JWHelperKit'
  s.homepage         = 'https://github.com/jw10126121/JWHelperKit'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'jw10126121' => '10126121@qq.com' }
  s.source           = { :git => 'https://github.com/jw10126121/JWHelperKit.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.ios.deployment_target = '9.0'

  #s.source_files = 'JWHelperKit/Classes/**/*'
  #s.dependency 'UINavigationControllerWithCompletionBlock'
  s.default_subspec = 'Base'

  #s.swift_versions = ['4.2', '5.0'] # 同时支持4.2和5.0

  s.subspec 'Base' do |ss|
      ss.source_files  = 'JWHelperKit/Classes/Base/**/*'#, "Sources/Moya/Plugins/"
      ss.framework  = 'UIKit'
      ss.dependency 'UINavigationControllerWithCompletionBlock'
  end
  
  
  
end
