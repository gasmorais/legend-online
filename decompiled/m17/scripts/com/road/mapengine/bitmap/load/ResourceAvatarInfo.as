package com.road.mapengine.bitmap.load
{
   import avatar.data.AvatarLayouData;
   import com.road.mapengine.bitmap.lib.BitmapTempLib;
   
   public class ResourceAvatarInfo extends ResourceInfo
   {
      
      public var sornBaseNum:Array;
      
      public var curBaseNum:int;
      
      public var position:String;
      
      public var layouPara:AvatarLayouData;
      
      public var walkLayouPara:AvatarLayouData;
      
      public var attackLayouPara:AvatarLayouData;
      
      public function ResourceAvatarInfo()
      {
         super();
      }
      
      public function getAvatarStandCellByFrame(param1:int, param2:int) : void
      {
         var _loc3_:String = packageName + "S_" + param1 + "_" + param2;
         nextBitmapData = BitmapTempLib.instance.createBitmapdata(_loc3_);
      }
      
      public function getAvatarWalksCellByFrame(param1:int, param2:int) : void
      {
         var _loc3_:String = packageName + "W_" + param1 + "_" + param2;
         nextBitmapData = BitmapTempLib.instance.createBitmapdata(_loc3_);
      }
      
      public function getAvatarAttackCellByFrame(param1:int, param2:int) : void
      {
         var _loc3_:String = packageName + "A_" + param1 + "_" + param2;
         nextBitmapData = BitmapTempLib.instance.createBitmapdata(_loc3_);
      }
   }
}

