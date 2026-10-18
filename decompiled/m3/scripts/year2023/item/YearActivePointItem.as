package year2023.item
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.image.Image;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Sprite;
   import managers.PlayerCurrencyManager;
   import yishi.events.NotificationEvent;
   import yishi.manager.NotificationManager;
   
   public class YearActivePointItem extends Sprite
   {
      
      private var _icon:Image;
      
      private var _numTxt:FilterFrameText;
      
      private var _numBg:Image;
      
      private var _hasYearGold:int = 0;
      
      public function YearActivePointItem()
      {
         super();
         initView();
         initEvent();
         updateYearGoldHandler();
      }
      
      public function get hasYearGold() : int
      {
         return _hasYearGold;
      }
      
      private function initView() : void
      {
         _icon = ComponentFactory.Instance.creatComponentByStylename("ui.yearactive.goldPriceIcon");
         _numTxt = ComponentFactory.Instance.creatComponentByStylename("ui.yearactive.goldPricenum");
         _numBg = ComponentFactory.Instance.creatComponentByStylename("ui.yearactive.goldPricebg");
         addChild(_numBg);
         addChild(_icon);
         addChild(_numTxt);
      }
      
      private function initEvent() : void
      {
         NotificationManager.instance.addEventListener("CURRENCYREFRESH",updateYearGoldHandler);
      }
      
      private function removeEvent() : void
      {
         NotificationManager.instance.removeEventListener("CURRENCYREFRESH",updateYearGoldHandler);
      }
      
      private function updateYearGoldHandler(param1:NotificationEvent = null) : void
      {
         if(PlayerCurrencyManager.instance.currencyInfo.yearGold)
         {
            _hasYearGold = PlayerCurrencyManager.instance.currencyInfo.yearGold.amount;
            _numTxt.text = "" + _hasYearGold;
         }
         else
         {
            _numTxt.text = "0";
         }
      }
      
      public function dispose() : void
      {
         removeEvent();
         ObjectUtils.disposeObject(_numBg);
         _numBg = null;
         ObjectUtils.disposeObject(_icon);
         _icon = null;
         ObjectUtils.disposeObject(_numTxt);
         _numTxt = null;
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}

