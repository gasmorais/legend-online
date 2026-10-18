package cell.mediator.playerequip
{
   import bag.helper.BagHelper;
   import cell.mediator.DoubleClickMediator;
   import com.pickgliss.utils.SoundManager;
   import flash.events.Event;
   import manager.LanguageMgr;
   import org.aswing.KeyboardManager;
   import yishi.datas.playerinfo.ThaneInfo;
   import yishi.manager.ArmyManager;
   import yishi.manager.GoodsManager;
   import yishi.manager.NotificationManager;
   import yishi.manager.PlayerManager;
   import yishi.view.tips.MessageTipManager;
   
   public class PlayerEquipBagCellClickMediator extends DoubleClickMediator
   {
      
      public function PlayerEquipBagCellClickMediator()
      {
         super();
      }
      
      override protected function __mouseDoubleClick(param1:Event) : void
      {
         var _loc2_:String = null;
         if(_cell.bagType == 4 && _cell.pos < 8)
         {
            if(_cell.data.isViceEquip)
            {
               _loc2_ = LanguageMgr.GetTranslation("armyII.viewII.equip.EquipView.EquipOpTips");
               MessageTipManager.instance().show(_loc2_);
               return;
            }
         }
         var _loc3_:int = GoodsManager.instance.findEmputyPos();
         if(_loc3_ == -1)
         {
            _loc2_ = LanguageMgr.GetTranslation("cell.mediator.consortiabag.ConsortiaCaseCellClickMediator.command01");
            MessageTipManager.instance().show(_loc2_);
            return;
         }
         SoundManager.instance.play("024",true);
         _cell.setGrayFilter();
         PlayerManager.instance.moveBagToBag(_cell.bagType,_cell.objectId,_cell.pos,1,0,_loc3_,1);
      }
      
      override protected function __mouseClickByClicker(param1:Event) : void
      {
         var _loc2_:String = null;
         var _loc4_:Boolean = KeyboardManager.isDown(16);
         var _loc3_:Boolean = BagHelper.instance.isSelling;
         if(_loc3_ || !_cell || !_cell.data)
         {
            return;
         }
         if(_loc4_)
         {
            NotificationManager.instance.sendNotification("SEND_GOODS",_cell.data);
            return;
         }
         if(_cell.bagType == 4 && _cell.pos < 8)
         {
            if(_cell.data.isViceEquip)
            {
               _loc2_ = LanguageMgr.GetTranslation("armyII.viewII.equip.EquipView.EquipOpTips");
               MessageTipManager.instance().show(_loc2_);
               return;
            }
         }
         NotificationManager.instance.sendNotification("DRAG_ITEM_BagNotic",[_cell,_cell.data.count]);
      }
      
      private function get thane() : ThaneInfo
      {
         return ArmyManager.instance.thane;
      }
   }
}

