//
//  TDStickerLibraryTabInfo.m
//  TDStickerLibrary
//
//  Created by Robin Hsu on 2015/1/21.
//  Copyright (c) 2015年 TechD. All rights reserved.
//

#ifndef __ARCMacros_H__
    #import "ARCMacros.h"
#endif  //  End of __ARCMacros_H__.

#import "ZipArchive.h"
#import "UIKit+TechD.h"
#import "TDStickerLibraryTabInfo.h"

//  ------------------------------------------------------------------------------------------------
static  NSString  * const kTDTabInfoKeyRoot                         = @"Tab";
static  NSString  * const kTDTabInfoKeyName                         = @"Name";
static  NSString  * const kTDTabInfoKeyEnabled                      = @"Enabled";
static  NSString  * const kTDTabInfoKeyImages                       = @"Images";
static  NSString  * const kTDTabInfoKeyConfigure                    = @"Configure";
static  NSString  * const kTDTabInfoKeyTimestamp                    = @"Timestamp";
static  NSString  * const kTDTabInfoKeyDataLink                     = @"DataLink";


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
@interface TDStickerLibraryTabInfo ()
{

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
@interface TDStickerLibraryTabInfo (Private)

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
@implementation TDStickerLibraryTabInfo (Private)

//  ------------------------------------------------------------------------------------------------
#pragma mark method for initial this class.
//  ------------------------------------------------------------------------------------------------
- ( void ) _InitAttributes
{

}


//  ------------------------------------------------------------------------------------------------
//  ------------------------------------------------------------------------------------------------

@end

//  ------------------------------------------------------------------------------------------------
//  ------------------------------------------------------------------------------------------------


// ※ 環境設定新建一個 default class 之類的方式, 把一些相關設定值都預設進去裡頭, 如果開發人員讓 object = nil 帶入, 就自建一個 default 的 出來傳遞,
//  如果有 new 這個 class 就帶入這個 new 出來的 class 的值... 這樣應該不錯用才是 @@~

//  ------------------------------------------------------------------------------------------------
//  ------------------------------------------------------------------------------------------------
#pragma mark -
#pragma mark implementation for public
//  ------------------------------------------------------------------------------------------------
@implementation TDStickerLibraryTabInfo

//  ------------------------------------------------------------------------------------------------
#pragma mark synthesize variable.


//  ------------------------------------------------------------------------------------------------
//  ------------------------------------------------------------------------------------------------
#pragma mark overwrite implementation of NSObject
//  ------------------------------------------------------------------------------------------------
//- ( void ) dealloc
//{
//    SAFE_ARC_SUPER_DEALLOC();
//}

//  ------------------------------------------------------------------------------------------------
//  ------------------------------------------------------------------------------------------------
#pragma mark method for create the object.
//  ------------------------------------------------------------------------------------------------
+ ( instancetype ) loadDataFromZip:(NSString *)filename forDirectories:(TDGetPathDirectory) directory inDirectory:(NSString *)subpath
                      inZippedPath:(NSString *)prefix with:(NSString *)password
{
    return [[self class] loadConfigureData: filename type: TDConfigureDataSourceFileTypeJSON
                                  encoding: NSUTF8StringEncoding withConfigure: kTDTabInfoKeyRoot
                                      from: filename forDirectories: directory inDirectory: subpath inZippedPath: prefix with: password onSingleton: NO];
    
}

//  ------------------------------------------------------------------------------------------------
+ ( instancetype ) loadDataFromzip:(NSString *)fullPath inZippedPath:(NSString *)prefix with:(NSString *)password
{
    return [[self class] loadConfigureData: [fullPath lastPathComponent] type: TDConfigureDataSourceFileTypeJSON
                                  encoding: NSUTF8StringEncoding withConfigure: kTDTabInfoKeyRoot
                                      from: fullPath inZippedPath: prefix with: password onSingleton: NO];
}

//  ------------------------------------------------------------------------------------------------
#pragma mark method for update this object.
//  ------------------------------------------------------------------------------------------------
- ( BOOL ) updateDataFromZip:(NSString *)filename forDirectories:(TDGetPathDirectory) directory inDirectory:(NSString *)subpath inZippedPath:(NSString *)prefix with:(NSString *)password
{
    return [self updateConfigureData: filename type: TDConfigureDataSourceFileTypeJSON encoding: NSUTF8StringEncoding
                       withConfigure: kTDTabInfoKeyRoot and: kTDTabInfoKeyName
                                from: filename forDirectories: directory inDirectory: subpath inZippedPath: prefix with: password];
}

//  ------------------------------------------------------------------------------------------------
#pragma mark method for get data in Zipped file.
//  ------------------------------------------------------------------------------------------------
- ( NSData * ) imageDataForKey:(NSString *)aKey
{
    aKey                            = TDGetPNGImageFilenameWithAssetScale( aKey, [[UIScreen mainScreen] scaleMultiple] );
    return [self unzipDataForKey: aKey];
}

//  ------------------------------------------------------------------------------------------------
#pragma mark method for get information data.
//  ------------------------------------------------------------------------------------------------
- ( BOOL ) sortInfoData
{
    return [self sortConfigureData: kTDTabInfoKeyConfigure orderAscending: YES];
}

//  ------------------------------------------------------------------------------------------------
- ( BOOL ) isInfoDataEnabledAtIndex:(NSInteger)index
{
    NSDictionary                  * infoData;
    NSString                      * enabled;
    
    infoData                        = [self infoDataAtIndex: index];
    if ( nil == infoData )
    {
        return NO;
    }
    
    enabled                         = [infoData objectForKey: kTDTabInfoKeyEnabled];
    if ( nil == enabled )
    {
        return NO;
    }
    
    if ( [enabled integerValue] == 0 )
    {
        return NO;
    }
    return YES;     //  value is not equal 0, always Yes.
}

//  ------------------------------------------------------------------------------------------------
- ( NSInteger ) indexOfInfoDataEnabledAtOrder:(NSInteger)order
{
    NSInteger                       count;
    
    count                           = 0;
    for ( int i = 0; i < [self infoDataCount]; ++i )
    {
        if ( [self isInfoDataEnabledAtIndex: i] == NO )
        {
            continue;
        }
        count++;
        if ( count == order )
        {
            return i;
        }
    }
    return -1;
}

//  ------------------------------------------------------------------------------------------------
- ( NSArray * ) imagesNameAtIndex:(NSInteger)index
{
    NSDictionary                  * infoData;
    
    infoData                        = [self infoDataAtIndex: index];
    if ( nil == infoData )
    {
        return nil;
    }
    return [infoData objectForKey: kTDTabInfoKeyImages];
}

//  ------------------------------------------------------------------------------------------------
- ( NSString * ) configureKeyAtIndex:(NSInteger)index
{
    NSString                      * name;
    
    name                            = [self infoDataAtIndex: index stringValueForKey: kTDTabInfoKeyName];
    if ( ( nil == name ) || ( [name length] == 0 ) )
    {
        return nil;
    }
    return name;
}

//  ------------------------------------------------------------------------------------------------
- ( NSString * ) configureNameAtIndex:(NSInteger)index
{
    NSString                      * configure;
    
    configure                       = [self infoDataAtIndex: index stringValueForKey: kTDTabInfoKeyConfigure];
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
    
    timestamp                       = [self infoDataAtIndex: index stringValueForKey: kTDTabInfoKeyTimestamp];
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
    
    dataLink                        = [self infoDataAtIndex: index stringValueForKey: kTDTabInfoKeyDataLink];
    if ( ( nil == dataLink ) || ( [dataLink length] == 0 ) )
    {
        return nil;
    }
    return dataLink;
}

//  ------------------------------------------------------------------------------------------------


@end

//  ------------------------------------------------------------------------------------------------
//  ------------------------------------------------------------------------------------------------
















