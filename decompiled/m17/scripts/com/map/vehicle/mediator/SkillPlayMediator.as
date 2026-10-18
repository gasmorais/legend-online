package com.map.vehicle.mediator
{
   import com.map.vehicle.SkillEffectFactory;
   import com.map.vehicle.VehicleModel;
   import com.map.vehicle.data.HurtData;
   import com.map.vehicle.data.PlayerVehicleInfo;
   import com.map.vehicle.data.UseSkillInfo;
   import com.map.vehicle.data.VehicleNode;
   import com.map.vehicle.events.VehicleEvent;
   import com.map.vehicle.net.VehicleSocketManager;
   import com.map.vehicle.objects.VehicleNpcAvatarView;
   import com.map.vehicle.view.VehicleSkillMovie;
   import flash.display.Sprite;
   import flash.utils.clearTimeout;
   import flash.utils.setTimeout;
   import yishi.interfaces.IMediator;
   import yishi.manager.NotificationManager;
   
   public class SkillPlayMediator implements IMediator
   {
      
      private var _skillFlyLayer:Sprite;
      
      private var _model:VehicleModel = VehicleSocketManager.instance.model;
      
      public function SkillPlayMediator()
      {
         super();
      }
      
      public function register(param1:Object) : void
      {
         _skillFlyLayer = param1 as Sprite;
         NotificationManager.instance.addEventListener("play_skill",__startSkillEffectHandler);
      }
      
      public function unregister(param1:Object) : void
      {
         NotificationManager.instance.removeEventListener("play_skill",__startSkillEffectHandler);
      }
      
      private function __startSkillEffectHandler(param1:VehicleEvent) : void
      {
         var _loc6_:VehicleNpcAvatarView = null;
         var _loc3_:int = 0;
         var _loc5_:UseSkillInfo = param1.data as UseSkillInfo;
         var _loc2_:VehicleNode = _model.getNodeByNodeId(_loc5_.casterId);
         if(_loc2_)
         {
            _loc6_ = _loc2_.logicView as VehicleNpcAvatarView;
            if(_loc6_)
            {
               _loc2_.state = 2;
               _loc3_ = int(setTimeout(attackEnd,800,_loc6_,_loc3_));
            }
         }
         var _loc4_:VehicleSkillMovie = SkillEffectFactory.instance.createEndEffect(_loc5_);
         _loc4_.x = _loc5_.effectX * 20;
         _loc4_.y = _loc5_.effectY * 20;
         _skillFlyLayer.addChild(_loc4_);
         hurt(_loc5_);
      }
      
      private function attackEnd(param1:VehicleNpcAvatarView, param2:int) : void
      {
         clearTimeout(param2);
         if(param1)
         {
            param1.state = 3;
         }
      }
      
      private function hurt(param1:UseSkillInfo) : void
      {
         var _loc3_:* = null;
         var _loc4_:PlayerVehicleInfo = null;
         var _loc2_:VehicleNode = null;
         for each(_loc3_ in param1.playerHurt)
         {
            _loc4_ = _model.getPlayerInfo(_loc3_.effectId);
            _loc4_.beAtk(_loc3_);
         }
         for each(_loc3_ in param1.npcHurt)
         {
            _loc2_ = _model.getNodeByNodeId(_loc3_.effectId);
            _loc2_.beAtk(_loc3_);
         }
      }
   }
}

