package matelords
{
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Sprite;
   import mvc.module.matelords.MatelordsModel;
   import yishi.manager.MatelordsManager;
   
   public class MatelordsTopListView extends Sprite implements Disposeable
   {
      
      public static const LIST_NUM:int = 2;
      
      private var _itemList:Vector.<MatelordsTopItemView>;
      
      private var _tempItem:MatelordsTopItemView;
      
      private var _model:MatelordsModel = MatelordsManager.instance.model;
      
      public function MatelordsTopListView()
      {
         super();
         initView();
         addEvent();
      }
      
      private function initView() : void
      {
         var _loc1_:int = 0;
         _itemList = new Vector.<MatelordsTopItemView>();
         _loc1_ = 1;
         while(_loc1_ >= 0)
         {
            _tempItem = new MatelordsTopItemView(_loc1_ + 1);
            _tempItem.x = 100 + 300 * _loc1_;
            addChild(_tempItem);
            _itemList.push(_tempItem);
            _loc1_--;
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
         var _loc2_:int = 0;
         if(!_model.isSign)
         {
            for each(var _loc1_:MatelordsTopItemView in _itemList)
            {
               _loc1_.data = null;
            }
            return;
         }
         _loc2_ = 0;
         while(_loc2_ < _model.topPlayerList.length)
         {
            _itemList[_loc2_].data = _model.topPlayerList[_loc2_];
            _loc2_++;
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

