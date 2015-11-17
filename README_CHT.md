# TechD-Robin/TDStickerLibrary

(中文毒我)

Sticker Library 是一鍋給 iOS 裝置使用的多分頁式的貼紙瀏覽的函式庫。

Sticker Library 提供的幾項主要功能：

* 簡單的貼紙瀏覽以及預覽功能

* 貼紙資料的下載與更新


<iframe width="560" height="315" src="https://www.youtube.com/embed/n3Nfy4H0dvk" frameborder="0" allowfullscreen></iframe>


## 環境需求

* iOS 8.0+
* ARC



## 函式庫安裝

### 下載

1. 點選畫面右邊的`Download ZIP`，或者直接 [點這邊下載][downloadLink]
2. 將函式庫的 `TDStickerLibrary/` 和 `Libraries/` 這兩個目錄新增到您的專案內

### 透過 [CocoaPods][cocoaPodsLink]

在專案的根目錄裡頭新增一個 `Podfile` 檔案，並且新增類似下面描述的檔案內容：

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



## 專案相依性

本函式庫直接引用下述的其他函式庫：

* [TDResourceManager][dependenceTDResourceManager]

* [TDDownloadManager][dependenceTDDownloadManager]

* [TDFoundation][dependenceTDFoundation]

* [UIKit+TechD][dependenceUIKit+TechD]

* [TDMath][dependenceTDMath]


## 入門使用 － ⋯ 花您三十分鐘就上手？

* ** 展示用專案 **
  * 專案內容被擺在 `DemoStickerLibrary/` 這個資料夾內。


  > **注意事項：**
  > 展示用專案包含下述幾項基本的機制流程
  >
  > 1. 瀏覽貼紙圖庫
  >
  > 2. 使用者點選後，取得貼紙的圖像資訊
  >
  > 3. 貼紙圖庫的更新


* **簡單又快速的引用執行**

  ````objective-c
  #import "TDStickerLibrary.h"    // import main header file
  ````
  ````objective-c
  TDStickerLibraryViewController* controller;
  controller                      = [TDStickerLibraryViewController stickerLibaray];
  if ( nil == controller )
  {
      return;
  }
  [self                           presentViewController: controller animated: YES completion: nil];

  //  will get a empty sticker libery.
  ````
> **注意事項：**
> 太過簡單地導入的關係，您將得到一個 啥密碗糕貼圖都沒有的貼紙圖庫！


* **簡單版本的引用範例**
  1. 先透過下載或是解壓縮取得本專案內容的目錄：`Resources/**/*.*`
  2. 在您的專案列表之下新增一個目錄：`Resources/`
  3. 將步驟一所取得的 `Resources/Configure` 目錄內容，拖拉進步驟二的 `Resources/` 目錄之下；記得在對話方塊 **'Added folders :'** 要透過什麼方式增加這些內容的地方勾選 ***`Create folder references`***
  4. (把頭轉回去)參考上一節的設定 **簡單又快速的引用執行**
  5. 執行您專案的 `Rebuild` & `Run`

  > **注意事項：**
  > 本回合的引用範例，並沒有包含更新機制


## 進階版使用法 － ⋯ 師父領進門，造化看個人？

* ** 客製化 ** 自訂您的介面設定

  ````objective-c
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

  > **注意事項：**
  >
  > 1. 您可以在 `TDStickerLibraryCustomization.h` 裡找到關於這些可以自訂的相關設定
  >
  > 2. 您 *** <FONT COLOR="orange"> 必須 </FONT> *** 自行完成這些參數的設定：屬性名稱的前綴字為 *** <FONT COLOR="red"> sysStyle </FONT> *** 的變數；比方說，這一個變數 `sysStyleBundleName`
  >

* ** 取得貼紙資訊 ** 使用者點選後，取得貼紙的圖像資訊

  ````objective-c
  [controller                     setFinishedStickerLibraryCallbackBlock: ^(UIImage * stickerImage)
  {
      NSLog( @"sticker image : %@", stickerImage );
  }];
    ````


* ** 資料更新 **
  1. 在可用的伺服器上，設定與上傳您的相關設定檔案
  2. 取得該設定檔的 `URL address`
  3. 將該 `URL address` 設定至更新流程所使用的屬性上頭
  4. 範例參考

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

    > **注意事項：**
    >
    > 完成上面的更新程序的設定之後，請記得讓 **`TDStickerLibraryViewController`** 這個主要的元件控制器的客製化內容，與上述的內容保持一致。不然，您更新了 A ，卻一直要主體元件去抓 B 的資料，這樣倒是挺麻煩的 ⋯

    主體元件執行程序：

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

## 相關文件



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


## 特別感謝

* 引用的第三方函式庫 :

  * [ZipArchive][dependenceZipArchive]
  * [AFNetworking][dependenceAFNetworking]


* 範例內容的貼紙作者 :

  * [Oca Studios][Oca Studios]
  * [nicubunu][nicubunu]
  * [rg1024][rg1024]    
  * [gnokii][gnokii]    
  * [warszawianka][warszawianka]  


## 特別需求

由於個人的英文，並不是普通等級的弱點項目而已，是非常弱的弱的弱 ⋯ ⋯ ⋯

