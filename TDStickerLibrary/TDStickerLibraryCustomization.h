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
#pragma mark declare enumeration.
//  ------------------------------------------------------------------------------------------------
/**
 *  enumeration for Sticker Library's Page Section data sorting.
 */
typedef NS_ENUM( NSInteger, TDStickerLibraryPageSectionSorting ){
    /**
     *  sorting is none.
     */
    TDStickerLibraryPageSectionSortingNone          = 0,
    /**
     *  sorting is use ID key and ascending.
     */
    TDStickerLibraryPageSectionSortingIDAscending,
    /**
     *  sorting is use ID key and descending.
     */
    TDStickerLibraryPageSectionSortingIDDescending,
    /**
     *  sorting is use Title key and ascending.
     */
    TDStickerLibraryPageSectionSortingTitleAscending,
    /**
     *  sorting is use Title key and descending.
     */
    TDStickerLibraryPageSectionSortingTitleDescending,
};

//  ------------------------------------------------------------------------------------------------
//  ------------------------------------------------------------------------------------------------


//

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
#pragma mark system style.
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

/**
 *  system style's back image name.
 */
@property( nonatomic, assign ) NSString                   * sysStyleBackImageName;

/**
 *  system style's back highlighted image name.
 */
@property( nonatomic, assign ) NSString                   * sysStyleBackHighlightedImageName;

/**
 *  system style's back disabled image name.
 */
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
 *  system style's delete image name.
 */
@property( nonatomic, assign ) NSString                   * sysStyleDeleteImageName;

/**
 *  system style's delete highlighted image name.
 */
@property( nonatomic, assign ) NSString                   * sysStyleDeleteHighlightedImageName;

/**
 *  system style's delete disabled image name.
 */
@property( nonatomic, assign ) NSString                   * sysStyleDeleteDisabledImageName;

/**
 *  system style's tinted color.
 */
@property( nonatomic, assign ) UIColor                    * sysStyleTintedColor;

/**
 *  system style's tinted color alpha.
 */
@property( nonatomic, assign ) CGFloat                      sysStyleTintedColorAlpha;

/**
 *  system style's highlighted tinted color.
 */
@property( nonatomic, assign ) UIColor                    * sysStyleHighlightedTintedColor;

/**
 *  system style's highlighted tinted color alpha.
 */
@property( nonatomic, assign ) CGFloat                      sysStyleHighlightedTintedColorAlpha;

/**
 *  system style's disabled tinted color.
 */
@property( nonatomic, assign ) UIColor                    * sysStyleDisabledTintedColor;

/**
 *  system style's disabled tinted color alpha.
 */
@property( nonatomic, assign ) CGFloat                      sysStyleDisabledTintedColorAlpha;

/**
 *  system style's alert tinted color.
 */
@property( nonatomic, assign ) UIColor                    * sysStyleAlertTintedColor;

/**
 *  system style's alert tinted color alpha.
 */
@property( nonatomic, assign ) CGFloat                      sysStyleAlertTintedColorAlpha;

/**
 *  system style's highlighted alert tinted color.
 */
@property( nonatomic, assign ) UIColor                    * sysStyleHighlightedAlertTintedColor;

/**
 *  system style's highlighted alert tinted color alpha.
 */
@property( nonatomic, assign ) CGFloat                      sysStyleHighlightedAlertTintedColorAlpha;

/**
 *  system style's title text color.
 */
@property( nonatomic, assign ) UIColor                    * sysStyleTitleTextColor;

/**
 *  system style's master vision background color.
 */
@property( nonatomic, copy )   UIColor                    * sysStyleMasterVisionBGC;

/**
 *  system style's navigation bar's background color.
 */
@property( nonatomic, copy )   UIColor                    * sysStyleNavigationBGC;


#pragma mark -
#pragma mark system configure default.
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
 *  update's with string.
 */
@property( nonatomic, assign ) NSString                   * systemConfigureTabPageUpdateZpwiaopsrpsded;

/**
 *  update's file name of tab's configure.
 */
@property( nonatomic, assign ) NSString                   * systemConfigureTabUpdateFilename;

/**
 *  update's prefix path name in zipped file.
 */
@property( nonatomic, assign ) NSString                   * systemConfigureTabUpdateInZippedPrefix;

/**
 *  update's with string.
 */
@property( nonatomic, assign ) NSString                   * systemConfigureTabUpdateZpwiaopsrpsded;


#pragma mark sticker download.
//  for sticker download.
/**
 *  subpath of sticker's download.
 */
@property( nonatomic, assign ) NSString                   * stickerDownloadSubpath;

