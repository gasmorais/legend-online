package buildings.transferbuilding.view.planesbag
{
   import cell.mediator.DoubleClickMediator;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import flash.events.Event;
   import flash.geom.Point;
   import yishi.service.managers.SocketSendManager;
   
   public class PlanesBagCellClickMediator extends DoubleClickMediator
   {
      
      private var _menu:PlanesGoodsItemMenu;
      
      public function PlanesBagCellClickMediator()
      {
         super();
      }
      
      override protected function __mouseClickByClicker(param1:Event) : void
      {
         if(_cell.data.templateInfo.SonType != 606)
         {
            return;
         }
         var _loc2_:Point = _cell.parent.localToGlobal(new Point(_cell.x,_cell.y));
         _menu = ComponentFactory.Instance.creatCustomObject("PlanesBagCell.GoodsItemMenu",[_cell]);
         _menu.x = _loc2_.x + _cell.icon.iconWidth;
         _menu.y = _loc2_.y + _cell.icon.iconHeight;
         LayerManager.Instance.addToLayer(_menu,7);
      }
      
      override protected function __mouseDoubleClick(param1:Event) : void
      {
         if(_cell.data.templateInfo.SonType != 606)
         {
            return;
         }
         SocketSendManager.instance.sendUseItem(_cell.data.pos);
      }
   }
}

