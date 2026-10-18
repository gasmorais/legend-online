package avatar.data
{
   import flash.utils.Dictionary;
   
   public class AvatarLayouData
   {
      
      public static const MULTI_MOUNT_GAP:uint = 50;
      
      public static const MULTI_MOUNT_GAP_DIAGONAL:Number = 40;
      
      public static const MULTI_MOUNT_DIAGONAL_DOWN_OFFSET_X:uint = 40;
      
      public static const MULTI_MOUNT_DIAGONAL_UP_OFFSET_Y:uint = 0;
      
      public static const MULTI_MOUNT_DIAGONAL_DWON_OFFSET_Y:uint = 25;
      
      private var _embedData:String;
      
      private var _data:Dictionary;
      
      public function AvatarLayouData(param1:String)
      {
         super();
         if(!param1)
         {
            return;
         }
         _embedData = param1;
         setData(_embedData);
      }
      
      private function setData(param1:String) : void
      {
         var _loc4_:Object = null;
         _data = new Dictionary(true);
         var _loc2_:Array = param1.split("|");
         for each(var _loc3_:String in _loc2_)
         {
            _loc4_ = solveItemData(_loc3_);
            _data[_loc4_.k] = _loc4_;
         }
      }
      
      public function clearOffset() : void
      {
         setData(_embedData);
      }
      
      public function setDataOffsetByFrameY(param1:int, param2:int, param3:int, param4:int = 1) : void
      {
         for(var _loc5_:String in _data)
         {
            if(_loc5_.indexOf("_" + param1) >= 0)
            {
               _data[_loc5_].x = int(_data[_loc5_].x) + param2 * param4;
               _data[_loc5_].y = int(_data[_loc5_].y) + param3 * param4;
            }
         }
      }
      
      public function getCellByKey(param1:int, param2:int) : Object
      {
         return _data[param1 + "_" + param2];
      }
      
      private function solveItemData(param1:String) : Object
      {
         var _loc3_:int = 0;
         var _loc2_:Array = param1.split(",");
         var _loc4_:Object = {};
         for each(var _loc5_:String in _loc2_)
         {
            _loc3_ = _loc5_.indexOf(":");
            _loc4_[_loc5_.substr(0,_loc3_)] = _loc5_.substr(_loc3_ + 1);
         }
         _loc2_ = null;
         return _loc4_;
      }
   }
}

