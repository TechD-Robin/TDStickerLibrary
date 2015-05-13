//
//  UIDevice+TechD.m
//  UIKit+TechD
//
//  Created by Robin Hsu on 2015/4/30.
//  Copyright (c) 2015年 TechD. All rights reserved.
//
//  ------------------------------------------------------------------------------------------------
//  ------------------------------------------------------------------------------------------------

#import "UIDevice+TechD.h"

#import <sys/sysctl.h>

//  ------------------------------------------------------------------------------------------------
#pragma mark define constant string.
//  ------------------------------------------------------------------------------------------------
static  char      * const UIDevice_TechDHWInfoKeyHWModel            = "hw.model";
static  char      * const UIDevice_TechDHWInfoKeyHWMachine          = "hw.machine";

static  NSString  * const UIDevice_TechDHWInfoKeyModelName          = @"Model Name";
static  NSString  * const UIDevice_TechDHWInfoKeyPhysicalPixels     = @"Physical Pixels";

static  NSString  * const UIDevice_TechDHWInfoKeyModeliPhone4Serials= @"iPhone 4";
static  NSString  * const UIDevice_TechDHWInfoKeyModeliPhone5Serials= @"iPhone 5";
static  NSString  * const UIDevice_TechDHWInfoKeyModeliPhone6       = @"iPhone 6";
static  NSString  * const UIDevice_TechDHWInfoKeyModeliPhone6Plus   = @"iPhone 6 Plus";

static  NSString  * const UIDevice_TechDHWInfoKeyFamilySimulator    = @"Simulator";
static  NSString  * const UIDevice_TechDHWInfoKeyFamilyiPhone       = @"iPhone";
static  NSString  * const UIDevice_TechDHWInfoKeyFamilyiPod         = @"iPod";
static  NSString  * const UIDevice_TechDHWInfoKeyFamilyiPad         = @"iPad";
static  NSString  * const UIDevice_TechDHWInfoKeyFamilyAppleTV      = @"Apple TV";
static  NSString  * const UIDevice_TechDHWInfoKeyFamilyAppleWatch   = @"Apple Watch";

static  NSString  * const UIDevice_TechDHWInfoKeySimulatorX86       = @"i386";
static  NSString  * const UIDevice_TechDHWInfoKeySimulatorX64       = @"x86_64";

//  ------------------------------------------------------------------------------------------------
//  ------------------------------------------------------------------------------------------------
#pragma mark -
#pragma mark class UIDevice


//  ------------------------------------------------------------------------------------------------
//  ------------------------------------------------------------------------------------------------
#pragma mark -
#pragma mark declare private category (Private)
//  ------------------------------------------------------------------------------------------------
@interface UIDevice (Private)

//  ------------------------------------------------------------------------------------------------
#pragma mark declare for platform's container.
//  ------------------------------------------------------------------------------------------------
/**
 *  @brief register all known device information into the container and return it.
 *  register all known device information into the container and return it.
 *
 *  @return container|nil           the container or nil.
 */
+ ( NSDictionary * ) _DeviceHardwareInformation;

//  ------------------------------------------------------------------------------------------------
/**
 *  @brief get a device information by identifier.
 *  get a device information by identifier.
 *
 *  @param deviceIdentifier         a device's key.
 *
 *  @return container|nil           the container of device information or nil.
 */
+ ( NSDictionary * ) _GetDeviceHardwareInformationByIdentifier:(NSString *)deviceIdentifier;

//  ------------------------------------------------------------------------------------------------
/**
 *  @brief get the device information.
 *  get the device information.
 *
 *  @return container|nil           the container of device information or nil.
 */
+ ( NSDictionary * ) _GetDeviceHardwareInformation;

//  ------------------------------------------------------------------------------------------------
#pragma mark declare for get device's hardware's information.
//  ------------------------------------------------------------------------------------------------
/**
 *  @brief get a system information by name.
 *  get a system information by name.
 *
 *  @param levelIdentifier          a information's key.
 *
 *  @return string|nil              the information's string or nil.
 */
