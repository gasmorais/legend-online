package apex
{
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Sprite;
   import mvc.module.apex.ApexModel;
   import yishi.manager.ApexManager;
   
   public class ApexHallPlayerList extends Sprite implements Disposeable
   {
      
      public static const LIST_NUM:int = 4;
      
      private var _itemList:Vector.<ApexHallPlayerItem>;
      
      private var _tempItem:ApexHallPlayerItem;
      
      private var _model:ApexModel = ApexManager.instance.model;
      
      public function ApexHallPlayerList()
      {
         super();
         initView();
         addEvent();
      }
      
      private function initView() : void
      {
         var _loc1_:int = 0;
         _itemList = new Vector.<ApexHallPlayerItem>();
         _loc1_ = 0;
         while(_loc1_ < 4)
         {
            _tempItem = new ApexHallPlayerItem(_loc1_ + 1);
            _tempItem.x = 9 + 176 * _loc1_;
            _tempItem.y = 102;
            addChild(_tempItem);
            _itemList.push(_tempItem);
            _loc1_++;
         }
         _tempItem = null;
      }
      
      private function uninitView() : void
      {
         while(_itemList && _itemList.length > 0)
         {
            _itemList.pop().dispose();
         }
         _itemList = null;
         _tempItem = null;
         ObjectUtils.disposeAllChildren(this);
      }
      
      private function addEvent() : void
      {
      }
      
      private function removeEvent() : void
      {
      }
      
      public function refresh() : void
      {
         var _loc1_:int = 0;
         _loc1_ = 0;
         while(_loc1_ < _model.lastWinnerPlayerList.length)
         {
            _itemList[_loc1_].data = _model.lastWinnerPlayerList[_loc1_];
            _loc1_++;
         }
      }
      
      public function dispose() : void
      {
         removeEvent();
         uninitView();
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}

