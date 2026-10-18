package outyard
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.utils.ObjectUtils;
   import com.road.yishi.proto.hugehead.HugeHeadOpenTimeMsg;
   import com.road.yishi.proto.hugehead.HugeHeadStateMsg;
   import flash.display.DisplayObject;
   import yishi.events.NotificationEvent;
   import yishi.manager.NotificationManager;
   import yishi.manager.OutyardManager;
   
   public class OutyardOpeningView extends Component
   {
      
      private var _title:DisplayObject;
      
      private var _itemList:Array = [];
      
      public function OutyardOpeningView()
      {
         super();
         initView();
         addEvent();
      }
      
      private function initView() : void
      {
         var _loc1_:OutyardOpeningItem = null;
         var _loc2_:int = 0;
         _title = ComponentFactory.Instance.creatBitmap("asset.outyard.OpeningViewTitle");
         addChild(_title);
         _loc2_ = 0;
         while(_loc2_ < 4)
         {
            _loc1_ = new OutyardOpeningItem();
            _loc1_.index = _loc2_;
            _loc1_.x = 1;
            _loc1_.y = _loc2_ * 40 + 22;
            addChild(_loc1_);
            _itemList.push(_loc1_);
            _loc2_++;
         }
      }
      
      private function addEvent() : void
      {
         NotificationManager.instance.addEventListener("OUTYARD_STATE_INFO",__refreshOpeningHandler);
         __refreshOpeningHandler(null);
      }
      
      private function removeEvent() : void
      {
         NotificationManager.instance.removeEventListener("OUTYARD_STATE_INFO",__refreshOpeningHandler);
      }
      
      private function __refreshOpeningHandler(param1:NotificationEvent) : void
      {
         var _loc3_:OutyardOpeningItem = null;
         var _loc4_:int = 0;
         var _loc2_:HugeHeadStateMsg = OutyardManager.instance.model.stateMsg;
         if(!_loc2_)
         {
            return;
         }
         var _loc5_:Array = _loc2_.stackHeadOpenTime;
         _loc4_ = 0;
         while(_loc4_ < _itemList.length)
         {
            _loc3_ = _itemList[_loc4_] as OutyardOpeningItem;
            _loc3_.data = _loc5_[_loc4_] as HugeHeadOpenTimeMsg;
            _loc4_++;
         }
      }
      
      override public function dispose() : void
      {
         removeEvent();
         ObjectUtils.disposeObject(_title);
         _title = null;
         if(_itemList)
         {
            while(_itemList.length)
            {
               ObjectUtils.disposeObject(_itemList.pop());
            }
         }
         _itemList = null;
         super.dispose();
      }
   }
}

