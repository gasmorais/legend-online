package gamehall.room
{
   import com.greensock.TweenMax;
   import com.greensock.easing.Quart;
   import com.pickgliss.events.ListItemEvent;
   import com.pickgliss.toplevel.StageReferance;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.BaseButton;
   import com.pickgliss.ui.controls.IconButton;
   import com.pickgliss.ui.controls.SelectedButton;
   import com.pickgliss.ui.controls.SelectedCheckButton;
   import com.pickgliss.ui.controls.list.VectorListModel;
   import com.pickgliss.ui.image.Image;
   import com.pickgliss.ui.image.ScaleFrameImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import com.pickgliss.utils.SoundManager;
   import events.FreedomTeamEvent;
   import events.GameHallEvent;
   import flash.display.DisplayObject;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.geom.Point;
   import flash.utils.Dictionary;
   import manager.LanguageMgr;
   import managers.GameHallManager;
   import managers.PlayerCurrencyManager;
   import mvc.module.currency.PlayerCurrencyInfo;
   import mvc.module.gamehall.GameHallArmy;
   import mvc.module.gamehall.GameHallGameInfo;
   import mvc.module.gamehall.GameHallModel;
   import mvc.module.gamehall.GameHallUserInfo;
   import mvc.module.pveroomlist.PVERoomListModel;
   import ui.maintoolbar.MainToolBar;
   import yishi.datas.playerinfo.PlayerInfo;
   import yishi.datas.templates.GameHallEasterTemplateInfo;
   import yishi.datas.templates.GameHallTemplateInfo;
   import yishi.events.NotificationEvent;
   import yishi.manager.FrameControllerManager;
   import yishi.manager.NotificationManager;
   import yishi.manager.PlayerManager;
   import yishi.manager.SharedManager;
   import yishi.manager.TempleteManager;
   import yishi.utils.SimpleAlertHelper;
   import yishi.utils.StringHelper;
   import yishi.view.frame.TodayNotAlertFrame;
   import yishi.view.tips.MessageTipManager;
   
   public class GameHallSceneBottomView extends Sprite
   {
      
      private var _bg:Image;
      
      private var _comboBox:GameHallComboBox;
      
      private var _useCountBtn:SelectedButton;
      
      private var _useCountTxt:FilterFrameText;
      
      private var _gameTitleImg:ScaleFrameImage;
      
      private var _gameDiffImg:ScaleFrameImage;
      
      private var _lockBtn:BaseButton;
      
      private var _noLockBtn:BaseButton;
      
      private var _selectBtn:IconButton;
      
      private var _addBtn:IconButton;
      
      private var _leaveBtn:IconButton;
      
      private var _lineUpBtn:IconButton;
      
      private var _kickBtn:IconButton;
      
      private var _leaderBtn:IconButton;
      
      private var _startBtn:IconButton;
      
      private var _readyBtn:IconButton;
      
      private var _cancelBtn:IconButton;
      
      private var _gameInfoList:Array;
      
      private var _currentSelected:GameHallGameInfo;
      
      private var _model:GameHallModel = GameHallManager.instance.model;
      
      private var _campaignNameTxt:FilterFrameText;
      
      private var _buyBuffBtn:BaseButton;
      
      private var _nextReadyCkBtn:SelectedCheckButton;
      
      private var _repeatCkBtn:SelectedCheckButton;
      
      private var _teamView:GameHallSceneTeamView;
      
      private var _alertEastType:int;
      
      private var frame:TodayNotAlertFrame;
      
      private var _flyBtn:BaseButton;
      
      public function GameHallSceneBottomView()
      {
         super();
         initView();
         initData();
         addEvent();
         refreshView();
      }
      
      private function initView() : void
      {
         _bg = ComponentFactory.Instance.creatComponentByStylename("gamehall.GameHallSceneBottomView.bg");
         _comboBox = ComponentFactory.Instance.creatComponentByStylename("gamehall.GameHallSceneBottomView.comboBox");
         _useCountBtn = ComponentFactory.Instance.creatComponentByStylename("gamehall.GameHallSceneBottomView.useCountBtn");
         _useCountTxt = ComponentFactory.Instance.creatComponentByStylename("gamehall.GameHallSceneBottomView.useCountTxt");
         _gameTitleImg = ComponentFactory.Instance.creatComponentByStylename("gamehall.GameHallSceneBottomView.gameTitleImg");
         _gameDiffImg = ComponentFactory.Instance.creatComponentByStylename("gamehall.GameHallSceneBottomView.gameDiffImg");
         _lockBtn = ComponentFactory.Instance.creatComponentByStylename("gamehall.GameHallSceneBottomView.lockBtn");
         _noLockBtn = ComponentFactory.Instance.creatComponentByStylename("gamehall.GameHallSceneBottomView.noLockBtn");
         _selectBtn = ComponentFactory.Instance.creatComponentByStylename("gamehall.GameHallSceneBottomView.selectBtn");
         _addBtn = ComponentFactory.Instance.creatComponentByStylename("gamehall.GameHallSceneBottomView.addBtn");
         _leaveBtn = ComponentFactory.Instance.creatComponentByStylename("gamehall.GameHallSceneBottomView.leaveBtn");
         _lineUpBtn = ComponentFactory.Instance.creatComponentByStylename("gamehall.GameHallSceneBottomView.lineUpBtn");
         _kickBtn = ComponentFactory.Instance.creatComponentByStylename("gamehall.GameHallSceneBottomView.kickBtn");
         _leaderBtn = ComponentFactory.Instance.creatComponentByStylename("gamehall.GameHallSceneBottomView.leaderBtn");
         _startBtn = ComponentFactory.Instance.creatComponentByStylename("gamehall.GameHallSceneBottomView.startBtn");
         _readyBtn = ComponentFactory.Instance.creatComponentByStylename("gamehall.GameHallSceneBottomView.readyBtn");
         _cancelBtn = ComponentFactory.Instance.creatComponentByStylename("gamehall.GameHallSceneBottomView.cancelBtn");
         _campaignNameTxt = ComponentFactory.Instance.creatComponentByStylename("gamehall.GameHallSceneBottomView.campaignNameTxt");
         _nextReadyCkBtn = ComponentFactory.Instance.creatComponentByStylename("gamehall.nextCheckBtn");
         _repeatCkBtn = ComponentFactory.Instance.creatComponentByStylename("gamehall.repeatCheckBtn");
         _nextReadyCkBtn.text = LanguageMgr.GetTranslation("gameHall.east.autoNext");
         _repeatCkBtn.text = LanguageMgr.GetTranslation("gameHall.east.autoRepeat");
         _gameTitleImg.setFrame(1);
         _gameDiffImg.setFrame(1);
         var _loc1_:GameHallGameInfo = new GameHallGameInfo();
         _loc1_.gameId = _model.gameId;
         var _loc3_:int = _loc1_.templateInfo.Count - _model.fixedGroupRewardCount;
         var _loc2_:int = int(_loc1_.templateInfo.Count);
         _useCountTxt.text = LanguageMgr.GetTranslation("gamehall.GameHallSceneBottomView.useCountTxt",_loc3_,_loc2_);
         _useCountTxt.setFrame(1);
         _gameTitleImg.visible = false;
         _gameDiffImg.visible = false;
         addChild(_bg);
         addChild(_comboBox);
         addChild(_useCountBtn);
         addChild(_useCountTxt);
         addChild(_gameTitleImg);
         addChild(_gameDiffImg);
         addChild(_campaignNameTxt);
         addChild(_lockBtn);
         addChild(_noLockBtn);
         addChild(_selectBtn);
         addChild(_addBtn);
         addChild(_leaveBtn);
         addChild(_lineUpBtn);
         addChild(_kickBtn);
         addChild(_leaderBtn);
         addChild(_startBtn);
         addChild(_readyBtn);
         addChild(_cancelBtn);
         addChild(_nextReadyCkBtn);
         addChild(_repeatCkBtn);
      }
      
      private function get playerInfo() : PlayerInfo
      {
         return PlayerManager.instance.currentPlayerModel.playerInfo;
      }
      
      private function uninitView() : void
      {
         ObjectUtils.disposeObject(_nextReadyCkBtn);
         _nextReadyCkBtn = null;
         ObjectUtils.disposeObject(_repeatCkBtn);
         _repeatCkBtn = null;
         ObjectUtils.disposeObject(_teamView);
         _teamView = null;
         ObjectUtils.disposeObject(_bg);
         _bg = null;
         ObjectUtils.disposeObject(_comboBox);
         _comboBox = null;
         ObjectUtils.disposeObject(_useCountBtn);
         _useCountBtn = null;
         ObjectUtils.disposeObject(_useCountTxt);
         _useCountTxt = null;
         ObjectUtils.disposeObject(_gameTitleImg);
         _gameTitleImg = null;
         ObjectUtils.disposeObject(_gameDiffImg);
         _gameDiffImg = null;
         ObjectUtils.disposeObject(_lockBtn);
         _lockBtn = null;
         ObjectUtils.disposeObject(_noLockBtn);
         _noLockBtn = null;
         ObjectUtils.disposeObject(_selectBtn);
         _selectBtn = null;
         ObjectUtils.disposeObject(_addBtn);
         _addBtn = null;
         ObjectUtils.disposeObject(_leaveBtn);
         _leaveBtn = null;
         ObjectUtils.disposeObject(_lineUpBtn);
         _lineUpBtn = null;
         ObjectUtils.disposeObject(_kickBtn);
         _kickBtn = null;
         ObjectUtils.disposeObject(_leaderBtn);
         _leaderBtn = null;
         ObjectUtils.disposeObject(_startBtn);
         _startBtn = null;
         ObjectUtils.disposeObject(_readyBtn);
         _readyBtn = null;
         ObjectUtils.disposeObject(_cancelBtn);
         _cancelBtn = null;
         ObjectUtils.disposeObject(_campaignNameTxt);
         _campaignNameTxt = null;
         ObjectUtils.disposeAllChildren(this);
         ObjectUtils.disposeSelf(this);
         _gameInfoList = null;
         _model = null;
      }
      
      private function initData() : void
      {
         var _loc4_:GameHallGameInfo = null;
         var _loc8_:Array = null;
         var _loc1_:GameHallEasterTemplateInfo = null;
         _gameInfoList = [];
         _comboBox.beginChanges();
         _comboBox.selctedPropName = "text";
         var _loc3_:VectorListModel = _comboBox.listPanel.vectorListModel;
         _loc3_.clear();
         var _loc5_:int = 0;
         var _loc6_:int = 0;
         var _loc2_:int = 0;
         var _loc7_:Dictionary = TempleteManager.instance.gameHallTemplateCate.getTemplates();
         if(_model.gameId == 4)
         {
            _loc8_ = _model.eastOpenTemplateIdArr;
            _loc2_ = int(_loc8_.length);
            if(_loc2_ > 0)
            {
               _loc5_ = 0;
               while(_loc5_ < _loc2_)
               {
                  _loc4_ = new GameHallGameInfo();
                  _loc4_.gameId = 4;
                  _loc4_.difficulty = _loc8_[_loc5_];
                  _gameInfoList.push(_loc4_);
                  _loc5_++;
               }
            }
            else
            {
               _loc4_ = new GameHallGameInfo();
               _loc4_.gameId = 4;
               if(_model.selfTeam)
               {
                  _loc4_.difficulty = _model.selfTeam.difficulty;
               }
               _gameInfoList.push(_loc4_);
            }
         }
         else
         {
            for each(var _loc9_:GameHallTemplateInfo in _loc7_)
            {
               if(GameHallModel.OPEN_GROUP.indexOf(_loc9_.Group) != -1)
               {
                  if(_loc9_.hasDiffSelect)
                  {
                     _loc2_ = int(_loc9_.difficultyMax);
                     _loc5_ = 0;
                     while(_loc5_ < _loc2_)
                     {
                        _loc6_ = _loc5_ + 1;
                        _loc4_ = new GameHallGameInfo();
                        _loc4_.gameId = _loc9_.GameId;
                        _loc4_.difficulty = _loc6_;
                        _gameInfoList.push(_loc4_);
                        _loc5_++;
                     }
                  }
                  else
                  {
                     _loc4_ = new GameHallGameInfo();
                     _loc4_.gameId = _loc9_.GameId;
                     _loc4_.difficulty = 0;
                     _gameInfoList.push(_loc4_);
                  }
               }
            }
         }
         _gameInfoList.sort(sortFun);
         _loc2_ = int(_gameInfoList.length);
         _loc5_ = 0;
         while(_loc5_ < _loc2_)
         {
            _comboBox.listPanel.vectorListModel.append(_gameInfoList[_loc5_]);
            _loc5_++;
         }
         _comboBox.listPanel.list.updateListView();
         _comboBox.commitChanges();
         _comboBox.listPanel.list.defaultSelectItemByCellValue = _gameInfoList[0];
         if(_model.gameId == 4)
         {
            _loc1_ = TempleteManager.instance.gameHallEastTemplateCate.getTemplateByID(_model.selfTeam.difficulty);
            if(_loc1_)
            {
               _campaignNameTxt.text = _loc1_.TemplateName;
            }
         }
      }
      
      protected function sortFun(param1:GameHallGameInfo, param2:GameHallGameInfo) : Number
      {
         if(param1.gameId < param2.gameId)
         {
            return -1;
         }
         if(param1.gameId > param2.gameId)
         {
            return 1;
         }
         if(param1.difficulty < param2.difficulty)
         {
            return -1;
         }
         if(param1.difficulty > param2.difficulty)
         {
            return 1;
         }
         return 0;
      }
      
      private function addEvent() : void
      {
         _comboBox.addEventListener("click",__comboBoxClickHandler);
         _comboBox.listPanel.list.addEventListener("listItemClick",__listItemClickHandler);
         _lockBtn.addEventListener("click",__lockBtnClickHandler);
         _noLockBtn.addEventListener("click",__lockBtnClickHandler);
         _selectBtn.addEventListener("click",__selectBtnClickHandler);
         _addBtn.addEventListener("click",__addBtnClickHandler);
         _leaveBtn.addEventListener("click",__leaveBtnClickHandler);
         _lineUpBtn.addEventListener("click",__lineUpBtnClickHandler);
         _kickBtn.addEventListener("click",__kickBtnClickHandler);
         _leaderBtn.addEventListener("click",__leaderBtnClickHandler);
         _startBtn.addEventListener("click",__startBtnClickHandler);
         _readyBtn.addEventListener("click",__readyBtnClickHandler);
         _cancelBtn.addEventListener("click",__cancelBtnClickHandler);
         _model.addEventListener("GAME_INFO_UPDATE",__gameInfoUpdateHandler);
         _model.addEventListener("USER_INFO_UPDATE",__userInfoUpdateHandler);
         _model.addEventListener("CAPTAIN_UPDATE",__captainInfoUpdateHandler);
         _model.addEventListener("PASSWORD_UPDATE",__passwordInfoUpdateHandler);
         NotificationManager.instance.addEventListener("TEAM_INFO_SYNC",__teamInfoUpdateHandler);
         NotificationManager.instance.addEventListener("PLAYER_EXTRA_FIELD",__updateExpHandler);
         _nextReadyCkBtn.addEventListener("click",__nextReadyCheckHandler);
         _repeatCkBtn.addEventListener("click",__repeatCheckHandler);
      }
      
      private function removeEvent() : void
      {
         _comboBox.removeEventListener("click",__comboBoxClickHandler);
         _comboBox.listPanel.list.removeEventListener("listItemClick",__listItemClickHandler);
         _lockBtn.removeEventListener("click",__lockBtnClickHandler);
         _noLockBtn.removeEventListener("click",__lockBtnClickHandler);
         _selectBtn.removeEventListener("click",__selectBtnClickHandler);
         _addBtn.removeEventListener("click",__addBtnClickHandler);
         _leaveBtn.removeEventListener("click",__leaveBtnClickHandler);
         _lineUpBtn.removeEventListener("click",__lineUpBtnClickHandler);
         _kickBtn.removeEventListener("click",__kickBtnClickHandler);
         _leaderBtn.removeEventListener("click",__leaderBtnClickHandler);
         _startBtn.removeEventListener("click",__startBtnClickHandler);
         _readyBtn.removeEventListener("click",__readyBtnClickHandler);
         _cancelBtn.removeEventListener("click",__cancelBtnClickHandler);
         _model.removeEventListener("GAME_INFO_UPDATE",__gameInfoUpdateHandler);
         _model.removeEventListener("USER_INFO_UPDATE",__userInfoUpdateHandler);
         _model.removeEventListener("CAPTAIN_UPDATE",__captainInfoUpdateHandler);
         _model.removeEventListener("PASSWORD_UPDATE",__passwordInfoUpdateHandler);
         NotificationManager.instance.removeEventListener("TEAM_INFO_SYNC",__teamInfoUpdateHandler);
         NotificationManager.instance.removeEventListener("PLAYER_EXTRA_FIELD",__updateExpHandler);
         _nextReadyCkBtn.removeEventListener("click",__nextReadyCheckHandler);
         _repeatCkBtn.removeEventListener("click",__repeatCheckHandler);
      }
      
      private function __nextReadyCheckHandler(param1:MouseEvent) : void
      {
         var _loc2_:String = null;
         var _loc3_:String = null;
         var _loc4_:String = null;
         var _loc5_:String = null;
         if(_nextReadyCkBtn.selected)
         {
            _repeatCkBtn.selected = false;
            _nextReadyCkBtn.selected = false;
            SimpleAlertHelper.instance.data = [nextReadyCheckCallBack];
            _loc2_ = LanguageMgr.GetTranslation("public.confirm");
            _loc3_ = LanguageMgr.GetTranslation("public.cancel");
            _loc4_ = LanguageMgr.GetTranslation("public.prompt");
            _loc5_ = LanguageMgr.GetTranslation("gameHall.east.autoNextDes");
            SimpleAlertHelper.instance.popAlerFrame(_loc4_,_loc5_,_loc2_,_loc3_,true,false,false);
         }
      }
      
      private function nextReadyCheckCallBack(param1:Boolean, param2:Boolean) : void
      {
         if(param1)
         {
            _nextReadyCkBtn.selected = true;
         }
      }
      
      private function __repeatCheckHandler(param1:MouseEvent) : void
      {
         var _loc2_:String = null;
         var _loc3_:String = null;
         var _loc4_:String = null;
         var _loc5_:String = null;
         if(_repeatCkBtn.selected)
         {
            _repeatCkBtn.selected = false;
            _nextReadyCkBtn.selected = false;
            SimpleAlertHelper.instance.data = [repeatCheckCheckCallBack];
            _loc2_ = LanguageMgr.GetTranslation("public.confirm");
            _loc3_ = LanguageMgr.GetTranslation("public.cancel");
            _loc4_ = LanguageMgr.GetTranslation("public.prompt");
            _loc5_ = LanguageMgr.GetTranslation("gameHall.east.autoRepeatDes");
            SimpleAlertHelper.instance.popAlerFrame(_loc4_,_loc5_,_loc2_,_loc3_,true,false,false);
         }
      }
      
      private function repeatCheckCheckCallBack(param1:Boolean, param2:Boolean) : void
      {
         if(param1)
         {
            _repeatCkBtn.selected = true;
         }
      }
      
      private function __comboBoxClickHandler(param1:MouseEvent) : void
      {
         SoundManager.instance.play("022");
         _comboBox.listPanel.vScrollbar.scrollValue = _comboBox.listPanel.vScrollbar.maximum;
      }
      
      private function __listItemClickHandler(param1:ListItemEvent) : void
      {
         var _loc2_:String = null;
         SoundManager.instance.play("022");
         var _loc3_:GameHallGameInfo = param1.cellValue;
         if(!GameHallManager.instance.isOpenToday(_loc3_.gameId))
         {
            _loc2_ = LanguageMgr.GetTranslation("gamehall.GameHallSceneBottomView.comboBoxTipTxt");
            MessageTipManager.instance().show(_loc2_);
            setCurrentSelectItem(_currentSelected);
            return;
         }
         if(_model.isCaptain)
         {
            GameHallManager.instance.teamGame(_loc3_.gameId,_loc3_.difficulty);
         }
      }
      
      private function __lockBtnClickHandler(param1:MouseEvent) : void
      {
         var _loc2_:GameHallPasswordFrame = ComponentFactory.Instance.creatComponentByStylename("gamehall.GameHallSceneBottomView.passwordFrame");
         _loc2_.backCall = passwordInputBack;
         _loc2_.show(_model.selfTeam.teamId);
      }
      
      private function passwordInputBack(param1:int, param2:String) : void
      {
         GameHallManager.instance.teamPassword(param2);
      }
      
      private function __selectBtnClickHandler(param1:MouseEvent) : void
      {
         FrameControllerManager.instance.openControllerByInfo("gamehall",null,true);
      }
      
      private function __addBtnClickHandler(param1:MouseEvent) : void
      {
         FrameControllerManager.instance.openControllerByInfo("pveroomlist",PVERoomListModel.OPEN_ROOMINVITEFRAME);
      }
      
      private function __leaveBtnClickHandler(param1:MouseEvent) : void
      {
         GameHallManager.instance.teamLeave();
      }
      
      private function __lineUpBtnClickHandler(param1:MouseEvent) : void
      {
         FrameControllerManager.instance.openControllerByInfo("teammanager","GAME_HALL_SORT_FRAME");
      }
      
      private function __kickBtnClickHandler(param1:MouseEvent) : void
      {
         showTeamView(_kickBtn,kickCallBack);
      }
      
      private function __leaderBtnClickHandler(param1:MouseEvent) : void
      {
         showTeamView(_leaderBtn,leaderCallBack);
      }
      
      private function showTeamView(param1:IconButton, param2:Function) : void
      {
         var _loc3_:int = this.x + param1.x;
         var _loc4_:int = this.y + param1.y - 180;
         var _loc5_:Point = parent.localToGlobal(new Point(_loc3_,_loc4_));
         _teamView = new GameHallSceneTeamView(param2);
         _teamView.x = _loc5_.x;
         _teamView.y = _loc5_.y;
         LayerManager.Instance.addToLayer(_teamView,7);
      }
      
      private function kickCallBack(param1:int) : void
      {
         GameHallManager.instance.teamKick(param1);
      }
      
      private function leaderCallBack(param1:int) : void
      {
         GameHallManager.instance.teamCaptain(param1);
      }
      
      private function __startBtnClickHandler(param1:MouseEvent) : void
      {
         if(_model.gameId == 4)
         {
            if(checkTicksEnough())
            {
               if(_model.remainEffectiveNum <= 0)
               {
                  _alertEastType = 1;
                  alertEastToday();
               }
               else
               {
                  GameHallManager.instance.teamStart(_useCountBtn.selected,eastAutoType);
               }
            }
            else
            {
               _model.buyTicks();
            }
         }
         else
         {
            checkHasEarings();
            GameHallManager.instance.teamStart(_useCountBtn.selected);
         }
      }
      
      private function __readyBtnClickHandler(param1:MouseEvent) : void
      {
         if(_model.gameId == 4)
         {
            if(checkTicksEnough())
            {
               if(_model.remainEffectiveNum <= 0)
               {
                  _alertEastType = 2;
                  alertEastToday();
               }
               else
               {
                  GameHallManager.instance.teamPrepare(true,_useCountBtn.selected);
               }
            }
            else
            {
               _model.buyTicks();
            }
         }
         else
         {
            checkHasEarings();
            GameHallManager.instance.teamPrepare(true,_useCountBtn.selected);
         }
      }
      
      private function alertEastToday() : void
      {
         var _loc1_:String = LanguageMgr.GetTranslation("active.expback.frame.selectbtntxt");
         var _loc3_:String = LanguageMgr.GetTranslation("gamehall.GameHallEastShopFrame.todayAlert",_model.effectiveNum,_model.buyPrice);
         var _loc2_:Boolean = todayNeedAlertForRefresh;
         if(_loc2_)
         {
            frame = ComponentFactory.Instance.creatComponentByStylename("gamehall.eastShopTodayNotAlertFrame");
            frame.show(_loc3_,_loc1_,__alertEastTodayConfrim,eastalertDispose,"center",1,false,0,false,2,__alertEastTodayCancel);
         }
         else
         {
            alertEastCloseBack();
         }
      }
      
      private function eastalertDispose() : void
      {
         frame = null;
      }
      
      private function __alertEastTodayCancel(param1:Boolean) : void
      {
         if(param1)
         {
            SharedManager.instance.gameHallEastShop = new Date();
            SharedManager.instance.saveGameHallEastShopAlertData();
         }
         flyBtn();
         _model.dispatchEvent(new Event("EVENT_FLITER_BUY"));
      }
      
      private function flyBtn() : void
      {
         if(_flyBtn != null)
         {
            return;
         }
         _flyBtn = ComponentFactory.Instance.creatComponentByStylename("gamehall.GameHallTeamEastLeftView.buyBufferBtn");
         var _loc1_:DisplayObject = frame.cancelBtn;
         var _loc3_:Point = _loc1_.localToGlobal(new Point(_loc1_.x,_loc1_.y));
         _flyBtn.x = _loc3_.x;
         _flyBtn.y = _loc3_.y;
         _flyBtn.mouseChildren = _flyBtn.mouseEnabled = false;
         StageReferance.stage.addChild(_flyBtn);
         var _loc2_:Point = _buyBuffBtn.localToGlobal(new Point(_buyBuffBtn.getBounds(_buyBuffBtn).x,_buyBuffBtn.getBounds(_buyBuffBtn).y));
         TweenMax.to(_flyBtn,1.2,{
            "bezierThrough":[{
               "x":_loc3_.x,
               "y":_loc3_.y
            },{
               "x":_loc2_.x,
               "y":_loc2_.y
            }],
            "scaleX":0.9,
            "scaleY":0.9,
            "orientToBezier":false,
            "ease":Quart.easeOut,
            "onComplete":_moveComplete,
            "onCompleteParams":[_flyBtn]
         });
      }
      
      private function _moveComplete(param1:DisplayObject) : void
      {
         TweenMax.to(param1,0.5,{
            "alpha":0,
            "onComplete":disapearComplete,
            "onCompleteParams":[param1]
         });
      }
      
      private function disapearComplete(param1:DisplayObject) : void
      {
         ObjectUtils.disposeObject(_flyBtn);
         _flyBtn = null;
      }
      
      private function __alertEastTodayConfrim(param1:Boolean) : void
      {
         if(param1)
         {
            SharedManager.instance.gameHallEastShop = new Date();
            SharedManager.instance.saveGameHallEastShopAlertData();
         }
         alertEastCloseBack();
      }
      
      private function alertEastCloseBack() : void
      {
         if(_alertEastType == 1)
         {
            GameHallManager.instance.teamStart(_useCountBtn.selected,eastAutoType);
         }
         else if(_alertEastType == 2)
         {
            GameHallManager.instance.teamPrepare(true,_useCountBtn.selected);
         }
      }
      
      private function get eastAutoType() : int
      {
         var _loc1_:int = 0;
         if(_nextReadyCkBtn.selected && Boolean(_nextReadyCkBtn.visible))
         {
            _loc1_ = 2;
         }
         else if(_repeatCkBtn.selected && Boolean(_repeatCkBtn.visible))
         {
            _loc1_ = 1;
         }
         return _loc1_;
      }
      
      private function get todayNeedAlertForRefresh() : Boolean
      {
         var _loc2_:Date = null;
         var _loc3_:Boolean = true;
         var _loc1_:Date = SharedManager.instance.gameHallEastShop;
         if(_loc1_)
         {
            _loc2_ = new Date();
            if(_loc2_.fullYear == _loc1_.fullYear && _loc2_.month == _loc1_.month && _loc2_.date == _loc1_.date)
            {
               _loc3_ = false;
            }
         }
         return _loc3_;
      }
      
      private function checkHasEarings() : void
      {
         var _loc1_:GameHallGameInfo = null;
         var _loc2_:int = 0;
         if(_model.gameId == 2)
         {
            _loc1_ = new GameHallGameInfo();
            _loc1_.gameId = _model.gameId;
            _loc2_ = _loc1_.templateInfo.Count - _model.fixedGroupRewardCount;
            if(_loc2_ > 0)
            {
               _model.hasEarnings = true;
            }
            else
            {
               _model.hasEarnings = false;
            }
         }
      }
      
      private function checkTicksEnough() : Boolean
      {
         var _loc1_:Boolean = false;
         var _loc2_:int = int(_model.selfTeam.difficulty);
         var _loc3_:GameHallEasterTemplateInfo = TempleteManager.instance.gameHallEastTemplateCate.getTemplateByID(_loc2_);
         if(_loc3_ && currencyInfo)
         {
            if(currencyInfo.eastTickesCoin.amount >= _loc3_.TicketCount)
            {
               _loc1_ = true;
            }
         }
         return _loc1_;
      }
      
      private function get currencyInfo() : PlayerCurrencyInfo
      {
         return PlayerCurrencyManager.instance.currencyInfo;
      }
      
      private function __cancelBtnClickHandler(param1:MouseEvent) : void
      {
         GameHallManager.instance.teamPrepare(false,_useCountBtn.selected);
      }
      
      private function __gameInfoUpdateHandler(param1:GameHallEvent) : void
      {
         _useCountBtn.selected = false;
         refreshBottomItemVisible();
         refreshGameView();
         refreshComboBox();
         refreshRewardCount();
         refreshBtnState();
         refreshPasswordState();
      }
      
      private function __userInfoUpdateHandler(param1:GameHallEvent) : void
      {
         refreshBottomItemVisible();
         refreshStartAndReadyBtnState();
         refreshRewardCount();
         refreshBtnState();
         refreshComboBoxState();
         refreshPasswordState();
      }
      
      private function __captainInfoUpdateHandler(param1:GameHallEvent) : void
      {
         refreshStartAndReadyBtnState();
         refreshComboBox();
         refreshGameView();
         refreshRewardCount();
         refreshBtnState();
         refreshComboBoxState();
         refreshPasswordState();
      }
      
      public function refreshBottomItemVisible() : void
      {
         if(_model.gameId != 4)
         {
            _useCountBtn.visible = _useCountTxt.visible = _gameTitleImg.visible = _gameDiffImg.visible = true;
            _campaignNameTxt.visible = false;
         }
         if(_model.gameId == 4)
         {
            _useCountBtn.visible = _useCountTxt.visible = _gameTitleImg.visible = _gameDiffImg.visible = false;
            _campaignNameTxt.visible = true;
         }
      }
      
      private function __passwordInfoUpdateHandler(param1:GameHallEvent) : void
      {
         refreshPasswordState();
      }
      
      private function __teamInfoUpdateHandler(param1:FreedomTeamEvent) : void
      {
         refreshStartAndReadyBtnState();
         refreshRewardCount();
         refreshBtnState();
         refreshComboBoxState();
         refreshPasswordState();
      }
      
      private function __updateExpHandler(param1:NotificationEvent) : void
      {
         refreshRewardCount();
      }
      
      private function refreshStartAndReadyBtnState() : void
      {
         if(_model.isCaptain)
         {
            _startBtn.enable = allReady;
            _readyBtn.enable = false;
            _cancelBtn.enable = false;
            _readyBtn.visible = true;
            _cancelBtn.visible = false;
            MainToolBar.instance.switchToolsBarState(4);
         }
         else
         {
            _startBtn.enable = false;
            _readyBtn.enable = true;
            _cancelBtn.enable = true;
            if(_model.selfArmy && _model.selfArmy.isPrepare)
            {
               _readyBtn.visible = false;
               _cancelBtn.visible = true;
               MainToolBar.instance.switchToolsBarState(3);
            }
            else
            {
               _readyBtn.visible = true;
               _cancelBtn.visible = false;
               MainToolBar.instance.switchToolsBarState(4);
            }
         }
      }
      
      private function get allReady() : Boolean
      {
         var _loc1_:GameHallUserInfo = null;
         var _loc5_:GameHallArmy = null;
         var _loc4_:int = 0;
         var _loc2_:Boolean = true;
         var _loc3_:int = int(_model.selfTeam.players.length);
         _loc4_ = 0;
         while(_loc4_ < _loc3_)
         {
            _loc1_ = _model.selfTeam.players[_loc4_];
            if(!(_model.selfArmy && _loc1_.userId == _model.selfArmy.userId))
            {
               _loc5_ = _model.getUserArmyByUserId(_loc1_.userId);
               if(!_loc5_.isPrepare)
               {
                  _loc2_ = false;
               }
            }
            _loc4_++;
         }
         return _loc2_;
      }
      
      private function refreshRewardCount() : void
      {
         var _loc2_:Boolean = false;
         var _loc1_:GameHallGameInfo = new GameHallGameInfo();
         _loc1_.gameId = _model.gameId;
         if(_model.fixedGroupRewardCount < _loc1_.templateInfo.Count)
         {
            if(_model.isCaptain)
            {
               _loc2_ = true;
            }
            else if(_model.selfArmy && !_model.selfArmy.isPrepare)
            {
               _loc2_ = true;
            }
         }
         else
         {
            _useCountBtn.selected = false;
         }
         var _loc4_:int = _loc1_.templateInfo.Count - _model.fixedGroupRewardCount;
         var _loc3_:int = int(_loc1_.templateInfo.Count);
         if(_loc1_.gameId == 2)
         {
            if(_loc2_)
            {
               _useCountBtn.selected = true;
            }
            _loc2_ = false;
         }
         if(_loc2_)
         {
            _useCountBtn.enable = true;
            _useCountTxt.setFrame(1);
         }
         else
         {
            _useCountBtn.enable = false;
            _useCountTxt.setFrame(2);
         }
         _useCountTxt.text = LanguageMgr.GetTranslation("gamehall.GameHallSceneBottomView.useCountTxt",_loc4_,_loc3_);
      }
      
      private function refreshGameView() : void
      {
         var _loc1_:GameHallEasterTemplateInfo = null;
         var _loc2_:GameHallGameInfo = new GameHallGameInfo();
         _loc2_.gameId = _model.gameId;
         _gameTitleImg.setFrame(_model.gameId);
         _gameTitleImg.visible = true;
         if(_loc2_.templateInfo.hasDiffSelect)
         {
            _gameDiffImg.setFrame(_model.difficulty);
            _gameDiffImg.visible = true;
         }
         else
         {
            _gameDiffImg.visible = false;
         }
         if(_model.gameId == 4)
         {
            _loc1_ = TempleteManager.instance.gameHallEastTemplateCate.getTemplateByID(_model.selfTeam.difficulty);
            if(_loc1_)
            {
               _campaignNameTxt.text = _loc1_.TemplateName;
            }
         }
      }
      
      private function refreshComboBox() : void
      {
         var _loc2_:GameHallGameInfo = null;
         var _loc3_:int = 0;
         var _loc1_:int = int(_gameInfoList.length);
         _loc3_ = 0;
         while(_loc3_ < _loc1_)
         {
            _loc2_ = _gameInfoList[_loc3_];
            if(_loc2_.gameId == _model.gameId)
            {
               if(!(_loc2_.templateInfo.hasDiffSelect && _loc2_.difficulty != _model.difficulty))
               {
                  if(_loc2_.gameId != 4)
                  {
                     setCurrentSelectItem(_loc2_);
                     _currentSelected = _loc2_;
                     break;
                  }
                  if(_loc2_.difficulty == _model.selfTeam.difficulty)
                  {
                     setCurrentSelectItem(_loc2_);
                     _currentSelected = _loc2_;
                     break;
                  }
               }
            }
            _loc3_++;
         }
      }
      
      private function setCurrentSelectItem(param1:GameHallGameInfo) : void
      {
         _comboBox.listPanel.list.removeEventListener("listItemClick",__listItemClickHandler);
         _comboBox.listPanel.list.defaultSelectItemByCellValue = param1;
         _comboBox.listPanel.list.addEventListener("listItemClick",__listItemClickHandler);
      }
      
      private function refreshComboBoxState() : void
      {
         if(_model.isCaptain)
         {
            _comboBox.visible = true;
         }
         else
         {
            _comboBox.visible = false;
         }
      }
      
      private function refreshPasswordState() : void
      {
         _lockBtn.visible = false;
         _noLockBtn.visible = false;
         if(_model.isCaptain)
         {
            if(StringHelper.isNullOrEmpty(_model.selfTeam.password))
            {
               _noLockBtn.visible = true;
            }
            else
            {
               _lockBtn.visible = true;
            }
         }
      }
      
      private function refreshBtnState() : void
      {
         if(_model.isCaptain)
         {
            _selectBtn.enable = true;
            _addBtn.enable = true;
            _leaveBtn.enable = true;
            _lineUpBtn.enable = true;
            _kickBtn.enable = true;
            _leaderBtn.enable = true;
         }
         else
         {
            _selectBtn.enable = true;
            _addBtn.enable = true;
            _leaveBtn.enable = true;
            _lineUpBtn.enable = true;
            _kickBtn.enable = false;
            _leaderBtn.enable = false;
         }
         refresEastAutoCheckBtns();
      }
      
      private function refresEastAutoCheckBtns() : void
      {
         if(_model.gameId == 4)
         {
            _nextReadyCkBtn.visible = true;
            _repeatCkBtn.visible = true;
            if(_model.selfTeam && _model.isCaptain)
            {
               _nextReadyCkBtn.enable = true;
               _repeatCkBtn.enable = true;
               switch(int(_model.selfTeam.autoType) - 1)
               {
                  case 0:
                     _nextReadyCkBtn.selected = false;
                     _repeatCkBtn.selected = true;
                     break;
                  case 1:
                     _nextReadyCkBtn.selected = true;
                     _repeatCkBtn.selected = false;
               }
            }
            else
            {
               _nextReadyCkBtn.enable = false;
               _nextReadyCkBtn.selected = false;
               _repeatCkBtn.enable = false;
               _repeatCkBtn.selected = false;
            }
         }
         else
         {
            _nextReadyCkBtn.visible = false;
            _repeatCkBtn.visible = false;
         }
      }
      
      private function refreshView() : void
      {
         refreshStartAndReadyBtnState();
         refreshRewardCount();
         refreshComboBox();
         refreshGameView();
         refreshPasswordState();
         refreshBtnState();
         refreshComboBoxState();
         refreshAutoStart();
      }
      
      private function refreshAutoStart() : void
      {
         if(_model.gameId == 4)
         {
            if(_model.selfTeam && _model.selfTeam.autoType != 0)
            {
               GameHallManager.instance.teamPrepare(true,_useCountBtn.selected);
            }
         }
      }
      
      private function test() : void
      {
         GameHallManager.instance.teamPrepare(true,_useCountBtn.selected);
      }
      
      public function resize(param1:int, param2:int) : void
      {
      }
      
      public function dispose() : void
      {
         MainToolBar.instance.switchToolsBarState(4);
         removeEvent();
         uninitView();
      }
      
      public function set buyBuffBtn(param1:BaseButton) : void
      {
         _buyBuffBtn = param1;
      }
   }
}

