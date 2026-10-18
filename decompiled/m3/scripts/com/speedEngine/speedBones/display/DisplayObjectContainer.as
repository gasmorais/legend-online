package com.speedEngine.speedBones.display
{
   import com.speedEngine.speedBones.events.Event;
   import com.speedEngine.speedBones.events.TouchEvent;
   import com.speedEngine.speedBones.filters.BlurFilter;
   import com.speedEngine.speedBones.filters.ColorFilter;
   import com.speedEngine.speedBones.filters.Filter;
   import com.speedEngine.speedBones.manager.RenderManager;
   import com.speedEngine.speedBones.model.ContainerData;
   import com.speedEngine.speedBones.model.RenderContainerData;
   import com.speedEngine.speedBones.utils.speedBones_internal;
   import flash.geom.Point;
   import flash.geom.Rectangle;
   
   use namespace speedBones_internal;
   
   public class DisplayObjectContainer extends DisplayObject
   {
      
      private var _children:Vector.<DisplayObject> = new Vector.<DisplayObject>();
      
      private var _touchableChildren:Boolean = true;
      
      private var _childBounds:Rectangle;
      
      private var _containerData:ContainerData;
      
      public function DisplayObjectContainer()
      {
         super();
         _containerData = RenderManager.instance.createContainerData();
      }
      
      override protected function initialize() : void
      {
         _childBounds = new Rectangle();
         super.initialize();
      }
      
      override protected function update() : void
      {
         if(_hasChangeFilter)
         {
            if(_filter)
            {
               updateFilter();
            }
            else
            {
               _blurFilterBytes.clear();
               _blurFilterBytes.length = 0;
            }
         }
      }
      
      override public function render(param1:Number) : void
      {
         super.render(param1);
         if(_blurFilterBytes.length > 0)
         {
            _containerData.writeController(_attributeBytes,_colorFilterBytes,_blurFilterBytes,_renderMode,_renderContainerData);
         }
      }
      
      public function renderAfter() : void
      {
         var _loc1_:Rectangle = null;
         if(_blurFilterBytes.length > 0)
         {
            _loc1_ = getBounds().clone();
            _loc1_.x = _loc1_.x + this.gx + this.x;
            _loc1_.y = _loc1_.y + this.gy + this.y;
            _containerData.writeContainerController(_loc1_);
         }
      }
      
      override public function getBounds() : Rectangle
      {
         getChildBounds();
         return super.getBounds();
      }
      
      public function addChildAt(param1:DisplayObject, param2:int) : void
      {
         addChild(param1,param2);
      }
      
      public function addChild(param1:DisplayObject, param2:int = 2147483647) : void
      {
         if(param1 == null)
         {
            return;
         }
         if(param1.public::parent == this)
         {
            if(param2 >= _children.length)
            {
               param2 = _children.length - 1;
            }
            setChildIndex(param1,param2);
            return;
         }
         if(param2 > _children.length)
         {
            param2 = int(_children.length);
         }
         if(param1.public::parent)
         {
            param1.public::parent.removeChild(param1);
         }
         addAt(param1,param2);
         param1.speedBones_internal::parent = this;
         param1.speedBones_internal::stage = stage;
      }
      
      override public function hitTest(param1:Point) : DisplayObject
      {
         var _loc2_:DisplayObject = null;
         var _loc6_:DisplayObject = null;
         var _loc5_:int = 0;
         var _loc3_:int = numChildren;
         var _loc4_:Point = new Point();
         _loc5_ = _loc3_ - 1;
         while(_loc5_ >= 0)
         {
            _loc6_ = children[_loc5_];
            _loc4_.x = param1.x - _loc6_.x;
            _loc4_.y = param1.y - _loc6_.y;
            _loc2_ = _loc6_.hitTest(_loc4_);
            if(_loc2_)
            {
               return _loc2_;
            }
            _loc5_--;
         }
         return super.hitTest(param1);
      }
      
      override public function addColorFilter(param1:ColorFilter) : void
      {
         super.addColorFilter(param1);
         for each(var _loc2_:DisplayObject in _children)
         {
            _loc2_.addColorFilter(param1);
         }
      }
      
      override public function clearColorFilter(param1:ColorFilter = null) : void
      {
         super.clearColorFilter(param1);
         for each(var _loc2_:DisplayObject in _children)
         {
            _loc2_.clearColorFilter(param1);
         }
      }
      
      public function sortChildren(param1:Function = null) : void
      {
         if(param1 == null)
         {
            param1 = defineCompareFun;
         }
         _children = _children.sort(param1);
      }
      
      private function defineCompareFun(param1:DisplayObject, param2:DisplayObject) : Number
      {
         if(int(param1.y) < int(param2.y))
         {
            return 1;
         }
         if(int(param1.y) > int(param2.y))
         {
            return -1;
         }
         return 0;
      }
      
      public function removeChild(param1:DisplayObject) : void
      {
         var _loc2_:int = getChildIndex(param1);
         removeChildAt(_loc2_);
      }
      
      private function removeAt(param1:int) : void
      {
         _children.splice(param1,1);
      }
      
      public function contains(param1:DisplayObject) : Boolean
      {
         return getChildIndex(param1) != -1;
      }
      
      public function setChildIndex(param1:DisplayObject, param2:int) : void
      {
         var _loc3_:int = getChildIndex(param1);
         if(_loc3_ > -1 && _loc3_ != param2)
         {
            _children.splice(_loc3_,1);
            _children.splice(param2,0,param1);
         }
      }
      
      private function addAt(param1:DisplayObject, param2:int) : void
      {
         var _loc3_:int = 0;
         if(this.touchTarget == false)
         {
            param1.touchTarget = this.touchTarget;
         }
         if(param1.colorFilters && colorFilters)
         {
            _loc3_ = colorFilters.length - 1;
            while(_loc3_ > 0)
            {
               param1.addColorFilter(colorFilters[_loc3_]);
               if(param1.colorFilters.length >= 3)
               {
                  break;
               }
               _loc3_--;
            }
         }
         _children.splice(param2,0,param1);
      }
      
      public function removeChildAt(param1:int) : void
      {
         if(param1 > -1)
         {
            _children[param1].speedBones_internal::parent = null;
            _children[param1].speedBones_internal::stage = null;
            removeAt(param1);
         }
      }
      
      public function getChildIndex(param1:DisplayObject) : int
      {
         return _children.indexOf(param1);
      }
      
      public function getChildAt(param1:int) : DisplayObject
      {
         return _children[param1];
      }
      
      public function getChildByName(param1:String) : DisplayObject
      {
         var _loc2_:int = int(_children.length);
         var _loc3_:int = -1;
         while(++_loc3_ < _loc2_)
         {
            if(_children[_loc3_].name == param1)
            {
               return _children[_loc3_];
            }
         }
         return null;
      }
      
      public function removeChildren() : void
      {
         var _loc1_:int = int(_children.length);
         var _loc2_:int = -1;
         while(++_loc2_ < _loc1_)
         {
            removeChildAt(0);
         }
      }
      
      override speedBones_internal function setRenderContainerFilter(param1:RenderContainerData) : void
      {
         super.speedBones_internal::setRenderContainerFilter(param1);
         for each(var _loc2_:DisplayObject in _children)
         {
            _loc2_.setRenderContainerFilter(param1);
         }
      }
      
      override public function dispose() : void
      {
         var _loc2_:int = 0;
         super.dispose();
         var _loc1_:int = int(_children.length);
         _loc2_ = 0;
         while(_loc2_ < _loc1_)
         {
            _children[_loc2_].speedBones_internal::stage = null;
            _children[_loc2_].speedBones_internal::parent = null;
            _children[_loc2_].dispose();
            _loc2_++;
         }
         _children.length = 0;
         _renderContainerData = null;
      }
      
      protected function getChildBounds() : Rectangle
      {
         var _loc11_:Rectangle = null;
         var _loc12_:DisplayObject = null;
         var _loc8_:Number = 0;
         var _loc5_:Number = 0;
         var _loc10_:Number = 0;
         var _loc4_:Number = 0;
         var _loc7_:Number = 0;
         var _loc3_:Number = 0;
         var _loc6_:Number = 0;
         var _loc1_:Number = 0;
         var _loc9_:int = -1;
         var _loc2_:int = numChildren;
         while(++_loc9_ < _loc2_)
         {
            _loc12_ = _children[_loc9_];
            if(_loc12_)
            {
               _loc11_ = _loc12_.getBounds();
               _loc7_ = _loc11_.x + _loc12_.x;
               _loc3_ = _loc11_.y + _loc12_.y;
               _loc6_ = _loc11_.right + _loc12_.x;
               _loc1_ = _loc11_.bottom + _loc12_.y;
            }
            _loc8_ = _loc8_ < _loc7_ ? _loc8_ : _loc7_;
            _loc5_ = _loc5_ < _loc3_ ? _loc5_ : _loc3_;
            _loc10_ = _loc10_ > _loc6_ ? _loc10_ : _loc6_;
            _loc4_ = _loc4_ > _loc1_ ? _loc4_ : _loc1_;
         }
         _childBounds.x = _loc8_;
         _childBounds.y = _loc5_;
         _childBounds.right = _loc10_;
         _childBounds.bottom = _loc4_;
         setSrcRect(_childBounds);
         return _childBounds;
      }
      
      override public function dispathEventWidth(param1:Event, param2:Boolean = false) : void
      {
         var _loc3_:TouchEvent = null;
         if(param2 == true)
         {
            _loc3_ = param1 as TouchEvent;
            if(_loc3_)
            {
               if(param1.type == "mouse_out")
               {
                  if(hitTest(new Point(_loc3_.touchX,_loc3_.touchY)) != null)
                  {
                     return;
                  }
                  lastMouseMovePoint = null;
               }
               else if(param1.type == "mouse_over" && lastMouseMovePoint == null)
               {
                  lastMouseMovePoint = new Point(_loc3_.touchX,_loc3_.touchY);
               }
               else if(param1.type == "mouse_over" && lastMouseMovePoint)
               {
                  return;
               }
            }
         }
         super.dispathEventWidth(param1,param2);
      }
      
      override public function get width() : Number
      {
         getChildBounds();
         return super.width > _childBounds.width ? super.width : _childBounds.width;
      }
      
      override public function get height() : Number
      {
         getChildBounds();
         return super.height > _childBounds.height ? super.height : _childBounds.height;
      }
      
      override speedBones_internal function set stage(param1:Stage) : void
      {
         if(stage == param1)
         {
            return;
         }
         super.speedBones_internal::stage = param1;
         var _loc2_:int = numChildren;
         var _loc3_:int = -1;
         while(++_loc3_ < _loc2_)
         {
            _children[_loc3_].speedBones_internal::stage = param1;
         }
      }
      
      public function get children() : Vector.<DisplayObject>
      {
         return _children.slice(0);
      }
      
      public function get numChildren() : int
      {
         return _children.length;
      }
      
      override public function set touchTarget(param1:Boolean) : void
      {
         super.touchTarget = param1;
         for each(var _loc2_:DisplayObject in _children)
         {
            _loc2_.touchTarget = param1;
         }
      }
      
      override public function set filter(param1:Filter) : void
      {
         super.filter = param1;
         if(param1 == null)
         {
            _renderContainerData = null;
         }
         for each(var _loc2_:DisplayObject in _children)
         {
            if(param1 == null)
            {
               _loc2_.setRenderContainerFilter(null);
            }
            else if(param1 is BlurFilter)
            {
               _renderContainerData = new RenderContainerData();
               _loc2_.setRenderContainerFilter(_renderContainerData);
            }
            else
            {
               _loc2_.filter = param1;
            }
         }
      }
      
      public function set touchableChildren(param1:Boolean) : void
      {
         if(_touchableChildren != param1)
         {
            _touchableChildren = param1;
            touchTarget = param1;
         }
      }
      
      public function get touchableChildren() : Boolean
      {
         return _touchableChildren;
      }
   }
}

