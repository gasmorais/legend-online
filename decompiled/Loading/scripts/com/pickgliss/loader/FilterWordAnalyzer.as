package com.pickgliss.loader
{
   public class FilterWordAnalyzer extends DataAnalyzer
   {
      
      public var words:Array = [];
      
      public var nickNames:Array = [];
      
      public var unableChar:String;
      
      public function FilterWordAnalyzer(param1:Function)
      {
         super(param1);
      }
      
      override public function analyze(param1:*) : void
      {
         var _loc2_:Array = (param1 as String).toLocaleLowerCase().split("\n");
         unableChar = _loc2_[0];
         nickNames = _loc2_[1].split("|");
         words = _loc2_[2].split("|");
         onAnalyzeComplete();
      }
   }
}

