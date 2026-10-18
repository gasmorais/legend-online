package proxy.scene
{
   import proxy.data.SocketDataProxyModel;
   import yishi.service.managers.SocketManager;
   
   public class VehicleSocketDataProxy extends BaseSceneSocketDataProxy
   {
      
      public function VehicleSocketDataProxy(param1:SocketDataProxyModel)
      {
         super(param1);
      }
      
      override protected function proxyStart() : void
      {
         SocketManager.instance.addEventListener("SLGSocketEvent" + 4517,__onDataHandler);
         SocketManager.instance.addEventListener("SLGSocketEvent" + 4513,__onDataHandler);
         SocketManager.instance.addEventListener("SLGSocketEvent" + 4523,__onDataHandler);
         SocketManager.instance.addEventListener("SLGSocketEvent" + 4519,__onDataHandler);
         SocketManager.instance.addEventListener("SLGSocketEvent" + 4522,__onDataHandler);
         SocketManager.instance.addEventListener("SLGSocketEvent" + 4521,__onDataHandler);
         SocketManager.instance.addEventListener("SLGSocketEvent" + 4520,__onDataHandler);
         SocketManager.instance.addEventListener("SLGSocketEvent" + 127,__onDataHandler);
         SocketManager.instance.addEventListener("SLGSocketEvent" + 4264,__onDataHandler);
         SocketManager.instance.addEventListener("SLGSocketEvent" + 128,__onDataHandler);
         SocketManager.instance.addEventListener("SLGSocketEvent" + 4474,__onDataHandler);
         SocketManager.instance.addEventListener("SLGSocketEvent" + 4518,__onDataHandler);
         SocketManager.instance.addEventListener("SLGSocketEvent" + 125,__onDataHandler);
         SocketManager.instance.addEventListener("SLGSocketEvent" + 4514,__onDataHandler);
         SocketManager.instance.addEventListener("SLGSocketEvent" + 4524,__onDataHandler);
      }
      
      override protected function proxyOver() : void
      {
         SocketManager.instance.removeEventListener("SLGSocketEvent" + 4517,__onDataHandler);
         SocketManager.instance.removeEventListener("SLGSocketEvent" + 4513,__onDataHandler);
         SocketManager.instance.removeEventListener("SLGSocketEvent" + 4523,__onDataHandler);
         SocketManager.instance.removeEventListener("SLGSocketEvent" + 4519,__onDataHandler);
         SocketManager.instance.removeEventListener("SLGSocketEvent" + 4522,__onDataHandler);
         SocketManager.instance.removeEventListener("SLGSocketEvent" + 4521,__onDataHandler);
         SocketManager.instance.removeEventListener("SLGSocketEvent" + 4520,__onDataHandler);
         SocketManager.instance.removeEventListener("SLGSocketEvent" + 127,__onDataHandler);
         SocketManager.instance.removeEventListener("SLGSocketEvent" + 4264,__onDataHandler);
         SocketManager.instance.removeEventListener("SLGSocketEvent" + 128,__onDataHandler);
         SocketManager.instance.removeEventListener("SLGSocketEvent" + 4474,__onDataHandler);
         SocketManager.instance.removeEventListener("SLGSocketEvent" + 4518,__onDataHandler);
         SocketManager.instance.removeEventListener("SLGSocketEvent" + 125,__onDataHandler);
         SocketManager.instance.removeEventListener("SLGSocketEvent" + 4514,__onDataHandler);
         SocketManager.instance.removeEventListener("SLGSocketEvent" + 4524,__onDataHandler);
      }
      
      override public function get sceneType() : String
      {
         return "VEHICLE";
      }
   }
}

