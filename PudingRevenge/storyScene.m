//
//  storyScene.m
//  PudingRevenge
//
//  Created by apple02 on 13. 5. 15..
//
//

#import "storyScene.h"
#import "menuScene.h"


@implementation storyScene

-(id) init
{
	if( (self=[super initWithColor:ccc4(255, 255, 255, 255)]) ) {
        
        CGSize winSize = [[CCDirector sharedDirector] winSize];
        
        //배경 스프라이트
        CCSprite *bgSprite = [CCSprite
                              spriteWithFile:@"story_back.png"];
		bgSprite.anchorPoint = CGPointZero;
		[bgSprite setPosition: ccp(0, 0)];
        [self addChild:bgSprite z:0 tag:10];
        
        //Next Button
        CCMenuItem *nextMenuItem = [CCMenuItemImage itemWithNormalImage:@"menu_next.png"
                                                           selectedImage:@"menu_next_sel.png"
                                                                  target:self
                                                                selector:@selector(nextMenuCall:)];
		CCMenu *menu = [CCMenu menuWithItems:nextMenuItem, nil];
		menu.position = ccp(winSize.width - 60, 30);
		[self addChild:menu z:3 tag:1];

        //다양한 사운드
        gsound = [SimpleAudioEngine sharedEngine];
        gsound.effectsVolume = 0.9;
        [gsound preloadBackgroundMusic:@"main_bgm.mp3"];
        [gsound preloadEffect:@"click.mp3"];
        [gsound playBackgroundMusic:@"main_bgm.mp3" loop:YES];
    }
	return self;
}

- (void) nextMenuCall: (id) sender
{
    [sceneManager goSelect];
    [gsound playEffect:@"click.mp3"];
    [gsound stopBackgroundMusic];
}

-(void) dealloc
{
	[super dealloc];
}
@end
