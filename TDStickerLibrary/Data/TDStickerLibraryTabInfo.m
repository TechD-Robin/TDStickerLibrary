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
static  NSString  * const kTDTabInfoKeyDataLink                     = @"DataLink";


//  ------------------------------------------------------------------------------------------------
//  ------------------------------------------------------------------------------------------------


//  ------------------------------------------------------------------------------------------------
//  ------------------------------------------------------------------------------------------------
#pragma mark -
#pragma mark class TDStickerLibraryTabInfo

//  ------------------------------------------------------------------------------------------------
//  ------------------------------------------------------------------------------------------------
//  declare property for private category()
//  ------------------------------------------------------------------------------------------------
//  --------------------------------
#pragma mark declare property ()
@interface TDStickerLibraryTabInfo()
{

}

//  ------------------------------------------------------------------------------------------------

@end


//  ------------------------------------------------------------------------------------------------
//  ------------------------------------------------------------------------------------------------


//  ------------------------------------------------------------------------------------------------
//  ------------------------------------------------------------------------------------------------
//  method declare for Private of category
//  ------------------------------------------------------------------------------------------------
#pragma mark -
#pragma mark declare for Private
@interface TDStickerLibraryTabInfo(Private)

//  ------------------------------------------------------------------------------------------------
//  ------------------------------------------------------------------------------------------------
/**
 *  @brief initial the attributes of class.
 *  initial the attributes of class.
 */
- ( void ) _InitAttributes;

//  ------------------------------------------------------------------------------------------------
- ( NSString * ) _GetImageDataKeyForScreenScale:(NSString *)aKey;


//  ------------------------------------------------------------------------------------------------

@end


//  ------------------------------------------------------------------------------------------------
//  ------------------------------------------------------------------------------------------------


//  ------------------------------------------------------------------------------------------------
//  ------------------------------------------------------------------------------------------------
//  method implementation for Private of category
//  ------------------------------------------------------------------------------------------------
#pragma mark -
#pragma mark implementation for Private method
@implementation TDStickerLibraryTabInfo(Private)

//  ------------------------------------------------------------------------------------------------
//  ------------------------------------------------------------------------------------------------
//  --------------------------------
- ( void ) _InitAttributes
{

}

//  ------------------------------------------------------------------------------------------------
- ( NSString * ) _GetImageDataKeyForScreenScale:(NSString *)aKey
{
    if ( nil == aKey )
    {
        return nil;
    }
    
    // split & check aKey
    NSString                      * file;
    NSString                      * extension;
    
    file                            = aKey;
    extension                       = [aKey pathExtension];
    if ( [[extension lowercaseString] isEqualToString: @"png"] == YES )
    {
        return aKey;
    }
    if ( ( nil != extension ) && ( [extension length] != 0 ) )
    {
        file                            = [aKey substringToIndex: ( [aKey length] - 4 )];
    }

    file                            = [NSString stringWithFormat: @"%s@%dx", [file UTF8String], (int)[[UIScreen mainScreen] scaleMultiple]];
    aKey                            = [file stringByAppendingPathExtension: @"png"];
    return aKey;
}

//  ------------------------------------------------------------------------------------------------


@end

//  ------------------------------------------------------------------------------------------------
//  ------------------------------------------------------------------------------------------------


// ※ 環境設定新建一個 default class 之類的方式, 把一些相關設定值都預設進去裡頭, 如果開發人員讓 object = nil 帶入, 就自建一個 default 的 出來傳遞,
//  如果有 new 這個 class 就帶入這個 new 出來的 class 的值... 這樣應該不錯用才是 @@~

//  ------------------------------------------------------------------------------------------------
//  ------------------------------------------------------------------------------------------------
//  public method implementation.
//  ------------------------------------------------------------------------------------------------
#pragma mark -
#pragma mark implementation for public method
@implementation TDStickerLibraryTabInfo

//  ------------------------------------------------------------------------------------------------
#pragma mark synthesize variable.


//  ------------------------------------------------------------------------------------------------
//  ------------------------------------------------------------------------------------------------
#pragma mark overwrite implementation of NSObject
//  ------------------------------------------------------------------------------------------------
- ( instancetype ) init
{
    return [self initWithZipFile: nil forDirectories: TDTemporaryDirectory inDirectory: nil inZippedPath: nil with: nil];
}

//  ------------------------------------------------------------------------------------------------
- ( void ) dealloc
{
    SAFE_ARC_SUPER_DEALLOC();
}

//  ------------------------------------------------------------------------------------------------
//  ------------------------------------------------------------------------------------------------
#pragma mark method create the object.
//  ------------------------------------------------------------------------------------------------
- ( instancetype ) initWithZipFile:(NSString *)filename forDirectories:(TDGetPathDirectory) directory inDirectory:(NSString *)subpath inZippedPath:(NSString*)prefix with:(NSString *)password
{
    return [super initWithZipFile: filename forDirectories: directory inDirectory: subpath inZippedPath: prefix with: password configure: kTDTabInfoKeyRoot];
}

//  ------------------------------------------------------------------------------------------------
+ ( instancetype ) loadDataFromZip:(NSString *)filename forDirectories:(TDGetPathDirectory) directory inDirectory:(NSString *)subpath inZippedPath:(NSString *)prefix
{
    return [[[self class] alloc] initWithZipFile: filename forDirectories: directory inDirectory: subpath inZippedPath: prefix with: nil];
}

//  ------------------------------------------------------------------------------------------------
+ ( instancetype ) loadDataFromZip:(NSString *)filename forDirectories:(TDGetPathDirectory) directory inDirectory:(NSString *)subpath inZippedPath:(NSString *)prefix with:(NSString *)password
{
    return [[[self class] alloc] initWithZipFile: filename forDirectories: directory inDirectory: subpath inZippedPath: prefix with: password];
}

//  ------------------------------------------------------------------------------------------------
//  ------------------------------------------------------------------------------------------------
- ( BOOL ) updateDataFromZip:(NSString *)filename forDirectories:(TDGetPathDirectory) directory inDirectory:(NSString *)subpath inZippedPath:(NSString *)prefix with:(NSString *)password
{
    return [self updateDataFromZip: filename forDirectories: directory inDirectory: subpath inZippedPath: prefix with: password configure: kTDTabInfoKeyRoot  with: kTDTabInfoKeyName];
}

//  ------------------------------------------------------------------------------------------------
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
    return 0;
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
- ( NSData * ) imageDataForKey:(NSString *)aKey
{
    aKey                            = [self _GetImageDataKeyForScreenScale: aKey];
    return [self unzipDataForKey: aKey];
}

//  ------------------------------------------------------------------------------------------------
- ( NSString * ) configureNameAtIndex:(NSInteger)index
{
    NSDictionary                  * infoData;
    NSString                      * configure;
    
    configure                       = nil;
    infoData                        = [self infoDataAtIndex: index];
    if ( nil == infoData )
    {
        return nil;
    }
    
    configure                       = [infoData objectForKey: kTDTabInfoKeyConfigure];
    if ( ( nil == configure ) || ( [configure length] == 0 ) )
    {
        return nil;
    }
    return configure;
}

//  ------------------------------------------------------------------------------------------------
- ( NSString * ) dataLinkAtIndex:(NSInteger)index
{
    NSDictionary                  * infoData;
    NSString                      * dataLink;
    
    dataLink                        = nil;
    infoData                        = [self infoDataAtIndex: index];
    if ( nil == infoData )
    {
        return nil;
    }
    
    dataLink                        = [infoData objectForKey: kTDTabInfoKeyDataLink];
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
















