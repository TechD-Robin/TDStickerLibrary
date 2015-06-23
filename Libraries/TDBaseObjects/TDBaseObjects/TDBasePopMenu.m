//
//  TDBasePopMenu.m
//  TDBaseObjects
//
//  Created by Robin Hsu on 2015/6/23.
//  Copyright (c) 2015年 TechD. All rights reserved.
//
//  ------------------------------------------------------------------------------------------------
//  ------------------------------------------------------------------------------------------------

#import "UIKit+TechD.h"
#import "TDBasePopMenu.h"


//  ------------------------------------------------------------------------------------------------
//  ------------------------------------------------------------------------------------------------
#pragma mark -
#pragma mark class TDBasePopMenu

//  ------------------------------------------------------------------------------------------------
//  ------------------------------------------------------------------------------------------------
#pragma mark declare private category ()
//  ------------------------------------------------------------------------------------------------
@interface TDBasePopMenu ()
{
    TDBasePopMenuPosition           popMenuPosition;
    CGPoint                         positionOffset;
    
    
    UIButton                      * popOutButton;
    UIButton                      * unPopOutButton;
    
    
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
@interface TDBasePopMenu (Private)

//  ------------------------------------------------------------------------------------------------
#pragma mark declare for initial this class.
//  ------------------------------------------------------------------------------------------------
/**
 *  @brief initial the attributes of class.
 *  initial the attributes of class.
 */
- ( void ) _InitAttributes;

- ( void ) _SetFrame;

//  ------------------------------------------------------------------------------------------------
#pragma mark declare for create object.
//  ------------------------------------------------------------------------------------------------
- ( BOOL ) _CreatePopOutView:(UIImage *)image highlighted:(UIImage *)highlighted;

//  ------------------------------------------------------------------------------------------------
- ( BOOL ) _CreateUnPopOutView:(UIImage *)image highlighted:(UIImage *)highlighted;


@end


//  ------------------------------------------------------------------------------------------------
//  ------------------------------------------------------------------------------------------------


//  ------------------------------------------------------------------------------------------------
//  ------------------------------------------------------------------------------------------------
#pragma mark -
#pragma mark implementation private category (Private)
//  ------------------------------------------------------------------------------------------------
@implementation TDBasePopMenu (Private)

//  ------------------------------------------------------------------------------------------------
#pragma mark method for initial this class.
//  ------------------------------------------------------------------------------------------------
//  --------------------------------
- ( void ) _InitAttributes
{
    positionOffset                  = CGPointZero;
    
    popOutButton                    = nil;
    unPopOutButton                  = nil;

}

//  ------------------------------------------------------------------------------------------------
- ( void ) _SetFrame
{
    CGFloat                         screenWidth;
    CGRect                          frame;
    
    frame                           = CGRectMake( 0.0f, 0.0f, 0.0f, 0.0f );
    screenWidth                     = [[UIScreen mainScreen] bounds].size.width;
    
    frame.origin.x                  = screenWidth;
    if ( nil != popOutButton )
    {
        frame.size                  = [popOutButton bounds].size;
    }
    
    switch ( popMenuPosition )
    {
        case TDBasePopMenuPositionLeftTop:
        {
            break;
        }
        case TDBasePopMenuPositionRightTop:
        {
            if ( nil != popOutButton )
            {
                frame.origin.x      -= frame.size.width;
            }
            break;
        }
        default:
            break;
    }
    
    

    frame.origin.x                  += positionOffset.x;
    frame.origin.y                  += positionOffset.y;
    [self                           setFrame: frame];
}


//  ------------------------------------------------------------------------------------------------
//  ------------------------------------------------------------------------------------------------
#pragma mark method for create object.
//  ------------------------------------------------------------------------------------------------
- ( BOOL ) _CreatePopOutView:(UIImage *)image highlighted:(UIImage *)highlighted
{
    NSParameterAssert( nil != image );
    NSParameterAssert( nil != highlighted );
    
    CGRect                          buttonRect;
    
    buttonRect                      = CGRectMake( 0.0f, 0.0f, [image size].width, [image size].height );
    popOutButton                    = [UIButton buttonWithImage: image highlighted: highlighted origin: CGPointZero];
    if ( nil == popOutButton )
    {
        return NO;
    }
    
    [popOutButton                   setFrame: buttonRect];
    [popOutButton                   addTarget: self action: @selector( _PopOutAction: ) forControlEvents: UIControlEventTouchUpInside];
    
    [self                           addSubview: popOutButton];
    return YES;
}

//  ------------------------------------------------------------------------------------------------
- ( void ) _PopOutAction:(id) sender
{
    NSLog( @"pop" );
    
    if ( nil != unPopOutButton )
    {
        [popOutButton               setHidden: YES];
        [unPopOutButton             setHidden: NO];
    }
}

//  ------------------------------------------------------------------------------------------------
- ( BOOL ) _CreateUnPopOutView:(UIImage *)image highlighted:(UIImage *)highlighted
{
    NSParameterAssert( nil != image );
    NSParameterAssert( nil != highlighted );
    
    CGRect                          buttonRect;
    
    if ( nil != popOutButton )
    {
        buttonRect                  = [popOutButton frame];
    }
    else
    {
        buttonRect                  = CGRectMake( 0.0f, 0.0f, [image size].width, [image size].height );
    }
    
    unPopOutButton                  = [UIButton buttonWithImage: image highlighted: highlighted origin: CGPointZero];
    if ( nil == unPopOutButton )
    {
        return NO;
    }
    
    [unPopOutButton                 setFrame: buttonRect];
    [unPopOutButton                 addTarget: self action: @selector( _UnPopOutAction: ) forControlEvents: UIControlEventTouchUpInside];
    [unPopOutButton                 setHidden: YES];
    
    [self                           addSubview: unPopOutButton];
    return YES;
}

//  ------------------------------------------------------------------------------------------------
- ( void ) _UnPopOutAction:(id) sender
{
    NSLog( @"unpop" );
    
    if ( nil != popOutButton )
    {
        [popOutButton               setHidden: NO];
        [unPopOutButton             setHidden: YES];
    }
}

//  ------------------------------------------------------------------------------------------------

@end

//  ------------------------------------------------------------------------------------------------
//  ------------------------------------------------------------------------------------------------


//  ------------------------------------------------------------------------------------------------
//  ------------------------------------------------------------------------------------------------
#pragma mark -
#pragma mark implementation for public
//  ------------------------------------------------------------------------------------------------
@implementation TDBasePopMenu

//  ------------------------------------------------------------------------------------------------
//  ------------------------------------------------------------------------------------------------
#pragma mark overwrite implementation of NSObject.

////  ------------------------------------------------------------------------------------------------
//- ( void ) dealloc
//{
//}

//  ------------------------------------------------------------------------------------------------
#pragma mark declare for create the object.
//  ------------------------------------------------------------------------------------------------
- (instancetype ) initWithPosition:(TDBasePopMenuPosition)menuPosition popOut:(UIImage *)image highlighted:(UIImage *)highlighted origin:(CGPoint)offset
{
    self                            = [super init];
    if ( nil == self )
    {
        return nil;
    }
    [self                           _InitAttributes];
    
    //  assign variables.
    popMenuPosition                 = menuPosition;
    positionOffset                  = offset;
    
    [self                           _CreatePopOutView: image highlighted: highlighted];
    [self                           _SetFrame];
    return self;
}

//  ------------------------------------------------------------------------------------------------
+ ( instancetype ) popMenu:(TDBasePopMenuPosition)menuPosition popOut:(UIImage *)image highlighted:(UIImage *)highlighted origin:(CGPoint)offset
{
    return [[[self class] alloc] initWithPosition: menuPosition popOut: image highlighted: highlighted origin: offset];
}

//  ------------------------------------------------------------------------------------------------
//  ------------------------------------------------------------------------------------------------
- ( BOOL ) setUnPopOut:(UIImage *)image highlighted:(UIImage *)highlighted
{
    return [self _CreateUnPopOutView: image highlighted: highlighted];
}
//  ------------------------------------------------------------------------------------------------



@end

//  ------------------------------------------------------------------------------------------------
//  ------------------------------------------------------------------------------------------------
































