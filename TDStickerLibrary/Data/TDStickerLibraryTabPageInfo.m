//
//  TDStickerLibraryTabPageInfo.m
//  TDStickerLibrary
//
//  Created by Robin Hsu on 2015/2/4.
//  Copyright (c) 2015年 TechD. All rights reserved.
//
//  ------------------------------------------------------------------------------------------------
//  ------------------------------------------------------------------------------------------------

#ifndef __ARCMacros_H__
    #import "ARCMacros.h"
#endif  //  End of __ARCMacros_H__.

#import "ZipArchive.h"
#import "UIKit+TechD.h"
#import "Foundation+TechD.h"
#import "TDStickerLibraryTabPageInfo.h"


//  ------------------------------------------------------------------------------------------------
static  NSString  * const kTDPageInfoKeyID                          = @"ID";
static  NSString  * const kTDPageInfoKeyMode                        = @"Mode";
static  NSString  * const kTDPageInfoKeyTitle                       = @"Title";
static  NSString  * const kTDPageInfoKeyIllustrator                 = @"Author";
static  NSString  * const kTDPageInfoKeyEMail                       = @"E-Mail";
static  NSString  * const kTDPageInfoKeyWebsite                     = @"Website";
static  NSString  * const kTDPageInfoKeyDescription                 = @"Description";
static  NSString  * const kTDPageInfoKeyIntroImageIndex             = @"Intro Image Index";
static  NSString  * const kTDPageInfoKeySubDir                      = @"SubDirectory";
static  NSString  * const kTDPageInfoKeyImages                      = @"Images";
static  NSString  * const kTDPageInfoKeyIntroImage                  = @"IntroImage";
static  NSString  * const kTDPageInfoKeyConfigure                   = @"Configure";
static  NSString  * const kTDPageInfoKeyTimestamp                   = @"Timestamp";
static  NSString  * const kTDPageInfoKeyDataLink                    = @"DataLink";
static  NSString  * const kTDPageInfoKeyValidDate                   = @"ValidDate";
static  NSString  * const kTDPageInfoKeyExpireDate                  = @"ExpireDate";

//  ------------------------------------------------------------------------------------------------
//  ------------------------------------------------------------------------------------------------


//  ------------------------------------------------------------------------------------------------
//  ------------------------------------------------------------------------------------------------
#pragma mark -
#pragma mark class TDStickerLibraryTabInfo

//  ------------------------------------------------------------------------------------------------
//  ------------------------------------------------------------------------------------------------
#pragma mark declare private category ()
//  ------------------------------------------------------------------------------------------------
@interface TDStickerLibraryTabPageInfo ()
{
    /**
     *  temporary the information data when swap.
     */
    id                              swapSource;
}

//  ------------------------------------------------------------------------------------------------

@end


//  ------------------------------------------------------------------------------------------------
//  ------------------------------------------------------------------------------------------------

//  ------------------------------------------------------------------------------------------------
//  ------------------------------------------------------------------------------------------------
#pragma mark -
#pragma mark declare private category (Private)
//  ------------------------------------------------------------------------------------------------
@interface TDStickerLibraryTabPageInfo (Private)

//  ------------------------------------------------------------------------------------------------
#pragma mark declare for initial this class.
//  ------------------------------------------------------------------------------------------------
/**
 *  @brief initial the attributes of class.
 *  initial the attributes of class.
 */
- ( void ) _InitAttributes;

//  ------------------------------------------------------------------------------------------------

@end


//  ------------------------------------------------------------------------------------------------
//  ------------------------------------------------------------------------------------------------


//  ------------------------------------------------------------------------------------------------
//  ------------------------------------------------------------------------------------------------
#pragma mark -
#pragma mark implementation private category (Private)
//  ------------------------------------------------------------------------------------------------
@implementation TDStickerLibraryTabPageInfo (Private)

//  ------------------------------------------------------------------------------------------------
#pragma mark method for initial this class.
//  ------------------------------------------------------------------------------------------------
- ( void ) _InitAttributes
{
    swapSource                      = nil;
}

//  ------------------------------------------------------------------------------------------------
//  ------------------------------------------------------------------------------------------------

@end

//  ------------------------------------------------------------------------------------------------
//  ------------------------------------------------------------------------------------------------


//  ------------------------------------------------------------------------------------------------
//  ------------------------------------------------------------------------------------------------
#pragma mark -
#pragma mark implementation for public
//  ------------------------------------------------------------------------------------------------
@implementation TDStickerLibraryTabPageInfo


