# Uncomment the next line to define a global platform for your project
platform :ios, '13.0'

  post_install do |installer|
    installer.pods_project.targets.each do |target|
      target.build_configurations.each do |config|
        config.build_settings.delete 'IPHONEOS_DEPLOYMENT_TARGET'
      end
    end
  end

target 'SwiftWeatherApp' do
  # Comment the next line if you don't want to use dynamic frameworks
  use_frameworks!

  # Pods for SwiftWeatherApp
	
	pod 'AFNetworking', '~> 4.0'
  pod 'SVProgressHUD'

  target 'SwiftWeatherAppTests' do
    inherit! :search_paths
    # Pods for testing
  end

  target 'SwiftWeatherAppUITests' do
    # Pods for testing
  end

end
