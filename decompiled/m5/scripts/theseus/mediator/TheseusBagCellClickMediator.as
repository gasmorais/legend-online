package theseus.mediator
{
   import com.pickgliss.utils.SoundManager;
   import flash.events.Event;
   import manager.LanguageMgr;
   import managers.TheseussoulManager;
   import mvc.module.theseus.WarFrameItemInfo;
   import theseus.warFrame.view.TheseusWarframeBagView;
   import yishi.datas.templates.RoyaltyTempInfo;
   import yishi.manager.NotificationManager;
   import yishi.manager.RoyaltyBossManager;
   import yishi.manager.TempleteManager;
   import yishi.view.tips.MessageTipManager;
   
   public class TheseusBagCellClickMediator extends WarDoubleMediator
   {
      
      private var openTheseus:int;
      
      public function TheseusBagCellClickMediator()
      {
         super();
         var _loc2_:int = int(RoyaltyBossManager.instance.model.royaltyLevel);
         var _loc1_:RoyaltyTempInfo = TempleteManager.instance.royaltyTempCate.getTempInfoByLevel(_loc2_);
         openTheseus = _loc1_.OpenTheseus;
      }
      
      override protected function __mouseClickByClicker(param1:Event) : void
      {
         var _loc2_:WarFrameItemInfo = _cell.data;
         if(!_loc2_)
         {
            return;
         }
         NotificationManager.instance.sendNotification("DRAG_ITEM_BagNotic",[_cell,_loc2_.count]);
      }
      
      override protected function __mouseDoubleClick(param1:Event) : void
      {
         var _loc5_:Array = null;
         var _loc4_:WarFrameItemInfo = _cell.data;
         if(!_loc4_)
         {
            return;
         }
         if(_cell.data.warTempInfo.Property6 != 1 && _cell.parent.parent is TheseusWarframeBagView)
         {
            MessageTipManager.instance().show(LanguageMgr.GetTranslation("theseus.equip.QHtips"));
            return;
         }
         if(_loc4_.warTempInfo.SonType != 720)
         {
            return;
         }
         if(_cell.parent.parent is TheseusWarframeBagView)
         {
            NotificationManager.instance.sendNotification("EventWarFrameInsPutIn",_cell.data.id);
            return;
         }
         var _loc2_:int = int(TheseussoulManager.Instance.model.currSuitIdx);
         var _loc7_:int = int(_loc4_.warTempInfo.Property1);
         if(openTheseus < _loc7_)
         {
            MessageTipManager.instance().show(LanguageMgr.GetTranslation("theseus.equip.suitNeedChoose"));
            return;
         }
         if(_loc2_ != _loc7_)
         {
            TheseussoulManager.Instance.model.currSuitIdx = _loc7_;
            _loc2_ = _loc7_;
         }
         var _loc3_:Array = getSontypePos(_loc4_.warTempInfo.Property3);
         var _loc6_:int = -1;
         if(_loc3_.length > 0)
         {
            _loc5_ = TheseussoulManager.Instance.model.suitInfo.getSuitArray(_loc2_);
            _loc6_ = int(_loc3_[0]);
            if(_loc3_.length > 1 && int(_loc5_[_loc6_]) > 0)
            {
               _loc6_ = int(_loc3_[1]);
            }
         }
         if(_loc6_ != -1)
         {
            SoundManager.instance.play("024",true);
            TheseussoulManager.Instance.doWarFrameParam(7,_cell.data.id,_loc6_);
         }
      }
      
      private function getSontypePos(param1:int) : Array
      {
         var _loc3_:int = 0;
         var _loc2_:Array = [];
         var _loc4_:Array = [0,2,3,4,1,5,8,8,9,9,6,7];
         _loc3_ = 0;
         while(_loc3_ < _loc4_.length)
         {
            if(_loc4_[_loc3_] == param1)
            {
               _loc2_.push(_loc3_);
            }
            _loc3_++;
         }
         return _loc2_;
      }
   }
}

