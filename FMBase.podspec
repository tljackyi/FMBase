Pod::Spec.new do |s|
  s.name             = 'FMBase'
  s.version          = '0.0.2'
  s.summary          = 'FMBase a dev toolkit'
  s.homepage         = 'https://github.com/tljackyi/FMBase'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'tljackyi' => 'tljackyi@gmail.com' }
  s.source           = { :git => 'https://github.com/tljackyi/FMBase.git', :tag => s.version.to_s }

  s.platform = :ios
  s.ios.deployment_target = '9.0'
  s.source_files = 'FMBase/Classes/**/**/*.{h,m}'
  s.frameworks = "UIKit", "Foundation"

  
  s.dependency 'YYKit'

end
