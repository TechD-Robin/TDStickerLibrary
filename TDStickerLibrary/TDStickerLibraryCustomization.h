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
//  sys style.
/**
 *  system style's assets bundle name.
 */
@property( nonatomic, assign ) NSString                   * sysStyleBundleName;

/**
 *  images's subpath in system style's assets bundle.
 */
@property( nonatomic, assign ) NSString                   * sysStyleImageSubpathInBundle;

/**
 *  system style's back to menu image name.
 */
@property( nonatomic, assign ) NSString                   * sysStyleBackToMenuImageName;

/**
 *  system style's back to menu highlighted image name.
 */
@property( nonatomic, assign ) NSString                   * sysStyleBackToMenuHighlightedImageName;


@property( nonatomic, assign ) NSString                   * sysStyleBackImageName;

@property( nonatomic, assign ) NSString                   * sysStyleBackHighlightedImageName;

@property( nonatomic, assign ) NSString                   * sysStyleBackDisabledImageName;

/**
 *  system style's download image name.
 */
@property( nonatomic, assign ) NSString                   * sysStyleDownloadImageName;

/**
 *  system style's download highlighted image name.
 */
@property( nonatomic, assign ) NSString                   * sysStyleDownloadHighlightedImageName;

/**
 *  system style's download disabled image name.
 */
@property( nonatomic, assign ) NSString                   * sysStyleDownloadDisabledImageName;

/**
 *  system style's tinted color.
 */
@property( nonatomic, assign ) UIColor                    * sysStyleTintedColor;

/**
 *  system style's tinted color alpha.
 */
@property( nonatomic, assign ) CGFloat                      sysStyleTintedColorAlpha;

/**
 *  system style's title text color.
 */
@property( nonatomic, assign ) UIColor                    * sysStyleTitleTextColor;


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
#pragma mark declare for get system style's image
//  ------------------------------------------------------------------------------------------------
/**
 *  @brief get the system style's back to menu image.
 *  get the system style's back to menu image.
 *
 *  @return image|nil               the image object or nil.
 */
- ( UIImage * ) sysStyleBackToMenuImage;

//  ------------------------------------------------------------------------------------------------
/**
 *  @brief get the system style's back to menu highlighted image.
 *  get the system style's back to menu highlighted image.
 *
 *  @return image|nil               the image object or nil.
 */
- ( UIImage * ) sysStyleBackToMenuImageHighlighted;

//  ------------------------------------------------------------------------------------------------
/**
 *  @brief get the system style's back image.
 *  get the system style's back image.
 *
 *  @return image|nil               the image object or nil.
 */
- ( UIImage * ) sysStyleBackImage;

//  ------------------------------------------------------------------------------------------------
/**
 *  @brief get the system style's back highlighted image.
 *  get the system style's back highlighted image.
 *
 *  @return image|nil               the image object or nil.
 */
- ( UIImage * ) sysStyleBackImageHighlighted;

//  ------------------------------------------------------------------------------------------------
/**
 *  @brief get the system style's back disabled image.
 *  get the system style's back disabled image.
 *
 *  @return image|nil               the image object or nil.
 */
- ( UIImage * ) sysStyleBackImageDisabled;

//  ------------------------------------------------------------------------------------------------
/**
 *  @brief get the system style's download image.
 *  get the system style's download image.
 *
 *  @return image|nil               the image object or nil.
 */
- ( UIImage * ) sysStyleDownloadImage;

//  ------------------------------------------------------------------------------------------------
/**
 *  @brief get the system style's download highlighted image.
 *  get the system style's download highlighted image.
 *
 *  @return image|nil               the image object or nil.
 */
- ( UIImage * ) sysStyleDownloadImageHighlighted;

//  ------------------------------------------------------------------------------------------------
/**
 *  @brief get the system style's download disabled image.
 *  get the system style's download disabled image.
 *
 *  @return image|nil               the image object or nil.
 */
- ( UIImage * ) sysStyleDownloadImageDisabled;

//  ------------------------------------------------------------------------------------------------
#pragma mark declare for get default's assets bundle image
//  ------------------------------------------------------------------------------------------------
/**
 *  @brief get the section header's information image.
 *  get the section header's information image.
 *
 *  @return image|nil               the image object or nil.
 */
- ( UIImage * ) sectionHeaderInforImage;

//  ------------------------------------------------------------------------------------------------
/**
 *  @brief get the section header's information highlighted image.
 *  get the section header's information highlighted image.
 *
 *  @return image|nil               the image object or nil.
 */
- ( UIImage * ) sectionHeaderInforImageHighlighted;

//  ------------------------------------------------------------------------------------------------
/**
 *  @brief get the section header's information disabled image.
 *  get the section header's information disabled image.
 *
 *  @return image|nil               the image object or nil.
 */
- ( UIImage * ) sectionHeaderInforImageDisabled;

//  ------------------------------------------------------------------------------------------------
/**
 *  @brief get the section header's information arrow down image.
 *  get the section header's information arrow down image.
 *
 *  @return image|nil               the image object or nil.
 */
- ( UIImage * ) sectionHeaderArrowDownImage;

//  ------------------------------------------------------------------------------------------------
/**
 *  @brief get the section header's information arrow down highlighted image.
 *  get the section header's information arrow down highlighted image.
 *
 *  @return image|nil               the image object or nil.
 */
- ( UIImage * ) sectionHeaderArrowDownImageHighlighted;

//  ------------------------------------------------------------------------------------------------
/**
 *  @brief get the section header's information arrow down disabled image.
 *  get the section header's information arrow down disabled image.
 *
 *  @return image|nil               the image object or nil.
 */
- ( UIImage * ) sectionHeaderArrowDownImageDisabled;

//  ------------------------------------------------------------------------------------------------
/**
 *  @brief get the section header's information arrow up image.
 *  get the section header's information arrow up image.
 *
 *  @return image|nil               the image object or nil.
 */
- ( UIImage * ) sectionHeaderArrowUpImage;

//  ------------------------------------------------------------------------------------------------
/**
 *  @brief get the section header's information arrow up highlighted image.
 *  get the section header's information arrow up highlighted image.
 *
 *  @return image|nil               the image object or nil.
 */
- ( UIImage * ) sectionHeaderArrowUpImageHighlighted;

//  ------------------------------------------------------------------------------------------------
/**
 *  @brief get the section header's information arrow up disabled image.
 *  get the section header's information arrow up disabled image.
 *
 *  @return image|nil               the image object or nil.
 */
- ( UIImage * ) sectionHeaderArrowUpImageDisabled;


//  ------------------------------------------------------------------------------------------------
//  ------------------------------------------------------------------------------------------------


@end

//  ------------------------------------------------------------------------------------------------
//  ------------------------------------------------------------------------------------------------




