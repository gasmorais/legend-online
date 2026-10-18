package com.road.yishi.proto.player
{
   public class HouseMsg
   {
      
      public var type:String;
      
      public var x:int;
      
      public var y:int;
      
      public var curW:int;
      
      public var curH:int;
      
      public function HouseMsg()
      {
         super();
      }
      
      public function toString() : String
      {
         return "type:" + type + ",x:" + x + ",y:" + y;
      }
   }
}

