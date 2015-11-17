
Pod::Spec.new do |s|

  s.name          = "TDStickerLibrary"
  s.version       = "0.1.1"
  s.summary       = "The Sticker Library is a sticker's collection view of multi-page for iOS."

  s.description  = <<-DESC
                   The Sticker Library is a sticker's collection view of multi-page for iOS.

                   * The Sticker Library provide several functionality,
                   *  can do sticker's easy browse & preview, & update & download newer.
                   DESC

  s.homepage     = "https://github.com/TechD-Robin/TDStickerLibrary/"
  s.source       = { :git => "https://github.com/TechD-Robin/TDStickerLibrary.git", :tag => "#{s.version}" }

  s.license            = 'MIT'
  s.author             = { "Robin Hsu" => "robinhsu599+dev@gmail.com" }
  s.social_media_url   = "https://plus.google.com/+RobinHsu"


  s.platform      = :ios, "8.0"
  s.requires_arc  = true
  s.frameworks    = 'Foundation', 'CoreGraphics', 'UIKit'

  s.source_files  = 'ARCMacros.h', 'TDStickerLibrary/*.{h,m}' 

  s.resources     = ['TDStickerLibrary/Assets/StickerLibraryDefault.bundle'] 


  s.dependency    "TDMath",               "~> 0.0.1"
  s.dependency    "TDResourceManager",    "~> 0.0.3"
  s.dependency    "TDDownloadManager",    "~> 0.0.6"
  s.dependency    "UIKit+TechD",          "~> 0.0.2"

  # Data Object.
  s.subspec 'Data' do |ss| 
    ss.source_files = 'TDStickerLibrary/Data/*.{h,m}' 
    ss.frameworks   = 'Foundation', 'CoreGraphics', 'UIKit'

    ss.dependency   "TDResourceManager",    "~> 0.0.3"
    ss.dependency   "TDFoundation",         "~> 0.0.4"
    ss.dependency   "UIKit+TechD",          "~> 0.0.2"
  

  
  end

  s.subspec 'TDBaseObjects' do |ss| 
    ss.source_files = 'Libraries/TDBaseObjects/**/*.{h,m}' 
    ss.frameworks   = 'UIKit' 

    ss.dependency   'UIKit+TechD',        "~> 0.0.2" 

  end


end
