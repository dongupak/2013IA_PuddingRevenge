//
//  gameoverScene.m
//  PudingRevenge
//
//  Created by apple02 on 13. 5. 15..
//
//

#import "gameoverScene.h"

@implementation gameoverScene

- (id) init {
	if( (self=[super init]) ) {
        
        CCSprite *bgSprite = [CCSprite spriteWithFile:@"gameover_background.png"];
        bgSprite.position = ccp(240, 160);
		[self addChild:bgSprite z:0 tag:0];
        
        
        CCSprite *rulu = [CCSprite spriteWithFile:@"gameover_rulu.png"];
        rulu.position = ccp(120, 160);
		[self addChild:rulu z:1 tag:0];
        
        id ruluUp = [CCMoveBy actionWithDuration:0.2 position:ccp(0, 5)];
        id ruluDown = [CCMoveBy actionWithDuration:0.1 position:ccp(0, -5)];
        id ruluUpAndDown = [CCSequence actions:ruluUp,ruluDown, nil];
        id ruluRotate = [CCRotateBy actionWithDuration:0.3 angle:-30];
        id ruluRotateReverse = [ruluRotate reverse];
        id ruluRotAndRev = [CCSequence actions:ruluRotate,ruluRotateReverse, nil];
        id ruluAllaction = [CCSpawn actions:ruluUpAndDown, ruluRotAndRev, nil];
        id ruluAction = [CCRepeatForever actionWithAction:ruluAllaction];
        
        [rulu runAction:ruluAction];
        
        
        CCSprite *pudding = [CCSprite spriteWithFile:@"gameover_pudding_01.png"];
        pudding.position = ccp(240, 150);
        [self addChild:pudding z:1 tag:0];
        
        id puddingScale = [CCScaleBy actionWithDuration:0.5 scaleX:1 scaleY:0.9];
        id puddingScaleReverse = [puddingScale reverse];
        id puddingScales = [CCSequence actions:puddingScale,puddingScaleReverse, nil];
        id puddingAction = [CCRepeatForever actionWithAction:puddingScales];
        [pudding runAction:puddingAction];
        
        CCAnimation *animation = [[CCAnimation alloc] init];
        [animation setDelayPerUnit:0.5];
        [animation addSpriteFrameWithFilename:@"gameover_pudding_01.png"];
        [animation addSpriteFrameWithFilename:@"gameover_pudding_02.png"];
        CCAnimate *animate = [CCAnimate actionWithAnimation:animation];
        animate = [CCRepeatForever actionWithAction:animate];
        [pudding runAction:animate];
        
        
        
        
        
        CCMenuItem *closeMenuItem = [CCMenuItemImage itemWithNormalImage:@"victory_restart.png"
                                                           selectedImage:@"victory_restart_sel.png"
                                                                  target:self
                                                                selector:@selector(closeMenuCallback:)];
		CCMenu *menu = [CCMenu menuWithItems:closeMenuItem, nil];
		menu.position = ccp(240, 50);
		[self addChild:menu z:3 tag:1];
        
        gsound = [SimpleAudioEngine sharedEngine];
        gsound.effectsVolume = 0.9;
        [gsound preloadEffect:@"click.mp3"];
        [gsound preloadBackgroundMusic:@"gameover.mp3"];
        
        [gsound playBackgroundMusic:@"gameover.mp3" loop:YES];
        
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
