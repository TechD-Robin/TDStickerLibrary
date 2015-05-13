//
//  UIDevice+TechD.h
//  UIKit+TechD
//
//  Created by Robin Hsu on 2015/4/30.
//  Copyright (c) 2015年 TechD. All rights reserved.
//
//  ------------------------------------------------------------------------------------------------
//  ------------------------------------------------------------------------------------------------

#import <Foundation/Foundation.h>
#import <Availability.h>

#import <UIKit/UIKit.h>

//  ------------------------------------------------------------------------------------------------
//  ------------------------------------------------------------------------------------------------
//  reference code :
//
//  https://github.com/erica/uidevice-extension/blob/master/UIDevice-Hardware.h
//  https://github.com/erica/uidevice-extension/blob/master/UIDevice-Hardware.m
//
//  ------------------------------------------------------------------------------------------------
//  * notice :
//  refer to above URL's code and others at internet ...
//  Because these code always get the device's platform name is 'simulator' during the development, that target device is selected simulator.
//
//  You can use below define 'ENFORCED_SIMULATOR_TO_SIMULATE_IDEVICE' or comment it to  enforce on these method's to get information of simulator currently.
//
//  * this define just effect on the 'DEBUG' and 'TARGET_IPHONE_SIMULATOR' have be defined.
//  That's mean when environment is 'release' or 'target is iDevice', this define hasn't any effect.
//  For this defined, you can find these string from the implementation file.
//
//  * And you must update manual these information when Apple Inc. release new device if you need it.
//
//  ※ 注意事項 :
//  因為參考過上面那個網址的 device platform 取得方式, 還有網路其他地方的資訊之後 ( 像是使用 define macro 的方式, 然後透過檢查裝置的寬或高的 points 值來進行判斷 );
//  比方 IS_IPHONE_5 ( height == 568.0 ) or IS_IPHONE_6_PLUS ( height == 736.0 ) 的方式, 這在現階段 iDevice 還沒有越來越多的狀況下(已經慢慢變多了),
//  這種透過檢查寬或高的方式暫時還是不會有問題的; 只不過若是之後很不幸的 Apple 若真的釋出了寬或高其中一項相同螢幕解析度重複為兩樣時, 這種判斷方式, 應該就 Game Over 了.
//  比方 iPhone6 ( W:H = 376:667), 未來如果有個 Apple X ( W:H = XXX:667 ), 這樣 ... 這個 667 就無法用來確定是哪個裝置的解析度了. =..="
//
//  再者, 上面這個 URL 裡頭的 Code 提供的解法, 其實已經可以解決上面這一個問題了, 只不過 ... 非常可惜的是裏頭的寫法, 如果遇到使用的裝置是 '模擬器' 進行 iDevice 模擬的開發階段的時候,
//  它也只會一直告訴想要它的資訊的開發人員說 '我是模擬器'; 如果變成是這樣子的話, 那就代表這個寫法如果 '沒有實裝進實機' 裡頭的時候, 仍然是無用武之地的;
//  可是, 在很多種狀況下, 並不是都有實機可以拿來裝著玩的, 這樣的這個判斷方式就差那麼一小步就可以順利拿來用在 '模擬器開發階段' 了啊 ~
//  於是, 個人就用本來的寫法替它加掛這個 define 值, 讓它在有效值的狀況之下可以 '強制在模擬器開發階段時', 用相同的方式, 就能取得對應的裝置資訊;
//  而若是在非 DEBUG, 或者是實機的狀態下, 就運行本來的流程.
//
//  ※ 'ENFORCED_SIMULATOR_TO_SIMULATE_IDEVICE' 必須是在 'DEBUG' 和 'TARGET_IPHONE_SIMULATOR' 也被設定的狀況下才會有效;
//  也就是說, 在被設定為 'RELEASE' 或者是 '非模擬器' 的狀態下, 這個設定值就無效化了.
//  要了解這個 define 可以使用哪些設定值, 就請直接查看 .m 檔裡頭的程式碼.
//
//  ※ 如果後續 Apple 有正式推出新的 iDevice 的時候, 又剛好是需要用到的裝置時, 即請務必記得回來增加設定到這個 .m 檔裡頭.
//
#define ENFORCED_SIMULATOR_TO_SIMULATE_IDEVICE      "iPhone7,1"


//  ------------------------------------------------------------------------------------------------
#pragma mark declare enumeration.
//  ------------------------------------------------------------------------------------------------
/**
 *  enumeration for family(serials) of device platform
 */
typedef NS_ENUM( NSInteger, UIDevicePlatformFamily ){
    /**
     *  unknown's platform
     */
    UIDevicePlatformFamilyUnknown                   = -1,
    /**
     *  platform is simulator.
     */
    UIDevicePlatformFamilySimulator                 = 0,
    /**
     *  platform is iPhone serials.
     */
    UIDevicePlatformFamilyiPhone,
    /**
     *  platform is iPod serials.
     */
    UIDevicePlatformFamilyiPod,
    /**
     *  platform is iPad serials.
     */
    UIDevicePlatformFamilyiPad,
    /**
     *  platform is Apple TV serials.
     */
    UIDevicePlatformFamilyAppleTV,
    /**
     *  platform is Apple Watch serials.
     */
    UIDevicePlatformFamilyAppleWatch,
};


