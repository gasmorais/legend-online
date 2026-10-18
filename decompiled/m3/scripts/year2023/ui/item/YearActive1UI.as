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
   
   public class YearActive1UI extends Sprite
   {
      
      protected var _enterItemBg1:MovieClip;
      
      protected var _actBtn1:BaseButton;
      
      protected var _dayInfo1:YearActiveXUI;
      
      public function YearActive1UI()
      {
         super();
         initView();
         initEvent();
      }
      
      protected function initView() : void
      {
         _enterItemBg1 = ComponentFactory.Instance.creatCustomObject("ui.yearactive.enterItemBg1");
         _actBtn1 = ComponentFactory.Instance.creatComponentByStylename("ui.yearactive.actBtn1");
         _dayInfo1 = ComponentFactory.Instance.creatCustomObject("ui.yearactive.dayInfo1");
         addChild(_enterItemBg1);
         addChild(_actBtn1);
         addChild(_dayInfo1);
         _dayInfo1.actName = LanguageMgr.GetTranslation("yearactivity.type1");
      }
      
      private function initEvent() : void
      {
         _actBtn1.addEventListener("click",clickHandler);
      }
      
      private function removeEvent() : void
      {
         _actBtn1.removeEventListener("click",clickHandler);
      }
      
      private function clickHandler(param1:MouseEvent) : void
      {
         FrameControllerManager.instance.openControllerByInfo("yearactive","Day");
         FrameControllerManager.instance.yearactiveContrl.setPreFrame("yearactive","Enter");
      }
      
      public function dispose() : void
      {
         removeEvent();
         ObjectUtils.disposeViolentMc(_enterItemBg1);
         _enterItemBg1 = null;
         ObjectUtils.disposeObject(_actBtn1);
         _actBtn1 = null;
         ObjectUtils.disposeObject(_dayInfo1);
         _dayInfo1 = null;
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}

