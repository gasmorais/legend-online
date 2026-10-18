package yishi.manager
{
   import com.road.yishi.proto.simple.DetailReqMsg;
   import com.road.yishi.proto.simple.InfoReqMsg;
   import yishi.comm.PackageOut;
   import yishi.service.managers.SocketManager;
   
   public class PlayerInfoManager
   {
      
      private static var _instance:PlayerInfoManager;
      
      private var _data:Object;
      
      public function PlayerInfoManager()
      {
         super();
         initEvent();
      }
      
      public static function get instance() : PlayerInfoManager
      {
         if(!_instance)
         {
            _instance = new PlayerInfoManager();
         }
         return _instance;
      }
      
      private function initEvent() : void
      {
      }
      
      public function get data() : Object
      {
         return _data;
      }
      
      public function show(param1:Object, param2:int = 0) : void
      {
         FrameControllerManager.instance.openControllerByInfo("playerinfo",null,{
            "d":param1,
            "op":param2
         });
      }
      
      public function sendRequestEquip(param1:int, param2:Boolean = false, param3:Boolean = false, param4:Boolean = false, param5:Boolean = false) : void
      {
         var _loc7_:PackageOut = new PackageOut(8199);
         var _loc6_:DetailReqMsg = new DetailReqMsg();
         _loc6_.otherId = param1;
         _loc6_.itemInfo = param2;
         _loc6_.heroInfo = param3;
         _loc6_.armyInfo = param4;
         _loc6_.pawnInfo = param5;
         SocketManager.instance.socket.sendProtobuffer(_loc7_,_loc6_);
      }
      
      public function sendRequestSimpleInfo(param1:int) : void
      {
         var _loc3_:PackageOut = new PackageOut(8200);
         var _loc2_:InfoReqMsg = new InfoReqMsg();
         _loc2_.otherId = param1;
         SocketManager.instance.socket.sendProtobuffer(_loc3_,_loc2_);
      }
      
      public function sendRequestSimpleInfoCross(param1:int, param2:String) : void
      {
         var _loc4_:PackageOut = new PackageOut(25097);
         var _loc3_:DetailReqMsg = new DetailReqMsg();
         _loc3_.userId = PlayerManager.instance.currentPlayerModel.playerInfo.userId;
         _loc3_.serverName = PlayerManager.instance.currentPlayerModel.playerInfo.serviceName;
         _loc3_.otherId = param1;
         _loc3_.otherName = param2;
         SocketManager.instance.socket.sendProtobuffer(_loc4_,_loc3_);
      }
   }
}

