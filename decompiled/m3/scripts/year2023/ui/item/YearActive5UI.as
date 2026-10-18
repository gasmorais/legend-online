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
   
   public class YearActive5UI extends Sprite
   {
      
      protected var _enterItemBg5:MovieClip;
      
      protected var _actBtn5:BaseButton;
      
      protected var _dayInfo5:YearActiveXUI;
      
      public function YearActive5UI()
      {
         super();
         initView();
         initEvent();
      }
      
      protected function initView() : void
      {
         _enterItemBg5 = ComponentFactory.Instance.creatCustomObject("ui.yearactive.enterItemBg5");
         _actBtn5 = ComponentFactory.Instance.creatComponentByStylename("ui.yearactive.actBtn5");
         _dayInfo5 = ComponentFactory.Instance.creatCustomObject("ui.yearactive.dayInfo5");
         addChild(_enterItemBg5);
         addChild(_actBtn5);
         addChild(_dayInfo5);
         _dayInfo5.actName = LanguageMgr.GetTranslation("yearactivity.type5");
      }
      
      private function initEvent() : void
      {
         _actBtn5.addEventListener("click",clickHandler);
      }
      
      private function removeEvent() : void
      {
         _actBtn5.removeEventListener("click",clickHandler);
      }
      
      private function clickHandler(param1:MouseEvent) : void
      {
         FrameControllerManager.instance.openControllerByInfo("yearactive","Shop");
         FrameControllerManager.instance.yearactiveContrl.setPreFrame("yearactive","Enter");
      }
      
      public function dispose() : void
      {
         removeEvent();
         ObjectUtils.disposeViolentMc(_enterItemBg5);
         _enterItemBg5 = null;
         ObjectUtils.disposeObject(_actBtn5);
         _actBtn5 = null;
         ObjectUtils.disposeObject(_dayInfo5);
         _dayInfo5 = null;
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}

