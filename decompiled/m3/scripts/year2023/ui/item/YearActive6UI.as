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
   
   public class YearActive6UI extends Sprite
   {
      
      protected var _enterItemBg6:MovieClip;
      
      protected var _enterBtn6:BaseButton;
      
      protected var _dayInfo6:YearActiveXUI;
      
      public function YearActive6UI()
      {
         super();
         initView();
         initEvent();
      }
      
      protected function initView() : void
      {
         _enterItemBg6 = ComponentFactory.Instance.creatCustomObject("ui.yearactive.enterItemBg6");
         _enterBtn6 = ComponentFactory.Instance.creatComponentByStylename("ui.yearactive.enterMc6Btn");
         _dayInfo6 = ComponentFactory.Instance.creatCustomObject("ui.yearactive.dayInfo6");
         addChild(_enterItemBg6);
         addChild(_enterBtn6);
         addChild(_dayInfo6);
         _dayInfo6.actName = LanguageMgr.GetTranslation("yearactivity.type6");
      }
      
      private function initEvent() : void
      {
         _enterBtn6.addEventListener("click",clickHandler);
      }
      
      private function removeEvent() : void
      {
         _enterBtn6.removeEventListener("click",clickHandler);
      }
      
      private function clickHandler(param1:MouseEvent) : void
      {
         FrameControllerManager.instance.openControllerByInfo("yearactive","Egg");
         FrameControllerManager.instance.yearactiveContrl.setLockPreFrame("yearactive","Enter",null,"year2023.frame.YearActiveEggFrame");
      }
      
      public function dispose() : void
      {
         removeEvent();
         ObjectUtils.disposeViolentMc(_enterItemBg6);
         _enterItemBg6 = null;
         ObjectUtils.disposeViolentMc(_enterBtn6);
         _enterBtn6 = null;
         ObjectUtils.disposeObject(_dayInfo6);
         _dayInfo6 = null;
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}