//  ------------------------------------------------------------------------------------------------
#pragma mark synthesize variable.


//  ------------------------------------------------------------------------------------------------
//  ------------------------------------------------------------------------------------------------
#pragma mark overwrite implementation of NSObject
//  ------------------------------------------------------------------------------------------------
- ( void ) dealloc
{
    if ( nil != swapSource )
    {
        SAFE_ARC_RELEASE( swapSource );
        swapSource                  = nil;
    }
    SAFE_ARC_SUPER_DEALLOC();
}

//  ------------------------------------------------------------------------------------------------
//  ------------------------------------------------------------------------------------------------
#pragma mark method for create the object.
//  ------------------------------------------------------------------------------------------------
+ ( instancetype ) loadDataFromZip:(NSString *)filename forDirectories:(TDGetPathDirectory) directory inDirectory:(NSString *)subpath
                      inZippedPath:(NSString *)prefix with:(NSString *)password
                         configure:(NSString *)rootKey
{
    return [[self class] loadConfigureData: filename type: TDConfigureDataSourceFileTypeJSON encoding: NSUTF8StringEncoding withConfigure: rootKey
                                      from: filename forDirectories: directory inDirectory: subpath inZippedPath: prefix with: password onSingleton: NO];
}


//  ------------------------------------------------------------------------------------------------
#pragma mark method for update this object.
//  ------------------------------------------------------------------------------------------------
- ( BOOL ) updateDataFromZip:(NSString *)filename forDirectories:(TDGetPathDirectory) directory inDirectory:(NSString *)subpath
                inZippedPath:(NSString *)prefix with:(NSString *)password
                   configure:(NSString *)rootKey
{
    return [self  updateConfigureData: filename type: TDConfigureDataSourceFileTypeJSON encoding: NSUTF8StringEncoding
                        withConfigure: rootKey and: kTDPageInfoKeyID
                                 from: filename forDirectories: directory inDirectory: subpath inZippedPath: prefix with: password];
}


//  ------------------------------------------------------------------------------------------------
#pragma mark method for special i/o information data.
//  ------------------------------------------------------------------------------------------------
- ( BOOL ) swapInfoDataWithIndex:(NSInteger)index
{
    if ( ( 0 > index ) || ( [self configureData] == nil ) || ( [[self configureData] count] == 0 ) )
    {
        return NO;
    }
    
    id                              infoData;
    
    infoData                        = [[self configureData] objectAtIndex: index];
    if ( nil == infoData )
    {
        return NO;
    }
    
    swapSource                      = [self configureData];
    [self                           setConfigureData: [NSMutableArray arrayWithObjects: infoData, nil]];
    return YES;
}

//  ------------------------------------------------------------------------------------------------
- ( BOOL ) reverseInfoData
{
    if ( nil == swapSource )
    {
        return NO;
    }
    
    [self                           setConfigureData: swapSource];
    swapSource                      = nil;
    return YES;
}

//  ------------------------------------------------------------------------------------------------
#pragma mark method for get information data.
//  ------------------------------------------------------------------------------------------------
- ( BOOL ) sortInfoData
{
    return [self sortConfigureData: kTDPageInfoKeyID orderAscending: NO];
}

//  ------------------------------------------------------------------------------------------------
- ( NSString * ) dataIDAtIndex:(NSInteger)index
{
    return [self infoDataAtIndex: index stringValueForKey: kTDPageInfoKeyID];
}

//  ------------------------------------------------------------------------------------------------
- ( NSString * ) dataTitleAtIndex:(NSInteger)index
{
    return [self infoDataAtIndex: index stringValueForKey: kTDPageInfoKeyTitle];
}

//  ------------------------------------------------------------------------------------------------
- ( BOOL ) dataMode:(NSInteger *)dataMode atIndex:(NSInteger)index
{
    NSInteger                       mode;
    
    mode                            = [self infoDataAtIndex: index integerValueForKey: kTDPageInfoKeyMode];
    if ( -1 == mode )
    {
        return NO;
    }
    if ( NULL != dataMode )
    {
        *dataMode                   = mode;
    }
    return YES;
}

//  ------------------------------------------------------------------------------------------------
- ( NSString * ) illustratorAtIndex:(NSInteger)index
{
    return [self infoDataAtIndex: index stringValueForKey: kTDPageInfoKeyIllustrator];
}