+ ( NSString * ) _GetSysInfoByName:(char *)levelIdentifier;

//  ------------------------------------------------------------------------------------------------

@end


//  ------------------------------------------------------------------------------------------------
//  ------------------------------------------------------------------------------------------------


//  ------------------------------------------------------------------------------------------------
//  ------------------------------------------------------------------------------------------------
#pragma mark -
#pragma mark implementation private category (Private)
//  ------------------------------------------------------------------------------------------------
@implementation UIDevice (Private)

//  ------------------------------------------------------------------------------------------------
//  ------------------------------------------------------------------------------------------------
#pragma mark method for platform's container.
//  ------------------------------------------------------------------------------------------------
//  reference data :
//
//  http://theiphonewiki.com/wiki/Models
//  http://www.everyi.com/by-identifier/ipod-iphone-ipad-specs-by-model-identifier.html
//
//  ------------------------------------------------------------------------------------------------
//  { aKey: { model name, physical pixels, asset scale } }
+ ( NSDictionary * ) _DeviceHardwareInformation
{
    static NSDictionary           * _hardwareInformation = nil;
    static dispatch_once_t          oneToken;
    dispatch_once( &oneToken, ^
    {
        _hardwareInformation        = @{
                                        @"iPhone1,1" : @{
                                                UIDevice_TechDHWInfoKeyModelName :         @"iPhone",
                                                UIDevice_TechDHWInfoKeyPhysicalPixels :    @"{ 320, 480 }",
                                                @"Asset Scale": @(1) },
                                        
                                        @"iPhone1,2" : @{
                                                UIDevice_TechDHWInfoKeyModelName :         @"iPhone 3G",
                                                UIDevice_TechDHWInfoKeyPhysicalPixels :    @"{ 320, 480 }",
                                                @"Asset Scale": @(1) },
                                        
                                        @"iPhone2,1" : @{
                                                UIDevice_TechDHWInfoKeyModelName :         @"iPhone 3GS",
                                                UIDevice_TechDHWInfoKeyPhysicalPixels :    @"{ 320, 480 }",
                                                @"Asset Scale": @(1) },
                                        
                                        @"iPhone3,1" : @{
                                                UIDevice_TechDHWInfoKeyModelName :         @"iPhone 4",
                                                UIDevice_TechDHWInfoKeyPhysicalPixels :    @"{ 640, 960 }",
                                                @"Asset Scale": @(2) },
                                        @"iPhone3,2" : @{
                                                UIDevice_TechDHWInfoKeyModelName :         @"iPhone 4",
                                                UIDevice_TechDHWInfoKeyPhysicalPixels :    @"{ 640, 960 }",
                                                @"Asset Scale": @(2) },
                                        @"iPhone3,3" : @{
                                                UIDevice_TechDHWInfoKeyModelName :         @"iPhone 4 (Verizon)",
                                                UIDevice_TechDHWInfoKeyPhysicalPixels :    @"{ 640, 960 }",
                                                @"Asset Scale": @(2) },
                                        
                                        @"iPhone4,1" : @{
                                                UIDevice_TechDHWInfoKeyModelName :         @"iPhone 4S",
                                                UIDevice_TechDHWInfoKeyPhysicalPixels :    @"{ 640, 960 }",
                                                @"Asset Scale": @(2) },
                                        
                                        @"iPhone5,1" : @{
                                                UIDevice_TechDHWInfoKeyModelName :         @"iPhone 5 (GSM)",
                                                UIDevice_TechDHWInfoKeyPhysicalPixels :    @"{ 640, 1136 }",
                                                @"Asset Scale": @(2) },
                                        @"iPhone5,2" : @{
                                                UIDevice_TechDHWInfoKeyModelName :         @"iPhone 5 (GSM+CDMA)",
                                                UIDevice_TechDHWInfoKeyPhysicalPixels :    @"{ 640, 1136 }",
                                                @"Asset Scale": @(2) },
                                        @"iPhone5,3" : @{
                                                UIDevice_TechDHWInfoKeyModelName :         @"iPhone 5C (GSM)",
                                                UIDevice_TechDHWInfoKeyPhysicalPixels :    @"{ 640, 1136 }",
                                                @"Asset Scale": @(2) },
                                        @"iPhone5,4" : @{
                                                UIDevice_TechDHWInfoKeyModelName :         @"iPhone 5C (GSM+CDMA)",
                                                UIDevice_TechDHWInfoKeyPhysicalPixels :    @"{ 640, 1136 }",
                                                @"Asset Scale": @(2) },
                                        
                                        @"iPhone6,1" : @{
                                                UIDevice_TechDHWInfoKeyModelName :         @"iPhone 5S (GSM)",
                                                UIDevice_TechDHWInfoKeyPhysicalPixels :    @"{ 640, 1136 }",
                                                @"Asset Scale": @(2) },
                                        @"iPhone6,2" : @{
                                                UIDevice_TechDHWInfoKeyModelName :         @"iPhone 5S (GSM+CDMA)",
                                                UIDevice_TechDHWInfoKeyPhysicalPixels :    @"{ 640, 1136 }",
                                                @"Asset Scale": @(2) },
                                        
                                        @"iPhone7,1" : @{
                                                UIDevice_TechDHWInfoKeyModelName :         UIDevice_TechDHWInfoKeyModeliPhone6Plus,
                                                UIDevice_TechDHWInfoKeyPhysicalPixels :    @"{ 1080, 1920 }",
                                                @"Asset Scale": @(3) },
                                        @"iPhone7,2" : @{
                                                UIDevice_TechDHWInfoKeyModelName :         UIDevice_TechDHWInfoKeyModeliPhone6,
                                                UIDevice_TechDHWInfoKeyPhysicalPixels :    @"{ 750, 1334 }",
                                                @"Asset Scale": @(2) },
                                        
                                        //@"iPhone7,1" : @{ @"Show String": @"iPhone 6 (GSM)",            @"Asset Scale": @(2) },
                                        //@"iPhone7,2" : @{ @"Show String": @"iPhone 6 (GSM+CDMA)",       @"Asset Scale": @(2) },
                                        
                                        //@"iPhone8,1" : @{ @"Show String": @"iPhone 6 Plus (GSM)",       @"Asset Scale": @(3) },
                                        //@"iPhone8,2" : @{ @"Show String": @"iPhone 6 Plus (Global)",    @"Asset Scale": @(3) },
                                        
                                        //  iPod
                                        @"iPod1,1" : @{
                                                UIDevice_TechDHWInfoKeyModelName :         @"iPod Touch 1G",
                                                UIDevice_TechDHWInfoKeyPhysicalPixels :    @"{ 320, 480 }",
                                                @"Asset Scale": @(1) },
                                        @"iPod2,1" : @{
                                                UIDevice_TechDHWInfoKeyModelName :         @"iPod Touch 2G",
                                                UIDevice_TechDHWInfoKeyPhysicalPixels :    @"{ 320, 480 }",
                                                @"Asset Scale": @(1) },
                                        @"iPod3,1" : @{
                                                UIDevice_TechDHWInfoKeyModelName :         @"iPod Touch 3G",
                                                UIDevice_TechDHWInfoKeyPhysicalPixels :    @"{ 320, 480 }",
                                                @"Asset Scale": @(1) },
                                        @"iPod4,1" : @{
                                                UIDevice_TechDHWInfoKeyModelName :         @"iPod Touch 4G",
                                                UIDevice_TechDHWInfoKeyPhysicalPixels :    @"{ 640, 960 }",
                                                @"Asset Scale": @(2) },
                                        @"iPod5,1" : @{
                                                UIDevice_TechDHWInfoKeyModelName :         @"iPod Touch 5G",
                                                UIDevice_TechDHWInfoKeyPhysicalPixels :    @"{ 640, 1136 }",
                                                @"Asset Scale": @(2) },
                                        
                                        //  iPad
                                        @"iPad1,1" : @{
                                                UIDevice_TechDHWInfoKeyModelName :         @"iPad",
                                                UIDevice_TechDHWInfoKeyPhysicalPixels :    @"{ 768, 1024 }",
                                                @"Asset Scale": @(1) },
                                        
                                        @"iPad2,1" : @{
                                                UIDevice_TechDHWInfoKeyModelName :         @"iPad 2 (WiFi)",
                                                UIDevice_TechDHWInfoKeyPhysicalPixels :    @"{ 768, 1024 }",
                                                @"Asset Scale": @(1) },
                                        @"iPad2,2" : @{
                                                UIDevice_TechDHWInfoKeyModelName :         @"iPad 2 (GSM)",
                                                UIDevice_TechDHWInfoKeyPhysicalPixels :    @"{ 768, 1024 }",
                                                @"Asset Scale": @(1) },
                                        @"iPad2,3" : @{
                                                UIDevice_TechDHWInfoKeyModelName :         @"iPad 2 (CDMA)",
                                                UIDevice_TechDHWInfoKeyPhysicalPixels :    @"{ 768, 1024 }",
                                                @"Asset Scale": @(1) },
                                        @"iPad2,4" : @{
                                                UIDevice_TechDHWInfoKeyModelName :         @"iPad 2 (WiFi)",
                                                UIDevice_TechDHWInfoKeyPhysicalPixels :    @"{ 768, 1024 }",
                                                @"Asset Scale": @(1) },
                                        @"iPad2,5" : @{
                                                UIDevice_TechDHWInfoKeyModelName :         @"iPad Mini 1G (WiFi)",
                                                UIDevice_TechDHWInfoKeyPhysicalPixels :    @"{ 768, 1024 }",
                                                @"Asset Scale": @(1) },
                                        @"iPad2,6" : @{
                                                UIDevice_TechDHWInfoKeyModelName :         @"iPad Mini 1G (GSM)",
                                                UIDevice_TechDHWInfoKeyPhysicalPixels :    @"{ 768, 1024 }",
                                                @"Asset Scale": @(1) },
                                        @"iPad2,7" : @{
                                                UIDevice_TechDHWInfoKeyModelName :         @"iPad Mini 1G (GSM+CDMA)",
                                                UIDevice_TechDHWInfoKeyPhysicalPixels :    @"{ 768, 1024 }",
                                                @"Asset Scale": @(1) },
                                        
                                        @"iPad3,1" : @{
                                                UIDevice_TechDHWInfoKeyModelName :         @"iPad 3 (WiFi)",
                                                UIDevice_TechDHWInfoKeyPhysicalPixels :    @"{ 1536, 2048 }",
                                                @"Asset Scale": @(2) },
                                        @"iPad3,2" : @{
                                                UIDevice_TechDHWInfoKeyModelName :         @"iPad 3 (GSM+CDMA)",
                                                UIDevice_TechDHWInfoKeyPhysicalPixels :    @"{ 1536, 2048 }",
                                                @"Asset Scale": @(2) },
                                        @"iPad3,3" : @{
                                                UIDevice_TechDHWInfoKeyModelName :         @"iPad 3 (GSM)",
                                                UIDevice_TechDHWInfoKeyPhysicalPixels :    @"{ 1536, 2048 }",
                                                @"Asset Scale": @(2) },
                                        @"iPad3,4" : @{
                                                UIDevice_TechDHWInfoKeyModelName :         @"iPad 4 (WiFi)",
                                                UIDevice_TechDHWInfoKeyPhysicalPixels :    @"{ 1536, 2048 }",
                                                @"Asset Scale": @(2) },
                                        @"iPad3,5" : @{
                                                UIDevice_TechDHWInfoKeyModelName :         @"iPad 4 (GSM)",
                                                UIDevice_TechDHWInfoKeyPhysicalPixels :    @"{ 1536, 2048 }",
                                                @"Asset Scale": @(2) },
                                        @"iPad3,6" : @{
                                                UIDevice_TechDHWInfoKeyModelName :         @"iPad 4 (GSM+CDMA)",
                                                UIDevice_TechDHWInfoKeyPhysicalPixels :    @"{ 1536, 2048 }",
                                                @"Asset Scale": @(2) },
                                        
                                        @"iPad4,1" : @{
                                                UIDevice_TechDHWInfoKeyModelName :         @"iPad Air (WiFi)",
                                                UIDevice_TechDHWInfoKeyPhysicalPixels :    @"{ 1536, 2048 }",
                                                @"Asset Scale": @(2) },
                                        @"iPad4,2" : @{
                                                UIDevice_TechDHWInfoKeyModelName :         @"iPad Air (Cellular)",
                                                UIDevice_TechDHWInfoKeyPhysicalPixels :    @"{ 1536, 2048 }",
                                                @"Asset Scale": @(2) },
                                        @"iPad4,3" : @{
                                                UIDevice_TechDHWInfoKeyModelName :         @"iPad Air",
                                                UIDevice_TechDHWInfoKeyPhysicalPixels :    @"{ 1536, 2048 }",
                                                @"Asset Scale": @(2) },
                                        @"iPad4,4" : @{
                                                UIDevice_TechDHWInfoKeyModelName :         @"iPad Mini 2 (WiFi)",
                                                UIDevice_TechDHWInfoKeyPhysicalPixels :    @"{ 1536, 2048 }",
                                                @"Asset Scale": @(2) },
                                        @"iPad4,5" : @{
                                                UIDevice_TechDHWInfoKeyModelName :         @"iPad Mini 2 (Cellular)",
                                                UIDevice_TechDHWInfoKeyPhysicalPixels :    @"{ 1536, 2048 }",
                                                @"Asset Scale": @(2) },
                                        @"iPad4,6" : @{
                                                UIDevice_TechDHWInfoKeyModelName :         @"iPad Mini 2",
                                                UIDevice_TechDHWInfoKeyPhysicalPixels :    @"{ 1536, 2048 }",
                                                @"Asset Scale": @(2) },
                                        
                                        @"iPad4,7" : @{
                                                UIDevice_TechDHWInfoKeyModelName :         @"iPad Mini 3 (WiFi)",
                                                UIDevice_TechDHWInfoKeyPhysicalPixels :    @"{ 1536, 2048 }",
                                                @"Asset Scale": @(2) },
                                        @"iPad4,8" : @{
                                                UIDevice_TechDHWInfoKeyModelName :         @"iPad Mini 3 (Cellular)",
                                                UIDevice_TechDHWInfoKeyPhysicalPixels :    @"{ 1536, 2048 }",
                                                @"Asset Scale": @(2) },
                                        @"iPad4,9" : @{
                                                UIDevice_TechDHWInfoKeyModelName :         @"iPad Mini 3",
                                                UIDevice_TechDHWInfoKeyPhysicalPixels :    @"{ 1536, 2048 }",
                                                @"Asset Scale": @(2) },
                                        
                                        @"iPad5,3" : @{
                                                UIDevice_TechDHWInfoKeyModelName :         @"iPad Air 2 (WiFi)",
                                                UIDevice_TechDHWInfoKeyPhysicalPixels :    @"{ 1536, 2048 }",
                                                @"Asset Scale": @(2) },
                                        @"iPad5,4" : @{
                                                UIDevice_TechDHWInfoKeyModelName :         @"iPad Air 2 (Cellular)",
                                                UIDevice_TechDHWInfoKeyPhysicalPixels :    @"{ 1536, 2048 }",
                                                @"Asset Scale": @(2) },
                                        
                                        
                                        //  Appple TV ...
                                        @"AppleTV2,1" : @{
                                                UIDevice_TechDHWInfoKeyModelName :         @"Apple TV 2G",
                                                UIDevice_TechDHWInfoKeyPhysicalPixels :     [NSNull null],
                                                @"Asset Scale": @(2) },
                                        
                                        @"AppleTV3,1" : @{
                                                UIDevice_TechDHWInfoKeyModelName :         @"Apple TV 3G",
                                                UIDevice_TechDHWInfoKeyPhysicalPixels :     [NSNull null],
                                                @"Asset Scale": @(2) },
                                        @"AppleTV3,2" : @{
                                                UIDevice_TechDHWInfoKeyModelName :         @"Apple TV 3G Rev A",
                                                UIDevice_TechDHWInfoKeyPhysicalPixels :     [NSNull null],
                                                @"Asset Scale": @(2) },
                                        
                                        //  Apple Watch
                                        @"Watch1,1" : @{
                                                UIDevice_TechDHWInfoKeyModelName :         @"Apple Watch",
                                                UIDevice_TechDHWInfoKeyPhysicalPixels :     [NSNull null],
                                                @"Asset Scale": @(2) },
                                        @"Watch1,2" : @{
                                                UIDevice_TechDHWInfoKeyModelName :         @"Apple Watch",
                                                UIDevice_TechDHWInfoKeyPhysicalPixels :     [NSNull null],
                                                @"Asset Scale": @(2) },
                                        
                                        
                                        //  simulator.
                                        UIDevice_TechDHWInfoKeySimulatorX86 : @{
                                                UIDevice_TechDHWInfoKeyModelName :         @"Simulator",
                                                UIDevice_TechDHWInfoKeyPhysicalPixels :     NSStringFromCGSize( [[UIScreen mainScreen] bounds].size ),
                                                @"Asset Scale": @(2) },
                                        UIDevice_TechDHWInfoKeySimulatorX64 : @{
                                                UIDevice_TechDHWInfoKeyModelName :         @"Simulator",
                                                UIDevice_TechDHWInfoKeyPhysicalPixels :     NSStringFromCGSize( [[UIScreen mainScreen] bounds].size ),
                                                @"Asset Scale": @(2) }
                                        };
        
    });     //  End of dispatch_once.
    return _hardwareInformation;
}

