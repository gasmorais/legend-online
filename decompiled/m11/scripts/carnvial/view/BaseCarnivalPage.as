package carnvial.view
{
   import com.pickgliss.loader.LoaderManagerII;
   import com.pickgliss.loader.data.LoaderInfo;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import mvc.module.carnival.CarnivalModel;
   import yishi.events.NotificationEvent;
   import yishi.manager.CarnivalManager;
   import yishi.manager.PathManager;
   
   public class BaseCarnivalPage extends Sprite
   {
      
      protected var _isDie:Boolean;
      
      protected var _activeId:int;
      
      public function BaseCarnivalPage()
      {
         super();
         _activeId = model.configActId;
         initView();
      }
      
      protected function initView() : void
      {
      }
      
      protected function initEvent() : void
      {
         CarnivalManager.Instance.addEventListener("carn.EVENT_UPDATE",updateInfoHandler);
      }
      
      protected function removeEvent() : void
      {
         CarnivalManager.Instance.removeEventListener("carn.EVENT_UPDATE",updateInfoHandler);
      }
      
      protected function updateInfoHandler(param1:NotificationEvent) : void
      {
      }
      
      protected function toLoadImg(param1:Bitmap, param2:String, param3:int) : void
      {
         var bit:Bitmap = param1;
         var imgName:String = param2;
         var activeId:int = param3;
         var path:String = PathManager.getCarnivalRes(activeId,imgName);
         LoaderManagerII.instance.load(path,2,0,function(param1:LoaderInfo, param2:Object):void
         {
            if(!_isDie && param1.args && param2 is Bitmap)
            {
               param1.args.bitmapData = param2.bitmapData;
            }
         },null,null,bit);
      }
      
      protected function get model() : CarnivalModel
      {
         return CarnivalManager.Instance.model;
      }
      
      protected function clearView() : void
      {
      }
      
      public function dispose() : void
      {
         _isDie = true;
         removeEvent();
         clearView();
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}

