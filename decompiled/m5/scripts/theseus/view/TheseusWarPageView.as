package theseus.view
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Sprite;
   import managers.TheseussoulManager;
   import theseus.war.view.TheseusWarEquipBagView;
   import theseus.war.view.TheseusWarEquipPageView;
   import yishi.events.NotificationEvent;
   
   public class TheseusWarPageView extends Sprite
   {
      
      private var _equipView:TheseusWarEquipPageView;
      
      private var _bagView:TheseusWarEquipBagView;
      
      public function TheseusWarPageView()
      {
         super();
         initView();
         initEvent();
      }
      
      private function initView() : void
      {
         _equipView = ComponentFactory.Instance.creatCustomObject("ui.theseussoul.war.TheseusWarEquipPageView");
         addChild(_equipView);
         _bagView = ComponentFactory.Instance.creatCustomObject("ui.theseussoul.war.TheseusWarEquipBagView");
         addChild(_bagView);
      }
      
      private function initEvent() : void
      {
         TheseussoulManager.Instance.addEventListener("EVENT_WAR_EQUIP",warListInfoHandler);
      }
      
      private function removeEvent() : void
      {
         TheseussoulManager.Instance.removeEventListener("EVENT_WAR_EQUIP",warListInfoHandler);
      }
      
      private function warListInfoHandler(param1:NotificationEvent) : void
      {
         var _loc2_:int = int(param1.data);
         if(_loc2_ == 10)
         {
            _equipView.updateView();
            _bagView.updateView();
         }
         else if(_loc2_ == 9)
         {
            _bagView.updateView();
         }
         else if(_loc2_ == 19)
         {
            _equipView.updateView();
         }
      }
      
      public function dispose() : void
      {
         removeEvent();
         ObjectUtils.disposeObject(_equipView);
         _equipView = null;
         ObjectUtils.disposeObject(_bagView);
         _bagView = null;
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}

