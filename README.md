# TechD-Robin/TDStickerLibrary


The Sticker Library is a sticker's collection view of multi-page for iOS.

The Sticker Library provide several functionality :

* sticker's easy browse & preview.

* update & download newer.


<iframe width="560" height="315" src="https://www.youtube.com/embed/n3Nfy4H0dvk" frameborder="0" allowfullscreen></iframe>


## Requirements

* iOS 8.0+
* ARC



## Install

### Download

1. Click `Download ZIP` or here : [download][downloadLink]
2. Add both `TDStickerLibrary/` and `Libraries/` folder to your project.

### [CocoaPods][cocoaPodsLink]

add `Podfile` in project's root directory, content like below :

```ruby
# For latest release in cocoapods
platform :ios, '8.0'
pod "TDStickerLibrary"

```

```ruby
# Get the latest on develop
platform :ios, '8.0'
pod 'TDStickerLibrary',   :git => 'https://github.com/TechD-Robin/TDStickerLibrary.git',    :branch => 'develop'
```

```ruby
# For version 0.1.1
platform :ios, '8.0'
pod 'TDStickerLibrary',   :git => 'https://github.com/TechD-Robin/TDStickerLibrary.git',    :tag => '0.1.1'

# or
#pod 'TDStickerLibrary', '~> 0.1.1'

```



## Dependencies

* [TDResourceManager][dependenceTDResourceManager]

* [TDDownloadManager][dependenceTDDownloadManager]

* [UIKit+TechD][dependenceUIKit+TechD]



## Getting Started

* **Demo Project**
  * A demo project in `DemoStickerLibrary/` folder.

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
#import "TDStickerLibrary.h"    // import main header file
````


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

  * [Table Schema - StickerLibrary - en.ods](ReferenceFiles/Documents/Table Schema - StickerLibrary - en.ods) 
  * [Table Schema - StickerLibrary - zh-Hant.ods](ReferenceFiles/Documents/Table Schema - StickerLibrary - zh-Hant.ods)

  > **NOTE:**
  >
  > .ods file editor : [OpenOffice][OpenOfficeLink]


* **System Configure JSON Sample**  

  1. System default configure of the Tab Menu : 
   * [StickerLibraryTabDefault.json](ReferenceFiles/Configure - sample/StickerLibraryTabDefault.json)
  2. The System Update configure : 
   * [StickerLibrarySystemUpdate.json](ReferenceFiles/Configure - sample/StickerLibrarySystemUpdate.json)
  3. A Page configure : 
   * [1001.page.face.json](ReferenceFiles/Configure - sample/1001page.face.json), 
   * [1002page.weather.json](ReferenceFiles/Configure - sample/1002page.weather.json), 
   * [1003page.emotion.json](ReferenceFiles/Configure - sample/1003page.emotion.json).


* **Preview Image Crop PList Sample**   

  * [warszawianka-weather.plist](ReferenceFiles/Configure - sample/warszawianka-weather.plist)


## Special Thanks

* for be imported repositories :

  * [ZipArchive][dependenceZipArchive]
  * [AFNetworking][dependenceAFNetworking]


* for stickers sample :

  * [Oca Studios][Oca Studios]
  * [nicubunu][nicubunu]
  * [rg1024][rg1024]    
  * [gnokii][gnokii]    
  * [warszawianka][warszawianka]  


## Special Request

 Sorry for my English, is very weak.

 Also, please help me to fix these English syntax or error words, if you have free time and want to do.

 ** Thanks very much! **

## Contribute

coming soon ~. ~


(You can support contributors of this project individually.)


## Donate 

Support the development of this library and author.

![donateWithPayPal][donateWithPayPal] 
* [USD $1][USD $1] a black tea of traditional taste of Taiwan. 
* [USD $5][USD $5] a good lunch 
* [USD $20][USD $20] anti-hungry 72 hr 
* [USD $50][USD $50] get a wonderful week 
* [other USD][other USD] a kindness support for development 

** Bitcoin **
* Bitcoin address `1GkUKb31JDwimpu2MJoQ1R7rjS8taX97aE`
* [Bitcoin URI][donateBitcoinURI]

Thanks for each donator.

## License

`TDStickerLibrary` is released under the [MIT License][mitLink]. See `LICENSE` for details.

>**Copyright &copy; 2015-Robin Hsu/Tech.D.Robin**

Please provide attribution, it is greatly appreciated.


----
[downloadLink]: https://github.com/TechD-Robin/TDStickerLibrary/archive/master.zip
[cocoaPodsLink]: https://cocoapods.org/
[OpenOfficeLink]: https://www.openoffice.org/

[dependenceTDResourceManager]: https://github.com/TechD-Robin/TDResourceManager
[dependenceTDDownloadManager]: https://github.com/TechD-Robin/TDDownloadManager
[dependenceUIKit+TechD]: https://github.com/TechD-Robin/UIKit-TechD

[dependenceAFNetworking]: https://github.com/AFNetworking/AFNetworking
[dependenceZipArchive]: https://github.com/mattconnolly/ZipArchive

[Oca Studios]: http://ocastudios.com/classics/doushouqi
[nicubunu]: https://openclipart.org/user-cliparts/nicubunu
[rg1024]: https://openclipart.org/user-cliparts/rg1024
[gnokii]: https://openclipart.org/user-cliparts/gnokii
[warszawianka]: https://openclipart.org/user-cliparts/warszawianka

[donateSimply]: https://www.paypalobjects.com/en_US/TW/i/btn/btn_donate_SM.gif
[donateWithPayPal]: https://www.paypalobjects.com/webstatic/en_US/btn/btn_donate_pp_142x27.png
[USD $1]: https://www.paypal.com/cgi-bin/webscr?cmd=_s-xclick&hosted_button_id=LNBCYLQ7EGWGU
[USD $5]: https://www.paypal.com/cgi-bin/webscr?cmd=_s-xclick&hosted_button_id=MS3JH5B6NQ6LU
[USD $20]: https://www.paypal.com/cgi-bin/webscr?cmd=_s-xclick&hosted_button_id=J3E8Y3CE5ZEC6
[USD $50]: https://www.paypal.com/cgi-bin/webscr?cmd=_s-xclick&hosted_button_id=3N79SPMPQBJ9U
[other USD]: https://www.paypal.com/cgi-bin/webscr?cmd=_s-xclick&hosted_button_id=S7YNRSFEF2HUG

[donateBitcoinURI]: bitcoin:1GkUKb31JDwimpu2MJoQ1R7rjS8taX97aE?label=GitHub%2C%20donate&message=Receive%20from%20GitHub%20TDSticker%20Library%27s%20donator%20

[mitLink]:http://opensource.org/licenses/MIT


