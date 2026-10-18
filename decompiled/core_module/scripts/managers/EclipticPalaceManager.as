package managers
{
   import com.road.yishi.proto.eclipticpalace.EclipticPalaceBossMsg;
   import com.road.yishi.proto.eclipticpalace.EclipticPalaceMsg;
   import com.road.yishi.proto.eclipticpalace.EclipticPalaceRewardRecordMsg;
   import com.road.yishi.proto.eclipticpalace.EclipticPalaceRouteMsg;
   import com.road.yishi.proto.player.CommonMsg;
   import mvc.module.eclipticpalace.EclipticPalaceBossInfo;
   import mvc.module.eclipticpalace.EclipticPalaceModel;
   import mvc.module.eclipticpalace.EclipticPalaceRouteInfo;
   import mvc.module.fundVein.RewardItemInfo;
   import yishi.comm.PackageIn;
   import yishi.comm.PackageOut;
   import yishi.events.SLGSocketEvent;
   import yishi.manager.PlayerManager;
   import yishi.service.managers.SocketManager;
   import yishi.service.managers.SocketSendManager;
   import yishi.utils.MsgMan;
   
   public class EclipticPalaceManager
   {
      
      private static var _instance:EclipticPalaceManager;
      
      private var _model:EclipticPalaceModel;
      
      public function EclipticPalaceManager()
      {
         super();
      }
      
      public static function get instance() : EclipticPalaceManager
      {
         if(_instance == null)
         {
            _instance = new EclipticPalaceManager();
         }
         return _instance;
      }
      
      public function get model() : EclipticPalaceModel
      {
         return _model;
      }
      
      public function setup() : void
      {
         if(!_model)
         {
            _model = new EclipticPalaceModel();
         }
         addEvent();
      }
      
      private function addEvent() : void
      {
         SocketManager.instance.addEventListener("SLGSocketEvent" + 173,__updateMsgBackHandler);
         SocketManager.instance.addEventListener("SLGSocketEvent" + 174,__updateRewardBackHandler);
      }
      
      private function __updateMsgBackHandler(param1:SLGSocketEvent) : void
      {
         var _loc3_:PackageIn = param1.data as PackageIn;
         var _loc2_:EclipticPalaceMsg = new EclipticPalaceMsg();
         _loc2_ = _loc3_.readBody(_loc2_) as EclipticPalaceMsg;
         if(_loc2_.hasCurrentLayer)
         {
            model.curLayer = _loc2_.currentLayer;
         }
         if(_loc2_.hasCurrentSpirit)
         {
            model.curSpirit = _loc2_.currentSpirit;
         }
         if(_loc2_.hasSelectedRoute)
         {
            model.selectedRoute = _loc2_.selectedRoute;
         }
         if(_loc2_.hasRecoverCountDown)
         {
            model.recoverCountDown = _loc2_.recoverCountDown;
            model.recoverEndTime = _loc2_.recoverCountDown + PlayerManager.instance.currentPlayerModel.sysCurTimeBySecond;
         }
         if(_loc2_.hasDeclineCountDown)
         {
            model.declineCountDown = _loc2_.declineCountDown;
            model.declineEndTime = _loc2_.declineCountDown + PlayerManager.instance.currentPlayerModel.sysCurTimeBySecond;
         }
         model.routeList = [];
         if(_loc2_.hasRoute1)
         {
            model.routeList.push(getRouteInfo(_loc2_.route1));
         }
         if(_loc2_.hasRoute2)
         {
            model.routeList.push(getRouteInfo(_loc2_.route2));
         }
         if(_loc2_.hasRoute3)
         {
            model.routeList.push(getRouteInfo(_loc2_.route3));
         }
         model.popEvent = false;
         if(_loc2_.hasPopEvent)
         {
            model.popEvent = _loc2_.popEvent;
         }
         model.setFightIndex();
         MsgMan.notifyObserver("ECLIPTIC_PALACE_INFO_CHANGE");
      }
      
      private function getRouteInfo(param1:EclipticPalaceRouteMsg) : EclipticPalaceRouteInfo
      {
         var _loc2_:EclipticPalaceBossInfo = null;
         var _loc4_:EclipticPalaceRouteInfo = new EclipticPalaceRouteInfo();
         _loc4_.guardJobType1 = param1.guardJobType1;
         _loc4_.guardJobType2 = param1.guardJobType2;
         _loc4_.skillId = param1.skillId;
         _loc4_.bossList = [];
         for each(var _loc3_:EclipticPalaceBossMsg in param1.bossList)
         {
            _loc2_ = new EclipticPalaceBossInfo();
            _loc2_.heroTempId = _loc3_.heroTempId;
            _loc2_.defeated = _loc3_.defeated;
            _loc2_.hiddenEvent = _loc3_.hiddenEvent;
            _loc4_.bossList.push(_loc2_);
         }
         return _loc4_;
      }
      
      private function __updateRewardBackHandler(param1:SLGSocketEvent) : void
      {
         var _loc5_:RewardItemInfo = null;
         var _loc4_:PackageIn = param1.data as PackageIn;
         var _loc2_:EclipticPalaceRewardRecordMsg = new EclipticPalaceRewardRecordMsg();
         _loc2_ = _loc4_.readBody(_loc2_) as EclipticPalaceRewardRecordMsg;
         model.rewardList = [];
         for each(var _loc3_:CommonMsg in _loc2_.itemList)
         {
            _loc5_ = new RewardItemInfo();
            _loc5_.tempId = _loc3_.param1;
            _loc5_.count = _loc3_.param2;
            model.rewardList.push(_loc5_);
         }
         MsgMan.notifyObserver("REWARD_GOODS_BACK");
      }
      
      public function sendEclipticPalaceRequest(param1:int, param2:int = 0) : void
      {
         var _loc4_:PackageOut = new PackageOut(5190);
         var _loc3_:CommonMsg = new CommonMsg();
         _loc3_.param1 = param1;
         _loc3_.param2 = param2;
         SocketSendManager.instance.sendProtoBuffer(_loc4_,_loc3_);
      }
   }
}

