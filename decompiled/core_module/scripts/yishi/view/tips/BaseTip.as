package yishi.view.tips
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.image.ScaleBitmapImage;
   import com.pickgliss.ui.tip.ITransformableTip;
   import flash.display.DisplayObject;
   import flash.display.Sprite;
   
   public class BaseTip extends Sprite implements ITransformableTip, Disposeable
   {
      
      protected var _bg:ScaleBitmapImage;
      
      protected var _data:Object;
      
      protected var _tipWidth:int;
      
      protected var _tipHeight:int;
      
      protected var _isFollowMouse:Boolean;
      
      protected var _isSingleToneTip:Boolean;
      
      public function BaseTip()
      {
         super();
         init();
         this.mouseEnabled = false;
         this.mouseChildren = false;
      }
      
      protected function init() : void
      {
         _bg = ComponentFactory.Instance.creatComponentByStylename("core.commonTipBg");
         addChild(_bg);
      }
      
      public function get tipData() : Object
      {
         return _data;
      }
      
      public function set tipData(param1:Object) : void
      {
         _data = param1;
         updateTransform();
      }
      
      protected function updateTransform() : void
      {
      }
      
      public function get tipWidth() : int
      {
         return _tipWidth;
      }
      
      public function set tipWidth(param1:int) : void
      {
         if(_tipWidth != param1)
         {
            _tipWidth = param1;
            updateTransform();
         }
      }
      
      public function get tipHeight() : int
      {
         return _bg.height;
      }
      
      public function set tipHeight(param1:int) : void
      {
      }
      
      public function asDisplayObject() : DisplayObject
      {
         return this;
      }
      
      public function set isFollowMouse(param1:Boolean) : void
      {
         _isFollowMouse = param1;
      }
      
      public function get isFollowMouse() : Boolean
      {
         return false;
      }
      
      public function get isSingleToneTip() : Boolean
      {
         return _isSingleToneTip;
      }
      
      public function set isSingleToneTip(param1:Boolean) : void
      {
         _isSingleToneTip = param1;
      }
      
      public function set direction(param1:int) : void
      {
      }
      
      public function dispose() : void
      {
         _data = null;
         if(_bg)
         {
            if(_bg.parent)
            {
               _bg.parent.removeChild(_bg);
            }
            _bg.dispose();
         }
         _bg = null;
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}

