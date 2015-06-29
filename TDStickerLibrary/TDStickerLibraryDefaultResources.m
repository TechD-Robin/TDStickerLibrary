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
    [self                           setSysStyleTintedColor: nil];
    [self                           setSysStyleTintedColorAlpha: 0.0f];
    
    [self                           setSysStyleHighlightedITintedColor: nil];
    [self                           setSysStyleHighlightedITintedColorAlpha: 0.0f];
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

@synthesize sysStyleHighlightedITintedColor         = _sysStyleHighlightedITintedColor;
@synthesize sysStyleHighlightedITintedColorAlpha    = _sysStyleHighlightedITintedColorAlpha;

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
    return [image imageWithTintedColor: [self sysStyleTintedColor] colorAlpha: [self sysStyleTintedColorAlpha]];
}

//  ------------------------------------------------------------------------------------------------
- ( UIImage * ) sectionHeaderInforImageHighlighted
{
    UIImage                       * image;
    
    image                           = [self defaultImage: @"flaticon_info-sign_3716"];
    if ( nil == image )
    {
        return nil;
    }
    image                           = [image imageWithTintedColor: [UIColor whiteColor]];
    if ( nil == image )
    {
        return nil;
    }
    //return [image imageWithTintedColor: [UIColor grayColor] colorAlpha: 0.12f];
    return [image imageWithTintedColor: [self sysStyleHighlightedITintedColor] colorAlpha: [self sysStyleHighlightedITintedColorAlpha]];
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
    
    image                           = [self defaultImage: @"ic_arrow_drop_down_black_36dp"];
    if ( nil == image )
    {
        return nil;
    }
    image                           = [image imageWithTintedColor: [UIColor whiteColor]];
    if ( nil == image )
    {
        return nil;
    }
    return [image imageWithTintedColor: [UIColor grayColor] colorAlpha: 0.12f];
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
    
    image                           = [self defaultImage: @"ic_arrow_drop_up_black_36dp"];
    if ( nil == image )
    {
        return nil;
    }
    image                           = [image imageWithTintedColor: [UIColor whiteColor]];
    if ( nil == image )
    {
        return nil;
    }
    return [image imageWithTintedColor: [UIColor grayColor] colorAlpha: 0.12f];
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
    return [image imageWithTintedColor: [self sysStyleTintedColor] colorAlpha: [self sysStyleTintedColorAlpha]];
}

//  ------------------------------------------------------------------------------------------------
- ( UIImage * ) popMenuPopOutImageHightlighted
{
    UIImage                       * image;
    
    image                           = [self defaultImage: @"ic_format_indent_decrease_36"];
    if ( nil == image )
    {
        return nil;
    }
    
    image                           = [image imageWithTintedColor: [UIColor whiteColor]];
    if ( nil == image )
    {
        return nil;
    }
    return [image imageWithTintedColor: [self sysStyleHighlightedITintedColor] colorAlpha: [self sysStyleHighlightedITintedColorAlpha]];
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
    return [image imageWithTintedColor: [self sysStyleTintedColor] colorAlpha: [self sysStyleTintedColorAlpha]];
}

//  ------------------------------------------------------------------------------------------------
- ( UIImage * ) popMenuUnPopOutImageHightlighted
{
    UIImage                       * image;
    
    image                           = [self defaultImage: @"ic_format_indent_increase_36"];
    if ( nil == image )
    {
        return nil;
    }
    
    image                           = [image imageWithTintedColor: [UIColor whiteColor]];
    if ( nil == image )
    {
        return nil;
    }
    return [image imageWithTintedColor: [self sysStyleHighlightedITintedColor] colorAlpha: [self sysStyleHighlightedITintedColorAlpha]];
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
    return [image imageWithTintedColor: [self sysStyleTintedColor] colorAlpha: [self sysStyleTintedColorAlpha]];    
}

//  ------------------------------------------------------------------------------------------------
- ( UIImage * ) popItemActionWebsiteImageHightlighted
{
    UIImage                       * image;
    
    image                           = [self defaultImage: @"ic_public_black_36dp"];
    if ( nil == image )
    {
        return nil;
    }
    
    image                           = [image imageWithTintedColor: [UIColor whiteColor]];
    if ( nil == image )
    {
        return nil;
    }
    return [image imageWithTintedColor: [self sysStyleHighlightedITintedColor] colorAlpha: [self sysStyleHighlightedITintedColorAlpha]];
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
    return [image imageWithTintedColor: [self sysStyleTintedColor] colorAlpha: [self sysStyleTintedColorAlpha]];
}

//  ------------------------------------------------------------------------------------------------
- ( UIImage * ) popItemActionEMailImageHightlighted
{
    UIImage                       * image;
    
    image                           = [self defaultImage: @"ic_email_black_36dp"];
    if ( nil == image )
    {
        return nil;
    }
    
    image                           = [image imageWithTintedColor: [UIColor whiteColor]];
    if ( nil == image )
    {
        return nil;
    }
    return [image imageWithTintedColor: [self sysStyleHighlightedITintedColor] colorAlpha: [self sysStyleHighlightedITintedColorAlpha]];
}

//  ------------------------------------------------------------------------------------------------
//  ------------------------------------------------------------------------------------------------

@end

//  ------------------------------------------------------------------------------------------------
//  ------------------------------------------------------------------------------------------------








