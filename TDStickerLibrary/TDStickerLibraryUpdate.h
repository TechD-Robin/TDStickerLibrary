//
//  TDStickerLibraryUpdate.h
//  TDStickerLibrary
//
//  Created by Robin Hsu on 2015/4/13.
//  Copyright (c) 2015年 TechD. All rights reserved.
//
//  ------------------------------------------------------------------------------------------------
//  ------------------------------------------------------------------------------------------------


#import "TDStickerLibrary.h"


//  ------------------------------------------------------------------------------------------------
//  ------------------------------------------------------------------------------------------------
#pragma mark type define.
//  ------------------------------------------------------------------------------------------------
/**
 *  @brief a block section be executed when update procedure is completed.
 *  a block section be executed when update procedure is completed, these parameters will return completed information to method caller.
 *
 *  @param updateResponses          a container to store download file's information, include result of download;
 *                                  responses include these keys : 'error', 'filename' & 'finished'.
 *  @param error                    a NSError object, if update procedure failure then this object has error information, otherwise it's nil object.
 *  @param finished                 a boolean value, if update procedure success then the value is YES, otherwise it's NO.
 *
 *  @return void                    nothing.
 */
typedef     void (^UpdateCompletionBlock)(NSDictionary * updateResponses, NSError * error, BOOL finished);

//  ------------------------------------------------------------------------------------------------
//  ------------------------------------------------------------------------------------------------


//  ------------------------------------------------------------------------------------------------
//  ------------------------------------------------------------------------------------------------
/**
 *  a upload procedure object is provide simple method for check and update configure data at internet,
 *  this method compare with project's main functional, that can be executed at first timing.
 */
@interface TDStickerLibraryUpdate : NSObject

//  ------------------------------------------------------------------------------------------------

//  ------------------------------------------------------------------------------------------------
#pragma mark property of variable.
//  ------------------------------------------------------------------------------------------------
/**
 *  delegate for this system's extension.
 *  delegate's protocol please to reference header file : TDStickerLibraryExtension.h.
 */
@property ( nonatomic, assign ) id                              idExtensionDelegate;


//  ------------------------------------------------------------------------------------------------
#pragma mark declare for create the object.
//  ------------------------------------------------------------------------------------------------
/**
 *  @brief create a Sticker Library Update procedure object.
 *  create a Sticker Library Update procedure object; because customization is nil, system will auto create one.
 *
 *  @return object|nil              the Sticker Library Update object or nil.
 */
+ ( instancetype ) stickerLibraryUpdate;

//  ------------------------------------------------------------------------------------------------
/**
 *  @brief create a Sticker Library Update procedure object with customization object.
 *  create a Sticker Library Update procedure object with customization object.
 *
 *  @param custom                   a customization configure for the Sticker Library View Controller.
 *
 *  @return object|nil              the Sticker Library Update object or nil.
 */
+ ( instancetype ) stickerLibraryUpdateWithCustomization:(TDStickerLibraryCustomization *)custom;

//  ------------------------------------------------------------------------------------------------
#pragma mark declare for start procedure
//  ------------------------------------------------------------------------------------------------
/**
 *  @brief start this update procedure to check and update configure data.
 *  start this update procedure to check and update configure data, the method will check configure data for keys
 *
 *  @param updateURL                the URL of configure data at internet.
 *  @param keyList                  keys of configure data
 */
- ( void ) startUpdateSystemConfigure:(NSString *)updateURL forSearch:(NSArray *)keyList;

//  ------------------------------------------------------------------------------------------------
#pragma mark declare for base methos of procedure
//  ------------------------------------------------------------------------------------------------
/**
 *  @brief stop this update procedure when complete.
 *  stop this update procedure when complete, this method will clear up some temporary data of procedure.
 */
- ( void ) stopProcedure;

//  ------------------------------------------------------------------------------------------------
/**
 *  @brief set a block section be executed when update procedure is completed.
 *  set a block section be executed when update procedure is completed; if you need result of update procedure, call this method.
 *
 *  @param completionBlock          a block section be executed when update procedure completed.
 */
- ( void ) setUpdateCompletionBlock:(UpdateCompletionBlock)completionBlock;

//  ------------------------------------------------------------------------------------------------
#pragma mark declare for check update file.
//  ------------------------------------------------------------------------------------------------
/**
 *  @brief check update file for configure that is download finished.
 *  check update file for configure that is download finished.
 *  first to check update's file exist, otherwise to check default's file exist.
 *
 *  @param configure                a configure file name.
 *  @param dataLink                 update's URL at internet.
 *  @param timestamp                the file update condition that was check for integer type.
 *  @param customization            a customization configure for the Sticker Library View Controller.
 *  @param isUpdate                 pointer of extensioin result of method, to express file exist is update or default.
 *
 *  @return YES|NO                  configure file exist or not.
 */
+ ( BOOL ) checkConfigureFileExist:(NSString *)configure from:(NSString *)dataLink updateCheckBy:(NSString *)timestamp
                              with:(TDStickerLibraryCustomization *)customization extensionResult:(BOOL *)isUpdate;

//  ------------------------------------------------------------------------------------------------

@end

//  ------------------------------------------------------------------------------------------------
//  ------------------------------------------------------------------------------------------------



