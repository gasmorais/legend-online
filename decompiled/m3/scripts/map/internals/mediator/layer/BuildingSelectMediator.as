package map.internals.mediator.layer
{
   import com.greensock.TimelineMax;
   import com.greensock.TweenMax;
   import com.pickgliss.toplevel.StageReferance;
   import flash.display.DisplayObject;
   import flash.events.Event;
   import flash.events.KeyboardEvent;
   import map.campaign.CampaignManager;
   import map.internals.data.MapPhysics;
   import map.internals.interfaces.ISelectMovie;
   import map.internals.view.hero.HeroAvatarView;
   import map.internals.view.physics.MapPhysicsBase;
   import org.aswing.KeyboardManager;
   import yishi.interfaces.IMediator;
   import yishi.scene.SceneManager;
   import yishi.utils.WorldBossHelper;
   
   public class BuildingSelectMediator implements IMediator
   {
      
      private var _target:Object;
      
      private var _isDown:Boolean;
      
      private var canAttack:Array = [];
      
      private var selected:Array = [];
      
      public function BuildingSelectMediator()
      {
         super();
      }
      
      public function register(param1:Object) : void
      {
         _target = param1;
         KeyboardManager.getInstance().addEventListener("keyDown",__kayDownHandler);
         KeyboardManager.getInstance().addEventListener("keyUp",__keyUpHandler);
         StageReferance.stage.addEventListener("deactivate",__deactiveHandler);
         StageReferance.stage.addEventListener("mouseLeave",__deactiveHandler);
      }
      
      public function unregister(param1:Object) : void
      {
         _target = null;
         KeyboardManager.getInstance().removeEventListener("keyDown",__kayDownHandler);
         KeyboardManager.getInstance().removeEventListener("keyUp",__keyUpHandler);
         StageReferance.stage.removeEventListener("deactivate",__deactiveHandler);
         StageReferance.stage.removeEventListener("mouseLeave",__deactiveHandler);
      }
      
      private function __deactiveHandler(param1:Event) : void
      {
         if(SceneManager.instance.currentType == "CAMPAIGN_MAP_SCENE")
         {
            clearAllPhysicsFilter();
         }
      }
      
      private function __kayDownHandler(param1:KeyboardEvent) : void
      {
         var _loc2_:Array = null;
         if(_isDown)
         {
            return;
         }
         if(param1.keyCode == 17)
         {
            _isDown = true;
            if(SceneManager.instance.currentType == "CAMPAIGN_MAP_SCENE")
            {
               _loc2_ = CampaignManager.instance.mapModel.mapNodesData;
               if(!WorldBossHelper.checkPvp(CampaignManager.instance.mapModel.mapId) && !WorldBossHelper.checkUnrealShooting(CampaignManager.instance.mapModel.mapId))
               {
                  setAllPhysicsFilter(_loc2_);
               }
            }
            param1.stopPropagation();
         }
      }
      
      private function __keyUpHandler(param1:KeyboardEvent) : void
      {
         if(param1.keyCode == 17)
         {
            _isDown = false;
            if(SceneManager.instance.currentType == "CAMPAIGN_MAP_SCENE")
            {
               if(!WorldBossHelper.checkPvp(CampaignManager.instance.mapModel.mapId) || !WorldBossHelper.checkFlameTemple(CampaignManager.instance.mapModel.mapId) && !WorldBossHelper.checkUnrealShooting(CampaignManager.instance.mapModel.mapId))
               {
                  clearAllPhysicsFilter();
               }
            }
            param1.stopPropagation();
         }
      }
      
      private function setAllPhysicsFilter(param1:Object) : void
      {
         var _loc3_:TimelineMax = new TimelineMax({
            "repeat":-1,
            "yoyo":true,
            "repeatDelay":0.5
         });
         var _loc2_:TimelineMax = new TimelineMax({
            "repeat":-1,
            "yoyo":true,
            "repeatDelay":0.5
         });
         clearAllPhysicsFilter();
         for each(var _loc4_:MapPhysics in param1)
         {
            if(_loc4_.info.state == 1)
            {
               if(_loc4_.nodeView is MapPhysicsBase)
               {
                  canAttack.push((_loc4_.nodeView as MapPhysicsBase).movie);
                  selected.push(_loc4_.nodeView);
               }
               else if(_loc4_.nodeView is HeroAvatarView)
               {
                  canAttack.push((_loc4_.nodeView as HeroAvatarView).avatarView);
                  selected.push(_loc4_.nodeView);
               }
               if(_loc4_.nodeView is ISelectMovie)
               {
                  (_loc4_.nodeView as ISelectMovie).beginSelectMovie();
               }
            }
         }
         _loc3_.insertMultiple(TweenMax.allFrom(canAttack,0.5,{
            "colorTransform":{
               "tint":16711680,
               "tintAmount":0.4
            },
            "glowFilter":{
               "color":16711680,
               "alpha":0.9,
               "blurX":17,
               "blurY":17
            }
         }));
         _loc2_.insertMultiple(TweenMax.allFrom(canAttack,0.5,{
            "colorTransform":{
               "tint":16711680,
               "tintAmount":0.18
            },
            "glowFilter":{
               "color":16711680,
               "alpha":1,
               "blurX":0,
               "blurY":0,
               "delay":0.5
            }
         }));
      }
      
      private function clearAllPhysicsFilter() : void
      {
         var _loc1_:DisplayObject = null;
         killChildTweensOf(false);
         while(selected.length > 0)
         {
            _loc1_ = selected.pop();
            if(_loc1_.parent is ISelectMovie)
            {
               (_loc1_.parent as ISelectMovie).resetSelectMovie();
            }
            else if(_loc1_ is ISelectMovie)
            {
               (_loc1_ as ISelectMovie).resetSelectMovie();
            }
            else
            {
               _loc1_.filters = null;
            }
         }
      }
      
      public function killChildTweensOf(param1:Boolean = false) : void
      {
         var _loc5_:* = null;
         var _loc4_:Object = null;
         var _loc2_:Array = TweenMax.getAllTweens();
         var _loc3_:int = int(_loc2_.length);
         while(--_loc3_ > -1)
         {
            _loc4_ = _loc2_[_loc3_].target;
            if(canAttack.indexOf(_loc4_) != -1)
            {
               if(param1)
               {
                  _loc2_[_loc3_].complete(false);
               }
               else
               {
                  _loc2_[_loc3_].setEnabled(false,false);
               }
            }
         }
      }
   }
}

