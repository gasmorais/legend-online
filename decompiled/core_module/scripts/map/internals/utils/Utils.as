package map.internals.utils
{
   import com.pickgliss.toplevel.StageReferance;
   import flash.geom.Point;
   import flash.geom.Rectangle;
   
   public class Utils
   {
      
      public function Utils()
      {
         super();
      }
      
      public static function getNineSliceScaling(param1:Rectangle) : Array
      {
         return getCurrentMinScreen(param1);
      }
      
      public static function getCurrentMinScreen(param1:Rectangle) : Array
      {
         var _loc5_:int = 0;
         var _loc6_:int = 0;
         var _loc4_:int = 1000;
         var _loc7_:int = 1000;
         var _loc2_:Array = [];
         var _loc3_:Point = new Point(param1.x - StageReferance.stageWidth / 2 - 100,param1.y - StageReferance.stageHeight / 2 - 100);
         _loc2_.push(getFileName(_loc3_.x,_loc3_.y,_loc4_,_loc7_));
         _loc2_.push(getFileName(_loc3_.x,_loc3_.y + 1000,_loc4_,_loc7_));
         _loc5_ = 1000 - param1.x % 1000 + 1000;
         _loc2_.push(getFileName(_loc3_.x + 1000,_loc3_.y,_loc4_,_loc7_));
         _loc2_.push(getFileName(_loc3_.x + 1000,_loc3_.y + 1000,_loc4_,_loc7_));
         if(_loc5_ < StageReferance.stageWidth + 150)
         {
            _loc2_.push(getFileName(_loc3_.x + 2000,_loc3_.y,_loc4_,_loc7_));
            _loc2_.push(getFileName(_loc3_.x + 2000,_loc3_.y + 1000,_loc4_,_loc7_));
         }
         _loc6_ = 1000 - _loc3_.y % 1000;
         if(_loc6_ < 150)
         {
            _loc2_.push(getFileName(_loc3_.x,_loc3_.y + 2000,_loc4_,_loc7_));
            _loc2_.push(getFileName(_loc3_.x + 1000,_loc3_.y + 2000,_loc4_,_loc7_));
         }
         return _loc2_;
      }
      
      public static function getFileNameList(param1:int, param2:int, param3:int, param4:int, param5:int, param6:int) : Array
      {
         var _loc8_:int = 0;
         var _loc9_:int = 0;
         var _loc7_:Array = [];
         _loc8_ = param1 - 1500;
         while(_loc8_ < param1 + 1500 + param5)
         {
            if(_loc8_ < 0)
            {
               _loc8_ += param5;
            }
            else
            {
               _loc9_ = param2 - 1500;
               while(_loc9_ < param2 + 1500 + param6)
               {
                  if(_loc9_ < 0)
                  {
                     _loc9_ += param6;
                  }
                  else
                  {
                     _loc7_.push(getFileName(_loc8_,_loc9_,param5,param6));
                     _loc9_ += param6;
                  }
                  _loc9_;
               }
               _loc8_ += param5;
            }
            _loc8_;
         }
         return _loc7_.reverse();
      }
      
      public static function getFileName(param1:int, param2:int, param3:int = 1000, param4:int = 1000) : String
      {
         var _loc5_:int = Math.floor(param1 / param3);
         var _loc6_:int = Math.floor(param2 / param4);
         return _loc5_ + "," + _loc6_;
      }
      
      public static function getTiles(param1:int, param2:int, param3:int, param4:int) : Point
      {
         var _loc6_:int = 0;
         var _loc5_:int = 0;
         _loc5_ = Math.floor(param3 / param1);
         _loc6_ = Math.floor(param4 / param2);
         return new Point(_loc5_,_loc6_);
      }
      
      public static function getStartPoint(param1:String) : Point
      {
         var _loc2_:Array = param1.split(",");
         var _loc3_:int = _loc2_[0] * 1000;
         var _loc4_:int = _loc2_[1] * 1000;
         var _loc5_:Point = new Point(_loc3_,_loc4_);
         _loc2_ = null;
         return _loc5_;
      }
      
      public static function getFilesIds(param1:Array) : String
      {
         var _loc4_:int = 0;
         var _loc2_:String = "";
         var _loc3_:RegExp = /,/;
         _loc4_ = 0;
         while(_loc4_ < param1.length)
         {
            _loc2_ += param1[_loc4_].replace(_loc3_,"_") + ",";
            _loc4_++;
         }
         return _loc2_.substring(0,_loc2_.length - 1);
      }
      
      public static function strToPoint(param1:String, param2:String) : Point
      {
         var _loc4_:Point = null;
         var _loc3_:Array = param1.split(param2);
         if(_loc3_.length == 2)
         {
            _loc4_ = new Point(_loc3_[0],_loc3_[1]);
            _loc3_ = null;
            return _loc4_;
         }
         throw new Error("String转换Point错误 ： " + param1);
      }
      
      public static function castleToPoint(param1:String) : Point
      {
         var _loc3_:Point = null;
         var _loc2_:Array = param1.split(",");
         if(_loc2_.length == 2)
         {
            _loc3_ = new Point(_loc2_[0],_loc2_[1]);
            _loc2_ = null;
            return _loc3_;
         }
         throw new Error("String转换Point错误 ： " + param1);
      }
      
      public static function getArrayValueByTag(param1:String, param2:Array) : String
      {
         var _loc5_:int = 0;
         var _loc4_:RegExp = new RegExp(param1);
         for each(var _loc3_:String in param2)
         {
            _loc5_ = _loc3_.indexOf(param1);
            if(_loc5_ != -1)
            {
               return _loc3_.replace(_loc4_,"");
            }
         }
         return "";
      }
   }
}

