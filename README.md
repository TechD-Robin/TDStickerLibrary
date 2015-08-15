# Functionality/TDStickerLibrary

The Sticker Library is a multi-page for sticker collection view for iOS.

<iframe width="560" height="315" src="https://www.youtube.com/embed/n3Nfy4H0dvk" frameborder="0" allowfullscreen></iframe>

## Dependencies

* TDResourceManager
* TDDownloadManager
* UIKit+TechD


## Requirements

* iOS 8.0+
* ARC


## Usage

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

1. Download this repository from here.
2. Drag the `TDStickerLibrary/` and `Libraries/` folder to your project.


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
  > 2. you must customize these properties <span style="color:red">`sysStyleXXX`</span> like `sysStyleBundleName` for system style by you self.


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
    
        [customization                  setSystemConfigureTabUpdateDefaultKey:          @"UpdateTab"];          //  equal update's configure.
        [customization                  setSystemConfigureTabUpdateZpwiaopsrpsded:      @"StickerLibrary"];     //  maybe equal update's configure. 
        [customization                  setSystemConfigureTabPageUpdateZpwiaopsrpsded:  @"StickerLibrary"];     //  maybe equal update's configure. 
        [customization                  setStickerDownloadZpwiaopsrpsded:               @"StickerLibrary"];     //  maybe equal update's configure. 
    
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
  1. [Table Schema - StickerLibrary - en.ods](ReferenceFiles/Documents/Table Schema - StickerLibrary - en.ods), [Table Schema - StickerLibrary - zh-Hant.ods](ReferenceFiles/Documents/Table Schema - StickerLibrary - zh-Hant.ods)

  > **NOTE:**
  >
  > .ods file editor : [OpenOffice](https://www.openoffice.org/)
  
* **System Configure JSON Sample** 
  1. System default configure of the Tab Menu : [StickerLibraryTabDefault.json](ReferenceFiles/Configure - sample/StickerLibraryTabDefault.json) 
  2. The System Update configure : [StickerLibrarySystemUpdate.json](ReferenceFiles/Configure - sample/StickerLibrarySystemUpdate.json)
  3. A Page configure : [1001.page.face.json](ReferenceFiles/Configure - sample/1001page.face.json), [1002page.weather.json](ReferenceFiles/Configure - sample/1002page.weather.json), [1003page.emotion.json](ReferenceFiles/Configure - sample/1003page.emotion.json).

* **Preview Image Crop PList Sample**   
  [warszawianka-weather.plist](ReferenceFiles/Configure - sample/warszawianka-weather.plist) 



## Author

Functionality/TDStickerLibrary, robinhsu599+dev@gmail.com

## License

See the [LICENSE](LICENSE) file for more info.

>**Copyright &copy; 2015 Robin Hsu/Tech.D.Robin**


