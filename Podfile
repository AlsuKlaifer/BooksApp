platform :ios, '14.0'
use_frameworks!
target 'BooksApp' do
  pod 'SwiftLint', '~> 0.46.2'
  pod 'FirebaseAuth'
  pod 'FirebaseFirestore'
  pod 'FirebaseDatabase'
end

post_install do |installer|
    installer.generated_projects.each do |project|
        project.targets.each do |target|
            target.build_configurations.each do |config|
                config.build_settings['IPHONEOS_DEPLOYMENT_TARGET'] = '14.0'
            end
        end
    end
end
