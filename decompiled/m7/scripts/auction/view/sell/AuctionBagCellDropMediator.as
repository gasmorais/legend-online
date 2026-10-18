package auction.view.sell
{
   import cell.mediator.CellDropMediator;
   import com.pickgliss.utils.SoundManager;
   import flash.display.DisplayObject;
   import flash.display.Stage;
   import manager.LanguageMgr;
   import mvc.controler.StoreControler;
   import mvc.module.store.StoreModel;
   import yishi.datas.goods.GoodsInfo;
   import yishi.manager.DragManager;
   import yishi.manager.FrameControllerManager;
   import yishi.manager.NotificationManager;
   import yishi.utils.GameDrag;
   import yishi.view.community.BaseItemView;
   import yishi.view.tips.MessageTipManager;
   
   public class AuctionBagCellDropMediator extends CellDropMediator
   {
      
      public function AuctionBagCellDropMediator()
      {
         super();
      }
      
      private function get control() : StoreControler
      {
         return FrameControllerManager.instance.storeController;
      }
      
      private function get model() : StoreModel
      {
         return control.model;
      }
      
      public function getData() : GoodsInfo
      {
         return null;
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
         _loc2_.dropChecks = [BaseItemView,Stage];
         _cell.setGrayFilter();
      }
      
      override public function beDropHitCallBack(param1:GameDrag) : void
      {
         var _loc5_:AuctionSellTargetCell = null;
         var _loc4_:int = 0;
         var _loc2_:* = null;
         var _loc3_:String = null;
         if(param1.dropTarget is AuctionSellTargetCell)
         {
            _loc5_ = param1.dropTarget as AuctionSellTargetCell;
            if(_cell.data.isLock)
            {
               _loc3_ = LanguageMgr.GetTranslation("vicepassword.description10");
               MessageTipManager.instance().show(_loc3_);
               NotificationManager.instance.sendNotification("ITEM_DROP_BagNotic",[_cell,true]);
               return;
            }
            AuctionGoodMoveControl.moveToTargetCell(_cell);
            param1.stopImmediatePropagation();
         }
         else
         {
            NotificationManager.instance.sendNotification("ITEM_DROP_BagNotic",[_cell,true]);
         }
      }
   }
}

