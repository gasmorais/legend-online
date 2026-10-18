package proxy.scene
{
   import com.pickgliss.ui.core.Disposeable;
   import proxy.data.SocketDataProxyInfo;
   import proxy.data.SocketDataProxyModel;
   import yishi.comm.PackageIn;
   import yishi.events.SLGSocketEvent;
   
   public class BaseSceneSocketDataProxy implements Disposeable
   {
      
      private var _model:SocketDataProxyModel;
      
      public function BaseSceneSocketDataProxy(param1:SocketDataProxyModel)
      {
         super();
         _model = param1;
         proxyStart();
      }
      
      protected function proxyStart() : void
      {
      }
      
      protected function __onDataHandler(param1:SLGSocketEvent) : void
      {
         _model.addSocketData(new SocketDataProxyInfo(param1.data as PackageIn,param1.type),sceneType);
      }
      
      public function get sceneType() : String
      {
         throw new Error("请重载该方法");
      }
      
      protected function proxyOver() : void
      {
      }
      
      public function dispose() : void
      {
         _model.readSceneSocketData(sceneType);
         proxyOver();
         _model = null;
      }
   }
}

