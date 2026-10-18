package yishi.view.base
{
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.utils.ClassUtils;
   import flash.display.Bitmap;
   import flash.display.BitmapData;
   import flash.geom.Point;
   import flash.geom.Rectangle;
   import utils.LogicUtils;
   
   public class NumberClip extends Component
   {
      
      public static const LEFT:String = "left";
      
      public static const CENTER:String = "center";
      
      public static const RIGHT:String = "right";
      
      private var _numStr:String = "1234567890";
      
      private var _text:String = "";
      
      private var _space:int = -6;
      
      private var _setX:int;
      
      private var _linkUrl:String;
      
      private var _bmpDatas:Vector.<BitmapData>;
      
      private var _bmps:Vector.<Bitmap> = new Vector.<Bitmap>();
      
      private var _clipWidth:int;
      
      private var _layout:String = "left";
      
      private var _pool:Vector.<Bitmap> = new Vector.<Bitmap>();
      
      public function NumberClip()
      {
         super();
      }
      
      public function set xy(param1:String) : void
      {
         var _loc2_:Array = param1.split(",");
         this.x = _loc2_[0];
         this.y = _loc2_[1];
      }
      
      public function set layout(param1:String) : void
      {
         if(_layout != param1)
         {
            _layout = param1;
            doLayout();
         }
      }
      
      public function set text(param1:String) : void
      {
         if(_text != param1)
         {
            _text = param1;
            updateView();
         }
      }
      
      public function set bitmapLink(param1:String) : void
      {
         if(_linkUrl != param1)
         {
            _linkUrl = param1;
            disposeBmd();
            updateView();
         }
      }
      
      public function set numStr(param1:String) : void
      {
         if(!_numStr != param1)
         {
            _numStr = param1;
            updateView();
         }
      }
      
      public function set space(param1:int) : void
      {
         if(_space != param1)
         {
            _space = param1;
            updateView();
         }
      }
      
      override public function set x(param1:Number) : void
      {
         if(_setX != param1)
         {
            _setX = param1;
            doLayout();
         }
      }
      
      private function createDatas() : void
      {
         var _loc1_:BitmapData = null;
         if(!_bmpDatas)
         {
            _loc1_ = new (ClassUtils.getDefinition(_linkUrl))();
            _bmpDatas = createClips(_loc1_,_numStr.length,1);
         }
      }
      
      private function createClips(param1:BitmapData, param2:int, param3:int) : Vector.<BitmapData>
      {
         var _loc7_:int = 0;
         var _loc8_:int = 0;
         var _loc4_:BitmapData = null;
         if(param1 == null)
         {
            return null;
         }
         var _loc5_:Vector.<BitmapData> = new Vector.<BitmapData>(param2 * param3);
         var _loc6_:int = Math.max(param1.width / param2,1);
         var _loc10_:int = Math.max(param1.height / param3,1);
         var _loc9_:Point = new Point();
         _loc8_ = 0;
         while(_loc8_ < param2)
         {
            _loc7_ = int(_numStr.charAt(_loc8_));
            _loc4_ = new BitmapData(_loc6_,_loc10_);
            _loc4_.copyPixels(param1,new Rectangle(_loc8_ * _loc6_,0,_loc6_,_loc10_),_loc9_);
            _loc5_[_loc7_] = _loc4_;
            _loc8_++;
         }
         param1.dispose();
         return _loc5_;
      }
      
      private function updateView() : void
      {
         if(_linkUrl && _text)
         {
            LogicUtils.addToRender(this,render);
         }
      }
      
      private function render() : void
      {
         var _loc3_:Bitmap = null;
         var _loc1_:BitmapData = null;
         var _loc5_:int = 0;
         if(!_bmpDatas)
         {
            createDatas();
         }
         var _loc2_:int = _text.length;
         while(_bmps.length > _loc2_)
         {
            storeBitmap(_bmps.pop());
         }
         var _loc6_:int = int(_bmps.length);
         var _loc4_:int = 0;
         _loc5_ = 0;
         while(_loc5_ < _loc2_)
         {
            _loc1_ = _bmpDatas[int(_text.charAt(_loc5_))];
            if(_loc5_ < _loc6_)
            {
               _loc3_ = _bmps[_loc5_];
            }
            else
            {
               _loc3_ = getBitmap();
               _bmps.push(_loc3_);
               addChild(_loc3_);
            }
            _loc3_.bitmapData = _loc1_;
            _loc3_.x = _loc4_;
            _loc4_ += _loc3_.width + _space;
            _loc5_++;
         }
         _clipWidth = _loc4_ - _space;
         doLayout();
      }
      
      private function doLayout() : void
      {
         var _loc1_:int = int(_bmps.length);
         if(_layout == "left")
         {
            super.x = _setX;
         }
         else if(_layout == "center")
         {
            super.x = _setX - _clipWidth * 0.5;
         }
         else if(_layout == "right")
         {
            super.x = _setX - _clipWidth;
         }
      }
      
      override public function dispose() : void
      {
         LogicUtils.disposeDisplayCollection(_pool);
         _pool = null;
         LogicUtils.disposeDisplayCollection(_bmps);
         _bmps = null;
         disposeBmd();
         super.dispose();
      }
      
      private function disposeBmd() : void
      {
         LogicUtils.disposeDisplayCollection(_bmpDatas);
         _bmpDatas = null;
      }
      
      private function getBitmap() : Bitmap
      {
         return _pool.length > 0 ? _pool.pop() : new Bitmap();
      }
      
      private function storeBitmap(param1:Bitmap) : void
      {
         if(param1.parent)
         {
            param1.parent.removeChild(param1);
         }
         param1.bitmapData = null;
         _pool.push(param1);
      }
   }
}

