package manager
{
   import com.pickgliss.loader.NamesLibAnalyzer;
   
   public class NamesLibManager
   {
      
      private static var _hasSetup:Boolean = false;
      
      private static var familyName:Array;
      
      private static var givenNameG:Array;
      
      private static var givenNameB:Array;
      
      public function NamesLibManager()
      {
         super();
      }
      
      public static function get hasSetup() : Boolean
      {
         return _hasSetup;
      }
      
      public static function setup(param1:NamesLibAnalyzer) : void
      {
         familyName = param1.familyName;
         givenNameG = param1.givenNameG;
         givenNameB = param1.givenNameB;
         _hasSetup = true;
      }
      
      public static function newName(param1:int) : String
      {
         var _loc3_:String = "";
         var _loc4_:int = random(0,familyName.length - 1);
         var _loc2_:int = random(0,givenNameG.length - 1);
         var _loc5_:int = random(0,givenNameB.length - 1);
         _loc3_ += familyName[_loc4_];
         if(param1 == 0)
         {
            _loc3_ += givenNameG[_loc2_];
         }
         else
         {
            _loc3_ += givenNameB[_loc5_];
         }
         return _loc3_;
      }
      
      public static function random(param1:int, param2:int) : int
      {
         var _loc3_:int = Math.random() * param2;
         if(_loc3_ < param1)
         {
            _loc3_ = param1;
         }
         else if(_loc3_ > param2)
         {
            _loc3_ = param2;
         }
         if(_loc3_ < 0)
         {
            _loc3_ = 0;
         }
         return _loc3_;
      }
   }
}

