package map.campaign.mediator.unrealshooting
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
   import map.campaign.action.UnrealShootingCastAction;
   import map.campaign.action.UnrealShootingJumpCastAction;
   import map.campaign.data.CampaignArmy;
   import map.campaign.data.CampaignMapModel;
   import map.campaign.view.physics.UnrealShootingArmyView;
   import map.internals.event.OuterCityEvent;
   import yishi.datas.templates.VehicleSkillTempInfo;
   import yishi.events.NotificationEvent;
   import yishi.interfaces.IMediator;
   import yishi.manager.NotificationManager;
   import yishi.manager.TempleteManager;
   import yishi.view.tips.MessageTipManager;
   
   public class UnrealShootingCastSkillMediator implements IMediator
   {
      
      private var stage:Stage;
      
      private var _selfView:UnrealShootingArmyView;
      
      private var _armyData:CampaignArmy;
      
      private var _controller:CampaignMapController;
      
      private var _mapModel:CampaignMapModel;
      
      private var _groupMc:MovieClip;
      
      private var _skillFlyLayer:Sprite;
      
      private var _castSkillId:int;
      
      private var _skillCd:Dictionary = new Dictionary(false);
      
      public function UnrealShootingCastSkillMediator()
      {
         super();
      }
      
      public function register(param1:Object) : void
      {
         _controller = CampaignManager.instance.controller;
         _mapModel = CampaignManager.instance.mapModel;
         _skillFlyLayer = CampaignManager.instance.mapView.skillLayer;
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
         _skillFlyLayer = null;
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
            _selfView = _controller.getArmyView(_armyData) as UnrealShootingArmyView;
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
         createCastAction(_loc2_.TemplateId);
      }
      
      private function __onKeyDown(param1:KeyboardEvent) : void
      {
         if(_armyData.isStun)
         {
            return;
         }
         if(!_armyData.unrealShootingVehicleTempInfo)
         {
            return;
         }
         var _loc5_:int = int(_armyData.unrealShootingVehicleTempInfo.NormalSkill);
         var _loc4_:int = int(_armyData.unrealShootingVehicleSkillIdW);
         var _loc3_:int = int(_armyData.unrealShootingVehicleSkillIdE);
         var _loc2_:int = int(_armyData.unrealShootingVehicleSkillIdSpace);
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
         else if(_loc2_.InjuryEffect == 1)
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
         var _loc3_:UnrealShootingJumpCastAction = null;
         var _loc2_:String = null;
         if(_controller.checkCanCastSkillTo(_selfView))
         {
            _loc3_ = new UnrealShootingJumpCastAction(_selfView,param1.TemplateId);
            _selfView.addAction(_loc3_);
         }
         else
         {
            _loc2_ = LanguageMgr.GetTranslation("castSkillMediator.noTarget");
            MessageTipManager.instance().show(_loc2_);
         }
      }
      
      private function monomerHandler(param1:VehicleSkillTempInfo, param2:Object) : void
      {
         var _loc4_:UnrealShootingCastAction = null;
         var _loc3_:String = null;
         if(!_controller.checkCanCastSkillTo(param2))
         {
            param2 = _controller.findNearEnemyUnrealShooting();
            _controller.curSelectedObject = param2 as Sprite;
         }
         if(_controller.checkCanCastSkillTo(param2))
         {
            _loc4_ = new UnrealShootingCastAction(_selfView,param1.TemplateId,param2);
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
         _skillFlyLayer.addChildAt(_groupMc,0);
         var _loc2_:Number = param1.DamageCoverage * 2 / 500;
         _groupMc.scaleX = _groupMc.scaleY = _loc2_;
      }
      
      private function __mouseDownHandler(param1:MouseEvent) : void
      {
         param1.stopPropagation();
      }
      
      private function __onEnterFrameHandler(param1:Event) : void
      {
         if(_groupMc && _skillFlyLayer)
         {
            _groupMc.x = _skillFlyLayer.mouseX;
            _groupMc.y = _skillFlyLayer.mouseY;
         }
      }
      
      private function __mouseUpHandler(param1:MouseEvent) : void
      {
         stage.removeEventListener("mouseDown",__mouseDownHandler,true);
         stage.removeEventListener("mouseUp",__mouseUpHandler);
         stage.removeEventListener("enterFrame",__onEnterFrameHandler);
         var _loc3_:Point = new Point(_skillFlyLayer.mouseX,_skillFlyLayer.mouseY);
         var _loc2_:UnrealShootingCastAction = new UnrealShootingCastAction(_selfView,_castSkillId,_loc3_);
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

