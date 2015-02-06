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
 *
 *  @return full path|nil           the file's full path or nil.
 */
NSString * TDGetPathForDirectories( TDGetPathDirectory directory, NSString * name, NSString * typeExt, NSString * inDirectorySubpath );

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
NSString * TDGetImageNameForScreenScale( NSString * imageName, NSInteger scaleScreen );


//  ------------------------------------------------------------------------------------------------


















