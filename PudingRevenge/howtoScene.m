//
//  howtoScene.m
//  PudingRevenge
//
//  Created by apple02 on 13. 5. 15..
//
//

#import "howtoScene.h"

@implementation howtoScene

- (id) init {
	if( (self=[super init]) ) {
        
        CGSize winSize = [[CCDirector sharedDirector] winSize];
        CCSprite *bgSprite = [CCSprite spriteWithFile:@"howto_back.png"];
		[bgSprite setAnchorPoint:CGPointZero];
		[bgSprite setPosition:CGPointZero];
		[self addChild:bgSprite z:0 tag:0];
        
        CCMenuItem *nextMenuItem = [CCMenuItemImage itemWithNormalImage:@"menu_next.png"
                                                           selectedImage:@"menu_next_sel.png"
                                                                  target:self
                                                                selector:@selector(nextMenuCallback:)];
		CCMenu *menu = [CCMenu menuWithItems:nextMenuItem, nil];
		menu.position = ccp(winSize.width/2, 30);
		[self addChild:menu z:3 tag:1];
        
        gsound = [SimpleAudioEngine sharedEngine];
        gsound.effectsVolume = 0.9;
        [gsound preloadEffect:@"click.mp3"];
        
    }
    return self;
}

// Howto2 씬으로 이동
- (void) nextMenuCallback: (id) sender
{
    [sceneManager goHowto2];
    [gsound playEffect:@"click.mp3"];
}

-(void) dealloc
{
	[super dealloc];
}
@end
