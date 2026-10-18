package com.speedEngine.game.view
{
   import com.speedEngine.game.interfaces.IDispose;
   import flash.display.DisplayObject;
   import flash.display.Sprite;
   
   public class BaseSprite extends Sprite implements IDispose
   {
      
      public function BaseSprite()
      {
         super();
      }
      
      public function dispose() : void
      {
         var _loc2_:int = 0;
         var _loc1_:DisplayObject = null;
         _loc2_ = 0;
         while(_loc2_ < numChildren)
         {
            _loc1_ = getChildAt(_loc2_);
            if(_loc1_.hasOwnProperty("dispose"))
            {
               _loc1_["dispose"]();
            }
            _loc2_++;
         }
      }
   }
}

