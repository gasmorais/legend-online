package monster.mediator
{
   import com.pickgliss.utils.DoubleClickManager;
   import flash.events.Event;
   import manager.LanguageMgr;
   import monster.cell.MonsterAccessoriesBagCell;
   import mvc.module.monster.MonsterModel;
   import org.aswing.KeyboardManager;
   import yishi.interfaces.IMediator;
   import yishi.manager.MonsterManager;
   import yishi.manager.NotificationManager;
   import yishi.manager.PlayerManager;
   import yishi.view.tips.MessageTipManager;
   
   public class MonsterAccessoriesBagCellClickMediator implements IMediator
   {
      
      private var _cell:MonsterAccessoriesBagCell;
      
      public function MonsterAccessoriesBagCellClickMediator()
      {
         super();
      }
      
      public function register(param1:Object) : void
      {
         _cell = param1 as MonsterAccessoriesBagCell;
         if(_cell)
         {
            DoubleClickManager.Instance.enableDoubleClick(_cell);
            _cell.addEventListener("interactive_click",__mouseClickByClicker);
            _cell.addEventListener("interactive_double_click",__mouseDoubleClick);
         }
      }
      
      public function unregister(param1:Object) : void
      {
         if(_cell)
         {
            DoubleClickManager.Instance.disableDoubleClick(_cell);
            _cell.removeEventListener("interactive_click",__mouseClickByClicker);
            _cell.removeEventListener("interactive_double_click",__mouseDoubleClick);
            _cell = null;
         }
      }
      
      protected function __mouseClickByClicker(param1:Event) : void
      {
         var _loc2_:Boolean = Boolean(KeyboardManager.isDown(16));
         if(!_cell || !_cell.data)
         {
            return;
         }
         if(_loc2_)
         {
            NotificationManager.instance.sendNotification("SEND_GOODS",_cell.data);
            return;
         }
         if(model && model.isStrengethenPanel && _cell.data.templateInfo.SonType != 232)
         {
            return;
         }
         if(_cell.data.templateInfo.SonType == 233)
         {
            MessageTipManager.instance().show(LanguageMgr.GetTranslation("cell.mediator.playerbag.PlayerBagCellDropMediator.command02"));
         }
         else
         {
            NotificationManager.instance.sendNotification("DRAG_ITEM_BagNotic",[_cell,1]);
         }
      }
      
      private function __mouseDoubleClick(param1:Event) : void
      {
         if(!canDoubleClick)
         {
            return;
         }
         if(model && model.isStrengethenPanel && _cell.data.templateInfo.SonType != 232)
         {
            return;
         }
         if(_cell.data.templateInfo.SonType == 232)
         {
            PlayerManager.instance.moveBagToBag(_cell.data.bagType,_cell.data.objectId,_cell.data.pos,0,0,0,1);
         }
         else if(_cell.data.templateInfo.SonType == 233)
         {
            MessageTipManager.instance().show(LanguageMgr.GetTranslation("cell.mediator.playerbag.PlayerBagCellDropMediator.command02"));
         }
         else if(model.getEmptyPos > 0)
         {
            PlayerManager.instance.moveBagToBag(_cell.data.bagType,_cell.data.objectId,_cell.data.pos,0,0,model.getEmptyPos,1);
         }
         else
         {
            MessageTipManager.instance().show(LanguageMgr.GetTranslation("cell.mediator.storebag.StoreBagCellClickMediator.command02"));
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
      
      private function get model() : MonsterModel
      {
         return MonsterManager.instance.model;
      }
   }
}

