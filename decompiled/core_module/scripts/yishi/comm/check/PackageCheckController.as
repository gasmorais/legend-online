package yishi.comm.check
{
   import yishi.comm.ByteSocket;
   import yishi.comm.PackageOut;
   import yishi.comm.SocketEvent;
   
   public class PackageCheckController
   {
      
      private var _model:PackageCheckModel;
      
      private var _byteSocket:ByteSocket;
      
      public function PackageCheckController(param1:ByteSocket)
      {
         super();
         _byteSocket = param1;
         _model = new PackageCheckModel();
         _model.addEventListener("checkError",__checkErrorHandler);
      }
      
      private function __checkErrorHandler(param1:SocketEvent) : void
      {
         _byteSocket.close();
      }
      
      public function addPackage(param1:PackageOut) : void
      {
         _model.addPackage(param1);
      }
   }
}