//  ------------------------------------------------------------------------------------------------
+ ( NSDictionary * ) _GetDeviceHardwareInformationByIdentifier:(NSString *)deviceIdentifier
{
    return [[[self class] _DeviceHardwareInformation] objectForKey: deviceIdentifier];
}

//  ------------------------------------------------------------------------------------------------
+ ( NSDictionary * ) _GetDeviceHardwareInformation
{
    return [[self class] _GetDeviceHardwareInformationByIdentifier: [[self class] _GetSysInfoByName: UIDevice_TechDHWInfoKeyHWMachine]];
}

//  ------------------------------------------------------------------------------------------------
#pragma mark method for get device's hardware's information.
//  ------------------------------------------------------------------------------------------------
+ ( NSString * ) _GetSysInfoByName:(char *)levelIdentifier
{
    NSParameterAssert( NULL != levelIdentifier );
    
    size_t                          size;
    char                          * answer;
    NSString                      * result;
    
    answer                          = NULL;
    sysctlbyname(levelIdentifier, NULL, &size, NULL, 0);
    
    answer                          = (char *)malloc( size );
    sysctlbyname(levelIdentifier, answer, &size, NULL, 0);
    
    result                          = [NSString stringWithCString:answer encoding: NSUTF8StringEncoding];
    free(answer);
    
    //  special mechanism for simulator    
#if defined( DEBUG ) && defined( TARGET_IPHONE_SIMULATOR ) && defined( ENFORCED_SIMULATOR_TO_SIMULATE_IDEVICE )
    if ( strcmp( levelIdentifier, UIDevice_TechDHWInfoKeyHWMachine ) != 0 )
    {
        return result;
    }
    if ( ( [result isEqualToString: UIDevice_TechDHWInfoKeySimulatorX86] == NO ) && ( [result isEqualToString: UIDevice_TechDHWInfoKeySimulatorX64] == NO ) )
    {
        return result;
    }
    
    return @(ENFORCED_SIMULATOR_TO_SIMULATE_IDEVICE);
#endif
    
    
    return result;
}

