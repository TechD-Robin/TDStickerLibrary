//
//  TDStickerLibraryStickerSoloView.h
//  TDStickerLibrary
//
//  Created by Robin Hsu on 2015/2/11.
//  Copyright (c) 2015年 TechD. All rights reserved.
//
//  (the object name use solo, just want kidding of self.)
//
//  ------------------------------------------------------------------------------------------------
//  ------------------------------------------------------------------------------------------------

#import <UIKit/UIKit.h>
#import "TDStickerLibraryCustomization.h"

//  ------------------------------------------------------------------------------------------------
//  ------------------------------------------------------------------------------------------------
typedef     void (^FinishedCallbackBlock)(BOOL finished);

//  ------------------------------------------------------------------------------------------------
//  ------------------------------------------------------------------------------------------------


//  ------------------------------------------------------------------------------------------------
//  ------------------------------------------------------------------------------------------------
/**
 *  a sticker solo view for sticker library view controller.
 */
@interface TDStickerLibraryStickerSoloView : UIView

//  ------------------------------------------------------------------------------------------------

//  ------------------------------------------------------------------------------------------------
#pragma mark property of variable.
//  ------------------------------------------------------------------------------------------------


//  ------------------------------------------------------------------------------------------------
#pragma mark declare for create the object.
//  ------------------------------------------------------------------------------------------------
/**
 *  @brief create a sticker image view and show or hide.
 *  create a sticker image view and show or hide(solo show).
 *
 *  @param stickerImage             a sticker image.
 *  @param stickerSize              the sticker original frame.
 *  @param nowFrame                 the sticker now frame on screen.
 *  @param window                   a current window object's pointer.
 *  @param custom                   the customization object for the Sticker Library.
 *
 *  @return object|nil              the sticker solo view or nil.
 */
+ ( instancetype ) stickerSoloView:(UIImage *)stickerImage original:(CGSize)stickerSize onScreen:(CGRect)nowFrame
                              with:(UIWindow *)window customization:(TDStickerLibraryCustomization *)custom;

//  ------------------------------------------------------------------------------------------------
#pragma mark declare for show/hide the object.
//  ------------------------------------------------------------------------------------------------
/**
 *  @brief show the sticker image on window.
 *  call the method when want to show the sticker image on window(device screen).
 *
 *  @param showView                 a block section when show start.
 *  @param completion               a block section when show finish.
 */
- ( void ) showSoloView:(void (^)(void))showView completion:(FinishedCallbackBlock)completion;


//  ------------------------------------------------------------------------------------------------

@end

//  ------------------------------------------------------------------------------------------------
//  ------------------------------------------------------------------------------------------------



