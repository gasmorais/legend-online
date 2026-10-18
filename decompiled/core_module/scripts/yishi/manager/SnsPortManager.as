package yishi.manager
{
   import com.pickgliss.loader.data.LoaderInfo;
   import com.road.yishi.proto.player.SnsRspMsg;
   import yishi.comm.PackageIn;
   import yishi.datas.VersionSwitch;
   import yishi.events.SLGSocketEvent;
   import yishi.service.managers.SocketManager;
   
   public class SnsPortManager
   {
      
      private static var _Instance:SnsPortManager;
      
      public static var StartGame:int = 1;
      
      public static var Grade:int = 2;
      
      public static var JoinConsortia:int = 3;
      
      public static var lastAttack:int = 4;
      
      public static var MoveCastle:int = 5;
      
      public static var Home:int = 6;
      
      public static var AreaPass:int = 7;
      
      public static var Clifford:int = 8;
      
      public static var Star:int = 9;
      
      public static var Challage:int = 10;
      
      public function SnsPortManager()
      {
         super();
      }
      
      public static function get Instance() : SnsPortManager
      {
         if(!_Instance)
         {
            _Instance = new SnsPortManager();
         }
         return _Instance;
      }
      
      public function setup() : void
      {
         initEvent();
      }
      
      private function initEvent() : void
      {
         SocketManager.instance.addEventListener("SLGSocketEvent" + 4388,_snsPortHandler);
      }
      
      private function _snsPortHandler(param1:SLGSocketEvent) : void
      {
         if(!VersionSwitch.SNS_PORT || PathManager.info.SNSPATH == "")
         {
            return;
         }
         var _loc3_:PackageIn = param1.data as PackageIn;
         var _loc2_:SnsRspMsg = new SnsRspMsg();
         _loc2_ = _loc3_.readBody(_loc2_) as SnsRspMsg;
      }
      
      private function __onEventComplete(param1:LoaderInfo, param2:Object) : void
      {
      }
      
      private function __onLoadError(param1:LoaderInfo) : void
      {
      }
   }
}