/**
 *  directory of sticker's download.
 */
@property( nonatomic, assign ) TDGetPathDirectory           stickerDownloadDirectory;

/**
 *  sticker download's with string.
 */
@property( nonatomic, assign ) NSString                   * stickerDownloadZpwiaopsrpsded;


#pragma mark Sticker Libaray View Controller's view
//  for Status Bar.
/**
 *  set the flag to decide the system status bar is hidden, otherwise is show.
 *  when flag value is Yes, the system status bar is hidden;
 *  default is No.
 */
@property( nonatomic, getter=isStatusBarHidden ) BOOL       statusBarHidden;

/**
 *  the style of the system status bar.
 *  when statusBarHidden is No then the configure has effect.
 *  default is UIStatusBarStyleDefault.
 */
@property( nonatomic, assign ) UIStatusBarStyle             statusBarStyle;

//  for UIView(Sticker Libaray View Controller's view).
/**
 *  height of navigation bar.
 */
@property( nonatomic, assign ) CGFloat                      navigationBarHeight;

/**
 *  edge insets of edge's action object.
 */
@property( nonatomic, assign ) UIEdgeInsets                 edgeActionObjectInsets;


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

/**
 *  set the flag to decide save the tab menu's current tab tag, the tag number is express the menu's item.
 *  when flag value is Yes, save current tab tag to NSUserDefaults object, otherwise skip the save action.
 *  default is Yes.
 */
@property( nonatomic, getter=isSaveTabMenuCurrentTabTag ) BOOL                      saveTabMenuCurrentTabTag;

/**
 *  sorting of section data of page's table.
 */
@property( nonatomic, assign ) TDStickerLibraryPageSectionSorting                   tabPageTableSectionSorting;

//  for UICollectionView(Sticker Libaray Tab Page View's layout).
/**
 *  set the flag to use image size's original proportion of table item.
 *  when flag value is Yes, use size of image original proportion, otherwise use table common item size.
 *  default is No.
 */
@property( nonatomic, getter=isTableItemSizeUsingImageOriginalProportion ) BOOL     tableItemSizeUsingImageOriginalProportion;

/**
 *  set the flag to decide save the table section's mini states change or not.
 *  when flage value is Yes, save states to NSUserDefaults object, otherwise skip the save action.
 *  default is Yes.
 */
@property( nonatomic, getter=isSaveTableSectionMiniStateChange ) BOOL               saveTableSectionMiniStateChange;

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
 *  common minimum inter item spacing of table's section.
 */
@property( nonatomic, assign ) CGFloat                      tableMinimumInteritemSpacing;

/**
 *  common minimum line spacing of table's section.
 */
@property( nonatomic, assign ) CGFloat                      tableMinimumLineSpacing;

/**
 *  background color of table's header.
 */
@property( nonatomic, copy )   UIColor                    * tableHeaderBGC;

/**
 *  background color of banner (of Sticker Libaray View Controller's view).
 */
@property( nonatomic, assign ) UIColor                    * bannerBGC;

/**
 *  background color of tab menu (of Sticker Libaray View Controller's view).
 */
@property( nonatomic, assign ) UIColor                    * tabMenuBGC;



#pragma mark Sticker Intro DLVC.
//  for Sticker Intro DLVC.
/**
 *  insets of introView for subview's.
 */
@property( nonatomic, assign ) UIEdgeInsets                 introViewSubViewInsets;

/**
 *  height of introView.
 */
@property( nonatomic, assign ) CGFloat                      introViewHeight;

/**
 *  font size of introView's illustrator.
 */
@property( nonatomic, assign ) CGFloat                      introViewIllustratorFontSize;

/**
 *  text color of introView's illustrator.
 */
@property( nonatomic,assign )   UIColor                   * introViewIllustratorTextColor;

/**
 *  font size of introView's description.
 */
@property( nonatomic, assign ) CGFloat                      introViewDescriptionFontSize;

/**
 *  line spacing of introView's contents.
 */
@property( nonatomic, assign ) CGFloat                      introViewContentsLineSpacing;

/**
 *  background color of introView.
 */
@property( nonatomic, copy )   UIColor                    * introViewBGC;

/**
 *  text color of introView's contents.
 */
@property( nonatomic, copy )   UIColor                    * introViewContentsTextColor;

/**
 *  font size of introView's expire date.
 */
@property( nonatomic, assign ) CGFloat                      introViewExpireDateFontSize;

/**
 *  text color of introView's expire date.
 */
@property( nonatomic, copy )   UIColor                    * introViewExpireDateTextColor;

/**
 *  alert's text color of introView's expire date when expiring.
 */
