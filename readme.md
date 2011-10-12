CCSliderMenu
==================

"In Cocos2d Extention, there is great class (CCSlider). I would like to use this as a Menu. I really appriciate the work for Cocos2d and Cocos2D Extentions."
- Tomohisa Takaoka.
http://www.zero4racer.com/blog

This class using Blocks, so you need to use iOS 4 or newer.

This code is released under MIT license.

How to create (Easy)
------------------------

        CCSliderMenu* sliderMenu = [CCSliderMenu sliderMenuWithBackgroundFile:@"menuFrame_racing.png" thumbFile:@"n_cf_001_mini.png" blockWhenButtonFire:
                      ^(id sender){[self menuFired:sender];}]; 
        sliderMenu.tag = kTagSliderRace2;
        sliderMenu.position = ccp(wins.width*1/2.0,wins.height*1.5/2);
        [self addChild:sliderMenu];


How to create (Advanced)
------------------------

        CCSliderMenu* sliderMenu = [CCSliderMenu sliderMenuWithBackgroundFile:@"menuFrame_racing.png" thumbFile:@"n_cf_001_mini.png" blockWhenButtonFire:
                                    ^(id sender){[self menuFired:sender];}];
        sliderMenu.tag = kTagSliderRace;
        sliderMenu.position = ccp(wins.width*1/2.0,wins.height*0.5/2);
        sliderMenu.regularAction = [CCRepeatForever actionWithAction:[CCSequence actions:[CCScaleTo actionWithDuration:.5 scale:.9],[CCScaleTo actionWithDuration:.5 scale:1.0], nil ]];
        sliderMenu.selectedAction = [CCRepeatForever actionWithAction:[CCSequence actions:[CCFadeTo actionWithDuration:.5 opacity:0x80],[CCFadeTo actionWithDuration:.5 opacity:0xff], nil ]];
        sliderMenu.blockTouched = ^(id sender){[self menuStartTouched:sender];};
        [self addChild:sliderMenu];
        
		
		
