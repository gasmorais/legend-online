package heroroad
{
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.utils.ObjectUtils;
   import utils.LogicUtils;
   import yishi.events.NotificationEvent;
   import yishi.manager.HeroRoadManager;
   import yishi.manager.NotificationManager;
   
   public class HeroRoadBoxItemView extends Component
   {
      
      private var _itemList:Array = [];
      
      public function HeroRoadBoxItemView()
      {
         super();
         initView();
         initEvent();
      }
      
      private function initView() : void
      {
      }
      
      private function initEvent() : void
      {
         NotificationManager.instance.addEventListener("HEROROAD_UPDATE_VIEW",__updateViewHandler);
         __updateViewHandler(null);
      }
      
      private function removeEvent() : void
      {
         NotificationManager.instance.removeEventListener("HEROROAD_UPDATE_VIEW",__updateViewHandler);
      }
      
      private function __updateViewHandler(param1:NotificationEvent) : void
      {
         var _loc3_:HeroRoadBoxItem = null;
         var _loc4_:int = 0;
         while(_itemList.length)
         {
            ObjectUtils.disposeObject(_itemList.pop());
         }
         var _loc2_:Array = HeroRoadManager.instance.getItemsByMasterType(HeroRoadManager.MASTER_DAY);
         _loc4_ = 0;
         while(_loc4_ < _loc2_.length)
         {
            _loc3_ = new HeroRoadBoxItem();
            _loc3_.x = 32 + _loc4_ * 136;
            _loc3_.y = 23;
            _loc3_.index = _loc4_ + 1;
            _loc3_.data = _loc2_[_loc4_];
            addChild(_loc3_);
            _itemList.push(_loc3_);
            _loc4_++;
         }
         _loc2_ = HeroRoadManager.instance.getItemsByMasterType(HeroRoadManager.MASTER_VIP);
         _loc4_ = 0;
         while(_loc4_ < _loc2_.length)
         {
            _loc3_ = new HeroRoadBoxItem();
            _loc3_.x = 519 + _loc4_ * 136;
            _loc3_.y = 23;
            _loc3_.index = _loc4_ + 4;
            _loc3_.data = _loc2_[_loc4_];
            addChild(_loc3_);
            _itemList.push(_loc3_);
            _loc4_++;
         }
      }
      
      override public function dispose() : void
      {
         removeEvent();
         LogicUtils.disposeDisplayCollection(_itemList);
         _itemList = null;
         super.dispose();
      }
   }
}

