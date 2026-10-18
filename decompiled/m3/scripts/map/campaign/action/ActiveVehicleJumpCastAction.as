package map.campaign.action
{
   import events.ArmyEvent;
   import flash.events.MouseEvent;
   import flash.geom.Point;
   import map.campaign.CampaignManager;
   import map.campaign.CampaignMapController;
   import map.campaign.CampaignSocketOutManager;
   import map.campaign.data.CampaignArmy;
   import map.campaign.data.CampaignArmyState;
   import map.campaign.data.CampaignMapModel;
   import map.campaign.view.CampaignMapView;
   import map.campaign.view.physics.ActiveVehicleArmyView;
   import map.internals.constant.MapGlobal;
   import map.internals.data.CampaignNode;
   import yishi.actions.map.MapBaseAction;
   import yishi.interfaces.IAction;
   import yishi.keyboard.KeyBoardRegister;
   import yishi.manager.NotificationManager;
   import yishi.scene.SceneManager;
   
   public class ActiveVehicleJumpCastAction extends MapBaseAction
   {
      
      private var _shooter:ActiveVehicleArmyView;
      
      private var _skillId:int;
      
      private var _model:CampaignMapModel;
      
      private var _mapView:CampaignMapView;
      
      private var _controller:CampaignMapController;
      
      private var _attackArmyInfo:CampaignArmy;
      
      private var targetArmy:CampaignArmy;
      
      private var targetNode:CampaignNode;
      
      public function ActiveVehicleJumpCastAction(param1:ActiveVehicleArmyView, param2:int)
      {
         super();
         _shooter = param1;
         _attackArmyInfo = _shooter.data;
         _skillId = param2;
         _model = CampaignManager.instance.mapModel;
         _mapView = CampaignManager.instance.mapView;
         _controller = CampaignManager.instance.controller;
         KeyBoardRegister.instance.battleFlag = true;
      }
      
      override public function dispose() : void
      {
         if(_attackArmyInfo)
         {
            _attackArmyInfo.isJumping = false;
            _attackArmyInfo.removeEventListener("USE_JUMP_SKILL",__useSkillHandler);
            _attackArmyInfo = null;
         }
         _skillId = 0;
         _model = null;
         _mapView = null;
         _controller = null;
         _shooter = null;
         KeyBoardRegister.instance.battleFlag = false;
         super.dispose();
      }
      
      override public function prepare() : void
      {
         if(finished)
         {
            return;
         }
         _attackArmyInfo.addEventListener("USE_JUMP_SKILL",__useSkillHandler);
      }
      
      override public function set finished(param1:Boolean) : void
      {
         super.finished = param1;
      }
      
      override public function update() : void
      {
         if(_shooter.isDie)
         {
            finished = true;
            return;
         }
         if(CampaignArmyState.checkDied(_attackArmyInfo.isDie))
         {
            finished = true;
            return;
         }
         if(_attackArmyInfo.isStun)
         {
            finished = true;
            return;
         }
         if(SceneManager.instance.currentType != "CAMPAIGN_MAP_SCENE")
         {
            finished = true;
            return;
         }
         if(finished)
         {
            return;
         }
         startCast();
      }
      
      private function startCast() : void
      {
         sendUseSkill();
         startSkillCD();
         finished = true;
      }
      
      private function sendUseSkill() : void
      {
         if(finished)
         {
            return;
         }
         if(!_attackArmyInfo)
         {
            return;
         }
         _attackArmyInfo.isJumping = false;
         if(SceneManager.instance.currentType != "CAMPAIGN_MAP_SCENE")
         {
            return;
         }
         if(!MapGlobal.qtree)
         {
            return;
         }
         var _loc1_:Point = new Point(_shooter.x,_shooter.y);
         var _loc4_:Array = [];
         var _loc3_:Array = [];
         var _loc2_:Array = [];
         _loc4_.push(_shooter.data.userId);
         _loc3_.push(_shooter.data.baseHero.serviceName);
         CampaignSocketOutManager.instance.sendSnowBallCastSkill(_attackArmyInfo.userId,_attackArmyInfo.baseHero.serviceName,_skillId,_loc4_,_loc3_,_loc2_,_loc1_.x,_loc1_.y);
         trace("使用跳跃{invalid_utf8=230}{invalid_utf8=138}?能：：：：：{invalid_utf8=239}{invalid_utf8=188}?",_skillId);
      }
      
      private function startSkillCD() : void
      {
         if(_model && _attackArmyInfo == _model.selfMemberData)
         {
            NotificationManager.instance.sendNotification("MAP_USE_SKILL_CD",_skillId);
         }
      }
      
      private function __useSkillHandler(param1:ArmyEvent) : void
      {
         finished = true;
      }
      
      private function __onStageClickHandler(param1:MouseEvent) : void
      {
         param1.stopImmediatePropagation();
         param1.stopPropagation();
      }
      
      override public function get type() : String
      {
         return "ActiveVechicleJumpCastAction";
      }
      
      override public function filter(param1:IAction) : Boolean
      {
         if(param1 is ActiveVehicleJumpCastAction)
         {
            return true;
         }
         return false;
      }
   }
}

