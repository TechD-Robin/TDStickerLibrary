//
//  TDStickerLibraryCustomization.m
//  TDStickerLibrary
//
//  Created by Robin Hsu on 2015/1/22.
//  Copyright (c) 2015年 TechD. All rights reserved.
//
//  ------------------------------------------------------------------------------------------------
//  ------------------------------------------------------------------------------------------------


#ifndef __ARCMacros_H__
    #import "ARCMacros.h"
#endif  //  End of __ARCMacros_H__.

#import "UIKit+TechD.h"
#import "TDResourceManager.h"
#import "TDStickerLibraryCustomization.h"
#import "TDStickerLibraryDefaultResources.h"

//  ------------------------------------------------------------------------------------------------
//  ------------------------------------------------------------------------------------------------


//  ------------------------------------------------------------------------------------------------
//  ------------------------------------------------------------------------------------------------
#pragma mark -
#pragma mark class TDStickerLibraryCustomization

//  ------------------------------------------------------------------------------------------------
//  ------------------------------------------------------------------------------------------------
#pragma mark declare private category ()
//  ------------------------------------------------------------------------------------------------
//  --------------------------------
@interface TDStickerLibraryCustomization ()
{
    /**
     *  the object pointer of system style's resources manager.
     */
    TDResourceManager                     * sysStyleBundleManager;
    
    //  sticker library default.
    /**
     *  the object pointer of default resources.
     */
    TDStickerLibraryDefaultResources      * defaultResources;
    
    /**
     *  a state flags for customization.
     */
    struct {
        unsigned int    saveTabMenuCurrentTabTag: 1;
        
        unsigned int    tableItemSizeUsingImageOriginalProportion: 1;
        unsigned int    saveTableSectionMiniStateChange: 1;
        
        unsigned int    stickerSoloViewEnabled: 1;
        unsigned int    stickerSoloViewUseBlurLayer: 1;
        
    } stateFlags;
    
}

//  ------------------------------------------------------------------------------------------------

@end


//  ------------------------------------------------------------------------------------------------
//  ------------------------------------------------------------------------------------------------


//  ------------------------------------------------------------------------------------------------
//  ------------------------------------------------------------------------------------------------
#pragma mark -
#pragma mark declare private category (Private)
//  ------------------------------------------------------------------------------------------------
@interface TDStickerLibraryCustomization (Private)

//  ------------------------------------------------------------------------------------------------
#pragma mark declare for initial this class.
//  ------------------------------------------------------------------------------------------------
/**
 *  @brief initial the attributes of class.
 *  initial the attributes of class.
 */
- ( void ) _InitAttributes;

//  ------------------------------------------------------------------------------------------------
/**
 *  @brief create a default resource object.
 *  create a default resource object.
 */
- ( void ) _InitDefaultResources;

//  ------------------------------------------------------------------------------------------------
#pragma mark declare for get system style's data.
//  ------------------------------------------------------------------------------------------------
/**
 *  @brief get a image from system style's resources manager.
 *  get a image from system style's resources manager.
 *
 *  @param imageName                image name.
 *
 *  @return image|nil               the image object or nil.
 */
- ( UIImage * ) _ImageFromSysStyleBundle:(NSString *)imageName;

//  ------------------------------------------------------------------------------------------------
/**
 *  @brief get a image with tinted color from system style's resources manager.
 *  get a image with tinted color from system style's resources manager.
 *
 *  @param imageName                image name.
 *
 *  @return image|nil               the image object or nil.
 */
- ( UIImage * ) _ImageFromSysStyleBundleWithTintedColor:(NSString *)imageName;

//  ------------------------------------------------------------------------------------------------
/**
 *  @brief get a highlighted image with tinted color from system style's resources manager.
 *  get a highlighted image with tinted color from system style's resources manager.
 *
 *  @param imageName                image name.
 *
 *  @return image|nil               the image object or nil.
 */
- ( UIImage * ) _ImageFromSysStyleBundleWithHighlightTintedColor:(NSString *)imageName;

//  ------------------------------------------------------------------------------------------------
/**
 *  @brief get a disabled image with tinted color from system style's resources manager.
 *  get a disabled image with tinted color from system style's resources manager.
 *
 *  @param imageName                image name.
 *
 *  @return image|nil               the image object or nil.
 */
- ( UIImage * ) _ImageFromSysStyleBundleWithDisbledTintedColor:(NSString *)imageName;

//  ------------------------------------------------------------------------------------------------
/**
 *  @brief get a image with alert's color of tinted's color from system style's resources manager.
 *  get a image with alert's color of tinted's color from system style's resources manager.
 *
 *  @param imageName                image name.
 *
 *  @return image|nil               the image object or nil.
 */
- ( UIImage * ) _ImageFromSysStyleBundleWithAlertTintedColor:(NSString *)imageName;

//  ------------------------------------------------------------------------------------------------
/**
 *  @brief get a highlighted image with alert's color of tinted's color from system style's resources manager.
 *  get a highlighted image with alert's color of tinted's color from system style's resources manager.
 *
 *  @param imageName                image name.
 *
 *  @return image|nil               the image object or nil.
 */
- ( UIImage * ) _ImageFromSysStyleBundleWithHighlightedAlertTintedColor:(NSString *)imageName;


//  ------------------------------------------------------------------------------------------------
//  ------------------------------------------------------------------------------------------------
/**
 *  when user define new UIColor without default, must call the new UIColor by class method or singleton class method ( static method );
 *  otherwise project will crash when call by instance method.
 */
