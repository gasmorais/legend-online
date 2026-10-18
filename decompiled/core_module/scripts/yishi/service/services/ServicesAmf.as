package yishi.service.services
{
   import flash.events.NetStatusEvent;
   import flash.net.NetConnection;
   
   public class ServicesAmf
   {
      
      private var _endPoint:String;
      
      private var _destination:String = "ServerRequest";
      
      private var _netConnection:NetConnection;
      
      public function ServicesAmf()
      {
         super();
         init();
      }
      
      private function init() : void
      {
         _netConnection = new NetConnection();
         _netConnection.client = this;
         _netConnection.addEventListener("netStatus",__netStatusHandler);
      }
      
      private function __netStatusHandler(param1:NetStatusEvent) : void
      {
      }
      
      public function AppendToGatewayUrl(param1:Object) : void
      {
         trace(param1);
      }
      
      public function callServer(param1:String, param2:Array) : AmfResponder
      {
         var _loc3_:AmfResponder = new AmfResponder(param2);
         var _loc4_:Array = [_destination + "." + param1,_loc3_];
         for each(var _loc5_ in param2)
         {
            _loc4_.push(_loc5_);
         }
         _netConnection.call.apply(null,_loc4_);
         return _loc3_;
      }
      
      public function get endPoint() : String
      {
         return _endPoint;
      }
      
      public function set endPoint(param1:String) : void
      {
         _endPoint = param1;
         _netConnection.connect(_endPoint);
      }
   }
}

