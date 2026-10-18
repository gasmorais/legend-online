package braveleg
{
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.instance.IManualSize;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.ui.controls.ListPanel;
   import com.pickgliss.ui.controls.TextButton;
   import com.pickgliss.ui.image.ScaleBitmapImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import com.pickgliss.utils.SoundManager;
   import events.BraveLegEvent;
   import flash.events.MouseEvent;
   import flash.events.TimerEvent;
   import flash.geom.Rectangle;
   import flash.utils.Timer;
   import flash.utils.getTimer;
   import manager.LanguageMgr;
   import mvc.module.braveleg.BraveLegModel;
   import mvc.module.braveleg.BraveLegPlayerInfo;
   import yishi.datas.ComponentGroupType;
   import yishi.manager.BraveLegManager;
   import yishi.view.tips.MessageTipManager;
   
   public class BraveLegInviteFrame extends Frame implements IManualSize
   {
      
      private static const MaxTime:int = 60;
      
      private var _listBG:ScaleBitmapImage;
      
      private var _listPanel:ListPanel;
      
      private var _refreshBtn:TextButton;
      
      private var _timeTxt:FilterFrameText;
      
      private var _clickTime:int;
      
      private var _model:BraveLegModel = BraveLegManager.instance.model;
      
      private var _timer:Timer;
      
      private var _timeCount:int = 60;
      
      public function BraveLegInviteFrame()
      {
         super();
         initView();
         addEvent();
         refresh();
      }
      
      private function initView() : void
      {
         _listBG = ComponentFactory.Instance.creatComponentByStylename("braveleg.InviteListBG");
         _listPanel = ComponentFactory.Instance.creatComponentByStylename("braveleg.InviteList");
         _refreshBtn = ComponentFactory.Instance.creatComponentByStylename("braveleg.InviteRefreshBtn");
         _timeTxt = ComponentFactory.Instance.creatComponentByStylename("braveleg.InviteTimeTxt");
         addToContent(_listBG);
         addToContent(_listPanel);
         addToContent(_refreshBtn);
         addToContent(_timeTxt);
         titleText = LanguageMgr.GetTranslation("room.view.invite.RoomInviteFrame.title");
         _refreshBtn.text = LanguageMgr.GetTranslation("room.view.invite.RoomInviteFrame.refreshBtn.text");
         _listPanel.list.updateListView();
         _timer = new Timer(1000);
         _timer.start();
      }
      
      private function addEvent() : void
      {
         addEventListener("response",__frameResponseHandler);
         _refreshBtn.addEventListener("click",__refreshClick);
         _timer.addEventListener("timer",__timeUpdateHandler);
         _model.addEventListener("BraveLegEvent.INVITE_INFO",__inviteInfoUpdateHandler);
      }
      
      private function removeEvent() : void
      {
         removeEventListener("response",__frameResponseHandler);
         _refreshBtn.removeEventListener("click",__refreshClick);
         _timer.removeEventListener("timer",__timeUpdateHandler);
         _model.removeEventListener("BraveLegEvent.INVITE_INFO",__inviteInfoUpdateHandler);
      }
      
      private function __refreshClick(param1:MouseEvent) : void
      {
         SoundManager.instance.play("022");
         var _loc2_:int = getTimer();
         if(_loc2_ - _clickTime < 1000)
         {
            MessageTipManager.instance().show(LanguageMgr.GetTranslation("braveleg.Error.str06"));
            return;
         }
         _clickTime = _loc2_;
         _timeCount = 60;
         _timeTxt.htmlText = LanguageMgr.GetTranslation("braveleg.Invite.refresh",_timeCount);
         BraveLegManager.instance.requestInviteList();
      }
      
      private function __timeUpdateHandler(param1:TimerEvent) : void
      {
         _timeCount = _timeCount - 1;
         _timeTxt.htmlText = LanguageMgr.GetTranslation("braveleg.Invite.refresh",_timeCount);
         if(_timeCount <= 0)
         {
            _timeCount = 60;
            BraveLegManager.instance.requestInviteList();
         }
      }
      
      private function __inviteInfoUpdateHandler(param1:BraveLegEvent) : void
      {
         refresh();
      }
      
      private function refresh() : void
      {
         var _loc3_:int = 0;
         var _loc2_:int = 0;
         _listPanel.beginChanges();
         _listPanel.vectorListModel.clear();
         var _loc1_:Vector.<BraveLegPlayerInfo> = _model.inviteList;
         _loc3_ = 0;
         _loc2_ = int(_loc1_.length);
         while(_loc3_ < _loc2_)
         {
            _listPanel.vectorListModel.append(_loc1_[_loc3_]);
            _loc3_++;
         }
         _listPanel.commitChanges();
         _listPanel.list.updateListView();
      }
      
      override public function dispose() : void
      {
         removeEvent();
         ObjectUtils.disposeObject(_listBG);
         _listBG = null;
         ObjectUtils.disposeObject(_listPanel);
         _listPanel = null;
         ObjectUtils.disposeObject(_refreshBtn);
         _refreshBtn = null;
         ObjectUtils.disposeObject(_timeTxt);
         _timeTxt = null;
         _model = null;
         if(_timer)
         {
            _timer.stop();
            _timer = null;
         }
         super.dispose();
      }
      
      private function __frameResponseHandler(param1:FrameEvent) : void
      {
         switch(int(param1.responseCode))
         {
            case 0:
            case 1:
               dispose();
         }
      }
      
      public function show() : void
      {
         LayerManager.Instance.addToLayer(this,3,true,true,2);
      }
      
      public function get viewRectangle() : Rectangle
      {
         return new Rectangle(0,0,306,442);
      }
      
      override public function get groups() : Array
      {
         return [ComponentGroupType.NONE];
      }
   }
}

