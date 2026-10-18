package mvc.module.timestory
{
   public class TimeStoryModel
   {
      
      public var id:String;
      
      public var time:String;
      
      public var title:String;
      
      public var isActive:Boolean;
      
      public var opUser:String;
      
      public var activeDate:String;
      
      public var remark:String;
      
      public var nextDate:String;
      
      public var music:String;
      
      public var infoList:Vector.<TimeStoryInfo>;
      
      public var totalPage:int = 0;
      
      public function TimeStoryModel()
      {
         super();
         infoList = new Vector.<TimeStoryInfo>();
      }
      
      public function addInfo(param1:TimeStoryInfo) : void
      {
         infoList.push(param1);
      }
      
      public function getInfoByType(param1:int) : TimeStoryInfo
      {
         for each(var _loc2_:TimeStoryInfo in infoList)
         {
            if(_loc2_.type == param1)
            {
               return _loc2_;
            }
         }
         return null;
      }
      
      public function initTotalPage() : void
      {
         var _loc4_:TimeStoryInfo = null;
         var _loc3_:int = 0;
         var _loc2_:int = 0;
         var _loc1_:int = int(infoList.length);
         _loc3_ = 0;
         while(_loc3_ < _loc1_)
         {
            _loc4_ = infoList[_loc3_];
            _loc2_ += _loc4_.count;
            _loc3_++;
         }
         totalPage = _loc2_ - 1;
      }
      
      public function getPreCountByCurrentType(param1:int) : int
      {
         var _loc3_:int = 0;
         var _loc2_:int = 0;
         _loc3_ = 1;
         while(_loc3_ < param1)
         {
            _loc2_ += getInfoByType(_loc3_).count;
            _loc3_++;
         }
         return _loc2_;
      }
      
      public function getInfoByPage(param1:int) : TimeStoryInfo
      {
         var _loc5_:TimeStoryInfo = null;
         var _loc4_:int = 0;
         var _loc3_:int = 0;
         var _loc2_:int = int(infoList.length);
         _loc4_ = 1;
         while(_loc4_ <= _loc2_)
         {
            _loc5_ = getInfoByType(_loc4_);
            _loc3_ += _loc5_.count;
            if(param1 <= _loc3_)
            {
               return _loc5_;
            }
            _loc4_++;
         }
         return _loc5_;
      }
      
      public function getResourceByPage(param1:int) : String
      {
         var _loc3_:int = 0;
         var _loc2_:int = 0;
         var _loc5_:TimeStoryInfo = getInfoByPage(param1);
         var _loc4_:int = getPreCountByCurrentType(_loc5_.type);
         _loc2_ += _loc4_;
         _loc3_ = 0;
         while(_loc3_ < _loc5_.resList.length)
         {
            if(++_loc2_ == param1)
            {
               return _loc5_.resList[_loc3_];
            }
            _loc3_++;
         }
         return "";
      }
   }
}

