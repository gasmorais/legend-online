package managers
{
   import com.road.yishi.proto.sqmemory.SqMemoryUserMsg;
   import mvc.module.sqmemory.SqmemoryUserInfo;
   import yishi.comm.PackageIn;
   import yishi.comm.PackageOut;
   import yishi.events.SLGSocketEvent;
   import yishi.manager.FrameControllerManager;
   import yishi.service.managers.SocketManager;
   
   public class SqMemoryManger
   {
      
      private static var _ins:SqMemoryManger;
      
      private var _userDataInfo:SqmemoryUserInfo;
      
      public var currSelectIdx:int = 0;
      
      public function SqMemoryManger()
      {
         super();
         _userDataInfo = new SqmemoryUserInfo();
      }
      
      public static function get Instance() : SqMemoryManger
      {
         if(_ins == null)
         {
            _ins = new SqMemoryManger();
         }
         return _ins;
      }
      
      public function setup() : void
      {
         SocketManager.instance.addEventListener("SLGSocketEvent" + 4321,__userDataInfosHandler);
      }
      
      private function __userDataInfosHandler(param1:SLGSocketEvent) : void
      {
         var _loc3_:PackageIn = param1.data as PackageIn;
         var _loc2_:SqMemoryUserMsg = new SqMemoryUserMsg();
         _loc2_ = _loc3_.readBody(_loc2_) as SqMemoryUserMsg;
         _userDataInfo.opType = _loc2_.opType;
         _userDataInfo.beginInfo = _loc2_.beginInfo;
         _userDataInfo.friendShipInfo = _loc2_.friendShipInfo;
         _userDataInfo.growthInfo = _loc2_.growthInfo;
         _userDataInfo.honourInfo = _loc2_.honourInfo;
         _userDataInfo.legendInfo = _loc2_.legendInfo;
         _userDataInfo.shareInfo = _loc2_.shareInfo;
         _userDataInfo.isReward = _loc2_.isReward;
         if(_loc2_.opType == 0)
         {
            FrameControllerManager.instance.openControllerByInfo("sqmemory");
         }
      }
      
      public function doSomething() : void
      {
         var _loc1_:PackageOut = new PackageOut(9716);
         SocketManager.instance.socket.sendProtobuffer(_loc1_,null);
      }
      
      public function get userDataInfo() : SqmemoryUserInfo
      {
         return _userDataInfo;
      }
   }
}

