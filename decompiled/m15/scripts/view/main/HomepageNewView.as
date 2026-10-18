package view.main
{
   import com.pickgliss.ui.core.Disposeable;
   import flash.display.Sprite;
   import managers.ShopManager;
   import mvc.module.shop.ShopGoodsInfo;
   import view.GoodsItem;
   import yishi.events.NotificationEvent;
   import yishi.manager.NotificationManager;
   import yishi.manager.TempleteManager;
   
   public class HomepageNewView extends Sprite implements Disposeable
   {
      
      private var _itemList:Vector.<GoodsItem>;
      
      public function HomepageNewView()
      {
         super();
         initView();
         showList();
         initEvent();
      }
      
      private function initEvent() : void
      {
         NotificationManager.instance.addEventListener("SHOPHOMEPAGE_UPDATA",__updateHandler);
      }
      
      private function removeEvent() : void
      {
         NotificationManager.instance.removeEventListener("SHOPHOMEPAGE_UPDATA",__updateHandler);
      }
      
      private function __updateHandler(param1:NotificationEvent) : void
      {
         showList();
      }
      
      private function initView() : void
      {
         var _loc3_:int = 0;
         var _loc1_:GoodsItem = null;
         _itemList = new Vector.<GoodsItem>();
         var _loc4_:int = 0;
         var _loc2_:int = 0;
         _loc3_ = 0;
         while(_loc3_ < 6)
         {
            _loc1_ = new GoodsItem();
            _loc4_ = _loc3_ / 3;
            _loc2_ = _loc3_ % 3;
            _loc1_.x = _loc2_ * (_loc1_.width - 9) + 24;
            _loc1_.y = _loc4_ * (_loc1_.height - 9) + 225;
            addChild(_loc1_);
            _itemList.push(_loc1_);
            _loc3_++;
         }
      }
      
      public function showList() : void
      {
         var _loc3_:int = 0;
         var _loc2_:int = 0;
         var _loc1_:ShopGoodsInfo = null;
         var _loc4_:Array = ShopManager.Instance.model.mainNewList;
         if(!_loc4_)
         {
            return;
         }
         _loc3_ = 0;
         while(_loc3_ < 6)
         {
            _itemList[_loc3_].data = null;
            _loc3_++;
         }
         _loc3_ = 0;
         while(_loc3_ < _loc4_.length)
         {
            if(_loc2_ >= 6)
            {
               return;
            }
            if(_loc4_[_loc3_].types == 1)
            {
               _loc1_ = TempleteManager.instance.getShopTempInfoByItemId(_loc4_[_loc3_].shopId);
               if(_loc1_ && _loc1_.ItemId == _loc4_[_loc3_].templateId)
               {
                  _itemList[_loc2_].data = _loc1_;
                  _loc2_++;
               }
            }
            _loc3_++;
         }
      }
      
      public function dispose() : void
      {
         removeEvent();
         for each(var _loc1_:GoodsItem in _itemList)
         {
            _loc1_.dispose();
            _loc1_ = null;
         }
         _itemList = null;
      }
   }
}

