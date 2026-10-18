package pet.advanced.equipbag
{
   import cell.mediator.DoubleClickMediator;
   import com.pickgliss.utils.SoundManager;
   import flash.events.Event;
   import manager.LanguageMgr;
   import managers.PetEquipManager;
   import org.aswing.KeyboardManager;
   import yishi.manager.GoodsManager;
   import yishi.manager.NotificationManager;
   import yishi.manager.PlayerManager;
   import yishi.view.tips.MessageTipManager;
   
   public class PetEquipBagCellClickMediator extends DoubleClickMediator
   {
      
      public function PetEquipBagCellClickMediator()
      {
         super();
      }
      
      override protected function __mouseDoubleClick(param1:Event) : void
      {
         var _loc3_:String = null;
         var _loc2_:int = int(GoodsManager.instance.findEmputyPos());
         if(_loc2_ == -1)
         {
            _loc3_ = LanguageMgr.GetTranslation("cell.mediator.consortiabag.ConsortiaCaseCellClickMediator.command01");
            MessageTipManager.instance().show(_loc3_);
            return;
         }
         SoundManager.instance.play("024",true);
         _cell.setGrayFilter();
         PlayerManager.instance.moveBagToBag(_cell.bagType,_cell.objectId,_cell.pos,1,0,_loc2_,1,PetEquipManager.currSelectedPetData.petId);
      }
      
      override protected function __mouseClickByClicker(param1:Event) : void
      {
         var _loc2_:Boolean = Boolean(KeyboardManager.isDown(16));
         if(!_cell)
         {
            return;
         }
         if(!_cell.data)
         {
            NotificationManager.instance.sendNotification("SHOWPETBAG");
            return;
         }
         if(_loc2_)
         {
            NotificationManager.instance.sendNotification("SEND_GOODS",_cell.data);
            return;
         }
         NotificationManager.instance.sendNotification("DRAG_ITEM_BagNotic",[_cell,_cell.data.count]);
      }
   }
}