@property( nonatomic, copy )   UIColor                    * introViewExpireDateExpiringTextColor;

/**
 *  alert days for introView's expire date when expiring. ( 0 is mean on the expire date )
 *  default is 2; ( 2 + 1 ).
 */
@property( nonatomic, assign ) NSUInteger                   introViewExpireDateExpiringAlertDays;

/**
 *  button height of DLVC's serial buttons.
 */
@property( nonatomic, assign ) CGFloat                      introViewSerialButtonHeight;

/**
 *  button color of DLVC's serial buttons.
 */
@property( nonatomic, copy )    UIColor                   * introViewSerialButtonColor;


//  for Sticker Intro DLVC's progress.
/**
 *  set the flag to use intro progress, and use the stamp image on the progress.
 *  when flag is Yes, is enable to use, otherwise is disabled.
 *  default is Yes.
 */
@property( nonatomic, getter=isIntroProgressEnabled ) BOOL  introProgressEnabled;

/**
 *  color of intro progress's message text.
 */
@property( nonatomic, copy )   UIColor                    * introProgressMessageTextColor;

/**
 *  inset of intro progress's intro image.
 */
@property( nonatomic, assign ) CGSize                       introProgressImageInsetSize;

/**
 *  color of intro progress's blur layer.
 */
@property( nonatomic, copy )   UIColor                    * introProgressBlurLayerColor;

/**
 *  inset of blur layer when the intro progress is show on top.
 */
@property( nonatomic, assign ) CGSize                       introProgressBlurLayerInsetSizeOnTop;

/**
 *  alpha of blur layer when the intro progress is show on top.
 *  value : 0.0f ~ 1.0f.
 */
@property( nonatomic, assign ) CGFloat                      introProgressBlurLayerAlphaOnTop;

/**
 *  bottom edge of progress message when the intro progress is show on top.
 */
@property( nonatomic, assign ) CGFloat                      introProgressMessageBottomEdgeOnTop;

/**
 *  duration of animate when intro progress is show.
 */
@property( nonatomic, assign ) CGFloat                      introProgressShowAnimateDuration;

/**
 *  duration of animate when intro progress is dismiss.
 */
@property( nonatomic, assign ) CGFloat                      introProgressDismissAnimateDuration;


#pragma mark pop menu.
//  for pop menu.
/**
 *  pop menu's inter item spacing.
 */
@property( nonatomic, assign ) CGFloat                      popMenuInteritemSpacing;

/**
 *  duration of animate when pop menu pop out.
 */
@property( nonatomic, assign ) CGFloat                      popMenuPopOutAnimateDuration;

/**
 *  pop menu's blur layer's color.
 */
@property( nonatomic, copy )   UIColor                    * popMenuBlurLayerColor;

/**
 *  pop menu's blur layer width scale. ( 1.0f is equal pop menu's width; 0.0f is equal unuse blur layer )
 */
@property( nonatomic, assign ) CGFloat                      popMenuBlayLayerWidthScale;


#pragma mark Sticker Solo View.
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
/**
 *  @brief get the system style's delete image.
 *  get the system style's delete image.
 *
 *  @return image|nil               the image object or nil.
 */
- ( UIImage * ) sysStyleDeleteImage;

//  ------------------------------------------------------------------------------------------------
/**
 *  @brief get the system style's delete highlighted image.
 *  get the system style's delete highlighted image.
 *
 *  @return image|nil               the image object or nil.
 */
- ( UIImage * ) sysStyleDeleteImageHighlighted;

//  ------------------------------------------------------------------------------------------------
/**
 *  @brief get the system style's delete disabled image.
 *  get the system style's delete disabled image.
 *
 *  @return image|nil               the image object or nil.
 */
- ( UIImage * ) sysStyleDeleteImageDisabled;

//  ------------------------------------------------------------------------------------------------
#pragma mark declare for get default's assets bundle image
//  ------------------------------------------------------------------------------------------------
/**
 *  @brief get a default image is not image.
 *  get a default image is not image.
 *
 *  @return image|nil               the image object or nil.
 */
- ( UIImage * ) defaultNoImage;

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
/**
 *  @brief get the pop menu's pop out image.
 *  get the pop menu's pop out image.
 *
 *  @return image|nil               the image object or nil.
 */
- ( UIImage * ) popMenuPopOutImage;

//  ------------------------------------------------------------------------------------------------
/**
 *  @brief get the pop menu's pop out highlighted image.
 *  get the pop menu's pop out highlighted image.
 *
 *  @return image|nil               the image object or nil.
 */
- ( UIImage * ) popMenuPopOutImageHightlighted;

