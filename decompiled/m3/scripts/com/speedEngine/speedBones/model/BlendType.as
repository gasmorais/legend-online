package com.speedEngine.speedBones.model
{
   import com.speedEngine.speedBones.BaseClass;
   
   public class BlendType extends BaseClass
   {
      
      public static const NONE:uint = 0;
      
      public static const NORMAL:uint = 1;
      
      public static const ADD:uint = 2;
      
      public static const MULTIPLY:uint = 3;
      
      public static const SCREEN:uint = 4;
      
      public static const ERASE:uint = 5;
      
      public function BlendType()
      {
         super();
      }
      
      public static function getBlendType(param1:String) : uint
      {
         switch(param1)
         {
            case "add":
               return 2;
            case "multiply":
               return 3;
            case "screen":
               return 4;
            case "erase":
               return 5;
            case "normal":
               return 1;
            case "none":
               return 0;
            default:
               return 1;
         }
      }
   }
}

