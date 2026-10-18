package managers
{
   import com.road.yishi.proto.privilege.PrivilegeMsg;
   import flash.utils.Dictionary;
   import yishi.comm.PackageIn;
   import yishi.comm.PackageOut;
   import yishi.events.NotificationEvent;
   import yishi.events.SLGSocketEvent;
   import yishi.manager.NotificationManager;
   import yishi.service.managers.SocketManager;
   
   public class Bag360Manager
   {
      
      private static var _instance:Bag360Manager;
      
      private var _hasGetList:Array;
      
      private var _levelDic:Dictionary;
      
      public function Bag360Manager()
      {
         super();
      }
      
      public static function get instance() : Bag360Manager
      {
         if(!_instance)
         {
            _instance = new Bag360Manager();
         }
         return _instance;
      }
      
      public function setup() : void
      {
         initEvent();
         getBagState();
      }
      
      private function getBagState() : void
      {
         var _loc1_:PackageOut = new PackageOut(8723);
         SocketManager.instance.socket.sendProtobuffer(_loc1_,null);
      }
      
      private function initEvent() : void
      {
         SocketManager.instance.addEventListener("SLGSocketEvent" + 4543,__receiveBag360Handler);
      }
      
      private function __receiveBag360Handler(param1:SLGSocketEvent) : void
      {
         var _loc4_:int = 0;
         var _loc5_:PackageIn = param1.data as PackageIn;
         var _loc2_:PrivilegeMsg = new PrivilegeMsg();
         _loc2_ = _loc5_.readBody(_loc2_) as PrivilegeMsg;
         var _loc3_:int = int((_loc2_ as PrivilegeMsg).list.length);
         _hasGetList = [];
         _loc4_ = 0;
         while(_loc4_ < _loc3_)
         {
            _hasGetList.push((_loc2_ as PrivilegeMsg).list[_loc4_]);
            _loc4_++;
         }
         NotificationManager.instance.dispatchEvent(new NotificationEvent("RECEIVE_BAG_360"));
      }
      
      public function get allGet() : Boolean
      {
         return hasGetList.length >= 6;
      }
      
      public function get hasGetList() : Array
      {
         if(_hasGetList == null)
         {
            _hasGetList = [];
         }
         return _hasGetList;
      }
      
      public function get levelDic() : Dictionary
      {
         if(_levelDic == null)
         {
            _levelDic = new Dictionary();
            _levelDic[1] = 5;
            _levelDic[2] = 10;
            _levelDic[3] = 20;
            _levelDic[4] = 30;
            _levelDic[5] = 40;
            _levelDic[6] = 50;
         }
         return _levelDic;
      }
   }
}

