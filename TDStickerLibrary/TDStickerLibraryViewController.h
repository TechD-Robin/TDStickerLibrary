//
//  TDStickerLibraryViewController.h
//  TDStickerLibrary
//
//  Created by Robin Hsu on 2015/1/15.
//  Copyright (c) 2015年 TechD. All rights reserved.
//
//  ------------------------------------------------------------------------------------------------
//  ------------------------------------------------------------------------------------------------


#import <UIKit/UIKit.h>
#import "TDStickerLibrary.h"


//  ------------------------------------------------------------------------------------------------
//  ------------------------------------------------------------------------------------------------
#pragma mark type define.
//  ------------------------------------------------------------------------------------------------
/**
 *  @brief a block section be executed when get a current image by user touch action.
 *  a block section be executed when get a current image by user touch action, 
 *  & these parameters will return finish information to method caller.
 *
 *  @param stickerImage             a sticker image, user touched.
 *
 *  @return void                    nothing.
 */
typedef     void (^FinishedStickerLibraryCallbackBlock)(UIImage * stickerImage);


//  ------------------------------------------------------------------------------------------------
//  ------------------------------------------------------------------------------------------------
/**
 *  the Sticker Library View Controller is a multi-page for sticker collection view.
 *  the section of tab page can set to minimun or normal state, 
 *  and can download new sticker image from URL.
 */
@interface TDStickerLibraryViewController : UIViewController

//  ------------------------------------------------------------------------------------------------

//  ------------------------------------------------------------------------------------------------
#pragma mark property of variable.
//  ------------------------------------------------------------------------------------------------



//  ------------------------------------------------------------------------------------------------
#pragma mark declare for create the object.
//  ------------------------------------------------------------------------------------------------
/**
 *  @brief create a Sticker Library View Controller.
 *  create a Sticker Library View Controller; because customization is nil, system will auto create one.
 *
 *  @return object|nil              the Sticker Library View Controller or nil.
 */
+ ( instancetype ) stickerLibaray;

//  ------------------------------------------------------------------------------------------------
/**
 *  @brief create a Sticker Library View Controller with customization object.
 *  create a Sticker Library View Controller with customization object.
 *
 *  @param custom                   a customization configure for the Sticker Library View Controller.
 *
 *  @return object|nil              the Sticker Library View Controller or nil.
 */
+ ( instancetype ) stickerLibarayWithCustomization:(TDStickerLibraryCustomization *)custom;

//  ------------------------------------------------------------------------------------------------
#pragma mark declare for base methos of procedure
//  ------------------------------------------------------------------------------------------------
/**
 *  @brief set a block section be executed when get a current image by user touch action.
 *  set a block section be executed when get a current image by user touch action.
 *  if you need result of this view controll, call this method,
 *  when it's not set (nil), this VC will run in "browser mode".
 *  when it's setted, this VC will run in "editor mode".( get a sticker image by user touch )
 *
 *  @param callbackBlock            a block section be executed when get a current image by user touch action.
 */
- ( void ) setFinishedStickerLibraryCallbackBlock:(FinishedStickerLibraryCallbackBlock)callbackBlock;

//  ------------------------------------------------------------------------------------------------
/**
 *  @brief get a block's pointer of this VC finished callback.
 *  get a block's pointer of this VC finished callback.
 *
 *  @return                         a block's pointer.
 */
- (FinishedStickerLibraryCallbackBlock)finishedStickerLibraryCallbackBlock;

//  ------------------------------------------------------------------------------------------------
/**
 *  @brief execute this method when Sticker Library VC's action is completion.
 *  execute this method when Sticker Library VC's action is completion; get a current image by user touch action.
 *  system will close this Sticker Library VC.
 */
- ( void ) actionCompletion;

//  ------------------------------------------------------------------------------------------------
//  ------------------------------------------------------------------------------------------------


@end

//  ------------------------------------------------------------------------------------------------
//  ------------------------------------------------------------------------------------------------





