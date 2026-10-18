package armyII.viewII.stone.item
{
   import cell.mediator.CellDropMediator;
   import com.pickgliss.utils.SoundManager;
   import flash.display.DisplayObject;
   import flash.display.Stage;
   import manager.LanguageMgr;
   import managers.ArmySocketOutManager;
   import yishi.manager.DragManager;
   import yishi.manager.FrameControllerManager;
   import yishi.manager.NotificationManager;
   import yishi.utils.GameDrag;
   import yishi.view.tips.MessageTipManager;
   
   public class StoneBagCellDropMediator extends CellDropMediator
   {
      
      public function StoneBagCellDropMediator()
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
         _loc2_.dropChecks = [StoneBagCell,Stage];
         _cell.setGrayFilter();
      }
      
      override public function beDropHitCallBack(param1:GameDrag) : void
      {
         var _loc2_:int = 0;
         NotificationManager.instance.sendNotification("stopRuneEquipEff");
         _cell.isDraging = false;
         _cell.setNormalFilter();
         var _loc5_:StoneBagCell = param1.dropTarget as StoneBagCell;
         var _loc4_:StoneBagCell = _cell as StoneBagCell;
         var _loc3_:int = int(FrameControllerManager.instance.armyController.currOpRuneInfo.runeId);
         if(_loc5_)
         {
            if(_loc5_.bagType == 41 && _loc4_.bagType == 40)
            {
               if(_loc5_.xing == _loc4_.data.templateInfo.Property1)
               {
                  ArmySocketOutManager.sendEquipStone(_loc3_,_loc5_.pos,1,_cell.data.pos);
               }
               else
               {
                  MessageTipManager.instance().show(LanguageMgr.GetTranslation("army.stone.doEquipXing"));
               }
            }
            else if(_loc5_.bagType == 41 && _loc4_.bagType == 41)
            {
               ArmySocketOutManager.sendEquipStone(_loc3_,_loc5_.pos,2,_cell.data.pos);
            }
            else if(_loc4_.bagType == 41)
            {
               ArmySocketOutManager.sendUnEquipStone(_loc3_,_loc4_.pos);
            }
         }
         else if(_loc4_.bagType == 41)
         {
            ArmySocketOutManager.sendUnEquipStone(_loc3_,_loc4_.pos);
         }
         param1.stopImmediatePropagation();
         NotificationManager.instance.sendNotification("ITEM_DROP_BagNotic",[_cell]);
      }
   }
}

