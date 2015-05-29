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
- ( UIImage * ) sectionHeaderInforImage
{
    UIImage                       * image;
    
    image                           = [self defaultImage: @"ic_perm_device_info_grey600_36dp"];
    if ( nil == image )
    {
        return nil;
    }
    return [image imageWithTintedColor: [UIColor blackColor] colorAlpha: 0.0f];
}

//  ------------------------------------------------------------------------------------------------
- ( UIImage * ) sectionHeaderInforImageHighlighted
{
    UIImage                       * image;
    
    image                           = [self defaultImage: @"ic_perm_device_info_grey600_36dp"];
    if ( nil == image )
    {
        return nil;
    }
    return [image imageWithTintedColor: [UIColor whiteColor] colorAlpha: 0.33f];
}

//  ------------------------------------------------------------------------------------------------
- ( UIImage * ) sectionHeaderInforImageDisabled
{
    return [self defaultImage: @"ic_perm_device_info_grey600_36dp"];
}

//  ------------------------------------------------------------------------------------------------
- ( UIImage * ) sectionHeaderArrowDownImage
{
    UIImage                       * image;
    
    image                           = [self defaultImage: @"ic_arrow_drop_down_grey600_36dp"];
    if ( nil == image )
    {
        return nil;
    }
    return [image imageWithTintedColor: [UIColor blackColor] colorAlpha: 0.0f];
}

//  ------------------------------------------------------------------------------------------------
- ( UIImage * ) sectionHeaderArrowDownImageHighlighted
{
    UIImage                       * image;
    
    image                           = [self defaultImage: @"ic_arrow_drop_down_grey600_36dp"];
    if ( nil == image )
    {
        return nil;
    }
    return [image imageWithTintedColor: [UIColor whiteColor] colorAlpha: 0.33f];
}

//  ------------------------------------------------------------------------------------------------
- ( UIImage * ) sectionHeaderArrowDownImageDisabled
{
    return [self defaultImage: @"ic_arrow_drop_down_grey600_36dp"];
}

//  ------------------------------------------------------------------------------------------------
- ( UIImage * ) sectionHeaderArrowUpImage
{
    UIImage                       * image;
    
    image                           = [self defaultImage: @"ic_arrow_drop_up_grey600_36dp"];
    if ( nil == image )
    {
        return nil;
    }
    return [image imageWithTintedColor: [UIColor blackColor] colorAlpha: 0.0f];
}

//  ------------------------------------------------------------------------------------------------
- ( UIImage * ) sectionHeaderArrowUpImageHighlighted
{
    UIImage                       * image;
    
    image                           = [self defaultImage: @"ic_arrow_drop_up_grey600_36dp"];
    if ( nil == image )
    {
        return nil;
    }
    return [image imageWithTintedColor: [UIColor whiteColor] colorAlpha: 0.33f];
}

//  ------------------------------------------------------------------------------------------------
- ( UIImage * ) sectionHeaderArrowUpImageDisabled
{
    return [self defaultImage: @"ic_arrow_drop_up_grey600_36dp"];
}

//  ------------------------------------------------------------------------------------------------
//  ------------------------------------------------------------------------------------------------

@end

//  ------------------------------------------------------------------------------------------------
//  ------------------------------------------------------------------------------------------------








