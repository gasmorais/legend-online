package map.internals.mediator.layer
{
   import com.greensock.TimelineMax;
   import com.greensock.TweenMax;
   import com.pickgliss.toplevel.StageReferance;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.KeyboardEvent;
   import flash.utils.Dictionary;
   import map.internals.filter.MapPhysicsFilter;
   import map.internals.interfaces.ISelectMovie;
   import map.internals.view.physics.MapPhysicsBase;
   import map.outercity.manager.OuterCityManager;
   import map.outercity.view.mapphysics.MapPhysicsCastle;
   import yishi.interfaces.IMediator;
   import yishi.manager.PlayerManager;
   import yishi.scene.SceneManager;
   
   public class OuterCityBuildingSelectMediator implements IMediator
   {
      
      private var _target:Sprite;
      
      private var _isDown:Boolean;
      
      private var _fileter:MapPhysicsFilter = new MapPhysicsFilter();
      
      private var _is:Boolean;
      
      private var _canAttack:Array = [];
      
      private var _noAttack:Array = [];
      
      public function OuterCityBuildingSelectMediator()
      {
         super();
      }
      
      public function register(param1:Object) : void
      {
         _target = param1 as Sprite;
         StageReferance.stage.addEventListener("deactivate",__deactiveHandler);
         StageReferance.stage.addEventListener("mouseLeave",__deactiveHandler);
      }
      
      public function unregister(param1:Object) : void
      {
         _target = null;
         StageReferance.stage.removeEventListener("deactivate",__deactiveHandler);
         StageReferance.stage.removeEventListener("mouseLeave",__deactiveHandler);
      }
      
      private function __deactiveHandler(param1:Event) : void
      {
         clearAllPhysicsFilter();
      }
      
      private function __kayDownHandler(param1:KeyboardEvent) : void
      {
         var _loc4_:Array = null;
         var _loc2_:* = null;
         var _loc3_:* = null;
         var _loc5_:Dictionary = null;
         if(_isDown)
         {
            return;
         }
         if(param1.keyCode == 17)
         {
            _isDown = true;
            if(SceneManager.instance.currentType == "OUTER_CITY_SCENE")
            {
               _loc4_ = [];
               _loc5_ = OuterCityManager.instance.model.allWildLand;
               for each(_loc2_ in _loc5_)
               {
                  _loc4_.push(_loc2_);
               }
               _loc5_ = OuterCityManager.instance.model.allCastles;
               for each(_loc2_ in _loc5_)
               {
                  _loc4_.push(_loc2_);
               }
               setAllPhysicsFilter(_loc4_);
            }
            param1.stopPropagation();
         }
      }
      
      private function __keyUpHandler(param1:KeyboardEvent) : void
      {
         if(param1.keyCode == 17)
         {
            _isDown = false;
            if(SceneManager.instance.currentType == "OUTER_CITY_SCENE")
            {
               clearAllPhysicsFilter();
            }
            param1.stopPropagation();
         }
      }
      
      public function setAllPhysicsFilter(param1:Object) : void
      {
         var _loc9_:ISelectMovie = null;
         if(_is)
         {
            return;
         }
         _is = true;
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
         var _loc10_:TimelineMax = new TimelineMax({
            "repeat":-1,
            "yoyo":true,
            "repeatDelay":0.5
         });
         var _loc6_:TimelineMax = new TimelineMax({
            "repeat":-1,
            "yoyo":true,
            "repeatDelay":0.5
         });
         var _loc7_:Array = [];
         var _loc4_:Array = [];
         var _loc11_:int = int(PlayerManager.instance.currentPlayerModel.playerInfo.userId);
         for each(var _loc5_:Object in param1)
         {
            for each(var _loc8_ in _loc5_)
            {
               _loc9_ = _loc8_.nodeView;
               if(_loc9_)
               {
                  _loc9_.beginSelectMovie();
                  if(_loc9_["isPlaying"])
                  {
                     if(_loc9_ is MapPhysicsCastle)
                     {
                        if((_loc9_ as MapPhysicsCastle).info.info.occupyPlayerId == 0)
                        {
                           _loc4_.push(_loc9_.selectMovie);
                           _noAttack.push(_loc9_);
                        }
                        else
                        {
                           if(_loc9_["isSelfCastle"])
                           {
                              continue;
                           }
                           _loc7_.push(_loc9_.selectMovie);
                           _canAttack.push(_loc9_);
                        }
                     }
                     else
                     {
                        if(_loc9_ is MapPhysicsBase)
                        {
                           if((_loc9_ as MapPhysicsBase).info.info.occupyPlayerId == _loc11_)
                           {
                              _loc4_.push(_loc9_.selectMovie);
                              _noAttack.push(_loc9_);
                              continue;
                           }
                        }
                        _loc7_.push(_loc9_.selectMovie);
                        _canAttack.push(_loc9_);
                     }
                  }
               }
            }
         }
         _loc3_.insertMultiple(TweenMax.allFrom(_loc7_,0.5,{
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
         _loc2_.insertMultiple(TweenMax.allFrom(_loc7_,0.5,{
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
         _loc10_.insertMultiple(TweenMax.allFrom(_loc4_,0.5,{
            "colorTransform":{
               "tint":16776960,
               "tintAmount":0.4
            },
            "glowFilter":{
               "color":16711680,
               "alpha":0.9,
               "blurX":17,
               "blurY":17
            }
         }));
         _loc6_.insertMultiple(TweenMax.allFrom(_loc4_,0.5,{
            "colorTransform":{
               "tint":16776960,
               "tintAmount":0.15
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
      
      public function clearAllPhysicsFilter() : void
      {
         var _loc2_:ISelectMovie = null;
         _is = false;
         var _loc1_:Sprite = OuterCityManager.instance.mapView.npcLayer as Sprite;
         TweenMax.killChildTweensOf(_loc1_,false);
         _loc1_ = OuterCityManager.instance.mapView.mainBuidingLayer as Sprite;
         TweenMax.killChildTweensOf(_loc1_,false);
         while(_canAttack.length > 0)
         {
            _loc2_ = _canAttack.pop();
            _loc2_.resetSelectMovie();
         }
         while(_noAttack.length > 0)
         {
            _loc2_ = _noAttack.pop();
            _loc2_.resetSelectMovie();
         }
      }
   }
}

