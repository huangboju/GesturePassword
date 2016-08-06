
Pod::Spec.new do |s|

  s.name         = "GesturePassword"
  s.version      = "0.0.1"
  s.summary      = "swift版的手势密码"
  s.homepage     = "https://github.com/huangboju/GesturePassword"
  s.license      = "MIT"
  s.author             = { "huangboju" => "529940945@qq.com" }
  s.platform     = :ios,'8.0'
  s.source       = { :git => "https://github.com/huangboju/GesturePassword.git", :tag => "#{s.version}" }
  s.source_files  = "GesturePassword/Classes/**/*.swift"
  s.framework  = "UIKit"
  s.requires_arc = true
end
