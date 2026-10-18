package map.campaign.view.physics
{
   import avatar.view.HeroAvatar;
   import com.greensock.TweenMax;
   import com.pickgliss.loader.ResourceDomain;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.container.HBox;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import events.ArmyEvent;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.geom.ColorTransform;
   import flash.geom.Point;
   import flash.geom.Rectangle;
   import flash.utils.clearTimeout;
   import manager.LanguageMgr;
   import map.campaign.CampaignManager;
   import map.campaign.CampaignMapController;
   import map.campaign.action.ActiveVehicleDannyAction;
   import map.campaign.action.ActiveVehicleJumpAction;
   import map.campaign.action.ActiveVehiclePickupAction;
   import map.campaign.action.ActiveVehicleShootAction;
   import map.campaign.data.CampaignArmy;
   import map.campaign.data.CampaignMapModel;
   import map.campaign.data.skill.MapBuffHurtData;
   import map.campaign.data.skill.MapSkillHurtData;
   import map.campaign.data.skill.MapSkillResultInfo;
   import map.campaign.event.CampaignMapEvent;
   import map.campaign.helper.gvgcross.GvgCrossResourceManager;
   import map.campaign.helper.hero.CampaignArmyViewHelper;
   import map.campaign.view.ui.activevehicle.ActiveVehicleChatPopView;
   import map.internals.data.ArmyChildrenInfo;
   import map.internals.data.ArmyPetInfo;
   import map.internals.data.CampaignNode;
   import map.internals.data.PhysicsEvent;
   import map.internals.interfaces.IBaseMouseEvent;
   import yishi.datas.templates.VehicleObjectTempInfo;
   import yishi.datas.templates.VehicleSkillBuffTemplate;
   import yishi.datas.templates.VehicleSkillTempInfo;
   import yishi.filter.UIFilter;
   import yishi.interfaces.IAction;
   import yishi.keyboard.KeyBoardRegister;
   import yishi.manager.ActionQueueManager;
   import yishi.manager.PathManager;
   import yishi.manager.TempleteManager;
   import yishi.utils.AsynActionManager;
   import yishi.utils.IconFactory;
   import yishi.view.community.BaseIconView;
   
   public class ActiveVehicleArmyView extends CampaignArmyView implements IBaseMouseEvent
   {
      
      private static var STAND:String = "Stand";
      
      private static var WALK:String = "Walk";
      
      private static var ATTACK:String = "Attack";
      
      public static var JUMP:String = "Jump";
      
      private var _actionQueue:ActionQueueManager;
      
      private var _asynActionMgr:AsynActionManager;
      
      private var _holdKeyView:MovieClip;
      
      private var _tank:MovieClip;
      
      private var _bloodBar:MovieClip;
      
      private var _bloodMask:MovieClip;
      
      private var _teamBlood:MovieClip;
      
      private var _bufferBlood:MovieClip;
      
      private var _resourceTxt:FilterFrameText;
      
      private var _effectLayer:Sprite;
      
      private var resDomain:ResourceDomain;
      
      private var _chatPopView:ActiveVehicleChatPopView;
      
      public var activeVechileTempInfo:VehicleObjectTempInfo;
      
      private var _hasHbox:HBox;
      
      public var isAttack:Boolean;
      
      public var isJump:Boolean;
      
      private var bodyState:int = 0;
      
      private var _delayId:int;
      
      private var _controller:CampaignMapController;
      
      private var _mapModel:CampaignMapModel;
      
      private var frameY:int;
      
      private var mirror:int;
      
      private var labelType:String;
      
      private var lastLabelType:String;
      
      private var _bloodTween:TweenMax;
      
      public function ActiveVehicleArmyView()
      {
         super();
         _controller = CampaignManager.instance.controller;
         _mapModel = CampaignManager.instance.mapModel;
         _actionQueue = new ActionQueueManager();
         _asynActionMgr = new AsynActionManager();
         this.mouseEnabled = true;
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
      
      public function cancelCastAction() : void
      {
         if(!_actionQueue)
         {
            return;
         }
         _actionQueue.cancelActionByType("ActiveVehicleCastAction");
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
      
      public function get tank() : MovieClip
      {
         return _tank;
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
      
      override public function set data(param1:CampaignArmy) : void
      {
         if(param1)
         {
            if(!_bloodBar)
            {
               _bloodBar = ComponentFactory.Instance.creat("asset.campaign.map.BloodAsset");
               _bloodBar.x = 0;
               _bloodMask = _bloodBar["bloodMc"] as MovieClip;
               _teamBlood = _bloodBar["teamBlood"] as MovieClip;
               _bufferBlood = _bloodBar.bufferBar;
               _bloodMask.gotoAndStop(1);
               _bufferBlood.gotoAndStop(1);
               _teamBlood.gotoAndStop(1);
               _bloodBar.addChildAt(_bufferBlood,1);
            }
            if(!_resourceTxt)
            {
               _resourceTxt = ComponentFactory.Instance.creatComponentByStylename("gvgarmyview.resourceTxt");
               _resourceTxt.x = -_resourceTxt.width * 0.5;
               _resourceTxt.htmlText = LanguageMgr.GetTranslation("gvgarmyview.ore",param1.oreNum);
               addChild(_resourceTxt);
            }
            if(!_effectLayer)
            {
               _effectLayer = new Sprite();
               _effectLayer.mouseChildren = _effectLayer.mouseEnabled = false;
               addChild(_effectLayer);
            }
            if(!_hasHbox)
            {
               _hasHbox = ComponentFactory.Instance.creatComponentByStylename("ActiveVehicleArmyView.hasHbox");
               addChild(_hasHbox);
            }
         }
         if(param1)
         {
            resDomain = GvgCrossResourceManager.instance.domain;
         }
         super.data = param1;
         var _loc2_:int = isBlueTeam() ? 1 : 5;
         if(isSelf)
         {
            _loc2_ = 3;
         }
         _npcName.setFrame(_loc2_);
         if(_vipText)
         {
            _vipText.visible = false;
         }
         if(_npcName)
         {
            _npcName.visible = true;
         }
         __onHoldKeyStateChangeHandler(null);
         if(data.activeVehicleTempInfo)
         {
            enterTank();
         }
         initBuff();
         __updateCurHpHandler(null);
      }
      
      private function checkPos() : void
      {
         if(_data == null)
         {
            return;
         }
         var _loc1_:int = _data.curPosX * 20;
         var _loc2_:int = _data.curPosY * 20;
         this.x = _loc1_;
         this.y = _loc2_;
      }
      
      override protected function __chatHandler(param1:PhysicsEvent) : void
      {
         if(_chatPopView)
         {
            _chatPopView.dispose();
         }
         _chatPopView = null;
         if(!_chatPopView)
         {
            _chatPopView = new ActiveVehicleChatPopView();
            _chatPopView.data = _data.chatData;
            _chatPopView.x = -_chatPopView.displayWidth / 2;
            _chatPopView.y = _npcName.y + 20 - _chatPopView.displayHeight;
            addChild(_chatPopView);
            addChild(_npcName);
         }
      }
      
      private function refreshArmyPos() : void
      {
         this.x = _data.curPosX * 20;
         this.y = _data.curPosY * 20;
      }
      
      override protected function showPet(param1:ArmyPetInfo) : void
      {
      }
      
      override protected function showChildren(param1:ArmyChildrenInfo) : void
      {
      }
      
      override protected function setHonerName() : void
      {
      }
      
      override protected function addFateSkillEffect() : void
      {
      }
      
      override protected function showInfoTxt() : void
      {
         setNpcName(0);
      }
      
      override protected function setNpcName(param1:int) : void
      {
         var _loc2_:int = isBlueTeam() ? 1 : 5;
         super.setNpcName(_loc2_);
         super.setConsortiaName(_loc2_);
         if(_vipText)
         {
            _vipText.visible = false;
         }
         if(_npcName)
         {
            _npcName.visible = true;
         }
      }
      
      private function isBlueTeam() : Boolean
      {
         return super.data.activeTeamId == 1;
      }
      
      public function mouseClickHandler(param1:MouseEvent) : Boolean
      {
         var _loc2_:CampaignArmy = CampaignManager.instance.mapModel.selfMemberData;
         if(mouseHitTest() && isAttackState)
         {
            CampaignManager.instance.mapModel.selectNode = null;
            _controller.curSelectedObject = this;
            return true;
         }
         return false;
      }
      
      public function mouseOverHandler(param1:MouseEvent) : Boolean
      {
         if(mouseHitTest() && isAttackState)
         {
            return true;
         }
         return false;
      }
      
      public function mouseOutHandler(param1:MouseEvent) : Boolean
      {
         if(mouseHitTest() && isAttackState)
         {
            return true;
         }
         return false;
      }
      
      public function mouseMoveHandler(param1:MouseEvent) : Boolean
      {
         if(mouseHitTest() && isAttackState)
         {
            return true;
         }
         return false;
      }
      
      private function get isAttackState() : Boolean
      {
         if(_data.activeCurHp <= 0)
         {
            return false;
         }
         return true;
      }
      
      override protected function updateBodyAlpha(param1:Number) : void
      {
         super.updateBodyAlpha(param1);
         if(_tank)
         {
            _tank.alpha = param1;
         }
      }
      
      override protected function layoutTxtViewWithNamePosY() : void
      {
         var _loc1_:int = isBlueTeam() ? 1 : 5;
         _consortiaTxt.setFrame(_loc1_);
         super.layoutTxtViewWithNamePosY();
         _bloodBar.y = _npcName.y + 15;
         _resourceTxt.y = caluateTopPos();
         _hasHbox.y = _consortiaTxt.text == "" ? _npcName.y - 40 : _npcName.y - 60;
         addChild(_bloodBar);
         if(_data.oreNum > 0)
         {
            addChild(_resourceTxt);
         }
         else
         {
            _resourceTxt.removeFromParent();
         }
         addChild(_effectLayer);
      }
      
      override protected function getPosYBySizeType(param1:int, param2:int = 0) : int
      {
         if(data)
         {
            return -200;
         }
         var _loc3_:int = super.getPosYBySizeType(param1,param2);
         return _loc3_ - 20;
      }
      
      override protected function refreshVocation() : void
      {
         if(!_data || !_data.baseHero || !_vocationIcon)
         {
            return;
         }
         if(_data.baseHero.vocationGrades > 0)
         {
            _vocationIcon.setFrame(_data.baseHero.vocationLevel);
            _vocationIcon.visible = true;
         }
         else
         {
            _vocationIcon.visible = false;
         }
      }
      
      public function changeDirectionTo(param1:int, param2:int) : void
      {
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
      
      override protected function addEvent() : void
      {
         if(_data)
         {
            _data.addEventListener("DANNAY",__onDannyHandler);
            _data.addEventListener("ADD_BUFF",__onAddBuffHandler);
            _data.addEventListener("USE_SKILL",__onUseSkillHandler);
            _data.addEventListener("USE_JUMP_SKILL",__onUseJumpSkillHandler);
            _data.addEventListener("PICK_UP",__onPickUpHandler);
            _data.addEventListener("ACTIVEVEHICLE_INFO_CHANGE",__activeArmyInfoHandler);
            _data.addEventListener("ACTIVEVEHICLE_HP_CHANGE",__updateActiveVehicleArmyHp);
            _data.addEventListener("ACTIVEVEHICLE_HOLD_KEY_STATE_CHANGE",__onHoldKeyStateChangeHandler);
            _data.addEventListener("CHECK_SNOW_BALL_POS",checkPosHandler);
            _data.addEventListener("ACTIVEVEHICLE_SKILL_CHANGE",__checkShowHboxHandler);
            _data.addEventListener("ADD_BUFF",__checkShowHboxHandler);
            _data.addEventListener("REMOVE_BUFF",__checkShowHboxHandler);
         }
         super.addEvent();
      }
      
      override protected function removeEvent() : void
      {
         if(_data)
         {
            _data.removeEventListener("DANNAY",__onDannyHandler);
            _data.removeEventListener("ADD_BUFF",__onAddBuffHandler);
            _data.removeEventListener("USE_SKILL",__onUseSkillHandler);
            _data.removeEventListener("USE_JUMP_SKILL",__onUseJumpSkillHandler);
            _data.removeEventListener("PICK_UP",__onPickUpHandler);
            _data.removeEventListener("ACTIVEVEHICLE_INFO_CHANGE",__activeArmyInfoHandler);
            _data.removeEventListener("ACTIVEVEHICLE_HP_CHANGE",__updateActiveVehicleArmyHp);
            _data.removeEventListener("ACTIVEVEHICLE_HOLD_KEY_STATE_CHANGE",__onHoldKeyStateChangeHandler);
            _data.removeEventListener("CHECK_SNOW_BALL_POS",checkPosHandler);
            _data.removeEventListener("ACTIVEVEHICLE_SKILL_CHANGE",__checkShowHboxHandler);
            _data.removeEventListener("ADD_BUFF",__checkShowHboxHandler);
            _data.removeEventListener("REMOVE_BUFF",__checkShowHboxHandler);
         }
         super.removeEvent();
      }
      
      private function enterTank() : void
      {
         updateVisible();
         changeBody();
      }
      
      private function __onDannyHandler(param1:ArmyEvent) : void
      {
         var _loc3_:MapSkillHurtData = param1.data as MapSkillHurtData;
         var _loc2_:ActiveVehicleDannyAction = new ActiveVehicleDannyAction(data,_loc3_);
         addAction(_loc2_,true);
      }
      
      private function initBuff() : void
      {
         var _loc1_:ActiveVehicleDannyAction = null;
         if(data == null)
         {
            return;
         }
         for each(var _loc2_:MapBuffHurtData in data.activeBuffList)
         {
            _loc1_ = new ActiveVehicleDannyAction(data,_loc2_);
            addAction(_loc1_,true);
         }
      }
      
      private function __onAddBuffHandler(param1:ArmyEvent) : void
      {
         var _loc3_:MapBuffHurtData = param1.data as MapBuffHurtData;
         var _loc2_:ActiveVehicleDannyAction = new ActiveVehicleDannyAction(data,_loc3_);
         addAction(_loc2_,true);
      }
      
      private function __onUseJumpSkillHandler(param1:ArmyEvent) : void
      {
         var _loc2_:ActiveVehicleJumpAction = new ActiveVehicleJumpAction(this);
         addAction(_loc2_);
      }
      
      private function __onUseSkillHandler(param1:ArmyEvent) : void
      {
         var _loc3_:MapSkillResultInfo = param1.data as MapSkillResultInfo;
         var _loc2_:ActiveVehicleShootAction = new ActiveVehicleShootAction(data,_loc3_);
         addAction(_loc2_);
      }
      
      private function __onPickUpHandler(param1:ArmyEvent) : void
      {
         var _loc2_:ActiveVehiclePickupAction = new ActiveVehiclePickupAction(data,param1.data as CampaignNode);
         addAction(_loc2_);
      }
      
      private function __onHoldKeyStateChangeHandler(param1:ArmyEvent) : void
      {
         if(_data.acctiveVehicleIsHoldKey)
         {
            if(!_holdKeyView)
            {
               _holdKeyView = ComponentFactory.Instance.creat("asset.unrealshooting.HoldKeyAsset");
               _holdKeyView.gotoAndPlay(1);
            }
            addChild(_holdKeyView);
            _holdKeyView.y = _showNamePosY - 40;
         }
         else
         {
            ObjectUtils.disposeObject(_holdKeyView);
            _holdKeyView = null;
         }
      }
      
      private function __activeArmyInfoHandler(param1:ArmyEvent) : void
      {
         enterTank();
         __checkShowHboxHandler(null);
      }
      
      override protected function __updateCurHpHandler(param1:PhysicsEvent) : void
      {
         _bloodBar.visible = true;
         var _loc3_:int = int(data.getCurrentHp());
         var _loc2_:int = int(data.getTotalHp());
         var _loc4_:int = _loc3_ * 100 / _loc2_;
         if(_bloodTween)
         {
            _bloodTween.currentProgress = 1;
         }
         if(isPlaying && _loc4_ != 100)
         {
            _bloodMask.gotoAndStop(_loc4_);
            _bloodTween = TweenMax.to(_bufferBlood,0.4,{
               "delay":0.6,
               "frame":_loc4_,
               "onComplete":killBloodMaskTweens
            });
         }
         else
         {
            _bloodMask.gotoAndStop(_loc4_);
            _bufferBlood.gotoAndStop(_loc4_);
         }
         updateDieState();
      }
      
      private function checkPosHandler(param1:ArmyEvent) : void
      {
         checkPos();
      }
      
      private function __checkShowHboxHandler(param1:ArmyEvent) : void
      {
         var _loc3_:VehicleSkillBuffTemplate = null;
         _hasHbox.removeAllChild();
         var _loc4_:VehicleSkillTempInfo = TempleteManager.instance.vehicleSkillTempteCate.getTemplateByTid(_data.activeVehicleSkillIdW);
         var _loc2_:VehicleSkillTempInfo = TempleteManager.instance.vehicleSkillTempteCate.getTemplateByTid(_data.activeVehicleSkillIdE);
         if(_loc4_)
         {
            _hasHbox.addChild(createSkillView(_loc4_));
         }
         if(_loc2_)
         {
            _hasHbox.addChild(createSkillView(_loc2_));
         }
         for each(var _loc5_:MapBuffHurtData in _data.activeBuffList)
         {
            _loc3_ = TempleteManager.instance.vehicleSkillBuffTemplateCate.getTemplateByIndex(_loc5_.buffId);
            if(!(!_loc3_ || _loc3_.TemplateId == 104 || _loc3_.Duration != -1 && _loc5_.leftTime == 0))
            {
               _hasHbox.addChild(createBufferView(_loc3_));
            }
         }
      }
      
      private function createSkillView(param1:VehicleSkillTempInfo) : BaseIconView
      {
         var _loc2_:BaseIconView = ComponentFactory.Instance.creatCustomObject("ActiveVehicleArmyView.skillBufferIcon");
         _loc2_.icon = IconFactory.getCommonIconPath(param1.Icons);
         _loc2_.tipData = param1;
         return _loc2_;
      }
      
      private function createBufferView(param1:VehicleSkillBuffTemplate) : BaseIconView
      {
         var _loc2_:BaseIconView = ComponentFactory.Instance.creatCustomObject("ActiveVehicleArmyView.skillBufferIcon");
         _loc2_.icon = IconFactory.getCommonIconPath(param1.Icon);
         _loc2_.tipData = param1;
         return _loc2_;
      }
      
      private function __updateActiveVehicleArmyHp(param1:ArmyEvent) : void
      {
         __updateCurHpHandler(null);
      }
      
      private function updateDieState() : void
      {
         if(_data.activeCurHp <= 0)
         {
            if(!_dieFilter)
            {
               _dieFilter = new UIFilter();
            }
            if(body)
            {
               body.transform.colorTransform = getNormalColorTrans();
            }
            if(_bloodBar)
            {
               _bloodBar.visible = false;
            }
            if(_tank)
            {
               _dieFilter.setGrayFilter(_tank);
            }
         }
         else
         {
            this.mouseChildren = false;
            if(_bloodBar)
            {
               _bloodBar.visible = true;
            }
            if(_tank)
            {
               _tank.filters = null;
            }
         }
      }
      
      private function getNormalColorTrans() : ColorTransform
      {
         var _loc1_:ColorTransform = new ColorTransform();
         _loc1_.redMultiplier = 1;
         _loc1_.greenMultiplier = 1;
         _loc1_.blueMultiplier = 1;
         _loc1_.alphaMultiplier = 1;
         _loc1_.redOffset = 0;
         _loc1_.greenOffset = 0;
         _loc1_.blueOffset = 0;
         _loc1_.alphaOffset = 0;
         return _loc1_;
      }
      
      private function killBloodMaskTweens() : void
      {
         if(_bloodTween)
         {
            _bloodTween.kill();
            _bloodTween = null;
         }
      }
      
      override public function dispose() : void
      {
         if(isDie)
         {
            return;
         }
         if(resDomain)
         {
            resDomain.removeCallBackFunction(__onLoaded);
         }
         resDomain = null;
         if(_actionQueue)
         {
            _actionQueue.dispose();
         }
         _actionQueue = null;
         if(_asynActionMgr)
         {
            _asynActionMgr.dispose();
         }
         _asynActionMgr = null;
         ObjectUtils.disposeObject(_resourceTxt);
         _resourceTxt = null;
         ObjectUtils.disposeObject(_hasHbox);
         _hasHbox = null;
         killBloodMaskTweens();
         if(_delayId > 0)
         {
            clearTimeout(_delayId);
         }
         _delayId = 0;
         TweenMax.killTweensOf(avatarView);
         super.dispose();
      }
      
      public function get effectLayer() : Sprite
      {
         return _effectLayer;
      }
      
      public function getHeadPos() : Point
      {
         var _loc1_:Point = new Point();
         _loc1_.y = -230;
         return _loc1_;
      }
      
      public function get body() : Sprite
      {
         if(_tank == null)
         {
            return avatarView;
         }
         return _tank;
      }
      
      override protected function __onlineStateHandler(param1:CampaignMapEvent) : void
      {
      }
      
      public function getShootPoint() : Point
      {
         var _loc1_:Point = new Point(this.x - 50,this.y - 55);
         if(_tank && _tank["bombpos"])
         {
            _loc1_.x += _tank.bombpos.x * _tank.scaleX;
            _loc1_.y += _tank.bombpos.y;
         }
         return _loc1_;
      }
      
      override public function updateVisible() : void
      {
         if(!_data)
         {
            return;
         }
         this.visible = Boolean(_data.online);
         if(avatarView)
         {
            avatarView.visible = false;
         }
         if(petAvatarView)
         {
            petAvatarView.visible = false;
         }
         if(childrenAvatarView)
         {
            childrenAvatarView.visible = false;
         }
      }
      
      override public function mouseHitTest() : Boolean
      {
         return super.mouseHitTest();
      }
      
      override public function set isPlaying(param1:Boolean) : void
      {
         super.isPlaying = param1;
         if(param1)
         {
            if(_tank && !_tank.isPlaying)
            {
               _tank.play();
            }
            if(_holdKeyView)
            {
               addChild(_holdKeyView);
            }
         }
         else
         {
            if(_tank && _tank.isPlaying)
            {
               _tank.stop();
            }
            if(_holdKeyView && _holdKeyView.parent)
            {
               _holdKeyView.parent.removeChild(_holdKeyView);
            }
         }
         if(data)
         {
            if(avatarView)
            {
               avatarView.isRending = false;
            }
         }
         else if(avatarView)
         {
            avatarView.isRending = true;
         }
         showFateSkillEffect();
         if(_honerTxt)
         {
            _honerTxt.visible = false;
         }
         if(_honerView)
         {
            _honerView.visible = false;
         }
      }
      
      override public function showFateSkillEffect() : void
      {
      }
      
      private function __onLoaded() : void
      {
         if(!data)
         {
            return;
         }
         if(isDie)
         {
            return;
         }
         if(data.activeVehicleTempInfo == null)
         {
            return;
         }
         var _loc3_:String = data.activeVehicleTempInfo.Avatar.substr(1);
         var _loc1_:String = "asset.avatar." + _loc3_;
         var _loc2_:int = 1;
         _tank = resDomain.createInstane(_loc1_) as MovieClip;
         if(_tank)
         {
            addChildAt(_tank,_loc2_);
         }
         updateDirection(data.angle);
         if(avatarView)
         {
            (avatarView as HeroAvatar).removeDefaultMovie();
            avatarView.isRending = false;
         }
         updateDieState();
      }
      
      public function changeBody() : void
      {
         refreshVocation();
         clearlastAvater();
         showTank();
         layoutTxtViewWithNamePosY();
      }
      
      override protected function showAvatar(param1:CampaignArmy) : void
      {
         super.showAvatar(param1);
         if(aiInfo && data.activeVehicleTempInfo)
         {
            aiInfo.speed = data.activeVehicleTempInfo.Speed;
         }
      }
      
      private function showTank() : void
      {
         var _loc1_:String = null;
         if(!_tank && data.activeVehicleTempInfo)
         {
            _loc1_ = PathManager.getVehicleAvatarPath(data.activeVehicleTempInfo.Avatar);
            resDomain.load(_loc1_,false,__onLoaded);
         }
         else
         {
            addChildAt(_tank,1);
            if(avatarView)
            {
               avatarView.isRending = false;
            }
         }
         if(aiInfo)
         {
            aiInfo.speed = data.activeVehicleTempInfo.Speed;
         }
         if(petAvatarView)
         {
            petAvatarView.visible = false;
         }
         if(childrenAvatarView)
         {
            childrenAvatarView.visible = false;
         }
         hideFateSkillEffect();
         if(isSelf)
         {
            KeyBoardRegister.instance.vehicleFlag = true;
         }
      }
      
      private function clearlastAvater() : void
      {
         if(petAvatarView)
         {
            petAvatarView.visible = true;
         }
         if(childrenAvatarView)
         {
            childrenAvatarView.visible = true;
         }
         showFateSkillEffect();
         if(avatarView)
         {
            avatarView.isRending = false;
         }
         ObjectUtils.disposeObject(_tank);
         _tank = null;
         resDomain.removeCallBackFunction(__onLoaded);
         if(isSelf)
         {
            KeyBoardRegister.instance.vehicleFlag = false;
         }
      }
   }
}