//  ------------------------------------------------------------------------------------------------
//  ------------------------------------------------------------------------------------------------

@end

//  ------------------------------------------------------------------------------------------------
//  ------------------------------------------------------------------------------------------------


@implementation UIDevice (TechD)

//  ------------------------------------------------------------------------------------------------
#pragma mark method for get device's platform.
//  ------------------------------------------------------------------------------------------------
+ ( BOOL ) isSimulator
{
    NSString                      * model;
    
    model                           = [[UIDevice currentDevice] model];
    NSParameterAssert( nil != model );
    return [model hasSuffix: @"Simulator"];
}

//  ------------------------------------------------------------------------------------------------
+ ( BOOL ) isIPhone4Serials
{
    NSString                      * devicePlatform;
    
    devicePlatform                  = [[self class] devicePlatform];
    NSParameterAssert( nil != devicePlatform );
    return [devicePlatform hasPrefix: UIDevice_TechDHWInfoKeyModeliPhone4Serials];
}

//  ------------------------------------------------------------------------------------------------
+ ( BOOL ) isIPhone5Serials
{
    NSString                      * devicePlatform;
    
    devicePlatform                  = [[self class] devicePlatform];
    NSParameterAssert( nil != devicePlatform );
    return [devicePlatform hasPrefix: UIDevice_TechDHWInfoKeyModeliPhone5Serials];
}

