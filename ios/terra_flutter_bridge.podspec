#
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html.
# Run `pod lib lint terra_flutter.podspec` to validate before publishing.
#
Pod::Spec.new do |s|
  s.name             = 'terra_flutter_bridge'
  s.version          = '0.4.3'
  s.summary          = 'Flutter Bridge for TerraiOS.'
  s.description      = <<-DESC
Flutter Bridge for Terra iOS
                       DESC
  s.homepage         = 'https://github.com/tryterra/terra-flutter'
  s.license          = { :file => '../LICENSE' }
  s.author           = { 'Try Terra' => 'dev@tryterra.co' }
  s.source           = { :path => '.' }
  s.source_files = 'Classes/**/*'
  s.dependency 'Flutter'
  s.dependency 'TerraiOS', '~> 1.5.3'
  s.frameworks = ['HealthKit']

  s.platform = :ios, '13.0'

  # Flutter.framework does not contain a i386 slice.
  s.pod_target_xcconfig = { 'DEFINES_MODULE' => 'YES', 'EXCLUDED_ARCHS[sdk=iphonesimulator*]' => 'i386' }
  s.swift_version = '5.0'
end
