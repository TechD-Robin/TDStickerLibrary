//
//  TDStickerLibraryDefaultResources.m
//  TDStickerLibrary
//
//  Created by Robin Hsu on 2015/5/28.
//  Copyright (c) 2015年 TechD. All rights reserved.
//
//  ------------------------------------------------------------------------------------------------
//  ------------------------------------------------------------------------------------------------

#import "UIImage+TechD.h"
#import "TDStickerLibraryDefaultResources.h"

//  ------------------------------------------------------------------------------------------------
//  ------------------------------------------------------------------------------------------------


//  ------------------------------------------------------------------------------------------------
//  ------------------------------------------------------------------------------------------------
#pragma mark -
#pragma mark class TDStickerLibraryDefaultResources

//  ------------------------------------------------------------------------------------------------
//  ------------------------------------------------------------------------------------------------
#pragma mark declare private category ()
//  ------------------------------------------------------------------------------------------------
//  --------------------------------
@interface TDStickerLibraryDefaultResources ()
{
    
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
@interface TDStickerLibraryDefaultResources (Private)

//  ------------------------------------------------------------------------------------------------
#pragma mark declare for initial this class.
//  ------------------------------------------------------------------------------------------------
/**
 *  @brief initial the attributes of class.
 *  initial the attributes of class.
 */
- ( void ) _InitAttributes;



//  ------------------------------------------------------------------------------------------------


@end


//  ------------------------------------------------------------------------------------------------
//  ------------------------------------------------------------------------------------------------

//  ------------------------------------------------------------------------------------------------
//  ------------------------------------------------------------------------------------------------
#pragma mark -
#pragma mark implementation private category (Private)
//  ------------------------------------------------------------------------------------------------
@implementation TDStickerLibraryDefaultResources (Private)

//  ------------------------------------------------------------------------------------------------
#pragma mark method for initial this class.
//  ------------------------------------------------------------------------------------------------
//  --------------------------------
- ( void ) _InitAttributes
{
    //  sys style.
    [self                           setSysStyleTintedColor: [UIColor cyanColor]];
    [self                           setSysStyleTintedColorAlpha: 0.32f];
    
    [self                           setSysStyleHighlightedTintedColor: [UIColor cyanColor]];
    [self                           setSysStyleHighlightedTintedColorAlpha: 0.32f];
    
    [self                           setSysStyleDisabledTintedColor: [UIColor lightGrayColor]];
    [self                           setSysStyleDisabledTintedColorAlpha: 0.0f];
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
@implementation TDStickerLibraryDefaultResources

//  ------------------------------------------------------------------------------------------------
#pragma mark synthesize variable.
//  sys style.
@synthesize sysStyleTintedColor                     = _sysStyleTintedColor;
@synthesize sysStyleTintedColorAlpha                = _sysStyleTintedColorAlpha;

@synthesize sysStyleHighlightedTintedColor          = _sysStyleHighlightedTintedColor;
@synthesize sysStyleHighlightedTintedColorAlpha     = _sysStyleHighlightedTintedColorAlpha;

@synthesize sysStyleDisabledTintedColor             = _sysStyleDisabledTintedColor;
@synthesize sysStyleDisabledTintedColorAlpha        = _sysStyleDisabledTintedColorAlpha;

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
#pragma mark method for get default's assets bundle image
//  ------------------------------------------------------------------------------------------------
/**
 *  @brief  get a image from this resource manager by image name.
 *   get a image from this resource manager by image name.
 *
 *  @param imageName                image name.
 *
 *  @return image|nil               the image object or nil.
 */
- ( UIImage * ) defaultImage:(NSString *)imageName
{
    if ( nil == imageName )
    {
        return nil;
    }
    return [self image: imageName ofType: @"png" inDirectory: kTDStickerLibraryDefaultImagesInDirectory];
}

//  ------------------------------------------------------------------------------------------------
- ( UIImage * ) defaultNoImage
{
    return [self defaultImage: @"no-image"];
}

//  ------------------------------------------------------------------------------------------------
- ( UIImage * ) sectionHeaderInforImage
{
    UIImage                       * image;
    
    image                           = [self defaultImage: @"flaticon_info-sign_3716"];
    if ( nil == image )
    {
        return nil;
    }
    //return [image imageWithTintedColor: [UIColor grayColor] colorAlpha: 0.42f];
    if ( [self sysStyleTintedColor] == nil )
    {
        return image;
    }
    return [image imageWithTintedColor: [self sysStyleTintedColor] colorAlpha: [self sysStyleTintedColorAlpha]];
}

//  ------------------------------------------------------------------------------------------------
- ( UIImage * ) sectionHeaderInforImageHighlighted
{
    UIImage                       * image;
    UIImage                       * tintedImage;
    
    tintedImage                     = nil;
    image                           = [self defaultImage: @"flaticon_info-sign_3716"];
    if ( nil == image )
    {
        return nil;
    }
    tintedImage                     = [image imageWithTintedColor: [UIColor whiteColor]];
    if ( nil == tintedImage )
    {
        return image;
    }
    //return [image imageWithTintedColor: [UIColor grayColor] colorAlpha: 0.12f];
    if ( [self sysStyleHighlightedTintedColor] == nil )
    {
        return tintedImage;
    }
    return [tintedImage imageWithTintedColor: [self sysStyleHighlightedTintedColor] colorAlpha: [self sysStyleHighlightedTintedColorAlpha]];
}

//  ------------------------------------------------------------------------------------------------
- ( UIImage * ) sectionHeaderInforImageDisabled
{
    UIImage                       * image;
    
    image                           = [self defaultImage: @"flaticon_info-sign_3716"];
    if ( nil == image )
    {
        return nil;
    }
    return [image imageWithTintedColor: [UIColor darkGrayColor] colorAlpha: 0.42f];
}

//  ------------------------------------------------------------------------------------------------
- ( UIImage * ) sectionHeaderArrowDownImage
{
    UIImage                       * image;
    
    image                           = [self defaultImage: @"ic_arrow_drop_down_black_36dp"];
    if ( nil == image )
    {
        return nil;
    }
    return [image imageWithTintedColor: [UIColor grayColor] colorAlpha: 0.42f];

}

//  ------------------------------------------------------------------------------------------------
- ( UIImage * ) sectionHeaderArrowDownImageHighlighted
{
    UIImage                       * image;
    UIImage                       * tintedImage;
    
    tintedImage                     = nil;
    image                           = [self defaultImage: @"ic_arrow_drop_down_black_36dp"];
    if ( nil == image )
    {
        return nil;
    }
    tintedImage                     = [image imageWithTintedColor: [UIColor whiteColor]];
    if ( nil == tintedImage )
    {
        return image;
    }
    return [tintedImage imageWithTintedColor: [UIColor grayColor] colorAlpha: 0.12f];
}

//  ------------------------------------------------------------------------------------------------
- ( UIImage * ) sectionHeaderArrowDownImageDisabled
{
    UIImage                       * image;

    image                           = [self defaultImage: @"ic_arrow_drop_down_black_36dp"];
    if ( nil == image )
    {
        return nil;
    }
    return [image imageWithTintedColor: [UIColor darkGrayColor] colorAlpha: 0.42f];
}

//  ------------------------------------------------------------------------------------------------
- ( UIImage * ) sectionHeaderArrowUpImage
{
    UIImage                       * image;
    
    image                           = [self defaultImage: @"ic_arrow_drop_up_black_36dp"];
    if ( nil == image )
    {
        return nil;
    }
    return [image imageWithTintedColor: [UIColor grayColor] colorAlpha: 0.42f];
}

//  ------------------------------------------------------------------------------------------------
- ( UIImage * ) sectionHeaderArrowUpImageHighlighted
{
    UIImage                       * image;
    UIImage                       * tintedImage;
    
    tintedImage                     = nil;
    image                           = [self defaultImage: @"ic_arrow_drop_up_black_36dp"];
    if ( nil == image )
    {
        return nil;
    }
    tintedImage                     = [image imageWithTintedColor: [UIColor whiteColor]];
    if ( nil == tintedImage )
    {
        return image;
    }
    return [tintedImage imageWithTintedColor: [UIColor grayColor] colorAlpha: 0.12f];
}

//  ------------------------------------------------------------------------------------------------
- ( UIImage * ) sectionHeaderArrowUpImageDisabled
{
    UIImage                       * image;
    
    image                           = [self defaultImage: @"ic_arrow_drop_up_black_36dp"];
    if ( nil == image )
    {
        return nil;
    }
    return [image imageWithTintedColor: [UIColor darkGrayColor] colorAlpha: 0.42f];
}

//  ------------------------------------------------------------------------------------------------
- ( UIImage * ) popMenuPopOutImage
{
    UIImage                       * image;
    
    image                           = [self defaultImage: @"ic_format_indent_decrease_36"];
    if ( nil == image )
    {
        return nil;
    }
    if ( [self sysStyleTintedColor] == nil )
    {
        return image;
    }
    return [image imageWithTintedColor: [self sysStyleTintedColor] colorAlpha: [self sysStyleTintedColorAlpha]];
}

//  ------------------------------------------------------------------------------------------------
- ( UIImage * ) popMenuPopOutImageHightlighted
{
    UIImage                       * image;
    UIImage                       * tintedImage;
    
    tintedImage                     = nil;
    image                           = [self defaultImage: @"ic_format_indent_decrease_36"];
    if ( nil == image )
    {
        return nil;
    }
    
    tintedImage                     = [image imageWithTintedColor: [UIColor whiteColor]];
    if ( nil == tintedImage )
    {
        return image;
    }
    if ( [self sysStyleHighlightedTintedColor] == nil )
    {
        return tintedImage;
    }
    return [tintedImage imageWithTintedColor: [self sysStyleHighlightedTintedColor] colorAlpha: [self sysStyleHighlightedTintedColorAlpha]];
}

//  ------------------------------------------------------------------------------------------------
- ( UIImage * ) popMenuPopOutImageDisabled
{
    UIImage                       * image;
    UIImage                       * tintedImage;
    
    tintedImage                     = nil;
    image                           = [self defaultImage: @"ic_format_indent_decrease_36"];
    if ( nil == image )
    {
        return nil;
    }
    
    tintedImage                     = [image imageWithTintedColor: [UIColor whiteColor]];
    if ( nil == tintedImage )
    {
        return image;
    }
    if ( [self sysStyleDisabledTintedColor] == nil )
    {
        return tintedImage;
    }
    return [tintedImage imageWithTintedColor: [self sysStyleDisabledTintedColor] colorAlpha: [self sysStyleDisabledTintedColorAlpha]];
}

//  ------------------------------------------------------------------------------------------------
- ( UIImage * ) popMenuUnPopOutImage
{
    UIImage                       * image;
    
    image                           = [self defaultImage: @"ic_format_indent_increase_36"];
    if ( nil == image )
    {
        return nil;
    }
    if ( [self sysStyleTintedColor] == nil )
    {
        return image;
    }
    return [image imageWithTintedColor: [self sysStyleTintedColor] colorAlpha: [self sysStyleTintedColorAlpha]];
}

//  ------------------------------------------------------------------------------------------------
- ( UIImage * ) popMenuUnPopOutImageHightlighted
{
    UIImage                       * image;
    UIImage                       * tintedImage;
    
    tintedImage                     = nil;
    image                           = [self defaultImage: @"ic_format_indent_increase_36"];
    if ( nil == image )
    {
        return nil;
    }
    
    tintedImage                     = [image imageWithTintedColor: [UIColor whiteColor]];
    if ( nil == tintedImage )
    {
        return image;
    }
    if ( [self sysStyleHighlightedTintedColor] == nil )
    {
        return tintedImage;
    }
    return [tintedImage imageWithTintedColor: [self sysStyleHighlightedTintedColor] colorAlpha: [self sysStyleHighlightedTintedColorAlpha]];
}

//  ------------------------------------------------------------------------------------------------
- ( UIImage * ) popMenuUnPopOutImageDisabled
{
    UIImage                       * image;
    UIImage                       * tintedImage;
    
    tintedImage                     = nil;
    image                           = [self defaultImage: @"ic_format_indent_increase_36"];
    if ( nil == image )
    {
        return nil;
    }
    
    tintedImage                     = [image imageWithTintedColor: [UIColor whiteColor]];
    if ( nil == tintedImage )
    {
        return image;
    }
    if ( [self sysStyleDisabledTintedColor] == nil )
    {
        return tintedImage;
    }
    return [tintedImage imageWithTintedColor: [self sysStyleDisabledTintedColor] colorAlpha: [self sysStyleDisabledTintedColorAlpha]];
}

//  ------------------------------------------------------------------------------------------------
- ( UIImage * ) popItemActionWebsiteImage
{
    UIImage                       * image;
    
    image                           = [self defaultImage: @"ic_public_black_36dp"];
    if ( nil == image )
    {
        return nil;
    }
    if ( [self sysStyleTintedColor] == nil )
    {
        return image;
    }
    return [image imageWithTintedColor: [self sysStyleTintedColor] colorAlpha: [self sysStyleTintedColorAlpha]];
}

//  ------------------------------------------------------------------------------------------------
- ( UIImage * ) popItemActionWebsiteImageHightlighted
{
    UIImage                       * image;
    UIImage                       * tintedImage;
    
    tintedImage                     = nil;
    image                           = [self defaultImage: @"ic_public_black_36dp"];
    if ( nil == image )
    {
        return nil;
    }
    
    tintedImage                     = [image imageWithTintedColor: [UIColor whiteColor]];
    if ( nil == tintedImage )
    {
        return image;
    }
    if ( [self sysStyleHighlightedTintedColor] == nil )
    {
        return tintedImage;
    }
    return [tintedImage imageWithTintedColor: [self sysStyleHighlightedTintedColor] colorAlpha: [self sysStyleHighlightedTintedColorAlpha]];
}

//  ------------------------------------------------------------------------------------------------
- ( UIImage * ) popItemActionWebsiteImageDisabled
{
    UIImage                       * image;
    UIImage                       * tintedImage;
    
    tintedImage                     = nil;
    image                           = [self defaultImage: @"ic_public_black_36dp"];
    if ( nil == image )
    {
        return nil;
    }
    
    tintedImage                     = [image imageWithTintedColor: [UIColor whiteColor]];
    if ( nil == tintedImage )
    {
        return image;
    }
    if ( [self sysStyleDisabledTintedColor] == nil )
    {
        return tintedImage;
    }
    return [tintedImage imageWithTintedColor: [self sysStyleDisabledTintedColor] colorAlpha: [self sysStyleDisabledTintedColorAlpha]];
}

//  ------------------------------------------------------------------------------------------------
- ( UIImage * ) popItemActionEMailImage
{
    UIImage                       * image;
    
    image                           = [self defaultImage: @"ic_email_black_36dp"];
    if ( nil == image )
    {
        return nil;
    }
    if ( [self sysStyleTintedColor] == nil )
    {
        return image;
    }
    return [image imageWithTintedColor: [self sysStyleTintedColor] colorAlpha: [self sysStyleTintedColorAlpha]];
}

//  ------------------------------------------------------------------------------------------------
- ( UIImage * ) popItemActionEMailImageHightlighted
{
    UIImage                       * image;
    UIImage                       * tintedImage;
    
    tintedImage                     = nil;
    image                           = [self defaultImage: @"ic_email_black_36dp"];
    if ( nil == image )
    {
        return nil;
    }
    
    tintedImage                     = [image imageWithTintedColor: [UIColor whiteColor]];
    if ( nil == tintedImage )
    {
        return image;
    }
    if ( [self sysStyleHighlightedTintedColor] == nil )
    {
        return tintedImage;
    }
    return [tintedImage imageWithTintedColor: [self sysStyleHighlightedTintedColor] colorAlpha: [self sysStyleHighlightedTintedColorAlpha]];
}

//  ------------------------------------------------------------------------------------------------
- ( UIImage * ) popItemActionEMailImageDisabled
{
    UIImage                       * image;
    UIImage                       * tintedImage;
    
    tintedImage                     = nil;
    image                           = [self defaultImage: @"ic_email_black_36dp"];
    if ( nil == image )
    {
        return nil;
    }
    
    tintedImage                     = [image imageWithTintedColor: [UIColor whiteColor]];
    if ( nil == tintedImage )
    {
        return image;
    }
    if ( [self sysStyleDisabledTintedColor] == nil )
    {
        return tintedImage;
    }
    return [tintedImage imageWithTintedColor: [self sysStyleDisabledTintedColor] colorAlpha: [self sysStyleDisabledTintedColorAlpha]];
}

//  ------------------------------------------------------------------------------------------------
//  ------------------------------------------------------------------------------------------------

@end

//  ------------------------------------------------------------------------------------------------
//  ------------------------------------------------------------------------------------------------








