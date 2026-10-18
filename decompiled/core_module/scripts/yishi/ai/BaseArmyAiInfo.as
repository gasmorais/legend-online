package yishi.ai
{
   import events.ArmyEvent;
   import flash.display.Bitmap;
   import flash.utils.Dictionary;
   import map.internals.utils.MapDataUtils;
   import yishi.datas.ai.AIBaseInfo;
   
   public class BaseArmyAiInfo extends AIBaseInfo
   {
      
      private var _road:Dictionary;
      
      private var _castleIndex:int;
      
      private var _castlesPath:Array;
      
      public function BaseArmyAiInfo()
      {
         super();
      }
      
      override public function sysInfo(param1:AIBaseInfo) : void
      {
         super.sysInfo(param1);
         this.road = param1["road"];
         this._castleIndex = param1["castleIndex"];
         setCastlesPath(param1["castlesPath"]);
      }
      
      public function get castleIndex() : int
      {
         return _castleIndex;
      }
      
      public function set castleIndex(param1:int) : void
      {
         _castleIndex = param1;
      }
      
      public function get castlesPath() : Array
      {
         return _castlesPath;
      }
      
      public function setCastlesPath(param1:Array, param2:Boolean = false) : void
      {
         var _loc3_:Array = null;
         _castleIndex = 0;
         if(param1)
         {
            _loc3_ = MapDataUtils.updateSeparatorByArray(param1);
         }
         _castlesPath = _loc3_;
         dispatchEvent(new ArmyEvent("UPDATE_CASTLE",param2));
      }
      
      public function get road() : Dictionary
      {
         return _road;
      }
      
      public function set road(param1:Dictionary) : void
      {
         if(_road)
         {
            clearRoad(_road);
         }
         _road = param1;
      }
      
      private function clearRoad(param1:Dictionary) : void
      {
         for each(var _loc2_:Bitmap in param1)
         {
            if(_loc2_.parent)
            {
               _loc2_.parent.removeChild(_loc2_);
            }
            _loc2_.bitmapData = null;
            _loc2_ = null;
         }
         for(var _loc3_:String in param1)
         {
            delete param1[_loc3_];
         }
         param1 = null;
      }
   }
}

