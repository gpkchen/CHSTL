#
# Be sure to run `pod lib lint CHSTL.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'CHSTL'
  s.version          = '1.0.2'
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
      category.source_files = 'CHSTL/Classes/Category/*.*'
      # category.public_header_files = 'Pod/Classes/NetworkEngine/**/*.h'
      category.dependency 'SDWebImage'
      category.dependency 'GTMBase64'
      category.dependency 'MJRefresh'
      category.dependency 'Masonry'
      category.dependency 'CHSTL/Macro'
  end

  s.subspec 'Macro' do |macro|
      macro.source_files = 'CHSTL/Classes/Macro/*.*'
      # category.public_header_files = 'Pod/Classes/NetworkEngine/**/*.h'
  end

  s.subspec 'UI' do |ui|
      ui.source_files = 'CHSTL/Classes/UI/*.*'
      # category.public_header_files = 'Pod/Classes/NetworkEngine/**/*.h'
      ui.dependency 'FLAnimatedImage'
      ui.dependency 'Masonry'
      ui.dependency 'CHSTL/Category'
      ui.dependency 'CHSTL/Macro'
      ui.dependency 'pop'

      ui.resource_bundles = {
        'UI_RES' => ['CHSTL/Assets/UI/*.*']
      }
  end

  # s.subspec 'Network' do |network|
  #     network.source_files = 'CHSTL/Classes/Network/*.*'
  #     network.dependency 'MJExtension'
  #     network.dependency 'AFNetworking'
  #     network.dependency 'AliyunOSSiOS', '~> 2.5.4'
  #     network.dependency 'CHSTL/Category'
  #     network.dependency 'CHSTL/Macro'
  #     network.dependency 'CHSTL/UI'
  #     # category.public_header_files = 'Pod/Classes/NetworkEngine/**/*.h'
  # end

  s.subspec 'Base' do |base|
      base.source_files = 'CHSTL/Classes/Base/*.*'
      base.dependency 'CHSTL/Category'
      base.dependency 'CHSTL/Macro'
      base.dependency 'CHSTL/UI'

      base.resource_bundles = {
        'BASE_RES' => ['CHSTL/Assets/Base/*.*']
      }
      # category.public_header_files = 'Pod/Classes/NetworkEngine/**/*.h'
  end

  s.subspec 'Utils' do |utils|
      utils.source_files = 'CHSTL/Classes/Utils/*.*'
      utils.dependency 'CHSTL/Category'
      utils.dependency 'CHSTL/Macro'
      # category.public_header_files = 'Pod/Classes/NetworkEngine/**/*.h'
  end

  s.subspec 'Router' do |router|
      router.source_files = 'CHSTL/Classes/Router/*.*'
      router.dependency 'CHSTL/Category'
      router.dependency 'CHSTL/Macro'
      router.dependency 'CHSTL/UI'
      router.dependency 'CHSTL/Base'
      # category.public_header_files = 'Pod/Classes/NetworkEngine/**/*.h'
  end

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
end