//  ------------------------------------------------------------------------------------------------
+ ( UIColor * ) _TabMenuColor;
//+ ( UIColor * ) _SoloViewBlurLayerColor;

//  ------------------------------------------------------------------------------------------------


@end


//  ------------------------------------------------------------------------------------------------
//  ------------------------------------------------------------------------------------------------

//  ------------------------------------------------------------------------------------------------
//  ------------------------------------------------------------------------------------------------
#pragma mark -
#pragma mark implementation private category (Private)
//  ------------------------------------------------------------------------------------------------
@implementation TDStickerLibraryCustomization (Private)

//  ------------------------------------------------------------------------------------------------
#pragma mark method for initial this class.
//  ------------------------------------------------------------------------------------------------
//  --------------------------------
- ( void ) _InitAttributes
{
    //  sys style.
    sysStyleBundleManager           = nil;
    
    //  sticker library default.
    defaultResources                = nil;
    
    [self                           setSysStyleBundleName: nil];
    [self                           setSysStyleImageSubpathInBundle: nil];
    
    [self                           setSysStyleBackToMenuImageName: nil];
    [self                           setSysStyleBackToMenuHighlightedImageName: nil];
    
    [self                           setSysStyleBackImageName: nil];
    [self                           setSysStyleBackHighlightedImageName: nil];
    [self                           setSysStyleBackDisabledImageName: nil];
    
    [self                           setSysStyleDownloadImageName: nil];
    [self                           setSysStyleDownloadHighlightedImageName: nil];
    [self                           setSysStyleDownloadDisabledImageName: nil];
    
    [self                           setSysStyleDeleteImageName: nil];
    [self                           setSysStyleDeleteHighlightedImageName: nil];
    [self                           setSysStyleDeleteDisabledImageName: nil];

    
    [self                           setSysStyleTintedColor: nil];
    [self                           setSysStyleTintedColorAlpha: 0.0f];
    
    [self                           setSysStyleHighlightedTintedColor: nil];
    [self                           setSysStyleHighlightedTintedColorAlpha: 0.0f];
    
    [self                           setSysStyleDisabledTintedColor: nil];
    [self                           setSysStyleDisabledTintedColorAlpha: 0.0f];
    
    [self                           setSysStyleAlertTintedColor: nil];
    [self                           setSysStyleAlertTintedColorAlpha: 0.0f];

    [self                           setSysStyleHighlightedAlertTintedColor: nil];
    [self                           setSysStyleHighlightedAlertTintedColorAlpha: 0.0f];
    
    [self                           setSysStyleTitleTextColor: nil];
    [self                           setSysStyleMasterVisionBGC: [UIColor clearColor]];
    [self                           setSysStyleNavigationBGC: [[UIColor grayColor] colorWithAlphaComponent: 0.33f]];
    
    
    //  for system configure default.
    [self                           setSystemConfigureDefaultSubpath:               @"Configure"];
    [self                           setSystemConfigureDefaultDirectory:             TDResourcesDirectory];
    
    [self                           setSystemConfigureTabDefaultFilename:           @"StickerLibraryTabDefault" ];
    [self                           setSystemConfigureTabDefaultInZippedPrefix:     @"StickerLibraryTabDefault"];
    

    //  for system configure update.
    [self                           setSystemConfigureUpdateFilename:               @"SystemUpdate.json"];
    [self                           setSystemConfigureUpdateSubpath:                @"Download/Configure"];
    [self                           setSystemConfigureUpdateDirectory:              TDCachesDirectory];
    [self                           setSystemConfigureTabPageUpdateZpwiaopsrpsded:  nil];
    
    [self                           setSystemConfigureTabUpdateFilename:            @"StickerLibraryTabUpdate"];
    [self                           setSystemConfigureTabUpdateInZippedPrefix:      @"StickerLibraryTabUpdate"];
    [self                           setSystemConfigureTabUpdateZpwiaopsrpsded:      nil];
    
    
    //  for sticker download.
    [self                           setStickerDownloadSubpath:                      @"Sticker"];
    [self                           setStickerDownloadDirectory:                    TDCachesDirectory];
    [self                           setStickerDownloadZpwiaopsrpsded:               nil];
    
    //  for UIView.
    [self                           setNavigationBarHeight: 36.0f];
    [self                           setEdgeActionObjectInsets: UIEdgeInsetsMake( 0.0f, 6.0f, 0.0f, 6.0f)];
    [self                           setBannerHeight: 48.0f];
    [self                           setTabMenuHeight: 50.0f];
    
    [self                           setTabMenuItemSize: CGSizeMake( 48.0f, 48.0f )];
    [self                           setTabMenuItemSizeInset: CGSizeMake( 3.0f, 3.0f )];
    [self                           setSaveTabMenuCurrentTabTag: YES];
    
    //  for UICollectionView.
    [self                           setTableItemSizeUsingImageOriginalProportion: NO];
    [self                           setSaveTableSectionMiniStateChange: YES];
    [self                           setTabPageTableSectionSorting: TDStickerLibraryPageSectionSortingNone];
    
    [self                           setTableCommonItemSize: CGSizeMake( 64.0f, 64.0f )];
    [self                           setTableCommonSectionInset: UIEdgeInsetsMake( 12.0f, 12.0f, 12.0f, 12.0f )];
    [self                           setTableCommonHeaderReferenceSize: CGSizeMake( 0.0f, 36.0f )];
    [self                           setTableMinimumInteritemSpacing: 10.0f];
    [self                           setTableMinimumLineSpacing: 10.0f];
    [self                           setTableHeaderBGC: [[UIColor grayColor] colorWithAlphaComponent: 0.25f]];
    
    [self                           setBannerBGC: [UIColor grayColor]];
    [self                           setTabMenuBGC: [[UIColor grayColor] colorWithAlphaComponent: 0.33f]];
    

    //  for Sticker Intro DLVC.
    [self                           setIntroViewSubViewInsets: UIEdgeInsetsMake( 8.0f, 8.0f, 8.0f, 8.0f)];
    [self                           setIntroViewHeight: 128.0f];
    [self                           setIntroViewIllustratorFontSize: 16.0f];
    [self                           setIntroViewIllustratorTextColor: [UIColor lightGrayColor]];
    [self                           setIntroViewDescriptionFontSize: 12.0f];
    [self                           setIntroViewContentsLineSpacing: 4.0f];
    [self                           setIntroViewBGC: [[UIColor grayColor] colorWithAlphaComponent: 0.27f]];
    [self                           setIntroViewContentsTextColor: [UIColor lightGrayColor]];
    [self                           setIntroViewExpireDateFontSize: 12.0f];
    [self                           setIntroViewExpireDateTextColor: [UIColor whiteColor]];
    [self                           setIntroViewExpireDateExpiringTextColor: [UIColor yellowColor]];
    [self                           setIntroViewExpireDateExpiringAlertDays: 2];    //  the days is 2 + 1(on the day).

    //  for pop menu.
    [self                           setPopMenuInteritemSpacing: 2.0f];
    [self                           setPopMenuPopOutAnimateDuration: 0.33f];
    [self                           setPopMenuBlurLayerColor: [[UIColor darkGrayColor] colorWithAlphaComponent: 0.66f]];
    [self                           setPopMenuBlayLayerWidthScale: 2.0f];

    
    //  for Sticker Solo View.
    //stateFlags.stickerSoloViewEnabled       = YES;
    //stateFlags.stickerSoloViewUseBlurLayer  = YES;
    [self                           setStickerSoloViewEnabled: YES];
    [self                           setStickerSoloViewUseBlurLayer: YES];
    
    
    [self                           setSoloViewInsetSize: CGSizeMake( 6.0f, 6.0f )];
    [self                           setSoloViewBlurLayerInsetSize: CGSizeMake( -12.0f, -12.0f )];
    [self                           setSoloViewBlurLayerInsetSizeOnTop: CGSizeMake( -24.0f, -24.0f )];
    [self                           setSoloViewBlurLayerAlphaOnTop: 0.9f];
    [self                           setSoloViewBlurLayerColor: [[UIColor darkGrayColor] colorWithAlphaComponent: 0.9f]];
    [self                           setSoloViewShowAnimateDuration: 0.25f];
    [self                           setSoloViewHideAnimateDuration: 0.25f];
    
    //  for UIBackgroundColor
    [self                           setNavigationBGC: [UIColor purpleColor]];
    
    
}

