require "json"

package = JSON.parse(File.read(File.join(__dir__, "package.json")))

Pod::Spec.new do |s|
  s.name         = package['name']
  s.version      = package["version"]
  s.summary      = package["description"]
  s.homepage     = package["homepage"]
  s.license      = package["license"]
  s.authors      = package["author"]

  s.platforms      = { :ios => "9.0", :tvos => "11.0" }
  s.ios.deployment_target = '9.0'
  s.preserve_paths = 'README.md', 'package.json', 'index.js'
  s.source_files   = 'iOS/*.{h,m}'
  s.source         = { :git => 'https://github.com/bashen1/react-native-mcheck-proxy.git', :tag => "#{s.version}" }

  s.dependency "React-Core"
end
