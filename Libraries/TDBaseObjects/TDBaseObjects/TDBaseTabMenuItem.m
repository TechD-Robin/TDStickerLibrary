//
//  TDBaseTabMenuItem.m
//  TDBaseObjects
//
//  Created by Robin Hsu on 2015/1/22.
//  Copyright (c) 2015年 TechD. All rights reserved.
//
//  ------------------------------------------------------------------------------------------------
//  ------------------------------------------------------------------------------------------------

#ifndef __ARCMacros_H__
    #import "ARCMacros.h"
#endif  //  End of __ARCMacros_H__.

#import "TDBaseTabMenuItem.h"

//  ------------------------------------------------------------------------------------------------
//  ------------------------------------------------------------------------------------------------


//  ------------------------------------------------------------------------------------------------
//  ------------------------------------------------------------------------------------------------
#pragma mark -
#pragma mark class TDBaseTabMenuItem

//  ------------------------------------------------------------------------------------------------
//  ------------------------------------------------------------------------------------------------
//  declare property for private category()
//  ------------------------------------------------------------------------------------------------
#pragma mark declare property ()
@interface TDBaseTabMenuItem()
{
    /**
     *  assign the block method pointer when relation view need to be created.
     */
    CreateRelationBlock             createRelationBlock;
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
@interface TDBaseTabMenuItem(Private)

//  ------------------------------------------------------------------------------------------------
//  ------------------------------------------------------------------------------------------------
/**
 *  @brief initial the attributes of class.
 *  initial the attributes of class.
 */
- ( void ) _InitAttributes;

//  ------------------------------------------------------------------------------------------------
/**
 *  @brief initial the tap Gesture Recongnizer of class.
 *  initial the tap Gesture Recongnizer of class.
 */
- ( void ) _InitGestureRecognizer;

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
@implementation TDBaseTabMenuItem(Private)

//  ------------------------------------------------------------------------------------------------
//  ------------------------------------------------------------------------------------------------
- ( void ) _InitAttributes
{
    [self                           setBackgroundColor: [UIColor clearColor]];
    [self                           setContentMode: UIViewContentModeScaleToFill];
    [self                           setUserInteractionEnabled: YES];
    
    createRelationBlock             = nil;
}

//  ------------------------------------------------------------------------------------------------
- ( void ) _InitGestureRecognizer
{
    UITapGestureRecognizer        * tap;
    
    tap                             = [[UITapGestureRecognizer alloc] initWithTarget: self action: @selector( _TapAction: )];
    if ( nil == tap )
    {
        return;
    }
    
    [self                           addGestureRecognizer: tap];
    SAFE_ARC_RELEASE( tap );
    SAFE_ARC_ASSIGN_POINTER_NIL( tap );
}

//  ------------------------------------------------------------------------------------------------
- ( void ) _TapAction:(id)sender
{
    [self                           setHighlighted: YES];
    if ( [self relationView] != nil )
    {
        [[self                      relationView] setHidden: NO];
    }
    else
    {
        if ( nil != createRelationBlock )
        {
            createRelationBlock( [self tag] );
        }
    }
    
    for ( TDBaseTabMenuItem * subview in [[self superview] subviews] )
    {
        if ( ( nil == subview ) || ( [subview isKindOfClass: [self class]] == NO ) || ( subview == self ) )
        {
            continue;
        }
        
        if ( [subview isHighlighted] == NO )
        {
            continue;
        }
        
        [subview                    setHighlighted: NO];
        if ( [subview relationView] != nil )
        {
            [[subview               relationView] setHidden: YES];
        }
    }
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
@implementation TDBaseTabMenuItem

//  ------------------------------------------------------------------------------------------------
#pragma mark synthesize variable.
@synthesize relationView            = _relationView;

//  ------------------------------------------------------------------------------------------------
#pragma mark overwrite implementation of UIView
//  ------------------------------------------------------------------------------------------------
- ( instancetype ) initWithFrame:(CGRect)frame
{
    return [[[self class] alloc] initWithFrame: frame image: nil highlightedImage: nil create: nil];
}


//  ------------------------------------------------------------------------------------------------
#pragma mark method for create the object.
//  ------------------------------------------------------------------------------------------------
- ( instancetype ) initWithFrame:(CGRect)frame image:(UIImage *)image highlightedImage:(UIImage *)highlightedImage
                          create:(CreateRelationBlock)relation
{
    self                            = [super initWithFrame: frame];
    if ( nil == self )
    {
        return nil;
    }
    
    [self                           _InitAttributes];
    [self                           _InitGestureRecognizer];
    [self                           setImage: image];
    [self                           setHighlightedImage: highlightedImage];
    if ( nil != relation )
    {
        createRelationBlock         = relation;
    }
    
    return self;
}

//  ------------------------------------------------------------------------------------------------
+ ( instancetype ) tabMenuItemWithFrame:(CGRect)frame image:(UIImage *)image
{
//    return [[self alloc] initWithFrame: frame image: image highlightedImage: nil];
    return [[[self class] alloc] initWithFrame: frame image: image highlightedImage: nil create: nil];
}

//  ------------------------------------------------------------------------------------------------
+ ( instancetype ) tabMenuItemWithFrame:(CGRect)frame image:(UIImage *)image highlightedImage:(UIImage *)highlightedImage
{
//    return [[self alloc] initWithFrame: frame image: image highlightedImage: highlightedImage];
    return [[[self class] alloc] initWithFrame: frame image: image highlightedImage: highlightedImage create: nil];
}

//  ------------------------------------------------------------------------------------------------
+ ( instancetype ) tabMenuItemWithFrame:(CGRect)frame image:(UIImage *)image
                                 create:(CreateRelationBlock)relation
{
    return [[[self class] alloc] initWithFrame: frame image: image highlightedImage: nil create: relation];
}

//  ------------------------------------------------------------------------------------------------
+ ( instancetype ) tabMenuItemWithFrame:(CGRect)frame image:(UIImage *)image highlightedImage:(UIImage *)highlightedImage
                                 create:(CreateRelationBlock)relation
{
    return [[[self class] alloc] initWithFrame: frame image: image highlightedImage: highlightedImage create: relation];
}

//  ------------------------------------------------------------------------------------------------
//  ------------------------------------------------------------------------------------------------

@end


//  ------------------------------------------------------------------------------------------------
//  ------------------------------------------------------------------------------------------------







