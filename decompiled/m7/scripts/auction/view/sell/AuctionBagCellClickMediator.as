package auction.view.sell
{
   import com.pickgliss.utils.DoubleClickManager;
   import com.pickgliss.utils.SoundManager;
   import flash.events.Event;
   import manager.LanguageMgr;
   import yishi.interfaces.IMediator;
   import yishi.manager.NotificationManager;
   import yishi.view.tips.MessageTipManager;
   
   public class AuctionBagCellClickMediator implements IMediator
   {
      
      private var _cell:AuctionSellBagCell;
      
      public function AuctionBagCellClickMediator()
      {
         super();
      }
      
      public function register(param1:Object) : void
      {
         _cell = param1 as AuctionSellBagCell;
         if(_cell.icon)
         {
            DoubleClickManager.Instance.enableDoubleClick(_cell.icon);
            _cell.icon.addEventListener("interactive_click",__mouseClickByClicker);
            _cell.icon.addEventListener("interactive_double_click",__mouseDoubleClick);
         }
      }
      
      protected function __mouseClickByClicker(param1:Event) : void
      {
         var _loc2_:String = null;
         if(!_cell || !_cell.data || !_cell.isNormalFilter)
         {
            return;
         }
         if(_cell.data.isLock)
         {
            _loc2_ = LanguageMgr.GetTranslation("vicepassword.description10");
            MessageTipManager.instance().show(_loc2_);
            return;
         }
         NotificationManager.instance.sendNotification("DRAG_ITEM_BagNotic",[_cell,_cell.data.count]);
      }
      
      private function __mouseDoubleClick(param1:Event) : void
      {
         var _loc2_:String = null;
         if(!_cell || !_cell.data || !_cell.isNormalFilter)
         {
            return;
         }
         SoundManager.instance.play("024",true);
         if(_cell.data.isLock)
         {
            _loc2_ = LanguageMgr.GetTranslation("vicepassword.description10");
            MessageTipManager.instance().show(_loc2_);
            return;
         }
         AuctionGoodMoveControl.moveToTargetCell(_cell);
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
   }
}

