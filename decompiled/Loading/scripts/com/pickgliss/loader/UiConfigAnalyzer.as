package com.pickgliss.loader
{
   import flash.utils.Dictionary;
   
   public class UiConfigAnalyzer extends DataAnalyzer
   {
      
      private static var _data:Dictionary;
      
      public function UiConfigAnalyzer(param1:Function)
      {
         super(param1);
      }
      
      public static function get data() : Dictionary
      {
         return _data;
      }
      
      override public function analyze(param1:*) : void
      {
         var _loc2_:XML = new XML(param1);
         _data = new Dictionary(true);
         var _loc4_:XMLList = _loc2_..Item;
         for each(var _loc3_ in _loc4_)
         {
            _data[String(_loc3_.@name)] = int(_loc3_.@size);
         }
         onAnalyzeComplete();
      }
   }
}

