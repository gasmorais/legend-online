package stelesys
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
   import managers.SteleSysManager;
   import mvc.module.stele.StelesysInfo;
   import mvc.module.stele.StelesysModel;
   import yishi.datas.ComponentGroupType;
   import yishi.keyboard.KeyBoardRegister;
   import yishi.manager.NotificationManager;
   
   public class StelaUseFrame extends Frame
   {
      
      private var _confirmBtn:TextButton;
      
      private var _alertText:Bitmap;
      
      private var _numberText:FilterFrameText;
      
      private var _inputBack:Bitmap;
      
      private var _data:StelesysInfo;
      
      private var _needMax:int;
      
      public function StelaUseFrame()
      {
         super();
         initView();
         initEvent();
      }
      
      private function initView() : void
      {
         titleText = LanguageMgr.GetTranslation("bag.view.SpliteItemFrame.title");
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
         _numberText.addEventListener("keyDown",__keydownHandler);
         _numberText.addEventListener("change",__textChangHandler);
         _numberText.addEventListener("focusIn",__inHandler);
      }
      
      private function removeEvent() : void
      {
         removeEventListener("response",__frameResponse);
         _confirmBtn.removeEventListener("click",__confirmHandler);
         _numberText.removeEventListener("keyDown",__keydownHandler);
         _numberText.removeEventListener("change",__textChangHandler);
         _numberText.removeEventListener("focusIn",__inHandler);
      }
      
      private function __keydownHandler(param1:KeyboardEvent) : void
      {
         if(param1.keyCode == 13)
         {
            __confirmHandler(null);
         }
         param1.stopPropagation();
      }
      
      private function __textChangHandler(param1:Event = null) : void
      {
         var _loc5_:int = 0;
         var _loc2_:int = 0;
         if(_data == null)
         {
            return;
         }
         var _loc4_:int = int(_numberText.text);
         var _loc3_:int = int(_data.tempInfo.Exp);
         if(model.intensifyCheckChoose())
         {
            _loc2_ = _data.tempUse * _loc3_;
            _loc5_ = model.currIntensifyNeedExp - (model.currInstensifyPreExp - _loc2_);
            _needMax = Math.ceil(_loc5_ / _loc3_);
         }
         else if(_data.tempUse > 0)
         {
            _loc2_ = _data.tempUse * _loc3_;
            _loc5_ = model.currIntensifyNeedExp - (model.currInstensifyPreExp - _loc2_);
            _needMax = Math.ceil(_loc5_ / _loc3_);
         }
         else
         {
            _needMax = 0;
         }
         if(_needMax > _data.exp)
         {
            _needMax = _data.exp;
         }
         if(_loc4_ > _needMax)
         {
            _numberText.text = "" + _needMax;
         }
      }
      
      private function get model() : StelesysModel
      {
         return SteleSysManager.Ins.model;
      }
      
      private function __inHandler(param1:FocusEvent) : void
      {
         _numberText.setSelection(0,_numberText.text.length);
      }
      
      protected function __confirmHandler(param1:MouseEvent) : void
      {
         NotificationManager.instance.sendNotification("STELE_SYS_USE_FRAME",[_data,int(_numberText.text)]);
         dispose();
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
      
      public function show() : void
      {
         LayerManager.Instance.addToLayer(this,3,true,true,2);
         KeyBoardRegister.instance.keyEnable = false;
      }
      
      override public function get groups() : Array
      {
         return [ComponentGroupType.NONE];
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
      
      public function get data() : StelesysInfo
      {
         return _data;
      }
      
      public function set data(param1:StelesysInfo) : void
      {
         _data = param1;
         __textChangHandler();
      }
   }
}