//  ------------------------------------------------------------------------------------------------
- ( NSString * ) illustratorEMailAtIndex:(NSInteger)index
{
    return [self infoDataAtIndex: index stringValueForKey: kTDPageInfoKeyEMail];
}

//  ------------------------------------------------------------------------------------------------
- ( NSString * ) illustratorWebsiteAtIndex:(NSInteger)index
{
    return [self infoDataAtIndex: index stringValueForKey: kTDPageInfoKeyWebsite];
}

//  ------------------------------------------------------------------------------------------------
- ( NSString * ) descriptionAtIndex:(NSInteger)index
{
    return [self infoDataAtIndex: index stringValueForKey: kTDPageInfoKeyDescription];
}

////  ------------------------------------------------------------------------------------------------
//- ( BOOL ) introImageIndex:(NSInteger *)imageIndex atIndex:(NSInteger)index;
//{
//    NSInteger                       indexData;
//    
//    indexData                       = [self infoDataAtIndex: index integerValueForKey: kTDPageInfoKeyIntroImageIndex];
//    if ( -1 == indexData )
//    {
//        return NO;
//    }
//    if ( NULL != imageIndex )
//    {
//        *imageIndex                 = indexData;
//    }
//    return YES;
//}

//  ------------------------------------------------------------------------------------------------
- ( NSString * ) introImageNameAtIndex:(NSInteger)index
{
    return [self infoDataAtIndex: index stringValueForKey: kTDPageInfoKeyIntroImage];
}

//  ------------------------------------------------------------------------------------------------
- ( UIImage * ) introImageAtIndex:(NSInteger)index
{
    NSString                      * introImageName;
    
    introImageName                  = [self introImageNameAtIndex: index];
    if ( nil == introImageName )
    {
        return nil;
    }
    return [self imageAtIndex: index forKey: introImageName];
}

//  ------------------------------------------------------------------------------------------------
- ( NSInteger ) countOfImageDataAtIndex:(NSInteger)index
{
    NSDictionary                  * infoData;
    NSArray                       * images;
    
    images                          = nil;
    infoData                        = [self infoDataAtIndex: index];
    if ( nil == infoData )
    {
        return 0;
    }
    
    images                          = [infoData objectForKey: kTDPageInfoKeyImages];
    if ( nil == images )
    {
        return 0;
    }
    return [images count];
}

//  ------------------------------------------------------------------------------------------------
- ( NSString * ) imageNameAtIndex:(NSInteger)index inArray:(NSInteger)inArrayIndex
{
    NSDictionary                  * infoData;
    NSArray                       * images;
    NSString                      * subDir;
    
    images                          = nil;
    subDir                          = [self infoDataAtIndex:index stringValueForKey: kTDPageInfoKeySubDir];
    infoData                        = [self infoDataAtIndex: index];
    if ( nil == infoData )
    {
        return nil;
    }
    
    images                          = [infoData objectForKey: kTDPageInfoKeyImages];
    if ( ( nil == images ) || ( [images count] == 0 ) )
    {
        return nil;
    }
    
    return [images objectAtIndex: inArrayIndex];
}

//  ------------------------------------------------------------------------------------------------
- ( BOOL ) isActive:(BOOL *)data atIndex:(NSInteger)index
{
    if ( NULL == data )
    {
        return NO;
    }
    
    NSString                      * dateValid;
    NSString                      * dateExpire;
    
    dateValid                       = [self infoDataAtIndex: index stringValueForKey: kTDPageInfoKeyValidDate];
    dateExpire                      = [self infoDataAtIndex: index stringValueForKey: kTDPageInfoKeyExpireDate];
    
    //  both is nil; is true.
    if ( ( nil == dateValid ) && ( nil == dateExpire ) )
    {
        *data                       = YES;
        return YES;
    }
    
    NSDate                        * now;
    NSDate                        * valid;
    NSDate                        * expire;
    NSTimeInterval                  intervalExpireInDay;

    valid                           = nil;
    expire                          = nil;
    intervalExpireInDay             = ( ( 24 * 60 * 60 ) - 1 );
    valid                           = [NSDate GMTDateWithTimeString: dateValid locale: nil format: @"yyyy-MM-dd"];
    
    //expire                          = [NSDate GMTDateWithTimeString: dateExpire locale: nil format: @"yyyy-MM-dd"];
    //expire                          = [NSDate dateWithTimeInterval: intervalExpireInDay sinceDate: expire];
    //  ※ 因為本來使用的手段會因為, 本身 create instance 時, 並不會複製額外產生的旗標資訊, 所以只能調整建立順序.
    //  because original's code (apple api) will not assign(or copy) new properties when create new date instance,
    //  that's must to change code order & method.
    expire                          = [NSDate dateWithTimeString: dateExpire locale: nil format: @"yyyy-MM-dd"];
    expire                          = [NSDate dateWithTimeInterval: intervalExpireInDay sinceDate: expire];
    expire                          = [expire GMTDate];
    now                             = [NSDate GMT];
    NSParameterAssert( nil != now );

    *data                           = [now isEffectivePeriod: valid and: expire];
    return YES;
}

