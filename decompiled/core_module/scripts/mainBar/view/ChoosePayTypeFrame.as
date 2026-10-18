package mainBar.view
{
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.ui.controls.IconButton;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import com.pickgliss.utils.SoundManager;
   import flash.events.MouseEvent;
   import flash.events.TextEvent;
   import manager.LanguageMgr;
   import yishi.datas.playerinfo.PlayerInfo;
   import yishi.keyboard.KeyBoardRegister;
   import yishi.manager.FrameControllerManager;
   import yishi.manager.PlayerManager;
   import yishi.manager.RechargeAlertMannager;
   
   public class ChoosePayTypeFrame extends Frame
   {
      
      public static const PAY_TYPE_POINT:int = 1;
      
      public static const PAY_TYPE_GIFT:int = 2;
      
      private var _confirmBtn:IconButton;
      
      private var _cancelBtn:IconButton;
      
      private var _tipTxt:FilterFrameText;
      
      private var _promptTxt:FilterFrameText;
      
      private var _type:int;
      
      private var _objectId:int;
      
      private var _point:int;
      
      private var _gift:int;
      
      private var _callBack:Function;
      
      public function ChoosePayTypeFrame()
      {
         super();
         initView();
         addEvent();
      }
      
      private function get playerInfo() : PlayerInfo
      {
         return PlayerManager.instance.currentPlayerModel.playerInfo;
      }
      
      private function initView() : void
      {
         _confirmBtn = ComponentFactory.Instance.creatComponentByStylename("queueBar.QuickCodeButton");
         _cancelBtn = ComponentFactory.Instance.creatComponentByStylename("queueBar.CloseButton");
         _tipTxt = ComponentFactory.Instance.creatComponentByStylename("queueBar.AlertTextStyle");
         _promptTxt = ComponentFactory.Instance.creatComponentByStylename("queueBar.AlertPromotTextStyle");
         addToContent(_confirmBtn);
         _confirmBtn.text = LanguageMgr.GetTranslation("public.confirm1");
         addToContent(_cancelBtn);
         _cancelBtn.text = LanguageMgr.GetTranslation("public.close1");
         addToContent(_promptTxt);
         _promptTxt.text = LanguageMgr.GetTranslation("public.queueBar.alertPromotText");
         addToContent(_tipTxt);
         _tipTxt.text = LanguageMgr.GetTranslation("mainBar.view.ChoosePayTypeFrame.tipTxtText");
      }
      
      private function uninit() : void
      {
         ObjectUtils.disposeAllChildren(this);
         if(parent)
         {
            parent.removeChild(this);
         }
         _callBack = null;
      }
      
      private function addEvent() : void
      {
         addEventListener("response",__frameResponse);
         _confirmBtn.addEventListener("click",__confirmHandler);
         _cancelBtn.addEventListener("click",__cancelHandler);
      }
      
      private function removeEvent() : void
      {
         removeEventListener("response",__frameResponse);
         _confirmBtn.removeEventListener("click",__confirmHandler);
         _cancelBtn.removeEventListener("click",__cancelHandler);
      }
      
      public function initData(param1:String, param2:String, param3:int, param4:int, param5:int, param6:Function, param7:String, param8:String) : void
      {
         _objectId = param3;
         _point = param4;
         _gift = param5;
         titleText = param1;
         _tipTxt.text = param2;
         _confirmBtn.text = param7;
         _cancelBtn.text = param8;
         _callBack = param6;
      }
      
      private function __link(param1:TextEvent) : void
      {
         FrameControllerManager.instance.openControllerByInfo("vip");
         dispose();
      }
      
      private function __cancelHandler(param1:MouseEvent) : void
      {
         SoundManager.instance.play("008");
         _callBack(false);
         dispose();
      }
      
      private function __confirmHandler(param1:MouseEvent) : void
      {
         var _loc3_:int = 0;
         SoundManager.instance.play("022");
         _type = 1;
         var _loc2_:int = playerInfo.point + playerInfo.giftToken;
         if(_loc2_ < _point)
         {
            dispose();
            RechargeAlertMannager.show();
            return;
         }
         _callBack(true,_objectId,_type);
         dispose();
      }
      
      private function __frameResponse(param1:FrameEvent) : void
      {
         switch(param1.responseCode - 2)
         {
            case 0:
            case 1:
               __confirmHandler(null);
               return;
            default:
               _callBack(false);
               dispose();
               return;
         }
      }
      
      public function show() : void
      {
         LayerManager.Instance.addToLayer(this,3,true,false,2);
         KeyBoardRegister.instance.keyEnable = false;
      }
      
      override public function dispose() : void
      {
         KeyBoardRegister.instance.keyEnable = true;
         removeEvent();
         uninit();
         super.dispose();
      }
   }
}

