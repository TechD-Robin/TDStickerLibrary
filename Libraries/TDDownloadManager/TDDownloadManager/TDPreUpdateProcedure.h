//
//  TDPreUpdateProcedure.h
//  TDDownloadManager
//
//  Created by Robin Hsu on 2015/3/25.
//  Copyright (c) 2015年 TechD. All rights reserved.
//
//  ------------------------------------------------------------------------------------------------
//  ------------------------------------------------------------------------------------------------


#import <Foundation/Foundation.h>
#import "TDFoundation.h"


//  ------------------------------------------------------------------------------------------------
//  ------------------------------------------------------------------------------------------------
#pragma mark type define.
//  ------------------------------------------------------------------------------------------------
/**
 *  @brief a block section be executed when pre-update procedure is completed.
 *  a block section be executed when pre-update procedure is completed, these parameters will return completed information to method caller.
 *
 *  @param updateResponses          a container to store download file's information, include result of download;
 *                                  responses include these keys : 'update infos', 'error', 'filename', 'finished'.
 *  @param error                    a NSError object, if pre-update procedure failure then this object has error information, otherwise it's nil object.
 *  @param finished                 a boolean value, if pre-update procedure success then the value is YES, otherwise it's NO.
 *
 *  @return void                    nothing.
 */
typedef     void (^PreUpdateCompletionBlock)(NSDictionary * updateResponses, NSError * error, BOOL finished);

//  ------------------------------------------------------------------------------------------------
//  ------------------------------------------------------------------------------------------------


//  ------------------------------------------------------------------------------------------------
//  ------------------------------------------------------------------------------------------------
/**
 *  a pre-upload procedure object is provide simple method for check and update configure data at internet,
 *  this method compare with project's main functional, that can be executed at first timing.
 */
#pragma mark -
#pragma mark class TDPreUpdateProcedure
@interface TDPreUpdateProcedure : NSObject

//  ------------------------------------------------------------------------------------------------

//  ------------------------------------------------------------------------------------------------
#pragma mark property of variable.
//  ------------------------------------------------------------------------------------------------



//  ------------------------------------------------------------------------------------------------
#pragma mark declare for create the object.
//  ------------------------------------------------------------------------------------------------
/**
 *  @brief create a pre-update procedure object, check update condition from URL and save configure data.
 *  create a pre-update procedure object, check update condition from URL and save configure data which these parameters is path condition.
 *
 *  @param fileURL                  the URL of configure data at internet.
 *  @param filename                 save filename of configure data.
 *  @param subpath                  save file's path of configure data.
 *  @param directory                enumeration for directory.
 *
 *  @return object|nil              the pre-update object or nil.
 */
+ ( instancetype ) preUpdate:(NSString *)configureURL
                    withSave:(NSString *)filename into:(NSString *)subpath of:(TDGetPathDirectory)directory ;

//  ------------------------------------------------------------------------------------------------
#pragma mark declare for start procedure
//  ------------------------------------------------------------------------------------------------
/**
 *  @brief start this pre-update procedure to check and update configure data.
 *  start this pre-update procedure to check and update configure data, this method will check all data in configure data.
 */
- ( void ) startProcedure;

//  ------------------------------------------------------------------------------------------------
/**
 *  @brief start this pre-update procedure to check and update configure data.
 *  start this pre-update procedure to check and update configure data, this method will check configure data for a key
 *
 *  @param aKey                     a key of data
 */
- ( void ) startProcedureWithKey:(NSString *)aKey;

//  ------------------------------------------------------------------------------------------------
/**
 *  @brief start this pre-update procedure to check and update configure data.
 *  start this pre-update procedure to check and update configure data, this method will check configure data for keys
 *
 *  @param keyList                  keys of data
 */
- ( void ) startProcedureWithKeys:(NSArray *)keyList;

//  ------------------------------------------------------------------------------------------------
#pragma mark declare for base methos of procedure
//  ------------------------------------------------------------------------------------------------
/**
 *  @brief stop this pre-update procedure when complete.
 *  stop this pre-update procedure when complete, this method will clear up some temporary data of procedure.
 */
- ( void ) stopProcedure;

//  ------------------------------------------------------------------------------------------------
/**
 *  @brief set a block section be executed when pre-update procedure is completed.
 *  set a block section be executed when pre-update procedure is completed; if you need result of pre-update procedure, call this method.
 *
 *  @param completionBlock          a block section be executed when pre-update procedure completed.
 */
- ( void ) setPreUpdateCompletionBlock:(PreUpdateCompletionBlock)completionBlock;

//  ------------------------------------------------------------------------------------------------


@end

//  ------------------------------------------------------------------------------------------------
//  ------------------------------------------------------------------------------------------------



