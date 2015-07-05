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
/**
 *  a data object for unzip a zipped file of Sticker Library Tab Info.
 *  the zipped file include configure file and other resources,
 *  and the file can use password or not to zip by ZipCrypto.
 */
@interface TDStickerLibraryTabInfo : TDStickerLibraryUnzip

//  ------------------------------------------------------------------------------------------------
#pragma mark property of variable.
//  ------------------------------------------------------------------------------------------------


//  ------------------------------------------------------------------------------------------------
#pragma mark declare for create the object.
//  ------------------------------------------------------------------------------------------------
/**
 *  @brief unzip a zipped file with password that is configure and resources about tab information.
 *  unzip a zipped file with password that is configure and resources about tab information.
 *
 *  @param filename                 zipped file name (without Extension part).
 *  @param directory                enumeration for directory.
 *  @param subpath                  resource's sub directory name of configure
 *  @param prefix                   prefix path name in zipped file.
 *  @param password                 password of zipped file.
 *
 *  @return object|nil              the Sticker Libaray Tab Info object or nil.
 */
+ ( instancetype ) loadDataFromZip:(NSString *)filename forDirectories:(TDGetPathDirectory) directory inDirectory:(NSString *)subpath
                      inZippedPath:(NSString *)prefix with:(NSString *)password;

//  ------------------------------------------------------------------------------------------------
/**
 *  @brief unzip a zipped file with password that is configure and resources about tab information.
 *  unzip a zipped file with password that is configure and resources about tab information.
 *
 *  @param fullPath                 zipped file name (full path).
 *  @param prefix                   prefix path name in zipped file.
 *  @param password                 password of zipped file.
 *
 *  @return object|nil              the Sticker Libaray Tab Info object or nil.
 */
+ ( instancetype ) loadDataFromzip:(NSString *)fullPath inZippedPath:(NSString *)prefix with:(NSString *)password;

//  ------------------------------------------------------------------------------------------------
#pragma mark declare for update this object.
//  ------------------------------------------------------------------------------------------------
/**
 *  @brief update data for the Sticker Libaray Tab Info object.
 *  update data for the Sticker Libaray Tab Info object.
 *
 *  @param filename                 zipped file name (without Extension part).
 *  @param directory                enumeration for directory.
 *  @param subpath                  resource's sub directory name of configure
 *  @param prefix                   prefix path name in zipped file.
 *  @param password                 password of zipped file.
 *
 *  @return YES|NO                  method success or failure.
 */
- ( BOOL ) updateDataFromZip:(NSString *)filename forDirectories:(TDGetPathDirectory) directory inDirectory:(NSString *)subpath inZippedPath:(NSString *)prefix with:(NSString *)password;

//  ------------------------------------------------------------------------------------------------
#pragma mark declare for get data in Zipped file.
//  ------------------------------------------------------------------------------------------------
/**
 *  @brief get a image data in zipped file for key.
 *  get a image data in zipped file for key.
 *
 *  @param aKey                     a key of image data.
 *
 *  @return data|nil                the image data or nil.
 */
- ( NSData * ) imageDataForKey:(NSString *)aKey;

//  ------------------------------------------------------------------------------------------------
#pragma mark declare for get information data.
//  ------------------------------------------------------------------------------------------------
/**
 *  @brief sort these information data.
 *  sort these information data
 *
 *  @return YES|NO                  method success or failure.
 */
- ( BOOL ) sortInfoData;

//  ------------------------------------------------------------------------------------------------
/**
 *  @brief check the information data is enabled or not.
 *  check the information data(tab information) is enabled or not.
 *
 *  @param index                    index of information data.
 *
 *  @return YES|NO                  enabled or disabled.
 */
- ( BOOL ) isInfoDataEnabledAtIndex:(NSInteger)index;

//  ------------------------------------------------------------------------------------------------
/**
 *  @brief get index of the information data is enabled by order.
 *  get index of the information data is enabled by order.
 *
 *  @param order                    order for enabled data.
 *
 *  @return index| -1               index or -1.
 */
- ( NSInteger ) indexOfInfoDataEnabledAtOrder:(NSInteger)order;

//  ------------------------------------------------------------------------------------------------
/**
 *  @brief get the image name of the information data at index.
 *  get the image name of the information data at index.
 *
 *  @param index                    index of information data.
 *
 *  @return data|nil                the container of information data or nil.
 */
- ( NSArray * ) imagesNameAtIndex:(NSInteger)index;

//  ------------------------------------------------------------------------------------------------
/**
 *  @biref get the key of the information data at index.
 *  get the key(name) of the information data at index.
 *
 *  @param index                    index of information data.
 *
 *  @return key|nil                 the key of information data or nil.
 */
- ( NSString * ) configureKeyAtIndex:(NSInteger)index;

//  ------------------------------------------------------------------------------------------------
/**
 *  @brief get the configure name of the information data at index.
 *  get the configure name of the information data at index; the configure name use for tab page.
 *
 *  @param index                    index of information data.
 *
 *  @return name|nil                the configure name or nil.
 */
- ( NSString * ) configureNameAtIndex:(NSInteger)index;

//  ------------------------------------------------------------------------------------------------
/**
 *  @brief get the timestamp of the information data at index
 *  get the timestamp of the information data at index; check configure update with this value.
 *
 *  @param index                    index of information data.
 *
 *  @return timestamp|nil           update's timestamp or nil.
 */
- (NSString * ) timestampAtIndex:(NSInteger)index;

//  ------------------------------------------------------------------------------------------------
/**
 *  @brief get the data link of the information data at index.
 *  get the data link of the information data at index; must download data from this URL for tab page.
 *
 *  @param index                    index of information data.
 *
 *  @return data|nil                the data link or nil.
 */
- ( NSString * ) dataLinkAtIndex:(NSInteger)index;

//  ------------------------------------------------------------------------------------------------


@end


//  ------------------------------------------------------------------------------------------------
//  ------------------------------------------------------------------------------------------------
