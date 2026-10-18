package cell.mediator
{
   import bag.helper.BagHelper;
   import cell.view.GoodsItemMenu;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import flash.events.MouseEvent;
   import flash.geom.Point;
   import org.aswing.KeyboardManager;
   import yishi.datas.goods.GoodsInfo;
   import yishi.interfaces.IMediator;
   import yishi.manager.DragManager;
   import yishi.manager.NotificationManager;
   import yishi.view.community.BaseItemView;
   
   public class CellMenuMediator implements IMediator
   {
      
      private var _menu:GoodsItemMenu;
      
      private var _cell:BaseItemView;
      
      public function CellMenuMediator()
      {
         super();
      }
      
      public function register(param1:Object) : void
      {
         _cell = param1 as BaseItemView;
         if(_cell.icon)
         {
            _cell.icon.addEventListener("click",__mouseClickHandler);
         }
      }
      
      public function unregister(param1:Object) : void
      {
         if(_cell.icon)
         {
            _cell.icon.removeEventListener("click",__mouseClickHandler);
         }
         _cell = null;
         if(_menu)
         {
            _menu.dispose();
         }
         _menu = null;
      }
      
      protected function __mouseClickHandler(param1:MouseEvent) : void
      {
         var _loc3_:Point = null;
         if(DragManager.getInstance().isDraging)
         {
            return;
         }
         var _loc2_:GoodsInfo = _cell.data;
         if(!_loc2_ || KeyboardManager.isDown(16) && BagHelper.instance.canSplite(_loc2_) || BagHelper.instance.isSelling)
         {
            return;
         }
         if(_loc2_.templateInfo.MasterType == 2 || _loc2_.templateInfo.MasterType == 4)
         {
            _loc3_ = _cell.parent.localToGlobal(new Point(_cell.x,_cell.y));
            if(BagHelper.checkCanUseGoods(_loc2_.templateInfo.SonType))
            {
               showUseMenu(_loc3_.x + _cell.width,_loc3_.y + _cell.height,_cell);
               return;
            }
         }
      }
      
      private function showUseMenu(param1:int, param2:int, param3:BaseItemView) : void
      {
         if(_cell.bagType == 6)
         {
            NotificationManager.instance.sendNotification("DRAG_ITEM_BagNotic",[this]);
            return;
         }
         _menu = ComponentFactory.Instance.creatCustomObject("core.GoodsItemMenu",[param3]);
         _menu.x = param1;
         _menu.y = param2;
         LayerManager.Instance.addToLayer(_menu,7);
      }
   }
}

