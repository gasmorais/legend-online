package managers
{
   import com.road.yishi.proto.children.FurnitureMsg;
   import com.road.yishi.proto.children.HomeMsg;
   import map.campaign.CampaignManager;
   import mvc.module.home.FurnitureInfo;
   import mvc.module.home.HomeInfo;
   import mvc.module.home.HomeModel;
   import yishi.comm.PackageIn;
   import yishi.events.SLGSocketEvent;
   import yishi.service.managers.SocketManager;
   import yishi.utils.MsgMan;
   import yishi.utils.WorldBossHelper;
   
   public class HomeManager
   {
      
      private static var _instance:HomeManager;
      
      public static const Base_Wall:int = 101002;
      
      public static const Base_Floor:int = 202001;
      
      private var _model:HomeModel;
      
      public function HomeManager()
      {
         super();
         if(_model == null)
         {
            _model = new HomeModel();
         }
      }
      
      public static function get instance() : HomeManager
      {
         if(!_instance)
         {
            _instance = new HomeManager();
         }
         return _instance;
      }
      
      public function get model() : HomeModel
      {
         return _model;
      }
      
      public function setup() : void
      {
         initEvent();
      }
      
      private function initEvent() : void
      {
         SocketManager.instance.addEventListener("SLGSocketEvent" + 4753,__homeInfoHandler);
         SocketManager.instance.addEventListener("SLGSocketEvent" + 4757,__selectInfoHandler);
      }
      
      private function __selectInfoHandler(param1:SLGSocketEvent) : void
      {
         var _loc3_:PackageIn = param1.data as PackageIn;
         var _loc2_:HomeMsg = new HomeMsg();
         _loc2_ = _loc3_.readBody(_loc2_) as HomeMsg;
         if(_loc2_.userIdA == MarryManager.instance.model.selfMarryInfo.userId || _loc2_.userIdB == MarryManager.instance.model.selfMarryInfo.userId)
         {
            MsgMan.notifyObserver("ChildEvent.HOME_INFO");
         }
      }
      
      private function __homeInfoHandler(param1:SLGSocketEvent) : void
      {
         var _loc4_:FurnitureInfo = null;
         var _loc6_:FurnitureMsg = null;
         var _loc5_:int = 0;
         var _loc7_:PackageIn = param1.data as PackageIn;
         var _loc2_:HomeMsg = new HomeMsg();
         _loc2_ = _loc7_.readBody(_loc2_) as HomeMsg;
         if(_loc2_.tarUserId > 0)
         {
            model.masterId = _loc2_.tarUserId;
         }
         if(!model.homeDic[_loc2_.userIdA + "_" + _loc2_.userIdB])
         {
            for(var _loc9_:String in model.homeDic)
            {
               if(_loc9_.split("_").indexOf(_loc2_.userIdA + "") >= 0 && _loc2_.userIdA > 0 || _loc9_.split("_").indexOf(_loc2_.userIdB + "") >= 0 && _loc2_.userIdB > 0)
               {
                  delete model.homeDic[_loc9_];
               }
            }
            model.homeDic[_loc2_.userIdA + "_" + _loc2_.userIdB] = new HomeInfo();
         }
         var _loc8_:HomeInfo = model.homeDic[_loc2_.userIdA + "_" + _loc2_.userIdB];
         _loc8_.homeId = _loc2_.homeId;
         _loc8_.userIdA = _loc2_.userIdA;
         _loc8_.userIdB = _loc2_.userIdB;
         _loc8_.homeUserId = _loc2_.courUserid;
         _loc8_.homeName = _loc2_.courNickname;
         _loc8_.houseUserId = _loc2_.houseUserid;
         _loc8_.houseName = _loc2_.houseNickname;
         _loc8_.homeLv = _loc2_.courtyardGarde;
         _loc8_.houseLv = _loc2_.houseGrade;
         _loc8_.furnitureId = _loc2_.randomId;
         _loc8_.state = _loc2_.state;
         _loc8_.cleanness = _loc2_.cleanness;
         _loc8_.maidDate = _loc2_.maidExpireDate;
         _loc8_.layList1.splice(0,_loc8_.layList1.length);
         _loc8_.storeList1.splice(0,_loc8_.storeList1.length);
         var _loc10_:Boolean = false;
         var _loc3_:Boolean = false;
         _loc5_ = 0;
         while(_loc5_ < _loc2_.furniture.length)
         {
            _loc6_ = _loc2_.furniture[_loc5_] as FurnitureMsg;
            if(_loc6_)
            {
               _loc4_ = new FurnitureInfo();
               _loc4_.furnitureId = _loc6_.id;
               _loc4_.templateId = _loc6_.templateId;
               _loc4_.posX = _loc6_.posX;
               _loc4_.posY = _loc6_.posY;
               _loc4_.rotation = _loc6_.rotation;
               if(_loc6_.posX >= 0 && _loc6_.posY >= 0)
               {
                  _loc8_.layList1.push(_loc4_);
                  if(_loc4_.templateInfo.Type == 1)
                  {
                     _loc10_ = true;
                  }
                  if(_loc4_.templateInfo.Type == 2)
                  {
                     _loc3_ = true;
                  }
               }
               else
               {
                  _loc8_.storeList1.push(_loc4_);
                  if(isNewId(_loc4_) && inHouse)
                  {
                     model.noFixList.push(_loc4_);
                  }
               }
            }
            _loc5_++;
         }
         if(!_loc10_)
         {
            _loc5_ = 0;
            while(_loc5_ < _loc8_.storeList1.length)
            {
               if(_loc8_.storeList1[_loc5_].templateId == 101002)
               {
                  _loc4_ = _loc8_.storeList1.splice(_loc5_,1)[0];
                  _loc4_.posX = 0;
                  _loc4_.posY = 0;
                  _loc8_.layList1.push(_loc4_);
                  break;
               }
               _loc5_++;
            }
         }
         if(!_loc3_)
         {
            _loc5_ = 0;
            while(_loc5_ < _loc8_.storeList1.length)
            {
               if(_loc8_.storeList1[_loc5_].templateId == 202001)
               {
                  _loc4_ = _loc8_.storeList1.splice(_loc5_,1)[0];
                  _loc4_.posX = 0;
                  _loc4_.posY = 0;
                  _loc8_.layList1.push(_loc4_);
                  break;
               }
               _loc5_++;
            }
         }
         _loc8_.layList2.splice(0,_loc8_.layList2.length);
         _loc8_.storeList2.splice(0,_loc8_.storeList2.length);
         _loc5_ = 0;
         while(_loc5_ < _loc2_.courFurniture.length)
         {
            _loc6_ = _loc2_.courFurniture[_loc5_] as FurnitureMsg;
            if(_loc6_)
            {
               _loc4_ = new FurnitureInfo();
               _loc4_.furnitureId = _loc6_.id;
               _loc4_.templateId = _loc6_.templateId;
               _loc4_.posX = _loc6_.posX;
               _loc4_.posY = _loc6_.posY;
               _loc4_.rotation = _loc6_.rotation;
               if(_loc6_.posX >= 0 && _loc6_.posY >= 0)
               {
                  _loc8_.layList2.push(_loc4_);
               }
               else
               {
                  _loc8_.storeList2.push(_loc4_);
                  if(isNewId(_loc4_) && inHome)
                  {
                     model.noFixList.push(_loc4_);
                  }
               }
            }
            _loc5_++;
         }
         if(_loc2_.isRefresh)
         {
            model.inFixUp = false;
            MsgMan.notifyObserver("ChildEvent.FIX_CHANGE");
         }
         MsgMan.notifyObserver("ChildEvent.HOME_INFO");
      }
      
      private function isNewId(param1:FurnitureInfo) : Boolean
      {
         var _loc3_:int = 0;
         var _loc2_:Vector.<FurnitureInfo> = model.fixUpList.concat(model.noFixList);
         _loc3_ = 0;
         while(_loc3_ < _loc2_.length)
         {
            if(_loc2_[_loc3_].furnitureId == param1.furnitureId)
            {
               return false;
            }
            _loc3_++;
         }
         return true;
      }
      
      private function get inHome() : Boolean
      {
         return WorldBossHelper.checkInHome(CampaignManager.instance.mapId);
      }
      
      private function get inHouse() : Boolean
      {
         return WorldBossHelper.checkInHouse(CampaignManager.instance.mapId);
      }
   }
}

