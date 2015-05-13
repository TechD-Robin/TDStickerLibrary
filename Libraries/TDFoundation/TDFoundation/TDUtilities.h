//
//  TDUtilities.h
//  TDFoundation
//
//  Created by Robin Hsu on 2015/1/25.
//  Copyright (c) 2015年 TechD. All rights reserved.
//
//  ------------------------------------------------------------------------------------------------
//  ------------------------------------------------------------------------------------------------

#import <Foundation/Foundation.h>
#import <Availability.h>

@interface TDUtilities : NSObject

@end

/**
 *  directory enumeration, and refer from NSSearchPathDirectory to define.
 */
typedef NS_ENUM( NSUInteger, TDGetPathDirectory ){
    TDLibraryDirectory              = NSLibraryDirectory,
    TDDocumentDirectory             = NSDocumentDirectory,
    TDCachesDirectory               = NSCachesDirectory,
    TDHomeDirectory                 = 201,
    TDTemporaryDirectory            = 202,
    TDResourcesDirectory            = 301,
};


//  ------------------------------------------------------------------------------------------------
/**
 *  @brief get the string of file's full path with path directory's enumeration.
 *  get the string of file's full path with path directory's enumeration, merge with NSSearchPathForDirectoriesInDomains and NSBundle's pathForResource: ofType: inDirectory: method.
 *
 *  @param directory                enumeration of directory.
 *  @param name                     the filename want to find.
 *  @param typeExt                  ext port of filename.(sub filename)
 *  @param inDirectorySubpath       sub path in directory.
 *  @param checkFileExist           use this method to check file exist in directory or not.
 *
 *  @return full path|nil           the file's full path or nil.
 */
NSString * TDGetPathForDirectories( TDGetPathDirectory directory, NSString * name, NSString * typeExt, NSString * inDirectorySubpath, BOOL checkFileExist );

//  ------------------------------------------------------------------------------------------------
/**
 *  @brief get the string of file's full path with timestamp and path directory's enumeration.
 *  get the string of file's full path with timestamp and path directory's enumeration, merge with NSSearchPathForDirectoriesInDomains and NSBundle's pathForResource: ofType: inDirectory: method.
 *
 *  @param directory                enumeration of directory.
 *  @param name                     the filename want to find.
 *  @param timestamp                a timestamp string.
 *  @param typeExt                  ext port of filename.(sub filename)
 *  @param inDirectorySubpath       sub path in directory.
 *  @param checkFileExist           use this method to check file exist in directory or not.
 *
 *  @return full path|nil           the file's full path or nil.
 */
NSString * TDGetPathForDirectoriesWithTimestamp( TDGetPathDirectory directory, NSString * name, NSString * timestamp, NSString * typeExt, NSString * inDirectorySubpath, BOOL checkFileExist );

//  ------------------------------------------------------------------------------------------------
/**
 *  @brief get the image name with scale when the name without ext port.
 *  get the image name with scale when the name without ext port. ( like 'name' to 'name@2x.png', 'name@3x.png' ).
 *
 *  @param imageName                file name of image. (png)
 *  @param scaleScreen              scale of Canvas Size (pts) to Design Canvas (px).
 *
 *  @return image name|nil          the name with scale|nil
 */
NSString * TDGetImageNameForScreenScale( NSString * imageName, NSInteger scaleScreen ) NS_DEPRECATED_IOS(6_0, 7_1, "use TDGetPNGImageFilenameWithAssetScale"); ;

//  ------------------------------------------------------------------------------------------------
/**
 *  @brief get a PNG image's filename with asset scale.
 *  get a PNG image's filename with asset scale.
 *
 *  @param filename                 a image filename wannt to append. (png)
 *  @param assetScale               scale of asset. (Canvas Size (pts) to Design Canvas (px))
 *
 *  @return filename|nil            the name with scale or nil.
 */
NSString * TDGetPNGImageFilenameWithAssetScale( NSString * filename, NSInteger assetScale );

//  ------------------------------------------------------------------------------------------------
/**
 *  @brief get a filename with asset scale.
 *  get a filename with asset scale. ( filename format like 'abc@1x', 'abc@2x.png', 'abc@3x.xyz' ).
 *
 *  @param filename                 a filename want to append.
 *  @param assetScale               scale of asset.
 *
 *  @return filename|nil            format's filename or nil.
 */
NSString * TDGetFilenameWithAssetScale( NSString * filename, NSInteger assetScale );

//  ------------------------------------------------------------------------------------------------
/**
 *  @brief check a filename is with asset scale or not.
 *  check a filename is with asset scale or not. ( filename format like 'abc@1x', 'abc@2x.png', 'abc@3x.xyz'; without '@0x' ).
 *
 *  @param filename                 the filename want to check.
 *
 *  @return YES|NO                  filename is match format or not.
 */
BOOL TDCheckFilenameWithAssetScale( NSString * filename );

//  ------------------------------------------------------------------------------------------------


















