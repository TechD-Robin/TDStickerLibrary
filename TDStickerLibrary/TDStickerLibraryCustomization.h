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
@property( nonatomic, assign ) NSString                   * inZippedUpdatePrefixPath;
@property( nonatomic, assign ) NSString                   * tabConfigureUpdateFilename;



//  for UIView.
@property( nonatomic, assign ) CGFloat                      navigationBarHeight;
@property( nonatomic, assign ) CGFloat                      bannerHeight;           //  when value is eaual 0, skip create banner view.
@property( nonatomic, assign ) CGFloat                      tabMenuHeight;

@property( nonatomic, assign ) CGSize                       tabMenuItemSize;
@property( nonatomic, assign ) CGSize                       tabMenuItemSizeInset;

//  for UICollectionView.
@property( nonatomic, assign ) CGSize                       tableCommonItemSize;
@property( nonatomic, assign ) UIEdgeInsets                 tableCommonSectionInset;
@property( nonatomic, assign ) CGSize                       tableCommonHeaderReferenceSize;
@property( nonatomic, assign ) CGFloat                      tableMinimumInteritemSpacing;
@property( nonatomic, assign ) CGFloat                      tableMinimumLineSpacing;

//  for StickeSolo View.
@property( nonatomic, getter=isStickerSoloViewEnabled )         BOOL        stickerSoloViewEnabled;         //  default is Yes.
@property( nonatomic, getter=isStickerSoloViewUseBlurLayer )    BOOL        stickerSoloViewUseBlurLayer;    //  default is Yes.

@property( nonatomic, assign ) CGSize                       soloViewInsetSize;
@property( nonatomic, assign ) CGSize                       soloViewBlurLayerInsetSize;             //  when stickerSoloViewUseBlurLayer = Yes.
@property( nonatomic, assign ) CGSize                       soloViewBlurLayerInsetSizeOnTop;        //  when stickerSoloViewUseBlurLayer = Yes.
@property( nonatomic, assign ) CGFloat                      soloViewBlurLayerAlphaOnTop;            //  when stickerSoloViewUseBlurLayer = Yes; value : 0 ~ 1.0 .
//@property( nonatomic, assign ) UIColor                    * soloViewBlurLayerColor;                 //  when stickerSoloViewUseBlurLayer = Yes.
@property( nonatomic, copy )   UIColor                    * soloViewBlurLayerColor;                 //  when stickerSoloViewUseBlurLayer = Yes.
@property( nonatomic, assign ) CGFloat                      soloViewShowAnimateDuration;
@property( nonatomic, assign ) CGFloat                      soloViewHideAnimateDuration;

//  for UIBackgroundColor
@property( nonatomic, assign ) UIColor                    * navigationBGC;          // some effect at navigation bar. (錯覺嗎?, 本來應該要沒效果的)
@property( nonatomic, assign ) UIColor                    * bannerBGC;
@property( nonatomic, assign ) UIColor                    * tabMenuBGC;

//  ------------------------------------------------------------------------------------------------


@end

//  ------------------------------------------------------------------------------------------------
//  ------------------------------------------------------------------------------------------------




