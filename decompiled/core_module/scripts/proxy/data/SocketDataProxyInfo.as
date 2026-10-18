package proxy.data
{
   import yishi.comm.PackageIn;
   
   public class SocketDataProxyInfo
   {
      
      public var data:PackageIn;
      
      public var event:String;
      
      public function SocketDataProxyInfo(param1:PackageIn, param2:String)
      {
         super();
         data = param1;
         event = param2;
      }
   }
}

