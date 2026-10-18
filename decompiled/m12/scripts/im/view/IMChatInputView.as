package im.view
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.image.ScaleBitmapImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.ui.text.TextArea;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Sprite;
   
   public class IMChatInputView extends Sprite implements Disposeable
   {
      
      private var _bg:ScaleBitmapImage;
      
      private var _textArea:TextArea;
      
      public function IMChatInputView()
      {
         super();
         initView();
         addEvent();
      }
      
      private function initView() : void
      {
         _bg = ComponentFactory.Instance.creatComponentByStylename("core.IMChatInputBg");
         _textArea = ComponentFactory.Instance.creatComponentByStylename("core.IMChatInputArea");
         _textArea.textField.maxChars = 84;
         addChild(_bg);
         addChild(_textArea);
      }
      
      private function addEvent() : void
      {
      }
      
      private function removeEvent() : void
      {
      }
      
      public function clear() : void
      {
         _textArea.text = "";
      }
      
      public function setFocus() : void
      {
         _textArea.textField.setFocus();
      }
      
      public function get textField() : FilterFrameText
      {
         return _textArea.textField;
      }
      
      public function get text() : String
      {
         return _textArea.text;
      }
      
      public function dispose() : void
      {
         removeEvent();
         if(_bg)
         {
            _bg.dispose();
         }
         _bg = null;
         if(_textArea)
         {
            _textArea.dispose();
         }
         _textArea = null;
         ObjectUtils.disposeAllChildren(this);
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}

