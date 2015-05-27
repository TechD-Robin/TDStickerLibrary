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

#import "TDUtilities.h"

//  ------------------------------------------------------------------------------------------------
//  ------------------------------------------------------------------------------------------------

//  ------------------------------------------------------------------------------------------------
//  ------------------------------------------------------------------------------------------------
/**
 *  a object for customization of sticker library view controller.
 *  developer can assign a new value into these properties after create this object.
 */
@interface TDStickerLibraryCustomization : NSObject

//  ------------------------------------------------------------------------------------------------
#pragma mark property of variable.
//  ------------------------------------------------------------------------------------------------
//  for system configure default.
/**
 *  default's subpath of system configure.
 */
@property( nonatomic, assign ) NSString                   * systemConfigureDefaultSubpath;

/**
 *  default's directory of system configure.
 */
@property( nonatomic, assign ) TDGetPathDirectory           systemConfigureDefaultDirectory;

/**
 *  default's file name of tab's configure.
 */
@property( nonatomic, assign ) NSString                   * systemConfigureTabDefaultFilename;

/**
 *  default's prefix path name in zipped file.
 */
@property( nonatomic, assign ) NSString                   * systemConfigureTabDefaultInZippedPrefix;


//  for system configure update.
/**
 *  update's filename of system configure.
 */
@property( nonatomic, assign ) NSString                   * systemConfigureUpdateFilename;

/**
 *  update's subpath of system configure.
 */
@property( nonatomic, assign ) NSString                   * systemConfigureUpdateSubpath;

/**
 *  update's directory of system configure.
 */
@property( nonatomic, assign ) TDGetPathDirectory           systemConfigureUpdateDirectory;

/**
 *  update's file name of tab's configure.
 */
@property( nonatomic, assign ) NSString                   * systemConfigureTabUpdateFilename;

/**
 *  update's prefix path name in zipped file.
 */
@property( nonatomic, assign ) NSString                   * systemConfigureTabUpdateInZippedPrefix;


//  for sticker download.
/**
 *  subpath of sticker's download.
 */
@property( nonatomic, assign ) NSString                   * stickerDownloadSubpath;

/**
 *  directory of sticker's download.
 */
@property( nonatomic, assign ) TDGetPathDirectory           stickerDownloadDirectory;


//  for UIView(Sticker Libaray View Controller's view).
/**
 *  height of navigation bar.
 */
@property( nonatomic, assign ) CGFloat                      navigationBarHeight;

/**
 *  height of banner; when value is eaual 0, skip create banner view.
 */
@property( nonatomic, assign ) CGFloat                      bannerHeight;

/**
 *  height of tab menu.
 */
@property( nonatomic, assign ) CGFloat                      tabMenuHeight;

/**
 *  size of tab menu's item.
 */
@property( nonatomic, assign ) CGSize                       tabMenuItemSize;

/**
 *  inset of tab menu's item.
 */
@property( nonatomic, assign ) CGSize                       tabMenuItemSizeInset;


@property( nonatomic, assign ) UIImage                    * backToMenuImage;

@property( nonatomic, assign ) UIImage                    * backToMenuImageHighlighted;

@property( nonatomic, assign ) UIImage                    * downloadImage;
@property( nonatomic, assign ) UIImage                    * downloadImageHighlighted;
@property( nonatomic, assign ) UIImage                    * downloadImageDisabled;


//  for UICollectionView(Sticker Libaray Tab Page View's layout).
/**
 *  common size of table's item.
 */
@property( nonatomic, assign ) CGSize                       tableCommonItemSize;

/**
 *  common inset of table's section.
 */
@property( nonatomic, assign ) UIEdgeInsets                 tableCommonSectionInset;

/**
 *  common size of header of table's section.
 */
@property( nonatomic, assign ) CGSize                       tableCommonHeaderReferenceSize;

/**
 *  common minimum interitem spacing of table's section.
 */
@property( nonatomic, assign ) CGFloat                      tableMinimumInteritemSpacing;

/**
 *  common minimum line spacing of table's section.
 */
@property( nonatomic, assign ) CGFloat                      tableMinimumLineSpacing;



//  for Sticker Solo View.
/**
 *  set the flag to use sticker solo view.
 *  when flag value is Yes, is enabled to use, otherwise is disabled. 
 *  default is Yes.
 */
@property( nonatomic, getter=isStickerSoloViewEnabled )         BOOL        stickerSoloViewEnabled;

/**
 *  set the flag to use blur layer when sticker solo view is enabled.
 *  when flag value is Yes, is enabled to use, otherwise is disabled. 
 *  default is Yes.
 */
@property( nonatomic, getter=isStickerSoloViewUseBlurLayer )    BOOL        stickerSoloViewUseBlurLayer;

/**
 *  inset of solo view.
 */
@property( nonatomic, assign ) CGSize                       soloViewInsetSize;

/**
 *  inset of blur layer when the layer is created. 
 *  when stickerSoloViewUseBlurLayer is Yes then the configure has effect.
 */
@property( nonatomic, assign ) CGSize                       soloViewBlurLayerInsetSize;

/**
 *  inset of blur layer when the solo view is show on top.
 *  when stickerSoloViewUseBlurLayer is Yes then the configure has effect.
 */
@property( nonatomic, assign ) CGSize                       soloViewBlurLayerInsetSizeOnTop;

/**
 *  alpha of blur layer when the solo view is show on top.
 *  when stickerSoloViewUseBlurLayer is Yes then the configure has effect.
 *  value : 0.0f ~ 1.0f.
 */
@property( nonatomic, assign ) CGFloat                      soloViewBlurLayerAlphaOnTop;

/**
 *  color of blur layer.
 *  when stickerSoloViewUseBlurLayer is Yes then the configure has effect.
 */
//@property( nonatomic, assign ) UIColor                    * soloViewBlurLayerColor;
@property( nonatomic, copy )   UIColor                    * soloViewBlurLayerColor;

/**
 *  duration of animate when solo view show.
 */
@property( nonatomic, assign ) CGFloat                      soloViewShowAnimateDuration;

/**
 *  duration of animate when solo view hide.
 */
@property( nonatomic, assign ) CGFloat                      soloViewHideAnimateDuration;


//  for UIBackgroundColor
/**
 *  background color of navigation bar.
 *  some effect at navigation bar. (錯覺嗎?, 本來應該要沒效果的)
 */
@property( nonatomic, assign ) UIColor                    * navigationBGC;

/**
 *  background color of banner (of Sticker Libaray View Controller's view).
 */
@property( nonatomic, assign ) UIColor                    * bannerBGC;

/**
 *  background color of tab menu (of Sticker Libaray View Controller's view).
 */
@property( nonatomic, assign ) UIColor                    * tabMenuBGC;

//  ------------------------------------------------------------------------------------------------


@end

//  ------------------------------------------------------------------------------------------------
//  ------------------------------------------------------------------------------------------------




