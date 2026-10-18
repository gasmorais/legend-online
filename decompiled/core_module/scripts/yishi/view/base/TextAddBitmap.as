package yishi.view.base
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.DisplayObject;
   import flash.display.Sprite;
   
   public class TextAddBitmap extends Sprite
   {
      
      private var _text:FilterFrameText;
      
      private var _bit:DisplayObject;
      
      private var _adjuestX:int;
      
      private var _adjuestY:int;
      
      public function TextAddBitmap()
      {
         super();
      }
      
      public function initView(param1:String, param2:String, param3:String = "right") : void
      {
         _text = ComponentFactory.Instance.creatComponentByStylename(param1);
         _bit = ComponentFactory.Instance.creat(param2);
         addChild(_text);
         addChild(_bit);
         updatePostion(param3);
      }
      
      private function updatePostion(param1:String) : void
      {
         switch(param1)
         {
            case "left":
               _bit.x = _text.x + _text.width;
               break;
            case "right":
               _bit.x = _text.x - _bit.width;
         }
         var _loc2_:int = _text.height == 4 ? 20 : _text.height;
         _bit.y = _text.y + (_loc2_ - _bit.height) / 2;
      }
      
      public function set tipData(param1:Object) : void
      {
         var _loc2_:Component = _bit as Component;
         if(_loc2_)
         {
            _loc2_.tipData = param1;
         }
      }
      
      public function adjustPositionX(param1:int) : void
      {
         _adjuestX = param1;
         _bit.x = param1;
      }
      
      public function adjustPositionY(param1:int) : void
      {
         _adjuestY = param1;
         _bit.y = param1;
      }
      
      public function setFrame(param1:int) : void
      {
         if(param1 < 1)
         {
            return;
         }
         _text.setFrame(param1);
      }
      
      public function setText(param1:String, param2:Boolean = false) : void
      {
         if(param2)
         {
            _text.htmlText = param1;
         }
         else
         {
            _text.text = param1;
         }
      }
      
      public function overText(param1:String) : void
      {
         _text.text = param1;
         setFrame(2);
         if(_bit != null)
         {
            _bit.x = _adjuestX + _text.x + _text.width + 5;
            addChild(_bit);
         }
      }
      
      public function outText(param1:String) : void
      {
         _text.text = param1;
         setFrame(1);
         if(_bit && _bit.parent)
         {
            _bit.parent.removeChild(_bit);
         }
      }
      
      public function dispose() : void
      {
         ObjectUtils.disposeObject(_text);
         _text = null;
         ObjectUtils.disposeObject(_bit);
         _bit = null;
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}

