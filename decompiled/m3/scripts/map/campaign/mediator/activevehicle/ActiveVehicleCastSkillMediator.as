package map.campaign.mediator.activevehicle
{
   import com.pickgliss.toplevel.StageReferance;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.display.Stage;
   import flash.events.Event;
   import flash.events.KeyboardEvent;
   import flash.events.MouseEvent;
   import flash.geom.Point;
   import flash.utils.Dictionary;
   import flash.utils.getTimer;
   import manager.LanguageMgr;
   import map.campaign.CampaignManager;
   import map.campaign.CampaignMapController;
   import map.campaign.action.ActiveVehicleCastAction;
   import map.campaign.action.ActiveVehicleJumpCastAction;
   import map.campaign.data.CampaignArmy;
   import map.campaign.data.CampaignMapModel;
   import map.campaign.view.physics.ActiveVehicleArmyView;
   import map.internals.constant.MapGlobal;
   import map.internals.event.OuterCityEvent;
   import yishi.datas.templates.VehicleSkillTempInfo;
   import yishi.events.NotificationEvent;
   import yishi.interfaces.IMediator;
   import yishi.manager.NotificationManager;
   import yishi.manager.TempleteManager;
   import yishi.view.tips.MessageTipManager;
   
   public class ActiveVehicleCastSkillMediator implements IMediator
   {
      
      private var stage:Stage;
      
      private var _selfView:ActiveVehicleArmyView;
      
      private var _armyData:CampaignArmy;
      
      private var _controller:CampaignMapController;
      
      private var _mapModel:CampaignMapModel;
      
      private var _groupMc:MovieClip;
      
      private var _effectLayer:Sprite;
      
      private var _castSkillId:int;
      
      private var _skillCd:Dictionary = new Dictionary(false);
      
      public function ActiveVehicleCastSkillMediator()
      {
         super();
      }
      
      public function register(param1:Object) : void
      {
         _controller = CampaignManager.instance.controller;
         _mapModel = CampaignManager.instance.mapModel;
         _effectLayer = CampaignManager.instance.mapView.skillLayer;
         _groupMc = ComponentFactory.Instance.creat("asset.vehiclemap.SkillCursor");
         _groupMc.mouseChildren = _groupMc.mouseEnabled = false;
         if(_mapModel.selfMemberData)
         {
            __init(null);
         }
         else
         {
            _mapModel.addEventListener("addGarrison",__init);
         }
      }
      
      public function unregister(param1:Object) : void
      {
         if(stage)
         {
            stage.removeEventListener("keyDown",__onKeyDown);
            stage.removeEventListener("mouseDown",__mouseDownHandler,true);
            stage.removeEventListener("mouseUp",__mouseUpHandler);
            stage.removeEventListener("enterFrame",__onEnterFrameHandler);
            stage.removeEventListener("click",__stageClickHandler,true);
         }
         if(_mapModel)
         {
            _mapModel.removeEventListener("addGarrison",__init);
         }
         NotificationManager.instance.removeEventListener("MAP_USE_SKILL",__useSkillHandler);
         NotificationManager.instance.removeEventListener("MAP_USE_SKILL_CD",__startCDHandler);
         ObjectUtils.disposeObject(_groupMc);
         _groupMc = null;
         _controller = null;
         _selfView = null;
         _mapModel = null;
         _armyData = null;
         stage = null;
         _effectLayer = null;
         for(var _loc2_:String in _skillCd)
         {
            delete _skillCd[_loc2_];
         }
         _skillCd = null;
      }
      
      private function __init(param1:OuterCityEvent) : void
      {
         if(_mapModel.selfMemberData)
         {
            _armyData = _mapModel.selfMemberData;
            _selfView = _controller.getArmyView(_armyData) as ActiveVehicleArmyView;
            stage = StageReferance.stage;
            stage.addEventListener("keyDown",__onKeyDown);
            _mapModel.removeEventListener("addGarrison",__init);
            NotificationManager.instance.addEventListener("MAP_USE_SKILL",__useSkillHandler);
            NotificationManager.instance.addEventListener("MAP_USE_SKILL_CD",__startCDHandler);
         }
      }
      
      private function __startCDHandler(param1:NotificationEvent) : void
      {
         var _loc2_:int = int(param1.data);
         if(_skillCd)
         {
            _skillCd[_loc2_] = getTimer();
         }
      }
      
      private function __useSkillHandler(param1:NotificationEvent) : void
      {
         var _loc2_:VehicleSkillTempInfo = param1.data as VehicleSkillTempInfo;
         if(_loc2_.InjuryEffect == MapGlobal.STUN_AVOID)
         {
            createChageBodyAction(_loc2_.TemplateId);
         }
         else
         {
            createCastAction(_loc2_.TemplateId);
         }
      }
      
      private function __onKeyDown(param1:KeyboardEvent) : void
      {
         if(_armyData.isStun)
         {
            return;
         }
         if(!_armyData.activeVehicleTempInfo)
         {
            return;
         }
         var _loc5_:int = int(_armyData.activeVehicleTempInfo.NormalSkill);
         var _loc4_:int = int(_armyData.activeVehicleSkillIdW);
         var _loc3_:int = int(_armyData.activeVehicleSkillIdE);
         var _loc2_:int = int(_armyData.activeVehicleSkillIdSpace);
         if(param1.keyCode == 81)
         {
            createCastAction(_loc5_);
         }
         else if(param1.keyCode == 87)
         {
            createCastAction(_loc4_);
         }
         else if(param1.keyCode == 69)
         {
            createCastAction(_loc3_);
         }
         else if(param1.keyCode == 32)
         {
            createJumpCastAction(_loc2_);
         }
         else if(param1.keyCode == 27)
         {
            cancel();
         }
      }
      
      private function createChageBodyAction(param1:int) : void
      {
         var _loc2_:VehicleSkillTempInfo = TempleteManager.instance.vehicleSkillTempteCate.getTemplateByTid(param1);
         if(!_loc2_)
         {
            return;
         }
         if(_armyData.isJumping)
         {
            return;
         }
         if(_armyData.isStun)
         {
            return;
         }
         if(isCDing(_loc2_))
         {
            return;
         }
         if(_castSkillId != 0)
         {
            return;
         }
         if(_loc2_.InjuryEffect == MapGlobal.STUN_AVOID)
         {
            changeBodyHandler(_loc2_);
         }
      }
      
      private function createJumpCastAction(param1:int) : void
      {
         var _loc2_:VehicleSkillTempInfo = TempleteManager.instance.vehicleSkillTempteCate.getTemplateByTid(param1);
         if(!_loc2_)
         {
            return;
         }
         if(_armyData.isJumping)
         {
            return;
         }
         if(_armyData.isStun)
         {
            return;
         }
         if(isCDing(_loc2_))
         {
            return;
         }
         if(_castSkillId != 0)
         {
            return;
         }
         if(_loc2_.InjuryEffect == 0)
         {
            jumpHandler(_loc2_);
         }
      }
      
      private function createCastAction(param1:int) : void
      {
         var _loc2_:VehicleSkillTempInfo = TempleteManager.instance.vehicleSkillTempteCate.getTemplateByTid(param1);
         if(!_loc2_)
         {
            return;
         }
         if(_armyData.isJumping)
         {
            return;
         }
         if(_armyData.isCasting)
         {
            return;
         }
         if(_armyData.isStun)
         {
            return;
         }
         if(isCDing(_loc2_))
         {
            return;
         }
         if(_castSkillId != 0)
         {
            return;
         }
         if(_loc2_.InjuryEffect == 0)
         {
            monomerHandler(_loc2_,_selfView);
         }
         if(_loc2_.InjuryEffect == 1)
         {
            monomerHandler(_loc2_,_controller.curSelectedObject);
         }
         else if(_loc2_.InjuryEffect == 2 || _loc2_.InjuryEffect == 4)
         {
            groupHandler(_loc2_);
         }
      }
      
      private function isCDing(param1:VehicleSkillTempInfo) : Boolean
      {
         var _loc2_:int = getTimer();
         var _loc3_:int = int(_skillCd[param1.TemplateId]);
         return _loc2_ - _loc3_ < param1.CoolDown;
      }
      
      private function jumpHandler(param1:VehicleSkillTempInfo) : void
      {
         var _loc3_:ActiveVehicleJumpCastAction = null;
         var _loc2_:String = null;
         if(_controller.checkCanCastSkillTo(_selfView))
         {
            _loc3_ = new ActiveVehicleJumpCastAction(_selfView,param1.TemplateId);
            _selfView.addAction(_loc3_);
         }
         else
         {
            _loc2_ = LanguageMgr.GetTranslation("castSkillMediator.noTarget");
            MessageTipManager.instance().show(_loc2_);
         }
      }
      
      private function changeBodyHandler(param1:VehicleSkillTempInfo) : void
      {
         var _loc3_:ActiveVehicleJumpCastAction = null;
         var _loc2_:String = null;
         if(_controller.checkCanCastSkillTo(_selfView))
         {
            _loc3_ = new ActiveVehicleJumpCastAction(_selfView,param1.TemplateId);
            _selfView.addAction(_loc3_);
         }
         else if(_armyData.activeCurHp <= 0)
         {
            _loc2_ = LanguageMgr.GetTranslation("snowball.dieTip");
            MessageTipManager.instance().show(_loc2_);
         }
         else
         {
            _loc2_ = LanguageMgr.GetTranslation("castSkillMediator.noTarget");
            MessageTipManager.instance().show(_loc2_);
         }
      }
      
      private function monomerHandler(param1:VehicleSkillTempInfo, param2:Object) : void
      {
         var _loc5_:ActiveVehicleArmyView = null;
         var _loc4_:ActiveVehicleCastAction = null;
         var _loc3_:String = null;
         if(!_controller.checkCanCastSkillTo(param2))
         {
            param2 = _controller.findNearEnemySteel();
            _controller.curSelectedObject = param2 as Sprite;
         }
         if(_controller.checkCanCastSkillTo(param2))
         {
            if(param2 is ActiveVehicleArmyView)
            {
               _loc5_ = param2 as ActiveVehicleArmyView;
               if(_loc5_.data && _loc5_.data.inProtectTime())
               {
                  _loc3_ = LanguageMgr.GetTranslation("map.outercity.view.mapphysics.MapPhysicsCastle.command03");
                  MessageTipManager.instance().show(_loc3_);
                  return;
               }
            }
            _loc4_ = new ActiveVehicleCastAction(_selfView,param1.TemplateId,param2);
            _selfView.addAction(_loc4_);
         }
         else
         {
            _loc3_ = LanguageMgr.GetTranslation("castSkillMediator.noTarget");
            MessageTipManager.instance().show(_loc3_);
         }
      }
      
      private function groupHandler(param1:VehicleSkillTempInfo) : void
      {
         stage.addEventListener("mouseDown",__mouseDownHandler,true,10000);
         stage.addEventListener("mouseUp",__mouseUpHandler);
         stage.addEventListener("enterFrame",__onEnterFrameHandler);
         stage.addEventListener("click",__stageClickHandler,true,10000);
         _castSkillId = param1.TemplateId;
         _effectLayer.addChildAt(_groupMc,0);
         var _loc2_:Number = param1.DamageCoverage * 2 / 500;
         _groupMc.scaleX = _groupMc.scaleY = _loc2_;
      }
      
      private function __mouseDownHandler(param1:MouseEvent) : void
      {
         param1.stopPropagation();
      }
      
      private function __onEnterFrameHandler(param1:Event) : void
      {
         if(_groupMc && _effectLayer)
         {
            _groupMc.x = _effectLayer.mouseX;
            _groupMc.y = _effectLayer.mouseY;
         }
      }
      
      private function __mouseUpHandler(param1:MouseEvent) : void
      {
         stage.removeEventListener("mouseDown",__mouseDownHandler,true);
         stage.removeEventListener("mouseUp",__mouseUpHandler);
         stage.removeEventListener("enterFrame",__onEnterFrameHandler);
         var _loc3_:Point = new Point(_effectLayer.mouseX,_effectLayer.mouseY);
         var _loc2_:ActiveVehicleCastAction = new ActiveVehicleCastAction(_selfView,_castSkillId,_loc3_);
         _selfView.addAction(_loc2_);
         if(_groupMc && _groupMc.parent)
         {
            _groupMc.parent.removeChild(_groupMc);
         }
         _castSkillId = 0;
      }
      
      private function __stageClickHandler(param1:MouseEvent) : void
      {
         stage.removeEventListener("click",__stageClickHandler,true);
         param1.stopImmediatePropagation();
      }
      
      private function cancel() : void
      {
         _armyData.breakup();
         if(_groupMc && _groupMc.parent)
         {
            _groupMc.parent.removeChild(_groupMc);
         }
         _castSkillId = 0;
         stage.removeEventListener("mouseUp",__mouseUpHandler);
         stage.removeEventListener("enterFrame",__onEnterFrameHandler);
         stage.removeEventListener("click",__stageClickHandler,true);
      }
   }
}

