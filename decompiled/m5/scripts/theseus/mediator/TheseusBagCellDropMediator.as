package theseus.mediator
{
   import com.pickgliss.utils.SoundManager;
   import flash.display.DisplayObject;
   import flash.display.Stage;
   import manager.LanguageMgr;
   import managers.TheseussoulManager;
   import theseus.item.TheseusBagCell;
   import theseus.item.TheseussoulEquipCell;
   import theseus.warFrame.item.WarframeQhCell;
   import yishi.manager.DragManager;
   import yishi.manager.NotificationManager;
   import yishi.utils.GameDrag;
   import yishi.view.tips.MessageTipManager;
   
   public class TheseusBagCellDropMediator extends WarDropMediator
   {
      
      public function TheseusBagCellDropMediator()
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
         _loc2_.dropChecks = [TheseusBagCell,TheseussoulEquipCell,WarframeQhCell,Stage];
         _cell.setGrayFilter();
      }
      
      override public function beDropHitCallBack(param1:GameDrag) : void
      {
         var _loc5_:WarframeQhCell = null;
         var _loc4_:int = 0;
         var _loc3_:TheseussoulEquipCell = null;
         var _loc2_:int = 0;
         var _loc7_:int = 0;
         _cell.isDraging = false;
         if(param1.dropTarget is WarframeQhCell)
         {
            _loc5_ = param1.dropTarget as WarframeQhCell;
            if(_cell.data.warTempInfo.Property6 != 1)
            {
               MessageTipManager.instance().show(LanguageMgr.GetTranslation("theseus.equip.QHtips"));
               return;
            }
            NotificationManager.instance.sendNotification("EventWarFrameInsPutIn",_cell.data.id);
            param1.stopImmediatePropagation();
            NotificationManager.instance.sendNotification("ITEM_DROP_BagNotic",[_cell]);
            return;
         }
         _cell.setNormalFilter();
         var _loc6_:Object = param1.dropTarget;
         if(_loc6_ != _cell)
         {
            if(_loc6_ is TheseussoulEquipCell)
            {
               _cell.setNormalFilter();
               _loc3_ = _loc6_ as TheseussoulEquipCell;
               if(_cell.data.warTempInfo.Property3 != _loc3_.sonType)
               {
                  param1.stopImmediatePropagation();
                  MessageTipManager.instance().show(LanguageMgr.GetTranslation("theseus.equip.putNo"));
                  return;
               }
               _loc2_ = int(TheseussoulManager.Instance.model.currSuitIdx);
               _loc7_ = int(_cell.data.warTempInfo.Property1);
               if(_loc2_ != _loc7_)
               {
                  param1.stopImmediatePropagation();
                  MessageTipManager.instance().show(LanguageMgr.GetTranslation("theseus.equip.suitNo"));
                  return;
               }
               TheseussoulManager.Instance.doWarFrameParam(7,_cell.data.id,_loc3_.pos);
            }
            else if(_loc6_ is TheseusBagCell)
            {
               _cell.setNormalFilter();
               SoundManager.instance.play("003");
               TheseussoulManager.Instance.doWarFrameParam(2,_cell.data.id,_loc6_.pos);
               param1.stopImmediatePropagation();
            }
            else
            {
               param1.stopImmediatePropagation();
            }
         }
         NotificationManager.instance.sendNotification("ITEM_DROP_BagNotic",[_cell]);
      }
   }
}

