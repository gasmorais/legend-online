package com.pickgliss.loader.data
{
   public class LoaderPriority
   {
      
      public static const Priority_10:int = 10;
      
      public static const Priority_9:int = 9;
      
      public static const Priority_8:int = 8;
      
      public static const Priority_7:int = 7;
      
      public static const Priority_6:int = 6;
      
      public static const Priority_5:int = 5;
      
      public static const Priority_4:int = 4;
      
      public static const Priority_1:int = 1;
      
      public static const Priority_0:int = 0;
      
      public static var canRemoveList:Array = [4,9];
      
      public function LoaderPriority()
      {
         super();
      }
      
      public static function isImidiatyLoader(param1:LoaderInfo) : Boolean
      {
         return param1.priority == 0;
      }
      
      public static function isMonopolizeLoader(param1:LoaderInfo) : Boolean
      {
         return param1.priority == 10 || param1.priority == 9;
      }
      
      public static function isCanClearLoader(param1:LoaderInfo) : Boolean
      {
         if(param1.priority != 1)
         {
            return param1.canClearWhenSetScene;
         }
         return param1.priority != 1;
      }
   }
}

