package com.road.mapengine.bitmap
{
   import com.pickgliss.ui.core.Disposeable;
   import com.road.mapengine.bitmap.logic.BitmapSimpleLogic;
   import flash.display.DisplayObject;
   import flash.display.Sprite;
   import flash.events.Event;
   import yishi.utils.SimpleDictionary;
   
   public class BaseMapScene implements Disposeable
   {
      
      protected var _list:SimpleDictionary;
      
      protected var _parent:Sprite;
      
      public function BaseMapScene(param1:Sprite)
      {
         super();
         _parent = param1;
         _list = new SimpleDictionary(true);
      }
      
      public function addChild(param1:DisplayObject) : DisplayObject
      {
         _parent.addChild(param1);
         return param1;
      }
      
      public function removeChild(param1:DisplayObject) : DisplayObject
      {
         if(param1)
         {
            if(param1.parent)
            {
               param1.parent.removeChild(param1);
            }
         }
         return param1;
      }
      
      public function addChildAt(param1:DisplayObject, param2:int) : DisplayObject
      {
         _parent.addChildAt(param1,param2);
         return param1;
      }
      
      public function dispatchEvent(param1:Event) : Boolean
      {
         return _parent.dispatchEvent(param1);
      }
      
      public function addEventListener(param1:String, param2:Function, param3:Boolean = false, param4:int = 0, param5:Boolean = false) : void
      {
         _parent.addEventListener(param1,param2,param3,param4,param5);
      }
      
      public function removeEventListener(param1:String, param2:Function, param3:Boolean = false) : void
      {
         _parent.removeEventListener(param1,param2,param3);
      }
      
      public function get mouseX() : Number
      {
         return _parent.mouseX;
      }
      
      public function get mouseY() : Number
      {
         return _parent.mouseY;
      }
      
      public function addSkill(param1:DisplayObject) : void
      {
         _parent.addChild(param1);
      }
      
      public function enterFrame() : void
      {
         for each(var _loc1_:BitmapSimpleLogic in _list)
         {
            _loc1_.update();
         }
      }
      
      public function addLogic(param1:BitmapSimpleLogic) : void
      {
         _list.add(param1.instanceId,param1);
      }
      
      public function removeLogic(param1:BitmapSimpleLogic) : void
      {
         _list.del(param1.instanceId);
      }
      
      public function getAllLogic() : Array
      {
         return _list.getList();
      }
      
      public function dispose() : void
      {
         for each(var _loc1_:BitmapSimpleLogic in _list)
         {
            _loc1_.dispose();
         }
         for(var _loc2_:String in _list)
         {
            delete _list[_loc2_];
         }
         _list = null;
         _parent = null;
      }
      
      public function get parent() : Sprite
      {
         return _parent;
      }
   }
}

