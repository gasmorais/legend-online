package finaldefense.view
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.IconButton;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Bitmap;
   import flash.events.MouseEvent;
   import managers.FinalDefenseManager;
   import yishi.events.NotificationEvent;
   import yishi.manager.NotificationManager;
   
   public class FinalDefenseGameStarView extends Component
   {
      
      private var _bg:Bitmap;
      
      private var _starBtn:IconButton;
      
      public function FinalDefenseGameStarView()
      {
         super();
         initView();
         initEvent();
         updateView();
      }
      
      private function initView() : void
      {
         _bg = ComponentFactory.Instance.creatBitmap("asset.finaldefense.gemastarbg");
         _starBtn = ComponentFactory.Instance.creatComponentByStylename("finaldefens.gamestarBtn");
         addChild(_bg);
         addChild(_starBtn);
      }
      
      public function updateView() : void
      {
         _starBtn.enable = true;
         if(FinalDefenseManager.ins.model.info.rounds > 5)
         {
            _starBtn.enable = false;
         }
      }
      
      private function initEvent() : void
      {
         _starBtn.addEventListener("click",onStarBtnClick);
         NotificationManager.instance.addEventListener("FINAL_DEFENSE_INFO",onInfo);
      }
      
      private function removeEvent() : void
      {
         _starBtn.removeEventListener("click",onStarBtnClick);
         NotificationManager.instance.removeEventListener("FINAL_DEFENSE_INFO",onInfo);
      }
      
      private function onInfo(param1:NotificationEvent) : void
      {
         updateView();
      }
      
      private function onStarBtnClick(param1:MouseEvent) : void
      {
         FinalDefenseManager.ins.starTrun();
         if(this.parent)
         {
            this.parent.removeChild(this);
         }
      }
      
      override public function dispose() : void
      {
         removeEvent();
         ObjectUtils.disposeObject(_bg);
         _bg = null;
         ObjectUtils.disposeObject(_starBtn);
         _starBtn = null;
         super.dispose();
      }
   }
}

