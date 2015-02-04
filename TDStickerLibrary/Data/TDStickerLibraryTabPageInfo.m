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
#import "TDStickerLibraryTabPageInfo.h"


//  ------------------------------------------------------------------------------------------------
static  NSString  * const kTDPageInfoKeyID                          = @"ID";

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

//  ------------------------------------------------------------------------------------------------


@end

//  ------------------------------------------------------------------------------------------------
//  ------------------------------------------------------------------------------------------------
















