package dragontalker.mediator
{
   import com.pickgliss.utils.DoubleClickManager;
   import dragontalker.cell.DragonTalkerTalismanHandleCell;
   import flash.events.Event;
   import manager.LanguageMgr;
   import managers.DragonTalkerManager;
   import mvc.module.dragontalker.DragonTalkerModel;
   import yishi.interfaces.IMediator;
   import yishi.utils.MsgMan;
   import yishi.view.tips.MessageTipManager;
   
   public class DragonTalkerHandleCellClickMediator implements IMediator
   {
      
      private var _cell:DragonTalkerTalismanHandleCell;
      
      public function DragonTalkerHandleCellClickMediator()
      {
         super();
      }
      
      public function register(param1:Object) : void
      {
         _cell = param1 as DragonTalkerTalismanHandleCell;
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
         if(model.isOpenMutiIntensify)
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
         if(model.isOpenMutiIntensify)
         {
            return;
         }
         if(model.bagViewType == 1)
         {
            if(_cell.data.goodsTempInfo.SonType == 407)
            {
               MessageTipManager.instance().show(LanguageMgr.GetTranslation("DragonTalkerBagCell.equipNoType.expAlert"));
               return;
            }
            DragonTalkerManager.instance.sendDragonTalkerTalismanReq(3,_cell.data.id);
         }
         else if(model.bagViewType == 2 || model.bagViewType == 3)
         {
            model.hideCellDic.del(_cell.cellType + "_" + _cell.posType);
            MsgMan.notifyObserver("HIDE_DIC_CHANGE");
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

