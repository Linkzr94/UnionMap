Pod::Spec.new do |s|
  s.name             = 'UnionMap'
  s.version          = '0.0.5'
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

  #s.default_subspec = 'UMCommon'

  s.subspec 'UMCommon' do |ss|
    ss.source_files = 'UnionMap/Classes/UMCommon/*'
    ss.dependency 'CTMediator'
  end

  s.subspec 'UMAMap' do |ss|
    ss.source_files = 'UnionMap/Classes/UMAMap/*'
    ss.dependency 'UnionMap/UMCommon'
    ss.dependency 'AMap3DMap'
    ss.dependency 'AMapSearch'
  end

  s.static_framework = true

  #s.dependency 'AMap3DMap'
  #s.dependency 'AMapSearch'

end
