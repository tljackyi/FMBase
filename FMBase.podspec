Pod::Spec.new do |s|
  s.name             = 'FMBase'
  s.version          = '0.1.1'
  s.summary          = 'FMBase a dev toolkit'
  s.homepage         = 'https://github.com/tljackyi/FMBase'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'tljackyi' => 'tljackyi@gmail.com' }
  s.source           = { :git => 'https://github.com/tljackyi/FMBase.git', :tag => s.version.to_s }

  s.platform = :ios
  s.ios.deployment_target = '9.0'
  s.source_files = 'FMBase/Classes/**/**/*.{h,m}'
  s.frameworks = "UIKit", "Foundation"

  s.dependency 'YYModel'
  s.dependency 'YYText'
  s.dependency 'YYImage'
  s.dependency 'YYCache'
  s.dependency 'FCUUID'
  s.dependency 'Tweaks'
  s.dependency 'Masonry'
  s.dependency 'FCFileManager'
  s.dependency 'UICKeyChainStore'
  s.dependency 'AFNetworking'
  s.dependency 'ReactiveObjC'
  s.dependency 'SDWebImage', '~> 5.0'

end
