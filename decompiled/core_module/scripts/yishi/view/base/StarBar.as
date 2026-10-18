package yishi.view.base
{
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.utils.ClassUtils;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Bitmap;
   import flash.display.BitmapData;
   import flash.display.Shape;
   
   public class StarBar extends Component
   {
      
      private var _count:int;
      
      private var _emptyClassName:String;
      
      private var _fullClassName:String;
      
      private var _fullStarBox:Component;
      
      private var _emptyBpd:BitmapData;
      
      private var _fullBpd:BitmapData;
      
      private var _boxMask:Shape;
      
      private var _progress:Number = 0;
      
      public function StarBar(param1:int = 5, param2:Number = 0, param3:String = "asset.wildsoul.EmptyStar", param4:String = "asset.wildsoul.FullStar")
      {
         _count = param1;
         _emptyClassName = param3;
         _fullClassName = param4;
         super();
         progress = param2;
      }
      
      override protected function init() : void
      {
         var _loc2_:int = 0;
         var _loc1_:Bitmap = null;
         _emptyBpd = ClassUtils.CreatInstance(_emptyClassName);
         _fullBpd = ClassUtils.CreatInstance(_fullClassName);
         _width = _emptyBpd.width * _count;
         _height = _emptyBpd.height;
         this.graphics.beginBitmapFill(_emptyBpd);
         this.graphics.drawRect(0,0,_width,_height);
         this.graphics.endFill();
         _fullStarBox = new Component();
         _loc2_ = 0;
         while(_loc2_ < _count)
         {
            _loc1_ = new Bitmap(_fullBpd);
            _loc1_.x = _loc2_ * _loc1_.width;
            _fullStarBox.addChild(_loc1_);
            _loc2_++;
         }
         addChild(_fullStarBox);
         _boxMask = new Shape();
         _fullStarBox.mask = _boxMask;
         addChild(_boxMask);
      }
      
      protected function uintView() : void
      {
         ObjectUtils.disposeObject(_emptyBpd);
         _emptyBpd = null;
         ObjectUtils.disposeObject(_fullBpd);
         _fullBpd = null;
         ObjectUtils.disposeObject(_fullStarBox);
         _fullStarBox = null;
         ObjectUtils.disposeObject(_boxMask);
         _boxMask = null;
      }
      
      public function set progress(param1:Number) : void
      {
         var _loc2_:Number = NaN;
         _progress = param1;
         if(!_boxMask)
         {
            return;
         }
         if(_count > 0)
         {
            _loc2_ = param1 * _width / _count;
         }
         else
         {
            _loc2_ = 0;
         }
         _boxMask.graphics.clear();
         _boxMask.graphics.beginFill(0,0);
         _boxMask.graphics.drawRect(0,0,_loc2_,_height);
         _boxMask.graphics.endFill();
      }
      
      public function get count() : int
      {
         return _count;
      }
      
      public function set count(param1:int) : void
      {
         _count = param1;
         if(!_emptyBpd)
         {
            return;
         }
         _width = _emptyBpd.width * _count;
         this.graphics.clear();
         this.graphics.beginBitmapFill(_emptyBpd);
         this.graphics.drawRect(0,0,_width,_height);
         this.graphics.endFill();
         progress = _progress;
      }
      
      override public function dispose() : void
      {
         uintView();
         super.dispose();
      }
   }
}

