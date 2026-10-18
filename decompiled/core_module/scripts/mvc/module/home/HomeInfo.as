package mvc.module.home
{
   import flash.geom.Point;
   import map.campaign.CampaignManager;
   import map.campaign.data.CampaignMapModel;
   import yishi.utils.WorldBossHelper;
   
   public class HomeInfo
   {
      
      public var homeId:int;
      
      public var userIdA:int;
      
      public var userIdB:int;
      
      public var homeUserId:int;
      
      public var homeName:String;
      
      public var houseUserId:int;
      
      public var houseName:String;
      
      public var homeLv:int;
      
      public var houseLv:int;
      
      public var furnitureId:int;
      
      public var state:int;
      
      public var layList1:Vector.<FurnitureInfo>;
      
      public var storeList1:Vector.<FurnitureInfo>;
      
      public var layList2:Vector.<FurnitureInfo>;
      
      public var storeList2:Vector.<FurnitureInfo>;
      
      public var isGetA:Boolean;
      
      public var isGetB:Boolean;
      
      public var cleanness:int;
      
      public var maidDate:String;
      
      public function HomeInfo()
      {
         super();
         layList1 = new Vector.<FurnitureInfo>();
         layList2 = new Vector.<FurnitureInfo>();
         storeList1 = new Vector.<FurnitureInfo>();
         storeList2 = new Vector.<FurnitureInfo>();
      }
      
      public function get floor() : int
      {
         var _loc1_:int = 0;
         if(inHouse)
         {
            switch(houseLv)
            {
               case 0:
                  _loc1_ = 0;
                  break;
               case 1:
                  _loc1_ = 8;
                  break;
               case 2:
                  _loc1_ = 12;
            }
         }
         else if(inHome)
         {
            _loc1_ = Math.ceil((mapModel.mapTempInfo.Height + Math.tan(3.141592653589793 / 6) * mapModel.mapTempInfo.Width / 2) / 60);
         }
         return _loc1_;
      }
      
      public function get wall() : int
      {
         return 5;
      }
      
      public function get corner() : Point
      {
         var _loc1_:Point = new Point();
         if(inHouse)
         {
            switch(houseLv)
            {
               case 0:
                  _loc1_.x = 0;
                  _loc1_.y = 0;
                  break;
               case 1:
                  _loc1_.x = 506;
                  _loc1_.y = 482;
                  break;
               case 2:
                  _loc1_.x = 813;
                  _loc1_.y = 465;
            }
         }
         else if(inHome)
         {
            switch(homeLv)
            {
               case 0:
                  _loc1_.x = 0;
                  _loc1_.y = 0;
                  break;
               default:
                  _loc1_.x = mapModel.mapTempInfo.Width / 2;
                  _loc1_.y = 0;
            }
         }
         return _loc1_;
      }
      
      private function get inHome() : Boolean
      {
         return WorldBossHelper.checkInHome(CampaignManager.instance.mapId);
      }
      
      private function get inHouse() : Boolean
      {
         return WorldBossHelper.checkInHouse(CampaignManager.instance.mapId);
      }
      
      private function get mapModel() : CampaignMapModel
      {
         return CampaignManager.instance.mapModel;
      }
   }
}