//  ------------------------------------------------------------------------------------------------
+ ( BOOL ) isIPhone6
{
    NSString                      * devicePlatform;
    
    devicePlatform                  = [[self class] devicePlatform];
    NSParameterAssert( nil != devicePlatform );
    return [devicePlatform isEqualToString: UIDevice_TechDHWInfoKeyModeliPhone6];
}

//  ------------------------------------------------------------------------------------------------
+ ( BOOL ) isIPhone6Plus
{
    NSString                      * devicePlatform;
    
    devicePlatform                  = [[self class] devicePlatform];
    NSParameterAssert( nil != devicePlatform );
    return [devicePlatform isEqualToString: UIDevice_TechDHWInfoKeyModeliPhone6Plus];
}

//  ------------------------------------------------------------------------------------------------
+ ( NSString * ) devicePlatform
{
    NSDictionary                  * hardwareInfo;
    
    hardwareInfo                    = [[self class] _GetDeviceHardwareInformation];
    if ( nil == hardwareInfo )
    {
        return nil;
    }
    return [hardwareInfo objectForKey: UIDevice_TechDHWInfoKeyModelName];
}

//  ------------------------------------------------------------------------------------------------
+ ( CGSize ) devicePhysicalPixels
{
    NSString                      * physicalPixels;
    NSDictionary                  * hardwareInfo;

    physicalPixels                  = nil;
    hardwareInfo                    = [[self class] _GetDeviceHardwareInformation];
    if ( nil == hardwareInfo )
    {
        return CGSizeZero;
    }
    
    physicalPixels                  = [hardwareInfo objectForKey: UIDevice_TechDHWInfoKeyPhysicalPixels];
    if ( nil == physicalPixels )
    {
        return CGSizeZero;
    }
    return CGSizeFromString( physicalPixels );
}

