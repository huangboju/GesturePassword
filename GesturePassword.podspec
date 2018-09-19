
Pod::Spec.new do |s|
    
    s.name         = "GesturePassword"
    s.version      = "2.0.3"
    s.summary      = "GesturePassword is a simple gesture password written in Swift"
    s.homepage     = "https://github.com/huangboju/GesturePassword"
    s.license      = "MIT"
    s.author       = { "huangboju" => "529940945@qq.com" }
    s.platform     = :ios,'8.0'
    s.source       = { :git => "https://github.com/huangboju/GesturePassword.git", :tag => "#{s.version}" }
    s.source_files = "GesturePassword/Classes/**/*.swift"
    s.ios.resource_bundles = {
        "GesturePassword" => ["GesturePassword/Assets/*.lproj/*.strings"]
    }
    s.framework    = "UIKit"
    s.requires_arc = true
    s.pod_target_xcconfig = { "SWIFT_VERSION" => "4.2" }
end
