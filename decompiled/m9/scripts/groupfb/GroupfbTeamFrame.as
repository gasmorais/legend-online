package groupfb
{
   import com.greensock.TweenLite;
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.BaseButton;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.ui.controls.IconButton;
   import com.pickgliss.ui.controls.SelectedCheckButton;
   import com.pickgliss.ui.controls.SimpleBitmapButton;
   import com.pickgliss.ui.controls.TextButton;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Bitmap;
   import flash.display.BitmapData;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.geom.Matrix;
   import flash.geom.Rectangle;
   import manager.LanguageMgr;
   import managers.GroupfbManager;
   import map.campaign.CampaignManager;
   import mvc.ModuleFrameInfo;
   import mvc.module.groupfb.GroupfbModel;
   import mvc.module.groupfb.GroupfbSender;
   import yishi.manager.FrameControllerManager;
   import yishi.manager.PlayerManager;
   import yishi.utils.MsgMan;
   import yishi.utils.SimpleAlertHelper;
   import yishi.utils.StringHelper;
   import yishi.utils.WorldBossHelper;
   import yishi.view.RoomPasswordFrame;
   import yishi.view.tips.MessageTipManager;
   
   public class GroupfbTeamFrame extends Frame
   {
      
      private var _team1:GroupfbTeamListView;
      
      private var _team2:GroupfbTeamListView;
      
      private var _lineupBtn:TextButton;
      
      private var _prepareBtn:IconButton;
      
      private var _cancleBtn:IconButton;
      
      private var _startBtn:IconButton;
      
      private var _exitBtn:IconButton;
      
      private var _lockBtn1:SimpleBitmapButton;
      
      private var _lockBtn2:SimpleBitmapButton;
      
      private var _roomTitle:FilterFrameText;
      
      private var _checkBtn:SelectedCheckButton;
      
      private var _hitBitmap:Bitmap;
      
      public function GroupfbTeamFrame()
      {
         super();
         initView();
         initEvent();
      }
      
      public function get viewRectangle() : Rectangle
      {
         return new Rectangle(0,0,510,545);
      }
      
      override public function get groups() : Array
      {
         return ["MAIN_TOOLS_GROUP","BAG_GROUP"];
      }
      
      private function initView() : void
      {
         titleText = LanguageMgr.GetTranslation("map.campaign.view.frame.ArmyManageFrame.title");
         _lineupBtn = ComponentFactory.Instance.creatComponentByStylename("GroupfbTeamFrame.lineupBtn");
         _prepareBtn = ComponentFactory.Instance.creatComponentByStylename("GroupfbTeamFrame.prepareBtn");
         _cancleBtn = ComponentFactory.Instance.creatComponentByStylename("GroupfbTeamFrame.cancleBtn");
         _startBtn = ComponentFactory.Instance.creatComponentByStylename("GroupfbTeamFrame.startBtn");
         _exitBtn = ComponentFactory.Instance.creatComponentByStylename("GroupfbTeamFrame.exitBtn");
         _lockBtn1 = ComponentFactory.Instance.creatComponentByStylename("GroupfbTeamFrame.loceBtn1");
         _lockBtn2 = ComponentFactory.Instance.creatComponentByStylename("GroupfbTeamFrame.loceBtn2");
         _roomTitle = ComponentFactory.Instance.creatComponentByStylename("GroupfbTeamFrame.RoomTitle");
         _checkBtn = ComponentFactory.Instance.creatComponentByStylename("GroupfbTeamFrame.checkBtn");
         _team1 = new GroupfbTeamListView(1);
         _team2 = new GroupfbTeamListView(2);
         addToContent(_team1);
         addToContent(_team2);
         addToContent(_roomTitle);
         addToContent(_lineupBtn);
         addToContent(_prepareBtn);
         addToContent(_cancleBtn);
         addToContent(_startBtn);
         addToContent(_exitBtn);
         addToContent(_lockBtn1);
         addToContent(_lockBtn2);
         addToContent(_checkBtn);
         _team2.y = 215;
         _lineupBtn.text = LanguageMgr.GetTranslation("armyII.viewII.allocate.AllocateView.sort");
         _lockBtn1.tipData = _lockBtn2.tipData = LanguageMgr.GetTranslation("yishi.view.RoomPasswordFrame.titleTxt");
         _checkBtn.text = LanguageMgr.GetTranslation("groupfb.GroupfbTeamFrame.useCount");
      }
      
      override public function set closeButton(param1:BaseButton) : void
      {
         super.closeButton = param1;
         closeButton.tipData = LanguageMgr.GetTranslation("groupfb.GroupfbTeamItem.closeBtnTips");
         closeButton.tipDirctions = "7,6,5";
         closeButton.tipGapH = closeButton.tipGapV = 0;
      }
      
      private function unitView() : void
      {
         if(_team1)
         {
            _team1.dispose();
         }
         _team1 = null;
         if(_team2)
         {
            _team2.dispose();
         }
         _team2 = null;
         if(_lineupBtn)
         {
            _lineupBtn.dispose();
         }
         _lineupBtn = null;
         if(_prepareBtn)
         {
            _prepareBtn.dispose();
         }
         _prepareBtn = null;
         if(_cancleBtn)
         {
            _cancleBtn.dispose();
         }
         _cancleBtn = null;
         if(_startBtn)
         {
            _startBtn.dispose();
         }
         _startBtn = null;
         if(_exitBtn)
         {
            _exitBtn.dispose();
         }
         _exitBtn = null;
         if(_lockBtn1)
         {
            _lockBtn1.dispose();
         }
         _lockBtn1 = null;
         if(_lockBtn2)
         {
            _lockBtn2.dispose();
         }
         _lockBtn2 = null;
         if(_roomTitle)
         {
            _roomTitle.dispose();
         }
         _roomTitle = null;
         ObjectUtils.disposeObject(_hitBitmap);
         _hitBitmap = null;
         if(_checkBtn)
         {
            _checkBtn.dispose();
         }
         _checkBtn = null;
      }
      
      private function initEvent() : void
      {
         addEventListener("response",__frameResponse);
         if(_lineupBtn)
         {
            _lineupBtn.addEventListener("click",__lineupBtnHandler);
         }
         if(_prepareBtn)
         {
            _prepareBtn.addEventListener("click",__prepareBtnHandler);
         }
         if(_cancleBtn)
         {
            _cancleBtn.addEventListener("click",__cancleBtnHandler);
         }
         if(_startBtn)
         {
            _startBtn.addEventListener("click",__startBtnHandler);
         }
         if(_exitBtn)
         {
            _exitBtn.addEventListener("click",__exitBtnHandler);
         }
         if(_lockBtn1)
         {
            _lockBtn1.addEventListener("click",__lockBtnHandler);
         }
         if(_lockBtn2)
         {
            _lockBtn2.addEventListener("click",__lockBtnHandler);
         }
         if(_checkBtn)
         {
            _checkBtn.addEventListener("select",__checkBtnHandler);
         }
         MsgMan.addObserver("PVPRoomListEvent.GROUP_ROOM_UPDATE",this,__teamUpdateHandler);
      }
      
      private function removeEvent() : void
      {
         removeEventListener("response",__frameResponse);
         if(_lineupBtn)
         {
            _lineupBtn.removeEventListener("click",__lineupBtnHandler);
         }
         if(_prepareBtn)
         {
            _prepareBtn.removeEventListener("click",__prepareBtnHandler);
         }
         if(_cancleBtn)
         {
            _cancleBtn.removeEventListener("click",__cancleBtnHandler);
         }
         if(_startBtn)
         {
            _startBtn.removeEventListener("click",__startBtnHandler);
         }
         if(_exitBtn)
         {
            _exitBtn.removeEventListener("click",__exitBtnHandler);
         }
         if(_lockBtn1)
         {
            _lockBtn1.removeEventListener("click",__lockBtnHandler);
         }
         if(_lockBtn2)
         {
            _lockBtn2.removeEventListener("click",__lockBtnHandler);
         }
         if(_checkBtn)
         {
            _checkBtn.removeEventListener("select",__checkBtnHandler);
         }
         MsgMan.removeObserver("PVPRoomListEvent.GROUP_ROOM_UPDATE",this,__teamUpdateHandler);
      }
      
      private function __frameResponse(param1:FrameEvent) : void
      {
         var _loc2_:Rectangle = null;
         var _loc4_:BitmapData = null;
         var _loc3_:Matrix = null;
         switch(int(param1.responseCode))
         {
            case 0:
            case 1:
               _loc2_ = this.getBounds(this);
               _loc4_ = new BitmapData(_loc2_.width,_loc2_.height,true,0);
               _loc3_ = new Matrix();
               _loc3_.translate(-_loc2_.x,-_loc2_.y);
               _loc4_.draw(this,_loc3_);
               _hitBitmap = new Bitmap(_loc4_);
               _hitBitmap.x = _loc2_.x;
               _hitBitmap.y = _loc2_.y;
               if(parent)
               {
                  parent.addChild(_hitBitmap);
               }
               if(_hitBitmap)
               {
                  TweenLite.to(_hitBitmap,0.5,{
                     "x":88,
                     "y":138,
                     "width":5,
                     "height":5,
                     "onComplete":disapearComplete
                  });
               }
               visible = false;
         }
      }
      
      private function disapearComplete() : void
      {
         dispose();
      }
      
      private function __checkBtnHandler(param1:Event) : void
      {
         if(model.selfTeam.selfInfo.isNoGet == _checkBtn.selected)
         {
            GroupfbSender.useIncome(!_checkBtn.selected);
         }
      }
      
      private function __lockBtnHandler(param1:MouseEvent) : void
      {
         var _loc2_:RoomPasswordFrame = ComponentFactory.Instance.creatComponentByStylename("core.RoomPasswordFrame");
         _loc2_.backCall = passwordInputBack;
         _loc2_.show(model.selfTeam.id);
      }
      
      private function passwordInputBack(param1:int, param2:String) : void
      {
         GroupfbSender.changePassward(param2);
      }
      
      private function __lineupBtnHandler(param1:MouseEvent) : void
      {
         FrameControllerManager.instance.openControllerByInfo("teammanager","GROUP_SORT_FRAME");
      }
      
      private function __prepareBtnHandler(param1:MouseEvent) : void
      {
         if(_prepareBtn)
         {
            _prepareBtn.enable = false;
         }
         if(_checkBtn)
         {
            GroupfbSender.editGroup(2,!_checkBtn.selected);
         }
      }
      
      private function __cancleBtnHandler(param1:MouseEvent) : void
      {
         if(_cancleBtn)
         {
            _cancleBtn.enable = false;
         }
         GroupfbSender.editGroup(1);
      }
      
      private function __exitBtnHandler(param1:MouseEvent) : void
      {
         if(_exitBtn)
         {
            _exitBtn.enable = false;
         }
         SimpleAlertHelper.instance.data = [exitCallBack];
         var _loc2_:String = LanguageMgr.GetTranslation("public.confirm");
         var _loc3_:String = LanguageMgr.GetTranslation("public.cancel");
         var _loc4_:String = LanguageMgr.GetTranslation("public.prompt");
         var _loc5_:String = LanguageMgr.GetTranslation("groupfb.GroupfbTeamFrame.exitTips");
         SimpleAlertHelper.instance.popAlerFrame(_loc4_,_loc5_,_loc2_,_loc3_);
      }
      
      private function exitCallBack(param1:Boolean, param2:Boolean) : void
      {
         if(param1)
         {
            GroupfbSender.exitGroup();
         }
         else if(_exitBtn)
         {
            _exitBtn.enable = true;
         }
      }
      
      private function __startBtnHandler(param1:MouseEvent) : void
      {
         var _loc2_:String = null;
         var _loc3_:String = null;
         var _loc4_:String = null;
         var _loc5_:String = null;
         if(_startBtn)
         {
            _startBtn.enable = false;
         }
         if(model.selfTeam.list.length < 2)
         {
            MessageTipManager.instance().show(LanguageMgr.GetTranslation("groupfb.GroupfbTeamFrame.peopleLimit1"));
         }
         else if(model.selfTeam.getTeamList(1).length <= 0)
         {
            MessageTipManager.instance().show(LanguageMgr.GetTranslation("groupfb.GroupfbTeamFrame.peopleLimit2",1));
         }
         else if(model.selfTeam.getTeamList(2).length <= 0)
         {
            MessageTipManager.instance().show(LanguageMgr.GetTranslation("groupfb.GroupfbTeamFrame.peopleLimit2",2));
         }
         else
         {
            SimpleAlertHelper.instance.data = [startCampaignCall];
            _loc2_ = LanguageMgr.GetTranslation("public.confirm");
            _loc3_ = LanguageMgr.GetTranslation("public.cancel");
            _loc4_ = LanguageMgr.GetTranslation("public.prompt");
            _loc5_ = LanguageMgr.GetTranslation("groupfb.GroupfbTeamFrame.startTips");
            SimpleAlertHelper.instance.popAlerFrame(_loc4_,_loc5_,_loc2_,_loc3_,false,true);
         }
      }
      
      private function startCampaignCall(param1:Boolean, param2:Boolean) : void
      {
         if(param1)
         {
            if(_checkBtn)
            {
               GroupfbSender.startCampaign(!_checkBtn.selected);
            }
         }
         else if(_startBtn)
         {
            _startBtn.enable = true;
         }
      }
      
      private function __teamUpdateHandler(param1:String, param2:Object) : void
      {
         refreshView();
      }
      
      private function refreshView() : void
      {
         if(isDie)
         {
            return;
         }
         if(model.hasGroupTeam == false)
         {
            dispose();
            return;
         }
         if(_team1)
         {
            _team1.refreshView();
         }
         if(_team2)
         {
            _team2.refreshView();
         }
         _roomTitle.text = "No." + model.selfTeam.id;
         _prepareBtn.visible = model.isWait && !model.isCaptain;
         _cancleBtn.visible = model.isReady && !model.isCaptain;
         _startBtn.visible = model.isCaptain;
         _startBtn.enable = model.canStart && !WorldBossHelper.checkGroupfb(CampaignManager.instance.mapId);
         _prepareBtn.enable = !WorldBossHelper.checkGroupfb(CampaignManager.instance.mapId);
         _cancleBtn.enable = !WorldBossHelper.checkGroupfb(CampaignManager.instance.mapId);
         _exitBtn.enable = true;
         _lockBtn1.visible = model.isCaptain && Boolean(StringHelper.isNullOrEmpty(model.selfTeam.passWord));
         _lockBtn2.visible = model.isCaptain && !StringHelper.isNullOrEmpty(model.selfTeam.passWord);
         _checkBtn.selected = !model.selfTeam.selfInfo.isNoGet;
         if(PlayerManager.instance.currentPlayerModel.playerInfo.teamCount <= 0 || Boolean(WorldBossHelper.checkGroupfb(CampaignManager.instance.mapId)))
         {
            _checkBtn.enable = false;
         }
         else
         {
            _checkBtn.enable = model.isWait || Boolean(model.isCaptain);
         }
      }
      
      private function get model() : GroupfbModel
      {
         return GroupfbManager.instance.model;
      }
      
      public function show(param1:ModuleFrameInfo = null) : void
      {
         refreshView();
         LayerManager.Instance.addToLayer(this,3,true,true);
      }
      
      override public function dispose() : void
      {
         TweenLite.killTweensOf(_hitBitmap);
         removeEvent();
         unitView();
         super.dispose();
      }
   }
}

