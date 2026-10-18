package cell.mediator.consortiabag
{
   import cell.mediator.DoubleClickMediator;
   import cell.view.PrizeItemMenu;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import flash.events.Event;
   import flash.geom.Point;
   import managers.ConsortiaSocketOutManager;
   import yishi.manager.ArmyManager;
   import yishi.manager.ConsortiaManager;
   import yishi.view.community.BaseItemView;
   
   public class ConsortiaPrizeCellClickMediator extends DoubleClickMediator
   {
      
      private var _menu:PrizeItemMenu;
      
      public function ConsortiaPrizeCellClickMediator()
      {
         super();
      }
      
      override protected function __mouseClickByClicker(param1:Event) : void
      {
         if(eaccess())
         {
            return;
         }
         var _loc2_:Point = _cell.parent.localToGlobal(new Point(_cell.x,_cell.y));
         showUseMenu(_loc2_.x + _cell.icon.iconWidth - 10,_loc2_.y + _cell.icon.iconHeight - 10,_cell);
      }
      
      override protected function __mouseDoubleClick(param1:Event) : void
      {
         if(eaccess())
         {
            return;
         }
         ConsortiaSocketOutManager.consortiaPrizeAllot(_cell.data.templateId);
      }
      
      private function eaccess() : Boolean
      {
         if(ConsortiaManager.instance.model.consortiaInfo.chairmanID != ArmyManager.instance.thane.userId || ConsortiaManager.instance.model.prizeList.keys.length == 0)
         {
            return true;
         }
         return false;
      }
      
      private function showUseMenu(param1:int, param2:int, param3:BaseItemView) : void
      {
         _menu = ComponentFactory.Instance.creatCustomObject("consortia.PrizeItemMenu",[param3]);
         _menu.x = param1;
         _menu.y = param2;
         LayerManager.Instance.addToLayer(_menu,7);
      }
   }
}

