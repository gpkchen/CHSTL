#
# Be sure to run `pod lib lint CHSTL.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'CHSTL'
  s.version          = '1.0.4'
  s.summary          = 'C.H.STL'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
  CHejiang Xiao Magua Technology Co., Ltd., IOS public module management platform
                       DESC

  s.homepage         = 'https://github.com/yuanlove/CHSTL.git'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'chenh' => 'shqfch@163.com' }
  s.source           = { :git => 'https://github.com/yuanlove/CHSTL.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'
  s.ios.deployment_target = '8.0'

  s.subspec 'Category' do |category|
      category.source_files = 'Tools/Classes/Category/*.*'
      # category.public_header_files = 'Pod/Classes/NetworkEngine/**/*.h'
      category.dependency 'SDWebImage'
      category.dependency 'GTMBase64'
      category.dependency 'MJRefresh'
      category.dependency 'Masonry'
      category.dependency 'Tools/Macro'
  end

  s.subspec 'Macro' do |macro|
      macro.source_files = 'Tools/Classes/Macro/*.*'
      # category.public_header_files = 'Pod/Classes/NetworkEngine/**/*.h'
  end

  s.subspec 'UI' do |ui|
      ui.source_files = 'Tools/Classes/UI/*.*'
      # category.public_header_files = 'Pod/Classes/NetworkEngine/**/*.h'
      ui.dependency 'FLAnimatedImage'
      ui.dependency 'Masonry'
      ui.dependency 'Tools/Category'
      ui.dependency 'Tools/Macro'
      ui.dependency 'pop'

      ui.resource_bundles = {
        'UI_RES' => ['Tools/Assets/UI/*.*']
      }
  end

  # s.subspec 'Network' do |network|
  #     network.source_files = 'Tools/Classes/Network/*.*'
  #     network.dependency 'MJExtension'
  #     network.dependency 'AFNetworking'
  #     network.dependency 'AliyunOSSiOS', '~> 2.5.4'
  #     network.dependency 'Tools/Category'
  #     network.dependency 'Tools/Macro'
  #     network.dependency 'Tools/UI'
  #     # category.public_header_files = 'Pod/Classes/NetworkEngine/**/*.h'
  # end

  s.subspec 'Base' do |base|
      base.source_files = 'Tools/Classes/Base/*.*'
      base.dependency 'Tools/Category'
      base.dependency 'Tools/Macro'
      base.dependency 'Tools/UI'

      base.resource_bundles = {
        'BASE_RES' => ['Tools/Assets/Base/*.*']
      }
      # category.public_header_files = 'Pod/Classes/NetworkEngine/**/*.h'
  end

  s.subspec 'Utils' do |utils|
      utils.source_files = 'Tools/Classes/Utils/*.*'
      utils.dependency 'Tools/Category'
      utils.dependency 'Tools/Macro'
      # category.public_header_files = 'Pod/Classes/NetworkEngine/**/*.h'
  end

  s.subspec 'Router' do |router|
      router.source_files = 'Tools/Classes/Router/*.*'
      router.dependency 'Tools/Category'
      router.dependency 'Tools/Macro'
      router.dependency 'Tools/UI'
      router.dependency 'Tools/Base'
      # category.public_header_files = 'Pod/Classes/NetworkEngine/**/*.h'
  end

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
end
