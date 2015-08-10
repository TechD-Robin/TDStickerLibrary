
Pod::Spec.new do |s|

  s.name          = "TDStickerLibrary"
  s.version       = "0.1.0"
  s.summary       = "The Sticker Library is a multi-page for sticker collection view for iOS."

  s.homepage      = "http://gitweb.techd.idv.tw:8080/?p=Functionality/TDStickerLibrary.git;a=summary"
  s.license       = { :type=> "No License", :file => "LICENSE" }
  s.author        = { "Robin Hsu" => "robinhsu599+dev@gmail.com" }


  s.platform      = :ios, "8.0"
  s.requires_arc  = true
  s.frameworks    = 'Foundation', 'CoreGraphics', 'UIKit'

  s.source        = { :git => "git://git.techd.idv.tw/Functionality/TDStickerLibrary.git", :tag => "#{s.version}" }
  s.source_files  = 'ARCMacros.h', 'TDStickerLibrary/*.{h,m}', 'TDStickerLibrary/Data/*.{h,m}'

  s.resources     = ['TDStickerLibrary/Assets/StickerLibraryDefault.bundle'] 

  s.dependency    "TDResourceManager",    "~> 0.0.3"
  s.dependency    "fork_ZipArchive",      "~> 1.3.2"
  s.dependency    "TDFoundation",         "~> 0.0.4" 
  #s.dependency    "Foundation+TechD",     "~> 0.0.3"


  s.dependency    "TDMath",               "~> 0.0.1"
  s.dependency    "UIKit+TechD",          "~> 0.0.2"
  s.dependency    "TDDownloadManager",    "~> 0.0.6"

  s.subspec 'TDBaseObjects' do |ss| 
    ss.source_files = 'Libraries/TDBaseObjects/**/*.{h,m}' 
    ss.frameworks   = 'UIKit' 
    ss.dependency   'UIKit+TechD',        "~> 0.0.2" 

  end


end