//  ------------------------------------------------------------------------------------------------
- ( void ) _InitDefaultResources
{
    defaultResources                = [TDStickerLibraryDefaultResources assetsBundleEnvironment: kTDStickerLibraryDefaultResourcesBundle
                                                                                           with: [self class]
                                                                                    onSingleton: NO];
    NSParameterAssert( nil != defaultResources );
    
    [defaultResources               setLocalizedStringTable: kTDStickerLibraryDefaultLocalizedStringTable];
}

//  ------------------------------------------------------------------------------------------------
#pragma mark method for get system style's data.
//  ------------------------------------------------------------------------------------------------
- ( UIImage * ) _ImageFromSysStyleBundle:(NSString *)imageName
{
    if ( ( nil == sysStyleBundleManager ) || ( nil == imageName ) )
    {
        return [self defaultNoImage];
    }
    
    UIImage                       * image;
    
    image                           = [sysStyleBundleManager image: imageName ofType: @"png" inDirectory: [self sysStyleImageSubpathInBundle]];
    if ( nil == image )
    {
        image                       = [self defaultNoImage];
        if ( nil == image )
        {
            return nil;
        }
    }
    return image;
}

//  ------------------------------------------------------------------------------------------------
- ( UIImage * ) _ImageFromSysStyleBundleWithTintedColor:(NSString *)imageName
{
    if ( ( nil == sysStyleBundleManager ) || ( nil == imageName ) )
    {
        return [self defaultNoImage];
    }
    
    UIImage                       * image;
    
    image                           = [sysStyleBundleManager image: imageName ofType: @"png"
                                                       inDirectory: [self sysStyleImageSubpathInBundle]];
    if ( nil == image )
    {
        return [self defaultNoImage];
    }
    if ( [self sysStyleTintedColor] == nil )
    {
        return image;
    }
    
    return [image imageWithTintedColor: [self sysStyleTintedColor] colorAlpha: [self sysStyleTintedColorAlpha]];
}

//  ------------------------------------------------------------------------------------------------
- ( UIImage * ) _ImageFromSysStyleBundleWithHighlightTintedColor:(NSString *)imageName
{
    if ( ( nil == sysStyleBundleManager ) || ( nil == imageName ) )
    {
        return [self defaultNoImage];
    }
    
    UIImage                       * image;
    
    image                           = [sysStyleBundleManager image: imageName ofType: @"png"
                                                       inDirectory: [self sysStyleImageSubpathInBundle]];
    if ( nil == image )
    {
        return [self defaultNoImage];
    }
    if ( [self sysStyleHighlightedTintedColor] == nil )
    {
        return image;
    }
    return [image imageWithTintedColor: [self sysStyleHighlightedTintedColor] colorAlpha: [self sysStyleHighlightedTintedColorAlpha]];
}

