//
//  HelloWorldLayer.m
//  CCSliderMenu
//
//  Created by Tomohisa Takaoka on 10/11/11.
//  Copyright __MyCompanyName__ 2011. All rights reserved.
//


// Import the interfaces
#import "HelloWorldLayer.h"
#import "CCSliderMenu.h"

enum
{
	kTagSliderRace,
	kTagSliderRace2,
	kTagSliderRace3,
	kTagSliderRace4,
	kTagSliderRace5,
};

@interface HelloWorldLayer()
-(void) menuFired:(id)sender;
-(void) menuStartTouched:(id)sender;
@end


// HelloWorldLayer implementation
@implementation HelloWorldLayer

+(CCScene *) scene
{
	// 'scene' is an autorelease object.
	CCScene *scene = [CCScene node];
	
	// 'layer' is an autorelease object.
	HelloWorldLayer *layer = [HelloWorldLayer node];
	
	// add layer as a child to scene
	[scene addChild: layer];
	
	// return the scene
	return scene;
}

// on "init" you need to initialize your instance
-(id) init
{
	// always call "super" init
	// Apple recommends to re-assign "self" with the "super" return value
	if( (self=[super init])) {
        CGSize wins = [[CCDirector sharedDirector] winSize];
	
        CCSliderMenu* sliderMenu = [CCSliderMenu sliderMenuWithBackgroundFile:@"menuFrame_racing.png" thumbFile:@"n_cf_001_mini.png" blockWhenButtonFire:
                                    ^(id sender){[self menuFired:sender];}];
        sliderMenu.tag = kTagSliderRace;
        sliderMenu.position = ccp(wins.width*1/2.0,wins.height*0.5/2);
        sliderMenu.regularAction = [CCRepeatForever actionWithAction:[CCSequence actions:[CCScaleTo actionWithDuration:.5 scale:.9],[CCScaleTo actionWithDuration:.5 scale:1.0], nil ]];
        sliderMenu.selectedAction = [CCRepeatForever actionWithAction:[CCSequence actions:[CCFadeTo actionWithDuration:.5 opacity:0x80],[CCFadeTo actionWithDuration:.5 opacity:0xff], nil ]];
        sliderMenu.blockTouched = ^(id sender){[self menuStartTouched:sender];};
        [self addChild:sliderMenu];
        
        sliderMenu = [CCSliderMenu sliderMenuWithBackgroundFile:@"menuFrame_racing.png" thumbFile:@"n_cf_001_mini.png" blockWhenButtonFire:
                      ^(id sender){[self menuFired:sender];}]; 
        sliderMenu.tag = kTagSliderRace2;
        sliderMenu.position = ccp(wins.width*1/2.0,wins.height*1.5/2);
        [self addChild:sliderMenu];
        
	}
	return self;
}

// on "dealloc" you need to release all your retained objects
- (void) dealloc
{
	// in case you have something to dealloc, do it in this method
	// in this particular example nothing needs to be released.
	// cocos2d will automatically release all the children (Label)
	
	// don't forget to call "super dealloc"
	[super dealloc];
}
-(void) menuFired:(id)sender{
    CCSliderMenu* sliderMenu = (CCSliderMenu*)sender;
    if (sliderMenu.tag==kTagSliderRace) {
        CCLOG(@"RACE");
        [sliderMenu resetStatus];
        sliderMenu.blockFire = ^(id sender){[self menuFired:sender];};
    }
    if (sliderMenu.tag==kTagSliderRace2) {
        CCLOG(@"RACE 2");
        [sliderMenu resetStatus];
        sliderMenu.blockFire = ^(id sender){[self menuFired:sender];};
    }
    if (sliderMenu.tag==kTagSliderRace3) {
        CCLOG(@"RACE 3");
        [sliderMenu resetStatus];
        sliderMenu.blockFire = ^(id sender){[self menuFired:sender];};
    }
    if (sliderMenu.tag==kTagSliderRace4) {
        CCLOG(@"RACE 4");
        [sliderMenu resetStatus];
        sliderMenu.blockFire = ^(id sender){[self menuFired:sender];};
    }
    if (sliderMenu.tag==kTagSliderRace5) {
        CCLOG(@"RACE 5");
        [sliderMenu resetStatus];
        sliderMenu.blockFire = ^(id sender){[self menuFired:sender];};
    }
}
-(void) menuStartTouched:(id)sender{
    CCSliderMenu* sliderMenu = (CCSliderMenu*)sender;
    if (sliderMenu.tag==kTagSliderRace) {
        CCLOG(@"RACE SOUND");
    }
    if (sliderMenu.tag==kTagSliderRace2) {
        CCLOG(@"RACE SOUND 2");
    }
    if (sliderMenu.tag==kTagSliderRace3) {
        CCLOG(@"RACE SOUND 3");
    }
    if (sliderMenu.tag==kTagSliderRace4) {
        CCLOG(@"RACE SOUND 4");
    }
    if (sliderMenu.tag==kTagSliderRace5) {
        CCLOG(@"RACE SOUND 5");
    }
}

@end
