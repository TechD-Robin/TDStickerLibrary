//
//  TDStickerLibraryCustomization.h
//  TDStickerLibrary
//
//  Created by Robin Hsu on 2015/1/22.
//  Copyright (c) 2015年 TechD. All rights reserved.
//
//  ------------------------------------------------------------------------------------------------
//  ------------------------------------------------------------------------------------------------

#import <Foundation/Foundation.h>
#import <CoreGraphics/CoreGraphics.h>
#import <UIKit/UIKit.h>

//  ------------------------------------------------------------------------------------------------
//  ------------------------------------------------------------------------------------------------

//  ------------------------------------------------------------------------------------------------
//  ------------------------------------------------------------------------------------------------
@interface TDStickerLibraryCustomization : NSObject

//  ------------------------------------------------------------------------------------------------
#pragma mark property of variable.
//  ------------------------------------------------------------------------------------------------
@property( nonatomic, assign ) NSString                   * configureResource;

@property( nonatomic, assign ) NSString                   * inZippedPrefixPath;
@property( nonatomic, assign ) NSString                   * tabConfigureFilename;



//  for UIView.
@property( nonatomic, assign ) CGFloat                      navigationBarHeight;
@property( nonatomic, assign ) CGFloat                      bannerHeight;           //  when value is eaual 0, skip create banner view.
@property( nonatomic, assign ) CGFloat                      tabMenuHeight;

@property( nonatomic, assign ) CGSize                       tabMenuItemSize;
@property( nonatomic, assign ) CGSize                       tabMenuItemSizeInset;

//  for UIBackgroundColor
@property( nonatomic, assign ) UIColor                    * navigationBGC;          // some effect at navigation bar. (錯覺嗎?, 本來應該要沒效果的)
@property( nonatomic, assign ) UIColor                    * bannerBGC;
@property( nonatomic, assign ) UIColor                    * tabMenuBGC;

//  ------------------------------------------------------------------------------------------------


@end

//  ------------------------------------------------------------------------------------------------
//  ------------------------------------------------------------------------------------------------