//  ------------------------------------------------------------------------------------------------
- ( UIImage * ) _ImageFromSysStyleBundleWithDisbledTintedColor:(NSString *)imageName
{
    if ( ( nil == sysStyleBundleManager ) || ( nil == imageName ) )
    {
        return [self defaultNoImage];
    }
    
    UIImage                       * image;
    
    image                           = [sysStyleBundleManager image: imageName ofType: @"png"
                                                       inDirectory: [self sysStyleImageSubpathInBundle]];
    if ( nil == image )
    {
        return [self defaultNoImage];
    }
    if ( [self sysStyleDisabledTintedColor] == nil )
    {
        return image;
    }
    return [image imageWithTintedColor: [self sysStyleDisabledTintedColor] colorAlpha: [self sysStyleDisabledTintedColorAlpha]];
}

//  ------------------------------------------------------------------------------------------------
- ( UIImage * ) _ImageFromSysStyleBundleWithAlertTintedColor:(NSString *)imageName
{
    if ( ( nil == sysStyleBundleManager ) || ( nil == imageName ) )
    {
        return [self defaultNoImage];
    }
    
    UIImage                       * image;
    
    image                           = [sysStyleBundleManager image: imageName ofType: @"png"
                                                       inDirectory: [self sysStyleImageSubpathInBundle]];
    if ( nil == image )
    {
        return [self defaultNoImage];
    }
    if ( [self sysStyleAlertTintedColor] == nil )
    {
        return image;
    }
    return [image imageWithTintedColor: [self sysStyleAlertTintedColor] colorAlpha: [self sysStyleAlertTintedColorAlpha]];
}

//  ------------------------------------------------------------------------------------------------
- ( UIImage * ) _ImageFromSysStyleBundleWithHighlightedAlertTintedColor:(NSString *)imageName
{
    if ( ( nil == sysStyleBundleManager ) || ( nil == imageName ) )
    {
        return [self defaultNoImage];
    }
    
    UIImage                       * image;
    
    image                           = [sysStyleBundleManager image: imageName ofType: @"png"
                                                       inDirectory: [self sysStyleImageSubpathInBundle]];
    if ( nil == image )
    {
        return [self defaultNoImage];
    }
    if ( [self sysStyleHighlightedAlertTintedColor] == nil )
    {
        return image;
    }
    return [image imageWithTintedColor: [self sysStyleHighlightedAlertTintedColor] colorAlpha: [self sysStyleHighlightedAlertTintedColorAlpha]];
}


//  ------------------------------------------------------------------------------------------------
//  ------------------------------------------------------------------------------------------------
+ ( UIColor * ) _TabMenuColor
{
    return [UIColor colorWithRed: 0.5f green: ( 200 / 255.0f ) blue: ( 200 / 255.0f ) alpha: 1.0f ];
}

////  ------------------------------------------------------------------------------------------------
//+ ( UIColor * ) _SoloViewBlurLayerColor
//{
//    return [[UIColor darkGrayColor] colorWithAlphaComponent: 0.9f];
//}


//  ------------------------------------------------------------------------------------------------
//  ------------------------------------------------------------------------------------------------

@end

//  ------------------------------------------------------------------------------------------------
//  ------------------------------------------------------------------------------------------------


//  ------------------------------------------------------------------------------------------------
//  ------------------------------------------------------------------------------------------------
#pragma mark -
#pragma mark implementation for public
//  ------------------------------------------------------------------------------------------------
@implementation TDStickerLibraryCustomization

//  ------------------------------------------------------------------------------------------------
#pragma mark synthesize variable.
//  sys style.
@synthesize sysStyleBundleName                      = _sysStyleBundleName;
@synthesize sysStyleImageSubpathInBundle            = _sysStyleImageSubpathInBundle;

@synthesize sysStyleBackToMenuImageName             = _sysStyleBackToMenuImageName;
@synthesize sysStyleBackToMenuHighlightedImageName  = _sysStyleBackToMenuHighlightedImageName;

@synthesize sysStyleBackImageName                   = _sysStyleBackImageName;
@synthesize sysStyleBackHighlightedImageName        = _sysStyleBackHighlightedImageName;
@synthesize sysStyleBackDisabledImageName           = _sysStyleBackDisabledImageName;

@synthesize sysStyleDownloadImageName               = _sysStyleDownloadImageName;
@synthesize sysStyleDownloadHighlightedImageName    = _sysStyleDownloadHighlightedImageName;
@synthesize sysStyleDownloadDisabledImageName       = _sysStyleDownloadDisabledImageName;

@synthesize sysStyleDeleteImageName                 = _sysStyleDeleteImageName;
@synthesize sysStyleDeleteHighlightedImageName      = _sysStyleDeleteHighlightedImageName;
@synthesize sysStyleDeleteDisabledImageName         = _sysStyleDeleteDisabledImageName;

@synthesize sysStyleTintedColor                     = _sysStyleTintedColor;
@synthesize sysStyleTintedColorAlpha                = _sysStyleTintedColorAlpha;

@synthesize sysStyleHighlightedTintedColor          = _sysStyleHighlightedTintedColor;
@synthesize sysStyleHighlightedTintedColorAlpha     = _sysStyleHighlightedTintedColorAlpha;

