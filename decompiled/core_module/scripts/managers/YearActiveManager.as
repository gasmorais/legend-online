package managers
{
   import com.road.yishi.proto.activity.YearActivityMsg;
   import com.road.yishi.proto.player.PlayerOpMsg;
   import com.road.yishi.proto.simple.PropertyMsg;
   import mvc.module.year2023.YearActiveModel;
   import yishi.comm.PackageIn;
   import yishi.comm.PackageOut;
   import yishi.events.SLGSocketEvent;
   import yishi.manager.NotificationManager;
   import yishi.service.managers.SocketManager;
   import yishi.utils.DateFormatter;
   
   public class YearActiveManager
   {
      
      private static var _ins:YearActiveManager;
      
      public var isOpen:Boolean;
      
      public var openTime:String;
      
      public var stopTime:String;
      
      public var openDate:Date;
      
      public var stopDate:Date;
      
      public var isGamePassed:Boolean = false;
      
      private var _model:YearActiveModel;
      
      public function YearActiveManager()
      {
         super();
         _model = new YearActiveModel();
      }
      
      public static function get ins() : YearActiveManager
      {
         if(_ins == null)
         {
            _ins = new YearActiveManager();
         }
         return _ins;
      }
      
      public function get model() : YearActiveModel
      {
         return _model;
      }
      
      public function setup() : void
      {
         SocketManager.instance.addEventListener("SLGSocketEvent" + 551,__dataInfosHandler);
         SocketManager.instance.addEventListener("SLGSocketEvent" + 4590,__topBtnHandler);
      }
      
      private function __dataInfosHandler(param1:SLGSocketEvent) : void
      {
         var _loc3_:PackageIn = param1.data as PackageIn;
         var _loc2_:YearActivityMsg = new YearActivityMsg();
         _loc2_ = _loc3_.readBody(_loc2_) as YearActivityMsg;
         _model.opType = _loc2_.opType;
         _model.checkinInfo = _loc2_.checkinInfo;
         _model.buyCheckin = _loc2_.buyCheckin;
         _model.miniGameState = _loc2_.miniGameState;
         _model.boxInfo = _loc2_.boxInfo;
         _model.boxLevel = _loc2_.boxLevel;
         _model.boxNext = _loc2_.boxNext;
         _model.eggCount = _loc2_.eggCount;
         _model.showInfo = _loc2_.showInfo;
         _model.curDay = _loc2_.curDay;
         if(_model.miniGameState == 0)
         {
            isGamePassed = false;
         }
         NotificationManager.instance.sendNotification("EVENT_YEARACTIVITY_OP",_loc2_.opType);
      }
      
      private function __topBtnHandler(param1:SLGSocketEvent) : void
      {
         var _loc3_:PackageIn = param1.data as PackageIn;
         var _loc2_:PropertyMsg = new PropertyMsg();
         _loc2_ = _loc3_.readBody(_loc2_) as PropertyMsg;
         if(_loc2_.param1 == 2061)
         {
            isOpen = _loc2_.param7;
            openTime = _loc2_.param4;
            stopTime = _loc2_.param5;
            openDate = DateFormatter.parse(openTime,"YYYY-MM-DD hh:mm:ss");
            stopDate = DateFormatter.parse(openTime,"YYYY-MM-DD hh:mm:ss");
            NotificationManager.instance.sendNotification("REFRESH_TOPTOOLS");
         }
      }
      
      public function doSomething(param1:int, param2:int = -1) : void
      {
         var _loc4_:PackageOut = new PackageOut(9728);
         var _loc3_:PlayerOpMsg = new PlayerOpMsg();
         _loc3_.op = param1;
         _loc3_.id = param2;
         SocketManager.instance.socket.sendProtobuffer(_loc4_,_loc3_);
      }
   }
}

