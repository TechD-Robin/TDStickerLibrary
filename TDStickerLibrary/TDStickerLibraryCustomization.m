//
//  TDStickerLibraryCustomization.m
//  TDStickerLibrary
//
//  Created by Robin Hsu on 2015/1/22.
//  Copyright (c) 2015年 TechD. All rights reserved.
//
//  ------------------------------------------------------------------------------------------------
//  ------------------------------------------------------------------------------------------------

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
        unsigned int    stickerSoloViewEnabled:1;
        unsigned int    stickerSoloViewUseBlurLayer:1;
        
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
//  ------------------------------------------------------------------------------------------------
/**
 *  when user define new UIColor without default, must call the new UIColor by class method or singleton class method ( static method );
 *  otherwise project will crash when call by instance method.
 */
//  ------------------------------------------------------------------------------------------------
+ ( UIColor * ) _TabMenuColor;
+ ( UIColor * ) _SoloViewBlurLayerColor;

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
    
    [self                           setSysStyleDownloadImageName: nil];
    [self                           setSysStyleDownloadHighlightedImageName: nil];
    [self                           setSysStyleDownloadDisabledImageName: nil];
    
    
    [self                           setSysStyleTintedColor: nil];
    [self                           setSysStyleTintedColorAlpha: 0.0f];
    
    
    //  for system configure default.
    [self                           setSystemConfigureDefaultSubpath:           @"Configure"];
    [self                           setSystemConfigureDefaultDirectory:         TDResourcesDirectory];
    
    [self                           setSystemConfigureTabDefaultFilename:       @"StickerLibraryTabDefault" ];
    [self                           setSystemConfigureTabDefaultInZippedPrefix: @"StickerLibraryTabDefault"];
    

    //  for system configure update.
    [self                           setSystemConfigureUpdateFilename:           @"SystemUpdate.json"];
    [self                           setSystemConfigureUpdateSubpath:            @"Download/Configure"];
    [self                           setSystemConfigureUpdateDirectory:          TDCachesDirectory];
    
    [self                           setSystemConfigureTabUpdateFilename:        @"StickerLibraryTabUpdate"];
    [self                           setSystemConfigureTabUpdateInZippedPrefix:  @"StickerLibraryTabUpdate"];
    
    
    //  for sticker download.
    [self                           setStickerDownloadSubpath:                  @"Sticker"];
    [self                           setStickerDownloadDirectory:                TDCachesDirectory];
    
    //  for UIView.
    [self                           setNavigationBarHeight: 36.0f];
    [self                           setBannerHeight: 48.0f];
    [self                           setTabMenuHeight: 50.0f];
    
    [self                           setTabMenuItemSize: CGSizeMake( 48.0f, 48.0f )];
    [self                           setTabMenuItemSizeInset: CGSizeMake( 3.0f, 3.0f )];
    
    //  for UICollectionView.
    [self                           setTableCommonItemSize: CGSizeMake( 64.0f, 64.0f )];
    [self                           setTableCommonSectionInset: UIEdgeInsetsMake( 12.0f, 12.0f, 12.0f, 12.0f )];
    [self                           setTableCommonHeaderReferenceSize: CGSizeMake( 0.0f, 36.0f )];
    [self                           setTableMinimumInteritemSpacing: 10.0f];
    [self                           setTableMinimumLineSpacing: 10.0f];

    //  for Sticker Solo View.
    //stateFlags.stickerSoloViewEnabled       = YES;
    //stateFlags.stickerSoloViewUseBlurLayer  = YES;
    [self                           setStickerSoloViewEnabled: YES];
    [self                           setStickerSoloViewUseBlurLayer: YES];
    
    
    [self                           setSoloViewInsetSize: CGSizeMake( -6.0f, -6.0f )];
    [self                           setSoloViewBlurLayerInsetSize: CGSizeMake( -12.0f, -12.0f )];
    [self                           setSoloViewBlurLayerInsetSizeOnTop: CGSizeMake( -24.0f, -24.0f )];
    [self                           setSoloViewBlurLayerAlphaOnTop: 0.9f];
    [self                           setSoloViewBlurLayerColor: [[self class] _SoloViewBlurLayerColor] ];
    [self                           setSoloViewShowAnimateDuration: 0.25f];
    [self                           setSoloViewHideAnimateDuration: 0.25f];
    
    //  for UIBackgroundColor
    [self                           setNavigationBGC: [UIColor purpleColor]];
    [self                           setBannerBGC: [UIColor grayColor]];
    [self                           setTabMenuBGC: [[self class] _TabMenuColor]];
    
    
}

//  ------------------------------------------------------------------------------------------------
- ( void ) _InitDefaultResources
{
    defaultResources                = [TDStickerLibraryDefaultResources assetsBundleEnvironment: kTDStickerLibraryDefaultResourcesBundle
                                                                                           with: [self class]
                                                                                    onSingleton: NO];
    NSParameterAssert( nil != defaultResources );
}

//  ------------------------------------------------------------------------------------------------
#pragma mark method for get system style's data.
//  ------------------------------------------------------------------------------------------------
- ( UIImage * ) _ImageFromSysStyleBundle:(NSString *)imageName
{
    if ( nil == sysStyleBundleManager )
    {
        return nil;
    }
    return [sysStyleBundleManager image: imageName ofType: @"png" inDirectory: [self sysStyleImageSubpathInBundle]];
}