@synthesize sysStyleDisabledTintedColor             = _sysStyleDisabledTintedColor;
@synthesize sysStyleDisabledTintedColorAlpha        = _sysStyleDisabledTintedColorAlpha;

@synthesize sysStyleAlertTintedColor                = _sysStyleAlertTintedColor;
@synthesize sysStyleAlertTintedColorAlpha           = _sysStyleAlertTintedColorAlpha;

@synthesize sysStyleHighlightedAlertTintedColor     = _sysStyleHighlightedAlertTintedColor;
@synthesize sysStyleHighlightedAlertTintedColorAlpha= _sysStyleHighlightedAlertTintedColorAlpha;

@synthesize sysStyleTitleTextColor                  = _sysStyleTitleTextColor;
@synthesize sysStyleMasterVisionBGC                 = _sysStyleMasterVisionBGC;
@synthesize sysStyleNavigationBGC                   = _sysStyleNavigationBGC;

//  for system configure default.
@synthesize systemConfigureDefaultSubpath           = _systemConfigureDefaultSubpath;
@synthesize systemConfigureDefaultDirectory         = _systemConfigureDefaultDirectory;

@synthesize systemConfigureTabDefaultFilename       = _systemConfigureTabDefaultFilename;
@synthesize systemConfigureTabDefaultInZippedPrefix = _systemConfigureTabDefaultInZippedPrefix;


//  for system configure update.
@synthesize systemConfigureUpdateFilename               = _systemConfigureUpdateFilename;
@synthesize systemConfigureUpdateSubpath                = _systemConfigureUpdateSubpath;
@synthesize systemConfigureUpdateDirectory              = _systemConfigureUpdateDirectory;
@synthesize systemConfigureTabPageUpdateZpwiaopsrpsded  = _systemConfigureTabPageUpdateZpwiaopsrpsded;

@synthesize systemConfigureTabUpdateFilename        = _systemConfigureTabUpdateFilename;
@synthesize systemConfigureTabUpdateInZippedPrefix  = _systemConfigureTabUpdateInZippedPrefix;
@synthesize systemConfigureTabUpdateZpwiaopsrpsded  = _systemConfigureTabUpdateZpwiaopsrpsded;


//  for sticker download.
@synthesize stickerDownloadSubpath                  = _stickerDownloadSubpath;
@synthesize stickerDownloadDirectory                = _stickerDownloadDirectory;
@synthesize stickerDownloadZpwiaopsrpsded           = _stickerDownloadZpwiaopsrpsded;

//  for UIView.
@synthesize navigationBarHeight     = _navigationBarHeight;
@synthesize edgeActionObjectInsets  = _edgeActionObjectInsets;
@synthesize bannerHeight            = _bannerHeight;
@synthesize tabMenuHeight           = _tabMenuHeight;

@synthesize tabMenuItemSize         = _tabMenuItemSize;
@synthesize tabMenuItemSizeInset    = _tabMenuItemSizeInset;

//  for UICollectionView.
@synthesize tabPageTableSectionSorting      = _tabPageTableSectionSorting;
@synthesize tableCommonItemSize             = _tableCommonItemSize;
@synthesize tableCommonSectionInset         = _tableCommonSectionInset;
@synthesize tableCommonHeaderReferenceSize  = _tableCommonHeaderReferenceSize;
@synthesize tableMinimumInteritemSpacing    = _tableMinimumInteritemSpacing;
@synthesize tableMinimumLineSpacing         = _tableMinimumLineSpacing;
@synthesize tableHeaderBGC                  = _tableHeaderBGC;

@synthesize bannerBGC                       = _bannerBGC;
@synthesize tabMenuBGC                      = _tabMenuBGC;

//  for Sticker Intro DLVC.
@synthesize introViewSubViewInsets          = _introViewSubViewInsets;
@synthesize introViewHeight                 = _introViewHeight;
@synthesize introViewIllustratorFontSize    = _introViewIllustratorFontSize;
@synthesize introViewIllustratorTextColor   = _introViewIllustratorTextColor;
@synthesize introViewDescriptionFontSize    = _introViewDescriptionFontSize;
@synthesize introViewContentsLineSpacing    = _introViewContentsLineSpacing;
@synthesize introViewBGC                    = _introViewBGC;
@synthesize introViewContentsTextColor      = _introViewContentsTextColor;
@synthesize introViewExpireDateFontSize             = _introViewExpireDateFontSize;
@synthesize introViewExpireDateTextColor            = _introViewExpireDateTextColor;
@synthesize introViewExpireDateExpiringTextColor    = _introViewExpireDateExpiringTextColor;
@synthesize introViewExpireDateExpiringAlertDays    = _introViewExpireDateExpiringAlertDays;

//  for pop menu.
@synthesize popMenuInteritemSpacing         = _popMenuInteritemSpacing;
@synthesize popMenuPopOutAnimateDuration    = _popMenuPopOutAnimateDuration;
@synthesize popMenuBlurLayerColor           = _popMenuBlurLayerColor;
@synthesize popMenuBlayLayerWidthScale      = _popMenuBlayLayerWidthScale;

//  for StickeSolo View.

