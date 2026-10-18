package theseusgodhead.mediator
{
   import com.pickgliss.utils.SoundManager;
   import flash.display.DisplayObject;
   import flash.display.Stage;
   import managers.TheseussoulManager;
   import mvc.module.theseus.TheseusGodheadStoneInfo;
   import theseusgodhead.UI.TheseusGodgrid;
   import theseusgodhead.UI.TheseusGodheadBagItem;
   import yishi.manager.DragManager;
   import yishi.manager.NotificationManager;
   import yishi.utils.GameDrag;
   
   public class TheseusBagCellDropMediator extends StoneDropMediator
   {
      
      public function TheseusBagCellDropMediator()
      {
         super();
      }
      
      override protected function starItemDrag(param1:int = -1) : void
      {
         var _loc3_:TheseusGodheadStoneInfo = null;
         if(TheseussoulManager.Instance.modelGodhead.isRotateMode)
         {
            _loc3_ = _cell.data;
            if(_loc3_)
            {
               TheseussoulManager.Instance.rotateSlate(_loc3_.stoneId);
            }
            return;
         }
         NotificationManager.instance.sendNotification("STONEUI_MOUSENABLECHANGE",false);
         SoundManager.instance.play("003");
         _cell.isDraging = true;
         _cell.setDragStatus(true);
         var _loc4_:DisplayObject = getDragIconObj();
         if(!_loc4_)
         {
            return;
         }
         var _loc2_:GameDrag = DragManager.getInstance().starDrag(_cell,{
            "icon":_loc4_,
            "type":"down"
         });
         _loc2_.data = param1;
         _loc2_.onDrop = beDropHitCallBack;
         _loc2_.dropChecks = [TheseusGodheadBagItem,TheseusGodgrid,Stage];
      }
      
      override public function beDropHitCallBack(param1:GameDrag) : void
      {
         var _loc4_:TheseusGodgrid = null;
         var _loc3_:TheseusGodheadStoneInfo = null;
         var _loc2_:int = 0;
         var _loc5_:Object = param1.dropTarget;
         _cell.isDraging = false;
         _cell.setDragStatus(false);
         if(_loc5_ is TheseusGodgrid)
         {
            _loc4_ = param1.dropTarget as TheseusGodgrid;
            _loc3_ = _cell.data;
            if(_loc3_)
            {
               if(isCanEquip(_loc4_.pos))
               {
                  _loc2_ = int(TheseussoulManager.Instance.modelGodhead.getPosByShapeandRotate(_loc3_,_loc4_.pos));
                  TheseussoulManager.Instance.movegirdSlatePos(_loc3_.stoneId,_loc2_);
               }
               NotificationManager.instance.sendNotification("refreshbaglist");
            }
            param1.stopImmediatePropagation();
            NotificationManager.instance.sendNotification("ITEM_DROP_BagNotic",[_cell]);
            return;
         }
         param1.stopImmediatePropagation();
         NotificationManager.instance.sendNotification("refreshbaglist");
         NotificationManager.instance.sendNotification("ITEM_DROP_BagNotic",[_cell]);
         NotificationManager.instance.sendNotification("STONEUI_MOUSENABLECHANGE",true);
      }
      
      private function isCanEquip(param1:int) : Boolean
      {
         var _loc2_:Array = TheseussoulManager.Instance.modelGodhead.getEquipedStoneInfo();
         return true;
      }
   }
}

