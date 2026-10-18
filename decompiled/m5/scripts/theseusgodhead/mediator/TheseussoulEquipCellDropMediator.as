package theseusgodhead.mediator
{
   import com.pickgliss.utils.SoundManager;
   import flash.display.DisplayObject;
   import flash.display.Stage;
   import managers.TheseussoulManager;
   import mvc.module.theseus.TheseusGodheadStoneInfo;
   import theseusgodhead.UI.TheseusGodgrid;
   import theseusgodhead.UI.TheseusGodheadBagItem;
   import theseusgodhead.UI.TheseusGodheadStoneUI;
   import yishi.manager.DragManager;
   import yishi.manager.NotificationManager;
   import yishi.utils.GameDrag;
   
   public class TheseussoulEquipCellDropMediator extends EquipDropMediator
   {
      
      public function TheseussoulEquipCellDropMediator()
      {
         super();
      }
      
      override protected function starItemDrag(param1:int = -1) : void
      {
         SoundManager.instance.play("003");
         var _loc3_:DisplayObject = getDragIconObj();
         if(!_loc3_)
         {
            return;
         }
         NotificationManager.instance.sendNotification("STONEUI_MOUSENABLECHANGE",false);
         var _loc2_:GameDrag = DragManager.getInstance().starDrag(_cell,{
            "icon":_loc3_,
            "type":"down"
         });
         _loc2_.data = param1;
         _loc2_.onDrop = beDropHitCallBack;
         _loc2_.dropChecks = [TheseusGodheadBagItem,TheseusGodgrid,TheseusGodheadStoneUI,Stage];
      }
      
      override public function beDropHitCallBack(param1:GameDrag) : void
      {
         var _loc3_:TheseusGodheadStoneInfo = null;
         var _loc2_:int = 0;
         var _loc4_:Object = param1.dropTarget;
         if(_loc4_ is TheseusGodheadStoneUI)
         {
            _loc3_ = _cell.stoneInfo();
            if(_loc3_)
            {
               TheseussoulManager.Instance.movebagSlatePos(_loc3_.stoneId,_loc3_.equipPos);
            }
            NotificationManager.instance.sendNotification("refreshGRID");
            param1.stopImmediatePropagation();
            NotificationManager.instance.sendNotification("ITEM_DROP_BagNotic",[_cell]);
            return;
         }
         if(_loc4_ is TheseusGodgrid)
         {
            _loc3_ = _cell.stoneInfo();
            if(_loc3_)
            {
               _loc2_ = int(TheseussoulManager.Instance.modelGodhead.getPosByShapeandRotate(_loc3_,_loc4_.pos));
               TheseussoulManager.Instance.movegirdSlatePos(_loc3_.stoneId,_loc2_);
            }
            NotificationManager.instance.sendNotification("refreshGRID");
         }
         else
         {
            _loc3_ = _cell.stoneInfo();
            if(_loc3_)
            {
               TheseussoulManager.Instance.movebagSlatePos(_loc3_.stoneId,_loc3_.equipPos);
            }
            NotificationManager.instance.sendNotification("refreshGRID");
         }
         param1.stopImmediatePropagation();
         NotificationManager.instance.sendNotification("ITEM_DROP_BagNotic",[_cell]);
         NotificationManager.instance.sendNotification("STONEUI_MOUSENABLECHANGE",true);
      }
   }
}

