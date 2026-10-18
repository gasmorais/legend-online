package mvc.module.home
{
   import flash.geom.Point;
   import flash.utils.Dictionary;
   import map.campaign.CampaignManager;
   import yishi.datas.playerinfo.PlayerInfo;
   import yishi.datas.templates.UpgradeTemplateInfo;
   import yishi.manager.CursorManagerII;
   import yishi.manager.PlayerManager;
   import yishi.manager.TempleteManager;
   import yishi.utils.MsgMan;
   import yishi.utils.WorldBossHelper;
   
   public class HomeModel
   {
      
      private var _selectFurn:FurnitureInfo;
      
      private var _clickFurn:FurnitureInfo;
      
      public var inFixUp:Boolean;
      
      private var _inBuy:Boolean;
      
      public var fixUpList:Vector.<FurnitureInfo>;
      
      public var noFixList:Vector.<FurnitureInfo>;
      
      public var floorList:Array;
      
      public var leftList:Array;
      
      public var rightList:Array;
      
      public var masterId:int;
      
      public var homeDic:Dictionary;
      
      public var opPoint:Point;
      
      public var isChange:Boolean;
      
      public function HomeModel()
      {
         super();
         floorList = [];
         leftList = [];
         rightList = [];
         fixUpList = new Vector.<FurnitureInfo>();
         noFixList = new Vector.<FurnitureInfo>();
         homeDic = new Dictionary();
         opPoint = new Point();
      }
      
      public function get info() : HomeInfo
      {
         for(var _loc1_:String in homeDic)
         {
            if(_loc1_.split("_").indexOf(masterId + "") >= 0 && masterId > 0)
            {
               return homeDic[_loc1_];
            }
         }
         return new HomeInfo();
      }
      
      public function get selfInfo() : HomeInfo
      {
         for(var _loc1_:String in homeDic)
         {
            if(_loc1_.split("_").indexOf(playerInfo.userId + "") >= 0)
            {
               return homeDic[_loc1_];
            }
         }
         return new HomeInfo();
      }
      
      public function get inBuy() : Boolean
      {
         return _inBuy;
      }
      
      public function set inBuy(param1:Boolean) : void
      {
         _inBuy = param1;
         MsgMan.notifyObserver("ChildEvent.STORE_BUY");
      }
      
      public function get selectFurn() : FurnitureInfo
      {
         return _selectFurn;
      }
      
      public function set selectFurn(param1:FurnitureInfo) : void
      {
         _selectFurn = param1;
         if(_selectFurn)
         {
            CursorManagerII.instance.showFurniture(_selectFurn);
         }
         else
         {
            CursorManagerII.instance.resetCursor();
         }
      }
      
      public function get clickFurn() : FurnitureInfo
      {
         return _clickFurn;
      }
      
      public function set clickFurn(param1:FurnitureInfo) : void
      {
         _clickFurn = param1;
         MsgMan.notifyObserver("ChildEvent.FURN_CLICK");
      }
      
      public function get isSelf() : Boolean
      {
         return masterId == playerInfo.userId;
      }
      
      public function filterType(param1:int, param2:int) : Boolean
      {
         if(param1 <= 0 || param2 <= 0)
         {
            return true;
         }
         if(inHome)
         {
            return false;
         }
         var _loc3_:Boolean = true;
         switch(param1 - 1)
         {
            case 0:
            case 1:
               _loc3_ = true;
               break;
            case 2:
               _loc3_ = param2 != 3;
               break;
            case 3:
            case 4:
            case 5:
               if(param2 != 4 && param2 != 5 && param2 != 6)
               {
                  _loc3_ = true;
               }
               else
               {
                  _loc3_ = false;
               }
               break;
            case 6:
               if(param2 != 7)
               {
                  _loc3_ = true;
               }
               else
               {
                  _loc3_ = false;
               }
               break;
            case 7:
               if(param2 != 8)
               {
                  _loc3_ = true;
                  break;
               }
               _loc3_ = false;
               break;
            case 8:
               _loc3_ = param2 != 9;
         }
         return _loc3_;
      }
      
      public function get playerInfo() : PlayerInfo
      {
         return PlayerManager.instance.currentPlayerModel.playerInfo;
      }
      
      private function get inHome() : Boolean
      {
         return WorldBossHelper.checkInHome(CampaignManager.instance.mapId);
      }
      
      private function get inHouse() : Boolean
      {
         return WorldBossHelper.checkInHouse(CampaignManager.instance.mapId);
      }
      
      public function getCanSetMaxCountByFurnitureType(param1:int) : int
      {
         var _loc2_:int = 0;
         var _loc4_:Array = null;
         var _loc3_:UpgradeTemplateInfo = TempleteManager.instance.getTemplateByLevelAndType(selfInfo.houseLv,45);
         if(_loc3_)
         {
            _loc4_ = _loc3_.TemplateName.split(",");
            return int(parseInt(_loc4_[param1 - 1]));
         }
         return 0;
      }
      
      public function getCurHasCountByTempId(param1:int) : int
      {
         var _loc4_:int = 0;
         for each(var _loc2_:FurnitureInfo in selfInfo.layList1)
         {
            if(_loc2_.templateId == param1)
            {
               _loc4_++;
            }
         }
         for each(var _loc3_:FurnitureInfo in selfInfo.storeList1)
         {
            if(_loc3_.templateId == param1)
            {
               _loc4_++;
            }
         }
         return _loc4_;
      }
   }
}

