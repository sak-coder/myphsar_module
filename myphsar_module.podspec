# my_flutter_module.podspec
Pod::Spec.new do |s|
  s.name             = 'myphsar_module'
  s.version          = '1.0.0'
  s.summary          = 'A MyPhsar module for iOS integration'
  s.description      =  'MyPhsar module for iOS integration'
  s.homepage         = 'https://github.com/sak-coder/myphsar_module'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'sak-coder' => 'sak@myphsar.com' }
  s.source           = { :git => 'https://github.com/sak-coder/myphsar_module.git', :tag => s.version.to_s }

  s.ios.deployment_target = '15.0'
  s.static_framework = true

  # Flutter framework
  s.vendored_frameworks = [
    'Flutter/App.framework',
    'Flutter/Flutter.framework',
    'Flutter/FlutterPluginRegistrant.framework',
    'Flutter/path_provider.framework',
    'Flutter/shared_preferences.framework',
    # Add other plugin frameworks your module uses
  ]

  # Flutter engine and plugins
  s.preserve_paths = 'Flutter/*.framework'
  s.xcconfig = { 'OTHER_LDFLAGS' => '-framework Flutter' }
  s.pod_target_xcconfig = { 'DEFINES_MODULE' => 'YES' }
end