所以，如果您在解讀並理解了相對應的程序流程或內容，以致於發現個人使用的英文單字、詞彙或者是語法上的錯誤的，在您閒暇並且有意願的前提之下，請您不吝告知，或者依循 GitHub 的 叉它的(fork) 流程加以修正並通知在下，以便於其他可能或嘗試使用此函式庫的使用者，更容易上手。

以上，關於此 `特別需求`，在此先行感謝啦。


## Contribute

除了，上一回合的 `特別需求` 之外，暫時還沒有對此 `Contribute` 有太特殊的想法。

故，敬請期待，或者歡迎與個人討論 ~. ~

(coming soon ~. ~)


## 捐贈 ～  

歡迎贊助此函式庫的持續性的開發，或者是稍稍地打賞給 ~ 店小二 ~  


* ![donateWithPayPal][donateWithPayPal]
 * [新台幣 30 元][TWD 30] 一杯古早味紅茶
 * [新台幣 100 元][TWD 100] 一頓豐盛的雞腿便當
 * [新台幣 500 元][TWD 500] 不飢餓 72 小時
 * [新台幣 1000 元][TWD 1000] 平平安安地度過一週
 * [隨緣][other TWD] 隨喜 ～

* ** Bitcoin **
 * Bitcoin address `1GkUKb31JDwimpu2MJoQ1R7rjS8taX97aE`
 * [Bitcoin URI][donateBitcoinURI]


 *** <FONT COLOR="orange"> 除此之外 ～ </FONT> ***

* 也請您考慮將本來打算打賞給店小二的小費，轉贈予 `社會福利機構或團體`
 * [熊米屋愛心烘焙坊/社團法人基隆市智障者家長協會][Taiwan papid]
 * [財團法人綠色和平基金會][Taiwan Greenpeace Foundation]
 * [維基百科][wikipedia]
 * 各國的世界展望會，如[台灣世界展望會][Taiwan worldvision] 或者[香港世界宣明會][HongKong worldvision] 等等 ～
 * [台灣兒童暨家庭扶助基金會][Taiwan ccf]
 * [兒童福利聯盟文教基金會][Taiwan children]
 * [社團法人中華民國保護動物協會][Taiwan APA]
 * [財團法人流浪動物之家基金會][Taiwan hsapf]
 * [社團法人台灣黑熊保育協會][Taiwan Bear]
 * [台灣導盲犬協會][Taiwan guidedog]
 * 您的居住地附近的各種議題的社會福利機構

 上述主要是個人曾經關注過的單位或者機構，請您務必不侷限於此參考名單


在此感謝每一位贊助者

> 此轉捐贈概念是在玩 Arduino 期間，在網路上搜尋資料的過程，從某本電子書裡頭看到的發行理念。


## License

`TDStickerLibrary` is released under the [MIT License][mitLink]. See `LICENSE` for details.

> **Copyright &copy; 2015-Robin Hsu/Tech.D.Robin**

Please provide attribution, it is greatly appreciated.


----
[downloadLink]: https://github.com/TechD-Robin/TDStickerLibrary/archive/master.zip
[cocoaPodsLink]: https://cocoapods.org/
[OpenOfficeLink]: https://www.openoffice.org/

[dependenceTDResourceManager]: https://github.com/TechD-Robin/TDResourceManager
[dependenceTDDownloadManager]: https://github.com/TechD-Robin/TDDownloadManager
[dependenceTDFoundation]: https://github.com/TechD-Robin/TDFoundation
[dependenceUIKit+TechD]: https://github.com/TechD-Robin/UIKit-TechD
[dependenceTDMath]:https://github.com/TechD-Robin/TDMath

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

[TWD 30]:    https://www.paypal.com/cgi-bin/webscr?cmd=_s-xclick&hosted_button_id=HKTPTDXCSG5XU
[TWD 100]:   https://www.paypal.com/cgi-bin/webscr?cmd=_s-xclick&hosted_button_id=DNRR9B2MYEJKG
[TWD 500]:   https://www.paypal.com/cgi-bin/webscr?cmd=_s-xclick&hosted_button_id=NAG4NPVMGQCKQ
[TWD 1000]:  https://www.paypal.com/cgi-bin/webscr?cmd=_s-xclick&hosted_button_id=GP8S422D6HSAE
[other TWD]: https://www.paypal.com/cgi-bin/webscr?cmd=_s-xclick&hosted_button_id=VX3STCMKJWHKJ

[Taiwan papid]: http://papid.com.tw/
[Taiwan Greenpeace Foundation]: http://www.greenpeace.org/taiwan/zh/
[wikipedia]: https://www.wikimedia.org/
[Taiwan worldvision]: http://www.worldvision.org.tw/
[HongKong worldvision]: http://www.worldvision.org.hk/
[Taiwan ccf]:http://www.ccf.org.tw/
[Taiwan children]: http://www.children.org.tw/
[Taiwan hsapf]: http://www.hsapf.org.tw/
[Taiwan APA]: http://www.apatw.org/
[Taiwan Bear]: http://www.taiwanbear.org.tw/
[Taiwan guidedog]: http://www.guidedog.org.tw/

[programmer magazine]: http://programmermagazine.github.io/home/
[ccckmit]: http://ccckmit.wikidot.com/

[donateBitcoinURI]: bitcoin:1GkUKb31JDwimpu2MJoQ1R7rjS8taX97aE?label=GitHub%2C%20donate&message=Receive%20from%20GitHub%20TDSticker%20Library%27s%20donator%20

[mitLink]:http://opensource.org/licenses/MIT
