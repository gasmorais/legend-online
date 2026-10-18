package managers
{
   import battle.utils.Int64Utils;
   import com.road.yishi.proto.pet.NavigationBoatMsg;
   import com.road.yishi.proto.pet.NavigationBuyDataMsg;
   import com.road.yishi.proto.pet.NavigationFishingStateMsg;
   import com.road.yishi.proto.pet.NavigationMsg;
   import com.road.yishi.proto.pet.NavigationOpMsg;
   import com.road.yishi.proto.pet.NavigationPortMsg;
   import com.road.yishi.proto.pet.NavigationResMsg;
   import mvc.module.mounts.MountShopInfo;
   import mvc.module.navigation.NavigationBoatInfo;
   import mvc.module.navigation.NavigationModel;
   import mvc.module.navigation.NavigationPortInfo;
   import yishi.comm.PackageIn;
   import yishi.comm.PackageOut;
   import yishi.events.SLGSocketEvent;
   import yishi.service.managers.SocketManager;
   import yishi.service.managers.SocketSendManager;
   import yishi.utils.MsgMan;
   
   public class NavigationManager
   {
      
      private static var _instance:NavigationManager;
      
      private var _model:NavigationModel;
      
      public function NavigationManager()
      {
         super();
      }
      
      public static function get instance() : NavigationManager
      {
         if(!_instance)
         {
            _instance = new NavigationManager();
         }
         return _instance;
      }
      
      public function get model() : NavigationModel
      {
         return _model;
      }
      
      public function setup() : void
      {
         if(!_model)
         {
            _model = new NavigationModel();
         }
         addEvent();
      }
      
      private function addEvent() : void
      {
         SocketManager.instance.addEventListener("SLGSocketEvent" + 341,__updateNavigationOpState);
         SocketManager.instance.addEventListener("SLGSocketEvent" + 342,__updateNavigationData);
         SocketManager.instance.addEventListener("SLGSocketEvent" + 178,__updateNavigationFishState);
      }
      
      private function __updateNavigationOpState(param1:SLGSocketEvent) : void
      {
         var _loc3_:PackageIn = param1.data as PackageIn;
         var _loc2_:NavigationResMsg = new NavigationResMsg();
         _loc2_ = _loc3_.readBody(_loc2_) as NavigationResMsg;
         if(_loc2_.hasOp)
         {
            if(_loc2_.op == 11 || _loc2_.op == 16)
            {
               MsgMan.notifyObserver("NAVIGATION_PATROL_CLOSE");
            }
            model.op = _loc2_.op;
         }
      }
      
      private function __updateNavigationFishState(param1:SLGSocketEvent) : void
      {
         var _loc3_:PackageIn = param1.data as PackageIn;
         var _loc2_:NavigationFishingStateMsg = new NavigationFishingStateMsg();
         _loc2_ = _loc3_.readBody(_loc2_) as NavigationFishingStateMsg;
         if(_loc2_.hasOpen)
         {
            model.fishOpen = _loc2_.open;
         }
         MsgMan.notifyObserver("FISHING_STATE_CHANGE");
      }
      
      private function __updateNavigationData(param1:SLGSocketEvent) : void
      {
         var _loc5_:MountShopInfo = null;
         var _loc7_:NavigationPortInfo = null;
         var _loc9_:NavigationBoatInfo = null;
         var _loc10_:PackageIn = param1.data as PackageIn;
         var _loc2_:NavigationMsg = new NavigationMsg();
         _loc2_ = _loc10_.readBody(_loc2_) as NavigationMsg;
         if(_loc2_.hasStrength)
         {
            model.strength = _loc2_.strength;
         }
         if(_loc2_.hasCurrency)
         {
            model.currency = _loc2_.currency;
         }
         if(_loc2_.hasDayBuyShopNum)
         {
            model.hasBuyShopNum = _loc2_.dayBuyShopNum;
         }
         if(_loc2_.hasDayBuyStrengthNum)
         {
            model.hasBuyStrengthNum = _loc2_.dayBuyStrengthNum;
         }
         if(_loc2_.hasShopRefreshCD)
         {
            model.shopRefreshTime = Int64Utils.int64ToNumber(_loc2_.shopRefreshCD) / 1000;
         }
         if(_loc2_.hasInviteNum)
         {
            model.hasInviteNum = _loc2_.inviteNum;
         }
         if(_loc2_.hasAssistNum)
         {
            model.hasAssistNum = _loc2_.assistNum;
         }
         if(_loc2_.hasFishingTime)
         {
            model.hasFishingTime = _loc2_.fishingTime;
         }
         if(_loc2_.fishingTipsList.length > 0)
         {
            for each(var _loc8_:String in _loc2_.fishingTipsList)
            {
               model.fishRewardList.push(_loc8_);
            }
         }
         if(_loc2_.buyData)
         {
            model.shopList = [];
            for each(var _loc4_:NavigationBuyDataMsg in _loc2_.buyData)
            {
               _loc5_ = new MountShopInfo();
               _loc5_.index = _loc4_.index;
               _loc5_.tempId = _loc4_.shopId;
               _loc5_.isCanBuy = _loc4_.buy;
               model.shopList.push(_loc5_);
            }
            model.shopList.sortOn("index",16);
         }
         if(_loc2_.port)
         {
            model.portList = [];
            for each(var _loc3_:NavigationPortMsg in _loc2_.port)
            {
               _loc7_ = new NavigationPortInfo();
               _loc7_.portId = _loc3_.id;
               _loc7_.taskId1 = _loc3_.taskId1;
               _loc7_.taskId2 = _loc3_.taskId2;
               _loc7_.taskId3 = _loc3_.taskId3;
               _loc7_.taskId4 = _loc3_.taskId4;
               _loc7_.taskId5 = _loc3_.taskId5;
               _loc7_.taskId6 = _loc3_.taskId6;
               _loc7_.portCd = Int64Utils.int64ToNumber(_loc3_.cd) / 1000;
               _loc7_.boatId = _loc3_.shippingBoatId;
               _loc7_.selectedTask1 = _loc3_.selectedTask1;
               _loc7_.selectedTask2 = _loc3_.selectedTask2;
               _loc7_.selectedTask3 = _loc3_.selectedTask3;
               _loc7_.selectedTask4 = _loc3_.selectedTask4;
               _loc7_.selectedTask5 = _loc3_.selectedTask5;
               _loc7_.selectedTask6 = _loc3_.selectedTask6;
               _loc7_.taskNum1 = _loc3_.taskNum1;
               _loc7_.taskNum2 = _loc3_.taskNum2;
               _loc7_.taskNum3 = _loc3_.taskNum3;
               _loc7_.taskNum4 = _loc3_.taskNum4;
               _loc7_.taskNum5 = _loc3_.taskNum5;
               _loc7_.taskNum6 = _loc3_.taskNum6;
               _loc7_.payBusinessNum = _loc3_.payBusinessNum;
               _loc7_.grades = _loc3_.grades;
               model.portList.push(_loc7_);
            }
            model.portList.sortOn("portId");
         }
         if(_loc2_.boat)
         {
            model.boatList = [];
            for each(var _loc6_:NavigationBoatMsg in _loc2_.boat)
            {
               _loc9_ = new NavigationBoatInfo();
               _loc9_.boatId = _loc6_.id;
               _loc9_.grade = _loc6_.grade;
               _loc9_.state = _loc6_.state;
               _loc9_.boatCd = Int64Utils.int64ToNumber(_loc6_.cd) / 1000;
               model.boatList.push(_loc9_);
            }
            model.boatList.sortOn("boatId");
         }
         MsgMan.notifyObserver("NAVIGATION_DATA_CHANGE");
      }
      
      public function sendNavigationOperate(param1:int, param2:String, param3:String, param4:int = 0, param5:int = 0, param6:Array = null, param7:Array = null) : void
      {
         var _loc9_:PackageOut = new PackageOut(9600);
         var _loc8_:NavigationOpMsg = new NavigationOpMsg();
         _loc8_.op = param1;
         _loc8_.param1 = param2;
         _loc8_.param2 = param3;
         _loc8_.param3 = param4;
         _loc8_.param4 = param5;
         if(param6 != null)
         {
            _loc8_.param5 = param6;
         }
         if(param7 != null)
         {
            _loc8_.param6 = param7;
         }
         SocketSendManager.instance.sendProtoBuffer(_loc9_,_loc8_);
      }
   }
}

