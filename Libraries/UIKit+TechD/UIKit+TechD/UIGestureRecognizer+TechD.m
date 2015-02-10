//
//  UIGestureRecognizer+TechD.m
//  UIKit+TechD
//
//  Created by Robin Hsu on 2015/2/11.
//  Copyright (c) 2015年 TechD. All rights reserved.
//

#import "UIGestureRecognizer+TechD.h"

//  ------------------------------------------------------------------------------------------------
//  ------------------------------------------------------------------------------------------------

@implementation UIGestureRecognizer (TechD)

//  ------------------------------------------------------------------------------------------------
+ ( BOOL ) tapGestureRecognizer:(id)ownerObject withTarget:(id)target action:(SEL)action
{
    if ( ( nil == ownerObject ) || ( nil == target ) )
    {
        return NO;
    }
    
    UITapGestureRecognizer        * tap;
    
    tap                             = [[UITapGestureRecognizer alloc] initWithTarget: target action: action];
    if ( nil == tap )
    {
        return NO;
    }
    
    [ownerObject                    addGestureRecognizer: tap];
    return YES;
}


//  ------------------------------------------------------------------------------------------------
//  ------------------------------------------------------------------------------------------------

@end

//  ------------------------------------------------------------------------------------------------
//  ------------------------------------------------------------------------------------------------




