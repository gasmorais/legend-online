package yishi.view.frame
{
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.ui.controls.IconButton;
   import com.pickgliss.ui.controls.SelectedButton;
   import com.pickgliss.ui.controls.SelectedButtonGroup;
   import com.pickgliss.ui.image.ScaleBitmapImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.road.yishi.proto.player.OfflineRewardMsg;
   import flash.display.Bitmap;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import manager.LanguageMgr;
   import yishi.comm.PackageOut;
   import yishi.manager.PlayerManager;
   import yishi.service.managers.SocketSendManager;
   import yishi.view.tips.MessageTipManager;
   
   public class HookRewardFrame extends Frame
   {
      
      private var _back1:ScaleBitmapImage;
      
      private var _back:Bitmap;
      
      private var _totalExp:FilterFrameText;
      
      private var _offLineHour:FilterFrameText;
      
      private var _offLineMin:FilterFrameText;
      
      private var _totalHour:FilterFrameText;
      
      private var _receiveBtn1:SelectedButton;
      
      private var _receiveBtn2:SelectedButton;
      
      private var _receiveBtn3:SelectedButton;
      
      private var _receiveBtn:IconButton;
      
      private var _checkGroup:SelectedButtonGroup;
      
      public function HookRewardFrame()
      {
         super();
         initView();
         initEvent();
         _checkGroup.selectIndex = 0;
      }
      
      private function initView() : void
      {
         _checkGroup = new SelectedButtonGroup();
         _back1 = ComponentFactory.Instance.creatComponentByStylename("core.HookRewardBack1");
         _back = ComponentFactory.Instance.creatBitmap("asset.core.HoodRewardBack");
         _totalExp = ComponentFactory.Instance.creatComponentByStylename("core.HookTotalExpTxt");
         _offLineHour = ComponentFactory.Instance.creatComponentByStylename("core.HookOffLineHourTxt");
         _offLineMin = ComponentFactory.Instance.creatComponentByStylename("core.HookOffLineMinTxt");
         _totalHour = ComponentFactory.Instance.creatComponentByStylename("core.HookTotalHourTxt");
         _receiveBtn1 = ComponentFactory.Instance.creatComponentByStylename("core.HookreceiveBtn1");
         _receiveBtn2 = ComponentFactory.Instance.creatComponentByStylename("core.HookreceiveBtn2");
         _receiveBtn3 = ComponentFactory.Instance.creatComponentByStylename("core.HookreceiveBtn3");
         _receiveBtn = ComponentFactory.Instance.creatComponentByStylename("core.HookreceiveBtn");
         addToContent(_back);
         addToContent(_totalExp);
         addToContent(_offLineHour);
         addToContent(_offLineMin);
         addToContent(_totalHour);
         addToContent(_receiveBtn1);
         addToContent(_receiveBtn2);
         addToContent(_receiveBtn3);
         addToContent(_receiveBtn);
         _checkGroup.addSelectItem(_receiveBtn1);
         _checkGroup.addSelectItem(_receiveBtn2);
         _checkGroup.addSelectItem(_receiveBtn3);
      }
      
      private function initEvent() : void
      {
         addEventListener("response",__frameResponseHandler);
         _receiveBtn.addEventListener("click",__clickHandler);
         _checkGroup.addEventListener("change",__selectedChangeHandler);
      }
      
      private function removeEvent() : void
      {
         removeEventListener("response",__frameResponseHandler);
         _receiveBtn.removeEventListener("click",__clickHandler);
         _checkGroup.removeEventListener("change",__selectedChangeHandler);
      }
      
      private function __selectedChangeHandler(param1:Event) : void
      {
         refreshView();
      }
      
      private function __clickHandler(param1:MouseEvent) : void
      {
         var _loc2_:String = null;
         var _loc4_:Number = PlayerManager.instance.currentPlayerModel.hookGp;
         if(_loc4_ <= 0)
         {
            _loc2_ = LanguageMgr.GetTranslation("yishi.view.HookRewardFrame.command01");
            MessageTipManager.instance().show(_loc2_);
            return;
         }
         var _loc5_:PackageOut = new PackageOut(8287);
         var _loc3_:OfflineRewardMsg = new OfflineRewardMsg();
         _loc3_.rateCount = getCount();
         SocketSendManager.instance.sendProtoBuffer(_loc5_,_loc3_);
         dispose();
      }
      
      private function getCount() : int
      {
         switch(_checkGroup.selectIndex)
         {
            case 0:
               return 0;
            case 1:
               return 15;
            case 2:
               return 20;
            default:
               return 0;
         }
      }
      
      private function refreshView() : void
      {
         var _loc1_:Number = _checkGroup.selectIndex == 0 ? 1 : getCount() / 10;
         _totalExp.text = (PlayerManager.instance.currentPlayerModel.hookGp * _loc1_).toString();
         _offLineHour.text = (int(PlayerManager.instance.currentPlayerModel.hookTime / 3600)).toString();
         _offLineMin.text = (int(PlayerManager.instance.currentPlayerModel.hookTime % 3600 / 60)).toString();
         _totalHour.text = "8";
      }
      
      private function __frameResponseHandler(param1:FrameEvent) : void
      {
         if(param1.responseCode == 1 || param1.responseCode == 0)
         {
            dispose();
         }
      }
      
      public function show() : void
      {
         LayerManager.Instance.addToLayer(this,3,true,true,2);
      }
      
      override public function dispose() : void
      {
         removeEvent();
         super.dispose();
      }
   }
}