//  ------------------------------------------------------------------------------------------------
+ ( CGSize ) deviceRenderedPixels
{
    CGFloat                         assetScale;
    CGSize                          canvasSize;
    
    assetScale                      = [UIScreen mainScreen].scale;
    canvasSize                      = [[UIScreen mainScreen] bounds].size;
    return CGSizeMake( ( assetScale * canvasSize.width ), ( assetScale * canvasSize.height ) );
}

//  ------------------------------------------------------------------------------------------------
+ ( CGFloat ) devicePhysicalAspectRatio
{
    CGSize                          pixelsSize;
    
    pixelsSize                      = [[self class] devicePhysicalPixels];
    if ( CGSizeEqualToSize( pixelsSize, CGSizeZero ) == YES )
    {
        return 0.0f;
    }
    return ( pixelsSize.height / pixelsSize.width );
}

//  ------------------------------------------------------------------------------------------------
+ ( CGFloat ) deviceRenderedAspectRatio
{
    CGSize                          pixelsSize;
    
    pixelsSize                      = [[self class] deviceRenderedPixels];
    if ( CGSizeEqualToSize( pixelsSize, CGSizeZero ) == YES )
    {
        return 0.0f;
    }
    return ( pixelsSize.height / pixelsSize.width );
}

//  ------------------------------------------------------------------------------------------------
+ ( UIDevicePlatformFamily ) devicePlatformFamily
{
    NSString                      * devicePlatform;
    
    devicePlatform                  = [[self class] devicePlatform];
    NSParameterAssert( nil != devicePlatform );
    
    if ( [devicePlatform hasPrefix: UIDevice_TechDHWInfoKeyFamilySimulator] == YES )    return UIDevicePlatformFamilySimulator;
    if ( [devicePlatform hasPrefix: UIDevice_TechDHWInfoKeyFamilyiPhone] == YES )       return UIDevicePlatformFamilyiPhone;
    if ( [devicePlatform hasPrefix: UIDevice_TechDHWInfoKeyFamilyiPod] == YES )         return UIDevicePlatformFamilyiPod;
    if ( [devicePlatform hasPrefix: UIDevice_TechDHWInfoKeyFamilyiPad] == YES )         return UIDevicePlatformFamilyiPad;
    if ( [devicePlatform hasPrefix: UIDevice_TechDHWInfoKeyFamilyAppleTV] == YES )      return UIDevicePlatformFamilyAppleTV;
    if ( [devicePlatform hasPrefix: UIDevice_TechDHWInfoKeyFamilyAppleWatch] == YES )   return UIDevicePlatformFamilyAppleWatch;
    
    return UIDevicePlatformFamilyUnknown;
}

