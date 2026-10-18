package year2023.ui.item
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.BaseButton;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import manager.LanguageMgr;
   import yishi.manager.FrameControllerManager;
   
   public class YearActive3UI extends Sprite
   {
      
      protected var _enterItemBg3:MovieClip;
      
      protected var _actBtn3:BaseButton;
      
      protected var _dayInfo3:YearActiveXUI;
      
      public function YearActive3UI()
      {
         super();
         initView();
         initEvent();
      }
      
      protected function initView() : void
      {
         _enterItemBg3 = ComponentFactory.Instance.creatCustomObject("ui.yearactive.enterItemBg3");
         _actBtn3 = ComponentFactory.Instance.creatComponentByStylename("ui.yearactive.actBtn3");
         _dayInfo3 = ComponentFactory.Instance.creatCustomObject("ui.yearactive.dayInfo3");
         addChild(_enterItemBg3);
         addChild(_actBtn3);
         addChild(_dayInfo3);
         _dayInfo3.actName = LanguageMgr.GetTranslation("yearactivity.type3");
      }
      
      private function initEvent() : void
      {
         _actBtn3.addEventListener("click",clickHandler);
      }
      
      private function removeEvent() : void
      {
         _actBtn3.removeEventListener("click",clickHandler);
      }
      
      private function clickHandler(param1:MouseEvent) : void
      {
         FrameControllerManager.instance.openControllerByInfo("yearactive","Look");
         FrameControllerManager.instance.yearactiveContrl.setPreFrame("yearactive","Enter");
      }
      
      public function dispose() : void
      {
         removeEvent();
         ObjectUtils.disposeViolentMc(_enterItemBg3);
         _enterItemBg3 = null;
         ObjectUtils.disposeObject(_actBtn3);
         _actBtn3 = null;
         ObjectUtils.disposeObject(_dayInfo3);
         _dayInfo3 = null;
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}

