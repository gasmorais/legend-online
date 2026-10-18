package com.map.vehicle.data
{
   import com.map.vehicle.events.VehicleEvent;
   import com.map.vehicle.interfaces.IBuffer;
   import com.map.vehicle.utils.VehicleUtil;
   import com.road.mapengine.bitmap.logic.BitmapSimpleLogic;
   import flash.events.EventDispatcher;
   import flash.utils.Dictionary;
   import yishi.datas.templates.VehicleObjectTempInfo;
   
   public class VehicleNode extends EventDispatcher implements IBuffer
   {
      
      public var logicView:BitmapSimpleLogic;
      
      public var nodeId:int;
      
      public var type:int;
      
      public var posX:int;
      
      public var posY:int;
      
      public var state:int;
      
      public var hp:int;
      
      public var name:String;
      
      public var sonType:int;
      
      public var handlerRange:int = 2;
      
      public var nameColor:int = 1;
      
      public var resource:int = 0;
      
      public var heroTempId:int;
      
      public var resetPosX:int;
      
      public var resetPosY:int;
      
      private var _teamId:int = 0;
      
      public var buffList:Dictionary = new Dictionary(true);
      
      public function VehicleNode()
      {
         super();
      }
      
      public function get totalHp() : int
      {
         var _loc2_:VehicleObjectTempInfo = null;
         var _loc1_:int = 0;
         if(type == 0)
         {
            _loc2_ = VehicleUtil.getVehicleObjectTemplate(VGlobal.model.bossTempId);
            if(_loc2_)
            {
               _loc1_ = int(_loc2_.Hp);
            }
         }
         return _loc1_;
      }
      
      public function isBoss() : Boolean
      {
         return this.type == 0;
      }
      
      public function get teamId() : int
      {
         return _teamId;
      }
      
      public function set teamId(param1:int) : void
      {
         _teamId = param1;
      }
      
      public function beAtk(param1:HurtData) : void
      {
         dispatchEvent(new VehicleEvent("SKILL_HURT",param1));
      }
      
      public function shoot(param1:UseSkillInfo) : void
      {
         this.dispatchEvent(new VehicleEvent("SKILL_CAST_OVER",param1));
      }
      
      public function addBuffDamage(param1:VehicleBufferDamageInfo) : void
      {
         var _loc2_:HurtData = null;
         if(param1.state == 0)
         {
            buffList[param1.id] = param1;
            param1.start();
            dispatchEvent(new VehicleEvent("ADD_BUFF",param1));
         }
         else if(param1.state == 1)
         {
            if(buffList[param1.id])
            {
               (buffList[param1.id] as VehicleBufferDamageInfo).stop();
            }
            buffList[param1.id] = null;
            delete buffList[param1.id];
            dispatchEvent(new VehicleEvent("REMOVE_BUFF",param1));
         }
         else if(param1.state == 2)
         {
            if(param1.damage != 0 && param1.buffTemplate && param1.buffTemplate.EffectType == VehicleSkillEffectType.HP_CHANGE)
            {
               _loc2_ = new HurtData();
               _loc2_.effectValue = param1.damage;
               if(_loc2_.effectValue <= 0)
               {
                  _loc2_.effectType = 0;
               }
               else
               {
                  _loc2_.effectType = 1;
               }
               this.dispatchEvent(new VehicleEvent("BUFF_HURT",_loc2_));
            }
         }
      }
      
      public function changeHp(param1:HurtData) : void
      {
         this.dispatchEvent(new VehicleEvent("SKILL_HURT",param1));
      }
      
      public function changePercentSpeed(param1:int) : void
      {
      }
      
      public function changeSpeed(param1:int) : void
      {
      }
      
      public function setStun(param1:Boolean) : void
      {
      }
      
      public function get isDie() : Boolean
      {
         return state == 1;
      }
      
      public function commit() : void
      {
         dispatchEvent(new VehicleEvent("updateNode",this));
      }
   }
}

