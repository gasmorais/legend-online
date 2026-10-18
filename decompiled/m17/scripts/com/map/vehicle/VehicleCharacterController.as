package com.map.vehicle
{
   import com.map.vehicle.data.PlayerVehicleInfo;
   import com.map.vehicle.data.SkillCastInfo;
   import com.map.vehicle.data.VGlobal;
   import com.map.vehicle.data.VehicleSkillInfo;
   import com.map.vehicle.events.VehicleEvent;
   import com.map.vehicle.objects.TankAvatarView;
   import com.map.vehicle.objects.VehicleBoxView;
   import com.pickgliss.toplevel.StageReferance;
   import com.road.mapengine.bitmap.logic.BitmapSimpleLogic;
   import flash.display.Stage;
   import flash.events.KeyboardEvent;
   import flash.events.MouseEvent;
   import flash.utils.getTimer;
   import manager.LanguageMgr;
   import yishi.datas.templates.VehicleSkillTempInfo;
   import yishi.manager.CursorManagerII;
   import yishi.view.tips.MessageTipManager;
   
   public class VehicleCharacterController
   {
      
      public var isSelection:Boolean = false;
      
      public var scale:Number = 1;
      
      private var _currentSkill:VehicleSkillTempInfo;
      
      private var _currentSkillInfo:VehicleSkillInfo;
      
      private var _listnerSetuped:Boolean = false;
      
      private var _logicWrold:VehicleView;
      
      private var _model:VehicleModel;
      
      private var _vehicleinfo:PlayerVehicleInfo;
      
      public function VehicleCharacterController(param1:VehicleView, param2:VehicleModel)
      {
         super();
         _logicWrold = param1;
         _model = param2;
         if(!_model.selfVehicleInfo)
         {
            _model.addEventListener("addPlayer",__addPlayerHandler);
         }
         else
         {
            _vehicleinfo = _model.selfVehicleInfo;
            addEvent();
         }
      }
      
      public function cancel() : void
      {
         _currentSkill = null;
         isSelection = false;
      }
      
      public function dispose() : void
      {
         removeEvent();
         _model = null;
         _logicWrold = null;
      }
      
      public function keyDownHandler(param1:uint) : void
      {
         var _loc3_:String = null;
         var _loc6_:TankAvatarView = null;
         var _loc9_:BitmapSimpleLogic = null;
         var _loc5_:BitmapSimpleLogic = null;
         var _loc2_:Number = getTimer();
         CursorManagerII.instance.resetCursor();
         var _loc8_:VehicleSkillInfo = _model.skillBag.getSkillByKey(param1);
         if(!_loc8_)
         {
            return;
         }
         if(!_loc8_.tempalte)
         {
            return;
         }
         if(!_vehicleinfo)
         {
            return;
         }
         if(_vehicleinfo.isStun)
         {
            return;
         }
         if(_loc2_ - _loc8_.lastTime < _loc8_.tempalte.CoolDown)
         {
            return;
         }
         if(_model.remainsTime <= 0)
         {
            return;
         }
         if(_loc8_.tempalte.Maximum > 0 && _loc8_.count <= 0)
         {
            return;
         }
         if(_vehicleinfo.hp <= 0)
         {
            _loc3_ = LanguageMgr.GetTranslation("vehicle.noattack");
            MessageTipManager.instance().show(_loc3_);
            return;
         }
         if(_vehicleinfo.isCasting)
         {
            return;
         }
         _currentSkill = null;
         var _loc4_:VehicleSkillTempInfo = _loc8_.tempalte;
         var _loc7_:SkillCastInfo = new SkillCastInfo();
         if(_loc4_.InjuryEffect == 1)
         {
            _loc9_ = _logicWrold.getClicker();
            if(_loc9_ is VehicleBoxView)
            {
               return;
            }
            if(_loc9_)
            {
               if(_loc8_.tempalte.IFF == 1)
               {
                  if(_loc9_ is TankAvatarView)
                  {
                     _loc6_ = _loc9_ as TankAvatarView;
                     if(_loc6_.isFriend)
                     {
                        return;
                     }
                     if(_loc6_.data.hp <= 0)
                     {
                        _loc3_ = LanguageMgr.GetTranslation("vehicle.attackTipDie");
                        MessageTipManager.instance().show(_loc3_);
                        _logicWrold.selectedLogic = null;
                        return;
                     }
                     if(_loc6_.data.checkBuff(4))
                     {
                        return;
                     }
                  }
               }
               else if(_loc8_.tempalte.IFF == 2)
               {
                  if(!(_loc9_ is TankAvatarView))
                  {
                     return;
                  }
                  _loc6_ = _loc9_ as TankAvatarView;
                  if(!_loc6_.isFriend)
                  {
                     return;
                  }
               }
               _loc7_.skillid = _loc4_.TemplateId;
               _loc7_.target = _loc9_;
               _loc7_.castPos = null;
               _vehicleinfo.cast(_loc7_);
            }
            else
            {
               if(_loc4_.InjuryEffect != 0)
               {
                  if(_loc8_.tempalte.IFF == 1)
                  {
                     _loc5_ = VGlobal.logicWorld.findNearEnemy();
                     if(_loc5_)
                     {
                        _loc7_.skillid = _loc4_.TemplateId;
                        _loc7_.target = _loc5_;
                        _loc7_.castPos = null;
                        _vehicleinfo.cast(_loc7_);
                        VGlobal.logicWorld.selectedLogic = _loc5_;
                     }
                  }
                  return;
               }
               _loc7_.skillid = _loc4_.TemplateId;
               _loc7_.target = _vehicleinfo.logicView;
               _loc7_.castPos = null;
               _vehicleinfo.cast(_loc7_);
            }
         }
         else if(_loc4_.InjuryEffect == 2 || _loc4_.InjuryEffect == 4)
         {
            _currentSkill = _loc4_;
            StageReferance.stage.addEventListener("mouseUp",__mouseDownHandler);
            isSelection = true;
            scale = _loc4_.DamageCoverage * 2 / 500;
         }
         _currentSkillInfo = _loc8_;
      }
      
      private function __addPlayerHandler(param1:VehicleEvent) : void
      {
         if(param1.data == _model.selfVehicleInfo)
         {
            _vehicleinfo = _model.selfVehicleInfo;
            _model.removeEventListener("addPlayer",__addPlayerHandler);
            addEvent();
         }
      }
      
      private function __changeSkillHandler(param1:VehicleEvent) : void
      {
         if(_currentSkill)
         {
            StageReferance.stage.removeEventListener("mouseUp",__mouseDownHandler);
            if(_currentSkill.TemplateId != (param1.data as VehicleSkillInfo).templateId)
            {
               _currentSkill = null;
               isSelection = false;
               scale = 1;
            }
         }
      }
      
      private function __selfDieHandler(param1:VehicleEvent) : void
      {
         StageReferance.stage.removeEventListener("mouseUp",__mouseDownHandler);
         isSelection = false;
         _currentSkill = null;
         scale = 1;
      }
      
      private function __mouseDownHandler(param1:MouseEvent) : void
      {
         var _loc2_:Number = getTimer();
         StageReferance.stage.removeEventListener("mouseUp",__mouseDownHandler);
         isSelection = false;
         if(!_currentSkill)
         {
            return;
         }
         if(!_currentSkillInfo)
         {
            return;
         }
         if(!_currentSkillInfo.tempalte)
         {
            return;
         }
         if(_loc2_ - _currentSkillInfo.lastTime < _currentSkillInfo.tempalte.CoolDown)
         {
            return;
         }
         CursorManagerII.instance.resetCursor();
         var _loc3_:SkillCastInfo = new SkillCastInfo();
         _loc3_.skillid = _currentSkill.TemplateId;
         _loc3_.target = null;
         _loc3_.castPos = _logicWrold.getMouesPos();
         _vehicleinfo.cast(_loc3_);
         _currentSkill = null;
      }
      
      private function __onClick(param1:MouseEvent) : void
      {
      }
      
      private function __onKeyDown(param1:KeyboardEvent) : void
      {
         var _loc2_:int = 0;
         switch(param1.keyCode)
         {
            case 49:
            case 50:
            case 81:
               if(isSelection)
               {
                  return;
               }
               keyDownHandler(param1.keyCode);
               break;
            case 27:
               cancel();
               break;
            default:
               return;
         }
      }
      
      private function __onKeyUp(param1:KeyboardEvent) : void
      {
      }
      
      private function addEvent() : void
      {
         if(_listnerSetuped)
         {
            return;
         }
         var _loc1_:Stage = StageReferance.stage;
         _loc1_.addEventListener("keyDown",__onKeyDown);
         _loc1_.addEventListener("keyUp",__onKeyUp);
         _loc1_.addEventListener("click",__onClick);
         _model.skillBag.addEventListener("CHANGE_SKILL",__changeSkillHandler);
         _vehicleinfo.addEventListener("DIE",__selfDieHandler);
         _listnerSetuped = true;
      }
      
      private function removeEvent() : void
      {
         var _loc1_:Stage = StageReferance.stage;
         _loc1_.removeEventListener("keyDown",__onKeyDown);
         _loc1_.removeEventListener("keyUp",__onKeyUp);
         _loc1_.removeEventListener("click",__onClick);
         if(_model && _model.skillBag)
         {
            _model.skillBag.removeEventListener("CHANGE_SKILL",__changeSkillHandler);
         }
         if(_vehicleinfo)
         {
            _vehicleinfo.removeEventListener("DIE",__selfDieHandler);
         }
         StageReferance.stage.removeEventListener("mouseUp",__mouseDownHandler);
         _listnerSetuped = false;
      }
   }
}

