package managers
{
   import com.road.yishi.proto.simple.PropertyMsg;
   import flash.external.ExternalInterface;
   import yishi.comm.PackageIn;
   import yishi.comm.PackageOut;
   import yishi.datas.templates.FaceBookShareTemplateInfo;
   import yishi.events.SLGSocketEvent;
   import yishi.manager.TempleteManager;
   import yishi.service.managers.SocketManager;
   
   public class FaceBookShareManager
   {
      
      private static var _instance:FaceBookShareManager;
      
      public function FaceBookShareManager()
      {
         super();
      }
      
      public static function get instance() : FaceBookShareManager
      {
         if(!_instance)
         {
            _instance = new FaceBookShareManager();
         }
         return _instance;
      }
      
      public function setup() : void
      {
         addEvent();
      }
      
      private function addEvent() : void
      {
         SocketManager.instance.addEventListener("SLGSocketEvent" + 336,__faceBookShareInfoHandler);
      }
      
      private function __faceBookShareInfoHandler(param1:SLGSocketEvent) : void
      {
         var _loc3_:PackageIn = param1.data as PackageIn;
         var _loc2_:PropertyMsg = new PropertyMsg();
         _loc2_ = _loc3_.readBody(_loc2_) as PropertyMsg;
         if(_loc2_.hasParam1)
         {
            faceBookShareById(_loc2_.param1);
         }
      }
      
      private function faceBookShareById(param1:int) : void
      {
         var _loc2_:FaceBookShareTemplateInfo = TempleteManager.instance.faceTemplateCate.getTemplateByID(param1);
         if(!_loc2_)
         {
            return;
         }
         if(ExternalInterface.available)
         {
            ExternalInterface.addCallback("sendFaceBookShareInfo",sendFaceBookShareInfo);
            ExternalInterface.call("callFbLike","param1","param1");
         }
      }
      
      private function sendFaceBookShareInfo(param1:int, param2:int) : void
      {
         var _loc3_:PackageOut = new PackageOut(9590);
         SocketManager.instance.socket.send(_loc3_);
      }
   }
}

