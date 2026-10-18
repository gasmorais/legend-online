package com.pickgliss.loader
{
   import com.pickgliss.utils.StringUtils;
   import flash.utils.Dictionary;
   
   public class LanguageAnalyzer extends DataAnalyzer
   {
      
      private var nAllExp:RegExp = /\\n/g;
      
      public var languages:Dictionary = new Dictionary();
      
      public function LanguageAnalyzer(param1:Function)
      {
         super(param1);
      }
      
      override public function analyze(param1:*) : void
      {
         var _loc4_:int = 0;
         var _loc2_:String = null;
         var _loc5_:int = 0;
         var _loc3_:String = null;
         var _loc7_:String = null;
         var _loc6_:Array = (param1 as String).split("\n");
         _loc4_ = 0;
         while(_loc4_ < _loc6_.length)
         {
            _loc2_ = _loc6_[_loc4_];
            if(_loc2_.indexOf("#") != 0)
            {
               _loc2_ = _loc2_.replace("\\r","\r");
               _loc2_ = _loc2_.replace(nAllExp,"\n");
               _loc5_ = _loc2_.indexOf(":");
               if(_loc5_ != -1)
               {
                  _loc3_ = _loc2_.substring(0,_loc5_);
                  _loc7_ = _loc2_.substr(_loc5_ + 1);
                  _loc7_ = _loc7_.split("##")[0];
                  languages[_loc3_] = StringUtils.trimRight(_loc7_);
               }
            }
            _loc4_++;
         }
         onAnalyzeComplete();
      }
   }
}