//  ------------------------------------------------------------------------------------------------
+ ( NSArray * ) knownDevicePlatforms
{
    NSMutableArray                * modelNameList;
    NSArray                       * platforms;
    NSString                      * modelName;
    NSDictionary                  * info;
    
    info                            = nil;
    modelName                       = nil;
    platforms                       = [[[self class] _DeviceHardwareInformation] allValues];
    NSParameterAssert( nil != platforms );

    modelNameList                   = [NSMutableArray arrayWithCapacity: [platforms count]];
    for ( NSDictionary * info in platforms )
    {
        if ( nil == info )
        {
            continue;
        }
        
        modelName                   = [info objectForKey: UIDevice_TechDHWInfoKeyModelName];
        if ( nil == modelName )
        {
            continue;
        }
        
        [modelNameList              addObject: modelName];
    }
    platforms                       = nil;
    return modelNameList;
}

#ifdef DEBUG
//  ------------------------------------------------------------------------------------------------
+ ( NSArray * ) knownDeviceIdentifiers
{
    return [[[self class] _DeviceHardwareInformation] allKeys];
}

#endif  //  End of  DEBUG.

//  ------------------------------------------------------------------------------------------------
#pragma mark method for get device's hardware's information.
//  ------------------------------------------------------------------------------------------------
+ ( NSString * ) hwModel
{
    return [[self class] _GetSysInfoByName: UIDevice_TechDHWInfoKeyHWModel];
}

//  ------------------------------------------------------------------------------------------------
+ ( NSString * ) hwMachine
{
    return [[self class] _GetSysInfoByName: UIDevice_TechDHWInfoKeyHWMachine];
}

//  ------------------------------------------------------------------------------------------------
//  ------------------------------------------------------------------------------------------------

@end

//  ------------------------------------------------------------------------------------------------
//  ------------------------------------------------------------------------------------------------





















