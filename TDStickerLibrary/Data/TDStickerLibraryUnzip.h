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
/**
 *  a data object for unzip a zipped file of Sticker Library Unzip.
 *  the zipped file include configure file and other resources, 
 *  and the file can use password or not to zip by ZipCrypto. 
 */
@interface TDStickerLibraryUnzip : NSObject

//  ------------------------------------------------------------------------------------------------
#pragma mark property of variable.
//  ------------------------------------------------------------------------------------------------


//  ------------------------------------------------------------------------------------------------
#pragma mark declare for create the object.
//  ------------------------------------------------------------------------------------------------
/**
 *  @brief initial a Sticker Libaray Unzip object.
 *  initial a Sticker Libaray Unzip object.
 *
 *  @param filename                 zipped file name (without Extension part).
 *  @param directory                enumeration for directory.
 *  @param subpath                  resource's sub directory name of configure
 *  @param prefix                   prefix path name in zipped file.
 *  @param password                 password of zipped file.
 *  @param rootKey                  key of root of configure file.
 *
 *  @return object|nil              the Sticker Library Unzip object or nil.
 */
- ( instancetype ) initWithZipFile:(NSString *)filename forDirectories:(TDGetPathDirectory) directory inDirectory:(NSString *)subpath
                      inZippedPath:(NSString *)prefix with:(NSString *)password
                         configure:(NSString *)rootKey;

//  ------------------------------------------------------------------------------------------------
/**
 *  @brief initial a Sticker Libaray Unzip object.
 *  initial a Sticker Libaray Unzip object.
 *
 *  @param fullPath                 zipped file name (full path).
 *  @param prefix                   prefix path name in zipped file.
 *  @param password                 password of zipped file.
 *  @param rootKey                  key of root of configure file.
 *
 *  @return object|nil              the Sticker Library Unzip object or nil.
 */
- ( instancetype ) initWithZipFile:(NSString *)fullPath
                      inZippedPath:(NSString *)prefix with:(NSString *)password
                         configure:(NSString *)rootKey;


//  ------------------------------------------------------------------------------------------------
#pragma mark declare for update this object.
//  ------------------------------------------------------------------------------------------------
/**
 *  @brief update data for the Sticker Libaray Unzip object.
 *  update data for the Sticker Libaray Unzip object.
 *
 *  @param filename                 zipped file name (without Extension part).
 *  @param directory                enumeration for directory.
 *  @param subpath                  resource's sub directory name of configure
 *  @param prefix                   prefix path name in zipped file.
 *  @param password                 password of zipped file.
 *  @param rootKey                  key of root of configure file.
 *  @param updateKey                key for update data.
 *
 *  @return YES|NO                  method success or failure.
 */
- ( BOOL ) updateDataFromZip:(NSString *)filename forDirectories:(TDGetPathDirectory) directory inDirectory:(NSString *)subpath
                inZippedPath:(NSString *)prefix with:(NSString *)password
                   configure:(NSString *)rootKey with:(NSString *)updateKey;


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
#pragma mark declare for special i/o information data.
//  ------------------------------------------------------------------------------------------------
/**
 *  @brief swap the information data with index.
 *  swap the information data with index, the current pointer is point from all's to one.
 *  that's mean the container have only a current data at index.
 *
 *  @param index                    index of information data.
 *
 *  @return YES|NO                  method success or failure.
 */
- ( BOOL ) swapInfoDataWithIndex:(NSInteger)index;

//  ------------------------------------------------------------------------------------------------
/**
 *  @brief reverse the information data.
 *  reverse the information data to un-swapped.
 *
 *  @return YES|NO                  method success or failure.
 */
- ( BOOL ) reverseInfoData;

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


