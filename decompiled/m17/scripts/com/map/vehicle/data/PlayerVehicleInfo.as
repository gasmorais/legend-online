package com.map.vehicle.data
{
   import chat.datas.ChatData;
   import com.map.vehicle.events.VehicleEvent;
   import com.map.vehicle.interfaces.IBuffer;
   import com.road.mapengine.bitmap.logic.BitmapSimpleLogic;
   import flash.events.EventDispatcher;
   import flash.events.IEventDispatcher;
   import flash.utils.Dictionary;
   import flash.utils.clearTimeout;
   import flash.utils.setTimeout;
   import manager.LanguageMgr;
   import yishi.datas.templates.AppellInfoTemplate;
   import yishi.datas.templates.VehicleObjectTempInfo;
   import yishi.datas.templates.VehicleSkillTempInfo;
   import yishi.manager.TempleteManager;
   import yishi.view.tips.MessageTipManager;
   
   public class PlayerVehicleInfo extends EventDispatcher implements IBuffer
   {
      
      public var name:String;
      
      public var consortiaName:String = "";
      
      public var id:int;
      
      public var team:int;
      
      public var isVip:Boolean = false;
      
      public var vipType:int;
      
      public var appellId:int;
      
      public var vocationGrades:int;
      
      public var vocationIndex:int;
      
      private var _hp:int = -1;
      
      private var _rebornTime:int = 0;
      
      public var isCasting:Boolean = false;
      
      public var isPickup:Boolean = false;
      
      public var isStun:Boolean = false;
      
      private var _isDisPatchDieEvent:Boolean;
      
      private var _dieTimerId:int = 0;
      
      public var playerId:int;
      
      private var _templateId:int;
      
      public var x:int;
      
      public var y:int;
      
      public var grade:int;
      
      public var headId:int;
      
      public var logicView:BitmapSimpleLogic;
      
      private var _state:int;
      
      public var speed:int = 7;
      
      public var bufferIds:Array = [];
      
      public var buffList:Dictionary = new Dictionary(true);
      
      public var score:int = 0;
      
      private var _chatData:ChatData;
      
      public function PlayerVehicleInfo(param1:IEventDispatcher = null)
      {
         super(param1);
      }
      
      public function get vocationLevel() : int
      {
         var _loc1_:int = (vocationGrades - 1) / 10 + 1;
         if(vocationIndex > 0)
         {
            return _loc1_ + 8;
         }
         return _loc1_;
      }
      
      public function get rebornTime() : int
      {
         return _rebornTime;
      }
      
      public function set rebornTime(param1:int) : void
      {
         _rebornTime = param1;
         if(_rebornTime > 0)
         {
            dispatchEvent(new VehicleEvent("DIE_COUNT",param1));
         }
      }
      
      public function get hp() : int
      {
         return _hp;
      }
      
      public function get isDie() : Boolean
      {
         return hp <= 0;
      }
      
      public function set hp(param1:int) : void
      {
         var _loc2_:int = _hp;
         _hp = param1;
         if(_hp <= 0)
         {
            _hp = 0;
            clearBuff();
         }
         if(_loc2_ == param1)
         {
            return;
         }
         if(_loc2_ == 0 && _hp > 0)
         {
            _isDisPatchDieEvent = false;
            dispatchEvent(new VehicleEvent("REVIER",this));
         }
         else if(_hp <= 0)
         {
            _dieTimerId = setTimeout(disPatchDieEvent,1200);
         }
         if(_loc2_ < _hp)
         {
            dispatchEvent(new VehicleEvent("HP_ADD",_hp - _loc2_));
         }
         else if(_loc2_ > param1)
         {
            dispatchEvent(new VehicleEvent("HP_CUT",_hp - _loc2_));
         }
         dispatchEvent(new VehicleEvent("update_hp",this));
      }
      
      private function disPatchDieEvent() : void
      {
         if(_dieTimerId != 0)
         {
            clearTimeout(_dieTimerId);
            _dieTimerId = 0;
         }
         if(_isDisPatchDieEvent)
         {
            return;
         }
         _isDisPatchDieEvent = true;
         dispatchEvent(new VehicleEvent("DIE",this));
      }
      
      public function get templateId() : int
      {
         return _templateId;
      }
      
      public function set templateId(param1:int) : void
      {
         if(_templateId != param1)
         {
            _templateId = param1;
            dispatchEvent(new VehicleEvent("VEHICLE_TEMPLATE_CHANGE",this));
         }
      }
      
      public function get template() : VehicleObjectTempInfo
      {
         return TempleteManager.instance.vehicleObjectTempInfoCate.getTemplateByIndex(templateId);
      }
      
      public function get talentSkillTemplate() : VehicleSkillTempInfo
      {
         var _loc1_:VehicleObjectTempInfo = template;
         if(_loc1_)
         {
            return TempleteManager.instance.vehicleSkillTempteCate.getTemplateByTid(_loc1_.GeniusSkill);
         }
         return null;
      }
      
      public function get normalSkillTemplate() : VehicleSkillTempInfo
      {
         var _loc1_:VehicleObjectTempInfo = template;
         if(_loc1_)
         {
            return TempleteManager.instance.vehicleSkillTempteCate.getTemplateByTid(_loc1_.NormalSkill);
         }
         return null;
      }
      
      public function cast(param1:SkillCastInfo) : void
      {
         if(this.hp <= 0)
         {
            return;
         }
         if(isPickup)
         {
            return;
         }
         if(isStun)
         {
            return;
         }
         this.dispatchEvent(new VehicleEvent("cast",param1));
      }
      
      public function shoot(param1:UseSkillInfo) : void
      {
         this.dispatchEvent(new VehicleEvent("SKILL_CAST_OVER",param1));
      }
      
      public function pickup(param1:VehicleNode) : void
      {
         var _loc2_:String = null;
         if(hp <= 0)
         {
            _loc2_ = LanguageMgr.GetTranslation("vehicle.waitRiver");
            MessageTipManager.instance().show(_loc2_);
            return;
         }
         if(isCasting)
         {
            return;
         }
         if(isStun)
         {
            return;
         }
         dispatchEvent(new VehicleEvent("pickup",param1));
      }
      
      public function beAtk(param1:HurtData) : void
      {
         if(param1.skillId != 0)
         {
            this.dispatchEvent(new VehicleEvent("SKILL_HURT",param1));
            this.dispatchEvent(new VehicleEvent("BREAK_PICKUP",this));
         }
         else
         {
            this.dispatchEvent(new VehicleEvent("BUFF_HURT",param1));
         }
         if(this.hp <= 0)
         {
            disPatchDieEvent();
         }
      }
      
      public function get state() : int
      {
         return _state;
      }
      
      public function set state(param1:int) : void
      {
         if(_state != param1)
         {
            _state = param1;
            dispatchEvent(new VehicleEvent("stateChange",param1));
         }
      }
      
      public function addBuffDamage(param1:VehicleBufferDamageInfo) : void
      {
         var _loc2_:HurtData = null;
         if(param1.buffTemplate && param1.buffTemplate.Duration <= 0)
         {
            dispatchEvent(new VehicleEvent("ADD_BUFF",param1));
            return;
         }
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
         if(param1.damage < 0 && param1.buffTemplate && param1.buffTemplate.EffectType == VehicleSkillEffectType.HP_CHANGE)
         {
            _loc2_ = new HurtData();
            _loc2_.effectValue = param1.damage;
            _loc2_.effectType = 0;
            this.dispatchEvent(new VehicleEvent("BUFF_HURT",_loc2_));
            if(this.hp <= 0)
            {
               disPatchDieEvent();
            }
         }
         updateDamage(param1);
      }
      
      public function clearBuff() : void
      {
         if(!template)
         {
            return;
         }
         isStun = false;
         speed = template.Speed;
         for(var _loc1_:String in buffList)
         {
            delete buffList[_loc1_];
         }
         dispatchEvent(new VehicleEvent("CLEAR_BUFF",this));
      }
      
      private function updateDamage(param1:VehicleBufferDamageInfo) : void
      {
         if(param1.buffId == 0)
         {
            return;
         }
         switch(param1.buffTemplate.EffectType)
         {
            case VehicleSkillEffectType.SPEED_CHANGE:
               checkSpeed();
               break;
            case VehicleSkillEffectType.STUN:
               checkStunBuff();
         }
      }
      
      private function checkSpeed() : void
      {
         var _loc2_:Number = NaN;
         var _loc1_:int = 0;
         var _loc3_:int = 0;
         for each(var _loc5_:VehicleBufferDamageInfo in buffList)
         {
            if(_loc5_.buffTemplate.EffectType == VehicleSkillEffectType.SPEED_CHANGE)
            {
               if(_loc5_.state != 1)
               {
                  _loc2_ = 0;
                  if(_loc5_.buffTemplate.EffectPercent != 0)
                  {
                     _loc2_ = template.Speed * _loc5_.buffTemplate.EffectPercent / 100;
                  }
                  else
                  {
                     _loc2_ = Number(_loc5_.buffTemplate.EffectValue);
                  }
                  if(_loc2_ > 0)
                  {
                     _loc1_ = int(_loc1_ > _loc2_ ? _loc1_ : _loc2_);
                  }
                  else
                  {
                     _loc3_ = int(_loc3_ > _loc2_ ? _loc2_ : _loc3_);
                  }
               }
            }
         }
         var _loc4_:int = _loc1_ + _loc3_;
         updateSpeed(_loc4_);
      }
      
      private function updateSpeed(param1:int) : void
      {
         this.speed = this.template.Speed + param1;
      }
      
      private function checkStunBuff() : void
      {
         for each(var _loc1_:VehicleBufferDamageInfo in buffList)
         {
            if(_loc1_.buffTemplate.EffectType == VehicleSkillEffectType.STUN)
            {
               if(_loc1_.state != 1)
               {
                  this.isStun = true;
                  return;
               }
            }
         }
         this.isStun = false;
      }
      
      public function get totalHp() : int
      {
         return int(template.Hp + (grade - 1) * 100);
      }
      
      public function get appellTemplate() : AppellInfoTemplate
      {
         return TempleteManager.instance.appellInfoTemplateCate.getTemplateByID(appellId);
      }
      
      public function get chatData() : ChatData
      {
         return _chatData;
      }
      
      public function set chatData(param1:ChatData) : void
      {
         _chatData = param1;
         this.dispatchEvent(new VehicleEvent("CHAT_DATA",_chatData));
      }
      
      public function commit() : void
      {
         dispatchEvent(new VehicleEvent("playerInfoChange",this));
      }
      
      public function getBuffList() : Dictionary
      {
         var _loc1_:Dictionary = new Dictionary();
         for each(var _loc2_:VehicleBufferDamageInfo in buffList)
         {
            _loc1_[_loc2_.id] = _loc2_.buffId;
         }
         return _loc1_;
      }
      
      public function getBufferById(param1:int) : VehicleBufferDamageInfo
      {
         return buffList[param1];
      }
      
      public function checkBuff(param1:int) : Boolean
      {
         for each(var _loc2_:VehicleBufferDamageInfo in buffList)
         {
            if(_loc2_.buffId == param1)
            {
               return true;
            }
         }
         return false;
      }
      
      public function changeHp(param1:HurtData) : void
      {
         this.dispatchEvent(new VehicleEvent("SKILL_HURT",param1));
      }
      
      public function changeSpeed(param1:int) : void
      {
         this.speed = this.template.Speed + param1;
      }
      
      public function setStun(param1:Boolean) : void
      {
         isStun = param1;
      }
      
      public function changePercentSpeed(param1:int) : void
      {
         this.speed = this.template.Speed * (1 + param1 / 100);
      }
   }
}

