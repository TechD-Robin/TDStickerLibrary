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
  4. Reference **Quick Run**
  5. Rebuild & run project.

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
  > 1. check these configure your can customize from `TDStickerLibraryCustomization.h`.
  >
  > 2. you must customize these properties `sysStyleXXX` like `sysStyleBundleName` for system style by you self.


* **Get Sticker** get the sticker image from user touch

* ````objective-c
        [controller                     setFinishedStickerLibraryCallbackBlock: ^(UIImage * stickerImage)
        {
            NSLog( @"sticker image : %@", stickerImage );
        }];
````



* **Update Data**
  1. Setup your update file to server.
  2. Get the update file's URL.
  3. Use this URL to your update method.
  4. sample 

     ````objective-c 
- ( void ) updateConfigure 
{
            NSArray                       * searchKeys;
            NSString                      * updateTabSearchKey;
            NSString                      * urlString;
            TDStickerLibraryUpdate        * updateProcedure;
            TDStickerLibraryCustomization * customization;
    
            updateTabSearchKey              = @"UpdateTab";
            urlString                       = @"https://docs.google.com/uc?authuser=0&id=0B1yHM9LysIXXX0JqNEdqcEZSTU0&export=download";
            customization                   = [TDStickerLibraryCustomization new];
            NSParameterAssert( nil != customization );
    
            [customization                  setSystemConfigureTabUpdateDefaultKey: updateTabSearchKey];
            [customization                  setSystemConfigureTabUpdateZpwiaopsrpsded: @"StickerLibrary"];
            updateProcedure                 = [TDStickerLibraryUpdate stickerLibraryUpdateWithCustomization: customization];
            NSParameterAssert( nil != updateProcedure );
    
            searchKeys                      = [NSArray arrayWithObjects: updateTabSearchKey, nil];
            [updateProcedure                startUpdateSystemConfigure: urlString forSearch: searchKeys];
    
            __weak __typeof(updateProcedure)    weakUpdateProcedure;
            weakUpdateProcedure                 = updateProcedure;
            [updateProcedure                    setUpdateCompletionBlock: ^(NSDictionary * updateResponses, NSError * error, BOOL finished)
            {
                NSLog( @"resopnses : %@", updateResponses );
                NSLog( @"error : %@", error );
                NSLog( @"finished : %d", finished );
         
                [weakUpdateProcedure            stopProcedure];
            }];
}
````
  
  > **NOTE:**
  >
  > after added the update procedure, about some of customize configure of **`TDStickerLibraryViewController`**, must same the update's configure;
  >
  >
  
  ````objective-c 
- (IBAction)startAction:(id)sender
{
    
        TDStickerLibraryViewController* controller;
        TDStickerLibraryCustomization * customization;
    
        customization                   = [TDStickerLibraryCustomization new];
        NSParameterAssert( nil != customization );
    
        [customization                  setSystemConfigureTabUpdateDefaultKey:          @"UpdateTab"];
        [customization                  setSystemConfigureTabUpdateZpwiaopsrpsded:      @"StickerLibrary"];
        [customization                  setSystemConfigureTabPageUpdateZpwiaopsrpsded:  @"StickerLibrary"];
        [customization                  setStickerDownloadZpwiaopsrpsded:               @"StickerLibrary"];
    
        controller                      = [TDStickerLibraryViewController stickerLibarayWithCustomization: customization];
        NSParameterAssert( nil != controller );
    
        [controller                     setFinishedStickerLibraryCallbackBlock: ^(UIImage * stickerImage)
        {
            NSLog( @"sticker image : %@", stickerImage );
        }];
    
        [self                           presentViewController: controller animated: YES completion: nil];
}
````

## Documents

* **Configure Files Schema** 
  1. [Table Schema - StickerLibrary - en.ods](ExtensionFiles/Documents/Table Schema - StickerLibrary - en.ods)

  > **NOTE:**
  >
  > .ods file editor : [OpenOffice](https://www.openoffice.org/)


## Author

Functionality/TDStickerLibrary, robinhsu599+dev@gmail.com

## License

See the LICENSE file for more info.




