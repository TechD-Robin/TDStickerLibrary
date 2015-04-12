//
//  TDDownloadManager.h
//  TDDownloadManager
//
//  Created by Robin Hsu on 2015/3/4.
//  Copyright (c) 2015年 TechD. All rights reserved.
//
//  ------------------------------------------------------------------------------------------------
//  ------------------------------------------------------------------------------------------------

#import <Foundation/Foundation.h>
#import "TDFoundation.h"

//  ------------------------------------------------------------------------------------------------
//  ------------------------------------------------------------------------------------------------
#pragma mark declare for get path.
//  ------------------------------------------------------------------------------------------------
/**
 *  @brief get a file's full path when the file can update data from URL.
 *  get a file's full path when the file can update data from URL.
 *  if can find the update's file in the update's directory then assign it to the current path, otherwise assign from original.
 *
 *  @param filename                 a original filename.
 *  @param subpath                  the original file's subpath of directory.
 *  @param directory                the original file's enumeration for directory.
 *  @param updateFilename           a update's filename.
 *  @param updateSubpath            the update's file's subpath of directory.
 *  @param updateDirectory          the update's file's enumeration of directory.
 *  @param updateTimestamp          the file update condition that was check for integer type.
 *
 *  @return filename|nil            a current filename with full path or nil.
 */
NSString * TDGetCurrentFilePathWithUpdate( NSString * filename, NSString * subpath, TDGetPathDirectory directory, NSString * updateFilename, NSString * updateSubpath, TDGetPathDirectory updateDirectory, NSString * updateTimestamp );

//  ------------------------------------------------------------------------------------------------
//  ------------------------------------------------------------------------------------------------


//  ------------------------------------------------------------------------------------------------
//  ------------------------------------------------------------------------------------------------
#pragma mark type define.
//  ------------------------------------------------------------------------------------------------
/**
 *  @brief a block section be executed when read json data from internet is completed.
 *  a block section be executed when read json data from internet is completed, these parameters will return completed information to method caller.
 *
 *  @param jsonContent              a container to store the JSON data.
 *  @param error                    a NSError object, if download method failure then this object has error informatioin, otherwise it's nil object.
 *  @param finished (YES|NO)        a boolean value, if download method success then the value is YES, otherwise it's NO.
 *
 *  @return void                    nothing.
 */
typedef     void (^ReadJSONCompletedCallbackBlock)(NSDictionary * jsonContent, NSError * error, BOOL finished);

//  ------------------------------------------------------------------------------------------------
/**
 *  @brief a block section be execute when download file from internet is completed.
 *  a block section be execute when download file from internet is completed, these parameters witll return completed information to method caller.
 *
 *  @param error                    a NSError object, if download method failure then this object has error information, otherwise it's nil object.
 *  @param fullPath                 save the download file to this file's full path.
 *  @param finished (YES|NO)        a boolean value, if download method success then the value is YES, otherwise it's NO.
 *
 *  @return void                    nothing.
 */
typedef     void (^DownloadCompletedCallbackBlock)(NSError * error, NSString * fullPath, BOOL finished);

//  ------------------------------------------------------------------------------------------------
//  the Download Manager provide method simply download data from URL;
//  build this object base on AFNetworking.
//  ------------------------------------------------------------------------------------------------
#pragma mark -
#pragma mark class TDDownloadManager
@interface TDDownloadManager : NSObject

//  ------------------------------------------------------------------------------------------------
#pragma mark declare for download file.
//  ------------------------------------------------------------------------------------------------
/**
 *  @brief download a file from URL and save the file to directory.
 *  download a file from URL and save the file to directory that is enumeration for directory.
 *
 *  @param downloadURL              the URL of file at internet.
 *  @param directory                enumeration for directory.
 *  @param completed                a block section be executed when download completed.
 *
 *  @return YES|NO                  method success or failure.
 */
+ ( BOOL ) simpleDownload:(NSString *)downloadURL forDirectory:(NSSearchPathDirectory)directory completed:(DownloadCompletedCallbackBlock)completed;

