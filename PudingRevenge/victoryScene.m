//
//  victoryScene.m
//  PudingRevenge
//
//  Created by apple02 on 13. 5. 15..
//
//

#import "victoryScene.h"

@implementation victoryScene

- (id) init {
	if( (self=[super init]) ) {
        
        CCSprite *bgSprite = [CCSprite spriteWithFile:@"victory_background.png"];
		[bgSprite setAnchorPoint:CGPointZero];
		[bgSprite setPosition:CGPointZero];
		[self addChild:bgSprite z:0 tag:0];
        
        
        pudding = [CCSprite
                   spriteWithFile:@"basic_pudding_01.png"];
		pudding.position = ccp(240, 140);
        [self addChild:pudding z:0 tag:16];
        
        CCAnimation *basicanion = [[CCAnimation alloc]init];
        [basicanion setDelayPerUnit:0.3f];
        [basicanion addSpriteFrameWithFilename:@"basic_pudding_01.png"];
        [basicanion addSpriteFrameWithFilename:@"basic_pudding_02.png"];
        CCAnimate *basicanite = [CCAnimate actionWithAnimation:basicanion];
        id basicanirep = [CCRepeatForever actionWithAction:basicanite];
        id scaledown = [CCScaleBy actionWithDuration:0.3 scaleX:1 scaleY:0.95];
        id scalerev = [scaledown reverse];
        id scale = [CCSequence actions:scaledown,scalerev, nil];
        id scalerep = [CCRepeatForever actionWithAction:scale];
        [pudding runAction:scalerep];
        [pudding runAction:basicanirep];
        
        
        
        CCMenuItem *closeMenuItem = [CCMenuItemImage itemWithNormalImage:@"victory_restart.png"
                                                           selectedImage:@"victory_restart_sel.png"
                                                                  target:self
                                                                selector:@selector(closeMenuCallback:)];
		CCMenu *menu = [CCMenu menuWithItems:closeMenuItem, nil];
		menu.position = ccp(240, 30);
		[self addChild:menu z:3 tag:1];
        
        gsound = [SimpleAudioEngine sharedEngine];
        gsound.effectsVolume = 0.9;
        [gsound preloadEffect:@"click.mp3"];
        [gsound preloadBackgroundMusic:@"victory.mp3"];
        [gsound playBackgroundMusic:@"victory.mp3" loop:YES];
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
