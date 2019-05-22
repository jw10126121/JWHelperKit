#
# Be sure to run `pod lib lint JWHelperKit.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#
Pod::Spec.new do |s|
    s.name         = 'JWHelperKit'
    s.version      = '1.0.7'
    s.summary      = 'JWHelperKit: Swift拓展'
    s.homepage     = 'https://github.com/jw10126121/JWHelperKit'
    s.license      = { :type => 'MIT', :file => 'LICENSE' }
    s.author             = { 'jw10126121' => '10126121@qq.com' }
    s.ios.deployment_target = '9.0'
    s.source       = { :git => 'https://github.com/jw10126121/JWHelperKit.git', :tag => s.version }
    #s.default_subspec = 'Base' #不能设置default_subspec,否则subspec不生效
    s.swift_version = '5.0'

    s.subspec 'Base' do |base|
        base.source_files  = 'JWHelperKit/Classes/Base/', 'JWHelperKit/Classes/Base/Other/', 'JWHelperKit/Classes/Base/UIHelper/'
        base.framework  = 'UIKit'
    end
    
    s.subspec 'Navigation' do |navigation|
        navigation.source_files = 'JWHelperKit/Classes/Navigation/**/*'
        navigation.dependency 'JWHelperKit/Base'
        navigation.dependency 'UINavigationControllerWithCompletionBlock'
    end
    
end