//  ------------------------------------------------------------------------------------------------
- ( UIImage * ) _ImageFromSysStyleBundleWithTintedColor:(NSString *)imageName
{
    NSParameterAssert( [self sysStyleTintedColor] != nil );
    if ( nil == sysStyleBundleManager )
    {
        return nil;
    }
    
    UIImage                       * image;
    
    image                           = [sysStyleBundleManager image: imageName ofType: @"png"
                                                       inDirectory: [self sysStyleImageSubpathInBundle]];
    if ( nil == image )
    {
        return nil;
    }
    return [image imageWithTintedColor: [self sysStyleTintedColor] colorAlpha: [self sysStyleTintedColorAlpha]];
}

//  ------------------------------------------------------------------------------------------------
//  ------------------------------------------------------------------------------------------------
+ ( UIColor * ) _TabMenuColor
{
    return [UIColor colorWithRed: 0.5f green: ( 200 / 255.0f ) blue: ( 200 / 255.0f ) alpha: 1.0f ];
}

//  ------------------------------------------------------------------------------------------------
+ ( UIColor * ) _SoloViewBlurLayerColor
{
    return [[UIColor darkGrayColor] colorWithAlphaComponent: 0.9f];
}


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

@synthesize sysStyleDownloadImageName               = _sysStyleDownloadImageName;
@synthesize sysStyleDownloadHighlightedImageName    = _sysStyleDownloadHighlightedImageName;
@synthesize sysStyleDownloadDisabledImageName       = _sysStyleDownloadDisabledImageName;

@synthesize sysStyleTintedColor                     = _sysStyleTintedColor;
@synthesize sysStyleTintedColorAlpha                = _sysStyleTintedColorAlpha;


//  for system configure default.
@synthesize systemConfigureDefaultSubpath           = _systemConfigureDefaultSubpath;
@synthesize systemConfigureDefaultDirectory         = _systemConfigureDefaultDirectory;

@synthesize systemConfigureTabDefaultFilename       = _systemConfigureTabDefaultFilename;
@synthesize systemConfigureTabDefaultInZippedPrefix = _systemConfigureTabDefaultInZippedPrefix;


//  for system configure update.
@synthesize systemConfigureUpdateFilename           = _systemConfigureUpdateFilename;
@synthesize systemConfigureUpdateSubpath            = _systemConfigureUpdateSubpath;
@synthesize systemConfigureUpdateDirectory          = _systemConfigureUpdateDirectory;

@synthesize systemConfigureTabUpdateFilename        = _systemConfigureTabUpdateFilename;
@synthesize systemConfigureTabUpdateInZippedPrefix  = _systemConfigureTabUpdateInZippedPrefix;


//  for sticker download.
@synthesize stickerDownloadSubpath                  = _stickerDownloadSubpath;
@synthesize stickerDownloadDirectory                = _stickerDownloadDirectory;

//  for UIView.
@synthesize navigationBarHeight     = _navigationBarHeight;
@synthesize bannerHeight            = _bannerHeight;
@synthesize tabMenuHeight           = _tabMenuHeight;

@synthesize tabMenuItemSize         = _tabMenuItemSize;
@synthesize tabMenuItemSizeInset    = _tabMenuItemSizeInset;

//  for UICollectionView.
@synthesize tableCommonItemSize             = _tableCommonItemSize;
@synthesize tableCommonSectionInset         = _tableCommonSectionInset;
@synthesize tableCommonHeaderReferenceSize  = _tableCommonHeaderReferenceSize;
@synthesize tableMinimumInteritemSpacing    = _tableMinimumInteritemSpacing;
@synthesize tableMinimumLineSpacing         = _tableMinimumLineSpacing;


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
@synthesize bannerBGC               = _bannerBGC;
@synthesize tabMenuBGC              = _tabMenuBGC;

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
#pragma mark method for get system style's image
//  ------------------------------------------------------------------------------------------------
- ( UIImage * ) sysStyleBackToMenuImage
{
    return [self _ImageFromSysStyleBundleWithTintedColor: [self sysStyleBackToMenuImageName]];
}

//  ------------------------------------------------------------------------------------------------
- ( UIImage * ) sysStyleBackToMenuImageHighlighted
{
    return [self _ImageFromSysStyleBundleWithTintedColor: [self sysStyleBackToMenuHighlightedImageName]];
}

//  ------------------------------------------------------------------------------------------------
- ( UIImage * ) sysStyleDownloadImage
{
    return [self _ImageFromSysStyleBundleWithTintedColor: [self sysStyleDownloadImageName]];
}

//  ------------------------------------------------------------------------------------------------
- ( UIImage * ) sysStyleDownloadImageHighlighted
{
    return [self _ImageFromSysStyleBundleWithTintedColor: [self sysStyleDownloadHighlightedImageName]];
}

//  ------------------------------------------------------------------------------------------------
- ( UIImage * ) sysStyleDownloadImageDisabled
{
    return [self _ImageFromSysStyleBundleWithTintedColor: [self sysStyleDownloadDisabledImageName]];
}

//  ------------------------------------------------------------------------------------------------
#pragma mark method for get default's assets bundle image
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
//  ------------------------------------------------------------------------------------------------

@end

//  ------------------------------------------------------------------------------------------------
//  ------------------------------------------------------------------------------------------------








