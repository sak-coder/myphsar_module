# my_flutter_module.podspec

Pod::Spec.new do |s|
  s.name             = 'myphsar_module'
  s.version          = '1.0.0'
  s.summary          = 'A short description of your Flutter module.'
  s.description      = <<-DESC
  This is a Flutter module packaged as a CocoaPod. It contains the
  Flutter UI and business logic for a specific feature.
  DESC
  s.homepage         = 'https://github.com/sak-coder/myphsar_module'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'myphsar' => 'sak@myphsar.com' }
  s.source           = { :git => 'https://github.com/sak-coder/myphsar_module.git', :tag => s.version.to_s }
  s.ios.deployment_target = '15.0'
  s.swift_versions = '5.0'

  # Add frameworks for App and Flutter engine
  s.vendored_frameworks = 'build/ios/framework/Debug/App.xcframework', 'build/ios/framework/Debug/Flutter.xcframework'

  # Add vendored frameworks for each plugin you use
  s.vendored_frameworks += 'build/ios/framework/Debug/FlutterPluginRegistrant.xcframework'

  # Example for a plugin
  # s.vendored_frameworks += 'build/ios/framework/Debug/path_provider_ios.xcframework'

  # Add dependencies for the Flutter plugins
  # You can find these by looking at the podspec files inside your .ios/Flutter/ directory
  # s.dependency 'path_provider_ios'
end
