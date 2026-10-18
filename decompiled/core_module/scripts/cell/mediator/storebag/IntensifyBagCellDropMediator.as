package cell.mediator.storebag
{
   import cell.mediator.CellDropMediator;
   import cell.view.storebag.StoreBagCell;
   import cell.view.storebag.StoreIntensifyCell;
   import cell.view.storebag.StoreMountCell;
   import cell.view.storebag.StoreResolveCell;
   import cell.view.storebag.StoreSwitchCell;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.utils.SoundManager;
   import flash.display.DisplayObject;
   import flash.display.Stage;
   import manager.LanguageMgr;
   import mvc.controler.StoreControler;
   import mvc.module.store.StoreModel;
   import yishi.events.NotificationEvent;
   import yishi.manager.DragManager;
   import yishi.manager.FrameControllerManager;
   import yishi.manager.GoodsManager;
   import yishi.manager.NotificationManager;
   import yishi.manager.PlayerManager;
   import yishi.utils.GameDrag;
   import yishi.view.community.BaseItemView;
   import yishi.view.tips.MessageTipManager;
   
   public class IntensifyBagCellDropMediator extends CellDropMediator
   {
      
      public function IntensifyBagCellDropMediator()
      {
         super();
      }
      
      private function get model() : StoreModel
      {
         return FrameControllerManager.instance.storeController.model;
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
         var _loc3_:StoreControler = null;
         SoundManager.instance.play("003");
         super.__dragItemBagHandler(param1);
         var _loc2_:StoreBagCell = param1.data[0] as StoreBagCell;
         if(!_loc2_)
         {
            return;
         }
         if(_cell is StoreMountCell)
         {
            if(_loc2_.data.templateInfo.MasterType == 1)
            {
               StoreMountCell(_cell).setFocus();
               return;
            }
         }
         else if(_cell is StoreSwitchCell)
         {
            if(_loc2_.data.templateInfo.MasterType == 2)
            {
               StoreSwitchCell(_cell).setFocus();
               return;
            }
         }
         else if(_cell is StoreResolveCell)
         {
            _loc3_ = FrameControllerManager.instance.storeController;
            if((_cell as StoreIntensifyCell).sonType == -1 && _loc3_.canReslove(_loc2_.data))
            {
               StoreIntensifyCell(_cell).setFocus();
               return;
            }
         }
         else if(_cell is StoreIntensifyCell)
         {
            if(!model.isViceIntensifing)
            {
               if(_loc2_.data.templateInfo.MasterType == 2 && (_cell as StoreIntensifyCell).pos == 1)
               {
                  StoreIntensifyCell(_cell).setFocus();
                  return;
               }
               if((_loc2_.data.templateInfo.MasterType == 1 || _loc2_.data.templateInfo.MasterType == 11) && (_cell as StoreIntensifyCell).pos == 0)
               {
                  StoreIntensifyCell(_cell).setFocus();
                  return;
               }
            }
         }
         StoreIntensifyCell(_cell).setNormal();
      }
      
      override protected function __itemDropBagHandler(param1:NotificationEvent) : void
      {
         super.__itemDropBagHandler(param1);
         StoreIntensifyCell(_cell).setNormal();
      }
      
      override public function beDropHitCallBack(param1:GameDrag) : void
      {
         var _loc3_:BaseItemView = null;
         var _loc2_:int = 0;
         _cell.isDraging = false;
         _cell.setNormalFilter();
         if(param1.dropTarget != _cell)
         {
            if(param1.dropTarget is BaseItemView)
            {
               SoundManager.instance.play("003");
               _loc2_ = param1.data > 0 ? param1.data : 1;
               _loc3_ = param1.dropTarget as BaseItemView;
               swapItem(_cell,_loc3_,_loc2_);
               param1.stopImmediatePropagation();
            }
            else
            {
               param1.stopImmediatePropagation();
            }
         }
         NotificationManager.instance.sendNotification("ITEM_DROP_BagNotic",[_cell]);
      }
      
      protected function swapItem(param1:BaseItemView, param2:BaseItemView, param3:int) : void
      {
         var _loc4_:String = null;
         if(param2 is StoreIntensifyCell)
         {
            if((param2 as StoreIntensifyCell).sonType == 204 && (param1 as StoreIntensifyCell).sonType == -1)
            {
               _loc4_ = LanguageMgr.GetTranslation("cell.mediator.playerbag.PlayerBagCellDropMediator.command02");
               MessageTipManager.instance().show(_loc4_);
               return;
            }
            if((param2 as StoreIntensifyCell).sonType == -1 && (param1 as StoreIntensifyCell).sonType == 204)
            {
               _loc4_ = LanguageMgr.GetTranslation("cell.mediator.storebag.IntensifyBagCellDropMediator.command01");
               MessageTipManager.instance().show(_loc4_);
               return;
            }
         }
         if(param2 is StoreBagCell)
         {
            if(PlayerManager.instance.currentPlayerModel.playerInfo.stoneBagCount > 0 && GoodsManager.instance.isStoreBagGoods(param1.data))
            {
               PlayerManager.instance.moveBagToBag(param1.bagType,param1.objectId,param1.pos,34,0,0,1);
            }
            else
            {
               PlayerManager.instance.moveBagToBag(param1.bagType,param1.objectId,param1.pos,1,0,0,1);
            }
         }
      }
   }
}

