package theseus.war.mediator
{
   import cell.mediator.CellDropMediator;
   import com.pickgliss.utils.SoundManager;
   import flash.display.DisplayObject;
   import flash.display.Stage;
   import theseus.war.item.TheseusWarMetrailCell;
   import yishi.manager.DragManager;
   import yishi.manager.NotificationManager;
   import yishi.manager.PlayerManager;
   import yishi.utils.GameDrag;
   import yishi.view.community.BaseItemView;
   
   public class TheseusMetrialBagCellDropMediator extends CellDropMediator
   {
      
      public function TheseusMetrialBagCellDropMediator()
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
         _loc2_.dropChecks = [TheseusWarMetrailCell,Stage];
         _cell.setGrayFilter();
      }
      
      override public function beDropHitCallBack(param1:GameDrag) : void
      {
         var _loc2_:int = 0;
         _cell.isDraging = false;
         _cell.setNormalFilter();
         var _loc3_:TheseusWarMetrailCell = param1.dropTarget as TheseusWarMetrailCell;
         if(_loc3_)
         {
            if(_cell.data.templateInfo.SonType != _loc3_.sonType)
            {
               param1.stopImmediatePropagation();
               return;
            }
            _loc2_ = int(param1.data > 0 ? param1.data : 1);
            swapItem(_cell,_loc3_,_loc2_);
         }
         param1.stopImmediatePropagation();
         NotificationManager.instance.sendNotification("ITEM_DROP_BagNotic",[_cell]);
      }
      
      protected function swapItem(param1:BaseItemView, param2:TheseusWarMetrailCell, param3:int) : void
      {
         PlayerManager.instance.moveBagToBag(param1.data.bagType,param1.data.objectId,param1.data.pos,param2.bagType,param2.objectId,param2.pos,1);
      }
   }
}

