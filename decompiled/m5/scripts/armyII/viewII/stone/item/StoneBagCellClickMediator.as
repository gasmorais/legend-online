package armyII.viewII.stone.item
{
   import cell.mediator.DoubleClickMediator;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import flash.events.Event;
   import flash.geom.Point;
   import managers.ArmySocketOutManager;
   import yishi.datas.goods.GoodsInfo;
   import yishi.manager.FrameControllerManager;
   import yishi.manager.NotificationManager;
   import yishi.view.community.BaseItemView;
   
   public class StoneBagCellClickMediator extends DoubleClickMediator
   {
      
      private var _menu:RuneCellMenu;
      
      public function StoneBagCellClickMediator()
      {
         super();
      }
      
      override protected function __mouseClickByClicker(param1:Event) : void
      {
         var _loc3_:int = 0;
         var _loc4_:Point = null;
         var _loc2_:GoodsInfo = _cell.data;
         if(!_loc2_)
         {
            return;
         }
         if(_cell.bagType == 401)
         {
            _loc3_ = int(FrameControllerManager.instance.armyController.model.stoneBtnState);
            if(_loc3_ <= 0)
            {
               _loc4_ = _cell.parent.localToGlobal(new Point(_cell.x,_cell.y));
               showUseMenu(_loc4_.x + _cell.icon.iconWidth - 10,_loc4_.y + _cell.icon.iconHeight - 10,_cell);
            }
         }
         else
         {
            NotificationManager.instance.sendNotification("playRuneEquipEff",_loc2_.templateInfo.Property1);
            NotificationManager.instance.sendNotification("DRAG_ITEM_BagNotic",[_cell,_loc2_.count]);
         }
      }
      
      override protected function __mouseDoubleClick(param1:Event) : void
      {
         var _loc3_:int = 0;
         var _loc2_:GoodsInfo = _cell.data;
         if(!_loc2_)
         {
            return;
         }
         var _loc4_:StoneBagCell = _cell as StoneBagCell;
         if(_loc4_ && _loc4_.bagType == 41)
         {
            _loc3_ = int(FrameControllerManager.instance.armyController.currOpRuneInfo.runeId);
            ArmySocketOutManager.sendUnEquipStone(_loc3_,_loc4_.pos);
         }
      }
      
      private function showUseMenu(param1:int, param2:int, param3:BaseItemView) : void
      {
         _menu = ComponentFactory.Instance.creatCustomObject("army.rune.GoodsItemMenu",[param3]);
         _menu.x = param1;
         _menu.y = param2;
         LayerManager.Instance.addToLayer(_menu,7);
      }
   }
}

