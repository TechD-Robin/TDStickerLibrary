//
//  TDStickerLibraryTabPageInfo.h
//  TDStickerLibrary
//
//  Created by Robin Hsu on 2015/2/4.
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
 *  a data object for unzip a zipped file of Sticker Library Tab Page Info.
 *  the zipped file include configure file and other resources,
 *  and the file can use password or not to zip by ZipCrypto.
 */
@interface TDStickerLibraryTabPageInfo : TDStickerLibraryUnzip

//  ------------------------------------------------------------------------------------------------
#pragma mark property of variable.
//  ------------------------------------------------------------------------------------------------


//  ------------------------------------------------------------------------------------------------
#pragma mark declare for create the object.
//  ------------------------------------------------------------------------------------------------
/**
 *  @brief unzip a zipped file that is configure and resources about tab page information.
 *  unzip a zipped file that is configure and resources about tab page information.
 *
 *  @param filename                 zipped file name (without Extension part).
 *  @param directory                enumeration for directory.
 *  @param subpath                  resource's sub directory name of configure
 *  @param prefix                   prefix path name in zipped file.
 *  @param rootKey                  key of root of configure file(relation: tab info's 'Name').
 *
 *  @return object|nil              the Sticker Libaray Tab Page Info object or nil.
 */
+ ( instancetype ) loadDataFromZip:(NSString *)filename forDirectories:(TDGetPathDirectory) directory inDirectory:(NSString *)subpath
                      inZippedPath:(NSString *)prefix configure:(NSString *)rootKey;

//  ------------------------------------------------------------------------------------------------
/**
 *  @brief unzip a zipped file with password that is configure and resources about tab page information.
 *  unzip a zipped file with password that is configure and resources about tab page information.
 *
 *  @param filename                 zipped file name (without Extension part).
 *  @param directory                enumeration for directory.
 *  @param subpath                  resource's sub directory name of configure
 *  @param prefix                   prefix path name in zipped file.
 *  @param password                 password of zipped file.
 *  @param rootKey                  key of root of configure file(relation: tab info's 'Name').
 *
 *  @return object|nil              the Sticker Libaray Tab Page Info object or nil.
 */
+ ( instancetype ) loadDataFromZip:(NSString *)filename forDirectories:(TDGetPathDirectory) directory inDirectory:(NSString *)subpath
                      inZippedPath:(NSString *)prefix with:(NSString *)password
                         configure:(NSString *)rootKey;

//  ------------------------------------------------------------------------------------------------
#pragma mark declare for update this object.
//  ------------------------------------------------------------------------------------------------
/**
 *  @brief update data for the Sticker Libaray Tab Page Info object.
 *  update data for the Sticker Libaray Tab Page Info object.
 *
 *  @param filename                 zipped file name (without Extension part).
 *  @param directory                enumeration for directory.
 *  @param subpath                  resource's sub directory name of configure
 *  @param prefix                   prefix path name in zipped file.
 *  @param password                 password of zipped file.
 *  @param rootKey                  key of root of configure file(relation: tab info's 'Name').
 *
 *  @return YES|NO                  method success or failure.
 */
- ( BOOL ) updateDataFromZip:(NSString *)filename forDirectories:(TDGetPathDirectory) directory inDirectory:(NSString *)subpath
                inZippedPath:(NSString *)prefix with:(NSString *)password
                   configure:(NSString *)rootKey;

//  ------------------------------------------------------------------------------------------------
#pragma mark declare for get information data.
//  ------------------------------------------------------------------------------------------------
/**
 *  @brief get the ID of the information data at index.
 *  get the ID of the information data at index.
 *
 *  @param index                    index of information data.
 *
 *  @return ID|nil                  the ID or nil.
 */
- ( NSString * ) dataIDAtIndex:(NSInteger)index;

//  ------------------------------------------------------------------------------------------------
/**
 *  @brief get the title of the information data at index.
 *  get the title of the information data at index.
 *
 *  @param index                    index of information data.
 *
 *  @return title|nil               the title or nil.
 */
- ( NSString * ) dataTitleAtIndex:(NSInteger)index;

//  ------------------------------------------------------------------------------------------------
/**
 *  @brief get the mode of the information data at index.
 *  get the mode of the information data at index.
 *
 *  @param index                    index of information data.
 *
 *  @return mode| 0                 the mode or 0.
 */
- ( NSInteger ) dataModeAtIndex:(NSInteger)index;

//  ------------------------------------------------------------------------------------------------
/**
 *  @brief get the container's count of image name of the information data at index.
 *  get the container's count of image name of the information data at index.
 *
 *  @param index                    index of information data.
 *
 *  @return count| 0                the count of container or 0.
 */
- ( NSInteger ) countOfImageDataAtIndex:(NSInteger)index;

//  ------------------------------------------------------------------------------------------------
/**
 *  @brief get the image name at information data index and at image name's container index.
 *
 *  @param index                    index of information data.
 *  @param inArrayIndex             index of image name's container.
 *
 *  @return name|nil                the image name or nil.
 */
- ( NSString * ) imageNameAtIndex:(NSInteger)index inArray:(NSInteger)inArrayIndex;

//  ------------------------------------------------------------------------------------------------
#pragma mark declare for get data in Zipped file.
//  ------------------------------------------------------------------------------------------------
/**
 *  @brief get a image data in zipped file at information data index and for zipped file key.
 *  get a image data in zipped file at information data index and for zipped file key. (for preview image)
 *
 *  @param index                    index of information data.
 *  @param aKey                     a key of image data for zipped file.
 *
 *  @return data|nil                the image data or nil.
 */
- ( NSData * ) imageDataAtIndex:(NSInteger)index forKey:(NSString *)aKey;

//  ------------------------------------------------------------------------------------------------
/**
 *  @brief get a image data in zipped file at information data index and at image name's container index.
 *  get a image data in zipped file at information data index and at image name's container index.
 *
 *  @param index                    index of information data.
 *  @param inArrayIndex             index of image name's container.
 *
 *  @return data|nil                the image data or nil.
 */
- ( NSData * ) imageDataAtIndex:(NSInteger)index inArray:(NSInteger)inArrayIndex;

//  ------------------------------------------------------------------------------------------------
/**
 *  @brief get a configure data in zipped file at information data index.
 *  get a configure data(sprite's frame data) in zipped file at information data index. (for preview image)
 *
 *  @param index                    index of information data.
 *
 *  @return data|nil                the configure data or nil.
 */
- ( NSData * ) configureDataAtIndex:(NSInteger)index;

//  ------------------------------------------------------------------------------------------------


@end


//  ------------------------------------------------------------------------------------------------
//  ------------------------------------------------------------------------------------------------
