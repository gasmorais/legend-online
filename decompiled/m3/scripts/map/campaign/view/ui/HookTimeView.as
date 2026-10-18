package map.campaign.view.ui
{
   import chat.datas.ChatData;
   import com.pickgliss.toplevel.StageReferance;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.IconButton;
   import com.pickgliss.ui.controls.TextButton;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.ui.image.MutipleImage;
   import com.pickgliss.ui.image.Scale9CornerImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectPool;
   import com.pickgliss.utils.ObjectUtils;
   import com.pickgliss.utils.SoundManager;
   import com.road.yishi.proto.campaign.HangupInfoMsg;
   import com.road.yishi.proto.player.PayTypeMsg;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.events.TimerEvent;
   import flash.utils.Timer;
   import manager.LanguageMgr;
   import managers.KingContractManager;
   import map.campaign.CampaignManager;
   import map.campaign.data.CampaignArmy;
   import yishi.comm.PackageIn;
   import yishi.comm.PackageOut;
   import yishi.datas.VersionSwitch;
   import yishi.datas.playerinfo.PlayerInfo;
   import yishi.datas.playerinfo.ThaneInfo;
   import yishi.events.SLGSocketEvent;
   import yishi.manager.ArmyManager;
   import yishi.manager.FrameControllerManager;
   import yishi.manager.NotificationManager;
   import yishi.manager.PlayerManager;
   import yishi.service.managers.SocketManager;
   import yishi.service.managers.SocketSendManager;
   import yishi.utils.SimpleAlertHelper;
   
   public class HookTimeView extends Component
   {
      
      private var _back1:MutipleImage;
      
      private var _back2:Scale9CornerImage;
      
      private var _left:FilterFrameText;
      
      private var _timeTxt:FilterFrameText;
      
      private var _button:IconButton;
      
      private var _cancel:TextButton;
      
      private var _downTime:DownTimeView;
      
      private var _currentWeaky:int;
      
      private var _bottomGap:int = 110;
      
      private var _timer:Timer;
      
      public function HookTimeView()
      {
         super();
         initView();
         initEvent();
         resize();
      }
      
      private function initView() : void
      {
         var _loc2_:int = 0;
         _back1 = ComponentFactory.Instance.creatComponentByStylename("campaign.HookTimeBack");
         _back2 = ComponentFactory.Instance.creatComponentByStylename("campaign.HookBack2");
         _timeTxt = ComponentFactory.Instance.creatComponentByStylename("campaign.HookTimeText");
         _left = ComponentFactory.Instance.creatComponentByStylename("campaign.HookLeft");
         _button = ComponentFactory.Instance.creatComponentByStylename("campaign.HookQuickBtn");
         _cancel = ComponentFactory.Instance.creatComponentByStylename("campaign.HookCancleBtn");
         _downTime = ComponentFactory.Instance.creatCustomObject("campaign.HookDownTime");
         addChild(_back1);
         addChild(_back2);
         addChild(_left);
         addChild(_timeTxt);
         addChild(_downTime);
         addChild(_button);
         addChild(_cancel);
         _back2.visible = false;
         _timeTxt.visible = false;
         _downTime.visible = false;
         _button.visible = false;
         _cancel.visible = false;
         _cancel.text = LanguageMgr.GetTranslation("public.cancel");
         _timeTxt.text = LanguageMgr.GetTranslation("map.campaign.view.ui.HookTimeView.time");
         _left.text = CampaignManager.instance.mapModel.hookleftWeay.toString();
         if(VersionSwitch.KING_CONTRACT)
         {
            _button.tipData = LanguageMgr.GetTranslation("map.campaign.view.ui.HookTimeView.HookTimeView.quickTip");
         }
         else
         {
            _button.tipData = LanguageMgr.GetTranslation("consortia.view.myConsortia.ConsortiaFrameTopView.quickBtnTipData");
         }
         _timer = new Timer(1000);
         _timer.addEventListener("timer",__timerHandler);
         var _loc1_:CampaignArmy = CampaignManager.instance.mapModel.getUserArmyByUserId(thane.userId);
         if(_loc1_ && _loc1_.hangupState > 0)
         {
            _loc2_ = int(CampaignManager.instance.mapModel.hookleftWeay);
            showHooKLeftTime(_loc2_);
            _left.text = _loc2_.toString();
         }
      }
      
      private function initEvent() : void
      {
         _button.addEventListener("click",__quickHandler);
         _cancel.addEventListener("click",__cancelHandler);
         SocketManager.instance.addEventListener("SLGSocketEvent" + 4200,__hookStateHandler);
         SocketManager.instance.addEventListener("SLGSocketEvent" + 4235,__timeUpdateHandler);
         StageReferance.stage.addEventListener("resize",__stageResizeHandler);
      }
      
      private function removeEvent() : void
      {
         _button.removeEventListener("click",__quickHandler);
         _cancel.removeEventListener("click",__cancelHandler);
         if(_timer)
         {
            _timer.removeEventListener("timer",__timerHandler);
         }
         SocketManager.instance.removeEventListener("SLGSocketEvent" + 4200,__hookStateHandler);
         SocketManager.instance.removeEventListener("SLGSocketEvent" + 4235,__timeUpdateHandler);
         StageReferance.stage.removeEventListener("resize",__stageResizeHandler);
      }
      
      private function __stageResizeHandler(param1:Event) : void
      {
         resize();
      }
      
      private function __timeUpdateHandler(param1:SLGSocketEvent) : void
      {
         var _loc5_:PackageIn = param1.data as PackageIn;
         var _loc2_:HangupInfoMsg = new HangupInfoMsg();
         _loc2_ = _loc5_.readBody(_loc2_) as HangupInfoMsg;
         CampaignManager.instance.mapModel.hookleftWeay = _loc2_.leftWeay;
         _left.text = CampaignManager.instance.mapModel.hookleftWeay.toString();
         updateTime(_loc2_.leftWeay);
         PlayerManager.instance.currentPlayerModel.playerInfo.beginChanges();
         PlayerManager.instance.currentPlayerModel.playerInfo.weary += _loc2_.addWeay;
         PlayerManager.instance.currentPlayerModel.playerInfo.commit();
         var _loc4_:ChatData = ObjectPool.getObject(ChatData) as ChatData;
         _loc4_.channel = 3;
         _loc4_.msg = LanguageMgr.GetTranslation("map.campaign.view.ui.HookTimeView.chatData.msg");
         _loc4_.commit();
         NotificationManager.instance.sendNotification("ADD_CHAT",_loc4_);
         var _loc3_:CampaignArmy = CampaignManager.instance.mapModel.getUserArmyByUserId(thane.userId);
         if(_loc3_)
         {
            _loc3_.huangupAdd = 1;
         }
      }
      
      private function __hookStateHandler(param1:SLGSocketEvent) : void
      {
         var _loc3_:CampaignArmy = null;
         var _loc4_:PackageIn = param1.data as PackageIn;
         var _loc2_:HangupInfoMsg = new HangupInfoMsg();
         _loc2_ = _loc4_.readBody(_loc2_) as HangupInfoMsg;
         CampaignManager.instance.mapModel.hookleftWeay = _loc2_.leftWeay;
         _left.text = _loc2_.leftWeay.toString();
         if(_loc2_.isStartHangup)
         {
            showHooKLeftTime(_loc2_.leftWeay);
         }
         else
         {
            hideHooKLeftTime();
            _loc3_ = CampaignManager.instance.mapModel.getUserArmyByUserId(thane.userId);
            if(_loc3_)
            {
               _loc3_.huangupAdd = _loc2_.addWeay;
            }
         }
      }
      
      private function showHooKLeftTime(param1:int) : void
      {
         _back2.visible = true;
         _timeTxt.visible = true;
         _downTime.visible = true;
         _button.visible = true;
         _cancel.visible = true;
         _bottomGap = 200;
         resize();
         updateTime(param1);
      }
      
      private function hideHooKLeftTime() : void
      {
         _back2.visible = false;
         _timeTxt.visible = false;
         _downTime.visible = false;
         _button.visible = false;
         _cancel.visible = false;
         _bottomGap = 110;
         resize();
      }
      
      private function updateTime(param1:Number) : void
      {
         _currentWeaky = param1 * 2 * 60;
         _downTime.time = _currentWeaky;
         if(!_timer.running)
         {
            _timer.start();
         }
      }
      
      private function __timerHandler(param1:TimerEvent) : void
      {
         _currentWeaky = _currentWeaky - 1;
         if(_currentWeaky == 0)
         {
            _timer.stop();
         }
         _downTime.time = _currentWeaky;
      }
      
      private function __cancelHandler(param1:MouseEvent) : void
      {
         SoundManager.instance.play("008");
         SimpleAlertHelper.instance.data = [__cancelCallBack];
         var _loc2_:String = LanguageMgr.GetTranslation("public.confirm");
         var _loc3_:String = LanguageMgr.GetTranslation("public.cancel");
         var _loc4_:String = LanguageMgr.GetTranslation("public.prompt");
         var _loc5_:String = LanguageMgr.GetTranslation("map.campaign.view.ui.HookTimeView.content01");
         SimpleAlertHelper.instance.popAlerFrame(_loc4_,_loc5_,_loc2_,_loc3_);
      }
      
      private function __cancelCallBack(param1:Boolean, param2:Boolean) : void
      {
         var _loc3_:PackageOut = null;
         if(param1)
         {
            _loc3_ = new PackageOut(8292);
            SocketSendManager.instance.send(_loc3_);
         }
      }
      
      private function __quickHandler(param1:MouseEvent) : void
      {
         var _loc5_:int = 0;
         var _loc7_:int = 0;
         var _loc2_:String = null;
         var _loc3_:String = null;
         var _loc8_:String = null;
         var _loc10_:String = null;
         var _loc9_:String = null;
         var _loc4_:String = null;
         SoundManager.instance.play("022");
         var _loc6_:int = int(CampaignManager.instance.mapModel.hookleftWeay);
         if(_loc6_ != 0)
         {
            if(KingContractManager.Instance.checkHasBuffById(4))
            {
               quickFree();
            }
            else
            {
               _loc5_ = int(PlayerManager.instance.currentPlayerModel.playerInfo.weary);
               _loc7_ = 200 - _loc5_;
               _loc6_ = _loc6_ < _loc7_ ? _loc6_ : _loc7_;
               SimpleAlertHelper.instance.data = [allCoolBack,_loc6_];
               _loc2_ = LanguageMgr.GetTranslation("public.confirm");
               _loc3_ = LanguageMgr.GetTranslation("public.cancel");
               _loc8_ = LanguageMgr.GetTranslation("public.prompt");
               _loc10_ = LanguageMgr.GetTranslation("map.campaign.view.ui.HookTimeView.content02",_loc6_);
               _loc9_ = LanguageMgr.GetTranslation("map.campaign.view.ui.HookTimeView.freeTip");
               _loc4_ = "<font color=\'#06ff00\'><a href=\'event:clickLink\'><u>" + LanguageMgr.GetTranslation("mainBar.view.ChoosePayTypeFrame.openVipTxt") + "</u></a></font>";
               _loc9_ += LanguageMgr.GetTranslation("public.parentheses1",_loc4_);
               SimpleAlertHelper.instance.popAlerFrame(_loc8_,_loc10_,_loc2_,_loc3_,false,false,false,2,"USEBINDPOINT_ALERT",0,_loc9_,openKingCall,"SimpleAlert",_loc6_);
            }
         }
      }
      
      private function openKingCall() : void
      {
         FrameControllerManager.instance.openControllerByInfo("kingcontract");
      }
      
      private function allCoolBack(param1:Boolean, param2:Boolean, param3:int) : void
      {
         var _loc4_:int = int(CampaignManager.instance.mapModel.hookleftWeay);
         if(param1 && _loc4_ != 0)
         {
            quickFree(param2);
         }
      }
      
      private function quickFree(param1:Boolean = true) : void
      {
         var _loc4_:PackageOut = null;
         var _loc2_:PayTypeMsg = null;
         var _loc3_:int = int(CampaignManager.instance.mapModel.hookleftWeay);
         if(_loc3_ != 0)
         {
            _loc4_ = new PackageOut(8293);
            _loc2_ = new PayTypeMsg();
            _loc2_.payType = 0;
            if(!param1)
            {
               _loc2_.payType = 1;
            }
            SocketSendManager.instance.sendProtoBuffer(_loc4_,_loc2_);
         }
      }
      
      private function resize() : void
      {
         x = (StageReferance.stageWidth - this.displayWidth) / 2;
         y = StageReferance.stageHeight - _bottomGap;
      }
      
      private function get playerInfo() : PlayerInfo
      {
         return PlayerManager.instance.currentPlayerModel.playerInfo;
      }
      
      private function get thane() : ThaneInfo
      {
         return ArmyManager.instance.thane;
      }
      
      override public function dispose() : void
      {
         removeEvent();
         ObjectUtils.disposeObject(_back1);
         _back1 = null;
         ObjectUtils.disposeObject(_back2);
         _back2 = null;
         if(_timer)
         {
            _timer.stop();
         }
         _timer = null;
         if(_left)
         {
            _left.dispose();
         }
         _left = null;
         if(_timeTxt)
         {
            _timeTxt.dispose();
         }
         _timeTxt = null;
         if(_button)
         {
            _button.dispose();
         }
         _button = null;
         if(_cancel)
         {
            _cancel.dispose();
         }
         _cancel = null;
         if(_downTime)
         {
            _downTime.dispose();
         }
         _downTime = null;
         super.dispose();
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}

