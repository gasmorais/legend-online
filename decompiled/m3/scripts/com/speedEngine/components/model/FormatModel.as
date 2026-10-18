package com.speedEngine.components.model
{
   public dynamic class FormatModel
   {
      
      private var _$className:String;
      
      private var _$objectName:String;
      
      private var _$children:Array;
      
      public function FormatModel()
      {
         super();
         _$className = null;
         _$objectName = null;
         _$children = null;
      }
      
      public function puchChild(... rest) : void
      {
         _$children == null ? (_$children = []) : null;
         var _loc2_:int = int(rest.length);
         var _loc3_:int = 0;
         while(_loc3_ < _loc2_)
         {
            _$children.push(rest[_loc3_]);
            _loc3_++;
         }
      }
      
      public function get children() : Array
      {
         return _$children;
      }
      
      public function get className() : String
      {
         return _$className;
      }
      
      public function set className(param1:String) : void
      {
         _$className = param1;
      }
      
      public function get objectName() : String
      {
         return _$objectName;
      }
      
      public function set objectName(param1:String) : void
      {
         _$objectName = param1;
      }
   }
}

