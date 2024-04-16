source 'https://github.com/CocoaPods/Specs.git'

platform :ios, '16'

inhibit_all_warnings!
use_frameworks!

install! 'cocoapods', warn_for_unused_master_specs_repo: false

target 'ClimaEs' do
  pod 'Alamofire', '~> 5.4'
  pod 'SnapKit', '~> 5.7.0'
end

post_install do |installer|
  installer.pods_project.build_configurations.each do |config|
    config.build_settings['VALID_ARCHS'] = 'arm64, arm64e, x86_64'
end

end


