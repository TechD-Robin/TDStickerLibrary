# Functionality/TDStickerLibrary


## Usage

## Dependencies

* TDResourceManager
* TDDownloadManager
* UIKit+TechD


## Requirements

* iOS 8.0+
* ARC


## Installation

From [CocoaPods](http://cocoapods.org):

```ruby
# For latest release in cocoapods
pod 'TDStickerLibrary'

# Get the latest on develop
pod 'TDStickerLibrary',     :git => 'git://git.techd.idv.tw/Functionality/TDStickerLibrary.git',       :branch => 'develop'

# For version 0.1.0
pod 'TDStickerLibrary',     :git => 'git://git.techd.idv.tw/Functionality/TDStickerLibrary.git',       :tag    => '0.1.0' 
```


Without CocoaPods:

Drag the `TDStickerLibrary/` and `Libraries/` folder to your project.


## Getting Started

````objective-c
#import "TDStickerLibrary.h"    // import main header file
````

* **Demo Project**
  * There's a demo project: `DemoStickerLibrary/`.

  > **NOTE:**
  > the demo project is include base mechanism:
  >
  > 1. browse sticker library.
  >
  > 2. get the sticker image from user touch.
  > 
  > 3. update sticker library data.

* **Quick Run**

* ````objective-c
        TDStickerLibraryViewController* controller;
        controller                      = [TDStickerLibraryViewController stickerLibaray];
        if ( nil == controller )
        {
            return;
        }
        [self                           presentViewController: controller animated: YES completion: nil];

        //  will get a empty sticker libery.
````
> **NOTE:**
> will get a empty sticker libery.


* **Easy Sample**
  1. Download `Resources/**/*.*` these file.
  2. Create a `Resources/` directory to your project.
  3. Drag the `Configure/` (step 1's sub-directory) folder into `Resources/` folder, and at **'Added folders :'** choose ***`Create folder references`***.
  4. Rebuild & run project.

  > **NOTE:**
  > these code is not yet include update mechanism.

## Getting  Advance

* **Customization** customize your UI configure 
* ````objective-c
        TDStickerLibraryViewController* controller;
        TDStickerLibraryCustomization * customization;
    
        customization                   = [TDStickerLibraryCustomization new];
        if ( nil == customization )
        {
            return;
        }
    
        [customization                  setSysStyleMasterVisionBGC:     [UIColor purpleColor]];
        [customization                  setSysStyleTitleTextColor:      [UIColor lightGrayColor]];
        [customization                  setBannerHeight:                0.0f];
        [customization                  setTableItemSizeUsingImageOriginalProportion: YES];
        //[customization ...];

        controller                      = [TDStickerLibraryViewController stickerLibarayWithCustomization: customization];
        if ( nil == controller )
        {
            return;
        }
        [self                           presentViewController: controller animated: YES completion: nil];
````

  > **NOTE:**
  >
  > 1. check other configure your can customize from `TDStickerLibraryCustomization.h`.
  >
  > 2. you must customize these properties `sysStyleXXX` like `sysStyleBundleName` for system style by you self.


* **Get Sticker** get the sticker image from user touch

* ````objective-c
        [controller                     setFinishedStickerLibraryCallbackBlock: ^(UIImage * stickerImage)
        {
            NSLog( @"sticker image : %@", stickerImage );
        }];
````





## Author

Functionality/TDStickerLibrary, robinhsu599+dev@gmail.com

## License

See the LICENSE file for more info.




