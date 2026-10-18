package com.speedEngine.game.base
{
   public class DriverType
   {
      
      public static const INFO_3D:String = "3d stage";
      
      public static const INFO_OLD:String = "3d old";
      
      public static const INFO_OLD_DRIVER:String = "Info oldDriver";
      
      public static const INFO_USER_DISABLED:String = "Info userDisabled";
      
      public function DriverType()
      {
         super();
      }
      
      public static function getDriverType(param1:String) : String
      {
         if(param1.indexOf("DirectX9") != -1 || param1.indexOf("OpenGL") != -1)
         {
            return "3d stage";
         }
         if(param1.indexOf("oldDriver") != -1)
         {
            return "Info oldDriver";
         }
         if(param1.indexOf("userDisabled") != -1)
         {
            return "Info userDisabled";
         }
         return "3d old";
      }
   }
}