//  ------------------------------------------------------------------------------------------------
/**
 *  @brief download a file from URL and save the file to directory.
 *  download a file from URL and save the file to directory which these parameters is path condition for append;
 *  if find the same filename in the directory, don't download.
 *
 *  @param filename                 save filename.
 *  @param fileURL                  the URL of file at internet.
 *  @param subpath                  the subpath of directory.
 *  @param directory                enumeration for directory.
 *  @param timestamp                the file update condition that was check for integer type.
 *  @param completed                a block section be executed when download completed.
 *
 *  @return YES|NO                  method success or failure.
 */
+ ( BOOL ) download:(NSString *)filename from:(NSString *)fileURL into:(NSString *)subpath of:(TDGetPathDirectory)directory updateCheckBy:(NSString *)timestamp
          completed:(DownloadCompletedCallbackBlock)completed ;

//  ------------------------------------------------------------------------------------------------
/**
 *  @brief download a file from URL and save the file to directory.
 *  download a file from URL and save the file to directory which these parameters is path condition for append.
 * if find the same filename in the directory, download and replace it.
 *
 *  @param filename                 save filename.
 *  @param fileURL                  the URL of file at internet.
 *  @param subpath                  the subpath of directory
 *  @param directory                enumeration for directory.
 *  @param completed                a block section be executed when download completed.
 *
 *  @return YES|NO                  method success or failure.
 */
+ ( BOOL ) replacementDownload:(NSString *)filename from:(NSString *)fileURL into:(NSString *)subpath of:(TDGetPathDirectory)directory
                     completed:(DownloadCompletedCallbackBlock)completed;

//  ------------------------------------------------------------------------------------------------
#pragma mark declare for download JSON data.
//  ------------------------------------------------------------------------------------------------
/**
 *  @brief download a JSON data from URL and assign the data into container of callback block.
 *  download a JSON data from URL and assign the data into container of callback block.
 *
 *  @param jsonURL                  the URL of JSON data at internet.
 *  @param completed                a block section be executed when download completed.
 *
 *  @return YES|NO                  method success or failure.
 */
+ ( BOOL ) readJSONFile:(NSString *)jsonURL completed:(ReadJSONCompletedCallbackBlock)completed;

//  ------------------------------------------------------------------------------------------------
/**
 *  @brief download a JSON data from URL and assign the data into container of callback block, and save the data to file.
 *  download a JSON data from URL and assign the data into container of callback block, 
 *  and save the data to file of directory which these parameters is path condition for append.
 *
 *  @param jsonURL                  the URL of JSON data at internet.
 *  @param filename                 save JSON filename.
 *  @param subpath                  the subpath of directory
 *  @param directory                enumeration for directory.
 *  @param timestamp                the file update condition that was check for integer type.
 *  @param completed                a block section be executed when download completed.
 *
 *  @return YES|NO                  method success or failure.
 */
+ ( BOOL ) readJSONFile:(NSString *)jsonURL
               withSave:(NSString *)filename into:(NSString *)subpath of:(TDGetPathDirectory)directory extension:(NSString *)timestamp
             completed:(ReadJSONCompletedCallbackBlock)completed;

//  ------------------------------------------------------------------------------------------------
/**
 *  @brief download a JSON data from URL and assign the data into container of callback block, and save the data to file.
 *  download a JSON data from URL and assign the data into container of callback block, and save the data to full path of file.
 *
 *  @param jsonURL                  the URL of JSON data at internet.
 *  @param fullPath                 save JSON's full path of file.
 *  @param completed                a block section be executed when download completed.
 *
 *  @return YES|NO                  method success or failure.
 */
+ ( BOOL ) readJSONFile:(NSString *)jsonURL withSaveInto:(NSString *)fullPath completed:(ReadJSONCompletedCallbackBlock)completed;

//  ------------------------------------------------------------------------------------------------
//  ------------------------------------------------------------------------------------------------


@end

//  ------------------------------------------------------------------------------------------------
//  ------------------------------------------------------------------------------------------------













