package com.speedEngine.components.manager
{
   import flash.utils.Dictionary;
   
   public class StyleConfig
   {
      
      private var _styleDic:Dictionary;
      
      public function StyleConfig()
      {
         super();
         _styleDic = new Dictionary();
      }
      
      private function initBtnBmpData(param1:XML) : void
      {
         var _loc2_:* = null;
         for each(_loc2_ in param1..style)
         {
            _styleDic[_loc2_.@id.toString()] = _loc2_;
            delete _loc2_.@id;
         }
      }
      
      public function getStyleByName(param1:String) : XML
      {
         var _loc2_:XML = _styleDic[param1];
         if(_loc2_ == null)
         {
         }
         return _loc2_;
      }
   }
}

