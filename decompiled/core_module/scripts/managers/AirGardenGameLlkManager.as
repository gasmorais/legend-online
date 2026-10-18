package managers
{
   import com.road.yishi.proto.linkgame.LinkGameMsg;
   import logging.LoggerSys;
   import manager.LanguageMgr;
   import mvc.module.llk.LlkDeleteData;
   import mvc.module.llk.LlkModel;
   import mvc.module.llk.LlkNodeData;
   import yishi.comm.PackageIn;
   import yishi.comm.PackageOut;
   import yishi.events.SLGSocketEvent;
   import yishi.manager.FrameControllerManager;
   import yishi.service.managers.SocketManager;
   import yishi.utils.MsgMan;
   import yishi.utils.SimpleAlertHelper;
   
   public class AirGardenGameLlkManager
   {
      
      private static var _instance:AirGardenGameLlkManager;
      
      public static const LLK_FRAME:String = "LLK_FRAME";
      
      public static const START:int = 1;
      
      public static const DELETE:int = 2;
      
      public static const USE_BOMB:int = 3;
      
      public static const RESET:int = 4;
      
      public static const CLOSE:int = 5;
      
      private var _model:LlkModel;
      
      public function AirGardenGameLlkManager()
      {
         super();
         _model = new LlkModel();
      }
      
      public static function get instance() : AirGardenGameLlkManager
      {
         if(!_instance)
         {
            _instance = new AirGardenGameLlkManager();
         }
         return _instance;
      }
      
      public static function llkOp(param1:int) : void
      {
         var _loc3_:PackageOut = new PackageOut(8859);
         var _loc2_:LinkGameMsg = new LinkGameMsg();
         _loc2_.opType = param1;
         SocketManager.instance.socket.sendProtobuffer(_loc3_,_loc2_);
      }
      
      public static function llkBuy(param1:int, param2:Boolean = true) : void
      {
         var _loc4_:PackageOut = new PackageOut(8859);
         var _loc3_:LinkGameMsg = new LinkGameMsg();
         _loc3_.opType = param1;
         _loc3_.param1 = param2 ? 0 : 1;
         SocketManager.instance.socket.sendProtobuffer(_loc4_,_loc3_);
      }
      
      public static function llkDelete(param1:LlkNodeData, param2:LlkNodeData) : void
      {
         var _loc4_:PackageOut = new PackageOut(8859);
         var _loc3_:LinkGameMsg = new LinkGameMsg();
         _loc3_.opType = 2;
         _loc3_.aX = param1.row;
         _loc3_.aY = param1.col;
         _loc3_.bX = param2.row;
         _loc3_.bY = param2.col;
         SocketManager.instance.socket.sendProtobuffer(_loc4_,_loc3_);
      }
      
      public function get model() : LlkModel
      {
         return _model;
      }
      
      public function setup() : void
      {
         SocketManager.instance.addEventListener("SLGSocketEvent" + 4736,__llkInfoHandler);
      }
      
      private function __llkInfoHandler(param1:SLGSocketEvent) : void
      {
         var _loc3_:Array = null;
         var _loc6_:int = 0;
         var _loc8_:int = 0;
         var _loc4_:String = null;
         var _loc10_:String = null;
         var _loc7_:String = null;
         var _loc5_:LlkDeleteData = null;
         var _loc9_:PackageIn = param1.data as PackageIn;
         var _loc2_:LinkGameMsg = new LinkGameMsg();
         _loc2_ = _loc9_.readBody(_loc2_) as LinkGameMsg;
         if(model.info.time <= 0)
         {
            model.info.time = _loc2_.time;
         }
         model.info.score = _loc2_.score;
         model.info.strength = _loc2_.strength;
         model.info.bombCount = _loc2_.bombCount;
         model.info.resetCount = _loc2_.resetCount;
         model.info.points = _loc2_.points;
         model.info.gate = _loc2_.tollgate;
         if(model.info.gate <= 0)
         {
            model.info.gate = 1;
         }
         if(_loc2_.reward)
         {
            _loc3_ = _loc2_.reward.split(",");
            _loc6_ = int(_loc3_[0]);
            _loc8_ = int(_loc3_[1]);
            _loc4_ = LanguageMgr.GetTranslation("AirGardenGame.hint3",_loc2_.score,_loc6_);
            _loc10_ = LanguageMgr.GetTranslation("public.prompt");
            _loc7_ = LanguageMgr.GetTranslation("public.confirm");
            SimpleAlertHelper.instance.popAlerFrame(_loc10_,_loc4_,_loc7_,"",false,false,false,1);
         }
         if(_loc2_.aX > 0 && _loc2_.aY > 0 && _loc2_.bX > 0 && _loc2_.bY > 0)
         {
            _loc5_ = new LlkDeleteData();
            _loc5_.node1.row = _loc2_.aX;
            _loc5_.node1.col = _loc2_.aY;
            _loc5_.node1.val = _loc2_.pointValue;
            _loc5_.node2.row = _loc2_.bX;
            _loc5_.node2.col = _loc2_.bY;
            _loc5_.node2.val = _loc2_.pointValue;
            _loc5_.combCount = _loc2_.combCount;
            _loc5_.addScore = _loc2_.addScore;
            model.info.deleteList.push(_loc5_);
         }
         _loc3_ = [];
         if(model.info.points)
         {
            _loc3_ = model.info.points.split(",");
         }
         if(_loc3_.length == LlkModel.ROW * LlkModel.COLUMN)
         {
            updateList(_loc3_);
         }
         else if(_loc3_.length > 0)
         {
            LoggerSys.info(LanguageMgr.GetTranslation("llk.view.LlkFrame.title") + _loc2_.points);
         }
         MsgMan.notifyObserver(LlkModel.LLK_INFO,null);
      }
      
      private function updateList(param1:Array) : void
      {
         var _loc2_:int = 0;
         _loc2_ = 0;
         while(_loc2_ < LlkModel.ROW * LlkModel.COLUMN)
         {
            model.list[_loc2_].val = param1[_loc2_];
            _loc2_++;
         }
      }
      
      public function opLlkFrame() : void
      {
         FrameControllerManager.instance.openControllerByInfo("llk","LLK_FRAME");
      }
   }
}

