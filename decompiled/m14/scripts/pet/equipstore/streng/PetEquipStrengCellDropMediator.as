package pet.equipstore.streng
{
   import cell.mediator.CellDropMediator;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.utils.SoundManager;
   import flash.display.DisplayObject;
   import flash.display.Stage;
   import yishi.manager.DragManager;
   import yishi.manager.NotificationManager;
   import yishi.manager.PlayerManager;
   import yishi.utils.GameDrag;
   import yishi.view.community.BaseItemView;
   
   public class PetEquipStrengCellDropMediator extends CellDropMediator
   {
      
      public function PetEquipStrengCellDropMediator()
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
               _loc2_ = int(param1.data > 0 ? param1.data : 1);
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
         PlayerManager.instance.moveBagToBag(param1.bagType,param1.objectId,param1.pos,1,0,0,1);
      }
   }
}

