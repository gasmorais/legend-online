package managers
{
   import com.road.yishi.proto.memorycard.NewMemoryCardMsg;
   import com.road.yishi.proto.player.PlayerOpMsg;
   import com.road.yishi.proto.simple.PropertyMsg;
   import mvc.module.newmemorycard.NewMemoryCardModel;
   import yishi.comm.PackageIn;
   import yishi.comm.PackageOut;
   import yishi.events.SLGSocketEvent;
   import yishi.manager.NotificationManager;
   import yishi.service.managers.SocketManager;
   import yishi.service.managers.SocketSendManager;
   import yishi.utils.MsgMan;
   
   public class NewMemoryCardManager
   {
      
      private static var _instance:NewMemoryCardManager;
      
      public static const OP_OPEN:int = 1;
      
      public static const OP_CHOOSE:int = 2;
      
      public static const OP_BUY:int = 3;
      
      public static const OP_REFRESH:int = 4;
      
      private var _model:NewMemoryCardModel;
      
      public function NewMemoryCardManager()
      {
         super();
         setup();
      }
      
      public static function get instance() : NewMemoryCardManager
      {
         if(!_instance)
         {
            _instance = new NewMemoryCardManager();
         }
         return _instance;
      }
      
      public function get model() : NewMemoryCardModel
      {
         return _model;
      }
      
      public function setup() : void
      {
         if(!_model)
         {
            _model = new NewMemoryCardModel();
         }
         addEvent();
      }
      
      private function addEvent() : void
      {
         SocketManager.instance.addEventListener("SLGSocketEvent" + 4301,__updateMemoryCardData);
         SocketManager.instance.addEventListener("SLGSocketEvent" + 4590,__topBtnHandler);
      }
      
      private function __topBtnHandler(param1:SLGSocketEvent) : void
      {
         var _loc3_:PackageIn = param1.data as PackageIn;
         var _loc2_:PropertyMsg = new PropertyMsg();
         _loc2_ = _loc3_.readBody(_loc2_) as PropertyMsg;
         if(_loc2_.param1 == 4024)
         {
            model.isOpen = _loc2_.param7;
            model.openTime = _loc2_.param4;
            model.stopTime = _loc2_.param5;
            NotificationManager.instance.sendNotification("REFRESH_TOPTOOLS");
         }
      }
      
      private function __updateMemoryCardData(param1:SLGSocketEvent) : void
      {
         var _loc3_:PackageIn = param1.data as PackageIn;
         var _loc2_:NewMemoryCardMsg = new NewMemoryCardMsg();
         _loc2_ = _loc3_.readBody(_loc2_) as NewMemoryCardMsg;
         if(_loc2_.hasOpType)
         {
            model.opType = _loc2_.opType;
         }
         if(_loc2_.hasFreeStep)
         {
            model.freeStep = _loc2_.freeStep;
         }
         if(_loc2_.hasBuyStep)
         {
            model.buyStep = _loc2_.buyStep;
         }
         if(_loc2_.hasBuyCount)
         {
            model.buyCount = _loc2_.buyCount;
         }
         if(_loc2_.hasDropInfo)
         {
            model.dropInfo = _loc2_.dropInfo;
         }
         if(_loc2_.hasPosInfo)
         {
            model.posInfo = _loc2_.posInfo;
         }
         if(_loc2_.hasSpecialInfo)
         {
            model.specialInfo = _loc2_.specialInfo;
         }
         if(_loc2_.hasCanRefresh)
         {
            model.canRefresh = _loc2_.canRefresh;
         }
         if(_loc2_.hasIsMatch)
         {
            model.isMatch = _loc2_.isMatch;
         }
         if(_loc2_.hasResult)
         {
            model.result = _loc2_.result;
         }
         MsgMan.notifyObserver("NEW_MEMORYCARD_UPDATE");
      }
      
      public function sendChoose() : void
      {
         var _loc2_:PackageOut = new PackageOut(8682);
         var _loc1_:PlayerOpMsg = new PlayerOpMsg();
         _loc1_.op = 2;
         _loc1_.value1 = model.clickIndexArr[0];
         _loc1_.value2 = model.clickIndexArr[1];
         SocketSendManager.instance.sendProtoBuffer(_loc2_,_loc1_);
      }
      
      public function send(param1:int) : void
      {
         var _loc3_:PackageOut = new PackageOut(8682);
         var _loc2_:PlayerOpMsg = new PlayerOpMsg();
         _loc2_.op = param1;
         SocketSendManager.instance.sendProtoBuffer(_loc3_,_loc2_);
      }
   }
}

