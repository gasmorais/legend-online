package finaldefense.view
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Bitmap;
   import flash.events.Event;
   import flash.utils.clearInterval;
   import flash.utils.setInterval;
   import managers.FinalDefenseManager;
   import yishi.events.NotificationEvent;
   import yishi.manager.NotificationManager;
   import yishi.utils.DateFormatter;
   
   public class FinalDefenseTopView extends Component
   {
      
      private var _bg:Bitmap;
      
      private var _leftTimeTxt:FilterFrameText;
      
      private var uintFlag:uint;
      
      public function FinalDefenseTopView()
      {
         super();
         initView();
         addEvent();
         updateView();
      }
      
      private function initView() : void
      {
         _bg = ComponentFactory.Instance.creatBitmap("asset.finaldefense.TopViewBg");
         _leftTimeTxt = ComponentFactory.Instance.creatComponentByStylename("finaldefens.leftTimeTxt");
         addChild(_bg);
         addChild(_leftTimeTxt);
      }
      
      private function addEvent() : void
      {
         NotificationManager.instance.addEventListener("FINAL_DEFENSE_GAME_STAR",onGameStar);
         NotificationManager.instance.addEventListener("FINAL_DEFENSE_ROUND_OVER",onRoundOver);
      }
      
      private function removeEvent() : void
      {
         NotificationManager.instance.removeEventListener("FINAL_DEFENSE_GAME_STAR",onGameStar);
         NotificationManager.instance.removeEventListener("FINAL_DEFENSE_ROUND_OVER",onRoundOver);
      }
      
      private function onRoundOver(param1:NotificationEvent) : void
      {
         FinalDefenseManager.ins.model.info.leftSecond = 0;
      }
      
      private function onGameStar(param1:Event) : void
      {
         uintFlag = setInterval(updateView,1000);
      }
      
      public function updateView() : void
      {
         if(FinalDefenseManager.ins.model.info.leftSecond <= 0)
         {
            clearInterval(uintFlag);
            return;
         }
         FinalDefenseManager.ins.model.info.leftSecond--;
         _leftTimeTxt.text = DateFormatter.getCountDateByMS(FinalDefenseManager.ins.model.info.leftSecond);
      }
      
      override public function dispose() : void
      {
         removeEvent();
         clearInterval(uintFlag);
         ObjectUtils.disposeObject(_bg);
         _bg = null;
         ObjectUtils.disposeObject(_leftTimeTxt);
         _leftTimeTxt = null;
         super.dispose();
      }
   }
}

