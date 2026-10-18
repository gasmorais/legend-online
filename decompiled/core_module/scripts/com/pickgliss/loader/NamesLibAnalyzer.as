package com.pickgliss.loader
{
   public class NamesLibAnalyzer extends DataAnalyzer
   {
      
      public var familyName:Array = [""];
      
      public var givenNameG:Array = [""];
      
      public var givenNameB:Array = [""];
      
      public function NamesLibAnalyzer(param1:Function)
      {
         super(param1);
      }
      
      override public function analyze(param1:*) : void
      {
         var _loc4_:int = 0;
         var _loc3_:String = null;
         var _loc2_:Array = (param1 as String).toLocaleLowerCase().split("\n");
         _loc4_ = 0;
         while(_loc4_ < _loc2_.length)
         {
            _loc3_ = _loc2_[_loc4_];
            if(_loc3_.indexOf("#") == 0)
            {
               _loc2_.splice(_loc4_,1);
            }
            _loc4_++;
         }
         if(_loc2_.length >= 1)
         {
            familyName = _loc2_[0].split(",");
         }
         if(_loc2_.length >= 2)
         {
            givenNameG = _loc2_[1].split(",");
         }
         if(_loc2_.length >= 3)
         {
            givenNameB = _loc2_[2].split(",");
         }
         onAnalyzeComplete();
      }
   }
}

