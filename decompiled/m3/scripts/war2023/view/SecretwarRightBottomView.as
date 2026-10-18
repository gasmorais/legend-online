package war2023.view
{
   import flash.events.Event;
   import flash.events.MouseEvent;
   import manager.LanguageMgr;
   import mvc.module.war2023.info.SecretwarSelfInfo;
   import war2023.ui.SecretwarRightBottomUI;
   import yishi.manager.FrameControllerManager;
   import yishi.manager.NotificationManager;
   import yishi.manager.SecretWarManager;
   
   public class SecretwarRightBottomView extends SecretwarRightBottomUI
   {
      
      private var _selfInfo:SecretwarSelfInfo;
      
      public function SecretwarRightBottomView()
      {
         super();
         _selfInfo = SecretWarManager.Instance.model.selfInfo;
         if(_selfInfo.camp == 1)
         {
            _rightCampTxt.setFrame(1);
            _rightCampTxt.text = LanguageMgr.GetTranslation("secretwar.birth1");
         }
         else
         {
            _rightCampTxt.setFrame(2);
            _rightCampTxt.text = LanguageMgr.GetTranslation("secretwar.birth2");
         }
         initEvent();
         updateHandler();
      }
      
      private function initEvent() : void
      {
         _rightRankBtn.addEventListener("click",rankHandler);
         _trackBtn.addEventListener("click",trackHandler);
         NotificationManager.instance.addEventListener("secretwarUpdateSelfEvent",updateHandler);
      }
      
      private function removeEvent() : void
      {
         _rightRankBtn.removeEventListener("click",rankHandler);
         _trackBtn.removeEventListener("click",trackHandler);
         NotificationManager.instance.removeEventListener("secretwarUpdateSelfEvent",updateHandler);
      }
      
      private function updateHandler(param1:Event = null) : void
      {
         _rightScoreTxt.text = "" + _selfInfo.score;
      }
      
      private function rankHandler(param1:MouseEvent) : void
      {
         FrameControllerManager.instance.openControllerByInfo("secretwar",3);
      }
      
      private function trackHandler(param1:MouseEvent) : void
      {
         NotificationManager.instance.sendNotification("Secretwar.initMapPos");
      }
      
      override public function dispose() : void
      {
         removeEvent();
         super.dispose();
         _selfInfo = null;
      }
   }
}

