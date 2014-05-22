//
//  howtoScene.m
//  PudingRevenge
//
//  Created by apple02 on 13. 5. 15..
//
//

#import "howtoScene2.h"

@implementation howtoScene2

- (id) init {
	if( (self=[super init]) ) {
        CGSize winSize = [[CCDirector sharedDirector] winSize];
        CCSprite *bgSprite = [CCSprite spriteWithFile:@"howto2_back.png"];
		[bgSprite setAnchorPoint:CGPointZero];
		[bgSprite setPosition:CGPointZero];
		[self addChild:bgSprite z:0 tag:0];
        
        CCMenuItem *closeMenuItem = [CCMenuItemImage itemWithNormalImage:@"back.png"
                                                           selectedImage:@"back_sel.png"
                                                                  target:self
                                                                selector:@selector(closeMenuCallback:)];
		CCMenu *menu = [CCMenu menuWithItems:closeMenuItem, nil];
		menu.position = ccp(winSize.width/2, 30);
		[self addChild:menu z:3 tag:1];
        
        gsound = [SimpleAudioEngine sharedEngine];
        gsound.effectsVolume = 0.9;
        [gsound preloadEffect:@"click.mp3"];
        
    }
    return self;
}

- (void) closeMenuCallback: (id) sender
{
    [sceneManager goMenu];
    [gsound playEffect:@"click.mp3"];
}



-(void) dealloc
{
	[super dealloc];
}
@end
