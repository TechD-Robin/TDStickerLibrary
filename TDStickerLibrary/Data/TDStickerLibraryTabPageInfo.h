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
#pragma mark declare enumeration.
//  ------------------------------------------------------------------------------------------------
/**
 *  enumeration for Sticker Library's Page Section data mode.
 */
typedef NS_ENUM( NSInteger, TDStickerLibraryPageSectionDataMode ){
    /**
     *  data mode is normal.
     */
    TDStickerLibraryPageSectionModeNormal           = 0,
    /**
     *  data mode is preview. ( preview image is high quality. )
     */
    TDStickerLibraryPageSectionModePreview          = 1,
    /**
     *  data mode is preview & must download.
     */
    TDStickerLibraryPageSectionModePreviewDownload  = 2,
};

//  ------------------------------------------------------------------------------------------------
//  ------------------------------------------------------------------------------------------------


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
 *  @brief get the mode of the informatioin data at index.
 *  get the mode of the informatioin data at index.
 *
 *  @param dataMode                 pointer of the mode to get result.
 *  @param index                    index of information data.
 *
 *  @return YES|NO                  method success or failure.
 */
- ( BOOL ) dataMode:(NSInteger *)dataMode atIndex:(NSInteger)index;


//  ------------------------------------------------------------------------------------------------
/**
 *  @brief get the illustrator of the information data at index.
 *  get the illustrator of the information data at index.
 *
 *  @param index                    index of information data.
 *
 *  @return illustrator|nil         the illustrator or nil.
 */
- ( NSString * ) illustratorAtIndex:(NSInteger)index;

//  ------------------------------------------------------------------------------------------------
/**
 *  @brief get the illustrator's E-Mail of the information data at index.
 *  get the illustrator's E-Mail of the information data at index.
 *
 *  @param index                    index of information data.
 *
 *  @return email|nil               the email or nil.
 */
- ( NSString * ) illustratorEMailAtIndex:(NSInteger)index;

//  ------------------------------------------------------------------------------------------------
/**
 *  @brief get the illustrator' website of the information data at index.
 *  get the illustrator' website of the information data at index.
 *
 *  @param index                    index of information data.
 *
 *  @return websit|nil              the websit or nil.
 */
- ( NSString * ) illustratorWebsiteAtIndex:(NSInteger)index;

//  ------------------------------------------------------------------------------------------------
/**
 *  @brief get the descript of the information data at index.
 *  get the descript of the information data at index.
 *
 *  @param index                    index of information data.
 *
 *  @return description|nil         the description or nil.
 */
- ( NSString * ) descriptionAtIndex:(NSInteger)index;

////  ------------------------------------------------------------------------------------------------
///**
// *  @brief get the image's index of introducation of the information data at index.
// *
// *  @param imageIndex               pointer of the images's index to get result.
// *  @param index                    index of information data.
// *
// *  @return YES|NO                  method success or failure.
// */
//- ( BOOL ) introImageIndex:(NSInteger *)imageIndex atIndex:(NSInteger)index;

//  ------------------------------------------------------------------------------------------------
/**
 *  @brief get the image's name of introducation of the information data at index.
 *  get the image's name of introducation of the information data at index.
 *
 *  @param index                    index of information data.
 *
 *  @return name|nil                the image name or nil.
 */
- ( NSString * ) introImageNameAtIndex:(NSInteger)index;

//  ------------------------------------------------------------------------------------------------
/**
 *  @brief get the image of introducation of the information data at index.
 *  get the image of introducation of the information data at index.
 *
 *  @param index                    index of information data.
 *
 *  @return image|nil                the image or nil.
 */
- ( UIImage * ) introImageAtIndex:(NSInteger)index;

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
 *  get the image name at information data index and at image name's container index.
 *
 *  @param index                    index of information data.
 *  @param inArrayIndex             index of image name's container.
 *
 *  @return name|nil                the image name or nil.
 */
- ( NSString * ) imageNameAtIndex:(NSInteger)index inArray:(NSInteger)inArrayIndex;


//  ------------------------------------------------------------------------------------------------
/**
 *  @brief check the date at informatioin data index, that is effective period or not.
 *  check the date at informatioin data index, that is effective period or not.
 *
 *  @param data                     pointer of the result of method, to express the date is effective period or not.
 *  @param index                    index of information data.
 *
 *  @return YES|NO                  method success or failure.
 */
- ( BOOL ) isActive:(BOOL *)data atIndex:(NSInteger)index;


//  ------------------------------------------------------------------------------------------------
/**
 *  @brief get the configure name of the information data at index.
 *  get the configure name of the information data at index.
 *
 *  @param index                    index of information data.
 *
 *  @return name|nil                the configure name or nil.
 */
- ( NSString * ) configureNameAtIndex:(NSInteger)index;

//  ------------------------------------------------------------------------------------------------
/**
 *  @brief get the timestamp of the information data at index
 *  get the timestamp of the information data at index.
 *
 *  @param index                    index of information data.
 *
 *  @return timestamp|nil           update's timestamp or nil.
 */
- (NSString * ) timestampAtIndex:(NSInteger)index;

//  ------------------------------------------------------------------------------------------------
/**
 *  @brief get the data link of the information data at index.
 *  get the data link of the information data at index; the download data from this URL of sticker.
 *
 *  @param index                    index of information data.
 *
 *  @return data|nil                the data link or nil.
 */
- ( NSString * ) dataLinkAtIndex:(NSInteger)index;

//  ------------------------------------------------------------------------------------------------
#pragma mark declare for get data in Zipped file.
//  ------------------------------------------------------------------------------------------------
/**
 *  @brief get a image in zipped file at information data index and for zipped file key.
 *  get a image in zipped file at information data index and for zipped file key. (for preview image)
 *
 *  @param index                    index of information data.
 *  @param aKey                     a key of image for zipped file.
 *
 *  @return image|nil                the image or nil.
 */
- ( UIImage * ) imageAtIndex:(NSInteger)index forKey:(NSString *)aKey;

//  ------------------------------------------------------------------------------------------------
/**
 *  @brief get a image in zipped file at information data index and at image name's container index.
 *  get a image in zipped file at information data index and at image name's container index.
 *
 *  @param index                    index of information data.
 *  @param inArrayIndex             index of image name's container.
 *
 *  @return image|nil                the image or nil.
 */
- ( UIImage * ) imageAtIndex:(NSInteger)index inArray:(NSInteger)inArrayIndex;

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
