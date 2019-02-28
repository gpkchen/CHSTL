#
# Be sure to run `pod lib lint ZHSTL.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'ZHSTL'
  s.version          = '1.0.74'
  s.summary          = 'Z.H.STL'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
  Zhejiang horizon New Technology Co., Ltd., IOS public module management platform
                       DESC

  s.homepage         = 'http://git.fintechzh.com/chenh/ZHSTL.git'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'chenh' => 'chenh@fintechzh.com' }
  s.source           = { :git => 'http://git.fintechzh.com/chenh/ZHSTL.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'
  s.ios.deployment_target = '8.0'

  s.subspec 'Category' do |category|
      category.source_files = 'ZHSTL/Classes/Category/*.*'
      # category.public_header_files = 'Pod/Classes/NetworkEngine/**/*.h'
      category.dependency 'SDWebImage'
      category.dependency 'GTMBase64'
      category.dependency 'MJRefresh'
      category.dependency 'Masonry'
      category.dependency 'ZHSTL/Macro'
  end

  s.subspec 'Macro' do |macro|
      macro.source_files = 'ZHSTL/Classes/Macro/*.*'
      # category.public_header_files = 'Pod/Classes/NetworkEngine/**/*.h'
  end

  s.subspec 'UI' do |ui|
      ui.source_files = 'ZHSTL/Classes/UI/*.*'
      # category.public_header_files = 'Pod/Classes/NetworkEngine/**/*.h'
      ui.dependency 'FLAnimatedImage'
      ui.dependency 'Masonry'
      ui.dependency 'ZHSTL/Category'
      ui.dependency 'ZHSTL/Macro'
      ui.dependency 'pop'

      ui.resource_bundles = {
        'UI_RES' => ['ZHSTL/Assets/UI/*.*']
      }
  end

  # s.subspec 'Network' do |network|
  #     network.source_files = 'ZHSTL/Classes/Network/*.*'
  #     network.dependency 'MJExtension'
  #     network.dependency 'AFNetworking'
  #     network.dependency 'AliyunOSSiOS', '~> 2.5.4'
  #     network.dependency 'ZHSTL/Category'
  #     network.dependency 'ZHSTL/Macro'
  #     network.dependency 'ZHSTL/UI'
  #     # category.public_header_files = 'Pod/Classes/NetworkEngine/**/*.h'
  # end

  s.subspec 'Base' do |base|
      base.source_files = 'ZHSTL/Classes/Base/*.*'
      base.dependency 'ZHSTL/Category'
      base.dependency 'ZHSTL/Macro'
      base.dependency 'ZHSTL/UI'

      base.resource_bundles = {
        'BASE_RES' => ['ZHSTL/Assets/Base/*.*']
      }
      # category.public_header_files = 'Pod/Classes/NetworkEngine/**/*.h'
  end

  s.subspec 'Utils' do |utils|
      utils.source_files = 'ZHSTL/Classes/Utils/*.*'
      utils.dependency 'ZHSTL/Category'
      utils.dependency 'ZHSTL/Macro'
      # category.public_header_files = 'Pod/Classes/NetworkEngine/**/*.h'
  end

  s.subspec 'Router' do |router|
      router.source_files = 'ZHSTL/Classes/Router/*.*'
      router.dependency 'ZHSTL/Category'
      router.dependency 'ZHSTL/Macro'
      router.dependency 'ZHSTL/UI'
      router.dependency 'ZHSTL/Base'
      # category.public_header_files = 'Pod/Classes/NetworkEngine/**/*.h'
  end

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
end
