package managers
{
   import com.road.yishi.proto.player.PlayerOpMsg;
   import com.road.yishi.proto.theseusdungeon.TaskMsg;
   import com.road.yishi.proto.theseusdungeon.TheseusDungeonUserMsg;
   import mvc.module.theseus.dungeon.TheseusDungeonModel;
   import yishi.comm.PackageIn;
   import yishi.comm.PackageOut;
   import yishi.events.NotificationEvent;
   import yishi.events.SLGSocketEvent;
   import yishi.manager.NotificationManager;
   import yishi.service.managers.SocketManager;
   
   public class DungeonExploManager
   {
      
      private static var _instance:DungeonExploManager;
      
      public static const ACTION_OPEN_INTERFACE:int = 1;
      
      public static const ACTION_ENTER_NEXT_FLOOR:int = 2;
      
      public static const ACTION_CLICK_BLOCK:int = 3;
      
      public static const ACTION_ACTIVATE_EVENT:int = 4;
      
      public static const ACTION_BUY_ENERGY:int = 5;
      
      public static const ACTION_TASK_FINISHED:int = 6;
      
      private var _model:TheseusDungeonModel;
      
      public function DungeonExploManager()
      {
         super();
      }
      
      public static function get instance() : DungeonExploManager
      {
         if(!_instance)
         {
            _instance = new DungeonExploManager();
         }
         return _instance;
      }
      
      public function get model() : TheseusDungeonModel
      {
         return _model;
      }
      
      public function setup() : void
      {
         if(!_model)
         {
            _model = new TheseusDungeonModel();
         }
         addEvent();
      }
      
      private function addEvent() : void
      {
         SocketManager.instance.addEventListener("SLGSocketEvent" + 779,__moneyReturnStateHandler);
         SocketManager.instance.addEventListener("SLGSocketEvent" + 780,__taskStateHandler);
      }
      
      private function __taskStateHandler(param1:SLGSocketEvent) : void
      {
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         var _loc5_:PackageIn = param1.data as PackageIn;
         var _loc2_:TaskMsg = new TaskMsg();
         _loc2_ = _loc5_.readBody(_loc2_) as TaskMsg;
         if(_model.tasks.length > 0)
         {
            _loc3_ = 0;
            while(_loc3_ < _model.tasks.length)
            {
               _loc4_ = 0;
               while(_loc4_ < _loc2_.tasks.length)
               {
                  if(_loc2_.tasks[_loc4_].taskId == _model.tasks[_loc3_].taskId)
                  {
                     _model.tasks[_loc3_] = _loc2_.tasks[_loc4_];
                  }
                  _loc4_++;
               }
               _loc3_++;
            }
         }
         else
         {
            _model.tasks = _loc2_.tasks;
         }
         NotificationManager.instance.sendNotification("THESEUS_DUNGEON_TASK_DATA",_model.tasks);
      }
      
      private function __moneyReturnStateHandler(param1:SLGSocketEvent) : void
      {
         var _loc3_:int = 0;
         var _loc4_:PackageIn = param1.data as PackageIn;
         var _loc2_:TheseusDungeonUserMsg = new TheseusDungeonUserMsg();
         _loc2_ = _loc4_.readBody(_loc2_) as TheseusDungeonUserMsg;
         _model.freeActionNum = _loc2_.freeActionNum;
         _model.buyActionNum = _loc2_.buyActionNum;
         _model.blockInfo = _loc2_.blockInfo;
         if(_loc2_.blockInfo.length == 15)
         {
            _loc3_ = int(_loc2_.blockInfo.length);
            while(_loc3_ > 0)
            {
               _model.blockInfo.splice(_loc3_,0,null,null,null,null);
               _loc3_ -= 5;
            }
            _model.blockInfo.unshift(null,null,null,null,null,null,null,null,null,null,null);
            _model.blockInfo.push(null,null,null,null,null);
         }
         if(_loc2_.blockInfo.length == 25)
         {
            _loc3_ = int(_loc2_.blockInfo.length);
            while(_loc3_ > 0)
            {
               _model.blockInfo.splice(_loc3_,0,null,null,null,null);
               _loc3_ -= 5;
            }
            _model.blockInfo.unshift(null,null);
            _model.blockInfo.splice(_model.blockInfo.length - 2,2);
         }
         _model.dayPurchasableActionNum = _loc2_.dayPurchasableActionNum;
         _model.skillIdList = _loc2_.skillIdList;
         _model.level = _loc2_.level;
         NotificationManager.instance.dispatchEvent(new NotificationEvent("THESEUS_DUNGEON_DATA"));
      }
      
      public function sendDungeonOperate(param1:int, param2:int = 0, param3:int = 0, param4:int = 0) : void
      {
         var _loc6_:PackageOut = new PackageOut(9763);
         var _loc5_:PlayerOpMsg = new PlayerOpMsg();
         _loc5_.op = param1;
         _loc5_.pos = param2;
         _loc5_.templateId = param3;
         _loc5_.count = param4;
         SocketManager.instance.socket.sendProtobuffer(_loc6_,_loc5_);
      }
   }
}

