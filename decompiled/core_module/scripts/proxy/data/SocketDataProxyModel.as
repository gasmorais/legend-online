package proxy.data
{
   import flash.events.EventDispatcher;
   import flash.utils.Dictionary;
   import proxy.SocketDataProxyEventEvent;
   import yishi.events.SLGSocketEvent;
   
   public class SocketDataProxyModel extends EventDispatcher
   {
      
      private var _cacheData:Dictionary;
      
      public function SocketDataProxyModel()
      {
         super();
         _cacheData = new Dictionary(true);
      }
      
      public function addSocketData(param1:SocketDataProxyInfo, param2:String) : void
      {
         var _loc3_:Vector.<SocketDataProxyInfo> = _cacheData[param2];
         if(!_loc3_)
         {
            _loc3_ = new Vector.<SocketDataProxyInfo>();
         }
         _loc3_.push(param1);
         _cacheData[param2] = _loc3_;
      }
      
      public function getSceneSocketData(param1:String) : Vector.<SocketDataProxyInfo>
      {
         return _cacheData[param1] as Vector.<SocketDataProxyInfo>;
      }
      
      public function readSceneSocketData(param1:String) : void
      {
         var _loc3_:SocketDataProxyInfo = null;
         var _loc2_:Vector.<SocketDataProxyInfo> = getSceneSocketData(param1);
         if(_loc2_)
         {
            while(_loc2_.length > 0)
            {
               _loc3_ = _loc2_.shift();
               this.dispatchEvent(new SLGSocketEvent(_loc3_.event,_loc3_.data));
            }
         }
         this.dispatchEvent(new SocketDataProxyEventEvent("READ_SOCKET_DATA_OVEW",param1));
      }
      
      public function clearSceneSocketData(param1:String) : void
      {
         var _loc2_:Vector.<SocketDataProxyInfo> = getSceneSocketData(param1);
         if(_loc2_)
         {
            _loc2_.length = 0;
         }
      }
   }
}

