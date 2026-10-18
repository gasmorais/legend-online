package oldbacker.view
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Bitmap;
   import flash.events.Event;
   
   public class OldBackerInputView extends Component
   {
      
      private var _back:Bitmap;
      
      private var _inputTxt:FilterFrameText;
      
      private var _isTextInput:Boolean;
      
      private var _singKey:String;
      
      public function OldBackerInputView()
      {
         super();
         initView();
         addEvent();
      }
      
      private function initView() : void
      {
         _back = ComponentFactory.Instance.creatBitmap("asset.oldbacker.oldbackerInputBack");
         _inputTxt = ComponentFactory.Instance.creatComponentByStylename("oldbacker.viewMsgText03");
         addChild(_back);
         addChild(_inputTxt);
         _inputTxt.type = "input";
      }
      
      private function addEvent() : void
      {
         _inputTxt.addEventListener("change",__onChangeHander);
      }
      
      private function __onChangeHander(param1:Event) : void
      {
         if(!_isTextInput)
         {
            if(_singKey != null && _singKey != "")
            {
               _inputTxt.text = _singKey;
            }
         }
         _singKey = _inputTxt.text;
      }
      
      private function removeEvent() : void
      {
         if(_inputTxt)
         {
            _inputTxt.removeEventListener("change",__onChangeHander);
         }
      }
      
      public function set isTextInput(param1:Boolean) : void
      {
         _isTextInput = param1;
      }
      
      public function get singKey() : String
      {
         return _singKey;
      }
      
      public function set singKey(param1:String) : void
      {
         _singKey = param1;
         _inputTxt.text = _singKey;
      }
      
      override public function dispose() : void
      {
         removeEvent();
         ObjectUtils.disposeObject(_back);
         _back = null;
         ObjectUtils.disposeObject(_inputTxt);
         _inputTxt = null;
         super.dispose();
      }
   }
}