//  ------------------------------------------------------------------------------------------------
- ( NSString * ) configureNameWithSubDirAtIndex:(NSInteger)index
{
    NSString                      * subDir;
    NSString                      * configureName;
    
    subDir                          = [self infoDataAtIndex: index stringValueForKey: kTDPageInfoKeySubDir];
    configureName                   = [self infoDataAtIndex: index stringValueForKey: kTDPageInfoKeyConfigure];
    
    if ( ( nil == configureName ) || ( [configureName length] == 0 ) )
    {
        return nil;
    }
    
    configureName                   = [subDir stringByAppendingPathComponent: configureName];
    configureName                   = [configureName stringByAppendingPathExtension: @"plist"];
    return configureName;
}

//  ------------------------------------------------------------------------------------------------
- ( NSString * ) configureNameAtIndex:(NSInteger)index
{
    NSString                      * configure;

    configure                       = [self infoDataAtIndex: index stringValueForKey: kTDPageInfoKeyConfigure];
    if ( ( nil == configure ) || ( [configure length] == 0 ) )
    {
        return nil;
    }
    return configure;
}

//  ------------------------------------------------------------------------------------------------
- (NSString * ) timestampAtIndex:(NSInteger)index
{
    NSString                      * timestamp;
    
    timestamp                       = [self infoDataAtIndex: index stringValueForKey: kTDPageInfoKeyTimestamp];
    if ( ( nil == timestamp ) || ( [timestamp length] == 0 ) )
    {
        return nil;
    }
    return timestamp;
}

//  ------------------------------------------------------------------------------------------------
- ( NSString * ) dataLinkAtIndex:(NSInteger)index
{
    NSString                      * dataLink;
    
    dataLink                        = [self infoDataAtIndex: index stringValueForKey: kTDPageInfoKeyDataLink];
    if ( ( nil == dataLink ) || ( [dataLink length] == 0 ) )
    {
        return nil;
    }
    return dataLink;
}

//  ------------------------------------------------------------------------------------------------
#pragma mark method for get data in Zipped file.
//  ------------------------------------------------------------------------------------------------
- ( UIImage * ) imageAtIndex:(NSInteger)index forKey:(NSString *)aKey
{
    if ( nil == aKey )
    {
        return nil;
    }
    
    NSString                      * subDir;
    
    subDir                          = [self infoDataAtIndex: index stringValueForKey: kTDPageInfoKeySubDir];
    
    return [self image: aKey ofType: nil inDirectory: subDir];
}

//  ------------------------------------------------------------------------------------------------
- ( UIImage * ) imageAtIndex:(NSInteger)index inArray:(NSInteger)inArrayIndex
{
    NSString                      * imageName;
    NSString                      * subDir;
    
    subDir                          = [self infoDataAtIndex:index stringValueForKey: kTDPageInfoKeySubDir];
    imageName                       = [self imageNameAtIndex: index inArray: inArrayIndex];
    
    return [self image: imageName ofType: nil inDirectory: subDir];
}

//  ------------------------------------------------------------------------------------------------
- ( NSData * ) configureDataForKey:(NSString *)aKey
{
    return [self unzipDataForKey: aKey];
}

//  ------------------------------------------------------------------------------------------------
- ( NSData * ) configureDataAtIndex:(NSInteger)index
{
    NSString                      * configureName;
    
    configureName                   = [self configureNameWithSubDirAtIndex: index];
    if ( nil == configureName )
    {
        return nil;
    }
    return [self configureDataForKey: configureName];
}

//  ------------------------------------------------------------------------------------------------


@end

//  ------------------------------------------------------------------------------------------------
//  ------------------------------------------------------------------------------------------------
















