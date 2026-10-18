package cell.mediator.marketbag
{
   import cell.mediator.CellDropMediator;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.utils.SoundManager;
   import flash.display.DisplayObject;
   import flash.display.Stage;
   import manager.LanguageMgr;
   import map.campaign.CampaignManager;
   import map.campaign.data.MarketModel;
   import yishi.manager.DragManager;
   import yishi.manager.NotificationManager;
   import yishi.utils.GameDrag;
   import yishi.view.tips.MessageTipManager;
   
   public class MarketBagCellDropMediator extends CellDropMediator
   {
      
      public function MarketBagCellDropMediator()
      {
         super();
      }
      
      override protected function starItemDrag(param1:int = -1) : void
      {
         if(model.selfStall.state == 2)
         {
            return;
         }
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
         _loc2_.dropChecks = [MarketItemCell,Frame,Stage];
         _cell.setGrayFilter();
      }
      
      override public function beDropHitCallBack(param1:GameDrag) : void
      {
         var _loc2_:MarketSellAlertFrame = null;
         var _loc3_:MarketItemCell = _cell as MarketItemCell;
         if(_loc3_ == null || _loc3_.data == null)
         {
            NotificationManager.instance.sendNotification("ITEM_DROP_BagNotic",[this]);
            return;
         }
         var _loc4_:MarketItemCell = param1.dropTarget as MarketItemCell;
         if(_loc4_ == null)
         {
            param1.stopImmediatePropagation();
            _loc3_.setNormalFilter();
            NotificationManager.instance.sendNotification("ITEM_DROP_BagNotic",[this]);
            return;
         }
         if(_loc3_.celltType == "BAG_TYPE")
         {
            if(_loc4_.celltType == "SELL_TYPE")
            {
               if(_loc4_.data == null)
               {
                  _loc2_ = ComponentFactory.Instance.creatComponentByStylename("market.MarketSellAlertFrame");
                  _loc2_.show(_loc3_.data,_loc4_.pos);
               }
               else
               {
                  MessageTipManager.instance().show(LanguageMgr.GetTranslation("mediator.market.MarketBagCellDropMediator.full"));
               }
            }
         }
         else if(_loc3_.celltType == "SELL_TYPE")
         {
            if(_loc4_.celltType == "BAG_TYPE")
            {
               model.marketToBag(_loc3_.data.pos,_loc3_.data.count);
            }
         }
         param1.stopImmediatePropagation();
         _loc3_.setNormalFilter();
         NotificationManager.instance.sendNotification("ITEM_DROP_BagNotic",[this]);
      }
      
      private function get model() : MarketModel
      {
         return CampaignManager.instance.marketModel;
      }
   }
}

