package braveleg
{
   import braveleg.team.BraveLegGroupInspireView;
   import braveleg.team.BraveLegTeammateGroupItem;
   import chat.datas.ChatData;
   import chat.datas.ChatFactory;
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.instance.IManualSize;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.ShowTipManager;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.ui.controls.IconButton;
   import com.pickgliss.ui.controls.ListPanel;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.ui.image.Image;
   import com.pickgliss.ui.image.MutipleImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import com.pickgliss.utils.SoundManager;
   import events.BraveLegEvent;
   import flash.events.MouseEvent;
   import flash.events.TimerEvent;
   import flash.geom.Rectangle;
   import flash.utils.Timer;
   import mainBar.SmallMapBar;
   import mainBar.TimeBoxView;
   import manager.LanguageMgr;
   import mvc.module.braveleg.BraveLegModel;
   import mvc.module.braveleg.BraveLegTeamInfo;
   import ui.maintoolbar.MainToolBar;
   import ui.queuebar.QueueBar;
   import ui.tasktracebar.TaskTraceBar;
   import ui.toptoolbar.TopToolsBar;
   import yishi.datas.ComponentGroupType;
   import yishi.events.NotificationEvent;
   import yishi.keyboard.KeyBoardRegister;
   import yishi.manager.BraveLegManager;
   import yishi.manager.FrameControllerManager;
   import yishi.manager.NotificationManager;
   import yishi.scene.SceneManager;
   import yishi.utils.SimpleAlertHelper;
   import yishi.view.component.TileContainer;
   
   public class BraveLegTeamFrame extends Frame implements IManualSize
   {
      
      private static const TeammateNum:int = 4;
      
      private var _bg:MutipleImage;
      
      private var _teammateList:ListPanel;
      
      private var _teamLeftTitle:Image;
      
      private var _leftTxt:FilterFrameText;
      
      private var _teamTimeTitle:Image;
      
      private var _timeTxt:FilterFrameText;
      
      private var _warnTxt:FilterFrameText;
      
      private var _inspireCountTxt:FilterFrameText;
      
      private var _matrixBtn:IconButton;
      
      private var _inviteBtn:IconButton;
      
      private var _groupTitle1:Image;
      
      private var _groupTitle2:Image;
      
      private var _groupTitle3:Image;
      
      private var _inspireView:BraveLegGroupInspireView;
      
      private var _groupContainer:TileContainer;
      
      private var _groupItem:Array;
      
      private var _data:BraveLegTeamInfo;
      
      private var _model:BraveLegModel = BraveLegManager.instance.model;
      
      private var _timer:Timer;
      
      private var _timeCount:int;
      
      private var _isReady:Boolean;
      
      public function BraveLegTeamFrame()
      {
         super();
         initView();
         addEvent();
      }
      
      private function initView() : void
      {
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         var _loc1_:BraveLegTeammateGroupItem = null;
         _bg = ComponentFactory.Instance.creatComponentByStylename("braveleg.TeamFrameBg");
         _teammateList = ComponentFactory.Instance.creatComponentByStylename("braveleg.TeammateList");
         _teamLeftTitle = ComponentFactory.Instance.creatComponentByStylename("braveleg.TeamLeftTitle");
         _leftTxt = ComponentFactory.Instance.creatComponentByStylename("braveleg.LeftTxt");
         _teamTimeTitle = ComponentFactory.Instance.creatComponentByStylename("braveleg.TeamTimeTitle");
         _timeTxt = ComponentFactory.Instance.creatComponentByStylename("braveleg.TimeTxt");
         _warnTxt = ComponentFactory.Instance.creatComponentByStylename("braveleg.WarnTxt");
         _inspireCountTxt = ComponentFactory.Instance.creatComponentByStylename("braveleg.InspireCountTxt");
         _matrixBtn = ComponentFactory.Instance.creatComponentByStylename("braveleg.MatrixBtn");
         _inviteBtn = ComponentFactory.Instance.creatComponentByStylename("braveleg.InviteBtn");
         _groupTitle1 = ComponentFactory.Instance.creatComponentByStylename("braveleg.GroupTitle1");
         _groupTitle2 = ComponentFactory.Instance.creatComponentByStylename("braveleg.GroupTitle2");
         _groupTitle3 = ComponentFactory.Instance.creatComponentByStylename("braveleg.GroupTitle3");
         _inspireView = ComponentFactory.Instance.creatComponentByStylename("braveleg.InspireView");
         _groupContainer = new TileContainer(false);
         _groupContainer.x = 293;
         _groupContainer.y = 139;
         _groupContainer.columnCount = 3;
         _groupContainer.rowCount = 3;
         _groupContainer.paddingH = 16;
         _groupContainer.paddingV = 28;
         addToContent(_bg);
         addToContent(_teammateList);
         addToContent(_teamLeftTitle);
         addToContent(_leftTxt);
         addToContent(_teamTimeTitle);
         addToContent(_timeTxt);
         addToContent(_warnTxt);
         addToContent(_inspireCountTxt);
         addToContent(_matrixBtn);
         addToContent(_inviteBtn);
         addToContent(_groupTitle1);
         addToContent(_groupTitle2);
         addToContent(_groupTitle3);
         addToContent(_inspireView);
         addToContent(_groupContainer);
         titleText = LanguageMgr.GetTranslation("braveleg.Title");
         _warnTxt.text = LanguageMgr.GetTranslation("braveleg.Team.Warn");
         _teammateList.beginChanges();
         _teammateList.vectorListModel.clear();
         _loc2_ = 0;
         while(_loc2_ < 4)
         {
            _teammateList.vectorListModel.append(null);
            _loc2_++;
         }
         _teammateList.commitChanges();
         _teammateList.list.updateListView();
         _groupItem = [];
         _loc2_ = 0;
         while(_loc2_ < 3)
         {
            _groupItem[_loc2_] = [];
            _loc3_ = 0;
            while(_loc3_ < 3)
            {
               _loc1_ = ComponentFactory.Instance.creatComponentByStylename("braveleg.TeammateGroupItem");
               _groupContainer.appendItem(_loc1_);
               _groupItem[_loc2_].push(_loc1_);
               _loc3_++;
            }
            _loc2_++;
         }
         _timer = new Timer(1000);
      }
      
      private function addEvent() : void
      {
         addEventListener("response",__frameResponseHandler);
         _timer.addEventListener("timer",__timeUpdateHandler);
         _matrixBtn.addEventListener("click",__matrixBtnClickHandler);
         _inviteBtn.addEventListener("click",__inviteBtnClickHandler);
         _model.addEventListener("BraveLegEvent.TEAM_INSPIRE",__onUpdateInspireHandler);
         NotificationManager.instance.addEventListener("BraveLegEvent.CLOSE_TEAM",__closeViewHandler);
         NotificationManager.instance.addEventListener("SWITCH_SCENE",__swtichCloseFrame);
         NotificationManager.instance.addEventListener("UPDATE_CHAT_VIEW",__playerChatHandler);
      }
      
      private function removeEvent() : void
      {
         removeEventListener("response",__frameResponseHandler);
         _timer.removeEventListener("timer",__timeUpdateHandler);
         _matrixBtn.removeEventListener("click",__matrixBtnClickHandler);
         _inviteBtn.removeEventListener("click",__inviteBtnClickHandler);
         _model.removeEventListener("BraveLegEvent.TEAM_INSPIRE",__onUpdateInspireHandler);
         NotificationManager.instance.removeEventListener("BraveLegEvent.CLOSE_TEAM",__closeViewHandler);
         NotificationManager.instance.removeEventListener("SWITCH_SCENE",__swtichCloseFrame);
         NotificationManager.instance.removeEventListener("UPDATE_CHAT_VIEW",__playerChatHandler);
      }
      
      override public function dispose() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         removeEvent();
         showToolView();
         ObjectUtils.disposeObject(_bg);
         _bg = null;
         ObjectUtils.disposeObject(_teammateList);
         _teammateList = null;
         ObjectUtils.disposeObject(_teamLeftTitle);
         _teamLeftTitle = null;
         ObjectUtils.disposeObject(_leftTxt);
         _leftTxt = null;
         ObjectUtils.disposeObject(_teamTimeTitle);
         _teamTimeTitle = null;
         ObjectUtils.disposeObject(_timeTxt);
         _timeTxt = null;
         ObjectUtils.disposeObject(_warnTxt);
         _warnTxt = null;
         ObjectUtils.disposeObject(_inspireCountTxt);
         _inspireCountTxt = null;
         ObjectUtils.disposeObject(_matrixBtn);
         _matrixBtn = null;
         ObjectUtils.disposeObject(_inviteBtn);
         _inviteBtn = null;
         ObjectUtils.disposeObject(_groupTitle1);
         _groupTitle1 = null;
         ObjectUtils.disposeObject(_groupTitle2);
         _groupTitle2 = null;
         ObjectUtils.disposeObject(_groupTitle3);
         _groupTitle3 = null;
         ObjectUtils.disposeObject(_inspireView);
         _inspireView = null;
         _loc1_ = 0;
         while(_loc1_ < _groupItem.length)
         {
            _loc2_ = 0;
            while(_loc2_ < _groupItem[_loc1_].length)
            {
               ObjectUtils.disposeObject(_groupItem[_loc1_][_loc2_]);
               _groupItem[_loc1_][_loc2_] = null;
               _loc2_++;
            }
            _groupItem[_loc1_].length = 0;
            _loc1_++;
         }
         _groupItem.length = 0;
         ObjectUtils.disposeObject(_groupContainer);
         _groupContainer = null;
         if(_timer)
         {
            _timer.stop();
            _timer = null;
         }
         KeyBoardRegister.instance.keyEnable = true;
         super.dispose();
      }
      
      private function __frameResponseHandler(param1:FrameEvent) : void
      {
         var _loc2_:String = null;
         var _loc3_:String = null;
         var _loc4_:String = null;
         var _loc5_:String = null;
         switch(int(param1.responseCode))
         {
            case 0:
            case 1:
               SimpleAlertHelper.instance.data = [conformQuit];
               _loc2_ = LanguageMgr.GetTranslation("public.confirm");
               _loc3_ = LanguageMgr.GetTranslation("public.cancel");
               _loc4_ = LanguageMgr.GetTranslation("public.prompt");
               _loc5_ = LanguageMgr.GetTranslation("braveleg.Dialog.quit");
               SimpleAlertHelper.instance.popAlerFrame(_loc4_,_loc5_,_loc2_,_loc3_);
         }
      }
      
      private function __timeUpdateHandler(param1:TimerEvent) : void
      {
         _timeCount = _timeCount - 1;
         _timeTxt.htmlText = getTimeStr(_timeCount);
         if(_timeCount <= 0)
         {
            _timer.stop();
         }
         if(_timeCount <= 60 && !_isReady)
         {
            _isReady = true;
            _inspireView.data = {
               "isReady":_isReady,
               "data":_data.inspire,
               "count":_data.maxInspireCount - _data.inspireCount
            };
         }
         else if(_timeCount > 60 && _isReady)
         {
            _isReady = false;
            _inspireView.data = {
               "isReady":_isReady,
               "data":_data.inspire,
               "count":_data.maxInspireCount - _data.inspireCount
            };
         }
      }
      
      private function __matrixBtnClickHandler(param1:MouseEvent) : void
      {
         SoundManager.instance.play("022");
         FrameControllerManager.instance.openControllerByInfo("braveleg",{"tab":4});
      }
      
      private function __inviteBtnClickHandler(param1:MouseEvent) : void
      {
         SoundManager.instance.play("022");
         BraveLegManager.instance.requestInviteList();
         FrameControllerManager.instance.openControllerByInfo("braveleg",{"tab":3});
      }
      
      private function __onUpdateInspireHandler(param1:BraveLegEvent) : void
      {
         _inspireView.data = {
            "isReady":_isReady,
            "data":_data.inspire,
            "count":_data.maxInspireCount - _data.inspireCount
         };
         if(_data)
         {
            _inspireCountTxt.htmlText = LanguageMgr.GetTranslation("braveleg.Team.Inspire",_data.maxInspireCount - _data.inspireCount,_data.maxInspireCount);
         }
      }
      
      private function __closeViewHandler(param1:BraveLegEvent) : void
      {
         dispose();
      }
      
      private function __swtichCloseFrame(param1:NotificationEvent) : void
      {
         dispose();
      }
      
      private function __playerChatHandler(param1:NotificationEvent) : void
      {
         var _loc3_:ChatData = null;
         var _loc4_:int = 0;
         var _loc2_:Component = null;
         if(_data)
         {
            _loc3_ = param1.data as ChatData;
            if(_loc3_.channel != 6 && _loc3_.channel != 8)
            {
               return;
            }
            _loc4_ = 0;
            while(_loc4_ < _data.teammate.length)
            {
               if(_data.teammate[_loc4_].userId == _loc3_.uid && _data.teammate[_loc4_].serverName == _loc3_.serverName)
               {
                  _loc2_ = ChatFactory.createChatPopByType(_loc3_);
                  _loc2_.x = _teammateList.x;
                  _loc2_.y = _teammateList.y + _loc4_ * 98 + 32;
                  addChild(_loc2_);
                  break;
               }
               _loc4_++;
            }
         }
      }
      
      public function set data(param1:BraveLegTeamInfo) : void
      {
         var _loc2_:int = 0;
         var _loc4_:int = 0;
         var _loc3_:int = 0;
         var _loc5_:Object = null;
         if(param1)
         {
            _data = param1;
            _loc2_ = int(param1.teammate.length);
            _loc5_ = {
               "1":[],
               "2":[],
               "3":[]
            };
            _teammateList.beginChanges();
            _teammateList.vectorListModel.clear();
            _loc3_ = 0;
            while(_loc3_ < 4)
            {
               if(_loc3_ < _loc2_)
               {
                  _teammateList.vectorListModel.append(_data.teammate[_loc3_]);
                  _loc5_[_data.teammate[_loc3_].groupId].push(_data.teammate[_loc3_]);
               }
               else
               {
                  _teammateList.vectorListModel.append(null);
               }
               _loc3_++;
            }
            _teammateList.commitChanges();
            _teammateList.list.updateListView();
            _leftTxt.htmlText = LanguageMgr.GetTranslation("braveleg.Team.Left",_data.maxTurnCount - _data.currentTurn,_data.maxTurnCount);
            _inspireView.data = {
               "isReady":_isReady,
               "data":_data.inspire,
               "count":_data.maxInspireCount - _data.inspireCount
            };
            _inspireCountTxt.htmlText = LanguageMgr.GetTranslation("braveleg.Team.Inspire",_data.maxInspireCount - _data.inspireCount,_data.maxInspireCount);
            _timeCount = _data.leftTime;
            _timeTxt.htmlText = getTimeStr(_timeCount);
            if(!_timer.running)
            {
               _timer.start();
            }
            _loc3_ = 0;
            while(_loc3_ < 3)
            {
               _loc4_ = 0;
               while(_loc4_ < 3)
               {
                  _groupItem[_loc3_][_loc4_].data = {
                     "groupId":_loc3_ + 1,
                     "player":_loc5_[_loc3_ + 1][_loc4_]
                  };
                  _loc5_[_loc3_ + 1][_loc4_] = null;
                  _loc4_++;
               }
               _loc5_[_loc3_ + 1].length = 0;
               _loc3_++;
            }
            _loc5_ = null;
         }
         else if(BraveLegManager.instance.model.teamInfo)
         {
            data = BraveLegManager.instance.model.teamInfo;
         }
         else
         {
            dispose();
         }
      }
      
      private function conformQuit(param1:Boolean, param2:Boolean) : void
      {
         if(param1)
         {
            BraveLegManager.instance.requestLeaveTeam();
            dispose();
         }
      }
      
      public function show() : void
      {
         if(parent == null)
         {
            LayerManager.Instance.addToLayer(this,6,true,true,2);
            hideTool();
            KeyBoardRegister.instance.keyEnable = false;
         }
      }
      
      public function hideTool() : void
      {
         TopToolsBar.instance.hide();
         TaskTraceBar.instance.hide();
         QueueBar.instance.hide();
         SmallMapBar.instance.hide();
         MainToolBar.instance.getButtnByType(10).visible = false;
         MainToolBar.instance.getButtnByType(15).visible = false;
         MainToolBar.instance.getButtnByType(16).visible = false;
         MainToolBar.instance.getButtnByType(9).enable = true;
         MainToolBar.instance.getMovieImageByType(1).visible = false;
         MainToolBar.instance.getMovieImageByType(2).visible = false;
         TimeBoxView.instance.hide();
         NotificationManager.instance.dispatchEvent(new NotificationEvent("HIDE_FREEDOMTEAMLIST",true));
         ShowTipManager.Instance.removeAllTip();
         LayerManager.Instance.clearnStageDynamic();
         LayerManager.Instance.clearnGameDynamic();
         LayerManager.Instance.clearGameMenuLayer();
      }
      
      public function showToolView() : void
      {
         TopToolsBar.instance.show();
         TaskTraceBar.instance.show();
         if(SceneManager.instance.currentType != "CAMPAIGN_MAP_SCENE")
         {
            QueueBar.instance.show();
         }
         SmallMapBar.instance.show();
         MainToolBar.instance.buttonsStageByScene(SceneManager.instance.currentType);
         MainToolBar.instance.recommendBtnIsExist(null);
         TimeBoxView.instance.show();
         NotificationManager.instance.dispatchEvent(new NotificationEvent("HIDE_FREEDOMTEAMLIST",false));
      }
      
      public function get viewRectangle() : Rectangle
      {
         return new Rectangle(0,0,722,515);
      }
      
      override public function get groups() : Array
      {
         return [ComponentGroupType.NONE];
      }
      
      public function getTimeStr(param1:uint) : String
      {
         var _loc4_:int = param1 / 3600;
         var _loc3_:int = (param1 - _loc4_ * 3600) / 60;
         var _loc2_:int = param1 - _loc4_ * 3600 - _loc3_ * 60;
         return supplementZero(_loc4_) + ":" + supplementZero(_loc3_) + ":" + supplementZero(_loc2_);
      }
      
      public function supplementZero(param1:Number) : String
      {
         if(param1 < 10)
         {
            return "0" + param1;
         }
         return param1.toString();
      }
   }
}

