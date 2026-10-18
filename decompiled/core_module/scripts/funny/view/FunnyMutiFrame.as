package funny.view
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
   import funny.FunnyHelper;
   import funny.datas.FunnyBagData;
   import manager.LanguageMgr;
   import managers.FunnyManager;
   import yishi.keyboard.KeyBoardRegister;
   import yishi.manager.GoodsManager;
   
   public class FunnyMutiFrame extends Frame
   {
      
      private var _confirmBtn:TextButton;
      
      private var _alertText:Bitmap;
      
      private var _numberText:FilterFrameText;
      
      private var _inputBack:Bitmap;
      
      private var _maxNum:int;
      
      private var _data:FunnyBagData;
      
      public function FunnyMutiFrame()
      {
         super();
         initView();
         initEvent();
      }
      
      private function initView() : void
      {
         titleText = LanguageMgr.GetTranslation("funny.view.FunnyMutiFrame.titleText");
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
         if(_numberText)
         {
            _numberText.addEventListener("keyDown",__keydownHandler);
            _numberText.addEventListener("change",__textChangHandler);
            _numberText.addEventListener("focusIn",__inHandler);
         }
         FunnyManager.instance.addEventListener("REFRESH_TEMP",__receiveTempHandler);
      }
      
      private function removeEvent() : void
      {
         removeEventListener("response",__frameResponse);
         if(_confirmBtn)
         {
            _confirmBtn.removeEventListener("click",__confirmHandler);
         }
         if(_numberText)
         {
            _numberText.removeEventListener("keyDown",__keydownHandler);
            _numberText.removeEventListener("change",__textChangHandler);
            _numberText.removeEventListener("focusIn",__inHandler);
         }
         FunnyManager.instance.removeEventListener("REFRESH_TEMP",__receiveTempHandler);
      }
      
      private function __receiveTempHandler(param1:Event) : void
      {
         dispose();
      }
      
      private function __inHandler(param1:FocusEvent) : void
      {
         _numberText.setSelection(0,_numberText.text.length);
      }
      
      private function __textChangHandler(param1:Event) : void
      {
         var _loc2_:int = int(_numberText.text);
         if(_loc2_ > _maxNum)
         {
            _loc2_ = _maxNum;
            _numberText.text = _loc2_.toString();
         }
         else if(_loc2_ == 0)
         {
            _numberText.text = "1";
         }
         else
         {
            _numberText.text = _loc2_.toString();
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
      
      private function __confirmHandler(param1:MouseEvent) : void
      {
         var _loc2_:int = 0;
         if(_data)
         {
            _loc2_ = int(_numberText.text);
            FunnyManager.instance.sendGetBag(2,_data.activeId,_data.id,_loc2_);
         }
         dispose();
      }
      
      public function set data(param1:FunnyBagData) : void
      {
         if(param1 == null || FunnyManager.instance.selectedFunnyData == null || !FunnyManager.instance.selectedFunnyData.bagList || FunnyManager.instance.selectedFunnyData.bagList.indexOf(param1) < 0)
         {
            dispose();
            return;
         }
         _data = param1;
         _maxNum = FunnyHelper.mutiMaxNum(_data);
      }
      
      private function getBagCount(param1:int) : int
      {
         return GoodsManager.instance.getBagCountByTempId(1,param1);
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
         _data = null;
         super.dispose();
      }
   }
}

