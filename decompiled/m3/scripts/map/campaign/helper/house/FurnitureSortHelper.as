package map.campaign.helper.house
{
   import map.campaign.CampaignManager;
   import mvc.module.home.FurnitureInfo;
   import yishi.datas.templates.FurnitureTempInfo;
   import yishi.manager.TempleteManager;
   import yishi.utils.WorldBossHelper;
   
   public class FurnitureSortHelper
   {
      
      private static var tempList:Vector.<FurnitureInfo>;
      
      private static var sortListLeftWall:Vector.<FurnitureInfo>;
      
      private static var sortListRightWall:Vector.<FurnitureInfo>;
      
      private static var sortListFloor:Vector.<FurnitureInfo>;
      
      private static var sortList:Vector.<FurnitureInfo>;
      
      private static var sortStack:Vector.<FurnitureInfo>;
      
      private static var sortFunction:Function;
      
      private static var lookAheadFunction:Function;
      
      private static var position:int;
      
      private static var dealCount:int;
      
      public function FurnitureSortHelper()
      {
         super();
      }
      
      public static function dealWith(param1:Vector.<FurnitureInfo>, param2:Function, param3:FurnitureInfo = null) : void
      {
         if(param3)
         {
            if(isOthers(param3))
            {
               dealFurnitureInfo(param2,param3,param3);
               return;
            }
         }
         tempList = param1.concat();
         sortListLeftWall = tempList.filter(FurnitureSortHelper.filterNeedSort).filter(FurnitureSortHelper.filterLeftWall);
         sortListRightWall = tempList.filter(FurnitureSortHelper.filterNeedSort).filter(FurnitureSortHelper.filterRightWall);
         sortListFloor = tempList.filter(FurnitureSortHelper.filterNeedSort).filter(FurnitureSortHelper.filterFloor);
         sortStack = new Vector.<FurnitureInfo>();
         if(param3)
         {
            if(param3.area == 1)
            {
               sortListLeftWall.push(param3);
            }
            else if(param3.area == 2)
            {
               sortListRightWall.push(param3);
            }
            else
            {
               sortListFloor.push(param3);
            }
         }
         else
         {
            for each(var _loc4_:FurnitureInfo in tempList)
            {
               if(isOthers(_loc4_))
               {
                  dealFurnitureInfo(param2,_loc4_);
               }
            }
         }
         sort(sortListLeftWall,sortByPosYAndPosXInverse,lookAheadInverse,param2,param3);
         sort(sortListRightWall,sortByPosYAndPosX,lookAhead,param2,param3);
         sort(sortListFloor,sortByPosYAndPosX,lookAhead,param2,param3);
         sortListLeftWall.splice(0,sortListLeftWall.length);
         sortListRightWall.splice(0,sortListRightWall.length);
         sortListFloor.splice(0,sortListFloor.length);
         tempList.splice(0,sortListLeftWall.length);
         sortListLeftWall = null;
         sortListRightWall = null;
         sortListFloor = null;
         tempList = null;
         sortStack = null;
      }
      
      private static function sort(param1:Vector.<FurnitureInfo>, param2:Function, param3:Function, param4:Function, param5:FurnitureInfo = null) : void
      {
         var _loc7_:FurnitureInfo = null;
         var _loc6_:FurnitureInfo = null;
         sortList = param1.slice();
         sortFunction = param2;
         lookAheadFunction = param3;
         position = 0;
         dealCount = 0;
         sortList.sort(sortFunction);
         if(sortList && sortList.length > 0)
         {
            _loc7_ = lookAheadFunction();
            while(sortList.length > 0 || sortStack.length > 0)
            {
               _loc6_ = lookAheadFunction(_loc7_);
               if(_loc6_)
               {
                  while(_loc6_)
                  {
                     sortStack.push(_loc7_);
                     _loc7_ = _loc6_;
                     _loc6_ = lookAheadFunction(_loc7_);
                  }
                  dealFurnitureInfo(param4,_loc7_,param5);
                  _loc7_ = sortStack.pop();
               }
               else
               {
                  dealFurnitureInfo(param4,_loc7_,param5);
                  if(sortStack && sortStack.length > 0)
                  {
                     _loc7_ = sortStack.pop();
                  }
                  else
                  {
                     _loc7_ = lookAheadFunction();
                  }
               }
            }
            dealFurnitureInfo(param4,_loc7_,param5);
         }
      }
      
      private static function dealFurnitureInfo(param1:Function, param2:FurnitureInfo, param3:FurnitureInfo = null) : void
      {
         var _loc4_:FurnitureInfo = null;
         if(param1 != null)
         {
            if(param3)
            {
               if(param3.furnitureId == param2.furnitureId)
               {
                  param1(param3,true,dealCount);
               }
               dealCount = dealCount + 1;
            }
            else
            {
               _loc4_ = new FurnitureInfo();
               _loc4_.furnitureId = param2.furnitureId;
               _loc4_.templateId = param2.templateId;
               _loc4_.posX = param2.posX;
               _loc4_.posY = param2.posY;
               _loc4_.rotation = param2.rotation;
               param1(_loc4_);
            }
         }
      }
      
      private static function lookAhead(param1:FurnitureInfo = null) : FurnitureInfo
      {
         var _loc2_:FurnitureInfo = null;
         var _loc3_:int = 0;
         if(sortList && sortList.length > 0)
         {
            if(!param1)
            {
               _loc2_ = sortList.splice(_loc3_,1)[0];
               position = _loc3_;
            }
            else
            {
               _loc3_ = position;
               while(_loc3_ < sortList.length)
               {
                  _loc2_ = sortList[_loc3_];
                  if(_loc2_.posY >= param1.posY + param1.height)
                  {
                     _loc2_ = null;
                     break;
                  }
                  if(_loc2_.posX < param1.posX)
                  {
                     _loc2_ = sortList.splice(_loc3_,1)[0];
                     position = _loc3_;
                     break;
                  }
                  _loc2_ = null;
                  _loc3_++;
               }
            }
         }
         return _loc2_;
      }
      
      private static function sortByPosYAndPosX(param1:FurnitureInfo, param2:FurnitureInfo) : Number
      {
         if(param1.posY < param2.posY)
         {
            return -1;
         }
         if(param1.posY > param2.posY)
         {
            return 1;
         }
         if(param1.posX < param2.posX)
         {
            return -1;
         }
         if(param1.posX > param2.posX)
         {
            return 1;
         }
         return 0;
      }
      
      private static function lookAheadInverse(param1:FurnitureInfo = null) : FurnitureInfo
      {
         var _loc2_:FurnitureInfo = null;
         var _loc3_:int = 0;
         if(sortList && sortList.length > 0)
         {
            if(!param1)
            {
               _loc2_ = sortList.splice(_loc3_,1)[0];
               position = _loc3_;
            }
            else
            {
               _loc3_ = position;
               while(_loc3_ < sortList.length)
               {
                  _loc2_ = sortList[_loc3_];
                  if(_loc2_.posY >= param1.posY + param1.height)
                  {
                     _loc2_ = null;
                     break;
                  }
                  if(_loc2_.posX > param1.posX)
                  {
                     _loc2_ = sortList.splice(_loc3_,1)[0];
                     position = _loc3_;
                     break;
                  }
                  _loc2_ = null;
                  _loc3_++;
               }
            }
         }
         return _loc2_;
      }
      
      private static function sortByPosYAndPosXInverse(param1:FurnitureInfo, param2:FurnitureInfo) : Number
      {
         if(param1.posY < param2.posY)
         {
            return -1;
         }
         if(param1.posY > param2.posY)
         {
            return 1;
         }
         if(param1.posX > param2.posX)
         {
            return -1;
         }
         if(param1.posX < param2.posX)
         {
            return 1;
         }
         return 0;
      }
      
      private static function filterLeftWall(param1:FurnitureInfo, param2:int, param3:Vector.<FurnitureInfo>) : Boolean
      {
         return param1.area == 1 ? true : false;
      }
      
      private static function filterRightWall(param1:FurnitureInfo, param2:int, param3:Vector.<FurnitureInfo>) : Boolean
      {
         return param1.area == 2 ? true : false;
      }
      
      private static function filterFloor(param1:FurnitureInfo, param2:int, param3:Vector.<FurnitureInfo>) : Boolean
      {
         return param1.area == 0 ? true : false;
      }
      
      private static function filterNeedSort(param1:FurnitureInfo, param2:int, param3:Vector.<FurnitureInfo>) : Boolean
      {
         return !isOthers(param1);
      }
      
      private static function isOthers(param1:FurnitureInfo) : Boolean
      {
         var _loc2_:FurnitureTempInfo = null;
         if(param1)
         {
            if(inHome)
            {
               return false;
            }
            _loc2_ = TempleteManager.instance.furnitureTemplateCate.getTempById(param1.templateId);
            if(_loc2_.Type == 3 || _loc2_.Type == 9 || _loc2_.Type == 1 || _loc2_.Type == 2)
            {
               return true;
            }
         }
         return false;
      }
      
      private static function get inHome() : Boolean
      {
         return WorldBossHelper.checkInHome(CampaignManager.instance.mapId);
      }
      
      private static function get inHouse() : Boolean
      {
         return WorldBossHelper.checkInHouse(CampaignManager.instance.mapId);
      }
   }
}

