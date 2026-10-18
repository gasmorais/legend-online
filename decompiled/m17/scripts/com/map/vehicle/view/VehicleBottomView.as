package com.map.vehicle.view
{
   import com.map.vehicle.VehicleModel;
   import com.map.vehicle.data.PlayerVehicleInfo;
   import com.map.vehicle.data.VehicleSkillInfo;
   import com.map.vehicle.events.VehicleEvent;
   import com.map.vehicle.net.VehicleSocketManager;
   import com.map.vehicle.net.VehicleSocketOutManager;
   import com.pickgliss.toplevel.StageReferance;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.ShowTipManager;
   import com.pickgliss.ui.controls.BaseButton;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.ui.image.ScaleFrameImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Bitmap;
   import flash.display.MovieClip;
   import flash.display.Shape;
   import flash.events.Event;
   import flash.events.KeyboardEvent;
   import flash.events.MouseEvent;
   import flash.geom.Point;
   import flash.utils.clearTimeout;
   import flash.utils.setTimeout;
   import im.view.IMMsgBoxView;
   import manager.LanguageMgr;
   import managers.IMManager;
   import yishi.SwitchPageHelp;
   import yishi.events.NotificationEvent;
   import yishi.manager.ArmyManager;
   import yishi.manager.FrameControllerManager;
   import yishi.manager.NotificationManager;
   import yishi.manager.PathManager;
   import yishi.manager.PlayerManager;
   import yishi.utils.TimerUtils;
   import yishi.view.community.BaseIconView;
   import yishi.view.component.MovieButton;
   
   public class VehicleBottomView extends Component
   {
      
      private var _back:Bitmap;
      
      private var _scoreTxt:Bitmap;
      
      private var _gradeBack:Bitmap;
      
      private var _gradeTxt:FilterFrameText;
      
      private var _scoreValueTxt:FilterFrameText;
      
      private var _hpTxt:FilterFrameText;
      
      private var _hpComponent:Component;
      
      private var _numTxt:FilterFrameText;
      
      private var _bloodmc:MovieClip;
      
      private var _head:BaseIconView;
      
      private var _icon01:VehicleSkillIcon;
      
      private var _icon02:VehicleSkillIcon;
      
      private var _icon03:VehicleSkillIcon;
      
      private var _iconList:Array;
      
      private var _flag:ScaleFrameImage;
      
      private var _settingBtn:BaseButton;
      
      private var _chatMessageBtn:MovieButton;
      
      private var _consortiaChatBtn:MovieButton;
      
      private var _model:VehicleModel = VehicleSocketManager.instance.model;
      
      private var _buffBar:VehicleBufferBar;
      
      private var _headMask:Shape;
      
      public function VehicleBottomView()
      {
         super();
         this.width = 620;
         this.height = 85;
         initView();
         addEvent();
      }
      
      private function initView() : void
      {
         _back = ComponentFactory.Instance.creatBitmap("asset.vehiclemap.BottomBack");
         _scoreTxt = ComponentFactory.Instance.creatBitmap("asset.vehiclemap.ScoreTxt");
         _gradeBack = ComponentFactory.Instance.creatBitmap("asset.vehiclemap.GradeBack");
         _gradeTxt = ComponentFactory.Instance.creatComponentByStylename("vehiclemap.gradeTxt");
         _scoreValueTxt = ComponentFactory.Instance.creatComponentByStylename("vehiclemap.scoreValueTxt");
         _hpTxt = ComponentFactory.Instance.creatComponentByStylename("vehiclemap.hpTxt");
         _hpComponent = ComponentFactory.Instance.creatCustomObject("vehiclemap.hpComponent");
         _numTxt = ComponentFactory.Instance.creatComponentByStylename("vehiclemap.numTxt");
         _bloodmc = ComponentFactory.Instance.creat("asset.vehiclemap.BloodBar");
         _bloodmc.gotoAndStop(80);
         _bloodmc.x = 159;
         _bloodmc.y = 63;
         _head = ComponentFactory.Instance.creatCustomObject("vehiclemap.headView");
         _icon01 = new VehicleSkillIcon("1");
         _icon02 = new VehicleSkillIcon("2");
         _icon03 = new VehicleSkillIcon("Q");
         _iconList = [_icon01,_icon02,_icon03];
         _icon01.x = 340;
         _icon01.y = 38;
         _icon02.x = 396;
         _icon02.y = 38;
         _icon03.x = 472;
         _icon03.y = 26;
         _buffBar = new VehicleBufferBar();
         _buffBar.x = 180;
         _buffBar.y = -3;
         _settingBtn = ComponentFactory.Instance.creatComponentByStylename("battle.settingBtn");
         _settingBtn.tipData = LanguageMgr.GetTranslation("setting.SettingFrame.title");
         _settingBtn.x = 434;
         _settingBtn.y = 8;
         _chatMessageBtn = ComponentFactory.Instance.creat("battle.chatMessageBtn");
         _consortiaChatBtn = ComponentFactory.Instance.creat("maintoolbar.ConsortiaChatBtn");
         _chatMessageBtn.tipData = LanguageMgr.GetTranslation("battle.view.ui.BattleUIView.msgBoxTip");
         _consortiaChatBtn.tipData = LanguageMgr.GetTranslation("consortiagroupchat.msgBoxItemNameTxt");
         _chatMessageBtn.x = 405;
         _chatMessageBtn.stopEffect();
         _flag = ComponentFactory.Instance.creatComponentByStylename("vehiclemap.teamFlag");
         _flag.x = 80;
         _flag.y = 5;
         _headMask = new Shape();
         _head.mask = _headMask;
         _headMask.graphics.beginFill(0);
         _headMask.graphics.drawRect(0,0,62,62);
         _headMask.graphics.endFill();
         _headMask.x = 95;
         _headMask.y = 20;
         addChild(_back);
         addChild(_head);
         addChild(_headMask);
         addChild(_flag);
         addChild(_gradeBack);
         addChild(_scoreTxt);
         addChild(_bloodmc);
         addChild(_gradeTxt);
         addChild(_scoreValueTxt);
         addChild(_hpComponent);
         _hpComponent.addChild(_hpTxt);
         addChild(_numTxt);
         addChild(_icon01);
         addChild(_icon02);
         addChild(_icon03);
         addChild(_buffBar);
         addChild(_settingBtn);
         if(ArmyManager.instance.thane.grades >= 6)
         {
            addChild(_chatMessageBtn);
         }
         if(PlayerManager.instance.currentPlayerModel.playerInfo.consortiaID > 0)
         {
            addChild(_consortiaChatBtn);
         }
         setMsgBtnShining();
         setConsortiaChatBtnShining();
         _hpComponent.tipData = LanguageMgr.GetTranslation("battle.view.bottomSelfBloodView.tip");
      }
      
      private function uintView() : void
      {
         ObjectUtils.disposeObject(_back);
         _back = null;
         ObjectUtils.disposeObject(_scoreTxt);
         _scoreTxt = null;
         ObjectUtils.disposeObject(_gradeBack);
         _gradeBack = null;
         ObjectUtils.disposeObject(_gradeTxt);
         _gradeTxt = null;
         ObjectUtils.disposeObject(_scoreValueTxt);
         _scoreValueTxt = null;
         ObjectUtils.disposeObject(_hpTxt);
         _hpTxt = null;
         ObjectUtils.disposeObject(_hpComponent);
         _hpComponent = null;
         ObjectUtils.disposeObject(_numTxt);
         _numTxt = null;
         ObjectUtils.disposeObject(_bloodmc);
         _bloodmc = null;
         ObjectUtils.disposeObject(_head);
         _head = null;
         ObjectUtils.disposeObject(_icon01);
         _icon01 = null;
         ObjectUtils.disposeObject(_icon02);
         _icon02 = null;
         ObjectUtils.disposeObject(_icon03);
         _icon03 = null;
         ObjectUtils.disposeObject(_flag);
         _flag = null;
         ObjectUtils.disposeObject(_settingBtn);
         _settingBtn = null;
         ObjectUtils.disposeObject(_chatMessageBtn);
         _chatMessageBtn = null;
         ObjectUtils.disposeObject(_consortiaChatBtn);
         _consortiaChatBtn = null;
         ObjectUtils.disposeObject(_buffBar);
         _buffBar = null;
         ObjectUtils.disposeObject(_headMask);
         _headMask = null;
         if(_iconList)
         {
            _iconList.length = 0;
         }
         _iconList = null;
         _model = null;
      }
      
      private function addEvent() : void
      {
         if(!_model.selfVehicleInfo)
         {
            _model.addEventListener("addPlayer",__addPlayerHandler);
         }
         else
         {
            _buffBar.playerVehicleInfo = _model.selfVehicleInfo;
            __updateHpHandler();
            __refreshHander();
            __scoreChangeHandler(null);
            _model.selfVehicleInfo.addEventListener("playerInfoChange",__refreshHander);
            _model.selfVehicleInfo.addEventListener("update_hp",__updateHpHandler);
            _model.addEventListener("SCORE_CHANGE",__scoreChangeHandler);
            _model.skillBag.addEventListener("SKILL_INFO_CHANGE",__refreshHander);
            _model.skillBag.addEventListener("START_CD",__startCdHandler);
            _chatMessageBtn.addEventListener("rollOut",__onMsgBtnRollOut);
            _chatMessageBtn.addEventListener("rollOver",__onMsgBtnRollOver);
            _chatMessageBtn.addEventListener("click",__mouseClickHandler);
            _consortiaChatBtn.addEventListener("click",__consortiaChatClickHandler);
            NotificationManager.instance.addEventListener("CHAT_FROM_CONSORTIA",__receiveGroupChatHandler);
            IMManager.instance.addEventListener("MSGBOX_SHINING_UPDATE",__chatMsgbtnShineHandler);
         }
         _settingBtn.addEventListener("click",__openSettingFrameHandler);
      }
      
      private function removeEvent() : void
      {
         if(_model)
         {
            _model.removeEventListener("addPlayer",__addPlayerHandler);
            _model.removeEventListener("SCORE_CHANGE",__scoreChangeHandler);
            if(_model.selfVehicleInfo)
            {
               _model.selfVehicleInfo.removeEventListener("update_hp",__updateHpHandler);
               _model.selfVehicleInfo.removeEventListener("playerInfoChange",__refreshHander);
            }
            if(_model.skillBag)
            {
               _model.skillBag.removeEventListener("SKILL_INFO_CHANGE",__refreshHander);
               _model.skillBag.removeEventListener("START_CD",__startCdHandler);
            }
         }
         _chatMessageBtn.removeEventListener("rollOut",__onMsgBtnRollOut);
         _chatMessageBtn.removeEventListener("rollOver",__onMsgBtnRollOver);
         _chatMessageBtn.removeEventListener("click",__mouseClickHandler);
         _consortiaChatBtn.removeEventListener("click",__consortiaChatClickHandler);
         NotificationManager.instance.removeEventListener("CHAT_FROM_CONSORTIA",__receiveGroupChatHandler);
         IMManager.instance.removeEventListener("MSGBOX_SHINING_UPDATE",__chatMsgbtnShineHandler);
         if(_settingBtn)
         {
            _settingBtn.removeEventListener("click",__openSettingFrameHandler);
         }
      }
      
      private function __updateHpHandler(param1:VehicleEvent = null) : void
      {
         var _loc2_:PlayerVehicleInfo = _model.selfVehicleInfo;
         _hpTxt.text = _loc2_.hp + " / " + _loc2_.totalHp;
         var _loc3_:int = _loc2_.hp * 100 / _loc2_.totalHp;
         _bloodmc.gotoAndStop(_loc3_);
      }
      
      private function __addPlayerHandler(param1:VehicleEvent) : void
      {
         if(_model.selfVehicleInfo)
         {
            _model.removeEventListener("addPlayer",__addPlayerHandler);
            addEvent();
         }
      }
      
      private function __scoreChangeHandler(param1:VehicleEvent) : void
      {
         _scoreValueTxt.text = String(_model.selfVehicleInfo.score);
      }
      
      private function __refreshHander(param1:VehicleEvent = null) : void
      {
         var _loc2_:String = null;
         var _loc4_:PlayerVehicleInfo = _model.selfVehicleInfo;
         if(!_loc4_)
         {
            return;
         }
         _gradeTxt.text = String(_loc4_.grade);
         if(_loc4_.team > 0)
         {
            _flag.setFrame(_loc4_.team);
         }
         _model.skillBag.init(_model.selfVehicleInfo);
         _icon01.data = _model.skillBag.getSkillByKey(49);
         _icon02.data = _model.skillBag.getSkillByKey(50);
         var _loc3_:VehicleSkillInfo = _model.skillBag.getSkillByKey(81);
         if(_loc3_.tempalte && _loc3_.tempalte.Maximum == -1)
         {
            _icon03.data = _model.skillBag.getSkillByKey(81);
            _numTxt.text = "--";
         }
         else if(_loc3_.count <= 0)
         {
            _icon03.data = null;
            _numTxt.text = "--";
         }
         else
         {
            _icon03.data = _loc3_;
            _numTxt.text = String(_loc3_.count);
         }
         _loc2_ = PathManager.getVehicleShowAvatarPath(_loc4_.template.Avatar);
         if(_loc2_ != String(_head.icon))
         {
            _head.icon = _loc2_;
         }
      }
      
      private function __startCdHandler(param1:VehicleEvent) : void
      {
         var _loc2_:int = param1.data;
         for each(var _loc3_:VehicleSkillIcon in _iconList)
         {
            if(_loc3_.data && _loc3_.data.templateId == _loc2_)
            {
               _loc3_.startCD();
               break;
            }
         }
      }
      
      private function __onMsgBtnRollOut(param1:MouseEvent) : void
      {
         IMManager.instance.model.removeMsgBoxTimeOut = flash.utils.setTimeout(removeIMMsgBox,300);
      }
      
      private function removeIMMsgBox() : void
      {
         clearTimeout(IMManager.instance.model.removeMsgBoxTimeOut);
         IMManager.instance.removeIMMsgBox();
      }
      
      private function __onMsgBtnRollOver(param1:MouseEvent) : void
      {
         var _loc2_:Point = null;
         var _loc3_:IMMsgBoxView = IMManager.instance.createIMMsgBox();
         if(_loc3_)
         {
            ShowTipManager.Instance.removeCurrentTip();
            _loc2_ = new Point(_chatMessageBtn.x - (_loc3_.width - _chatMessageBtn.width) / 2,_chatMessageBtn.y - _loc3_.height);
            _loc2_ = this.localToGlobal(_loc2_);
            _loc3_.x = _loc2_.x;
            _loc3_.y = _loc2_.y;
            _loc2_ = null;
            LayerManager.Instance.addToLayer(_loc3_,3);
         }
      }
      
      private function __mouseClickHandler(param1:MouseEvent) : void
      {
         StageReferance.stage.dispatchEvent(new KeyboardEvent("keyDown",true,false,0,13));
         param1.stopPropagation();
      }
      
      private function __consortiaChatClickHandler(param1:MouseEvent) : void
      {
         if(!FrameControllerManager.instance.consortiaGroupChatControler.isVisible())
         {
            setConsortiaChatBtnShining(false);
            FrameControllerManager.instance.openControllerByInfo("consortiagroupchat");
         }
      }
      
      private function __receiveGroupChatHandler(param1:NotificationEvent) : void
      {
         setConsortiaChatBtnShining();
      }
      
      private function __chatMsgbtnShineHandler(param1:Event) : void
      {
         setMsgBtnShining();
      }
      
      private function setMsgBtnShining() : void
      {
         if(IMManager.instance.friendBtnShining)
         {
            _chatMessageBtn.isPlaying = true;
            _chatMessageBtn.playEffect();
         }
         else
         {
            _chatMessageBtn.isPlaying = false;
            _chatMessageBtn.stopEffect();
         }
      }
      
      private function setConsortiaChatBtnShining(param1:Boolean = true) : void
      {
         if(param1 && Boolean(FrameControllerManager.instance.consortiaGroupChatControler.groupChatShining))
         {
            _consortiaChatBtn.isPlaying = true;
            _consortiaChatBtn.playEffect();
         }
         else
         {
            _consortiaChatBtn.isPlaying = false;
            _consortiaChatBtn.stopEffect();
         }
      }
      
      private function __openSettingFrameHandler(param1:MouseEvent) : void
      {
         TimerUtils.setTimeout(openFrame,10);
      }
      
      private function openFrame() : void
      {
         FrameControllerManager.instance.openControllerByInfo("setting");
      }
      
      private function __exitHandler(param1:MouseEvent) : void
      {
         VehicleSocketOutManager.instance.sendReturnCampaignRoom();
         SwitchPageHelp.returnToSpace();
      }
      
      public function show() : void
      {
         resize();
         LayerManager.Instance.addToLayer(this,4,false,false,0,2);
      }
      
      public function resize() : void
      {
         var _loc1_:int = int(StageReferance.stageWidth);
         var _loc2_:int = int(StageReferance.stageHeight);
         this.x = (_loc1_ - this.width) / 2;
         this.y = _loc2_ - this.height;
      }
      
      override public function dispose() : void
      {
         removeEvent();
         uintView();
         super.dispose();
      }
   }
}

