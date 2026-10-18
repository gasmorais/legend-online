package battle.view.ui
{
   import battle.BattleManager;
   import battle.data.BufferDamageData;
   import battle.events.BattleEvent;
   import battle.net.BattleSocketOuterManager;
   import battle.qte.QteView;
   import battle.utils.BattleFunctionHelper;
   import battle.utils.DelayCalling;
   import battle.utils.Helpers;
   import battle.utils.Int64Utils;
   import battle.view.bottom.BottomBar;
   import battle.view.bottom.ChildCommonBottomBar;
   import battle.view.bottom.ChildpveBattleBar;
   import battle.view.bottom.MonsterCommonBottomBar;
   import battle.view.bottom.PetBattleBar;
   import battle.view.bottom.PetSacristyBar;
   import battle.view.skillname.SkillNameContainer;
   import battle.view.ui.top.BattleGoddessTopView;
   import chat.datas.ChatData;
   import com.pickgliss.toplevel.StageReferance;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.ShowTipManager;
   import com.pickgliss.ui.controls.BaseButton;
   import com.pickgliss.ui.controls.IconButton;
   import com.pickgliss.ui.controls.SelectedButton;
   import com.pickgliss.ui.controls.SelectedIconTextButton;
   import com.pickgliss.ui.controls.TextButton;
   import com.pickgliss.ui.controls.container.VBox;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.ui.image.Image;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.ui.text.GradientText;
   import com.pickgliss.utils.ObjectPool;
   import com.pickgliss.utils.ObjectUtils;
   import com.pickgliss.utils.SoundManager;
   import com.road.yishi.proto.battle.BattleReqMsg;
   import com.road.yishi.proto.battle.TriggerSkillMsg;
   import com.road.yishi.proto.simple.WorldBossInfoMsg;
   import flash.display.DisplayObject;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.KeyboardEvent;
   import flash.events.MouseEvent;
   import flash.events.TimerEvent;
   import flash.geom.Point;
   import flash.utils.Timer;
   import flash.utils.clearTimeout;
   import flash.utils.setTimeout;
   import im.view.IMMsgBoxView;
   import mainBar.StripView;
   import manager.LanguageMgr;
   import managers.IMManager;
   import managers.PetSacristyManager;
   import managers.VIPManager;
   import mvc.module.friends.IMEvent;
   import mvc.module.vip.VipInfo;
   import ui.maintoolbar.MainToolBar;
   import yishi.comm.PackageIn;
   import yishi.comm.PackageOut;
   import yishi.datas.BattleModel;
   import yishi.datas.objects.HeroRoleInfo;
   import yishi.datas.objects.MonsterRoleInfo;
   import yishi.datas.objects.SelfChessRoleInfo;
   import yishi.datas.templates.ConfigInfosTempInfo;
   import yishi.datas.templates.GameHeroTempInfo;
   import yishi.datas.templates.SkillTempInfo;
   import yishi.events.NotificationEvent;
   import yishi.events.RoleEvent;
   import yishi.events.SLGSocketEvent;
   import yishi.manager.ArmyManager;
   import yishi.manager.ConfigManager;
   import yishi.manager.FrameControllerManager;
   import yishi.manager.NotificationManager;
   import yishi.manager.PlayerManager;
   import yishi.manager.SharedManager;
   import yishi.manager.TempleteManager;
   import yishi.service.managers.SocketManager;
   import yishi.service.managers.SocketSendManager;
   import yishi.utils.HashMap;
   import yishi.utils.SimpleAlertHelper;
   import yishi.utils.TimerUtils;
   import yishi.view.component.MovieButton;
   import yishi.view.component.TileContainer;
   import yishi.view.tips.MessageTipManager;
   
   public class BattleUIView extends Sprite
   {
      
      private var _roleShowII:RoleShowViewII;
      
      private var _doubleBossShow:RoleShowViewIII;
      
      private var _mutilRoleShowView:MutilBossShowView;
      
      private var _skillNameContainer:SkillNameContainer;
      
      private var _batterUIView:BatterUIView;
      
      private var _battleSpaceTimeView:BattleSpaceTimeView;
      
      private var _resistUIView1:ResistUIView;
      
      private var _resistUIView2:ResistUIView;
      
      private var _sceneWidth:Number;
      
      private var _sceneHeight:Number;
      
      private var _delay:DelayCalling;
      
      private var _qteView:QteView;
      
      private var _addSpBallLayer:Sprite;
      
      private var _preLockState:Boolean;
      
      private var _skillListOffsetX:int;
      
      private var _bottomBar:BottomBar;
      
      private var _petBar:PetBattleBar;
      
      private var _sacristyBar:PetSacristyBar;
      
      private var _childpveBar:ChildpveBattleBar;
      
      private var _childCommomBar:ChildCommonBottomBar;
      
      private var _monsterCommomBar:MonsterCommonBottomBar;
      
      private var _outyardShowView:OutyardShowView;
      
      private var _hurtUpView:HurtUpView;
      
      private var _trailCountView:TrailCountView;
      
      private var _autoFightBtn:SelectedButton;
      
      private var _autoFightFlag:DisplayObject;
      
      private var _autoFightStrip:StripView;
      
      private var _chatMessageBtn:MovieButton;
      
      private var _consortiaChatBtn:MovieButton;
      
      private var _teamStripContainer1:VBox;
      
      private var _teamStripContainer2:VBox;
      
      private var _finishNowBtn:IconButton;
      
      private var _settingBtn:BaseButton;
      
      private var _timer:Timer;
      
      private var _countdownTxt:GradientText;
      
      private var _countdownTxt2:GradientText;
      
      private var _countdownNumTxt:FilterFrameText;
      
      private var _killSelfBtn:TextButton;
      
      private var _immediatelyWinBtn:TextButton;
      
      private var _hideOthersBg:Image;
      
      private var _hideOthersBtn:SelectedIconTextButton;
      
      private var _preSelected:Boolean;
      
      private var _nldlyiSynBloodRoleInfo:HeroRoleInfo;
      
      private var _dragonTitanOfTeamMate:DragonTitanTeamView;
      
      private var _dragonTitanOfEnemies:DragonTitanTeamView;
      
      private var _selfGoddessTopView:BattleGoddessTopView;
      
      private var _vsGoddessTopView:BattleGoddessTopView;
      
      private var _raceAgainstTimeUpView:RaceAgainstTimeUpView;
      
      private var _forbiddenBossUIView:ForbiddenBossUIView;
      
      private var _warsoulEndBtn:IconButton;
      
      private var container:TileContainer;
      
      private var _isskilling:Boolean = false;
      
      private var _stripView:Component;
      
      private var _teamStripHashmap:HashMap;
      
      private var _preClickTime:Number;
      
      public function BattleUIView()
      {
         super();
         init();
         layout();
         addEvent();
         var _loc1_:VipInfo = VIPManager.Instance.model.vipInfo;
         if((isPetChallenge || isMonopolyHelp) && Boolean(_loc1_.IsVipAndNoExpirt) && _loc1_.VipGrade >= 3)
         {
            showFinishBtn();
         }
         if(isBattleSign)
         {
            showFinishBtn();
         }
         if(battleModel.battleType == 3905)
         {
            _warsoulEndBtn.visible = true;
         }
      }
      
      private function showFinishBtn() : void
      {
         var _loc2_:int = 10;
         var _loc1_:ConfigInfosTempInfo = TempleteManager.instance.getConfigInfoByConfigName("Imm_over_battle");
         if(_loc1_)
         {
            _loc2_ = parseInt(_loc1_.ConfigValue) / 1000;
         }
         if(_finishNowBtn.icon)
         {
            _finishNowBtn.icon.visible = false;
         }
         if(_countdownTxt)
         {
            _countdownTxt.visible = true;
         }
         if(_countdownTxt2)
         {
            _countdownTxt2.visible = true;
         }
         if(_countdownNumTxt)
         {
            _countdownNumTxt.visible = true;
         }
         _stripView.tipData = LanguageMgr.GetTranslation("battle.petChallenge.countdownTxtTip",_loc2_);
         _timer = new Timer(1000,_loc2_);
         _timer.addEventListener("timer",__onTimer);
         _timer.addEventListener("timerComplete",__onTimerComplete);
         _timer.start();
      }
      
      private function __onTimer(param1:TimerEvent) : void
      {
         var _loc2_:String = null;
         if(_countdownNumTxt)
         {
            _loc2_ = _timer.repeatCount - _timer.currentCount + "";
            if(_loc2_.length == 1)
            {
               _loc2_ = "0" + _loc2_;
            }
            _countdownNumTxt.text = _loc2_;
            if(_stripView)
            {
               _stripView.tipData = LanguageMgr.GetTranslation("battle.petChallenge.countdownTxtTip",_timer.repeatCount - _timer.currentCount);
            }
         }
      }
      
      private function __onTimerComplete(param1:TimerEvent) : void
      {
         if(_timer)
         {
            _timer.stop();
            _timer.removeEventListener("timer",__onTimer);
            _timer.removeEventListener("timerComplete",__onTimerComplete);
            _timer = null;
         }
         if(_stripView)
         {
            _stripView.tipData = LanguageMgr.GetTranslation("BattleUIView.vip3use");
         }
         if(!_finishNowBtn)
         {
            return;
         }
         var _loc2_:VipInfo = VIPManager.Instance.model.vipInfo;
         if(_loc2_.IsVipAndNoExpirt && _loc2_.VipGrade >= 3)
         {
            _finishNowBtn.enable = true;
         }
         if(battleModel.battleType == 16)
         {
            _finishNowBtn.enable = true;
         }
         if(_finishNowBtn.icon)
         {
            _finishNowBtn.icon.visible = true;
         }
         ObjectUtils.disposeObject(_countdownNumTxt);
         _countdownNumTxt = null;
         ObjectUtils.disposeObject(_countdownTxt);
         _countdownTxt = null;
         ObjectUtils.disposeObject(_countdownTxt2);
         _countdownTxt2 = null;
      }
      
      private function addEvent() : void
      {
         StageReferance.stage.addEventListener("resize",__stageResize);
         NotificationManager.instance.addEventListener("SET_BATTERUI_VISIBLE_BattleNotic",__batterUIVisible);
         NotificationManager.instance.addEventListener("SET_RESIST_VISIBLE",__resistUIVisible);
         NotificationManager.instance.addEventListener("SHOW_SKILL_USE_SUCCESS_BattleNotic",__skillUseSuccess);
         NotificationManager.instance.addEventListener("SKILL_ENABLE",__skillEnable);
         NotificationManager.instance.addEventListener("CHAT_FROM_CONSORTIA",__receiveGroupChatHandler);
         NotificationManager.instance.addEventListener("BATTLE_REINFORCE_HANDLER",__refreshViewHandler);
         NotificationManager.instance.addEventListener("BATTLE_STONETRIGGER",_showStoneTriggerSkill);
         _chatMessageBtn.addEventListener("rollOut",__onMsgBtnRollOut);
         _chatMessageBtn.addEventListener("rollOver",__onMsgBtnRollOver);
         _chatMessageBtn.addEventListener("click",__mouseClickHandler);
         _consortiaChatBtn.addEventListener("click",__consortiaChatClickHandler);
         IMManager.instance.addEventListener("MSGBOX_SHINING_UPDATE",__msgboxShiningUpdateHandler);
         NotificationManager.instance.addEventListener("FORCE_SKILL_ENABLE",__forceSkillEnable);
         if(_finishNowBtn)
         {
            _finishNowBtn.addEventListener("click",__finishNowBtnClickHandler);
         }
         if(_settingBtn)
         {
            _settingBtn.addEventListener("click",__settingBtnClickHandler);
         }
         if(_warsoulEndBtn)
         {
            _warsoulEndBtn.addEventListener("click",__warsoulEndBtnClickHandler);
         }
      }
      
      private function removeEvent() : void
      {
         StageReferance.stage.removeEventListener("resize",__stageResize);
         NotificationManager.instance.removeEventListener("SHOW_SKILL_USE_SUCCESS_BattleNotic",__skillUseSuccess);
         NotificationManager.instance.removeEventListener("SET_BATTERUI_VISIBLE_BattleNotic",__batterUIVisible);
         NotificationManager.instance.removeEventListener("SET_RESIST_VISIBLE",__resistUIVisible);
         NotificationManager.instance.removeEventListener("SKILL_ENABLE",__skillEnable);
         NotificationManager.instance.removeEventListener("CHAT_FROM_CONSORTIA",__receiveGroupChatHandler);
         NotificationManager.instance.removeEventListener("BATTLE_REINFORCE_HANDLER",__refreshViewHandler);
         NotificationManager.instance.removeEventListener("BATTLE_STONETRIGGER",_showStoneTriggerSkill);
         NotificationManager.instance.removeEventListener("FORCE_SKILL_ENABLE",__forceSkillEnable);
         SocketManager.instance.removeEventListener("SLGSocketEvent" + 4794,nldlyiOtherBossHPSyncHandler);
         if(_chatMessageBtn)
         {
            _chatMessageBtn.removeEventListener("rollOut",__onMsgBtnRollOut);
            _chatMessageBtn.removeEventListener("rollOver",__onMsgBtnRollOver);
            _chatMessageBtn.removeEventListener("click",__mouseClickHandler);
         }
         if(_consortiaChatBtn)
         {
            _consortiaChatBtn.removeEventListener("click",__consortiaChatClickHandler);
         }
         if(_autoFightBtn)
         {
            _autoFightBtn.removeEventListener("click",onAutoFightClick);
         }
         if(_hideOthersBtn)
         {
            _hideOthersBtn.removeEventListener("click",onHideOthersClick);
         }
         IMManager.instance.removeEventListener("MSGBOX_SHINING_UPDATE",__msgboxShiningUpdateHandler);
         if(_finishNowBtn)
         {
            _finishNowBtn.removeEventListener("click",__finishNowBtnClickHandler);
         }
         if(_settingBtn)
         {
            _settingBtn.removeEventListener("click",__settingBtnClickHandler);
         }
         if(_killSelfBtn)
         {
            _killSelfBtn.removeEventListener("click",_onKillSelfClick);
         }
         if(_immediatelyWinBtn)
         {
            _immediatelyWinBtn.removeEventListener("click",_onKillSelfClick);
         }
         if(_warsoulEndBtn)
         {
            _warsoulEndBtn.removeEventListener("click",__warsoulEndBtnClickHandler);
         }
      }
      
      private function __forceSkillEnable(param1:NotificationEvent) : void
      {
         if(container)
         {
            container.removeAllChildren();
            container.visible = false;
         }
      }
      
      private function testTriggerskill() : void
      {
         var _loc4_:int = 0;
         var _loc2_:TriggerSkillMsg = null;
         var _loc1_:BattleEvent = new BattleEvent("sss",null);
         var _loc3_:Array = [];
         var _loc5_:Array = [5500101,5500204,5500405];
         _loc4_ = 0;
         while(_loc4_ < 3)
         {
            _loc2_ = new TriggerSkillMsg();
            _loc2_.templatedId = _loc5_[_loc4_];
            _loc3_.push(_loc2_);
            _loc4_++;
         }
         if(_isskilling)
         {
            _loc3_ = [];
            _isskilling = false;
         }
         else
         {
            _isskilling = true;
         }
         _loc1_.data = _loc3_;
         _showStoneTriggerSkill(_loc1_);
      }
      
      private function _showStoneTriggerSkill(param1:BattleEvent) : void
      {
         var _loc2_:BattleSkillItemII = null;
         var _loc7_:SkillTempInfo = null;
         var _loc6_:int = 0;
         var _loc4_:TriggerSkillMsg = null;
         var _loc3_:Array = param1.data as Array;
         if(!_loc3_)
         {
            return;
         }
         var _loc5_:int = int(_loc3_.length);
         if(_loc5_ == 0)
         {
            container.removeAllChildren();
            container.visible = false;
         }
         else
         {
            container.removeAllChildren();
            container.visible = true;
            _loc7_ = null;
            _loc6_ = 0;
            while(_loc6_ < _loc5_)
            {
               _loc2_ = new BattleSkillItemII(5);
               _loc4_ = _loc3_[_loc6_];
               if(_loc4_)
               {
                  (_loc2_ as BattleSkillItemII).setState(0);
                  _loc2_.addEventListener("SKILL_CLICK_BattleEvent",__skillClick);
                  _loc7_ = TempleteManager.instance.getSkillTemplateInfoById(_loc4_.templatedId);
                  _loc2_["data"] = _loc7_;
                  if(_loc4_.coolDown)
                  {
                     _loc2_["data"].CoolDown = _loc4_.coolDown;
                     _loc2_.cdStart(_loc4_.appearCoolDown,_loc7_.CoolDown);
                  }
                  container.appendItem(_loc2_,{"width":44});
               }
               _loc6_++;
            }
         }
      }
      
      private function __skillClick(param1:BattleEvent) : void
      {
         NotificationManager.instance.sendNotification("ACTION_SKILL_BattleNotic",param1.data);
      }
      
      private function __refreshViewHandler(param1:BattleEvent) : void
      {
         if(!isNoHeroBattleType())
         {
            if(hasTitanInThisBattle())
            {
               if(BattleFunctionHelper.instance.hasHeroBySide(enemySide))
               {
                  if(!_dragonTitanOfTeamMate)
                  {
                     _dragonTitanOfTeamMate = new DragonTitanTeamView(selfSide);
                     _dragonTitanOfTeamMate.x = 0;
                     _dragonTitanOfTeamMate.y = _sceneHeight * 0.5 - 130;
                     addChild(_dragonTitanOfTeamMate);
                  }
                  if(!_dragonTitanOfEnemies && battleModel.battleType != 3870)
                  {
                     _dragonTitanOfEnemies = new DragonTitanTeamView(enemySide);
                     _dragonTitanOfEnemies.x = _sceneWidth - 120;
                     _dragonTitanOfEnemies.y = _sceneHeight * 0.5 - 130;
                     addChild(_dragonTitanOfEnemies);
                  }
               }
               else if(BattleFunctionHelper.instance.hasHeroBySide(selfSide))
               {
                  if(!_dragonTitanOfTeamMate)
                  {
                     _dragonTitanOfTeamMate = new DragonTitanTeamView(selfSide);
                     _dragonTitanOfTeamMate.x = 0;
                     _dragonTitanOfTeamMate.y = _sceneHeight * 0.5 - 130;
                     addChild(_dragonTitanOfTeamMate);
                  }
               }
            }
         }
         var _loc2_:Array = BattleFunctionHelper.instance.showGoddessTopAry();
         if(_loc2_[0])
         {
            _selfGoddessTopView = new BattleGoddessTopView(selfSide);
            _selfGoddessTopView.x = _sceneWidth / 2 - 480;
            _selfGoddessTopView.y = -20;
            addChild(_selfGoddessTopView);
         }
         if(_loc2_[1])
         {
            _vsGoddessTopView = new BattleGoddessTopView(enemySide);
            _vsGoddessTopView.x = _sceneWidth / 2 + 40;
            _vsGoddessTopView.y = -20;
            addChild(_vsGoddessTopView);
         }
      }
      
      private function __finishNowBtnClickHandler(param1:MouseEvent) : void
      {
         var _loc3_:VipInfo = null;
         var _loc4_:String = null;
         var _loc2_:ChatData = null;
         SoundManager.instance.play("022");
         if(battleModel.battleType == 16)
         {
            battleModel.isFinishNow = true;
            BattleSocketOuterManager.sendEndBattle(battleModel.battleId);
         }
         else
         {
            _loc3_ = VIPManager.Instance.model.vipInfo;
            if(_loc3_.IsVipAndNoExpirt && _loc3_.VipGrade >= 3)
            {
               battleModel.isFinishNow = true;
               BattleSocketOuterManager.sendEndBattle(battleModel.battleId);
            }
            _loc4_ = "";
            _loc2_ = ObjectPool.getObject(ChatData) as ChatData;
            if(isMonopolyHelp)
            {
               _loc4_ = LanguageMgr.GetTranslation("battle.view.ui.BattleUIView.finishNowBtnClickTips");
               if(_loc2_)
               {
                  _loc2_.channel = 3;
                  _loc2_.msg = _loc4_;
                  _loc2_.commit();
                  NotificationManager.instance.sendNotification("ADD_CHAT",_loc2_);
               }
            }
         }
         _finishNowBtn.enable = false;
      }
      
      private function __warsoulEndBtnClickHandler(param1:MouseEvent) : void
      {
         SimpleAlertHelper.instance.data = [callBack];
         var _loc2_:String = LanguageMgr.GetTranslation("public.confirm");
         var _loc3_:String = LanguageMgr.GetTranslation("public.cancel");
         var _loc4_:String = LanguageMgr.GetTranslation("public.prompt");
         var _loc5_:String = LanguageMgr.GetTranslation("battleUIView.warsoulTower.content.txt");
         SimpleAlertHelper.instance.popAlerFrame(_loc4_,_loc5_,_loc2_,_loc3_,true,true);
      }
      
      private function callBack(param1:Boolean, param2:Boolean) : void
      {
         if(param1)
         {
            if(battleModel.battleType == 3905)
            {
               SocketSendManager.instance.sendRemoveBattle();
            }
         }
      }
      
      private function __settingBtnClickHandler(param1:MouseEvent) : void
      {
         TimerUtils.setTimeout(openFrame,10);
      }
      
      private function openFrame() : void
      {
         FrameControllerManager.instance.openControllerByInfo("setting");
      }
      
      private function __receiveGroupChatHandler(param1:NotificationEvent) : void
      {
         setConsortiaChatBtnShining();
      }
      
      private function __msgboxShiningUpdateHandler(param1:IMEvent) : void
      {
         setMsgBtnShining();
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
      
      private function __onMsgBtnRollOut(param1:MouseEvent) : void
      {
         IMManager.instance.model.removeMsgBoxTimeOut = setTimeout(removeIMMsgBox,300);
      }
      
      private function removeIMMsgBox() : void
      {
         clearTimeout(IMManager.instance.model.removeMsgBoxTimeOut);
         IMManager.instance.removeIMMsgBox();
      }
      
      private function __consortiaChatClickHandler(param1:MouseEvent) : void
      {
         if(!FrameControllerManager.instance.consortiaGroupChatControler.isVisible())
         {
            setConsortiaChatBtnShining(false);
            FrameControllerManager.instance.openControllerByInfo("consortiagroupchat");
         }
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
      
      private function __batterUIVisible(param1:NotificationEvent) : void
      {
         var event:NotificationEvent = param1;
         if(event.data == true)
         {
            BattleManager.getInstance().batterModel.lock = false;
            _batterUIView.visible = event.data;
            if(_delay)
            {
               _delay.cancel();
            }
            _batterUIView.show();
         }
         else
         {
            if(_delay)
            {
               _delay.cancel();
            }
            _delay = Helpers.delayCall(function():void
            {
               _batterUIView.hide();
               BattleManager.getInstance().batterModel.lock = false;
            },25);
         }
      }
      
      private function __resistUIVisible(param1:NotificationEvent) : void
      {
         if(battleModel.battleType == 311 || battleModel.battleType == 312 || battleModel.battleType == 313)
         {
            return;
         }
         var _loc2_:ResistUIView = param1.data.side == 1 ? _resistUIView1 : _resistUIView2;
         if(param1.data.value == true)
         {
            _loc2_.visible = param1.data.value;
            _loc2_.show();
         }
      }
      
      private function __skillEnable(param1:NotificationEvent) : void
      {
         if(battleModel.isMultiPlayer() || !BattleModel.allowAutoFight)
         {
            if(_autoFightBtn)
            {
               battleAutoFightEnable = false;
            }
            return;
         }
         if(battleModel.isOver)
         {
            battleAutoFightEnable = false;
         }
         else if(ArmyManager.instance.thane.grades >= 15)
         {
            battleAutoFightEnable = true;
         }
      }
      
      private function set battleAutoFightEnable(param1:Boolean) : void
      {
         if(_autoFightBtn)
         {
            _autoFightBtn.enable = param1;
         }
         if(battleModel.battleType == 3886)
         {
            if(!battleModel.isOver && ArmyManager.instance.thane.grades >= 15)
            {
               _autoFightBtn.enable = true;
            }
         }
      }
      
      private function __stageResize(param1:Event) : void
      {
         layout();
      }
      
      private function layout() : void
      {
         var _loc1_:Number = NaN;
         var _loc5_:Number = NaN;
         var _loc4_:Number = NaN;
         var _loc6_:Number = NaN;
         var _loc10_:Number = NaN;
         _sceneWidth = Helpers.limitRange(StageReferance.stage.stageWidth,1000,1500);
         _sceneHeight = Helpers.limitRange(StageReferance.stage.stageHeight,600,900);
         var _loc8_:Number = _sceneWidth / 1500;
         var _loc2_:Number = _sceneWidth - _skillListOffsetX;
         _batterUIView.x = _sceneWidth - 280;
         _resistUIView1.x = 280;
         _resistUIView2.x = _sceneWidth - 280;
         _skillNameContainer.x = _sceneWidth * 0.5;
         _skillNameContainer.y = 270 * _loc8_;
         _teamStripContainer2.x = _sceneWidth - 190;
         if(_qteView)
         {
            _qteView.x = (_sceneWidth - _qteView.width) / 2;
            _qteView.y = _sceneHeight - 280;
         }
         if(container)
         {
            container.x = _sceneWidth / 2;
            container.y = _sceneHeight / 2 + 100;
         }
         var _loc7_:Number = (_sceneWidth - 1000) / 300;
         _loc7_ = 0.85 + _loc7_ * 0.15;
         var _loc3_:Number = _sceneWidth * 0.5;
         var _loc9_:Number = 500 * _loc7_;
         if(isPetChallenge || isMonopolyHelp || isBattleSign || isSpiritExpedition || isYLExpedtion || isDarkMaze)
         {
            if(_stripView)
            {
               _stripView.x = _sceneWidth * 0.5 - _finishNowBtn.width * 0.5;
               _stripView.y = _sceneHeight - _finishNowBtn.height + 5;
               if(_hideOthersBg)
               {
                  _hideOthersBg.x = _stripView.x + _finishNowBtn.width + 25;
                  _hideOthersBg.y = isSpiritExpedition ? _sceneHeight - _finishNowBtn.height - 20 : _sceneHeight - _finishNowBtn.height + 15;
               }
               if(_hideOthersBtn)
               {
                  _hideOthersBtn.x = _stripView.x + _finishNowBtn.width + 30;
                  _hideOthersBtn.y = isSpiritExpedition ? _sceneHeight - _finishNowBtn.height - 15 : _sceneHeight - _finishNowBtn.height + 20;
               }
               if(_consortiaChatBtn)
               {
                  _consortiaChatBtn.x = _stripView.x + _finishNowBtn.width * 0.5 - _chatMessageBtn.width * 0.5 - 30;
                  _consortiaChatBtn.y = _sceneHeight - _finishNowBtn.height - 8;
               }
               if(_chatMessageBtn)
               {
                  _chatMessageBtn.x = _stripView.x + _finishNowBtn.width * 0.5 - _chatMessageBtn.width * 0.5;
                  _chatMessageBtn.y = _sceneHeight - _finishNowBtn.height - 10;
               }
               if(_settingBtn)
               {
                  _settingBtn.x = _stripView.x + _finishNowBtn.width * 0.5 - _chatMessageBtn.width * 0.5 + 30;
                  _settingBtn.y = _sceneHeight - _finishNowBtn.height - 10;
               }
            }
            _autoFightBtn.visible = _autoFightStrip.visible = false;
         }
         else if(isSelfChess)
         {
            if(_hideOthersBg)
            {
               _hideOthersBg.x = _loc3_ + _loc9_ + 3;
               _hideOthersBg.y = _sceneHeight - 45;
            }
            if(_hideOthersBtn)
            {
               _hideOthersBtn.x = _loc3_ + _loc9_ + 8;
               _hideOthersBtn.y = _sceneHeight - 41;
            }
            _autoFightBtn.visible = false;
            if(_chatMessageBtn)
            {
               _chatMessageBtn.visible = false;
            }
            if(_consortiaChatBtn)
            {
               _consortiaChatBtn.visible = false;
            }
            if(_settingBtn)
            {
               _settingBtn.visible = false;
            }
         }
         else if(isPetBatle)
         {
            if(_petBar)
            {
               _loc1_ = (_sceneWidth - 1000) / 300;
               _loc1_ = 0.85 + _loc1_ * 0.15;
               _petBar.x = _sceneWidth * 0.5;
               _petBar.y = _sceneHeight;
               _petBar.scaleX = _petBar.scaleY = _loc1_;
               if(_hideOthersBg)
               {
                  _hideOthersBg.x = _petBar.x + 210 * _loc1_ + 145;
                  _hideOthersBg.y = _sceneHeight - 60 * _loc1_ - 5;
               }
               if(_hideOthersBtn)
               {
                  _hideOthersBtn.x = _petBar.x + 210 * _loc1_ + 150;
                  _hideOthersBtn.y = _sceneHeight - 60 * _loc1_;
               }
               if(_chatMessageBtn)
               {
                  _chatMessageBtn.x = _petBar.x + 210 * _loc1_ - 60 - 7;
                  _chatMessageBtn.y = _sceneHeight - 60 * _loc1_ - 35;
               }
               if(_consortiaChatBtn)
               {
                  _consortiaChatBtn.x = _petBar.x + 210 * _loc1_ - 90 - 7;
                  _consortiaChatBtn.y = _sceneHeight - 60 * _loc1_ - 33;
               }
            }
            _autoFightBtn.visible = _autoFightStrip.visible = false;
         }
         else if(isSacristyBatle)
         {
            if(_sacristyBar)
            {
               _loc5_ = (_sceneWidth - 1000) / 300;
               _loc5_ = 0.85 + _loc5_ * 0.15;
               _sacristyBar.x = _sceneWidth * 0.5;
               _sacristyBar.y = _sceneHeight;
               _sacristyBar.scaleX = _sacristyBar.scaleY = _loc5_;
               if(_autoFightBtn)
               {
                  _autoFightBtn.x = _sacristyBar.x + 210 * _loc5_ + 50 + 20;
                  _autoFightBtn.y = _sceneHeight - 63 - 18;
                  _hideOthersBg.y = _sceneHeight - 63;
                  _autoFightStrip.y = _sceneHeight - 63;
               }
               if(_hideOthersBg)
               {
                  _hideOthersBg.x = _sacristyBar.x + 210 * _loc5_ + 145;
                  _hideOthersBg.y = _sceneHeight - 60 * _loc5_ - 5;
               }
               if(_hideOthersBtn)
               {
                  _hideOthersBtn.x = _sacristyBar.x + 210 * _loc5_ + 150;
                  _hideOthersBtn.y = _sceneHeight - 60 * _loc5_;
               }
               if(_chatMessageBtn)
               {
                  _chatMessageBtn.x = _sacristyBar.x + 210 * _loc5_ - 60 - 97;
                  _chatMessageBtn.y = _sceneHeight - 60 * _loc5_ - 35;
               }
               if(_consortiaChatBtn)
               {
                  _consortiaChatBtn.visible = false;
                  _consortiaChatBtn.x = _sacristyBar.x + 210 * _loc5_ - 90 - 7;
                  _consortiaChatBtn.y = _sceneHeight - 60 * _loc5_ - 33;
               }
            }
            _autoFightBtn.visible = _autoFightStrip.visible = false;
         }
         else if(isChildpveBatle)
         {
            if(_childpveBar)
            {
               _loc4_ = (_sceneWidth - 1000) / 300;
               _loc4_ = 0.85 + _loc4_ * 0.15;
               _childpveBar.x = _sceneWidth * 0.5;
               _childpveBar.y = _sceneHeight;
               _childpveBar.scaleX = _childpveBar.scaleY = _loc4_;
               if(_hideOthersBg)
               {
                  _hideOthersBg.x = _childpveBar.x + 210 * _loc4_ + 145;
                  _hideOthersBg.y = _sceneHeight - 60 * _loc4_ - 5;
               }
               if(_hideOthersBtn)
               {
                  _hideOthersBtn.x = _childpveBar.x + 210 * _loc4_ + 150;
                  _hideOthersBtn.y = _sceneHeight - 60 * _loc4_;
               }
               if(_chatMessageBtn)
               {
                  _chatMessageBtn.x = _childpveBar.x + 210 * _loc4_ - 60 - 7;
                  _chatMessageBtn.y = _sceneHeight - 60 * _loc4_ - 35;
               }
               if(_consortiaChatBtn)
               {
                  _consortiaChatBtn.x = _childpveBar.x + 210 * _loc4_ - 90 - 7;
                  _consortiaChatBtn.y = _sceneHeight - 60 * _loc4_ - 33;
               }
            }
            _autoFightBtn.visible = _autoFightStrip.visible = false;
         }
         else if(battleModel.isChildBattle)
         {
            if(_childCommomBar)
            {
               _loc6_ = (_sceneWidth - 1000) / 300;
               _loc6_ = 0.85 + _loc6_ * 0.15;
               _childCommomBar.x = _sceneWidth * 0.5;
               _childCommomBar.y = _sceneHeight;
               _childCommomBar.scaleX = _childCommomBar.scaleY = _loc6_;
               if(_hideOthersBg)
               {
                  _hideOthersBg.x = _childCommomBar.x + 210 * _loc6_ + 35;
                  _hideOthersBg.y = _sceneHeight - 60 * _loc6_;
               }
               if(_hideOthersBtn)
               {
                  _hideOthersBtn.x = _childCommomBar.x + 210 * _loc6_ + 40;
                  _hideOthersBtn.y = _sceneHeight - 60 * _loc6_ + 5;
               }
               if(_chatMessageBtn)
               {
                  _chatMessageBtn.x = _childCommomBar.x + 150 * _loc6_ - 60 - 7;
                  _chatMessageBtn.y = _sceneHeight - 60 * _loc6_ - 35;
               }
               if(_consortiaChatBtn)
               {
                  _consortiaChatBtn.x = _childCommomBar.x + 150 * _loc6_ - 90 - 7;
                  _consortiaChatBtn.y = _sceneHeight - 60 * _loc6_ - 33;
               }
               if(battleModel.battleType == 3911)
               {
                  _chatMessageBtn.x = 948;
                  _consortiaChatBtn.x = 918;
                  _hideOthersBg.x = 1080;
                  _hideOthersBtn.x = 1086;
               }
            }
            _autoFightBtn.visible = _autoFightStrip.visible = false;
         }
         else if(battleModel.isMonsterBattle)
         {
            if(_monsterCommomBar)
            {
               _loc10_ = (_sceneWidth - 1000) / 300;
               _loc10_ = 0.85 + _loc10_ * 0.15;
               _monsterCommomBar.x = _sceneWidth * 0.5;
               _monsterCommomBar.y = _sceneHeight;
               _monsterCommomBar.scaleX = _monsterCommomBar.scaleY = _loc10_;
               if(_hideOthersBg)
               {
                  _hideOthersBg.x = _monsterCommomBar.x + 210 * _loc10_ + 35;
                  _hideOthersBg.y = _sceneHeight - 60 * _loc10_;
               }
               if(_hideOthersBtn)
               {
                  _hideOthersBtn.x = _monsterCommomBar.x + 210 * _loc10_ + 40;
                  _hideOthersBtn.y = _sceneHeight - 60 * _loc10_ + 5;
               }
               if(_chatMessageBtn)
               {
                  _chatMessageBtn.x = _monsterCommomBar.x + 150 * _loc10_ - 60 - 7;
                  _chatMessageBtn.y = _sceneHeight - 60 * _loc10_ - 35;
               }
               if(_consortiaChatBtn)
               {
                  _consortiaChatBtn.x = _monsterCommomBar.x + 150 * _loc10_ - 90 - 7;
                  _consortiaChatBtn.y = _sceneHeight - 60 * _loc10_ - 33;
               }
            }
            _autoFightBtn.visible = _autoFightStrip.visible = false;
         }
         else if(_bottomBar)
         {
            _bottomBar.x = _sceneWidth * 0.5;
            _bottomBar.y = _sceneHeight;
            _bottomBar.scaleX = _bottomBar.scaleY = _loc7_;
            if(_autoFightBtn)
            {
               _autoFightBtn.x = _bottomBar.x + 500 * _loc7_ + 10;
               _autoFightStrip.x = _autoFightBtn.x;
               _autoFightBtn.y = _sceneHeight - 63;
               _hideOthersBg.y = _sceneHeight - 63;
               _autoFightStrip.y = _sceneHeight - 63;
            }
            if(_hideOthersBg)
            {
               if(_autoFightBtn)
               {
                  _hideOthersBg.x = _autoFightBtn.x + _autoFightBtn.width;
               }
               else
               {
                  _hideOthersBg.x = _bottomBar.x + _bottomBar.width * 0.5 + 17;
               }
               _hideOthersBg.y = _sceneHeight - 50;
            }
            if(_hideOthersBtn)
            {
               if(_autoFightBtn)
               {
                  _hideOthersBtn.x = _autoFightBtn.x + _autoFightBtn.width + 12;
               }
               else
               {
                  _hideOthersBtn.x = _bottomBar.x + _bottomBar.width * 0.5 + 22;
               }
               _hideOthersBtn.y = _sceneHeight - 45;
            }
            if(_chatMessageBtn)
            {
               _chatMessageBtn.x = _bottomBar.x + 210 * _loc7_ - 60 - 7;
               _chatMessageBtn.y = _sceneHeight - 60 * _loc7_ - 35;
            }
            if(_consortiaChatBtn)
            {
               _consortiaChatBtn.x = _bottomBar.x + 210 * _loc7_ - 90 - 7;
               _consortiaChatBtn.y = _sceneHeight - 60 * _loc7_ - 33;
            }
            if(_warsoulEndBtn)
            {
               _warsoulEndBtn.x = _bottomBar.x + 500 * _loc7_ + 10;
               _warsoulEndBtn.y = _sceneHeight - 120;
            }
         }
         if(_dragonTitanOfTeamMate)
         {
            _dragonTitanOfTeamMate.x = 0;
            _dragonTitanOfTeamMate.y = _sceneHeight * 0.5 - 130;
         }
         if(_dragonTitanOfEnemies)
         {
            _dragonTitanOfEnemies.x = _sceneWidth - 120;
            _dragonTitanOfEnemies.y = _sceneHeight * 0.5 - 130;
         }
         if(_selfGoddessTopView)
         {
            _selfGoddessTopView.x = _sceneWidth / 2 - 480;
            _selfGoddessTopView.y = -20;
         }
         if(_vsGoddessTopView)
         {
            _vsGoddessTopView.x = _sceneWidth / 2 + 40;
            _vsGoddessTopView.y = -20;
         }
         if(_hurtUpView)
         {
            _hurtUpView.x = _sceneWidth * 0.5 - 30;
         }
         if(_trailCountView)
         {
            _trailCountView.x = _sceneWidth - 123;
            _trailCountView.y = 175;
         }
         if(_battleSpaceTimeView)
         {
            _battleSpaceTimeView.x = (_sceneWidth - 187) / 2;
         }
         if(_raceAgainstTimeUpView)
         {
            _raceAgainstTimeUpView.x = (_sceneWidth - _raceAgainstTimeUpView.width) / 2 + 45;
            _raceAgainstTimeUpView.y = 0;
         }
         if(_forbiddenBossUIView)
         {
            _forbiddenBossUIView.x = (_sceneWidth - _forbiddenBossUIView.width) / 2;
            _forbiddenBossUIView.y = -6;
         }
         if(BattleManager.getInstance().battleModel.battleType == 295)
         {
            _autoFightBtn.visible = _autoFightStrip.visible = false;
         }
         if(_killSelfBtn)
         {
            if(_bottomBar)
            {
               _killSelfBtn.x = _bottomBar.x + _bottomBar.width * 0.5 + 30;
               _killSelfBtn.y = _sceneHeight - 63 - 30;
            }
            else
            {
               _killSelfBtn.x = _sceneWidth - 200;
               _killSelfBtn.y = _sceneHeight - 63 - 30;
            }
            if(_immediatelyWinBtn)
            {
               _immediatelyWinBtn.x = _killSelfBtn.x;
               _immediatelyWinBtn.y = _killSelfBtn.y - 30;
            }
         }
         if(hasGoddessUI && _hurtUpView && _hurtUpView.parent)
         {
            _autoFightFlag.x = (_sceneWidth - _autoFightFlag.width) * 0.5;
            _autoFightFlag.y = 137 * _loc8_ + 30;
         }
         else
         {
            _autoFightFlag.x = (_sceneWidth - _autoFightFlag.width) * 0.5;
            _autoFightFlag.y = 137 * _loc8_;
            if(battleModel.battleType == 3886)
            {
               _autoFightFlag.y += 80;
            }
         }
      }
      
      private function init() : void
      {
         var _loc3_:* = undefined;
         var _loc4_:* = undefined;
         var _loc2_:Number = NaN;
         var _loc1_:Date = null;
         if(isPetBatle)
         {
            _petBar = new PetBattleBar(SharedManager.instance.allowSceneEffect);
         }
         else if(isSacristyBatle)
         {
            _sacristyBar = new PetSacristyBar(SharedManager.instance.allowSceneEffect);
         }
         else if(isChildpveBatle)
         {
            _childpveBar = new ChildpveBattleBar(SharedManager.instance.allowSceneEffect);
         }
         else if(!(isSpiritExpedition || isDarkMaze))
         {
            if(battleModel.isChildBattle)
            {
               _childCommomBar = new ChildCommonBottomBar(SharedManager.instance.allowSceneEffect);
            }
            else if(battleModel.isMonsterBattle)
            {
               _monsterCommomBar = new MonsterCommonBottomBar(SharedManager.instance.allowSceneEffect);
            }
            else if(isSpaceTimeBattle)
            {
               _battleSpaceTimeView = new BattleSpaceTimeView();
               _bottomBar = new BottomBar(SharedManager.instance.allowSceneEffect);
            }
            else if(!(isPetChallenge || isYLExpedtion || isSelfChess))
            {
               _bottomBar = new BottomBar(SharedManager.instance.allowSceneEffect);
            }
         }
         if(!isNoHeroBattleType())
         {
            if(hasTitanInThisBattle() && Boolean(ConfigManager.version_info.TAITAN_LOCK))
            {
               if(BattleFunctionHelper.instance.hasHeroBySide(enemySide))
               {
                  _dragonTitanOfTeamMate = new DragonTitanTeamView(selfSide);
                  _dragonTitanOfEnemies = new DragonTitanTeamView(enemySide);
               }
               else if(BattleFunctionHelper.instance.hasHeroBySide(selfSide))
               {
                  _dragonTitanOfTeamMate = new DragonTitanTeamView(selfSide);
               }
            }
         }
         var _loc6_:Array = BattleFunctionHelper.instance.showGoddessTopAry();
         if(_loc6_[0])
         {
            _selfGoddessTopView = new BattleGoddessTopView(selfSide);
            _selfGoddessTopView.x = _sceneWidth / 2 - 480;
            _selfGoddessTopView.y = -20;
            addChild(_selfGoddessTopView);
         }
         if(_loc6_[1])
         {
            _vsGoddessTopView = new BattleGoddessTopView(enemySide);
            _vsGoddessTopView.x = _sceneWidth / 2 + 40;
            _vsGoddessTopView.y = -20;
            addChild(_vsGoddessTopView);
         }
         container = new TileContainer();
         addChild(container);
         _finishNowBtn = ComponentFactory.Instance.creat("battle.petChallenge.finishNowBtn");
         _settingBtn = ComponentFactory.Instance.creat("battle.petChallenge.settingBtn");
         _settingBtn.tipData = LanguageMgr.GetTranslation("battle.view.bottom.BottomBar.settingBtn.tipData");
         _stripView = ComponentFactory.Instance.creatComponentByStylename("battle.petChallenge.finishNowBtnTip");
         _stripView.x = _finishNowBtn.x;
         _stripView.y = _finishNowBtn.y;
         _finishNowBtn.x = 0;
         _finishNowBtn.y = 0;
         _stripView.addChild(_finishNowBtn);
         _countdownTxt = ComponentFactory.Instance.creatComponentByStylename("battle.petChallenge.countdownTxt");
         _countdownTxt2 = ComponentFactory.Instance.creatComponentByStylename("battle.petChallenge.countdownTxt");
         _countdownNumTxt = ComponentFactory.Instance.creatComponentByStylename("battle.petChallenge.countdownNumTxt");
         _stripView.addChild(_countdownTxt);
         _stripView.addChild(_countdownTxt2);
         _stripView.addChild(_countdownNumTxt);
         _countdownTxt.text = LanguageMgr.GetTranslation("battle.petChallenge.countdownTxt");
         _countdownTxt2.text = LanguageMgr.GetTranslation("task.view.TaskMobilePhoneView.Text1");
         _countdownNumTxt.text = "10";
         _countdownNumTxt.x = _countdownTxt.x + _countdownTxt.textWidth + 10;
         _countdownTxt2.x = _countdownNumTxt.x + _countdownNumTxt.textWidth + 10;
         _countdownNumTxt.visible = false;
         _countdownTxt.visible = false;
         _countdownTxt2.visible = false;
         _warsoulEndBtn = ComponentFactory.Instance.creat("battle.petChallenge.warsoulEndBtn");
         _warsoulEndBtn.visible = false;
         var _loc5_:VipInfo = VIPManager.Instance.model.vipInfo;
         if(!_loc5_.IsVipAndNoExpirt || _loc5_.VipGrade < 3)
         {
            _stripView.tipData = LanguageMgr.GetTranslation("BattleUIView.vip3");
         }
         else if(battleModel.battleType == 16)
         {
            _stripView.tipData = LanguageMgr.GetTranslation("battle.petChallenge.countdownTxtTip",10);
         }
         else
         {
            _stripView.tipData = LanguageMgr.GetTranslation("battle.petChallenge.countdownTxtTip",10);
         }
         _finishNowBtn.enable = false;
         if(battleModel.battleType == 3905)
         {
            addChild(_warsoulEndBtn);
         }
         if(isPetChallenge || isMonopolyHelp || isBattleSign)
         {
            addChild(_stripView);
            addChild(_settingBtn);
         }
         else if(isPetBatle)
         {
            addChild(_petBar);
         }
         else if(isSacristyBatle)
         {
            addChild(_sacristyBar);
         }
         else if(isChildpveBatle)
         {
            addChild(_childpveBar);
         }
         else if(isSpiritExpedition)
         {
            addChild(_settingBtn);
         }
         else if(isYLExpedtion)
         {
            addChild(_settingBtn);
         }
         else if(isDarkMaze)
         {
            addChild(_settingBtn);
         }
         else if(battleModel.isChildBattle)
         {
            addChild(_childCommomBar);
         }
         else if(battleModel.isMonsterBattle)
         {
            addChild(_monsterCommomBar);
         }
         else if(isSpaceTimeBattle)
         {
            addChild(_battleSpaceTimeView);
            addChild(_bottomBar);
         }
         else if(!isSelfChess)
         {
            addChild(_bottomBar);
         }
         if(!isNoHeroBattleType())
         {
            if(_dragonTitanOfTeamMate)
            {
               addChild(_dragonTitanOfTeamMate);
            }
            if(_dragonTitanOfEnemies)
            {
               addChild(_dragonTitanOfEnemies);
            }
         }
         if(battleModel.isPvP())
         {
            _hurtUpView = new HurtUpView(battleModel.getHurtMode());
            addChild(_hurtUpView);
         }
         if(battleModel.isTrail() || isSpaceTimeBattle)
         {
            _trailCountView = new TrailCountView();
            addChild(_trailCountView);
         }
         if(battleModel.isRaceAgainstTime())
         {
            _trailCountView = new TrailCountView();
            addChild(_trailCountView);
            _raceAgainstTimeUpView = new RaceAgainstTimeUpView();
            addChild(_raceAgainstTimeUpView);
         }
         if(battleModel.isForbiddenBoss())
         {
            _forbiddenBossUIView = new ForbiddenBossUIView();
            addChild(_forbiddenBossUIView);
         }
         if(battleModel.isWarSoulTower())
         {
            _trailCountView = new TrailCountView();
            addChild(_trailCountView);
         }
         _batterUIView = new BatterUIView();
         _batterUIView.visible = false;
         _batterUIView.y = 174;
         _resistUIView1 = new ResistUIView(1);
         _resistUIView2 = new ResistUIView(2);
         _resistUIView1.visible = false;
         _resistUIView2.visible = false;
         _resistUIView1.y = 185;
         _resistUIView2.y = 185;
         switch(battleModel.battleType)
         {
            case 310:
            case 3852:
               _doubleBossShow = new RoleShowViewIII();
               _resistUIView1.y = 265;
               _resistUIView2.y = 215;
               break;
            case 311:
            case 312:
               _loc3_ = new <String>["asset.battle.BossShowRightAsset","asset.battle.LiteBossBloodBar_0"];
               _loc4_ = new <int>[0,673];
               _mutilRoleShowView = new MutilBossShowView(_loc3_,_loc4_);
               break;
            case 313:
               _loc3_ = new <String>["asset.battle.BossShowRightAsset","asset.battle.LiteBossBloodBar_1","asset.battle.LiteBossBloodBar_1"];
               _loc4_ = new <int>[0,790,790];
               _mutilRoleShowView = new MutilBossShowView(_loc3_,_loc4_);
               break;
            case 295:
               _roleShowII = new RoleShowViewII();
               _resistUIView1.y = 250;
               _resistUIView2.y = 250;
               break;
            case 3855:
               _outyardShowView = new OutyardShowView();
               break;
            case 349:
            case 3867:
            case 3889:
               break;
            default:
               _roleShowII = new RoleShowViewII();
               _resistUIView1.y = 265;
               _resistUIView2.y = 215;
         }
         _skillNameContainer = new SkillNameContainer();
         if(_roleShowII)
         {
            addChild(_roleShowII);
         }
         if(_outyardShowView)
         {
            addChild(_outyardShowView);
         }
         if(_doubleBossShow)
         {
            addChild(_doubleBossShow);
         }
         if(_mutilRoleShowView)
         {
            addChild(_mutilRoleShowView);
            updateMutilRoleShowView();
         }
         addChild(_resistUIView1);
         addChild(_resistUIView2);
         addChild(_skillNameContainer);
         _chatMessageBtn = ComponentFactory.Instance.creat("battle.chatMessageBtn");
         _consortiaChatBtn = ComponentFactory.Instance.creat("maintoolbar.ConsortiaChatBtn");
         _chatMessageBtn.tipData = LanguageMgr.GetTranslation("battle.view.ui.BattleUIView.msgBoxTip");
         _consortiaChatBtn.tipData = LanguageMgr.GetTranslation("consortiagroupchat.msgBoxItemNameTxt");
         setMsgBtnShining();
         setConsortiaChatBtnShining();
         if(ArmyManager.instance.thane.grades >= 6)
         {
            addChild(_chatMessageBtn);
         }
         if(PlayerManager.instance.currentPlayerModel.playerInfo.consortiaID > 0)
         {
            addChild(_consortiaChatBtn);
         }
         _addSpBallLayer = new Sprite();
         _addSpBallLayer.mouseChildren = _addSpBallLayer.mouseEnabled = false;
         addChild(_addSpBallLayer);
         _autoFightFlag = ComponentFactory.Instance.creatBitmap("asset.battle.AutoFightFlagAsset");
         _autoFightBtn = ComponentFactory.Instance.creatComponentByStylename("battle.AutoFightBtn2");
         _autoFightStrip = ComponentFactory.Instance.creatCustomObject("battle.autoFightStrip");
         updateAutoFightBtn(battleModel.getAutoFightFlag());
         _autoFightBtn.addEventListener("click",onAutoFightClick);
         NotificationManager.instance.addEventListener("autoFightChanged",onAutoFightChanged);
         addChild(_autoFightBtn);
         addChild(_autoFightStrip);
         _autoFightStrip.setTarget(_autoFightBtn);
         _autoFightStrip.tipData = LanguageMgr.GetTranslation("store.view.StoreFrame.command01",15);
         if(ArmyManager.instance.thane.grades >= 15)
         {
            _autoFightStrip.visible = false;
         }
         else
         {
            battleAutoFightEnable = false;
            _autoFightStrip.visible = true;
         }
         _hideOthersBg = ComponentFactory.Instance.creatComponentByStylename("battle.HideOthersBg");
         _hideOthersBtn = ComponentFactory.Instance.creatComponentByStylename("battle.HideOthersBtn");
         _hideOthersBtn.addEventListener("click",onHideOthersClick);
         _hideOthersBtn.selected = SharedManager.instance.hideOthersInBattle;
         _preSelected = SharedManager.instance.hideOthersInBattle;
         _hideOthersBtn.text = LanguageMgr.GetTranslation("battle.view.ui.BattleUIView.hideOthersTip");
         if(ArmyManager.instance.thane.grades > 0)
         {
            addChild(_hideOthersBg);
            addChild(_hideOthersBtn);
         }
         FrameControllerManager.instance.consortiaGroupChatControler.model.isOpenGroupChatTip = true;
         _teamStripContainer1 = ComponentFactory.Instance.creatComponentByStylename("battle.teamStripContainer1");
         _teamStripContainer2 = ComponentFactory.Instance.creatComponentByStylename("battle.teamStripContainer2");
         addChild(_teamStripContainer1);
         addChild(_teamStripContainer2);
         if(BattleManager.getInstance().battleModel.battleType == 295)
         {
            _loc1_ = new Date();
            BattleManager.getInstance().battleModel.trialLayer = BattleManager.molongLayer;
            _trailCountView = new TrailCountView();
            addChild(_trailCountView);
         }
         if(StageReferance.isDebug)
         {
            _killSelfBtn = ComponentFactory.Instance.creatComponentByStylename("core.UseButton");
            _killSelfBtn.addEventListener("click",_onKillSelfClick);
            _killSelfBtn.text = "自杀结束战斗";
            addChild(_killSelfBtn);
            _immediatelyWinBtn = ComponentFactory.Instance.creatComponentByStylename("core.UseButton");
            _immediatelyWinBtn.addEventListener("click",_onKillSelfClick);
            _immediatelyWinBtn.text = "胜利结束战斗";
            addChild(_immediatelyWinBtn);
         }
      }
      
      private function get selfSide() : int
      {
         return battleModel.selfSide;
      }
      
      private function get enemySide() : int
      {
         return 3 - battleModel.selfSide;
      }
      
      private function hasTitanInThisBattle() : Boolean
      {
         var _loc3_:HeroRoleInfo = null;
         var _loc2_:int = 0;
         var _loc1_:Boolean = false;
         _loc2_ = 0;
         while(_loc2_ < 4)
         {
            _loc3_ = battleModel.heroList[_loc2_ + "_" + selfSide];
            if(_loc3_ && _loc3_.titanId > 0)
            {
               return true;
            }
            _loc3_ = battleModel.heroList[_loc2_ + "_" + enemySide];
            if(_loc3_ && _loc3_.titanId > 0)
            {
               return true;
            }
            _loc2_++;
         }
         return false;
      }
      
      private function isNoHeroBattleType() : Boolean
      {
         return battleModel.battleType == 3847 || battleModel.battleType == 3845 || battleModel.battleType == 3844 || battleModel.battleType == 35 || battleModel.battleType == 3867 || battleModel.battleType == 3889 || battleModel.battleType == 3895 || battleModel.battleType == 3868 || battleModel.battleType == 3898 || battleModel.battleType == 3907;
      }
      
      private function _onKillSelfClick(param1:MouseEvent) : void
      {
         var _loc3_:int = 2;
         if(param1.currentTarget == _immediatelyWinBtn)
         {
            _loc3_ = 1;
         }
         var _loc4_:PackageOut = new PackageOut(14002);
         var _loc2_:BattleReqMsg = new BattleReqMsg();
         _loc2_.battleId = BattleManager.getInstance().battleModel.battleId;
         _loc2_.otherObj = _loc3_;
         SocketSendManager.instance.sendProtoBuffer(_loc4_,_loc2_);
      }
      
      public function updateMutilRoleShowView(... rest) : void
      {
         var _loc2_:Boolean = false;
         switch(int(battleModel.battleType) - 311)
         {
            case 0:
            case 1:
            case 2:
               _loc2_ = Boolean(rest.length > 0 ? rest[0] : false);
               nldlyiUpdateMutilRoleShowView(_loc2_);
               return;
            default:
               return;
         }
      }
      
      private function nldlyiUpdateMutilRoleShowView(param1:Boolean) : void
      {
         var _loc2_:* = undefined;
         var _loc7_:HeroRoleInfo = null;
         var _loc5_:GameHeroTempInfo = null;
         var _loc3_:* = 0;
         var _loc8_:* = 0;
         var _loc4_:* = 0;
         var _loc6_:HeroRoleInfo = battleModel.armyInfoRight.boss;
         if(param1)
         {
            _mutilRoleShowView.resetRoleData(_loc6_);
         }
         else
         {
            _loc2_ = new <HeroRoleInfo>[_loc6_];
            _loc3_ = uint(battleModel._heroTempId.length);
            _loc4_ = 0;
            while(_loc4_ < _loc3_)
            {
               _loc8_ = uint(battleModel._heroTempId[_loc4_]);
               if(_loc8_ != _loc6_.templateId)
               {
                  _loc7_ = new HeroRoleInfo();
                  _loc7_.templateId = _loc8_;
                  _loc7_.heroInfo.templateId = _loc8_;
                  _loc5_ = TempleteManager.instance.gameHeroTemplateCate.getTemplateByID(_loc8_);
                  _loc7_.heroInfo.nickName = _loc5_.TemplateName;
                  _loc7_.totalBloodA = _loc5_.Live;
                  _loc7_.bloodA = _loc4_ < battleModel._life.length ? Int64Utils.int64ToNumber(battleModel._life[_loc4_]) : Number(_loc7_.totalBloodA);
                  _loc2_.push(_loc7_);
               }
               _loc4_++;
            }
            _mutilRoleShowView.setRoleData(_loc2_,_loc6_);
            if(battleModel.battleType == 313)
            {
               _nldlyiSynBloodRoleInfo = _loc6_;
               _mutilRoleShowView.worldBossRoleInfo = _loc6_;
            }
            else
            {
               _nldlyiSynBloodRoleInfo = _loc7_;
               _mutilRoleShowView.worldBossRoleInfo = null;
            }
            if(!SocketManager.instance.hasEventListener("SLGSocketEvent" + 4794))
            {
               SocketManager.instance.addEventListener("SLGSocketEvent" + 4794,nldlyiOtherBossHPSyncHandler);
            }
         }
      }
      
      private function nldlyiOtherBossHPSyncHandler(param1:SLGSocketEvent) : void
      {
         var _loc4_:Boolean = false;
         var _loc6_:Number = NaN;
         var _loc5_:int = 0;
         var _loc8_:PackageIn = param1.data as PackageIn;
         var _loc2_:WorldBossInfoMsg = new WorldBossInfoMsg();
         _loc2_ = _loc8_.readBody(_loc2_) as WorldBossInfoMsg;
         var _loc7_:Number = Number(Int64Utils.int64ToNumber(_loc2_.currentMillis));
         var _loc3_:Number = Number(Int64Utils.int64ToNumber(_loc2_.curHp));
         if(_nldlyiSynBloodRoleInfo != null)
         {
            if(battleModel.battleType == 313)
            {
               BattleManager.getInstance().battleModel.updateWorldBossBlood(_loc3_,_loc7_);
            }
            else
            {
               _loc4_ = _loc3_ - _nldlyiSynBloodRoleInfo.bloodA > _nldlyiSynBloodRoleInfo.totalBloodA * 0.6;
               _loc6_ = _nldlyiSynBloodRoleInfo.bloodA - _loc3_;
               _nldlyiSynBloodRoleInfo.bloodA = _loc3_;
               if(_loc4_)
               {
                  _mutilRoleShowView.resetRoleData(_nldlyiSynBloodRoleInfo);
               }
               else
               {
                  _mutilRoleShowView.playDamageNumEffect(_nldlyiSynBloodRoleInfo.templateId,_loc6_);
               }
               _nldlyiSynBloodRoleInfo.dispatchEvent(new RoleEvent("bloodChange",_nldlyiSynBloodRoleInfo));
            }
            _loc5_ = int(battleModel._heroTempId.indexOf(_nldlyiSynBloodRoleInfo.templateId));
            if(_loc5_ >= 0 && _loc5_ < battleModel._life.length)
            {
               battleModel._life[_loc5_] = Int64Utils.numberToInt64(_nldlyiSynBloodRoleInfo.bloodA);
            }
         }
      }
      
      public function addTeamStrip(param1:HeroRoleInfo) : void
      {
         var _loc2_:TeamStrip = null;
         if(param1 == null)
         {
            return;
         }
         if(param1.isPetFake)
         {
            return;
         }
         if(param1.isChildFake)
         {
            return;
         }
         if(param1 is MonsterRoleInfo)
         {
            return;
         }
         if(param1 is SelfChessRoleInfo)
         {
            return;
         }
         if(battleModel.battleType == 3907)
         {
            return;
         }
         var _loc3_:int = int(battleModel.selfSide);
         if(param1.side == _loc3_)
         {
            if(param1.heroInfo.userId != ArmyManager.instance.thane.userId)
            {
               _loc2_ = new TeamStrip(param1,1);
               _teamStripContainer1.addChild(_loc2_);
               if(_teamStripHashmap == null)
               {
                  _teamStripHashmap = new HashMap();
               }
               _teamStripHashmap.put(param1.userId,_loc2_);
            }
         }
         else
         {
            _teamStripContainer2.addChild(new TeamStrip(param1,2));
         }
      }
      
      public function removeDieRole(param1:int) : void
      {
         if(!_teamStripHashmap)
         {
            return;
         }
         var _loc2_:TeamStrip = _teamStripHashmap.getValue(param1) as TeamStrip;
         if(_loc2_ && _teamStripContainer1.contains(_loc2_))
         {
            _teamStripContainer1.removeChild(_loc2_);
            _teamStripHashmap.remove(param1);
         }
      }
      
      private function onAutoFightChanged(param1:NotificationEvent) : void
      {
         if(battleModel && !battleModel.isOver)
         {
            updateAutoFightBtn(battleModel.getAutoFightFlag());
         }
      }
      
      private function updateAutoFightBtn(param1:int) : void
      {
         if(param1 == 1)
         {
            _autoFightBtn.selected = false;
            if(!_autoFightFlag.parent)
            {
               addChild(_autoFightFlag);
            }
            _skillListOffsetX = 0;
         }
         else
         {
            _autoFightBtn.selected = true;
            if(_autoFightFlag.parent)
            {
               removeChild(_autoFightFlag);
            }
            _skillListOffsetX = 320;
         }
         var _loc3_:Boolean = battleModel.isMultiPlayer() || !BattleModel.allowAutoFight;
         if(battleModel.battleType == 3846)
         {
            _autoFightBtn.visible = _autoFightStrip.visible = false;
         }
         if(_loc3_)
         {
            if(_autoFightBtn)
            {
               battleAutoFightEnable = false;
            }
         }
         var _loc2_:int = int(Helpers.limitRange(StageReferance.stage.stageWidth,1000,1500));
      }
      
      private function onAutoFightClick(param1:MouseEvent) : void
      {
         var _loc2_:String = null;
         if(!_autoFightBtn.enable)
         {
            return;
         }
         if(battleModel.isMultiPlayer() && battleModel.battleType != 3886)
         {
            _autoFightBtn.selected = true;
            _loc2_ = LanguageMgr.GetTranslation("battle.view.ui.BattleUIView.command01");
            MessageTipManager.instance().show(_loc2_,true,null,true);
            return;
         }
         if(battleModel.getAutoFightFlag() == 1)
         {
            battleModel.setAutoFight(2);
         }
         else
         {
            battleModel.setAutoFight(1);
         }
      }
      
      public function get autoFightBtn() : SelectedButton
      {
         return _autoFightBtn;
      }
      
      private function onHideOthersClick(param1:MouseEvent) : void
      {
         SharedManager.instance.hideOthersInBattle = _hideOthersBtn.selected;
         SharedManager.instance.saveHideOthersInBattle();
         _preSelected = _hideOthersBtn.selected;
         battleModel.otherLivingVisible = !_hideOthersBtn.selected;
      }
      
      public function getDragonTitanOfTeamMate() : DragonTitanTeamView
      {
         return _dragonTitanOfTeamMate;
      }
      
      public function getDragonTitanOfEnemies() : DragonTitanTeamView
      {
         return _dragonTitanOfEnemies;
      }
      
      public function getBottomBar() : *
      {
         if(isSacristyBatle)
         {
            return _sacristyBar;
         }
         return _bottomBar;
      }
      
      public function get hasGoddessUI() : Boolean
      {
         if(_selfGoddessTopView || _vsGoddessTopView)
         {
            return true;
         }
         return false;
      }
      
      public function getHideBtn() : SelectedIconTextButton
      {
         return _hideOthersBtn;
      }
      
      public function showTopView() : void
      {
         if(_outyardShowView)
         {
            _outyardShowView.visible = true;
         }
         if(_roleShowII)
         {
            _roleShowII.visible = true;
         }
         if(_doubleBossShow)
         {
            _doubleBossShow.visible = true;
         }
         if(_mutilRoleShowView)
         {
            _mutilRoleShowView.visible = true;
         }
      }
      
      public function hideTopView() : void
      {
         if(_outyardShowView)
         {
            _outyardShowView.visible = false;
         }
         if(_roleShowII)
         {
            _roleShowII.visible = false;
         }
         if(_doubleBossShow)
         {
            _doubleBossShow.visible = false;
         }
         if(_mutilRoleShowView)
         {
            _mutilRoleShowView.visible = false;
         }
      }
      
      public function getAddSpBallLayer() : Sprite
      {
         return _addSpBallLayer;
      }
      
      public function getAddSpDestPoint() : Point
      {
         var _loc1_:Point = _bottomBar.getSpGlobalPos();
         return _addSpBallLayer.globalToLocal(_loc1_);
      }
      
      public function getAddHitPointDestPoint() : Point
      {
         var _loc1_:Point = _bottomBar.getHitPointGlobalPos();
         return _addSpBallLayer.globalToLocal(_loc1_);
      }
      
      private function __skillUseSuccess(param1:NotificationEvent) : void
      {
         if(int(param1.data[1]) > 0 && battleModel && !battleModel.isControledByBoss())
         {
            if(_qteView)
            {
               _qteView.dispose();
            }
            _qteView = null;
            _qteView = new QteView(param1.data);
            addChild(_qteView);
            _qteView.x = (_sceneWidth - _qteView.width) / 2;
            _qteView.y = _sceneHeight - 280;
         }
         if(!battleModel.isAutoFight)
         {
            BattleManager.getInstance().battleMap.addSkillAimFlag(param1.data[3]);
         }
      }
      
      private function get battleModel() : BattleModel
      {
         return BattleManager.getInstance().battleModel;
      }
      
      private function get isBattleSign() : Boolean
      {
         var _loc1_:Boolean = false;
         if(battleModel.battleType == 16)
         {
            _loc1_ = true;
         }
         return _loc1_;
      }
      
      private function get isPetChallenge() : Boolean
      {
         if(battleModel.battleType == 35)
         {
            return true;
         }
         return false;
      }
      
      private function get isYLExpedtion() : Boolean
      {
         if(battleModel.battleType == 3896)
         {
            return true;
         }
         return false;
      }
      
      private function get isSpiritExpedition() : Boolean
      {
         if(battleModel.battleType == 3895)
         {
            return true;
         }
         return false;
      }
      
      private function get isDarkMaze() : Boolean
      {
         if(battleModel.battleType == 3898)
         {
            return true;
         }
         return false;
      }
      
      private function get isShadowLand() : Boolean
      {
         if(battleModel.battleType == 3897)
         {
            return true;
         }
         return false;
      }
      
      private function get isPetBatle() : Boolean
      {
         if(battleModel.battleType == 3844)
         {
            return true;
         }
         return false;
      }
      
      private function get isSacristyBatle() : Boolean
      {
         if(battleModel.battleType == 3866 || battleModel.battleType == 3864)
         {
            return true;
         }
         return false;
      }
      
      private function get isSelfChess() : Boolean
      {
         if(battleModel.battleType == 349)
         {
            return true;
         }
         return false;
      }
      
      private function get isSpaceTimeBattle() : Boolean
      {
         if(battleModel.battleType == 3870)
         {
            return true;
         }
         return false;
      }
      
      private function get isChildpveBatle() : Boolean
      {
         if(battleModel.battleType == 3845)
         {
            return true;
         }
         return false;
      }
      
      private function get isChildArenaBattle() : Boolean
      {
         if(battleModel.battleType == 3847)
         {
            return true;
         }
         return false;
      }
      
      private function get isMonopolyHelp() : Boolean
      {
         if(battleModel.battleType == 307)
         {
            return true;
         }
         return false;
      }
      
      public function reFreshBuffer(param1:Vector.<BufferDamageData>) : void
      {
         var _loc2_:int = 0;
         var _loc3_:Vector.<BufferDamageData> = new Vector.<BufferDamageData>();
         if(_roleShowII && _roleShowII.bossBufferContainer && param1)
         {
            _loc2_ = 0;
            while(_loc2_ < param1.length)
            {
               if(_roleShowII.livingId == param1[_loc2_].target)
               {
                  _loc3_.push(param1[_loc2_]);
               }
               _loc2_++;
            }
            _roleShowII.bossBufferContainer.reFreshBuffer(_loc3_);
         }
      }
      
      public function refreshTurn() : void
      {
         if(_roleShowII && _roleShowII.bossBufferContainer)
         {
            _roleShowII.bossBufferContainer.refreshTurn();
         }
         if(_doubleBossShow && _doubleBossShow.bossBufferContainer1)
         {
            _doubleBossShow.bossBufferContainer1.refreshTurn();
         }
         if(_doubleBossShow && _doubleBossShow.bossBufferContainer2)
         {
            _doubleBossShow.bossBufferContainer2.refreshTurn();
         }
         if(_mutilRoleShowView)
         {
            _mutilRoleShowView.refreshTurn();
         }
      }
      
      public function bufferDispose(param1:HeroRoleInfo = null) : void
      {
         if(_roleShowII && _roleShowII.bossBufferContainer)
         {
            _roleShowII.bossBufferContainer.disposeBossInfo(param1);
         }
      }
      
      public function bossReinforce(param1:Array) : void
      {
         if(_roleShowII)
         {
            _roleShowII.bossReinforce(param1);
         }
      }
      
      public function setReinforceWaveInfo(param1:int, param2:int) : void
      {
         if(_roleShowII)
         {
            _roleShowII.setReinforceWaveInfo(param1,param2);
         }
      }
      
      public function dispose() : void
      {
         if(_teamStripHashmap)
         {
            _teamStripHashmap.clear();
            _teamStripHashmap = null;
         }
         if(_timer)
         {
            _timer.stop();
            _timer.removeEventListener("timer",__onTimer);
            _timer.removeEventListener("timerComplete",__onTimerComplete);
            _timer = null;
         }
         removeEvent();
         NotificationManager.instance.removeEventListener("autoFightChanged",onAutoFightChanged);
         PetSacristyManager.instance.awake = 0;
         if(FrameControllerManager.instance.consortiaGroupChatControler.isVisible() || Boolean(MainToolBar.instance.poptipButtonVisible))
         {
            FrameControllerManager.instance.consortiaGroupChatControler.model.isOpenGroupChatTip = false;
            FrameControllerManager.instance.consortiaGroupChatControler.consortiaBtnShining = false;
            IMManager.instance.friendBtnShining = false;
         }
         ObjectUtils.disposeObject(_hurtUpView);
         _hurtUpView = null;
         ObjectUtils.disposeObject(_trailCountView);
         _trailCountView = null;
         ObjectUtils.disposeObject(_raceAgainstTimeUpView);
         _raceAgainstTimeUpView = null;
         ObjectUtils.disposeObject(_chatMessageBtn);
         _chatMessageBtn = null;
         ObjectUtils.disposeObject(_consortiaChatBtn);
         _consortiaChatBtn = null;
         ObjectUtils.disposeObject(_finishNowBtn);
         _finishNowBtn = null;
         ObjectUtils.disposeObject(_settingBtn);
         _settingBtn = null;
         ObjectUtils.disposeObject(_stripView);
         _stripView = null;
         ObjectUtils.disposeObject(_countdownNumTxt);
         _countdownNumTxt = null;
         ObjectUtils.disposeObject(_countdownTxt);
         _countdownTxt = null;
         ObjectUtils.disposeObject(_countdownTxt2);
         _countdownTxt2 = null;
         ObjectUtils.disposeObject(_killSelfBtn);
         _killSelfBtn = null;
         ObjectUtils.disposeObject(_immediatelyWinBtn);
         _immediatelyWinBtn = null;
         ObjectUtils.disposeObject(_hideOthersBg);
         _hideOthersBg = null;
         ObjectUtils.disposeObject(_hideOthersBtn);
         _hideOthersBtn = null;
         ObjectUtils.disposeObject(_autoFightStrip);
         _autoFightStrip = null;
         ObjectUtils.disposeObject(_autoFightBtn);
         _autoFightBtn = null;
         ObjectUtils.disposeObject(_bottomBar);
         _bottomBar = null;
         ObjectUtils.disposeObject(_dragonTitanOfTeamMate);
         _dragonTitanOfTeamMate = null;
         ObjectUtils.disposeObject(_dragonTitanOfEnemies);
         _dragonTitanOfEnemies = null;
         ObjectUtils.disposeObject(_selfGoddessTopView);
         _selfGoddessTopView = null;
         ObjectUtils.disposeObject(_vsGoddessTopView);
         _vsGoddessTopView = null;
         ObjectUtils.disposeObject(_petBar);
         _petBar = null;
         ObjectUtils.disposeObject(_sacristyBar);
         _sacristyBar = null;
         ObjectUtils.disposeObject(_childpveBar);
         _childpveBar = null;
         ObjectUtils.disposeObject(_skillNameContainer);
         _skillNameContainer = null;
         ObjectUtils.disposeObject(_forbiddenBossUIView);
         _forbiddenBossUIView = null;
         if(_outyardShowView)
         {
            ObjectUtils.disposeObject(_outyardShowView);
         }
         _outyardShowView = null;
         if(_roleShowII)
         {
            ObjectUtils.disposeObject(_roleShowII);
         }
         _roleShowII = null;
         if(_doubleBossShow)
         {
            ObjectUtils.disposeObject(_doubleBossShow);
         }
         _doubleBossShow = null;
         if(_mutilRoleShowView)
         {
            ObjectUtils.disposeObject(_mutilRoleShowView);
         }
         _mutilRoleShowView = null;
         if(_qteView)
         {
            ObjectUtils.disposeObject(_qteView);
         }
         _qteView = null;
         if(_batterUIView)
         {
            ObjectUtils.disposeObject(_batterUIView);
         }
         _batterUIView = null;
         if(_battleSpaceTimeView)
         {
            ObjectUtils.disposeObject(_battleSpaceTimeView);
         }
         _battleSpaceTimeView = null;
         ObjectUtils.disposeObject(_resistUIView1);
         _resistUIView1 = null;
         ObjectUtils.disposeObject(_resistUIView2);
         _resistUIView2 = null;
         if(_delay)
         {
            _delay.cancel();
         }
         _delay = null;
         ObjectUtils.disposeViolentMc(_addSpBallLayer);
         _addSpBallLayer = null;
         ObjectUtils.disposeObject(_autoFightFlag);
         _autoFightFlag = null;
         ObjectUtils.disposeObject(_teamStripContainer1);
         _teamStripContainer1 = null;
         ObjectUtils.disposeObject(_teamStripContainer2);
         _teamStripContainer2 = null;
         ObjectUtils.disposeObject(_childCommomBar);
         _childCommomBar = null;
         ObjectUtils.disposeObject(_monsterCommomBar);
         _monsterCommomBar = null;
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}

