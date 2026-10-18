package com.speedEngine.speedBones.model
{
   import com.speedEngine.speedBones.BaseClass;
   
   public class HinderData extends BaseClass
   {
      
      private var _hinderStr:String;
      
      private var _hitSize:int;
      
      public function HinderData()
      {
         super();
      }
      
      public function get hinderStr() : String
      {
         return _hinderStr;
      }
      
      public function set hinderStr(param1:String) : void
      {
         _hinderStr = param1;
      }
      
      public function get hitSize() : int
      {
         return _hitSize;
      }
      
      public function set hitSize(param1:int) : void
      {
         _hitSize = param1;
      }
   }
}

