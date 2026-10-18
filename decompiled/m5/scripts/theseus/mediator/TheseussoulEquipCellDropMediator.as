package theseus.mediator
{
   import com.pickgliss.utils.SoundManager;
   import flash.display.DisplayObject;
   import flash.display.Stage;
   import managers.TheseussoulManager;
   import theseus.item.TheseusBagCell;
   import yishi.manager.DragManager;
   import yishi.manager.NotificationManager;
   import yishi.utils.GameDrag;
   import yishi.view.community.BaseWarItem;
   
   public class TheseussoulEquipCellDropMediator extends WarDropMediator
   {
      
      public function TheseussoulEquipCellDropMediator()
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
         var _loc2_:GameDrag = DragManager.getInstance().starDrag(_cell,{
            "icon":_loc3_,
            "type":"down"
         });
         _loc2_.data = param1;
         _loc2_.onDrop = beDropHitCallBack;
         _loc2_.dropChecks = [TheseusBagCell,Stage];
         _cell.setGrayFilter();
      }
      
      override public function beDropHitCallBack(param1:GameDrag) : void
      {
         var _loc3_:int = 0;
         var _loc2_:int = 0;
         _cell.isDraging = false;
         _cell.setNormalFilter();
         var _loc4_:BaseWarItem = param1.dropTarget as BaseWarItem;
         if(_loc4_ is TheseusBagCell)
         {
            _loc2_ = int(_cell.data.warTempInfo.Property1);
            TheseussoulManager.Instance.doWarFrameParam(8,_cell.data.id,_cell.pos);
         }
         param1.stopImmediatePropagation();
         NotificationManager.instance.sendNotification("ITEM_DROP_BagNotic",[_cell]);
      }
   }
}

