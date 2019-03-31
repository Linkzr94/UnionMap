Pod::Spec.new do |s|
  s.name             = 'UnionMap'
  s.version          = '0.0.2'
  s.summary          = 'UnionMap for iOS.'

  s.description      = <<-DESC
TODO: Add long description of the pod here.
                       DESC

  s.homepage         = 'https://github.com/nullcex/UnionMap'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'nullcex' => '1028159057@qq.com' }
  s.source           = { :git => 'https://github.com/nullcex/UnionMap.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.ios.deployment_target = '8.0'

  #s.source_files = 'UnionMap/Classes/**/*'
  
  # s.resource_bundles = {
  #   'UnionMap' => ['UnionMap/Assets/*.png']
  # }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
  # s.dependency 'AFNetworking', '~> 2.3'

  s.subspec 'UMCommon' do |Common|
    Common.source_files = 'UnionMap/Classes/UMCommon/**/*'
    Common.dependency = 'CTMediator'
  end

  s.subspec 'UMAMap' do |AMap|
    AMap.source_files = 'UnionMap/Classes/UMAMap/**/*'
    AMap.dependency = 'UnionMap/Classes/UMCommon'
  end

end
