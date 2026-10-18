package map.campaign.view.physics
{
   import avatar.view.HeroAvatar;
   import com.pickgliss.loader.ResourceDomain;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.geom.Point;
   import flash.geom.Rectangle;
   import map.campaign.CampaignManager;
   import map.campaign.CampaignMapController;
   import map.campaign.action.ActiveVehicleNpcDannyAction;
   import map.campaign.action.UnrealShootingShootAction;
   import map.campaign.data.CampaignMapModel;
   import map.campaign.data.skill.MapBuffHurtData;
   import map.campaign.data.skill.MapSkillResultInfo;
   import map.campaign.helper.gvgcross.GvgCrossResourceManager;
   import map.campaign.helper.hero.CampaignArmyViewHelper;
   import map.campaign.view.CampaignMapView;
   import map.internals.data.CampaignNode;
   import map.internals.data.MapPhysics;
   import map.internals.data.PhysicsEvent;
   import yishi.datas.templates.VehicleObjectTempInfo;
   import yishi.interfaces.IAction;
   import yishi.manager.ActionQueueManager;
   import yishi.manager.PathManager;
   import yishi.manager.TempleteManager;
   import yishi.utils.AsynActionManager;
   
   public class ActiveVehicleNpcAvater extends NpcAvatarView
   {
      
      public static var STAND:String = "Stand";
      
      public static var WALK:String = "Walk";
      
      public static var ATTACK:String = "Attack";
      
      public static var JUMP:String = "Jump";
      
      private var _actionQueue:ActionQueueManager;
      
      private var _asynActionMgr:AsynActionManager;
      
      private var _tank:MovieClip;
      
      private var _effectLayer:Sprite;
      
      private var resDomain:ResourceDomain;
      
      public var activeVehicleTempInfo:VehicleObjectTempInfo;
      
      private var _mapView:CampaignMapView;
      
      private var _controller:CampaignMapController;
      
      private var _mapModel:CampaignMapModel;
      
      private var frameY:int;
      
      private var mirror:int;
      
      public var isAttack:Boolean;
      
      public var isJump:Boolean;
      
      private var labelType:String;
      
      private var lastLabelType:String;
      
      public var isTank:Boolean;
      
      private var _posHead:Point = null;
      
      public function ActiveVehicleNpcAvater(param1:String, param2:String, param3:int, param4:int)
      {
         super(param1,param2,param3,param4);
         _mapView = CampaignManager.instance.mapView;
         _controller = CampaignManager.instance.controller;
         _mapModel = CampaignManager.instance.mapModel;
         _actionQueue = new ActionQueueManager();
         _asynActionMgr = new AsynActionManager();
      }
      
      override public function execute() : void
      {
         if(_actionQueue)
         {
            _actionQueue.update();
         }
         if(_asynActionMgr)
         {
            _asynActionMgr.update();
         }
         super.execute();
      }
      
      override protected function setNameColor() : void
      {
         var _loc1_:CampaignNode = _nodeInfo as CampaignNode;
         _npcName.setFrame(5);
      }
      
      public function addAction(param1:IAction, param2:Boolean = false) : void
      {
         if(!_actionQueue || !_asynActionMgr)
         {
            return;
         }
         if(param2)
         {
            _asynActionMgr.addAction(param1);
         }
         else
         {
            _actionQueue.addAction(param1);
         }
      }
      
      public function playAttackAction() : void
      {
         if(!_tank)
         {
            return;
         }
         _tank.gotoAndPlay(ATTACK + (frameY + 1));
      }
      
      override public function updateDirection(param1:Number) : void
      {
         super.updateDirection(param1);
         frameY = CampaignArmyViewHelper.calcFrameY(param1);
         mirror = CampaignArmyViewHelper.calcMirror(param1);
         if(_tank)
         {
            _tank.scaleX = mirror;
            playTankBody();
         }
      }
      
      public function changeBodyState() : void
      {
         if(_tank)
         {
            playTankBody();
         }
      }
      
      private function playTankBody() : void
      {
         var _loc1_:String = null;
         if(!_tank)
         {
            return;
         }
         if(isJump)
         {
            labelType = JUMP;
            _loc1_ = JUMP + (frameY + 1);
         }
         else if(isAttack)
         {
            labelType = ATTACK;
            _loc1_ = ATTACK + (frameY + 1);
         }
         else if(isStand)
         {
            labelType = STAND;
            _loc1_ = STAND + (frameY + 1);
         }
         else
         {
            labelType = WALK;
            _loc1_ = WALK + (frameY + 1);
         }
         if(_loc1_ != _tank.currentLabel)
         {
            if(labelType == JUMP && labelType == lastLabelType)
            {
               return;
            }
            _tank.gotoAndPlay(_loc1_);
         }
         lastLabelType = labelType;
      }
      
      override protected function walkOver() : void
      {
         super.walkOver();
         playTankBody();
      }
      
      override public function set nodeInfo(param1:MapPhysics) : void
      {
         var _loc2_:CampaignNode = null;
         super.nodeInfo = param1 as CampaignNode;
         if(param1)
         {
            resDomain = GvgCrossResourceManager.instance.domain;
            activeVehicleTempInfo = TempleteManager.instance.vehicleObjectTempInfoCate.getTemplateByIndex((nodeInfo as CampaignNode).sonType);
            _loc2_ = param1 as CampaignNode;
            if(_loc2_ && activeVehicleTempInfo)
            {
               _loc2_.totalHp = activeVehicleTempInfo.Hp;
            }
         }
         __updateCurHpHandler(null);
         if(nodeInfo.info.types == 99998)
         {
            if(!_effectLayer)
            {
               _effectLayer = new Sprite();
               _effectLayer.mouseChildren = _effectLayer.mouseEnabled = false;
               addChild(_effectLayer);
            }
            enterTank();
         }
      }
      
      private function enterTank() : void
      {
         changeBody(true);
      }
      
      public function changeBody(param1:Boolean = true) : void
      {
         var _loc2_:String = null;
         isTank = param1;
         if(param1)
         {
            if(!_tank && activeVehicleTempInfo != null)
            {
               _loc2_ = PathManager.getVehicleAvatarPath(activeVehicleTempInfo.Avatar);
               resDomain.load(_loc2_,false,__onLoaded);
            }
            else
            {
               if(_tank)
               {
                  addChildAt(_tank,1);
               }
               if(avatarView)
               {
                  avatarView.isRending = false;
               }
            }
         }
         else
         {
            if(avatarView)
            {
               avatarView.isRending = true;
            }
            ObjectUtils.disposeObject(_tank);
            _tank = null;
            resDomain.removeCallBackFunction(__onLoaded);
         }
      }
      
      override protected function addEvent() : void
      {
         super.addEvent();
         if(_nodeInfo)
         {
            _nodeInfo.addEventListener("DANNAY",__onDannyHandler);
            _nodeInfo.addEventListener("ADD_BUFF",__onAddBuffHandler);
            _nodeInfo.addEventListener("USE_SKILL",__onUseSkillHandler);
         }
      }
      
      override protected function removeEvent() : void
      {
         if(_nodeInfo)
         {
            _nodeInfo.removeEventListener("DANNAY",__onDannyHandler);
            _nodeInfo.removeEventListener("ADD_BUFF",__onAddBuffHandler);
            _nodeInfo.removeEventListener("USE_SKILL",__onUseSkillHandler);
         }
         super.removeEvent();
      }
      
      private function __onDannyHandler(param1:PhysicsEvent) : void
      {
         var _loc3_:MapBuffHurtData = param1.data as MapBuffHurtData;
         var _loc2_:ActiveVehicleNpcDannyAction = new ActiveVehicleNpcDannyAction(_nodeInfo as CampaignNode,_loc3_);
         addAction(_loc2_,true);
      }
      
      private function __onAddBuffHandler(param1:PhysicsEvent) : void
      {
         var _loc3_:MapBuffHurtData = param1.data as MapBuffHurtData;
         var _loc2_:ActiveVehicleNpcDannyAction = new ActiveVehicleNpcDannyAction(_nodeInfo as CampaignNode,_loc3_);
         addAction(_loc2_,true);
      }
      
      private function __onUseSkillHandler(param1:PhysicsEvent) : void
      {
         var _loc2_:UnrealShootingShootAction = new UnrealShootingShootAction(_nodeInfo,param1.data as MapSkillResultInfo);
         addAction(_loc2_);
      }
      
      override protected function __updateNodeStateHandler(param1:PhysicsEvent) : void
      {
         super.__updateNodeStateHandler(param1);
         if(_controller.curSelectedObject == this && _nodeInfo.info.state != 1)
         {
            _controller.curSelectedObject = null;
         }
         if(_nodeInfo.info.state == 8)
         {
            dispose();
         }
      }
      
      private function __onLoaded() : void
      {
         if(isDie || activeVehicleTempInfo == null)
         {
            return;
         }
         var _loc3_:String = activeVehicleTempInfo.Avatar.substr(1);
         var _loc1_:String = "asset.avatar." + _loc3_;
         var _loc2_:int = 1;
         _tank = resDomain.createInstane(_loc1_) as MovieClip;
         if(getChildAt(0) == null)
         {
            _loc2_ = 0;
         }
         if(_tank)
         {
            addChildAt(_tank,_loc2_);
         }
         if(avatarView)
         {
            (avatarView as HeroAvatar).removeDefaultMovie();
            avatarView.isRending = false;
         }
         refreshNamePos();
      }
      
      override protected function layouTextView(param1:String) : void
      {
         super.layouTextView(param1);
         refreshNamePos();
      }
      
      override protected function __updateCurHpHandler(param1:PhysicsEvent) : void
      {
         super.__updateCurHpHandler(param1);
         refreshNamePos();
      }
      
      private function refreshNamePos() : void
      {
         var _loc1_:Point = getHeadPoint();
         if(!_loc1_)
         {
            return;
         }
         if(_npcName)
         {
            _npcName.y = _loc1_.y - 30;
         }
         if(_bloodMc)
         {
            _bloodMc.y = _loc1_.y;
         }
      }
      
      public function changeDirectionTo(param1:int, param2:int) : void
      {
         if(!_tank)
         {
            return;
         }
         var _loc3_:Number = param1 - x;
         var _loc4_:Number = param2 - y;
         var _loc5_:Number = Math.atan2(_loc4_,_loc3_);
         var _loc6_:int = _loc5_ * 180 / 3.141592653589793;
         if(_loc6_ < 0)
         {
            _loc6_ += 360;
         }
         updateDirection(_loc6_);
      }
      
      private function getHeadPoint() : Point
      {
         if(_posHead)
         {
            return _posHead;
         }
         if(_tank && _tank["pos_head"])
         {
            _posHead = new Point(0,0);
            _posHead.x += _tank.pos_head.x;
            _posHead.y += _tank.pos_head.y;
         }
         return _posHead;
      }
      
      public function getShootPoint() : Point
      {
         var _loc1_:Point = new Point(this.x,this.y);
         if(_tank && _tank["bombpos"])
         {
            _loc1_.x += _tank.bombpos.x * _tank.scaleX;
            _loc1_.y += _tank.bombpos.y;
         }
         return _loc1_;
      }
      
      public function getHitPoint() : Point
      {
         var _loc2_:Rectangle = null;
         var _loc1_:Point = new Point(this.x,this.y);
         if(_tank)
         {
            _loc2_ = _tank.getBounds(_tank);
            _loc1_.y = this.y + _loc2_.y + _loc2_.height * 0.5;
         }
         else
         {
            _loc1_.y -= 70;
         }
         return _loc1_;
      }
      
      override protected function getPosYBySizeType(param1:int, param2:int = 0) : int
      {
         return -150;
      }
      
      override public function attackFun() : Boolean
      {
         if(!_mapModel.mapTielsData)
         {
            return false;
         }
         CampaignManager.instance.mapModel.selectNode = null;
         _controller.curSelectedObject = this;
         return true;
      }
      
      override public function mouseClickHandler(param1:MouseEvent) : Boolean
      {
         if(mouseHitTest() && isAttackState)
         {
            return attackFun();
         }
         return false;
      }
      
      override public function mouseOverHandler(param1:MouseEvent) : Boolean
      {
         if(mouseHitTest() && isAttackState)
         {
            return true;
         }
         return false;
      }
      
      override public function mouseMoveHandler(param1:MouseEvent) : Boolean
      {
         if(mouseHitTest() && isAttackState)
         {
            return true;
         }
         return false;
      }
      
      override public function mouseOutHandler(param1:MouseEvent) : Boolean
      {
         if(mouseHitTest() && isAttackState)
         {
            return true;
         }
         return false;
      }
      
      private function get isAttackState() : Boolean
      {
         if(isFriend())
         {
            return false;
         }
         return true;
      }
      
      private function isFriend() : Boolean
      {
         return false;
      }
      
      override public function mouseHitTest() : Boolean
      {
         var _loc2_:Point = null;
         if(!mouseEnabled)
         {
            return false;
         }
         if(!parent)
         {
            return false;
         }
         var _loc1_:Sprite = this;
         if(_tank)
         {
            _loc1_ = _tank;
            _loc2_ = _loc1_.localToGlobal(new Point(_loc1_.mouseX,_loc1_.mouseY));
            return _loc1_.hitTestPoint(_loc2_.x,_loc2_.y,true);
         }
         return super.mouseHitTest();
      }
      
      public function get tank() : MovieClip
      {
         return _tank;
      }
      
      public function get effectLayer() : Sprite
      {
         return _effectLayer;
      }
      
      public function getHeadPos() : Point
      {
         var _loc2_:Point = new Point();
         var _loc1_:Point = getHeadPoint();
         if(_loc1_)
         {
            _loc2_.y = _loc1_.y - 50;
         }
         return _loc2_;
      }
      
      public function get body() : Sprite
      {
         return _tank;
      }
   }
}

