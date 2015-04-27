//
//  TDStickerLibraryStickerIntroDLVC.h
//  StickerLibrary
//
//  Created by Robin Hsu on 2015/4/19.
//  Copyright (c) 2015年 TechD. All rights reserved.
//
//  ------------------------------------------------------------------------------------------------
//  ------------------------------------------------------------------------------------------------


#import <UIKit/UIKit.h>
#import "TDStickerLibraryCustomization.h"
#import "TDStickerLibraryTabPageInfo.h"


//  ------------------------------------------------------------------------------------------------
//  ------------------------------------------------------------------------------------------------
#pragma mark type define.
//  ------------------------------------------------------------------------------------------------
/**
 *  @brief a block section be executed when closed this view controller.
 *  a block section be executed when closed this view controller, these parameters will return finish information to method caller.
 *
 *  @param stickerID                identifier of sticker's data.
 *  @param index                    section index.
 *  @param isDownloaded (YES|NO)    a boolean value, a data is downloaded, the value is YES, otherwise it's NO(maybe is mean data delete).
 *  @param actionFinished (YES|NO)  the action(download or delete) in this view controller is finished or not.
 *
 *  @return void                    nothing.
 */
typedef     void (^FinishedIntroDLVCCallbackBlock)(NSString * stickerID, NSInteger sectionIndex, BOOL isDownloaded, BOOL actionFinished);

//  ------------------------------------------------------------------------------------------------
//  ------------------------------------------------------------------------------------------------


//  ------------------------------------------------------------------------------------------------
//  ------------------------------------------------------------------------------------------------
/**
 *  the Sticker Library Sticker IntroDLVC(Introducton & Download View Controller) is a functional view controller,
 *  that for sticker preview or download.
 */
@interface TDStickerLibraryStickerIntroDLVC : UIViewController

//  ------------------------------------------------------------------------------------------------

//  ------------------------------------------------------------------------------------------------
#pragma mark property of variable.
//  ------------------------------------------------------------------------------------------------


//  ------------------------------------------------------------------------------------------------
#pragma mark declare for create the object.
//  ------------------------------------------------------------------------------------------------
/**
 *  @brief create a Sticker Library Sticker IntroDLVC.
 *  create a Sticker Library Sticker IntroDLVC(Introducton & Download View Controller).
 *
 *  @param custom                   the customization object for the Sticker Library.
 *  @param pageInfo                 the page information object.
 *  @param index                    section index.
 *  @param stickerID                identifier of sticker's data.
 *
 *  @return object|nil              the Sticker Library Sticker IntroDLVC or nil.
 */
+ ( instancetype ) introductionDL:(TDStickerLibraryCustomization *)custom configure:(TDStickerLibraryTabPageInfo *)pageInfo
                       forSection:(NSInteger)index identifier:(NSString *)stickerID;


//  ------------------------------------------------------------------------------------------------
#pragma mark declare for base methos of procedure
//  ------------------------------------------------------------------------------------------------
/**
 *  @brief set a block section be executed when closed this view controller.
 *  set a block section be executed when closed this view controller, if you need result of this view controll, call this method.
 *
 *  @param callbackBlock            a block section be executed when closed this view controller.
 */
- ( void ) setFinishedIntroDLVCCallbackBlock:(FinishedIntroDLVCCallbackBlock)callbackBlock;

//  ------------------------------------------------------------------------------------------------


@end

//  ------------------------------------------------------------------------------------------------
//  ------------------------------------------------------------------------------------------------





