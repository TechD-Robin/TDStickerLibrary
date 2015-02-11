//
//  TDStickerLibraryCustomization.m
//  TDStickerLibrary
//
//  Created by Robin Hsu on 2015/1/22.
//  Copyright (c) 2015年 TechD. All rights reserved.
//
//  ------------------------------------------------------------------------------------------------
//  ------------------------------------------------------------------------------------------------

#import "TDStickerLibraryCustomization.h"

//  ------------------------------------------------------------------------------------------------
//  ------------------------------------------------------------------------------------------------


//  ------------------------------------------------------------------------------------------------
//  ------------------------------------------------------------------------------------------------
#pragma mark -
#pragma mark class TDStickerLibraryCustomization

//  ------------------------------------------------------------------------------------------------
//  ------------------------------------------------------------------------------------------------
//  declare property for private category()
//  ------------------------------------------------------------------------------------------------
#pragma mark declare property ()
@interface TDStickerLibraryCustomization()
{
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
//  method declare for Private of category
//  ------------------------------------------------------------------------------------------------
#pragma mark -
#pragma mark declare for Private
@interface TDStickerLibraryCustomization(Private)

//  ------------------------------------------------------------------------------------------------
//  ------------------------------------------------------------------------------------------------
/**
 *  @brief initial the attributes of class.
 *  initial the attributes of class.
 */
- ( void ) _InitAttributes;


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
//  method implementation for Private of category
//  ------------------------------------------------------------------------------------------------
#pragma mark -
#pragma mark implementation for Private method
@implementation TDStickerLibraryCustomization(Private)

//  ------------------------------------------------------------------------------------------------
//  ------------------------------------------------------------------------------------------------
//  --------------------------------
- ( void ) _InitAttributes
{
    [self                           setConfigureResource: @"Configure"];
    [self                           setInZippedPrefixPath: @"StickerLibraryTabDefault"];
    [self                           setTabConfigureFilename: @"StickerLibraryTabDefault"];
    [self                           setInZippedUpdatePrefixPath: @"StickerLibraryTabUpdate"];
    [self                           setTabConfigureUpdateFilename: @"StickerLibraryTabUpdate"];
    
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

    //  for StickeSolo View.
    stateFlags.stickerSoloViewEnabled       = YES;
    stateFlags.stickerSoloViewUseBlurLayer  = YES;
    
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

@end

//  ------------------------------------------------------------------------------------------------
//  ------------------------------------------------------------------------------------------------


//  ------------------------------------------------------------------------------------------------
//  ------------------------------------------------------------------------------------------------
//  public method implementation.
//  ------------------------------------------------------------------------------------------------
#pragma mark -
#pragma mark implementation for public method
@implementation TDStickerLibraryCustomization

//  ------------------------------------------------------------------------------------------------
#pragma mark synthesize variable.
@synthesize configureResource           = _configureResource;
@synthesize inZippedPrefixPath          = _inZippedPrefixPath;
@synthesize tabConfigureFilename        = _tabConfigureFilename;
@synthesize inZippedUpdatePrefixPath    = _inZippedUpdatePrefixPath;
@synthesize tabConfigureUpdateFilename  = _tabConfigureUpdateFilename;


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
    
    return self;
}

//  ------------------------------------------------------------------------------------------------
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
//  ------------------------------------------------------------------------------------------------

@end









