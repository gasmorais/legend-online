package secretary
{
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.ui.controls.IconButton;
   import com.pickgliss.ui.controls.ScrollPanel;
   import com.pickgliss.ui.controls.container.VBox;
   import com.pickgliss.utils.SoundManager;
   import com.road.yishi.proto.player.AssistantMsg;
   import events.MopupEvent;
   import flash.events.MouseEvent;
   import flash.geom.Rectangle;
   import manager.LanguageMgr;
   import managers.KingContractManager;
   import managers.MopupManager;
   import managers.SecretaryManager;
   import mvc.module.mopup.MopupModel;
   import mvc.module.secretary.SecretaryData;
   import secretary.item.SecretaryAwardItem;
   import yishi.comm.PackageIn;
   import yishi.datas.ComponentGroupType;
   import yishi.datas.goods.GoodsInfo;
   import yishi.events.NotificationEvent;
   import yishi.events.SLGSocketEvent;
   import yishi.manager.NotificationManager;
   import yishi.manager.TempleteManager;
   import yishi.service.managers.SocketManager;
   import yishi.utils.MsgMan;
   import yishi.utils.SimpleAlertHelper;
   import yishi.view.tips.MessageTipManager;
   
   public class SecretaryAwardFrame extends Frame
   {
      
      private var _mopupAccelerateBtn:IconButton;
      
      private var _mopupVBox:VBox;
      
      private var _mopupListScroll:ScrollPanel;
      
      private var _currentBattleItem:SecretaryAwardItem;
      
      private var _mopupCancelBtn:IconButton;
      
      public function SecretaryAwardFrame()
      {
         super();
         this.visible = false;
         initView();
         addEvent();
         initData();
      }
      
      override public function get groups() : Array
      {
         return [ComponentGroupType.NONE];
      }
      
      public function show() : void
      {
         LayerManager.Instance.addToLayer(this,3,true,true,1);
      }
      
      public function get viewRectangle() : Rectangle
      {
         return new Rectangle(0,0,320,600);
      }
      
      private function initView() : void
      {
         titleText = LanguageMgr.GetTranslation("secretary.LittleSecretaryFrameTips8");
         _mopupListScroll = ComponentFactory.Instance.creatComponentByStylename("secretary.secretaryListScrollPanel");
         _mopupVBox = ComponentFactory.Instance.creatComponentByStylename("secretary.secretaryListVbox");
         addToContent(_mopupListScroll);
         _mopupListScroll.setView(_mopupVBox);
         _mopupAccelerateBtn = ComponentFactory.Instance.creatComponentByStylename("secretary.secretaryListBtn");
         _mopupCancelBtn = ComponentFactory.Instance.creatComponentByStylename("secretary.secretaryListCancelBtn");
         addToContent(_mopupAccelerateBtn);
         addToContent(_mopupCancelBtn);
         _mopupAccelerateBtn.visible = false;
         _mopupCancelBtn.visible = false;
      }
      
      private function addEvent() : void
      {
         SocketManager.instance.addEventListener("SLGSocketEvent" + 592,refrshView);
         _model.addEventListener("MOPUP_END",__reMopupView);
         NotificationManager.instance.addEventListener("LITTLESECRETARY",__currencyHandler);
         _model.addEventListener("MOPUP_RESULT_LIST_REFRESH",__refreshView);
         _model.addEventListener("MOPUP_END",__refreshView);
         _mopupAccelerateBtn.addEventListener("click",__accelerateHandler);
         _mopupCancelBtn.addEventListener("click",__cancelHandler);
         addEventListener("response",__frameResponse);
         MsgMan.addObserver("LitteActionManager",this,__refreshTitle);
      }
      
      private function useAlertDispose() : void
      {
         SimpleAlertHelper.instance.data = [disposeBack];
         var _loc1_:String = LanguageMgr.GetTranslation("public.confirm");
         var _loc2_:String = LanguageMgr.GetTranslation("public.cancel");
         var _loc3_:String = LanguageMgr.GetTranslation("public.prompt");
         var _loc4_:String = LanguageMgr.GetTranslation("mopup.view.MazeMopupIngFrame.alertContent");
         SimpleAlertHelper.instance.popAlerFrame(_loc3_,_loc4_,_loc1_,_loc2_,true);
      }
      
      private function disposeBack(param1:Boolean, param2:Boolean) : void
      {
         if(param1)
         {
            dispose();
         }
      }
      
      public function refrshView(param1:SLGSocketEvent) : void
      {
         var _loc6_:GoodsInfo = null;
         var _loc4_:int = 0;
         var _loc5_:PackageIn = param1.data as PackageIn;
         var _loc2_:AssistantMsg = new AssistantMsg();
         _loc2_ = _loc5_.readBody(_loc2_) as AssistantMsg;
         _mopupVBox.beginChanges();
         _currentBattleItem = new SecretaryAwardItem(_loc2_.type);
         var _loc3_:Array = [];
         _loc4_ = 0;
         while(_loc4_ < _loc2_.items.length)
         {
            _loc6_ = new GoodsInfo();
            _loc6_.templateId = _loc2_.items[_loc4_].itemId;
            _loc6_.count = _loc2_.items[_loc4_].num;
            _loc3_.push(_loc6_);
            _loc4_++;
         }
         _currentBattleItem.updateView(_loc3_);
         this.visible = true;
         _mopupVBox.addChild(_currentBattleItem);
         _mopupVBox.commitChanges();
         _mopupListScroll.invalidateViewport(true);
      }
      
      public function __reMopupView(param1:MopupEvent) : void
      {
         _mopupAccelerateBtn.visible = false;
      }
      
      public function __refreshView(param1:MopupEvent) : void
      {
         var _loc2_:int = 0;
         _loc2_ = 0;
         while(_loc2_ < _model.resultInfoList.length)
         {
            if(_model.resultInfoList[_loc2_].items.length > 0)
            {
               _mopupVBox.commitChanges();
               _mopupListScroll.invalidateViewport(true);
            }
            _loc2_++;
         }
      }
      
      public function __currencyHandler(param1:NotificationEvent) : void
      {
         var _loc2_:int = 0;
         _mopupAccelerateBtn.visible = true;
         _mopupVBox.beginChanges();
         switch(_model.campaignId)
         {
            case 8001:
               _loc2_ = 2;
               break;
            case 8101:
               _loc2_ = 3;
               break;
            case 8401:
               _loc2_ = 4;
         }
         _currentBattleItem = new SecretaryAwardItem(_loc2_);
         _mopupVBox.addChild(_currentBattleItem);
         this.visible = true;
         _mopupVBox.commitChanges();
         _mopupListScroll.invalidateViewport(true);
      }
      
      private function get _model() : MopupModel
      {
         return MopupManager.instance.model;
      }
      
      public function initData() : void
      {
      }
      
      private function __accelerateHandler(param1:MouseEvent) : void
      {
         var _loc6_:Array = null;
         var _loc4_:int = 0;
         var _loc2_:String = null;
         var _loc3_:String = null;
         var _loc5_:String = null;
         var _loc7_:String = null;
         if(KingContractManager.Instance.checkHasBuffById(4))
         {
            MopupManager.instance.sendMopupInfo(2,2,0,0,0,1,false,false);
         }
         else
         {
            SoundManager.instance.play("022");
            _loc6_ = TempleteManager.instance.getConfigInfoByConfigName("Sweep_Fast").ConfigValue.split(",");
            _loc4_ = int(Math.ceil(_model.mopupRemainTime / (60 * _loc6_[1]))) * _loc6_[0];
            SimpleAlertHelper.instance.data = [accelerateBack];
            _loc2_ = LanguageMgr.GetTranslation("public.confirm");
            _loc3_ = LanguageMgr.GetTranslation("public.cancel");
            _loc5_ = LanguageMgr.GetTranslation("public.prompt");
            _loc7_ = LanguageMgr.GetTranslation("mopup.view.MazeMopupIngFrame.AccelerateTip",_loc4_);
            SimpleAlertHelper.instance.popAlerFrame(_loc5_,_loc7_,_loc2_,_loc3_,true,false,false,2,"USEBINDPOINT_ALERT",0,"",null,"SimpleAlert",_loc4_);
         }
      }
      
      private function accelerateBack(param1:Boolean, param2:Boolean) : void
      {
         var _loc3_:String = null;
         var _loc4_:int = 0;
         if(param1)
         {
            if(_model.mopupEnd)
            {
               _loc3_ = LanguageMgr.GetTranslation("mopup.view.MazeMopupIngFrame.mopupEnd");
               MessageTipManager.instance().show(_loc3_);
            }
            else
            {
               _loc4_ = 2;
               if(!param2)
               {
                  _loc4_ = 1;
               }
               MopupManager.instance.sendMopupInfo(2,2,0,0,0,1,false,false,_loc4_);
            }
         }
      }
      
      private function removeEvent() : void
      {
         NotificationManager.instance.removeEventListener("LITTLESECRETARY",__currencyHandler);
         _model.removeEventListener("MOPUP_RESULT_LIST_REFRESH",__refreshView);
         _model.removeEventListener("MOPUP_END",__refreshView);
         SocketManager.instance.removeEventListener("SLGSocketEvent" + 592,refrshView);
         _mopupAccelerateBtn.removeEventListener("click",__accelerateHandler);
         _mopupCancelBtn.removeEventListener("click",__cancelHandler);
         removeEventListener("response",__frameResponse);
         MsgMan.removeObserver("LitteActionManager",this,__refreshTitle);
         _model.removeEventListener("MOPUP_END",__reMopupView);
      }
      
      private function __refreshTitle(param1:String, param2:Object) : void
      {
         titleText = LanguageMgr.GetTranslation("secretary.LittleSecretaryFrameTips9");
         _mopupAccelerateBtn.visible = false;
         _mopupCancelBtn.visible = true;
         if(!this.visible)
         {
            dispose();
         }
      }
      
      private function get model() : SecretaryData
      {
         return SecretaryManager.instance.model;
      }
      
      private function __frameResponse(param1:FrameEvent) : void
      {
         switch(int(param1.responseCode))
         {
            case 0:
            case 1:
               dispose();
         }
      }
      
      private function __cancelHandler(param1:MouseEvent) : void
      {
         dispose();
      }
      
      override public function dispose() : void
      {
         removeEvent();
         model.openAward = true;
         MsgMan.notifyObserver("SecretaryAwardFrame","");
         super.dispose();
      }
   }
}

