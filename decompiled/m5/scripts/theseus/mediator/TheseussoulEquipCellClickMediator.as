package theseus.mediator
{
   import com.pickgliss.utils.SoundManager;
   import flash.events.Event;
   import managers.TheseussoulManager;
   import mvc.module.theseus.WarFrameItemInfo;
   import yishi.manager.NotificationManager;
   
   public class TheseussoulEquipCellClickMediator extends WarDoubleMediator
   {
      
      public function TheseussoulEquipCellClickMediator()
      {
         super();
      }
      
      override protected function __mouseClickByClicker(param1:Event) : void
      {
         var _loc2_:WarFrameItemInfo = _cell.data;
         if(!_loc2_)
         {
            return;
         }
         NotificationManager.instance.sendNotification("DRAG_ITEM_BagNotic",[_cell,_loc2_.count]);
      }
      
      override protected function __mouseDoubleClick(param1:Event) : void
      {
         var _loc2_:* = null;
         if(!_cell.data)
         {
            return;
         }
         SoundManager.instance.play("024",true);
         var _loc3_:int = int(_cell.data.warTempInfo.Property1);
         TheseussoulManager.Instance.doWarFrameParam(8,_cell.data.id,_cell.pos);
      }
   }
}

