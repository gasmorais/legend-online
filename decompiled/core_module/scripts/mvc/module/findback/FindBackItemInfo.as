package mvc.module.findback
{
   import com.pickgliss.ui.controls.cell.INotSameHeightListCellData;
   import com.road.yishi.proto.retrieve.RetrieveInfo;
   
   public class FindBackItemInfo implements INotSameHeightListCellData
   {
      
      public var type:int;
      
      public var name:String;
      
      public var rewards:Vector.<FindBackRewardInfo>;
      
      public var costGold:int = 0;
      
      public var costPoint:int = 0;
      
      public var model:FindBackModel;
      
      public var findType:int;
      
      public function FindBackItemInfo()
      {
         super();
         rewards = new Vector.<FindBackRewardInfo>();
      }
      
      public static function createFromMsg(param1:RetrieveInfo) : FindBackItemInfo
      {
         var _loc4_:Array = null;
         var _loc5_:Array = null;
         var _loc3_:FindBackRewardInfo = null;
         var _loc6_:FindBackItemInfo = new FindBackItemInfo();
         _loc6_.type = param1.tempType;
         _loc6_.name = param1.tempName;
         _loc6_.costGold = param1.totalGold;
         _loc6_.costPoint = param1.totalPoint;
         _loc6_.findType = param1.type;
         if(param1.items)
         {
            _loc4_ = param1.items.split("|");
            for each(var _loc2_:String in _loc4_)
            {
               _loc5_ = _loc2_.split(",");
               if(_loc5_.length == 2)
               {
                  if(!(int(_loc5_[0]) == 0 || int(_loc5_[1]) == 0))
                  {
                     _loc3_ = new FindBackRewardInfo(int(_loc5_[0]),int(_loc5_[1]));
                     _loc6_.rewards.push(_loc3_);
                  }
               }
            }
         }
         return _loc6_;
      }
      
      public function contains(param1:int) : Boolean
      {
         for each(var _loc2_:FindBackRewardInfo in rewards)
         {
            if(param1 > 0)
            {
               if(_loc2_.goodsTempId > 0)
               {
                  return true;
               }
            }
            else if(_loc2_.goodsTempId == param1)
            {
               return true;
            }
         }
         return false;
      }
      
      public function getCellHeight() : Number
      {
         var _loc2_:int = (rewards.length - 1) / 4;
         return 88 + _loc2_ * 65;
      }
   }
}

