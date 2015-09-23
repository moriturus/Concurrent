
Pod::Spec.new do |s|

  s.name         = "Concurrent"
  s.version      = "1.2.0"
  s.summary      = "Swift's concurrency programming library influenced by Go and Rust"

  s.description  = <<-DESC
  Concurrent is a minimum concurrency programming library that is influenced by Google Go Language and Rust Language.
  The Library is now developing for iOS 8 and OSX Yosemite and written in Apple Swift.
                   DESC

  s.homepage     = "https://github.com/moriturus/Concurrent"
  s.license      = { :type => "MIT", :file => "LICENSE" }

  s.author             = { "moriturus" => "es.moriturus@icloud.com" }
  s.social_media_url   = "http://twitter.com/moriturus"

  s.ios.platform     = :ios, "8.0"
  s.osx.platform     = :osx, "10.10"
  s.watchos.deployment_target = "2.0"
  s.requires_arc     = true

  s.source       = { :git => "https://github.com/moriturus/Concurrent.git", :tag => "0.0.1" }
  s.source_files  = "Classes", "Concurrent/*.swift"

end
