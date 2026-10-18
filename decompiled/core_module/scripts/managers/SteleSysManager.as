package managers
{
   import com.road.yishi.proto.player.PlayerOpMsg;
   import com.road.yishi.proto.stela.StelaDataMsg;
   import com.road.yishi.proto.stela.StelaMsg;
   import com.road.yishi.proto.stela.StelaRefreshMsg;
   import mvc.module.stele.StelesysInfo;
   import mvc.module.stele.StelesysModel;
   import mvc.module.stele.StelesysRefineInfo;
   import yishi.comm.PackageIn;
   import yishi.comm.PackageOut;
   import yishi.events.SLGSocketEvent;
   import yishi.manager.NotificationManager;
   import yishi.service.managers.SocketManager;
   
   public class SteleSysManager
   {
      
      private static var _ins:SteleSysManager;
      
      public static const OP_EDIT:int = 1;
      
      public static const OP_STRENGTH:int = 2;
      
      public static const OP_STEP:int = 3;
      
      public static const OP_REFRESH:int = 4;
      
      public static const OP_VIEW_REFRESH:int = 5;
      
      public static const OP_REPLACE:int = 6;
      
      public static const OP_ROLLBACK:int = 7;
      
      private var _model:StelesysModel;
      
      public function SteleSysManager()
      {
         super();
         _model = new StelesysModel();
      }
      
      public static function get Ins() : SteleSysManager
      {
         if(_ins == null)
         {
            _ins = new SteleSysManager();
         }
         return _ins;
      }
      
      public function get model() : StelesysModel
      {
         return _model;
      }
      
      public function setup() : void
      {
         SocketManager.instance.addEventListener("SLGSocketEvent" + 4279,__dataInfosHandler);
         SocketManager.instance.addEventListener("SLGSocketEvent" + 4280,__dataInfosHandler);
         SocketManager.instance.addEventListener("SLGSocketEvent" + 4281,__refineInfosHandler);
      }
      
      private function __refineInfosHandler(param1:SLGSocketEvent) : void
      {
         var _loc4_:PackageIn = param1.data as PackageIn;
         var _loc2_:StelaRefreshMsg = new StelaRefreshMsg();
         _loc2_ = _loc4_.readBody(_loc2_) as StelaRefreshMsg;
         var _loc3_:int = _loc2_.opType;
         var _loc5_:StelesysRefineInfo = new StelesysRefineInfo();
         _loc5_.stelaId = _loc2_.stelaId;
         _loc5_.skills = _loc2_.skills.concat();
         NotificationManager.instance.sendNotification("STELE_SYS_REFINE",[_loc3_,_loc5_]);
      }
      
      private function __dataInfosHandler(param1:SLGSocketEvent) : void
      {
         var _loc7_:StelesysInfo = null;
         var _loc6_:int = 0;
         var _loc5_:PackageIn = param1.data as PackageIn;
         var _loc2_:StelaMsg = new StelaMsg();
         _loc2_ = _loc5_.readBody(_loc2_) as StelaMsg;
         var _loc3_:int = _loc2_.opType;
         for each(var _loc4_:StelaDataMsg in _loc2_.datas)
         {
            _loc6_ = _loc4_.id;
            if(_loc4_.step == -1)
            {
               _loc7_ = _model.metralDic[_loc6_];
               if(_loc7_ == null)
               {
                  _loc7_ = new StelesysInfo();
                  _model.metralDic.add(_loc6_,_loc7_);
               }
               _loc7_.id = _loc6_;
               _loc7_.templateId = _loc4_.templateId;
               _loc7_.step = _loc4_.step;
               _loc7_.exp = _loc4_.exp;
               _loc7_.isExist = _loc4_.isExist;
               _loc7_.tempUse = 0;
            }
            else
            {
               _loc7_ = _model.infoDic[_loc6_];
               if(_loc7_ == null)
               {
                  _loc7_ = new StelesysInfo();
                  _model.infoDic.add(_loc6_,_loc7_);
               }
               _loc7_.id = _loc6_;
               _loc7_.templateId = _loc4_.templateId;
               _loc7_.pos = _loc4_.pos;
               _loc7_.step = _loc4_.step;
               _loc7_.level = _loc4_.level;
               _loc7_.exp = _loc4_.exp;
               _loc7_.totalExp = _loc4_.totalExp;
               _loc7_.skill1 = _loc4_.skill1;
               _loc7_.skill2 = _loc4_.skill2;
               _loc7_.skill3 = _loc4_.skill3;
               _loc7_.skill4 = _loc4_.skill4;
               _loc7_.skill5 = _loc4_.skill5;
               _loc7_.isExist = _loc4_.isExist;
               if(!_loc7_.isExist)
               {
                  _model.infoDic.del(_loc6_);
               }
               _loc7_.updateStelaAttInfo();
            }
         }
         NotificationManager.instance.sendNotification("STELE_SYS_UPDATA");
      }
      
      public function sendEquip(param1:int, param2:int) : void
      {
         var _loc4_:PackageOut = new PackageOut(8664);
         var _loc3_:PlayerOpMsg = new PlayerOpMsg();
         _loc3_.op = 1;
         _loc3_.id = param1;
         _loc3_.pos = param2;
         SocketManager.instance.socket.sendProtobuffer(_loc4_,_loc3_);
      }
      
      public function sendIntensify(param1:int, param2:String, param3:Array) : void
      {
         var _loc5_:PackageOut = new PackageOut(8664);
         var _loc4_:PlayerOpMsg = new PlayerOpMsg();
         _loc4_.op = 2;
         _loc4_.id = param1;
         _loc4_.param1 = param2;
         _loc4_.ids = param3;
         SocketManager.instance.socket.sendProtobuffer(_loc5_,_loc4_);
      }
      
      public function sendStep(param1:int, param2:Array) : void
      {
         var _loc4_:PackageOut = new PackageOut(8664);
         var _loc3_:PlayerOpMsg = new PlayerOpMsg();
         _loc3_.op = 3;
         _loc3_.id = param1;
         _loc3_.ids = param2;
         SocketManager.instance.socket.sendProtobuffer(_loc4_,_loc3_);
      }
      
      public function sendRefine(param1:int, param2:String) : void
      {
         var _loc4_:PackageOut = new PackageOut(8664);
         var _loc3_:PlayerOpMsg = new PlayerOpMsg();
         _loc3_.op = 4;
         _loc3_.id = param1;
         _loc3_.param1 = param2;
         SocketManager.instance.socket.sendProtobuffer(_loc4_,_loc3_);
      }
      
      public function sendGetRefine(param1:int) : void
      {
         var _loc3_:PackageOut = new PackageOut(8664);
         var _loc2_:PlayerOpMsg = new PlayerOpMsg();
         _loc2_.op = 5;
         _loc2_.id = param1;
         SocketManager.instance.socket.sendProtobuffer(_loc3_,_loc2_);
      }
      
      public function sendReplaceRefine(param1:int) : void
      {
         var _loc3_:PackageOut = new PackageOut(8664);
         var _loc2_:PlayerOpMsg = new PlayerOpMsg();
         _loc2_.op = 6;
         _loc2_.id = param1;
         SocketManager.instance.socket.sendProtobuffer(_loc3_,_loc2_);
      }
      
      public function sendRecycle(param1:Array) : void
      {
         var _loc3_:PackageOut = new PackageOut(8664);
         var _loc2_:PlayerOpMsg = new PlayerOpMsg();
         _loc2_.op = 7;
         _loc2_.ids = param1;
         SocketManager.instance.socket.sendProtobuffer(_loc3_,_loc2_);
      }
   }
}

