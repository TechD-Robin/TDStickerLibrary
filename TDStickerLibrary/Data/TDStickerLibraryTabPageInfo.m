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
#import "TDStickerLibraryTabPageInfo.h"


//  ------------------------------------------------------------------------------------------------
static  NSString  * const kTDPageInfoKeyID                          = @"ID";
static  NSString  * const kTDPageInfoKeyMode                        = @"Mode";
static  NSString  * const kTDPageInfoKeyTitle                       = @"Title";
static  NSString  * const kTDPageInfoKeySubDir                      = @"SubDirectory";
static  NSString  * const kTDPageInfoKeyImages                      = @"Images";
static  NSString  * const kTDPageInfoKeyConfigure                   = @"Configure";

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
@interface TDStickerLibraryTabPageInfo()
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
@interface TDStickerLibraryTabPageInfo(Private)

//  ------------------------------------------------------------------------------------------------
//  ------------------------------------------------------------------------------------------------
/**
 *  @brief initial the attributes of class.
 *  initial the attributes of class.
 */
- ( void ) _InitAttributes;

//  ------------------------------------------------------------------------------------------------
- ( NSString * ) _GetStringDataAtIndex:(NSInteger)index forKey:(NSString *)aKey;

- ( NSInteger ) _GetIntegerDataAtIndex:(NSInteger)index forKey:(NSString *)aKey;

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
@implementation TDStickerLibraryTabPageInfo(Private)

//  ------------------------------------------------------------------------------------------------
//  ------------------------------------------------------------------------------------------------
//  --------------------------------
- ( void ) _InitAttributes
{
    
}

//  ------------------------------------------------------------------------------------------------
//  ------------------------------------------------------------------------------------------------
- ( NSString * ) _GetStringDataAtIndex:(NSInteger)index forKey:(NSString *)aKey
{
    NSDictionary                  * infoData;
    NSString                      * string;
    
    string                          = nil;
    infoData                        = [self infoDataAtIndex: index];
    if ( nil == infoData )
    {
        return nil;
    }
    
    string                          = [infoData objectForKey: aKey];
    if ( ( nil == string ) || ( [string length] == 0 ) )
    {
        return nil;
    }
    return string;
    
}

//  ------------------------------------------------------------------------------------------------
- ( NSInteger ) _GetIntegerDataAtIndex:(NSInteger)index forKey:(NSString *)aKey
{
    NSString                      * string;
    
    string                          = [self _GetStringDataAtIndex: index forKey: aKey];
    if ( nil == string )
    {
        return 0;
    }
    return [string integerValue];
}

//  ------------------------------------------------------------------------------------------------
//  ------------------------------------------------------------------------------------------------


@end

//  ------------------------------------------------------------------------------------------------
//  ------------------------------------------------------------------------------------------------

//  ------------------------------------------------------------------------------------------------
//  ------------------------------------------------------------------------------------------------
//  public method implementation.
//  ------------------------------------------------------------------------------------------------
#pragma mark -
#pragma mark implementation for public method
@implementation TDStickerLibraryTabPageInfo


//  ------------------------------------------------------------------------------------------------
#pragma mark synthesize variable.


