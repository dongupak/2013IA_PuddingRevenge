//
//  selectScene.m
//  PudingRevenge
//
//  Created by apple02 on 13. 5. 15..
//
//

#import "selectScene.h"

@implementation selectScene

-(id) init
{
	if( (self=[super init]) ) {
		

        CGSize winSize = [[CCDirector sharedDirector] winSize];
        //배경 스프라이트
        CCSprite *bgSprite = [CCSprite
                              spriteWithFile:@"select_background.png"];
		bgSprite.anchorPoint = CGPointZero;
		[bgSprite setPosition: ccp(0, 0)];
        [self addChild:bgSprite z:0 tag:10];
        
        
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
        flame.position = ccp(winSize.width/8 + 10, 10);
        [self addChild:flame z:0 tag:100];
        
        electric = [CCSprite spriteWithSpriteFrame:[aniFrames2 objectAtIndex:1]];
        electric.position = ccp(winSize.width - 70, 10);
        [self addChild:electric z:0 tag:101];
        
        
        CCAnimation *fAnin = [CCAnimation animationWithSpriteFrames:aniFrames1 delay:0.15f];
        CCAnimation *eAnin = [CCAnimation animationWithSpriteFrames:aniFrames2 delay:0.15f];
        
        CCAnimate *fAnite = [CCAnimate actionWithAnimation:fAnin];
        CCAnimate *eAnite = [CCAnimate actionWithAnimation:eAnin];
        
        fAnite = [CCRepeatForever actionWithAction:fAnite];
        eAnite = [CCRepeatForever actionWithAction:eAnite];
        [flame runAction:fAnite];
        [electric runAction:eAnite];

        
        //파티클 1번
        [self doParticle1];
        [self doParticle2];
        
        
        
        CCSprite *wall = [CCSprite
                           spriteWithFile:@"select_wall.png"];
		wall.position = ccp(winSize.width/2, 0);
        [self addChild:wall z:0 tag:15];
        
        pudding = [CCSprite
                          spriteWithFile:@"basic_pudding_01.png"];
		pudding.position = ccp(winSize.width/2, winSize.height/2 + 20);
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
        
        
        
        //메뉴
        selecFlame = [CCMenuItemImage itemWithNormalImage:@"select_flame_menu.png" selectedImage:@"select_flame_menu_sel.png" target:self selector:@selector(doClick1)];
        
        selecElectric = [CCMenuItemImage itemWithNormalImage:@"select_electric_menu.png" selectedImage:@"select_electric_menu_sel.png" target:self selector:@selector(doClick2)];
        
        select = [CCMenu menuWithItems:selecFlame,selecElectric, nil];
        [select setPosition:ccp(winSize.width/2, winSize.height - 40)];
        [select alignItemsHorizontallyWithPadding:120.0f];
        
        [self addChild:select];
        
        
        //효과음
        gsound = [SimpleAudioEngine sharedEngine];
        [gsound preloadEffect:@"click.mp3"];
        [gsound preloadEffect:@"trans_effect.mp3"];
        
    }
    return self;
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

- (void)doClick1
{
    CGSize winSize = [[CCDirector sharedDirector] winSize];
    CCSprite *ffeed = [CCSprite spriteWithFile:@"flame_feed.png"];
    ffeed.position = ccp(winSize.height/8 + 10, 10);
    [self addChild:ffeed z:0 tag:25];
    
    
    
    id feedmove1 = [CCMoveBy actionWithDuration:0.6 position:ccp(0, 90)];
    id feedmove2 = [CCMoveBy actionWithDuration:0.6 position:ccp(170, 0)];
    id feedmove = [CCSequence actions:feedmove1,feedmove2, nil];
    [ffeed runAction:feedmove];
    
    //플레임 푸딩 변신 애니메이션
    [[CCSpriteFrameCache sharedSpriteFrameCache] addSpriteFramesWithFile:@"flame_trans.plist"];
    
    
    NSMutableArray *transAniFrames = [NSMutableArray array];
    
    for (int i = 1; i < 42; i++) {
        
        CCSpriteFrame *tframe1 = [[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:[NSString stringWithFormat:@"trans_pudding_%02d.png",i]];
        [transAniFrames addObject:tframe1];
    }
    
    
    CCAnimation *fAnin = [CCAnimation animationWithSpriteFrames:transAniFrames delay:0.1f];
    CCAnimate *fAnite = [CCAnimate actionWithAnimation:fAnin];
    
    CCSprite *flamePudding;
    flamePudding = [CCSprite spriteWithSpriteFrame:[transAniFrames objectAtIndex:1]];
    flamePudding.position = ccp(winSize.width/2, winSize.height/2);

        [self addChild:flamePudding z:0 tag:100];
        [self removeChild:pudding cleanup:YES];
        [flamePudding runAction:fAnite];
    
    
    
    //메뉴 제거
    [self removeChild:select cleanup:YES];
    
    [self performSelector:@selector(goGame1) withObject:self afterDelay:4.5];
    
    
    [gsound playEffect:@"click.mp3"];
    [gsound playEffect:@"trans_effect.mp3"];
}

- (void)doClick2
{
    CGSize winSize = [[CCDirector sharedDirector] winSize];
    NSLog(@"electric sel");
    CCSprite *efeed = [CCSprite
                         spriteWithFile:@"electric_feed.png"];
    efeed.position = ccp(winSize.width - 70, 10);
    [self addChild:efeed z:0 tag:25];
    id feedmove1 = [CCMoveBy actionWithDuration:0.6 position:ccp(0, 80)];
    id feedmove2 = [CCMoveBy actionWithDuration:0.6 position:ccp(-170, 0)];
    id feedmove = [CCSequence actions:feedmove1,feedmove2, nil];
    [efeed runAction:feedmove];
    
    //일렉트릭 푸딩 변신 애니메이션
    [[CCSpriteFrameCache sharedSpriteFrameCache] addSpriteFramesWithFile:@"electric_trans.plist"];
    NSMutableArray *transAniFrames = [NSMutableArray array];
    
    for (int i = 1; i < 42; i++) {
        
        CCSpriteFrame *tframe1 = [[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:[NSString stringWithFormat:@"trans_pudding_%02d.png",i]];
        [transAniFrames addObject:tframe1];
    }
    
    
    CCAnimation *eAnin = [CCAnimation animationWithSpriteFrames:transAniFrames delay:0.1f];
    CCAnimate *eAnite = [CCAnimate actionWithAnimation:eAnin];
    
    CCSprite *electricPudding;
    electricPudding = [CCSprite spriteWithSpriteFrame:[transAniFrames objectAtIndex:1]];
    electricPudding.position = ccp(winSize.width/2, winSize.height/2);
    
    [self addChild:electricPudding z:0 tag:100];
    [self removeChild:pudding cleanup:YES];
    [electricPudding runAction:eAnite];
    
    //메뉴 제거
    [self removeChild:select cleanup:YES];
    [self performSelector:@selector(goGame2) withObject:self afterDelay:4.5];
    
    [gsound playEffect:@"click.mp3"];
    [gsound playEffect:@"trans_effect.mp3"];
}

// Flame 버튼을 터치하면 Flame Pudding의 게임인 gameScene으로 이동
- (void)goGame1
{
    [sceneManager goGame];
    [self removeAllChildrenWithCleanup:YES];

}

// Electric 버튼을 터치하면 Electirc Pudding의 게임인 gameScene2으로 이동
- (void)goGame2
{
    [sceneManager goGame2];
    [self removeAllChildrenWithCleanup:YES];
}


-(void) dealloc
{
	[super dealloc];
}

@end
