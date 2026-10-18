package managers
{
   import com.road.yishi.proto.active.SuperSigninCardReqMsg;
   import com.road.yishi.proto.active.SuperSigninCardRespMsg;
   import com.road.yishi.proto.active.SuperSigninRewardMsg;
   import com.road.yishi.proto.simple.PropertyMsg;
   import mvc.module.supersignincard.SuperSigninCardModel;
   import yishi.comm.PackageIn;
   import yishi.comm.PackageOut;
   import yishi.events.SLGSocketEvent;
   import yishi.manager.NotificationManager;
   import yishi.service.managers.SocketManager;
   import yishi.service.managers.SocketSendManager;
   import yishi.utils.MsgMan;
   
   public class SuperSigninCardManager
   {
      
      private static var _instance:SuperSigninCardManager;
      
      public static const OPEN_FRAME:int = 1;
      
      public static const BUY:int = 2;
      
      public static const RECEIVE:int = 3;
      
      public static const SIGNIN:int = 4;
      
      private var _model:SuperSigninCardModel;
      
      public function SuperSigninCardManager()
      {
         super();
      }
      
      public static function get instance() : SuperSigninCardManager
      {
         if(_instance == null)
         {
            _instance = new SuperSigninCardManager();
         }
         return _instance;
      }
      
      public function get model() : SuperSigninCardModel
      {
         return _model;
      }
      
      public function setup() : void
      {
         if(!_model)
         {
            _model = new SuperSigninCardModel();
         }
         addEvent();
      }
      
      private function addEvent() : void
      {
         SocketManager.instance.addEventListener("SLGSocketEvent" + 513,__updateSuperSigninCardMsg);
         SocketManager.instance.addEventListener("SLGSocketEvent" + 514,__updateSuperSigninCardTempMsg);
         SocketManager.instance.addEventListener("SLGSocketEvent" + 4590,__superSigninCardBtnHandler);
      }
      
      private function __superSigninCardBtnHandler(param1:SLGSocketEvent) : void
      {
         var _loc3_:PackageIn = param1.data as PackageIn;
         var _loc2_:PropertyMsg = new PropertyMsg();
         _loc2_ = _loc3_.readBody(_loc2_) as PropertyMsg;
         if(_loc2_.param1 == 2059)
         {
            model.isOpen = _loc2_.param7;
            model.openTime = _loc2_.param4;
            model.stopTime = _loc2_.param5;
            if(!model.isOpen)
            {
               model.stateDic.clear();
            }
            NotificationManager.instance.sendNotification("REFRESH_TOPTOOLS");
            MsgMan.notifyObserver("SUPER_SIGNIN_CARD_UPDATE");
         }
      }
      
      private function __updateSuperSigninCardMsg(param1:SLGSocketEvent) : void
      {
         var _loc3_:PackageIn = param1.data as PackageIn;
         var _loc2_:SuperSigninCardRespMsg = new SuperSigninCardRespMsg();
         _loc2_ = _loc3_.readBody(_loc2_) as SuperSigninCardRespMsg;
         model.refreshState(_loc2_.details);
         MsgMan.notifyObserver("SUPER_SIGNIN_CARD_UPDATE");
      }
      
      private function __updateSuperSigninCardTempMsg(param1:SLGSocketEvent) : void
      {
         var _loc3_:PackageIn = param1.data as PackageIn;
         var _loc2_:SuperSigninRewardMsg = new SuperSigninRewardMsg();
         _loc2_ = _loc3_.readBody(_loc2_) as SuperSigninRewardMsg;
         model.cardPrice = _loc2_.cardPrice;
         model.reSigninPrice = _loc2_.reSigninPrice;
         model.refreshTempData(_loc2_.temp);
         MsgMan.notifyObserver("SUPER_SIGNIN_CARD_TEMP_UPDATE");
      }
      
      public function sendRequest(param1:int, param2:int = 0) : void
      {
         var _loc4_:PackageOut = new PackageOut(9645,0,38);
         var _loc3_:SuperSigninCardReqMsg = new SuperSigninCardReqMsg();
         _loc3_.opType = param1;
         _loc3_.date = param2;
         SocketSendManager.instance.sendProtoBuffer(_loc4_,_loc3_);
      }
   }
}

