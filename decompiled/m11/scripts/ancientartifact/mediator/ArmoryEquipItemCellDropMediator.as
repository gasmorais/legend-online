package ancientartifact.mediator
{
   import ancientartifact.view.item.AncientBagCell;
   import ancientartifact.view.item.AncientEquipArmoryItem;
   import com.pickgliss.utils.SoundManager;
   import events.AncientArtifactEvent;
   import flash.display.DisplayObject;
   import flash.display.Stage;
   import mvc.module.ancientartifact.AncientArmoryInfo;
   import mvc.module.ancientartifact.AncientArtifactModel;
   import yishi.events.NotificationEvent;
   import yishi.interfaces.IMediator;
   import yishi.manager.AncientArtifactManager;
   import yishi.manager.DragManager;
   import yishi.manager.NotificationManager;
   import yishi.utils.GameDrag;
   
   public class ArmoryEquipItemCellDropMediator implements IMediator
   {
      
      protected var _cell:AncientEquipArmoryItem;
      
      public function ArmoryEquipItemCellDropMediator()
      {
         super();
      }
      
      public function register(param1:Object) : void
      {
         _cell = param1 as AncientEquipArmoryItem;
         NotificationManager.instance.addEventListener("DRAG_ITEM_BagNotic",__dragItemBagHandler);
      }
      
      public function unregister(param1:Object) : void
      {
         NotificationManager.instance.removeEventListener("DRAG_ITEM_BagNotic",__dragItemBagHandler);
         _cell = null;
      }
      
      protected function __dragItemBagHandler(param1:NotificationEvent) : void
      {
         if(param1.data[1] && param1.data[0] == _cell && !DragManager.getInstance().isDraging)
         {
            starItemDrag(param1.data[1]);
         }
      }
      
      protected function starItemDrag(param1:AncientArmoryInfo) : void
      {
         SoundManager.instance.play("003");
         var _loc3_:DisplayObject = getDragIconObj();
         if(!_loc3_)
         {
            return;
         }
         var _loc2_:GameDrag = DragManager.getInstance().starDrag(_cell,{"icon":_loc3_});
         _loc2_.data = param1;
         _loc2_.onDrop = beDropHitCallBack;
         _loc2_.dropChecks = [AncientBagCell,Stage];
      }
      
      public function getDragIconObj() : DisplayObject
      {
         var _loc1_:AncientArmoryInfo = _cell.data;
         var _loc2_:AncientBagCell = new AncientBagCell();
         if(_loc1_)
         {
            _loc2_.data = _loc1_;
            _loc2_.mouseChildren = _loc2_.mouseEnabled = false;
            return _loc2_;
         }
         return null;
      }
      
      public function beDropHitCallBack(param1:GameDrag) : void
      {
         var _loc2_:int = 0;
         if(!_cell)
         {
            return;
         }
         var _loc3_:AncientArmoryInfo = _cell.data;
         if(param1.dropTarget != this)
         {
            if(param1.dropTarget is AncientBagCell)
            {
               if(model.currentArmoryIndx == 0)
               {
                  AncientArtifactManager.instance.OperateArtifactReq(AncientArtifactManager.ARMORY_EQUIP,AncientArtifactManager.instance.selectTempId,0,false,_cell.pos,0);
               }
               else if(model.currentArmoryIndx == 3)
               {
                  _loc2_ = int(model.chooseList.indexOf(_loc3_.armoryId));
                  if(_loc2_ >= 0)
                  {
                     model.chooseList.splice(_loc2_,1);
                     model.dispatchEvent(new AncientArtifactEvent("ARMORY_BAG_UP_DATA"));
                     model.dispatchEvent(new AncientArtifactEvent("ARMORY_CHOOSE_DATA"));
                  }
               }
               param1.stopImmediatePropagation();
            }
            else
            {
               param1.stopImmediatePropagation();
            }
            param1.stopImmediatePropagation();
         }
      }
      
      private function get model() : AncientArtifactModel
      {
         return AncientArtifactManager.instance.model;
      }
   }
}

