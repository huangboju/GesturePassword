
Pod::Spec.new do |s|

  s.name         = "GesturePassword"
  s.version      = "1.2.2"
  s.summary      = "GesturePassword is a simple gesture password written in Swift 2.2"
  s.homepage     = "https://github.com/huangboju/GesturePassword"
  s.license      = "MIT"
  s.author             = { "huangboju" => "529940945@qq.com" }
  s.platform     = :ios,'8.0'
  s.source       = { :git => "https://github.com/huangboju/GesturePassword.git", :tag => "#{s.version}" }
  s.source_files  = "Classes/**/*.swift"
  s.framework  = "UIKit"
  s.requires_arc = true
end
