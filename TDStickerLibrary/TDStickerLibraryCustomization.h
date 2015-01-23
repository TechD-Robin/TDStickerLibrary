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
#import  <CoreGraphics/CoreGraphics.h>

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

//  ------------------------------------------------------------------------------------------------


@end

//  ------------------------------------------------------------------------------------------------
//  ------------------------------------------------------------------------------------------------




