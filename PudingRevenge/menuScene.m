//
//  HelloWorldLayer.m
//  PudingRevenge
//
//  Created by apple02 on 13. 5. 15..
//  Copyright __MyCompanyName__ 2013년. All rights reserved.
//


#import "menuScene.h"
#import "AppDelegate.h"

#pragma mark - menuSceneLayer


@implementation menuSceneLayer

+(CCScene *) scene
{
	CCScene *scene = [CCScene node];
	menuSceneLayer *layer = [menuSceneLayer node];
	[scene addChild: layer];
	return scene;
}


-(id) init
{
	if( (self=[super initWithColor:ccc4(255, 255, 255, 255)]) ) {
        
        CGSize winSize = [[CCDirector sharedDirector] winSize];
        
        //배경 스프라이트
        CCSprite *bgSprite = [CCSprite
                              spriteWithFile:@"menu_background.png"];
		bgSprite.anchorPoint = CGPointZero;
		[bgSprite setPosition: ccp(0, 0)];
        [self addChild:bgSprite z:0 tag:10];
        
        //메뉴 배경 스프라이트
        CCSprite *mnbgSprite = [CCSprite
                              spriteWithFile:@"menu_back.png"];
		mnbgSprite.position = ccp(winSize.width/2, winSize.height/2 - 20);
        [self addChild:mnbgSprite z:0 tag:11];
        
        //타이틀 스프라이트
        CCSprite *title = [CCSprite
                                spriteWithFile:@"menu_title.png"];
		title.position = ccp(winSize.width/2, winSize.height - 40);
        [self addChild:title z:0 tag:12];
        
        
        
        //electric source and flame source
        [[CCSpriteFrameCache sharedSpriteFrameCache] addSpriteFramesWithFile:@"flame_source.plist"];
        [[CCSpriteFrameCache sharedSpriteFrameCache] addSpriteFramesWithFile:@"electric_source.plist"];
        
        
        NSMutableArray *aniFrames1 = [NSMutableArray array];
        NSMutableArray *aniFrames2 = [NSMutableArray array];
        
        for (int i = 1; i < 6; i++) {
            
            CCSpriteFrame *frame1 = [[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:[NSString stringWithFormat:@"flame_source_%02d.png",i]];
            [aniFrames1 addObject:frame1];
            
            CCSpriteFrame *frame2 = [[CCSpriteFrameCache sharedSpriteFrameCache]
                                     spriteFrameByName:[NSString stringWithFormat:@"electric_source_%02d.png",i]];
            [aniFrames2 addObject:frame2];
	}
        flame = [CCSprite spriteWithSpriteFrame:[aniFrames1 objectAtIndex:1]];
        flame.position = ccp(winSize.width/6 - 10, 10);
        [self addChild:flame];
        
        electric = [CCSprite spriteWithSpriteFrame:[aniFrames2 objectAtIndex:1]];
        electric.position = ccp(winSize.width*3/4 + 50, 10);
        [self addChild:electric];

        
        CCAnimation *fAnin = [CCAnimation animationWithSpriteFrames:aniFrames1 delay:0.15f];
        CCAnimation *eAnin = [CCAnimation animationWithSpriteFrames:aniFrames2 delay:0.15f];
        
        CCAnimate *fAnite = [CCAnimate actionWithAnimation:fAnin];
        CCAnimate *eAnite = [CCAnimate actionWithAnimation:eAnin];
        
        fAnite = [CCRepeatForever actionWithAction:fAnite];
        eAnite = [CCRepeatForever actionWithAction:eAnite];
        [flame runAction:fAnite];
        [electric runAction:eAnite];
        
        //메뉴
        CCMenuItem *start = [CCMenuItemImage itemWithNormalImage:@"menu_start.png" selectedImage:@"menu_start_sel.png" target:self selector:@selector(doClick1)];
        
        CCMenuItem *howto = [CCMenuItemImage itemWithNormalImage:@"menu_howto.png" selectedImage:@"menu_howto_sel.png" target:self selector:@selector(doClick2)];
        
        CCMenuItem *credit = [CCMenuItemImage itemWithNormalImage:@"menu_credit.png" selectedImage:@"menu_credit_sel.png" target:self selector:@selector(doClick3)];
        
        CCMenu *menu = [CCMenu menuWithItems:start,howto,credit, nil];
        menu.position = ccp(winSize.width/2, winSize.height/2 - 20);
        [menu alignItemsVerticallyWithPadding:15.0f];
        [self addChild:menu];
        
        //파티클 1번
        [self doParticle1];
        [self doParticle2];
        
        //다양한 사운드
        gsound = [SimpleAudioEngine sharedEngine];
        gsound.effectsVolume = 0.9;
		[gsound preloadBackgroundMusic:@"main_bgm.mp3"];
		[gsound preloadEffect:@"click.mp3"];
        [gsound playBackgroundMusic:@"main_bgm.mp3" loop:YES];
        
    }
	return self;
}


- (void)doClick1
{
    [sceneManager goStory];
    [self removeChild:flame cleanup:YES];
    [self removeChild:electric cleanup:YES];
    [gsound playEffect:@"click.mp3"];
    [gsound stopBackgroundMusic];
}

- (void)doClick2
{
    [sceneManager goHowto];
    [gsound playEffect:@"click.mp3"];
}

- (void)doClick3
{
    [sceneManager goCredit];
    [gsound playEffect:@"click.mp3"];
}



-(void) doParticle1
{
    CGSize winSize = [[CCDirector sharedDirector] winSize];
    CCParticleSystem *fireparticle = [CCParticleFire node];
    fireparticle.position = ccp(winSize.width/8 + 10,90);
    [self addChild:fireparticle z:5];
}

-(void) doParticle2
{
    CGSize winSize = [[CCDirector sharedDirector] winSize];
    CCParticleSystem *elecparticle = [CCParticleGalaxy node];
    CCParticleSystem *elecparticle2 = [CCParticleMeteor node];
    elecparticle.position = ccp(winSize.width - 70,90);
    elecparticle2.position = ccp(winSize.width - 70,90);
    elecparticle2.speed = 200;
    elecparticle.scale = 0.6;
    elecparticle2.scale = 0.3;
    [self addChild:elecparticle z:6];
    [self addChild:elecparticle2 z:8];
}

-(void) dealloc
{
	[super dealloc];
}
    
#pragma mark GameKit delegate

-(void) achievementViewControllerDidFinish:(GKAchievementViewController *)viewController
{
	AppController *app = (AppController*) [[UIApplication sharedApplication] delegate];
	[[app navController] dismissModalViewControllerAnimated:YES];
}

-(void) leaderboardViewControllerDidFinish:(GKLeaderboardViewController *)viewController
{
	AppController *app = (AppController*) [[UIApplication sharedApplication] delegate];
	[[app navController] dismissModalViewControllerAnimated:YES];
}
@end
