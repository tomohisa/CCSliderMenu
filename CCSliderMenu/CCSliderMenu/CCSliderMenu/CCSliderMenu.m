//
//  CCSliderMenu.m
//  Zero4Kids
//
//  Created by Tomohisa Takaoka on 10/10/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "CCSliderMenu.h"
#import "CCSlider.h"

enum
{
	kTagSliderRace,
};

@interface CCSliderMenu ()
@property (nonatomic, assign) BOOL isTouching;
@end

@implementation CCSliderMenu
@synthesize blockFire;
@synthesize blockTouched;
@synthesize firingValue;
@synthesize regularAction;
@synthesize selectedAction;
@synthesize isTouching;

+ (id) sliderMenuWithBackgroundFile: (NSString *) bgFile thumbFile: (NSString *) thumbFile {
    CCSliderMenu* new = [[[CCSliderMenu alloc] initWithBackgroundFile:bgFile thumbFile:thumbFile] autorelease];
    new.blockFire = nil;
    new.blockTouched = nil;
    new.value = 1;
    new.firingValue = .2;
    new.regularAction = nil;
    new.selectedAction = nil;
    new.isTouching = NO;
    [new addObserver:new forKeyPath:@"regularAction" options:NSKeyValueObservingOptionNew context:nil];
    return new;
}

+ (id) sliderMenuWithBackgroundFile: (NSString *) bgFile thumbFile: (NSString *) thumbFile blockWhenButtonFire:(BlockTypeFire)block {
    CCSliderMenu* new = [[[CCSliderMenu alloc] initWithBackgroundFile:bgFile thumbFile:thumbFile] autorelease];
    new.blockFire = block;
    new.blockTouched = nil;
    new.value = 1;
    new.firingValue = .2;
    new.regularAction = nil;
    new.selectedAction = nil;
    [new addObserver:new forKeyPath:@"regularAction" options:NSKeyValueObservingOptionNew context:nil];
    new.isTouching = NO;
    return new;
}

-(void) observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context{
    if ([keyPath isEqualToString:@"regularAction"]) {
        [_thumb stopAllActions];
        [_thumb runAction:self.regularAction];
    }
}

-(void) dealloc {
    [self removeObserver:self forKeyPath:@"regularAction"];
    self.blockFire = nil;
    self.regularAction = nil;
    self.selectedAction = nil;
}

-(BOOL) ccTouchBegan:(UITouch *)touch withEvent:(UIEvent *)event
{
    if (isTouching) {
        return NO;
    }
    BOOL retunValue = [super ccTouchBegan:touch withEvent:event];
    if (retunValue && self.selectedAction) {
        [_thumb stopAllActions];
        _thumb.scale = 1.0;
        CCSprite *thumb = (CCSprite *)[[self children] objectAtIndex:1];
        thumb.opacity = 0xff;
        [_thumb runAction:selectedAction];
    }
    if (retunValue && self.blockTouched) {
        blockTouched(self);
    }
    if (_thumb.position.x > _bg.position.x + _bg.contentSize.width / 2 - _thumb.contentSize.width / 2) {
        _thumb.position = ccp(_bg.position.x + _bg.contentSize.width / 2 - _thumb.contentSize.width / 2,_thumb.position.y);
    }
    if (_thumb.position.x < _bg.position.x - _bg.contentSize.width / 2 + _thumb.contentSize.width / 2) {
        _thumb.position = ccp(_bg.position.x - _bg.contentSize.width / 2 + _thumb.contentSize.width / 2,_thumb.position.y);
    }
    isTouching = retunValue;
    return retunValue;
}

-(void) ccTouchMoved:(UITouch *)touch withEvent:(UIEvent *)event
{
    if (!isTouching) {
        return;
    }

    
    [super ccTouchMoved:touch withEvent:event];
    
    CCSprite *thumb = (CCSprite *)[[self children] objectAtIndex:1];
    self.value = (thumb.position.x - minX) / (maxX - minX);

    if (_thumb.position.x > _bg.position.x + _bg.contentSize.width / 2 - _thumb.contentSize.width / 2) {
        _thumb.position = ccp(_bg.position.x + _bg.contentSize.width / 2 - _thumb.contentSize.width / 2,_thumb.position.y);
    }
    if (_thumb.position.x < _bg.position.x - _bg.contentSize.width / 2 + _thumb.contentSize.width / 2) {
        _thumb.position = ccp(_bg.position.x - _bg.contentSize.width / 2 + _thumb.contentSize.width / 2,_thumb.position.y);
    }

    if (self.value<firingValue){
        if (blockFire) {
            blockFire(self);
        }
    }
}

-(void) ccTouchEnded:(UITouch *)touch withEvent:(UIEvent *)event
{
    if (!isTouching) {
        return;
    }

    CCSprite *thumb = (CCSprite *)[[self children] objectAtIndex:1];
    [_thumb unselected];
    self.value = (thumb.position.x - minX) / (maxX - minX);

    if (_thumb.position.x > _bg.position.x + _bg.contentSize.width / 2 - _thumb.contentSize.width / 2) {
        _thumb.position = ccp(_bg.position.x + _bg.contentSize.width / 2 - _thumb.contentSize.width / 2,_thumb.position.y);
    }
    if (_thumb.position.x < _bg.position.x - _bg.contentSize.width / 2 + _thumb.contentSize.width / 2) {
        _thumb.position = ccp(_bg.position.x - _bg.contentSize.width / 2 + _thumb.contentSize.width / 2,_thumb.position.y);
    }
    if (self.selectedAction) {
        [_thumb stopAllActions];
        _thumb.scale = 1.0;
        CCSprite *thumb = (CCSprite *)[[self children] objectAtIndex:1];
        thumb.opacity = 0xff;
    }
    if (self.regularAction) {
        [_thumb runAction:self.regularAction];
    }
    isTouching = NO;
}
-(void) ccTouchCancelled:(UITouch *)touch withEvent:(UIEvent *)event{
    if (!isTouching) {
        return;
    }

    [super ccTouchCancelled:touch withEvent:event];
    if (self.selectedAction) {
        [_thumb stopAllActions];
        _thumb.scale = 1.0;
        CCSprite *thumb = (CCSprite *)[[self children] objectAtIndex:1];
        thumb.opacity = 0xff;
    }
    if (self.regularAction) {
        [_thumb runAction:self.regularAction];
    }
    isTouching = NO;
}


-(BOOL) isTouchForMe:(CGPoint)touchLocation
{
	// Only use thumb for this purpose.
	if (CGRectContainsPoint([_thumb boundingBox], touchLocation))
		return YES;
	
	return NO;
}
-(void) resetStatus{
    self.value = 1.0;
    self.isTouching = NO;
    if (_thumb.isSelected)
        [_thumb unselected];

    _thumb.position = ccp(_bg.position.x + _bg.contentSize.width / 2 - _thumb.contentSize.width / 2,_thumb.position.y);
    [_thumb stopAllActions];
    _thumb.scale = 1.0;
    CCSprite *thumb = (CCSprite *)[[self children] objectAtIndex:1];
    thumb.opacity = 0xff;
    
    if (self.regularAction) {
        [_thumb stopAllActions];
        _thumb.scale = 1.0;
        CCSprite *thumb = (CCSprite *)[[self children] objectAtIndex:1];
        thumb.opacity = 0xff;
        [_thumb runAction:regularAction];
    }

}


@end
