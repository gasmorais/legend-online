package avenger
{
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.ui.controls.IconButton;
   import com.pickgliss.ui.image.MutipleImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import manager.LanguageMgr;
   import mvc.ModuleFrameInfo;
   import yishi.datas.ComponentGroupType;
   
   public class AvengerChildNsSkillInputFrame extends Frame
   {
      
      private var _back:MutipleImage;
      
      private var _hasText:FilterFrameText;
      
      private var _inputText:FilterFrameText;
      
      private var _sureBtn:IconButton;
      
      private var _hasCount:int;
      
      public var callBack:Function;
      
      public function AvengerChildNsSkillInputFrame()
      {
         super();
         initView();
         addEvent();
      }
      
      override public function get groups() : Array
      {
         return [ComponentGroupType.NONE];
      }
      
      private function initView() : void
      {
         _back = ComponentFactory.Instance.creatComponentByStylename("AvengerChildNsSkillInputFrame.back");
         _hasText = ComponentFactory.Instance.creatComponentByStylename("AvengerChildNsSkillInputFrame.hasText");
         _inputText = ComponentFactory.Instance.creatComponentByStylename("AvengerChildNsSkillInputFrame.inputText");
         _sureBtn = ComponentFactory.Instance.creatComponentByStylename("AvengerChildNsSkillInputFrame.sureBtn");
         addToContent(_back);
         addToContent(_hasText);
         addToContent(_inputText);
         addToContent(_sureBtn);
      }
      
      private function addEvent() : void
      {
         addEventListener("response",__frameResponse);
         _sureBtn.addEventListener("click",__sureClickHandler);
         _inputText.addEventListener("change",__textChangHandler);
      }
      
      private function removeEvent() : void
      {
         removeEventListener("response",__frameResponse);
         _inputText.addEventListener("change",__textChangHandler);
         if(_sureBtn)
         {
            _sureBtn.removeEventListener("click",__sureClickHandler);
         }
      }
      
      private function __textChangHandler(param1:Event) : void
      {
         var _loc2_:int = parseInt(_inputText.text);
         if(_loc2_ <= 0)
         {
            _inputText.text = "1";
         }
         if(_loc2_ >= hasCount)
         {
            _inputText.text = hasCount + "";
         }
      }
      
      public function get hasCount() : int
      {
         return _hasCount;
      }
      
      public function set hasCount(param1:int) : void
      {
         _hasCount = param1;
         _hasText.text = _hasCount + "";
         _inputText.text = _hasCount + "";
      }
      
      private function __sureClickHandler(param1:MouseEvent) : void
      {
         if(callBack != null)
         {
            callBack(int(_inputText.text));
         }
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
      
      public function show(param1:ModuleFrameInfo = null) : void
      {
         LayerManager.Instance.addToLayer(this,3,true,true,1);
         this.titleText = LanguageMgr.GetTranslation("bag.view.MulItemUseFrame.command01");
      }
      
      override public function dispose() : void
      {
         removeEvent();
         ObjectUtils.disposeObject(_back);
         _back = null;
         ObjectUtils.disposeObject(_hasText);
         _hasText = null;
         ObjectUtils.disposeObject(_inputText);
         _inputText = null;
         ObjectUtils.disposeObject(_sureBtn);
         _sureBtn = null;
         super.dispose();
      }
   }
}

