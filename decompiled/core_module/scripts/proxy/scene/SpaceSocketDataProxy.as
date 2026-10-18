package proxy.scene
{
   import proxy.data.SocketDataProxyModel;
   import yishi.service.managers.SocketManager;
   
   public class SpaceSocketDataProxy extends BaseSceneSocketDataProxy
   {
      
      public function SpaceSocketDataProxy(param1:SocketDataProxyModel)
      {
         super(param1);
      }
      
      override protected function proxyStart() : void
      {
         SocketManager.instance.addEventListener("SLGSocketEvent" + 4592,__onDataHandler);
         SocketManager.instance.addEventListener("SLGSocketEvent" + 4593,__onDataHandler);
         SocketManager.instance.addEventListener("SLGSocketEvent" + 4594,__onDataHandler);
         SocketManager.instance.addEventListener("SLGSocketEvent" + 149,__onDataHandler);
         SocketManager.instance.addEventListener("SLGSocketEvent" + 4601,__onDataHandler);
      }
      
      override protected function proxyOver() : void
      {
         SocketManager.instance.removeEventListener("SLGSocketEvent" + 4592,__onDataHandler);
         SocketManager.instance.removeEventListener("SLGSocketEvent" + 4593,__onDataHandler);
         SocketManager.instance.removeEventListener("SLGSocketEvent" + 4594,__onDataHandler);
         SocketManager.instance.removeEventListener("SLGSocketEvent" + 149,__onDataHandler);
         SocketManager.instance.removeEventListener("SLGSocketEvent" + 4601,__onDataHandler);
      }
      
      override public function get sceneType() : String
      {
         return "SPACE_SCENE";
      }
   }
}

