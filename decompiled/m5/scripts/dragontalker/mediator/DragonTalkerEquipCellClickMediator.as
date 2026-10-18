package dragontalker.mediator
{
   import com.pickgliss.utils.DoubleClickManager;
   import dragontalker.cell.DragonTalkerTalismanEquipCell;
   import flash.events.Event;
   import manager.LanguageMgr;
   import managers.DragonTalkerManager;
   import mvc.module.dragontalker.DragonTalkerModel;
   import yishi.interfaces.IMediator;
   import yishi.utils.MsgMan;
   import yishi.view.tips.MessageTipManager;
   
   public class DragonTalkerEquipCellClickMediator implements IMediator
   {
      
      private var _cell:DragonTalkerTalismanEquipCell;
      
      public function DragonTalkerEquipCellClickMediator()
      {
         super();
      }
      
      public function register(param1:Object) : void
      {
         _cell = param1 as DragonTalkerTalismanEquipCell;
         if(_cell.icon)
         {
            DoubleClickManager.Instance.enableDoubleClick(_cell.icon);
            _cell.icon.addEventListener("interactive_click",__mouseClickByClicker);
            _cell.icon.addEventListener("interactive_double_click",__mouseDoubleClick);
         }
      }
      
      public function unregister(param1:Object) : void
      {
         if(_cell && _cell.icon)
         {
            DoubleClickManager.Instance.disableDoubleClick(_cell.icon);
            _cell.icon.removeEventListener("interactive_click",__mouseClickByClicker);
            _cell.icon.removeEventListener("interactive_double_click",__mouseDoubleClick);
            _cell = null;
         }
      }
      
      protected function __mouseClickByClicker(param1:Event) : void
      {
         if(!_cell || !_cell.data)
         {
            return;
         }
         MsgMan.notifyObserver("DRAG_ITEM_BagNotic",{
            "cell":_cell,
            "data":_cell.data
         });
      }
      
      private function __mouseDoubleClick(param1:Event) : void
      {
         if(!canDoubleClick)
         {
            return;
         }
         if(model.bagViewType == 1)
         {
            if(model.getIsFullBySontype(_cell.data.goodsTempInfo.SonType))
            {
               MessageTipManager.instance().show(LanguageMgr.GetTranslation("DragonTalkerBagCell.equipNoType.bagIsFullAlert"));
               return;
            }
            DragonTalkerManager.instance.sendDragonTalkerTalismanReq(3,_cell.data.id);
            MsgMan.notifyObserver("TALISMAN_REMOVE_EQUIP",_cell.data);
         }
         else if(model.bagViewType != 2)
         {
            if(model.bagViewType != 3)
            {
            }
         }
      }
      
      private function get canDoubleClick() : Boolean
      {
         if(!_cell.data)
         {
            return false;
         }
         return true;
      }
      
      private function get model() : DragonTalkerModel
      {
         return DragonTalkerManager.instance.model;
      }
   }
}

