//
//  TDStickerLibraryTabInfo.h
//  TDStickerLibrary
//
//  Created by Robin Hsu on 2015/1/21.
//  Copyright (c) 2015年 TechD. All rights reserved.
//
//  ------------------------------------------------------------------------------------------------
//  ------------------------------------------------------------------------------------------------

#import <Foundation/Foundation.h>
#import "TDFoundation.h"

#import "TDStickerLibraryUnzip.h"

//  ------------------------------------------------------------------------------------------------
//  ------------------------------------------------------------------------------------------------
@interface TDStickerLibraryTabInfo : TDStickerLibraryUnzip

//  ------------------------------------------------------------------------------------------------
#pragma mark property of variable.
//  ------------------------------------------------------------------------------------------------


//  ------------------------------------------------------------------------------------------------
+ ( instancetype ) loadDataFromZip:(NSString *)filename forDirectories:(TDGetPathDirectory) directory inDirectory:(NSString *)subpath inZippedPath:(NSString *)prefix;

+ ( instancetype ) loadDataFromZip:(NSString *)filename forDirectories:(TDGetPathDirectory) directory inDirectory:(NSString *)subpath inZippedPath:(NSString *)prefix with:(NSString *)password;

//  ------------------------------------------------------------------------------------------------
- ( BOOL ) updateDataFromZip:(NSString *)filename forDirectories:(TDGetPathDirectory) directory inDirectory:(NSString *)subpath inZippedPath:(NSString *)prefix with:(NSString *)password;

//  ------------------------------------------------------------------------------------------------
- ( BOOL ) isInfoDataEnabledAtIndex:(NSInteger)index;

- ( NSInteger ) indexOfInfoDataEnabledAtOrder:(NSInteger)order;

- ( NSArray * ) imagesNameAtIndex:(NSInteger)index;

- ( NSData * ) imageDataForKey:(NSString *)aKey;

- ( NSString * ) configureKeyAtIndex:(NSInteger)index;      //  name.

- ( NSString * ) configureNameAtIndex:(NSInteger)index;

- ( NSString * ) dataLinkAtIndex:(NSInteger)index;

//  ------------------------------------------------------------------------------------------------


@end


//  ------------------------------------------------------------------------------------------------
//  ------------------------------------------------------------------------------------------------
