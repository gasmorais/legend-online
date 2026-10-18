package com.pickgliss.ui.controls.container
{
   import com.pickgliss.events.ComponentEvent;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.DisplayObject;
   
   public class BoxContainer extends Component
   {
      
      public static const P_childRefresh:String = "childRefresh";
      
      public static const P_childResize:String = "childResize";
      
      public static const P_isReverAdd:String = "isReverAdd";
      
      public static const P_spacing:String = "spacing";
      
      public static const P_strictWidth:String = "strictWidth";
      
      public static const P_strictHeight:String = "strictHeight";
      
      public static const P_direction:String = "direction";
      
      protected var _childrenList:Vector.<DisplayObject> = new Vector.<DisplayObject>();
      
      protected var _isReverAdd:Boolean;
      
      protected var _spacing:Number = 0;
      
      protected var _strictWidth:Number = -1;
      
      protected var _strictHeight:Number = -1;
      
      protected var _direction:Number = -1;
      
      public function BoxContainer()
      {
         super();
      }
      
      override public function addChild(param1:DisplayObject) : DisplayObject
      {
         if(!_childrenList)
         {
            return null;
         }
         if(_childrenList.indexOf(param1) >= 0)
         {
            return null;
         }
         if(!_isReverAdd)
         {
            _childrenList.push(super.addChild(param1));
         }
         else
         {
            _childrenList.unshift(super.addChildAt(param1,0));
         }
         param1.addEventListener("propertiesChanged",__onResize);
         onPropertiesChanged("childRefresh");
         return param1;
      }
      
      override public function addChildAt(param1:DisplayObject, param2:int) : DisplayObject
      {
         _childrenList.splice(param2,0,super.addChildAt(param1,param2));
         param1.addEventListener("propertiesChanged",__onResize);
         onPropertiesChanged("childRefresh");
         return param1;
      }
      
      override public function dispose() : void
      {
         removeAllEvent();
         super.dispose();
         _childrenList = null;
      }
      
      public function removeAllChild() : void
      {
         var _loc1_:DisplayObject = null;
         while(numChildren > 0)
         {
            _loc1_ = getChildAt(0);
            removeChild(_loc1_);
            _loc1_.x = 0;
            _loc1_.removeEventListener("propertiesChanged",__onResize);
         }
         if(_childrenList)
         {
            _childrenList.splice(0,-1);
         }
      }
      
      protected function refreshDirection(param1:DisplayObject) : void
      {
      }
      
      public function disposeAllChildren() : void
      {
         removeAllEvent();
         ObjectUtils.disposeAllChildren(this);
         if(_childrenList)
         {
            _childrenList.splice(0,-1);
         }
      }
      
      public function set isReverAdd(param1:Boolean) : void
      {
         if(_isReverAdd == param1)
         {
            return;
         }
         _isReverAdd = param1;
         onPropertiesChanged("isReverAdd");
      }
      
      public function removeAllEvent() : void
      {
         var _loc2_:int = 0;
         var _loc3_:DisplayObject = null;
         var _loc1_:int = numChildren;
         _loc2_ = 0;
         while(_loc2_ < _loc1_)
         {
            _loc3_ = getChildAt(0);
            if(_loc3_)
            {
               _loc3_.removeEventListener("propertiesChanged",__onResize);
            }
            _loc2_++;
         }
      }
      
      public function refreshChildPos() : void
      {
         onPropertiesChanged("childResize");
      }
      
      override public function removeChild(param1:DisplayObject) : DisplayObject
      {
         if(_childrenList)
         {
            param1.removeEventListener("propertiesChanged",__onResize);
            _childrenList.splice(_childrenList.indexOf(param1),1);
            super.removeChild(param1);
            onPropertiesChanged("childRefresh");
            return param1;
         }
         return null;
      }
      
      override public function removeChildAt(param1:int) : DisplayObject
      {
         var _loc2_:DisplayObject = getChildAt(param1);
         _loc2_.removeEventListener("propertiesChanged",__onResize);
         _childrenList.splice(_childrenList.indexOf(_loc2_),1);
         super.removeChild(_loc2_);
         onPropertiesChanged("childRefresh");
         return _loc2_;
      }
      
      public function reverChildren() : void
      {
         var _loc2_:int = 0;
         var _loc1_:Vector.<DisplayObject> = new Vector.<DisplayObject>();
         while(numChildren > 0)
         {
            _loc1_.push(removeChildAt(0));
         }
         _loc2_ = 0;
         while(_loc2_ < _loc1_.length)
         {
            addChild(_loc1_[_loc2_]);
            _loc2_++;
         }
      }
      
      public function get spacing() : Number
      {
         return _spacing;
      }
      
      public function set spacing(param1:Number) : void
      {
         if(_spacing == param1)
         {
            return;
         }
         _spacing = param1;
         onPropertiesChanged("spacing");
      }
      
      public function set strictWidth(param1:Number) : void
      {
         if(_strictWidth == param1)
         {
            return;
         }
         _strictWidth = param1;
         onPropertiesChanged("strictWidth");
      }
      
      public function set strictHeight(param1:Number) : void
      {
         if(_strictHeight == param1)
         {
            return;
         }
         _strictHeight = param1;
         onPropertiesChanged("strictHeight");
      }
      
      public function set direction(param1:Number) : void
      {
         if(_direction == param1)
         {
            return;
         }
         _direction = param1;
         onPropertiesChanged("direction");
      }
      
      protected function arrange() : void
      {
      }
      
      protected function get isStrictWidth() : Boolean
      {
         return _strictWidth > 0;
      }
      
      protected function get isStrictHeight() : Boolean
      {
         return _strictHeight > 0;
      }
      
      override protected function onProppertiesUpdate() : void
      {
         arrange();
      }
      
      protected function __onResize(param1:ComponentEvent) : void
      {
         if(param1.changedProperties["height"] || param1.changedProperties["width"])
         {
            onPropertiesChanged("childRefresh");
         }
      }
   }
}