@synthesize soloViewInsetSize               = _soloViewInsetSize;
@synthesize soloViewBlurLayerInsetSize      = _soloViewBlurLayerInsetSize;
@synthesize soloViewBlurLayerInsetSizeOnTop = _soloViewBlurLayerInsetSizeOnTop;
@synthesize soloViewBlurLayerAlphaOnTop     = _soloViewBlurLayerAlphaOnTop;
@synthesize soloViewBlurLayerColor          = _soloViewBlurLayerColor;
@synthesize soloViewShowAnimateDuration     = _soloViewShowAnimateDuration;
@synthesize soloViewHideAnimateDuration     = _soloViewHideAnimateDuration;

//  for UIBackgroundColor
@synthesize navigationBGC           = _navigationBGC;

//  ------------------------------------------------------------------------------------------------
//  ------------------------------------------------------------------------------------------------
#pragma mark overwrite implementation of NSObject
//  ------------------------------------------------------------------------------------------------
- ( instancetype ) init
{
    self                            = [super init];
    if ( nil == self )
    {
        return nil;
    }
    
    [self                           _InitAttributes];
    [self                           _InitDefaultResources];
    return self;
}

//  ------------------------------------------------------------------------------------------------
- ( void ) dealloc
{
    if ( nil != sysStyleBundleManager )
    {
        SAFE_ARC_RELEASE( sysStyleBundleManager );
        sysStyleBundleManager       = nil;
    }
    
    if ( nil != defaultResources )
    {
        SAFE_ARC_RELEASE( defaultResources );
        defaultResources            = nil;
    }
}

//  ------------------------------------------------------------------------------------------------
#pragma mark overwrite properties of the class
//  ------------------------------------------------------------------------------------------------
- ( void ) setSysStyleBundleName:(NSString *)bundleName
{
    _sysStyleBundleName             = bundleName;
    
    if ( ( nil == sysStyleBundleManager ) && ( nil != bundleName ) )
    {
        sysStyleBundleManager       = [TDResourceManager assetsBundleEnvironment: bundleName with: [self class] onSingleton: NO];
    }
}

//  ------------------------------------------------------------------------------------------------
- ( BOOL ) isSaveTabMenuCurrentTabTag
{
    return stateFlags.saveTabMenuCurrentTabTag;
}

//  ------------------------------------------------------------------------------------------------
- ( void ) setSaveTabMenuCurrentTabTag:(BOOL)saveTabMenuCurrentTabTag
{
    stateFlags.saveTabMenuCurrentTabTag                     = saveTabMenuCurrentTabTag;
}

//  ------------------------------------------------------------------------------------------------
- ( BOOL ) isTableItemSizeUsingImageOriginalProportion
{
    return stateFlags.tableItemSizeUsingImageOriginalProportion;
}

//  ------------------------------------------------------------------------------------------------
- ( void ) setTableItemSizeUsingImageOriginalProportion:(BOOL)usingImageOriginalProportion
{
    stateFlags.tableItemSizeUsingImageOriginalProportion    = usingImageOriginalProportion;
}

//  ------------------------------------------------------------------------------------------------
- ( BOOL ) isSaveTableSectionMiniStateChange
{
    return stateFlags.saveTableSectionMiniStateChange;
}

//  ------------------------------------------------------------------------------------------------
- ( void ) setSaveTableSectionMiniStateChange:(BOOL)saveTableSectionMiniStateChange
{
    stateFlags.saveTableSectionMiniStateChange              = saveTableSectionMiniStateChange;
}

//  ------------------------------------------------------------------------------------------------
- ( BOOL ) isStickerSoloViewEnabled
{
    return stateFlags.stickerSoloViewEnabled;
}

//  ------------------------------------------------------------------------------------------------
- ( void ) setStickerSoloViewEnabled:(BOOL)stickerSoloViewEnabled
{
    stateFlags.stickerSoloViewEnabled   = stickerSoloViewEnabled;
}

//  ------------------------------------------------------------------------------------------------
- ( BOOL ) isStickerSoloViewUseBlurLayer
{
    return  stateFlags.stickerSoloViewUseBlurLayer;
}

//  ------------------------------------------------------------------------------------------------
- ( void ) setStickerSoloViewUseBlurLayer:(BOOL)stickerSoloViewUseBlurLayer
{
    stateFlags.stickerSoloViewUseBlurLayer  = stickerSoloViewUseBlurLayer;
}

//  ------------------------------------------------------------------------------------------------
- ( void ) setSysStyleTintedColor:(UIColor *)sysStyleTintedColor
{
    _sysStyleTintedColor                = sysStyleTintedColor;
    if ( nil != defaultResources )
    {
        [defaultResources               setSysStyleTintedColor: sysStyleTintedColor];
    }
}

//  ------------------------------------------------------------------------------------------------
- ( void ) setSysStyleTintedColorAlpha:(CGFloat)sysStyleTintedColorAlpha
{
    _sysStyleTintedColorAlpha           = sysStyleTintedColorAlpha;
    if ( nil != defaultResources )
    {
        [defaultResources               setSysStyleTintedColorAlpha: sysStyleTintedColorAlpha];
    }
}

//  ------------------------------------------------------------------------------------------------
- ( void ) setSysStyleHighlightedTintedColor:(UIColor *)sysStyleHighlightedTintedColor
{
    _sysStyleHighlightedTintedColor     = sysStyleHighlightedTintedColor;
    if ( nil != defaultResources )
    {
        [defaultResources               setSysStyleHighlightedTintedColor: sysStyleHighlightedTintedColor];
    }
}

