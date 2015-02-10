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


//  ------------------------------------------------------------------------------------------------
//  ------------------------------------------------------------------------------------------------

@interface TDStickerLibraryStickerSoloView : UIView

//  ------------------------------------------------------------------------------------------------

//  ------------------------------------------------------------------------------------------------
#pragma mark property of variable.
//  ------------------------------------------------------------------------------------------------


//  ------------------------------------------------------------------------------------------------
#pragma mark declare for create the object.
//  ------------------------------------------------------------------------------------------------
+ ( instancetype ) stickerSoloView:(UIImage *)stickerImage original:(CGRect)stickerFrame onScreen:(CGRect)nowFrame
                              with:(UIWindow *)window customization:(TDStickerLibraryCustomization *)customization;



//+ ( instancetype ) StickerLibraryStickerViewer:(UIImage *)stickerImage withSize:(CGSize)originalSize withFrame:(CGRect)onScreenFrame
//                                     reference:(UIView *)referenceView
//                                      showView:(void (^)(void))showView completion:(void (^)(BOOL finished))completion;



//+ ( instancetype ) tabPageWithFrame:(CGRect)frame customization:(TDStickerLibraryCustomization *)customization
//                               data:(NSString *)configure forKey:(NSString *)aKey;
//

//  ------------------------------------------------------------------------------------------------


@end

//  ------------------------------------------------------------------------------------------------
//  ------------------------------------------------------------------------------------------------