//  ------------------------------------------------------------------------------------------------
//  ------------------------------------------------------------------------------------------------
@interface UIDevice (TechD)

//  ------------------------------------------------------------------------------------------------
#pragma mark declare for get device's platform.
//  ------------------------------------------------------------------------------------------------
/**
 *  @brief check the device's platform which is simulator or not.
 *  check the device's platform which is simulator or not.
 *
 *  @return YES|NO                  platform is simulator or not.
 */
+ ( BOOL ) isSimulator;

//  ------------------------------------------------------------------------------------------------
/**
 *  @brief check the device's platform which is iPhone 4 serials or not.
 *  check the device's platform which is iPhone 4 serials or not.
 *
 *  @return YES|NO                  platform is iPhone 4 serials or not.
 */
+ ( BOOL ) isIPhone4Serials;

//  ------------------------------------------------------------------------------------------------
/**
 *  @brief check the device's platform which is iPhone 5 serials or not.
 *  check the device's platform which is iPhone 5 serials or not.
 *
 *  @return YES|NO                  platform is iPhone 5 serials or not.
 */
+ ( BOOL ) isIPhone5Serials;

//  ------------------------------------------------------------------------------------------------
/**
 *  @brief check the device's platform which is iPhone 6 serials or not.
 *  check the device's platform which is iPhone 6 serials or not.
 *
 *  @return YES|NO                  platform is iPhone 6 serials or not.
 */
+ ( BOOL ) isIPhone6;

//  ------------------------------------------------------------------------------------------------
/**
 *  @brief check the device's platform which is iPhone 6 + serials or not.
 *  check the device's platform which is iPhone 6 + serials or not.
 *
 *  @return YES|NO                  platform is iPhone 6 + serials or not.
 */
+ ( BOOL ) isIPhone6Plus;

//  ------------------------------------------------------------------------------------------------
/**
 *  @brief get name of the device platform.
 *  get name of the device platform
 *
 *  @return string|nil              name of the device platform or nil.
 */
+ ( NSString * ) devicePlatform;

//  ------------------------------------------------------------------------------------------------
/**
 *  @brief get physical pixels of the device platform.
 *  get physical pixels of the device platform.
 *
 *  @return size|ZeroSize           physical pixels or ZeroSize.
 */
+ ( CGSize ) devicePhysicalPixels;

//  ------------------------------------------------------------------------------------------------
/**
 *  @brief get rendered pixels of the device platform.
 *  get rendered pixels of the device platform. (scale * bounds.size. ( iOS points type to device pixels ))
 *
 *  @return size|ZeroSize           rendered pixels or ZeroSize.
 */
+ ( CGSize ) deviceRenderedPixels;

//  ------------------------------------------------------------------------------------------------
/**
 *  @brief calculate aspect ratio of physical pixels of the device platform.
 *  calculate aspect ratio of physical pixels of the device platform. (ratio :( height/width ))
 *
 *  @return value| 0                calculated value for aspect ratio or 0.
 */
+ ( CGFloat ) devicePhysicalAspectRatio;

//  ------------------------------------------------------------------------------------------------
/**
 *  @brief calculate aspect ratio of rendered pixels of the device platform.
 *  calculate aspect ratio of rendered pixels of the device platform. (ratio :( height/width ))
 *
 *  @return value| 0                calculated value for aspect ratio or 0.
 */
+ ( CGFloat ) deviceRenderedAspectRatio;

//  ------------------------------------------------------------------------------------------------
/**
 *  @brief get family type(serials) of the device platform.
 *  get family type(serials) of the device platform.
 *
 *  @return                         family type of the device platform.
 */
+ ( UIDevicePlatformFamily ) devicePlatformFamily;

//  ------------------------------------------------------------------------------------------------
/**
 *  @brief get list of name of all device platforms known.
 *  get list of name of all device platforms known. ( that's mean register into this class's information container by developer manual )
 *
 *  @return list|nil                name' list or nil.
 */
+ ( NSArray * ) knownDevicePlatforms;

#ifdef DEBUG
//  ------------------------------------------------------------------------------------------------
/**
 *  @brief get list of identifier of all device platforms known.
 *  get list of identifier of all device platforms known. ( that's mean register into this class's information container by developer manual )
 *
 *  @return list|nil                identifier's list or nil.
 */
+ ( NSArray * ) knownDeviceIdentifiers;

#endif  //  End of  DEBUG.


//  ------------------------------------------------------------------------------------------------
#pragma mark declare for get device's hardware's information.
//  ------------------------------------------------------------------------------------------------
/**
 *  @brief get model's name of the device hardware.
 *  get model's name of the device hardware.
 *
 *  @return string|nil              model's name or nil.
 */
+ ( NSString * ) hwModel;

//  ------------------------------------------------------------------------------------------------
/**
 *  @brief get machine's name of the device hardware.
 *  get machine's name of the device hardware.
 *
 *  @return string|nil              machine's name or nil.
 */
+ ( NSString * ) hwMachine;

//  ------------------------------------------------------------------------------------------------
//  ------------------------------------------------------------------------------------------------


@end

//  ------------------------------------------------------------------------------------------------
//  ------------------------------------------------------------------------------------------------