//  ------------------------------------------------------------------------------------------------
- ( void ) setSysStyleHighlightedTintedColorAlpha:(CGFloat)sysStyleHighlightedTintedColorAlpha
{
    _sysStyleHighlightedTintedColorAlpha= sysStyleHighlightedTintedColorAlpha;
    if ( nil != defaultResources )
    {
        [defaultResources               setSysStyleHighlightedTintedColorAlpha: sysStyleHighlightedTintedColorAlpha];
    }
}

//  ------------------------------------------------------------------------------------------------
- ( void ) setSysStyleDisabledTintedColor:(UIColor *)sysStyleDisabledTintedColor
{
    _sysStyleDisabledTintedColor        = sysStyleDisabledTintedColor;
    if ( nil != defaultResources )
    {
        [defaultResources               setSysStyleDisabledTintedColor: sysStyleDisabledTintedColor];
    }
}

//  ------------------------------------------------------------------------------------------------
- ( void ) setSysStyleDisabledTintedColorAlpha:(CGFloat)sysStyleDisabledTintedColorAlpha
{
    _sysStyleDisabledTintedColorAlpha   = sysStyleDisabledTintedColorAlpha;
    if ( nil != defaultResources )
    {
        [defaultResources               setSysStyleDisabledTintedColorAlpha: sysStyleDisabledTintedColorAlpha];
    }
}

//  ------------------------------------------------------------------------------------------------
#pragma mark method for get system style's image
//  ------------------------------------------------------------------------------------------------
- ( UIImage * ) sysStyleBackToMenuImage
{
    return [self _ImageFromSysStyleBundleWithTintedColor: [self sysStyleBackToMenuImageName]];
}

//  ------------------------------------------------------------------------------------------------
- ( UIImage * ) sysStyleBackToMenuImageHighlighted
{
    return [self _ImageFromSysStyleBundleWithHighlightTintedColor: [self sysStyleBackToMenuHighlightedImageName]];
}

//  ------------------------------------------------------------------------------------------------
- ( UIImage * ) sysStyleBackImage
{
    return [self _ImageFromSysStyleBundleWithTintedColor: [self sysStyleBackImageName]];
}

//  ------------------------------------------------------------------------------------------------
- ( UIImage * ) sysStyleBackImageHighlighted
{
    return [self _ImageFromSysStyleBundleWithHighlightTintedColor: [self sysStyleBackHighlightedImageName]];
}

//  ------------------------------------------------------------------------------------------------
- ( UIImage * ) sysStyleBackImageDisabled
{
    return [self _ImageFromSysStyleBundleWithDisbledTintedColor: [self sysStyleBackDisabledImageName]];
}

//  ------------------------------------------------------------------------------------------------
- ( UIImage * ) sysStyleDownloadImage
{
    return [self _ImageFromSysStyleBundleWithTintedColor: [self sysStyleDownloadImageName]];
}

//  ------------------------------------------------------------------------------------------------
- ( UIImage * ) sysStyleDownloadImageHighlighted
{
    return [self _ImageFromSysStyleBundleWithHighlightTintedColor: [self sysStyleDownloadHighlightedImageName]];
}

//  ------------------------------------------------------------------------------------------------
- ( UIImage * ) sysStyleDownloadImageDisabled
{
    return [self _ImageFromSysStyleBundleWithDisbledTintedColor: [self sysStyleDownloadDisabledImageName]];
}

//  ------------------------------------------------------------------------------------------------
- ( UIImage * ) sysStyleDeleteImage
{
    return [self _ImageFromSysStyleBundleWithAlertTintedColor: [self sysStyleDeleteImageName]];
}

//  ------------------------------------------------------------------------------------------------
- ( UIImage * ) sysStyleDeleteImageHighlighted
{
    return [self _ImageFromSysStyleBundleWithHighlightedAlertTintedColor: [self sysStyleDeleteHighlightedImageName]];
}

//  ------------------------------------------------------------------------------------------------
- ( UIImage * ) sysStyleDeleteImageDisabled
{
    return [self _ImageFromSysStyleBundleWithDisbledTintedColor: [self sysStyleDeleteDisabledImageName]];
}


//  ------------------------------------------------------------------------------------------------
#pragma mark method for get default's assets bundle image
//  ------------------------------------------------------------------------------------------------
- ( UIImage * ) defaultNoImage
{
    if ( nil == defaultResources )
    {
        return nil;
    }
    return [defaultResources defaultNoImage];
}

//  ------------------------------------------------------------------------------------------------
- ( UIImage * ) sectionHeaderInforImage
{
    if ( nil == defaultResources )
    {
        return nil;
    }
    return [defaultResources sectionHeaderInforImage];
}

//  ------------------------------------------------------------------------------------------------
- ( UIImage * ) sectionHeaderInforImageHighlighted
{
    if ( nil == defaultResources )
    {
        return nil;
    }
    return [defaultResources sectionHeaderInforImageHighlighted];
}

//  ------------------------------------------------------------------------------------------------
- ( UIImage * ) sectionHeaderInforImageDisabled
{
    if ( nil == defaultResources )
    {
        return nil;
    }
    return [defaultResources sectionHeaderInforImageDisabled];
}

//  ------------------------------------------------------------------------------------------------
- ( UIImage * ) sectionHeaderArrowDownImage
{
    if ( nil == defaultResources )
    {
        return nil;
    }
    return [defaultResources sectionHeaderArrowDownImage];
}

//  ------------------------------------------------------------------------------------------------
- ( UIImage * ) sectionHeaderArrowDownImageHighlighted
{
    if ( nil == defaultResources )
    {
        return nil;
    }
    return [defaultResources sectionHeaderArrowDownImageHighlighted];
}

