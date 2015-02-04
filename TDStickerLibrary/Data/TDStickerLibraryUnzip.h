//
//  TDStickerLibraryUnzip.h
//  TDStickerLibrary
//
//  Created by Robin Hsu on 2015/2/4.
//  Copyright (c) 2015年 TechD. All rights reserved.
//
//  ------------------------------------------------------------------------------------------------
//  ------------------------------------------------------------------------------------------------

#import <Foundation/Foundation.h>
#import "TDFoundation.h"

//  ------------------------------------------------------------------------------------------------
//  ------------------------------------------------------------------------------------------------
@interface TDStickerLibraryUnzip : NSObject

//  ------------------------------------------------------------------------------------------------
#pragma mark property of variable.
//  ------------------------------------------------------------------------------------------------


//  ------------------------------------------------------------------------------------------------
- ( instancetype ) initWithZipFile:(NSString *)filename forDirectories:(TDGetPathDirectory) directory inDirectory:(NSString *)subpath
                      inZippedPath:(NSString *)prefix with:(NSString *)password
                         configure:(NSString *)rootKey;

//  ------------------------------------------------------------------------------------------------
- ( BOOL ) updateDataFromZip:(NSString *)filename forDirectories:(TDGetPathDirectory) directory inDirectory:(NSString *)subpath
                inZippedPath:(NSString *)prefix with:(NSString *)password
                   configure:(NSString *)rootKey with:(NSString *)updateKey;


//  ------------------------------------------------------------------------------------------------
- ( NSData * ) unzipDataForKey:(NSString *)aKey;

//  ------------------------------------------------------------------------------------------------
- ( NSDictionary * ) infoDataAtIndex:(NSInteger)index;

- ( NSInteger ) infoDataCount;


//  ------------------------------------------------------------------------------------------------


@end


//  ------------------------------------------------------------------------------------------------
//  ------------------------------------------------------------------------------------------------
