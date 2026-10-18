package cathouse
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.utils.ObjectUtils;
   import managers.PlayerCurrencyManager;
   import mvc.module.currency.CurrencyInfo;
   import mvc.module.currency.CurrencyType;
   import mvc.module.currency.PlayerCurrencyInfo;
   import yishi.events.NotificationEvent;
   import yishi.manager.NotificationManager;
   
   public class CatHouseCurrencyBar extends Component
   {
      
      private const COUNT:int = 7;
      
      private var _itemList:Array = [];
      
      public function CatHouseCurrencyBar()
      {
         super();
         initView();
         addEvent();
      }
      
      private function initView() : void
      {
         var _loc2_:int = 0;
         var _loc1_:CatHouseCurrencyItem = null;
         _loc2_ = 0;
         while(_loc2_ < 7)
         {
            _loc1_ = ComponentFactory.Instance.creatCustomObject("cathouse.CatHouseCurrencyItem");
            _loc1_.x = 30 + _loc2_ * 100;
            _loc1_.y = 0;
            _loc1_.index = _loc2_;
            _loc1_.setWidth = 80;
            addChild(_loc1_);
            _itemList.push(_loc1_);
            _loc2_++;
         }
      }
      
      private function addEvent() : void
      {
         NotificationManager.instance.addEventListener("CURRENCYREFRESH",__currencyHandler);
         __currencyHandler(null);
      }
      
      private function removeEvent() : void
      {
         NotificationManager.instance.removeEventListener("CURRENCYREFRESH",__currencyHandler);
      }
      
      private function __currencyHandler(param1:NotificationEvent) : void
      {
         var _loc5_:CurrencyInfo = null;
         var _loc4_:int = 0;
         var _loc3_:CatHouseCurrencyItem = null;
         var _loc2_:PlayerCurrencyInfo = PlayerCurrencyManager.instance.currencyInfo;
         _loc4_ = 0;
         while(_loc4_ < 7)
         {
            _loc3_ = _itemList[_loc4_];
            _loc5_ = _loc2_.getCatToyCurrencyInfoByType(CurrencyType.CAT_TOY_TYPE_LIST[_loc4_]);
            _loc3_.value = _loc5_.amount;
            _loc4_++;
         }
      }
      
      override public function dispose() : void
      {
         removeEvent();
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