//  ------------------------------------------------------------------------------------------------
/**
 *  @brief get the pop menu's pop out disabled image.
 *  get the pop menu's pop out disabled image.
 *
 *  @return image|nil               the image object or nil.
 */
- ( UIImage * ) popMenuPopOutImageDisabled;

//  ------------------------------------------------------------------------------------------------
/**
 *  @brief get the pop menu's un-pop out image.
 *  get the pop menu's un-pop out image.
 *
 *  @return image|nil               the image object or nil.
 */
- ( UIImage * ) popMenuUnPopOutImage;

//  ------------------------------------------------------------------------------------------------
/**
 *  @brief get the pop menu's un-pop out highlighted image.
 *  get the pop menu's un-pop out highlighted image.
 *
 *  @return image|nil               the image object or nil.
 */
- ( UIImage * ) popMenuUnPopOutImageHightlighted;

//  ------------------------------------------------------------------------------------------------
/**
 *  @brief get the pop menu's un-pop out disabled image.
 *  get the pop menu's un-pop out disabled image.
 *
 *  @return image|nil               the image object or nil.
 */
- ( UIImage * ) popMenuUnPopOutImageDisabled;

//  ------------------------------------------------------------------------------------------------
/**
 *  @brief get the pop items's website action's image.
 *  get the pop items's website action's image.
 *
 *  @return image|nil               the image object or nil.
 */
- ( UIImage * ) popItemActionWebsiteImage;

//  ------------------------------------------------------------------------------------------------
/**
 *  @brief get the pop items's website action's highlighted image.
 *  get the pop items's website action's highlighted image.
 *
 *  @return image|nil               the image object or nil.
 */
- ( UIImage * ) popItemActionWebsiteImageHightlighted;

//  ------------------------------------------------------------------------------------------------
/**
 *  @brief get the pop items's website action's disabled image.
 *  get the pop items's website action's disabled image.
 *
 *  @return image|nil               the image object or nil.
 */
- ( UIImage * ) popItemActionWebsiteImageDisabled;

//  ------------------------------------------------------------------------------------------------
/**
 *  @brief get the pop items's email action's image.
 *  get the pop items's email action's image.
 *
 *  @return image|nil               the image object or nil.
 */
- ( UIImage * ) popItemActionEMailImage;

//  ------------------------------------------------------------------------------------------------
/**
 *  @brief get the pop items's email action's highlighted image.
 *  get the pop items's email action's highlighted image.
 *
 *  @return image|nil               the image object or nil.
 */
- ( UIImage * ) popItemActionEMailImageHightlighted;

//  ------------------------------------------------------------------------------------------------
/**
 *  @brief get the pop items's email action's disabled image.
 *  get the pop items's email action's disabled image.
 *
 *  @return image|nil               the image object or nil.
 */
- ( UIImage * ) popItemActionEMailImageDisabled;

//  ------------------------------------------------------------------------------------------------
#pragma mark declare for get localized stirng.
//  ------------------------------------------------------------------------------------------------
/**
 *  @brief get this library's title string from localized setting.
 *  get this library's title string from localized setting.
 *
 *  @return string|nil              the string or nil.
 */
- ( NSString * ) libraryTitleString;

//  ------------------------------------------------------------------------------------------------
/**
 *  @brief get the download string from localized setting.
 *  get the download string from localized setting.
 *
 *  @return string|nil              the string or nil.
 */
- ( NSString * ) downloadString;

//  ------------------------------------------------------------------------------------------------
/**
 *  @brief get the downloading string from localized setting.
 *  get the downloading string from localized setting.
 *
 *  @return string|nil              the string or nil.
 */
- ( NSString * ) downloadingString;

//  ------------------------------------------------------------------------------------------------
/**
 *  @brief get the download highlighted string from localized setting.
 *  get the download highlighted string from localized setting.
 *
 *  @return string|nil              the string or nil.
 */
- ( NSString * ) downloadStringHightlighted;

//  ------------------------------------------------------------------------------------------------
/**
 *  @brief get the delete string from localized setting.
 *  get the delete string from localized setting.
 *
 *  @return string|nil              the string or nil.
 */
- ( NSString * ) deleteString;

//  ------------------------------------------------------------------------------------------------
/**
 *  @brief get the expire date string from localized setting.
 *  get the expire date string from localized setting.
 *
 *  @return string|nil              the string or nil.
 */
- ( NSString * ) expireDateString;

//  ------------------------------------------------------------------------------------------------
//  ------------------------------------------------------------------------------------------------


@end

//  ------------------------------------------------------------------------------------------------
//  ------------------------------------------------------------------------------------------------




