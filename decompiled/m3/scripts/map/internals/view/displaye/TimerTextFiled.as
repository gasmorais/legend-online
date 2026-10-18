package map.internals.view.displaye
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.text.FilterFrameText;
   import flash.display.Sprite;
   import yishi.interfaces.IEnterFrame;
   
   public class TimerTextFiled extends Sprite implements IEnterFrame, Disposeable
   {
      
      private var _textFiled:FilterFrameText;
      
      private var _textFiledStyle:String;
      
      public function TimerTextFiled()
      {
         super();
      }
      
      public function get textFiledStyle() : String
      {
         return _textFiledStyle;
      }
      
      public function set textFiledStyle(param1:String) : void
      {
         _textFiledStyle = param1;
         _textFiled = ComponentFactory.Instance.creatComponentByStylename(_textFiledStyle);
         addChild(_textFiled);
      }
      
      public function enterFrame() : void
      {
      }
      
      public function dispose() : void
      {
      }
   }
}

