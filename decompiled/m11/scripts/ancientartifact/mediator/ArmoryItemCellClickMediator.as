package ancientartifact.mediator
{
   import ancientartifact.view.item.AncientArmoryGradeItem;
   import ancientartifact.view.item.AncientArmoryItem;
   import com.pickgliss.utils.DoubleClickManager;
   import events.AncientArtifactEvent;
   import flash.events.Event;
   import flash.geom.Point;
   import mvc.module.ancientartifact.AncientArmoryInfo;
   import mvc.module.ancientartifact.AncientArtifactModel;
   import yishi.interfaces.IMediator;
   import yishi.manager.AncientArtifactManager;
   import yishi.manager.NotificationManager;
   
   public class ArmoryItemCellClickMediator implements IMediator
   {
      
      private var _cell:AncientArmoryItem;
      
      public function ArmoryItemCellClickMediator()
      {
         super();
      }
      
      public function register(param1:Object) : void
      {
         _cell = param1 as AncientArmoryItem;
         if(_cell.iconItem)
         {
            DoubleClickManager.Instance.enableDoubleClick(_cell.iconItem);
            _cell.iconItem.addEventListener("interactive_click",__mouseClickByClicker);
            _cell.iconItem.addEventListener("interactive_double_click",__mouseDoubleClick);
         }
      }
      
      public function unregister(param1:Object) : void
      {
         if(_cell && _cell.iconItem)
         {
            DoubleClickManager.Instance.disableDoubleClick(_cell.iconItem);
            _cell.iconItem.removeEventListener("interactive_click",__mouseClickByClicker);
            _cell.iconItem.removeEventListener("interactive_double_click",__mouseDoubleClick);
            _cell = null;
         }
      }
      
      private function __mouseClickByClicker(param1:Event) : void
      {
         if(!_cell || !_cell.data)
         {
            return;
         }
         var _loc3_:Point = _cell.parent.localToGlobal(new Point(_cell.x,_cell.y));
         var _loc2_:AncientArmoryInfo = _cell.data;
         NotificationManager.instance.sendNotification("DRAG_ITEM_BagNotic",[_cell,_cell.data]);
      }
      
      private function __mouseDoubleClick(param1:Event) : void
      {
         var _loc3_:int = 0;
         if(!_cell || !_cell.data)
         {
            return;
         }
         var _loc2_:int = _cell.pos;
         var _loc4_:AncientArmoryInfo = _cell.data;
         if(model.currentArmoryIndx == 0)
         {
            AncientArtifactManager.instance.OperateArtifactReq(AncientArtifactManager.ARMORY_EQUIP,AncientArtifactManager.instance.selectTempId,0,false,_loc2_,0);
         }
         else if(model.currentArmoryIndx == 1)
         {
            model.chooseId = 0;
            model.dispatchEvent(new AncientArtifactEvent("ARMORY_BAG_UP_DATA"));
            model.dispatchEvent(new AncientArtifactEvent("ARMORY_CHOOSE_DATA",null));
         }
         else if(model.currentArmoryIndx == 2)
         {
            if(_cell.parent is AncientArmoryGradeItem)
            {
               if((_cell.parent as AncientArmoryGradeItem).type != 2)
               {
                  model.isGradeItemInfo = false;
                  model.chooseId = 0;
                  model.chooseList = [];
                  model.dispatchEvent(new AncientArtifactEvent("ARMORY_BAG_UP_DATA"));
                  model.dispatchEvent(new AncientArtifactEvent("ARMORY_CHOOSE_DATA",[null,-1]));
               }
            }
            else
            {
               _loc3_ = int(model.chooseList.indexOf(_loc4_.armoryId));
               if(_loc3_ >= 0)
               {
                  model.chooseList.splice(_loc3_,1);
                  model.dispatchEvent(new AncientArtifactEvent("ARMORY_BAG_UP_DATA"));
                  model.dispatchEvent(new AncientArtifactEvent("ARMORY_CHOOSE_DATA",[null,_cell.pos]));
               }
            }
         }
      }
      
      private function get noIsQuipPos() : int
      {
         var _loc5_:int = 0;
         var _loc3_:int = 0;
         var _loc2_:int = 0;
         var _loc4_:Array = [6,5,4,3,2,1];
         var _loc1_:int = 0;
         _loc3_ = 0;
         while(_loc3_ < _loc1_)
         {
            _loc2_ = int(_loc4_[_loc3_]);
            _loc5_ = int(model.getArmoryEquipIdByPos(_loc2_));
            if(_loc5_ == 0)
            {
               return _loc2_;
            }
            _loc3_ += 1;
         }
         return 0;
      }
      
      private function get model() : AncientArtifactModel
      {
         return AncientArtifactManager.instance.model;
      }
   }
}

