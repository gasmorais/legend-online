package managers
{
   import com.road.yishi.proto.player.PlayerOpMsg;
   import com.road.yishi.proto.simple.PropertyMsg;
   import mvc.module.question.QuestionModel;
   import yishi.comm.PackageIn;
   import yishi.comm.PackageOut;
   import yishi.events.SLGSocketEvent;
   import yishi.manager.NotificationManager;
   import yishi.service.managers.SocketManager;
   import yishi.utils.MsgMan;
   
   public class QuestionManager
   {
      
      private static var _instance:QuestionManager;
      
      private var _model:QuestionModel;
      
      public function QuestionManager()
      {
         super();
         setup();
      }
      
      public static function get instance() : QuestionManager
      {
         if(!_instance)
         {
            _instance = new QuestionManager();
         }
         return _instance;
      }
      
      public function get model() : QuestionModel
      {
         return _model;
      }
      
      public function setup() : void
      {
         if(!_model)
         {
            _model = new QuestionModel();
         }
         addEvent();
      }
      
      private function addEvent() : void
      {
         SocketManager.instance.addEventListener("SLGSocketEvent" + 4291,__updateQuestionData);
         SocketManager.instance.addEventListener("SLGSocketEvent" + 4590,__topBtnHandler);
      }
      
      private function __topBtnHandler(param1:SLGSocketEvent) : void
      {
         var _loc3_:PackageIn = param1.data as PackageIn;
         var _loc2_:PropertyMsg = new PropertyMsg();
         _loc2_ = _loc3_.readBody(_loc2_) as PropertyMsg;
         if(_loc2_.param1 == 4023)
         {
            model.isOpen = _loc2_.param7;
            model.openTime = _loc2_.param4;
            model.stopTime = _loc2_.param5;
            NotificationManager.instance.sendNotification("REFRESH_TOPTOOLS");
            MsgMan.notifyObserver("QUESTION_UPDATE");
         }
      }
      
      private function __updateQuestionData(param1:SLGSocketEvent) : void
      {
         var _loc3_:PackageIn = param1.data as PackageIn;
         var _loc2_:PropertyMsg = new PropertyMsg();
         _loc2_ = _loc3_.readBody(_loc2_) as PropertyMsg;
         if(_loc2_.hasParam4)
         {
            _model.selectedString = _loc2_.param4;
         }
         MsgMan.notifyObserver("QUESTION_UPDATE");
      }
      
      public function send(param1:String) : void
      {
         var _loc3_:PackageOut = new PackageOut(8673);
         var _loc2_:PlayerOpMsg = new PlayerOpMsg();
         _loc2_.param1 = param1;
         SocketManager.instance.socket.sendProtobuffer(_loc3_,_loc2_);
      }
   }
}

