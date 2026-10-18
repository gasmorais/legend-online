package armyII.viewII.allocate
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
   import mvc.controler.ArmyControler;
   import mvc.module.armyII.ArmyModel;
   import yishi.keyboard.KeyBoardRegister;
   import yishi.service.services.AmfResponder;
   import yishi.view.tips.MessageTipManager;
   
   public class DissmissPawnFrame extends Frame
   {
      
      private var _item:*;
      
      private var _confirmBtn:TextButton;
      
      private var _alertText:Bitmap;
      
      private var _numberText:FilterFrameText;
      
      private var _inputBack:Bitmap;
      
      private var _control:ArmyControler;
      
      private var _model:ArmyModel;
      
      public function DissmissPawnFrame()
      {
         super();
         initView();
         initEvent();
      }
      
      private function initView() : void
      {
         titleText = LanguageMgr.GetTranslation("armyII.viewII.allocate.DissmissPawnFrame.command01");
         _inputBack = ComponentFactory.Instance.creatBitmap("asset.core.SpliteInputBack");
         addToContent(_inputBack);
         _confirmBtn = ComponentFactory.Instance.creatComponentByStylename("core.ConfirmBtn");
         _confirmBtn.text = LanguageMgr.GetTranslation("public.confirm");
         addToContent(_confirmBtn);
         _alertText = ComponentFactory.Instance.creatBitmap("asset.core.InputAlertTextStyle");
         addToContent(_alertText);
         _numberText = ComponentFactory.Instance.creatComponentByStylename("core.InputTextStyle");
         _numberText.selectable = true;
         _numberText.text = "1";
         addToContent(_numberText);
      }
      
      private function initEvent() : void
      {
         addEventListener("response",__frameResponse);
         _confirmBtn.addEventListener("click",__confirmHandler);
         _numberText.addEventListener("change",__textChangHandler);
         _numberText.addEventListener("focusIn",__inHandler);
         _numberText.addEventListener("keyDown",__keyDownHandler);
      }
      
      private function removeEvent() : void
      {
         removeEventListener("response",__frameResponse);
         _confirmBtn.removeEventListener("click",__confirmHandler);
         _numberText.removeEventListener("change",__textChangHandler);
         _numberText.removeEventListener("focusIn",__inHandler);
         _numberText.removeEventListener("keyDown",__keyDownHandler);
      }
      
      private function __inHandler(param1:FocusEvent) : void
      {
         _numberText.setSelection(0,_numberText.text.length);
      }
      
      private function __textChangHandler(param1:Event) : void
      {
         var _loc2_:int = int(_numberText.text);
         if(_loc2_ > _item.pawn.ownPawns)
         {
            _loc2_ = int(_item.pawn.ownPawns);
            _numberText.text = _loc2_.toString();
         }
         else if(_loc2_ == 0)
         {
            _numberText.text = "";
         }
         else
         {
            _numberText.text = _loc2_.toString();
         }
      }
      
      private function __confirmHandler(param1:MouseEvent) : void
      {
         var _loc2_:String = null;
         if(int(_numberText.text) > 0 && _item && _item.pawn)
         {
            _control.sendDismissPawn(_item.pawn.templateId,int(_numberText.text));
            dispose();
            _control = null;
            _model = null;
         }
         else if(_numberText.text == "")
         {
            _loc2_ = LanguageMgr.GetTranslation("armyII.viewII.allocate.DissmissPawnFrame.command02");
            MessageTipManager.instance().show(_loc2_);
         }
      }
      
      private function dissmissHandler(param1:AmfResponder) : void
      {
         if(param1.result > 0)
         {
            _item.pawn.ownPawns -= int(param1.result);
            _item.refreshView();
         }
         dispose();
         _control = null;
         _model = null;
      }
      
      public function set data(param1:*) : void
      {
         _item = param1;
         _numberText.text = param1.pawn.ownPawns.toString();
         _numberText.setFocus();
      }
      
      public function initControl(param1:ArmyControler, param2:ArmyModel) : void
      {
         _control = param1;
         _model = param2;
      }
      
      public function show() : void
      {
         LayerManager.Instance.addToLayer(this,3,true,true,2);
         KeyBoardRegister.instance.keyEnable = false;
         _numberText.setFocus();
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
      
      private function __keyDownHandler(param1:KeyboardEvent) : void
      {
         switch(int(param1.keyCode) - 13)
         {
            case 0:
               __confirmHandler(null);
               break;
            case 14:
               dispose();
         }
         param1.stopPropagation();
      }
      
      override public function dispose() : void
      {
         KeyBoardRegister.instance.keyEnable = true;
         removeEvent();
         ObjectUtils.disposeAllChildren(this);
         if(this.parent)
         {
            this.parent.removeChild(this);
         }
         _control.closeDissmissFrame();
         _control = null;
         _model = null;
         super.dispose();
      }
   }
}

