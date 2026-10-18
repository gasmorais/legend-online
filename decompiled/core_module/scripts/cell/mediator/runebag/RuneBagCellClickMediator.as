package cell.mediator.runebag
{
   import cell.view.runebag.RuneBagCell;
   import com.pickgliss.utils.DoubleClickManager;
   import com.pickgliss.utils.SoundManager;
   import flash.events.Event;
   import manager.LanguageMgr;
   import yishi.datas.goods.GoodsInfo;
   import yishi.datas.playerinfo.ThaneInfo;
   import yishi.interfaces.IMediator;
   import yishi.manager.ArmyManager;
   import yishi.manager.GoodsManager;
   import yishi.manager.NotificationManager;
   import yishi.manager.PlayerManager;
   import yishi.manager.TempleteManager;
   import yishi.view.tips.MessageTipManager;
   
   public class RuneBagCellClickMediator implements IMediator
   {
      
      private var _cell:RuneBagCell;
      
      private var _runeCarryTwoLevel:int = 40;
      
      private var _runeOpenLevel:int = 35;
      
      private var _runeSwallowMax:Number = 1000000000;
      
      public function RuneBagCellClickMediator()
      {
         super();
      }
      
      public function register(param1:Object) : void
      {
         _cell = param1 as RuneBagCell;
         if(_cell.icon)
         {
            DoubleClickManager.Instance.enableDoubleClick(_cell.icon);
            _cell.icon.addEventListener("interactive_click",__mouseClickByClicker);
            _cell.icon.addEventListener("interactive_double_click",__mouseDoubleClick);
            _runeCarryTwoLevel = int(TempleteManager.instance.getConfigInfoByConfigName("CarryTwoRune").ConfigValue);
            _runeOpenLevel = int(TempleteManager.instance.getConfigInfoByConfigName("OpenRuneGrade").ConfigValue);
         }
      }
      
      protected function __mouseClickByClicker(param1:Event) : void
      {
         if(!_cell || !_cell.data)
         {
            return;
         }
         NotificationManager.instance.sendNotification("DRAG_ITEM_BagNotic",[_cell,_cell.data.count]);
      }
      
      private function __mouseDoubleClick(param1:Event) : void
      {
         var _loc4_:int = 0;
         var _loc3_:String = null;
         if(!canDoubleClick)
         {
            return;
         }
         SoundManager.instance.play("024",true);
         var _loc2_:Array = GoodsManager.instance.getGoodsByBagType(0);
         var _loc6_:int = isRuneIntensifyPoint;
         if(_loc6_ == -1)
         {
            return;
         }
         for each(var _loc5_:GoodsInfo in _loc2_)
         {
            _loc4_ += _loc5_.count;
         }
         if(thane.runeInfo.swallowCount < _runeSwallowMax)
         {
            if(!thane.runeInfo.nextTemplateInfo)
            {
               _loc3_ = LanguageMgr.GetTranslation("armyII.viewII.rune.RuneUpgradeView.UpgradeTipTxt3");
               MessageTipManager.instance().show(_loc3_);
            }
            else if(_loc2_.length == 0 || thane.runeInfo.swallowCount + _loc4_ < _runeSwallowMax)
            {
               PlayerManager.instance.moveBagToBag(_cell.data.bagType,_cell.data.objectId,_cell.data.pos,0,0,_loc6_,1);
            }
            else
            {
               _loc3_ = LanguageMgr.GetTranslation("armyII.viewII.rune.RuneUpgradeView.UpgradeTipTxt5");
               MessageTipManager.instance().show(_loc3_);
            }
         }
         else
         {
            _loc3_ = LanguageMgr.GetTranslation("armyII.viewII.rune.RuneUpgradeView.UpgradeTipTxt1");
            MessageTipManager.instance().show(_loc3_);
         }
      }
      
      private function get thane() : ThaneInfo
      {
         return ArmyManager.instance.thane;
      }
      
      private function get isRuneIntensifyPoint() : int
      {
         var _loc2_:int = 0;
         var _loc3_:GoodsInfo = null;
         _loc2_ = 0;
         while(_loc2_ < 8)
         {
            _loc3_ = GoodsManager.instance.getHideBagItemByPos(_loc2_);
            if(_loc3_ == null)
            {
               return _loc2_;
            }
            _loc2_++;
         }
         var _loc1_:String = LanguageMgr.GetTranslation("cell.mediator.storebag.StoreBagCellClickMediator.command02");
         MessageTipManager.instance().show(_loc1_);
         return -1;
      }
      
      private function get canDoubleClick() : Boolean
      {
         if(!_cell.data)
         {
            return false;
         }
         return true;
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

