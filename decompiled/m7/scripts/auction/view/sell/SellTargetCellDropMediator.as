package auction.view.sell
{
   import cell.mediator.CellDropMediator;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.utils.SoundManager;
   import flash.display.DisplayObject;
   import flash.display.Stage;
   import yishi.events.NotificationEvent;
   import yishi.manager.DragManager;
   import yishi.manager.NotificationManager;
   import yishi.utils.GameDrag;
   import yishi.view.community.BaseItemView;
   
   public class SellTargetCellDropMediator extends CellDropMediator
   {
      
      public function SellTargetCellDropMediator()
      {
         super();
      }
      
      override protected function starItemDrag(param1:int = -1) : void
      {
         SoundManager.instance.play("003");
         _cell.isDraging = true;
         var _loc3_:DisplayObject = getDragIconObj();
         if(!_loc3_)
         {
            return;
         }
         var _loc2_:GameDrag = DragManager.getInstance().starDrag(_cell,{"icon":_loc3_});
         _loc2_.data = param1;
         _loc2_.onDrop = beDropHitCallBack;
         _loc2_.dropChecks = [BaseItemView,Frame,Stage];
         _cell.setGrayFilter();
      }
      
      override protected function __dragItemBagHandler(param1:NotificationEvent) : void
      {
         SoundManager.instance.play("003");
         super.__dragItemBagHandler(param1);
         var _loc2_:AuctionSellBagCell = param1.data[0] as AuctionSellBagCell;
         if(!_loc2_)
         {
            return;
         }
         if(_cell is AuctionSellTargetCell)
         {
            AuctionSellTargetCell(_cell).setFocus();
            return;
         }
         AuctionSellTargetCell(_cell).setNormal();
      }
      
      override protected function __itemDropBagHandler(param1:NotificationEvent) : void
      {
         super.__itemDropBagHandler(param1);
         AuctionSellTargetCell(_cell).setNormal();
      }
      
      override public function unregister(param1:Object) : void
      {
         super.unregister(param1);
         DragManager.getInstance().stopDrag();
      }
      
      override public function beDropHitCallBack(param1:GameDrag) : void
      {
         _cell.isDraging = false;
         _cell.setNormalFilter();
         AuctionSellTargetCell(_cell).data = null;
         NotificationManager.instance.sendNotification("ITEM_DROP_BagNotic",[_cell]);
      }
   }
}

