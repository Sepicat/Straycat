Pod::Spec.new do |s|
  s.name         = "Straycat"
  s.version      = "0.1.0"
  s.summary      = "The github parser for Sepicat"
  s.description  = <<-DESC
  Parse the github data, which can't be given by github.
                   DESC
  s.homepage     = "http://desgard.com"
  s.license      = "GPL-3.0"
  s.author       = { "Harry Twan" => "gua@desgard.com" }
  s.source       = { :git => "https://github.com/Sepicat/Straycat.git", :tag => "0.1.0" }
  s.source_files  =  "Straycat/Straycat/*.{swift,plist}"
  s.ios.deployment_target = '10.0'
  s.dependency 'Alamofire', '~> 4.5'
  s.dependency 'SwiftSoup', '~> 1.6.3'
end
