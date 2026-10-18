package view.main
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.BaseButton;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.events.TimerEvent;
   import flash.utils.Timer;
   import managers.ShopManager;
   import yishi.events.NotificationEvent;
   import yishi.manager.NotificationManager;
   import yishi.view.community.PromotionItem;
   
   public class HomepageRightView extends Sprite implements Disposeable
   {
      
      private var _homepageTime:Timer;
      
      private var _countGood:int = 0;
      
      private var _bg:Bitmap;
      
      private var _preBtn:BaseButton;
      
      private var _nextBtn:BaseButton;
      
      private var _pageTxtBack:Bitmap;
      
      private var _pageTxt:FilterFrameText;
      
      private var _goodList:Array;
      
      private var _currentPage:int = 1;
      
      private var _totalPage:int;
      
      public function HomepageRightView()
      {
         super();
         initView();
         _updateView();
         initEvent();
      }
      
      private function initView() : void
      {
         var _loc1_:int = 0;
         var _loc2_:PromotionItem = null;
         _bg = ComponentFactory.Instance.creatBitmap("asset.shop.PromoBackImg");
         _preBtn = ComponentFactory.Instance.creatComponentByStylename("stop.prePageBtn");
         _nextBtn = ComponentFactory.Instance.creatComponentByStylename("stop.nextPageBtn");
         _pageTxtBack = ComponentFactory.Instance.creatBitmap("asset.stop.PageNumBack");
         _pageTxt = ComponentFactory.Instance.creatComponentByStylename("stop.PageTxt");
         _goodList = [];
         addChild(_bg);
         _loc1_ = 0;
         while(_loc1_ < 3)
         {
            _loc2_ = new PromotionItem();
            _loc2_.x = 700;
            _loc2_.y = (_loc2_.height - 3) * _loc1_ + 28;
            addChild(_loc2_);
            _goodList.push(_loc2_);
            _loc1_++;
         }
         addChild(_preBtn);
         addChild(_nextBtn);
         addChild(_pageTxtBack);
         addChild(_pageTxt);
         _pageTxt.text = "1/1";
      }
      
      private function initEvent() : void
      {
         NotificationManager.instance.addEventListener("SHOPHOMEPAGE_UPDATA",__updateHandler);
         _preBtn.addEventListener("click",_preHandler);
         _nextBtn.addEventListener("click",_nextHandler);
      }
      
      private function removeEvent() : void
      {
         NotificationManager.instance.removeEventListener("SHOPHOMEPAGE_UPDATA",__updateHandler);
         _preBtn.removeEventListener("click",_preHandler);
         _nextBtn.removeEventListener("click",_nextHandler);
      }
      
      private function _preHandler(param1:MouseEvent) : void
      {
         _currentPage = _currentPage - 1;
         _updateView();
         updatePageView();
      }
      
      private function _nextHandler(param1:MouseEvent) : void
      {
         _currentPage = _currentPage + 1;
         _updateView();
         updatePageView();
      }
      
      private function __updateHandler(param1:NotificationEvent) : void
      {
         if(_homepageTime)
         {
            _homepageTime.stop();
            _homepageTime.removeEventListener("timer",__updateTimeHandler);
         }
         _updateView();
      }
      
      private function _updateView() : void
      {
         var _loc3_:int = 0;
         var _loc2_:int = 0;
         _countGood = 0;
         var _loc1_:Array = ShopManager.Instance.model.mainDiscountList;
         if(_loc1_.length % 3 != 0 || _loc1_.length == 0)
         {
            _totalPage = _loc1_.length / 3 + 1;
         }
         else
         {
            _totalPage = _loc1_.length / 3;
         }
         _loc3_ = 0;
         while(_loc3_ < 3)
         {
            if(_currentPage - 1 < 0)
            {
               _loc2_ = _loc3_;
            }
            else
            {
               _loc2_ = _loc3_ + (_currentPage - 1) * 3;
            }
            if(_loc1_.length > _loc2_)
            {
               _countGood = _countGood + 1;
               _goodList[_loc3_].data = _loc1_[_loc2_];
            }
            else
            {
               _goodList[_loc3_].data = null;
            }
            _loc3_++;
         }
         if(_countGood > 0)
         {
            _homepageTime = new Timer(1000);
            _homepageTime.addEventListener("timer",__updateTimeHandler);
            _homepageTime.start();
            __updateTimeHandler(null);
         }
         updatePageView();
      }
      
      private function updatePageView() : void
      {
         _pageTxt.text = _currentPage + "/" + _totalPage;
         if(_currentPage == 1)
         {
            _preBtn.enable = false;
         }
         else
         {
            _preBtn.enable = true;
         }
         if(_currentPage == _totalPage)
         {
            _nextBtn.enable = false;
         }
         else
         {
            _nextBtn.enable = true;
         }
      }
      
      private function __updateTimeHandler(param1:TimerEvent) : void
      {
         var _loc2_:int = 0;
         var _loc3_:Number = NaN;
         _loc2_ = 0;
         while(_loc2_ < 3)
         {
            if(_goodList[_loc2_].data)
            {
               _loc3_ = Number(_goodList[_loc2_].data.remainTime);
               if(_loc3_ > 0)
               {
                  _goodList[_loc2_].timeText = _loc3_;
               }
               else
               {
                  _goodList[_loc2_].data = null;
                  _updateView();
               }
            }
            _loc2_++;
         }
      }
      
      public function dispose() : void
      {
         removeEvent();
         if(_homepageTime)
         {
            _homepageTime.stop();
            _homepageTime.removeEventListener("timer",__updateTimeHandler);
         }
         ObjectUtils.disposeAllChildren(this);
      }
   }
}

