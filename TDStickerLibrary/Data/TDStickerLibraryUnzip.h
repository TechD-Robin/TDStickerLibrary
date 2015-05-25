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
#import "TDConfigureData.h"

//  ------------------------------------------------------------------------------------------------
//  ------------------------------------------------------------------------------------------------
/**
 *  a data object for unzip a zipped file of Sticker Library Unzip.
 *  the zipped file include configure file and other resources, 
 *  and the file can use password or not to zip by ZipCrypto. 
 */
@interface TDStickerLibraryUnzip : TDConfigureData


//  ------------------------------------------------------------------------------------------------
#pragma mark property of variable.
//  ------------------------------------------------------------------------------------------------


//  ------------------------------------------------------------------------------------------------
#pragma mark declare for get data in Zipped file.
//  ------------------------------------------------------------------------------------------------
/**
 *  @brief get a data in zipped file for key.
 *  get a data in zipped file for key.
 *
 *  @param aKey                     a key of data.
 *
 *  @return data|nil                the data or nil.
 */
- ( NSData * ) unzipDataForKey:(NSString *)aKey;

//  ------------------------------------------------------------------------------------------------
#pragma mark declare for get information data.
//  ------------------------------------------------------------------------------------------------
/**
 *  @brief get a information data at index.
 *  get a information data at index.
 *
 *  @param index                    index of information data.
 *
 *  @return data|nil                the container of information data or nil.
 */
- ( NSDictionary * ) infoDataAtIndex:(NSInteger)index;

//  ------------------------------------------------------------------------------------------------
/**
 *  @brief remove informatioin data from other information data list.
 *  remove informatioin data from other information data list.
 *
 *  @param infoDataList             a information data list.
 */
- ( void ) removeInfoData:(NSArray *)infoDataList;

//  ------------------------------------------------------------------------------------------------
/**
 *  @biref count of information data.
 *  count of information data.
 *
 *  @return count| 0                the count of information data or 0.
 */
- ( NSInteger ) infoDataCount;

//  ------------------------------------------------------------------------------------------------
/**
 *  @brief get data type is string data at information data index and for the data key.
 *  get data type is string data at information data index and for the data key.
 *
 *  @param index                    index of information data.
 *  @param aKey                     key of the information data container.
 *
 *  @return data|nil                the data for key or nil.
 */
- ( NSString * ) infoDataAtIndex:(NSInteger)index stringValueForKey:(NSString *)aKey;

//  ------------------------------------------------------------------------------------------------
/**
 *  @brief get data type is integer data at information data index and for the data key.
 *
 *  @param index                    index of information data.
 *  @param aKey                     key of the information data container.
 *
 *  @return data| -1                 the data for key or -1.
 */
- ( NSInteger ) infoDataAtIndex:(NSInteger)index integerValueForKey:(NSString *)aKey;

//  ------------------------------------------------------------------------------------------------

@end


//  ------------------------------------------------------------------------------------------------
//  ------------------------------------------------------------------------------------------------


