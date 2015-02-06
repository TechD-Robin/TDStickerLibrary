//
//  TDTrigonometry.m
//  TDMath
//
//  Created by Robin Hsu on 2014/12/4.
//  Copyright (c) 2014年 TechD. All rights reserved.
//
//  ------------------------------------------------------------------------------------------------
//  ------------------------------------------------------------------------------------------------


#import "TDTrigonometry.h"

//  ------------------------------------------------------------------------------------------------
//  ------------------------------------------------------------------------------------------------


//  ------------------------------------------------------------------------------------------------
//  ------------------------------------------------------------------------------------------------
//  r^2 = ( a^2 + b^2 )
CGFloat calculateTriangleHypotenuse( CGFloat sideAdjacent, CGFloat sideOpposite )
{
    return sqrtf( ( powf( sideAdjacent,  2.0f ) ) + ( powf( sideOpposite,  2.0f ) ) );
}

//  ------------------------------------------------------------------------------------------------
//  cosθ = (x/r) ; cosθ = √( 1 / ( (tanθ)^2 + 1 ) )
//  x = cosθ * r
CGFloat calculateTriangleAdjacentWithHypotenuse( CGFloat sideHypotenuse, CGFloat tanTheta )
{
    CGFloat                         cosTheta;
    CGFloat                         sideAdjacent;
    
    cosTheta                        = sqrtf( ( 1 / ( powf( tanTheta, 2.0f ) + 1 ) ) );
    sideAdjacent                    = cosTheta * sideHypotenuse;
    return sideAdjacent;
}

//  ------------------------------------------------------------------------------------------------
//  sinθ = (y/r) ; sinθ = √( (tanθ)^2 / ( (tanθ)^2 + 1 ) )
//  y = sinθ * r
CGFloat calculateTriangleOppositeWithHypotenuse( CGFloat sideHypotenuse, CGFloat tanTheta )
{
    CGFloat                         sinTheta;
    CGFloat                         sideOpposite;
    
    sinTheta                        = sqrtf( ( powf( tanTheta, 2.0f ) / ( powf( tanTheta, 2.0f ) + 1 ) ) );
    sideOpposite                    = sinTheta * sideHypotenuse;
    return sideOpposite;
}

//  ------------------------------------------------------------------------------------------------
//  ------------------------------------------------------------------------------------------------

