//
//  CCSliderMenu.h
//  Zero4Kids
//
//  Created by Tomohisa Takaoka on 10/10/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "CCNode.h"
#import "CCSlider.h"

typedef void (^BlockTypeFire)(id sender);

@interface CCSliderMenu : CCSlider

@property (nonatomic, copy) BlockTypeFire blockFire;
@property (nonatomic, copy) BlockTypeFire blockTouched;
@property (nonatomic, assign) float firingValue;
@property (nonatomic, retain) id regularAction;
@property (nonatomic, retain) id selectedAction;


+ (id) sliderMenuWithBackgroundFile: (NSString *) bgFile thumbFile: (NSString *) thumbFile;
+ (id) sliderMenuWithBackgroundFile: (NSString *) bgFile thumbFile: (NSString *) thumbFile blockWhenButtonFire:(BlockTypeFire)block;

-(void) resetStatus;

@end