//  ------------------------------------------------------------------------------------------------
//  ------------------------------------------------------------------------------------------------
#pragma mark overwrite implementation of NSObject
//  ------------------------------------------------------------------------------------------------
- ( instancetype ) init
{
    return [self initWithZipFile: nil forDirectories: TDTemporaryDirectory inDirectory: nil inZippedPath: nil with: nil configure: nil];
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
- ( instancetype ) initWithZipFile:(NSString *)filename forDirectories:(TDGetPathDirectory) directory inDirectory:(NSString *)subpath
                      inZippedPath:(NSString*)prefix with:(NSString *)password
                         configure:(NSString *)rootKey
{
    return [super initWithZipFile: filename forDirectories: directory inDirectory: subpath inZippedPath: prefix with: password configure: rootKey];
}

//  ------------------------------------------------------------------------------------------------
+ ( instancetype ) loadDataFromZip:(NSString *)filename forDirectories:(TDGetPathDirectory) directory inDirectory:(NSString *)subpath
                      inZippedPath:(NSString *)prefix configure:(NSString *)rootKey
{
    return [[[self class] alloc] initWithZipFile: filename forDirectories: directory inDirectory: subpath inZippedPath: prefix with: nil configure: rootKey];
}

//  ------------------------------------------------------------------------------------------------
+ ( instancetype ) loadDataFromZip:(NSString *)filename forDirectories:(TDGetPathDirectory) directory inDirectory:(NSString *)subpath
                      inZippedPath:(NSString *)prefix with:(NSString *)password
                         configure:(NSString *)rootKey
{
    return [[[self class] alloc] initWithZipFile: filename forDirectories: directory inDirectory: subpath inZippedPath: prefix with: password configure: rootKey];
}

//  ------------------------------------------------------------------------------------------------
//  ------------------------------------------------------------------------------------------------
- ( BOOL ) updateDataFromZip:(NSString *)filename forDirectories:(TDGetPathDirectory) directory inDirectory:(NSString *)subpath
                inZippedPath:(NSString *)prefix with:(NSString *)password
                   configure:(NSString *)rootKey
{
    return [self updateDataFromZip: filename forDirectories: directory inDirectory: subpath inZippedPath: prefix with: password configure: rootKey with: kTDPageInfoKeyID];
}

//  ------------------------------------------------------------------------------------------------
//  ------------------------------------------------------------------------------------------------
//  --------------------------------
- ( NSString * ) dataIDAtIndex:(NSInteger)index
{
    return [self _GetStringDataAtIndex: index forKey: kTDPageInfoKeyID];
}

//  ------------------------------------------------------------------------------------------------
- ( NSString * ) dataTitleAtIndex:(NSInteger)index
{
    return [self _GetStringDataAtIndex: index forKey: kTDPageInfoKeyTitle];
}

//  ------------------------------------------------------------------------------------------------
- ( NSInteger ) dataModeAtIndex:(NSInteger)index
{
    return [self _GetIntegerDataAtIndex: index forKey: kTDPageInfoKeyMode];
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
    NSString                      * imageName;
    
    images                          = nil;
    imageName                       = nil;
    subDir                          = [self _GetStringDataAtIndex: index forKey: kTDPageInfoKeySubDir];
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
    
    imageName                       = [images objectAtIndex: inArrayIndex];
    if ( nil == imageName )
    {
        return nil;
    }
    
    if ( ( nil == subDir ) || ( [subDir length] == 0 ) )
    {
        return imageName;
    }
    
    imageName                       = [subDir stringByAppendingPathComponent: imageName];
    return imageName;
}

//  ------------------------------------------------------------------------------------------------
- ( NSData * ) imageDataForKey:(NSString *)aKey
{
    aKey                            = TDGetImageNameForScreenScale( aKey, (NSInteger)[[UIScreen mainScreen] scaleMultiple] );
    if ( nil == aKey )
    {
        return nil;
    }
    return [self unzipDataForKey: aKey];
}

//  ------------------------------------------------------------------------------------------------
- ( NSData * ) imageDataAtIndex:(NSInteger)index inArray:(NSInteger)inArrayIndex
{
    NSString                      * imageName;

    imageName                       = [self imageNameAtIndex: index inArray: inArrayIndex];
    if ( nil == imageName )
    {
        return nil;
    }
    return [self imageDataForKey: imageName];
}

//  ------------------------------------------------------------------------------------------------
- ( NSString * ) configureNameAtIndex:(NSInteger)index
{
    NSDictionary                  * infoData;
    NSString                      * subDir;
    NSString                      * configureName;
    
    configureName                   = nil;
    subDir                          = [self _GetStringDataAtIndex: index forKey: kTDPageInfoKeySubDir];
    infoData                        = [self infoDataAtIndex: index];
    if ( nil == infoData )
    {
        return nil;
    }
    
    configureName                   = [infoData objectForKey: kTDPageInfoKeyConfigure];
    if ( ( nil == configureName ) || ( [configureName length] == 0 ) )
    {
        return nil;
    }
    
    configureName                   = [subDir stringByAppendingPathComponent: configureName];
    configureName                   = [configureName stringByAppendingPathExtension: @"plist"];
    return configureName;
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
    
    configureName                   = [self configureNameAtIndex: index];
    if ( nil == configureName )
    {
        return nil;
    }
    return [self configureDataForKey: configureName];
}


//  ------------------------------------------------------------------------------------------------

//  ------------------------------------------------------------------------------------------------


@end

//  ------------------------------------------------------------------------------------------------
//  ------------------------------------------------------------------------------------------------
