//  ------------------------------------------------------------------------------------------------
- ( UIImage * ) sectionHeaderArrowDownImageDisabled
{
    if ( nil == defaultResources )
    {
        return nil;
    }
    return [defaultResources sectionHeaderArrowDownImageDisabled];
}

//  ------------------------------------------------------------------------------------------------
- ( UIImage * ) sectionHeaderArrowUpImage
{
    if ( nil == defaultResources )
    {
        return nil;
    }
    return [defaultResources sectionHeaderArrowUpImage];
}

//  ------------------------------------------------------------------------------------------------
- ( UIImage * ) sectionHeaderArrowUpImageHighlighted;
{
    if ( nil == defaultResources )
    {
        return nil;
    }
    return [defaultResources sectionHeaderArrowUpImageHighlighted];
}

//  ------------------------------------------------------------------------------------------------
- ( UIImage * ) sectionHeaderArrowUpImageDisabled;
{
    if ( nil == defaultResources )
    {
        return nil;
    }
    return [defaultResources sectionHeaderArrowUpImageDisabled];
}

//  ------------------------------------------------------------------------------------------------
- ( UIImage * ) popMenuPopOutImage
{
    if ( nil == defaultResources )
    {
        return nil;
    }
    return [defaultResources popMenuPopOutImage];
}

//  ------------------------------------------------------------------------------------------------
- ( UIImage * ) popMenuPopOutImageHightlighted
{
    if ( nil == defaultResources )
    {
        return nil;
    }
    return [defaultResources popMenuPopOutImageHightlighted];
}

//  ------------------------------------------------------------------------------------------------
- ( UIImage * ) popMenuPopOutImageDisabled
{
    if ( nil == defaultResources )
    {
        return nil;
    }
    return [defaultResources popMenuPopOutImageDisabled];
}

//  ------------------------------------------------------------------------------------------------
- ( UIImage * ) popMenuUnPopOutImage
{
    if ( nil == defaultResources )
    {
        return nil;
    }
    return [defaultResources popMenuUnPopOutImage];
}

//  ------------------------------------------------------------------------------------------------
- ( UIImage * ) popMenuUnPopOutImageHightlighted
{
    if ( nil == defaultResources )
    {
        return nil;
    }
    return [defaultResources popMenuUnPopOutImageHightlighted];
}

//  ------------------------------------------------------------------------------------------------
- ( UIImage * ) popMenuUnPopOutImageDisabled
{
    if ( nil == defaultResources )
    {
        return nil;
    }
    return [defaultResources popMenuUnPopOutImageDisabled];
}

//  ------------------------------------------------------------------------------------------------
- ( UIImage * ) popItemActionWebsiteImage
{
    if ( nil == defaultResources )
    {
        return nil;
    }
    return [defaultResources popItemActionWebsiteImage];
}

//  ------------------------------------------------------------------------------------------------
- ( UIImage * ) popItemActionWebsiteImageHightlighted
{
    if ( nil == defaultResources )
    {
        return nil;
    }
    return [defaultResources popItemActionWebsiteImageHightlighted];
}

//  ------------------------------------------------------------------------------------------------
- ( UIImage * ) popItemActionWebsiteImageDisabled
{
    if ( nil == defaultResources )
    {
        return nil;
    }
    return [defaultResources popItemActionWebsiteImageDisabled];
}

//  ------------------------------------------------------------------------------------------------
- ( UIImage * ) popItemActionEMailImage
{
    if ( nil == defaultResources )
    {
        return nil;
    }
    return [defaultResources popItemActionEMailImage];
}

//  ------------------------------------------------------------------------------------------------
- ( UIImage * ) popItemActionEMailImageHightlighted
{
    if ( nil == defaultResources )
    {
        return nil;
    }
    return [defaultResources popItemActionEMailImageHightlighted];
}

//  ------------------------------------------------------------------------------------------------
- ( UIImage * ) popItemActionEMailImageDisabled
{
    if ( nil == defaultResources )
    {
        return nil;
    }
    return [defaultResources popItemActionEMailImageDisabled];
}

//  ------------------------------------------------------------------------------------------------
#pragma mark method for get localized stirng.
//  ------------------------------------------------------------------------------------------------
- ( NSString *) libraryTitleString
{
    if ( nil == defaultResources )
    {
        return nil;
    }
    return [defaultResources localizedStringForKey: @"library title"];
}

//  ------------------------------------------------------------------------------------------------
- ( NSString * ) downloadString
{
    if ( nil == defaultResources )
    {
        return nil;
    }
    return [defaultResources localizedStringForKey: @"download"];
}

//  ------------------------------------------------------------------------------------------------
- ( NSString * ) downloadStringHightlighted
{
    if ( nil == defaultResources )
    {
        return nil;
    }
    return [defaultResources localizedStringForKey: @"download already"];
}

//  ------------------------------------------------------------------------------------------------
- ( NSString * ) deleteString
{
    if ( nil == defaultResources )
    {
        return nil;
    }
    return [defaultResources localizedStringForKey: @"delete"];
}

//  ------------------------------------------------------------------------------------------------
- ( NSString * ) expireDateString
{
    if ( nil == defaultResources )
    {
        return nil;
    }
    return [defaultResources localizedStringForKey: @"expire date"];    
}

//  ------------------------------------------------------------------------------------------------
//  ------------------------------------------------------------------------------------------------

@end

//  ------------------------------------------------------------------------------------------------
//  ------------------------------------------------------------------------------------------------








