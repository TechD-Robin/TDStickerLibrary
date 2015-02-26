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
#pragma mark declare private category ()
//  ------------------------------------------------------------------------------------------------
@interface TDStickerLibraryTabPageInfo ()
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
#pragma mark declare for get data in Zipped file.
//  ------------------------------------------------------------------------------------------------
/**
 *  @brief get a image data in zipped file for key.
 *  get a image data in zipped file for key.
 *
 *  @param aKey                     a key of data.
 *
 *  @return data|nil                the image data for key or nil.
 */
- ( NSData * ) _GetImageDataForKey:(NSString *)aKey;

//  ------------------------------------------------------------------------------------------------
#pragma mark declare for get information data.
//  ------------------------------------------------------------------------------------------------
/**
 *  @brief get data type is string data at information data index and for the data key.
 *
 *  @param index                    index of information data.
 *  @param aKey                     key of the information data container.
 *
 *  @return data|nil                the data for key or nil.
 */
- ( NSString * ) _GetStringDataAtIndex:(NSInteger)index forKey:(NSString *)aKey;

//  ------------------------------------------------------------------------------------------------
/**
 *  @brief get data type is integer data at information data index and for the data key.
 *
 *  @param index                    index of information data.
 *  @param aKey                     key of the information data container.
 *
 *  @return data| 0                 the data for key or 0.
 */
- ( NSInteger ) _GetIntegerDataAtIndex:(NSInteger)index forKey:(NSString *)aKey;

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
    
}

//  ------------------------------------------------------------------------------------------------
#pragma mark method for get data in Zipped file.
//  ------------------------------------------------------------------------------------------------
- ( NSData * ) _GetImageDataForKey:(NSString *)aKey
{
    aKey                            = TDGetImageNameForScreenScale( aKey, (NSInteger)[[UIScreen mainScreen] scaleMultiple] );
    if ( nil == aKey )
    {
        return nil;
    }
    return [self unzipDataForKey: aKey];
}

//  ------------------------------------------------------------------------------------------------
#pragma mark method for get information data.
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
#pragma mark method for create the object.
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
#pragma mark method for update this object.
//  ------------------------------------------------------------------------------------------------
- ( BOOL ) updateDataFromZip:(NSString *)filename forDirectories:(TDGetPathDirectory) directory inDirectory:(NSString *)subpath
                inZippedPath:(NSString *)prefix with:(NSString *)password
                   configure:(NSString *)rootKey
{
    return [self updateDataFromZip: filename forDirectories: directory inDirectory: subpath inZippedPath: prefix with: password configure: rootKey with: kTDPageInfoKeyID];
}


//  ------------------------------------------------------------------------------------------------
#pragma mark method for get information data.
//  ------------------------------------------------------------------------------------------------
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
#pragma mark method for get data in Zipped file.
//  ------------------------------------------------------------------------------------------------
- ( NSData * ) imageDataAtIndex:(NSInteger)index forKey:(NSString *)aKey;
{
//    aKey                            = TDGetImageNameForScreenScale( aKey, (NSInteger)[[UIScreen mainScreen] scaleMultiple] );
    if ( nil == aKey )
    {
        return nil;
    }
    
    NSString                      * subDir;
    NSString                      * imageName;
    
    imageName                       = nil;
    subDir                          = [self _GetStringDataAtIndex: index forKey: kTDPageInfoKeySubDir];
    if ( ( nil == subDir ) || ( [subDir length] == 0 ) )
    {
        return [self _GetImageDataForKey: aKey];
    }
    
    imageName                       = [subDir stringByAppendingPathComponent: aKey];
    return [self _GetImageDataForKey: imageName];
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
    return [self _GetImageDataForKey: imageName];
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


@end

//  ------------------------------------------------------------------------------------------------
//  ------------------------------------------------------------------------------------------------
















