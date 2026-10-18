package gamebox.view
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.ui.image.Image;
   import com.pickgliss.ui.image.ScaleBitmapImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Bitmap;
   import manager.LanguageMgr;
   import managers.GameBoxManager;
   import yishi.datas.goods.GoodsInfo;
   import yishi.events.NotificationEvent;
   import yishi.manager.NotificationManager;
   
   public class GameBoxExchangeView extends Component
   {
      
      private var _bg:ScaleBitmapImage;
      
      private var _exchangeTxt:Bitmap;
      
      private var _exchangeTxtBg:Bitmap;
      
      private var _medalBg:Bitmap;
      
      private var _medal:Bitmap;
      
      private var _medalTxt:FilterFrameText;
      
      private var _medalDscTxt:FilterFrameText;
      
      private var _medalIcon:Image;
      
      private var _itemArr:Array;
      
      public function GameBoxExchangeView()
      {
         super();
         initView();
         addEvent();
      }
      
      private function initView() : void
      {
         var _loc2_:int = 0;
         var _loc1_:GameBoxExchangeItem = null;
         _bg = ComponentFactory.Instance.creatComponentByStylename("gamebox.rewardAreaBg");
         _exchangeTxt = ComponentFactory.Instance.creatBitmap("asset.gamebox.ExchangeTxtBgImg");
         _exchangeTxtBg = ComponentFactory.Instance.creatBitmap("asset.gamebox.ExchangeTxtImg");
         _medalBg = ComponentFactory.Instance.creatBitmap("asset.gamebox.MedalBg");
         _medal = ComponentFactory.Instance.creatBitmap("asset.gamebox.MedalTxt");
         _medalTxt = ComponentFactory.Instance.creatComponentByStylename("gamebox.medalTxt");
         _medalIcon = ComponentFactory.Instance.creatComponentByStylename("gamebox.GameboxMedalIcon0");
         _medalDscTxt = ComponentFactory.Instance.creatComponentByStylename("gamebox.medalDscTxt");
         addChild(_bg);
         addChild(_exchangeTxt);
         addChild(_exchangeTxtBg);
         addChild(_medalBg);
         addChild(_medal);
         addChild(_medalTxt);
         addChild(_medalIcon);
         addChild(_medalDscTxt);
         _medalDscTxt.text = LanguageMgr.GetTranslation("gamebox.view.medalDscTxt");
         var _loc3_:GoodsInfo = new GoodsInfo();
         _loc3_.templateId = -4000;
         _medalIcon.tipData = _loc3_.templateInfo.Description;
         _itemArr = [];
         _loc2_ = 1;
         while(_loc2_ < 5)
         {
            _loc1_ = ComponentFactory.Instance.creatCustomObject("gamebox.view.GameBoxExchangeItem" + _loc2_);
            addChild(_loc1_);
            _itemArr.push(_loc1_);
            _loc2_++;
         }
      }
      
      private function addEvent() : void
      {
         NotificationManager.instance.addEventListener("GAME_BOX_INFO",onInfo);
      }
      
      private function removeEvent() : void
      {
         NotificationManager.instance.removeEventListener("GAME_BOX_INFO",onInfo);
      }
      
      private function onInfo(param1:NotificationEvent) : void
      {
         updateView();
      }
      
      public function updateView() : void
      {
         var _loc2_:int = 0;
         var _loc1_:GameBoxExchangeItem = null;
         _loc2_ = 1;
         while(_loc2_ < 5)
         {
            _loc1_ = _itemArr[_loc2_ - 1];
            _loc1_.area = _loc2_;
            _loc2_++;
         }
         _medalTxt.text = GameBoxManager.instance.mode.info.gameBoxMedal.toString();
      }
      
      override public function dispose() : void
      {
         var _loc1_:int = 0;
         removeEvent();
         ObjectUtils.disposeObject(_bg);
         _bg = null;
         ObjectUtils.disposeObject(_exchangeTxt);
         _exchangeTxt = null;
         ObjectUtils.disposeObject(_exchangeTxtBg);
         _exchangeTxtBg = null;
         ObjectUtils.disposeObject(_medalBg);
         _medalBg = null;
         ObjectUtils.disposeObject(_medal);
         _medal = null;
         ObjectUtils.disposeObject(_medalTxt);
         _medalTxt = null;
         ObjectUtils.disposeObject(_medalDscTxt);
         _medalDscTxt = null;
         ObjectUtils.disposeObject(_medalIcon);
         _medalIcon = null;
         _loc1_ = 0;
         while(_loc1_ < _itemArr.length)
         {
            ObjectUtils.disposeObject(_itemArr[_loc1_]);
            _itemArr[_loc1_] = null;
            _loc1_++;
         }
         _itemArr = null;
         super.dispose();
      }
   }
}

