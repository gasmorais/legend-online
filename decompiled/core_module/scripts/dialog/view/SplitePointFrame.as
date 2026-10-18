package dialog.view
{
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.ui.controls.TextButton;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Bitmap;
   import flash.events.Event;
   import flash.events.FocusEvent;
   import flash.events.KeyboardEvent;
   import flash.events.MouseEvent;
   import manager.LanguageMgr;
   import yishi.datas.playerinfo.PlayerInfo;
   import yishi.datas.playerinfo.ThaneInfo;
   import yishi.keyboard.KeyBoardRegister;
   import yishi.manager.ArmyManager;
   import yishi.manager.PlayerManager;
   import yishi.manager.RechargeAlertMannager;
   
   public class SplitePointFrame extends Frame
   {
      
      private var _confirmBtn:TextButton;
      
      private var _alertText:Bitmap;
      
      protected var _numberText:FilterFrameText;
      
      private var _inputBack:Bitmap;
      
      public var handPointFunction:Function;
      
      public function SplitePointFrame()
      {
         super();
         initView();
         initEvent();
      }
      
      private function initView() : void
      {
         titleText = LanguageMgr.GetTranslation("dialog.view.SplitePointFrame.title");
         _inputBack = ComponentFactory.Instance.creatBitmap("asset.core.SpliteInputBack");
         addToContent(_inputBack);
         _confirmBtn = ComponentFactory.Instance.creatComponentByStylename("core.ConfirmBtn");
         _confirmBtn.text = LanguageMgr.GetTranslation("public.confirm");
         addToContent(_confirmBtn);
         _alertText = ComponentFactory.Instance.creatBitmap("asset.core.InputAlertTextStyle");
         addToContent(_alertText);
         _numberText = ComponentFactory.Instance.creatComponentByStylename("splitePointFrame.InputTextStyle");
         _numberText.selectable = true;
         _numberText.text = "1";
         addToContent(_numberText);
      }
      
      private function initEvent() : void
      {
         addEventListener("response",__frameResponse);
         _confirmBtn.addEventListener("click",__confirmHandler);
         _numberText.addEventListener("keyDown",__keydownHandler);
         _numberText.addEventListener("focusIn",__inHandler);
         _numberText.addEventListener("change",__textChangHandler);
      }
      
      private function removeEvent() : void
      {
         removeEventListener("response",__frameResponse);
         _confirmBtn.removeEventListener("click",__confirmHandler);
         _numberText.removeEventListener("keyDown",__keydownHandler);
         _numberText.removeEventListener("focusIn",__inHandler);
         _numberText.removeEventListener("change",__textChangHandler);
      }
      
      private function __inHandler(param1:FocusEvent) : void
      {
         _numberText.setSelection(0,_numberText.text.length);
      }
      
      private function __textChangHandler(param1:Event) : void
      {
         var _loc2_:int = int(_numberText.text);
         if(_loc2_ > 500)
         {
            _numberText.text = "500";
         }
      }
      
      private function __keydownHandler(param1:KeyboardEvent) : void
      {
         if(param1.keyCode == 13)
         {
            __confirmHandler(null);
         }
         param1.stopPropagation();
      }
      
      protected function __confirmHandler(param1:MouseEvent) : void
      {
         starDrag();
         dispose();
      }
      
      private function starDrag() : void
      {
         var _loc1_:int = int(_numberText.text);
         if(_loc1_ > playerInfo.point)
         {
            RechargeAlertMannager.show();
            return;
         }
         if(_loc1_ > 0)
         {
            handPointFunction(_loc1_);
         }
      }
      
      public function show() : void
      {
         LayerManager.Instance.addToLayer(this,3,true,true,2);
         KeyBoardRegister.instance.keyEnable = false;
         _numberText.setFocus();
      }
      
      private function __frameResponse(param1:FrameEvent) : void
      {
         switch(param1.responseCode)
         {
            case 0:
            case 1:
               dispose();
               break;
            case 2:
               __confirmHandler(null);
         }
      }
      
      private function get thane() : ThaneInfo
      {
         return ArmyManager.instance.thane;
      }
      
      private function get playerInfo() : PlayerInfo
      {
         return PlayerManager.instance.currentPlayerModel.playerInfo;
      }
      
      override public function dispose() : void
      {
         KeyBoardRegister.instance.keyEnable = true;
         removeEvent();
         ObjectUtils.disposeObject(_confirmBtn);
         _confirmBtn = null;
         ObjectUtils.disposeObject(_alertText);
         _alertText = null;
         ObjectUtils.disposeObject(_numberText);
         _numberText = null;
         ObjectUtils.disposeObject(_inputBack);
         _inputBack = null;
         super.dispose();
      }
   }
}

