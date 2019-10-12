Pod::Spec.new do |s|
  s.name         = "Straycat"
  s.version      = "0.1.2"
  s.summary      = "The github parser for Sepicat"
  s.description  = <<-DESC
  Parse the github data, which can't be given by github.
                   DESC
  s.homepage     = "http://desgard.com"
  s.license      = "GPL-3.0"
  s.author       = { "Harry Twan" => "gua@desgard.com" }
  s.source       = { :git => "https://github.com/Sepicat/Straycat.git", :tag => "0.1.0" }
  s.source_files  =  "Straycat/Straycat/**/*.{swift}"
  s.ios.deployment_target = '10.0'
  s.dependency 'Alamofire'
  s.dependency 'SwiftSoup'
  s.dependency 'PySwiftyRegex'

  s.pod_target_xcconfig = { 'HEADER_SEARCH_PATHS' => "$(SDKROOT)/usr/include/libxml2" }
  s.dependency 'Kanna'
end
