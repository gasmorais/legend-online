package yishi.actions.consortia
{
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.ui.AlertManager;
   import com.pickgliss.ui.controls.alert.BaseAlerFrame;
   import com.pickgliss.utils.ObjectUtils;
   import manager.LanguageMgr;
   import yishi.actions.map.MapBaseAction;
   import yishi.manager.PlayerManager;
   import yishi.scene.SceneManager;
   
   public class CaseGoodsSendBackByMailAction extends MapBaseAction
   {
      
      private var _isPop:Boolean;
      
      private var _alert:BaseAlerFrame;
      
      public function CaseGoodsSendBackByMailAction()
      {
         super();
      }
      
      override public function prepare() : void
      {
         SceneManager.instance.lockScene = false;
      }
      
      override public function update() : void
      {
         if(!_isPop)
         {
            createTipsFrame();
            _isPop = true;
         }
      }
      
      private function createTipsFrame() : void
      {
         var _loc1_:String = LanguageMgr.GetTranslation("public.prompt");
         _alert = AlertManager.Instance.simpleAlert(_loc1_,msg,"");
         _alert.submitButton.y = 99;
         _alert.addEventListener("response",__requestFrameCloseHandler);
      }
      
      private function get msg() : String
      {
         var _loc2_:Date = new Date();
         var _loc1_:Date = new Date();
         _loc2_.setTime(PlayerManager.instance.currentPlayerModel.nowDate);
         _loc1_.setTime(_loc2_.time + 2592000000);
         return LanguageMgr.GetTranslation("yishi.actions.consortia.CaseGoodsSendBackByMailAction.sendBack") + (_loc2_.getMonth() + 1) + LanguageMgr.GetTranslation("public.month") + _loc2_.getDate() + LanguageMgr.GetTranslation("public.daily") + "—" + (_loc1_.getMonth() + 1) + LanguageMgr.GetTranslation("public.month") + _loc1_.getDate() + LanguageMgr.GetTranslation("public.daily");
      }
      
      private function __requestFrameCloseHandler(param1:FrameEvent) : void
      {
         _alert.removeEventListener("response",__requestFrameCloseHandler);
         _alert.dispose();
         _alert = null;
         dispose();
      }
      
      override public function dispose() : void
      {
         ObjectUtils.disposeObject(_alert);
         _alert = null;
         super.dispose();
      }
   }
}

