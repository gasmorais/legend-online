package yishi.manager
{
   import com.road.yishi.proto.finalroad.FinalRoadChapterRspMsg;
   import com.road.yishi.proto.finalroad.FinalRoadGroupRspMsg;
   import com.road.yishi.proto.simple.PropertyMsg;
   import mvc.module.finalroad.FinalRoadModel;
   import yishi.comm.PackageIn;
   import yishi.comm.PackageOut;
   import yishi.events.SLGSocketEvent;
   import yishi.service.managers.SocketManager;
   import yishi.utils.MsgMan;
   
   public class FinalRoadManager
   {
      
      private static var _instance:FinalRoadManager;
      
      public static const OP_BUY:int = 0;
      
      public static const OP_ENTER:int = 1;
      
      public static const OP_CHALLENGE:int = 2;
      
      public static const OP_AGAIN:int = 3;
      
      public static const OP_GIVEUP:int = 4;
      
      private var _model:FinalRoadModel;
      
      public function FinalRoadManager()
      {
         super();
      }
      
      public static function get instance() : FinalRoadManager
      {
         if(!_instance)
         {
            _instance = new FinalRoadManager();
         }
         return _instance;
      }
      
      public function get model() : FinalRoadModel
      {
         return _model;
      }
      
      public function setup() : void
      {
         if(!_model)
         {
            _model = new FinalRoadModel();
         }
         addEvent();
      }
      
      private function addEvent() : void
      {
         SocketManager.instance.addEventListener("SLGSocketEvent" + 532,__finalRoadChapterHandler);
         SocketManager.instance.addEventListener("SLGSocketEvent" + 533,__finalRoadGroupHandler);
      }
      
      private function __finalRoadChapterHandler(param1:SLGSocketEvent) : void
      {
         var _loc3_:PackageIn = param1.data as PackageIn;
         var _loc2_:FinalRoadChapterRspMsg = new FinalRoadChapterRspMsg();
         _loc2_ = _loc3_.readBody(_loc2_) as FinalRoadChapterRspMsg;
         model.currentChapter = _loc2_.currentChapter;
         model.surplusChapterTimes = _loc2_.surplusChapterTimes;
         model.buyChapterTimes = _loc2_.buyChapterTimes;
         model.passChapterRecord = _loc2_.passChapterRecord;
         model.isOpen = _loc2_.isOpen;
         MsgMan.notifyObserver("FINALROAD_CHAPTER_UPDATE");
      }
      
      private function __finalRoadGroupHandler(param1:SLGSocketEvent) : void
      {
         var _loc3_:PackageIn = param1.data as PackageIn;
         var _loc2_:FinalRoadGroupRspMsg = new FinalRoadGroupRspMsg();
         _loc2_ = _loc3_.readBody(_loc2_) as FinalRoadGroupRspMsg;
         model.groupInfo.chapter = _loc2_.chapter;
         model.groupInfo.level = _loc2_.level;
         model.groupInfo.groupLevel = _loc2_.groupLevel;
         model.groupInfo.state = _loc2_.state;
         model.groupInfo.surplusLevelTimes = _loc2_.surplusLevelTimes;
         model.groupInfo.levelSkills = _loc2_.levelSkills;
         model.groupInfo.events = _loc2_.events;
         MsgMan.notifyObserver("FINALROAD_GROUP_UPDATE");
      }
      
      public function send(param1:int, param2:int = 0) : void
      {
         var _loc4_:PackageOut = new PackageOut(9711);
         var _loc3_:PropertyMsg = new PropertyMsg();
         _loc3_.param1 = param1;
         _loc3_.param2 = param2;
         SocketManager.instance.socket.sendProtobuffer(_loc4_,_loc3_);
      }
   }
}

