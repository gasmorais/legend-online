package yishi.view.component
{
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.DisplayObject;
   import flash.geom.Point;
   import flash.geom.Rectangle;
   import flash.utils.Dictionary;
   
   public class TileContainer extends ChangeableSprite implements Disposeable
   {
      
      private var _paddingH:Number = 10;
      
      private var _paddingV:Number = 10;
      
      private var _columnCount:uint = 2147483647;
      
      private var _rowCount:uint = 2147483647;
      
      private var _autoVSize:Boolean = true;
      
      private var _scrollY:int = 0;
      
      private var _scrollX:int = 0;
      
      public var childBoundsSize:Boolean;
      
      private var layoutMap:Dictionary = new Dictionary(true);
      
      public function TileContainer(param1:Boolean = true)
      {
         super();
         this.childBoundsSize = param1;
         init();
      }
      
      override protected function initChangeables() : void
      {
         super.initChangeables();
         registChangeableThings("autoVSize");
      }
      
      private function init() : void
      {
         width = 400;
      }
      
      public function removeAllChildren() : void
      {
         var _loc2_:int = 0;
         var _loc1_:int = numChildren;
         _loc2_ = 0;
         while(_loc2_ < _loc1_)
         {
            removeChildAt(0);
            _loc2_++;
         }
      }
      
      override protected function onDraw() : void
      {
         var _loc5_:int = 0;
         var _loc7_:DisplayObject = null;
         var _loc3_:DisplayObject = null;
         var _loc2_:Object = null;
         var _loc6_:Point = new Point();
         var _loc4_:uint = 0;
         var _loc1_:uint = 0;
         _loc5_ = 0;
         while(_loc5_ < numChildren)
         {
            _loc3_ = getChildAt(_loc5_);
            _loc2_ = getItemLayout(_loc3_);
            _loc7_ = _loc3_;
            _loc7_.x = _loc6_.x;
            _loc7_.y = _loc6_.y;
            _loc6_.x += _loc2_.width + _loc2_.paddingH;
            _loc4_++;
            if(_loc5_ + 1 < numChildren)
            {
               if(getItemLayout(getChildAt(_loc5_ + 1)).width + _loc2_.paddingH + _loc6_.x > width || _loc4_ >= _columnCount)
               {
                  _loc6_.y += _loc2_.height + _loc2_.paddingV;
                  _loc6_.x = 0;
                  _loc4_ = 0;
                  _loc1_++;
               }
            }
            _loc5_++;
         }
      }
      
      public function get columnCount() : uint
      {
         return _columnCount;
      }
      
      public function set columnCount(param1:uint) : void
      {
         _columnCount = param1;
      }
      
      public function get rowCount() : uint
      {
         return _rowCount;
      }
      
      public function set rowCount(param1:uint) : void
      {
         _rowCount = param1;
      }
      
      override public function addChild(param1:DisplayObject) : DisplayObject
      {
         throw new Error("use appendItem method!");
      }
      
      override public function removeChild(param1:DisplayObject) : DisplayObject
      {
         delete layoutMap[param1];
         return super.removeChild(param1);
      }
      
      public function removeItem(param1:DisplayObject) : void
      {
         super.removeChild(param1);
         delete layoutMap[param1];
      }
      
      public function appendItem(param1:DisplayObject, param2:Object = null) : void
      {
         if(param2)
         {
            layoutMap[param1] = param2;
         }
         else
         {
            layoutMap[param1] = {};
         }
         super.addChild(param1);
      }
      
      private function getItemLayout(param1:DisplayObject) : Object
      {
         var _loc2_:Rectangle = null;
         var _loc4_:Object = {};
         var _loc3_:Object = layoutMap[param1];
         if(childBoundsSize)
         {
            _loc2_ = param1.getBounds(this);
            _loc4_.width = _loc3_.width || _loc2_.width;
            _loc4_.height = _loc3_.height || _loc2_.height;
         }
         else
         {
            _loc4_.width = _loc3_.width || param1.width;
            _loc4_.height = _loc3_.height || param1.height;
         }
         _loc4_.paddingV = _loc3_.paddingV || paddingV;
         _loc4_.paddingH = _loc3_.paddingH || paddingH;
         return _loc4_;
      }
      
      override public function get height() : Number
      {
         if(autoVSize)
         {
            return contentHeight;
         }
         return super.height;
      }
      
      public function get paddingH() : Number
      {
         return _paddingH;
      }
      
      public function set paddingH(param1:Number) : void
      {
         _paddingH = param1;
      }
      
      public function get paddingV() : Number
      {
         return _paddingV;
      }
      
      public function set paddingV(param1:Number) : void
      {
         _paddingV = param1;
      }
      
      public function get autoVSize() : Boolean
      {
         return _autoVSize;
      }
      
      public function set autoVSize(param1:Boolean) : void
      {
         if(_autoVSize == param1)
         {
            return;
         }
         _autoVSize = param1;
         commitChage("autoVSize");
      }
      
      public function dispose() : void
      {
         ObjectUtils.disposeAllChildren(this);
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}

