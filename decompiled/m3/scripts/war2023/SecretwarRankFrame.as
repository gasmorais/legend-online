package war2023
{
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.utils.ObjectUtils;
   import flash.events.Event;
   import manager.LanguageMgr;
   import war2023.view.SecretwarRankView;
   import yishi.datas.ComponentGroupType;
   import yishi.manager.NotificationManager;
   import yishi.manager.SecretWarManager;
   
   public class SecretwarRankFrame extends Frame
   {
      
      private var _view:SecretwarRankView;
      
      public function SecretwarRankFrame()
      {
         super();
         initView();
         initEvent();
         SecretWarManager.Instance.gameOp(6);
      }
      
      private function initView() : void
      {
         _view = new SecretwarRankView();
         addToContent(_view);
      }
      
      private function initEvent() : void
      {
         addEventListener("response",__frameResponse);
         NotificationManager.instance.addEventListener("secretwarRankListEvent",rankHandler);
      }
      
      private function removeEvent() : void
      {
         removeEventListener("response",__frameResponse);
         NotificationManager.instance.removeEventListener("secretwarRankListEvent",rankHandler);
      }
      
      private function rankHandler(param1:Event) : void
      {
         _view.btnGroup.selectIndex = 0;
      }
      
      private function __frameResponse(param1:FrameEvent) : void
      {
         switch(int(param1.responseCode))
         {
            case 0:
            case 1:
               dispose();
         }
      }
      
      override public function dispose() : void
      {
         removeEvent();
         ObjectUtils.disposeObject(_view);
         _view = null;
         super.dispose();
      }
      
      public function show() : void
      {
         titleText = LanguageMgr.GetTranslation("map.campaign.pvp.title01");
         LayerManager.Instance.addToLayer(this,3,true,true,1);
      }
      
      override public function get groups() : Array
      {
         return [ComponentGroupType.NONE];
      }
   }
}

