package mvc.module.skyboxroad
{
   import flash.events.EventDispatcher;
   import yishi.manager.TempleteManager;
   import yishi.utils.MsgMan;
   
   public class SkyboxRoadModel extends EventDispatcher
   {
      
      public static const TOLLGATE_PER_FLOOR:int = 10;
      
      public static const FLOOR_STR:Array = [undefined,"Ⅰ","Ⅱ","Ⅲ","Ⅳ","Ⅴ","Ⅵ","Ⅶ","Ⅷ","Ⅸ","Ⅹ"];
      
      private var _toptLayer:int = 0;
      
      public var currentPortalId:int;
      
      private var _lastLayer:int;
      
      public var isPageChange:Boolean = false;
      
      public var skyTrialInfo:SkyTrialInfo;
      
      public var portalRewardArray:Array = [];
      
      public var currentEventId:int;
      
      public var callHelper:Boolean = false;
      
      public var cleanPortalId:int;
      
      public var myRank:SkyboxRoadRankInfo;
      
      public var dayRankList:Array;
      
      public var weekRankList:Array;
      
      public var curPointList:Array;
      
      public var isOccpPoint:Boolean;
      
      public function SkyboxRoadModel()
      {
         super();
         skyTrialInfo = new SkyTrialInfo();
         if(dayRankList == null)
         {
            dayRankList = [];
         }
         if(weekRankList == null)
         {
            weekRankList = [];
         }
         if(curPointList == null)
         {
            curPointList = [];
         }
         TempleteManager.instance.skyBoxRoadTimeRewardTempCate.getTemplates();
      }
      
      public function get lastLayer() : int
      {
         return _lastLayer;
      }
      
      public function set lastLayer(param1:int) : void
      {
         _lastLayer = param1;
      }
      
      public function get toptLayer() : int
      {
         return _toptLayer;
      }
      
      public function set toptLayer(param1:int) : void
      {
         _toptLayer = param1;
      }
      
      public function get currentLayer() : int
      {
         if(lastLayer == 0)
         {
            lastLayer = toptLayer;
         }
         return lastLayer;
      }
      
      public function leaveScene() : void
      {
         isPageChange = false;
         callHelper = false;
      }
      
      public function getCurrentLayerInfo() : SkyTrialLayerInfo
      {
         return skyTrialInfo.getLayerInfoByLayerNum(currentLayer);
      }
      
      public function showRankListByType(param1:int) : Array
      {
         if(param1 == 0)
         {
            return dayRankList;
         }
         if(param1 == 1)
         {
            return weekRankList;
         }
         return [];
      }
      
      public function getPointInfoByIndex(param1:int) : SkyBoxRoadPointInfo
      {
         for each(var _loc2_:SkyBoxRoadPointInfo in curPointList)
         {
            if(_loc2_.posIndex == param1)
            {
               return _loc2_;
            }
         }
         return null;
      }
      
      public function updateRanklist() : void
      {
         MsgMan.notifyObserver("SKYBOX_ROAD_RANK_UPDATE");
      }
      
      public function updateOccupyList() : void
      {
         MsgMan.notifyObserver("SKYBOX_ROAD_OCCUPYLIST_UPDATE");
      }
   }
}

