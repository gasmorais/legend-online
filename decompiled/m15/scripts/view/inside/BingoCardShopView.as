package view.inside
{
   import com.pickgliss.loader.DisplayLoader;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.IconButton;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import yishi.datas.playerinfo.PlayerInfo;
   import yishi.datas.playerinfo.PlayerModel;
   import yishi.manager.BingoManager;
   import yishi.manager.PlayerManager;
   
   public class BingoCardShopView extends Component implements Disposeable
   {
      
      private var _preBtn:IconButton;
      
      private var _nextBtn:IconButton;
      
      private var _pageTxt:FilterFrameText;
      
      private var _goodList:Array;
      
      private var _currentPage:int = 1;
      
      private var _totalPage:int;
      
      private var _countGood:int = 0;
      
      public function BingoCardShopView()
      {
         super();
         initView();
         initEvent();
         updateView();
      }
      
      private function initView() : void
      {
         var _loc2_:int = 0;
         var _loc5_:* = undefined;
         var _loc3_:Sprite = null;
         _preBtn = ComponentFactory.Instance.creatComponentByStylename("stop.ComShopFramePrePageBtn");
         _nextBtn = ComponentFactory.Instance.creatComponentByStylename("stop.ComShopFrameNextPageBtn");
         _pageTxt = ComponentFactory.Instance.creatComponentByStylename("stop.ComShopFramePageTextStyle");
         addChild(_preBtn);
         _preBtn.enable = false;
         addChild(_nextBtn);
         addChild(_pageTxt);
         _pageTxt.text = "1/1";
         _goodList = [];
         var _loc4_:int = 0;
         var _loc1_:int = 0;
         _loc2_ = 0;
         while(_loc2_ < 9)
         {
            _loc4_ = _loc2_ / 3;
            _loc1_ = _loc2_ % 3;
            _loc5_ = DisplayLoader.Context.applicationDomain.getDefinition("view.GoodsItem10") as Class;
            _loc3_ = new _loc5_();
            _loc3_.x = _loc1_ * _loc3_.width + 7;
            _loc3_.y = _loc4_ * (_loc3_.height + 3) + 5;
            addChild(_loc3_);
            _goodList.push(_loc3_);
            _loc2_++;
         }
      }
      
      private function initEvent() : void
      {
         _preBtn.addEventListener("click",_preHandler);
         _nextBtn.addEventListener("click",_nextHandler);
      }
      
      private function removeEvent() : void
      {
         _preBtn.removeEventListener("click",_preHandler);
         _nextBtn.removeEventListener("click",_nextHandler);
      }
      
      private function _preHandler(param1:MouseEvent) : void
      {
         _currentPage = _currentPage - 1;
         updateView();
         updatePageView();
      }
      
      private function _nextHandler(param1:MouseEvent) : void
      {
         _currentPage = _currentPage + 1;
         updateView();
         updatePageView();
      }
      
      private function updateView() : void
      {
         var _loc2_:int = 0;
         var _loc1_:int = 0;
         _countGood = 0;
         var _loc3_:Array = BingoManager.instance.cardTempArr;
         if(_loc3_.length % 9 != 0 || _loc3_.length == 0)
         {
            _totalPage = _loc3_.length / 9 + 1;
         }
         else
         {
            _totalPage = _loc3_.length / 9;
         }
         _loc2_ = 0;
         while(_loc2_ < 9)
         {
            if(_currentPage - 1 < 0)
            {
               _loc1_ = _loc2_;
            }
            else
            {
               _loc1_ = _loc2_ + (_currentPage - 1) * 9;
            }
            if(_loc3_.length > _loc1_)
            {
               _countGood = _countGood + 1;
               _goodList[_loc2_].data = _loc3_[_loc1_];
            }
            else
            {
               _goodList[_loc2_].data = null;
            }
            _loc2_++;
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
      
      public function get currentPage() : int
      {
         return _currentPage;
      }
      
      public function set currentPage(param1:int) : void
      {
         _currentPage = param1;
      }
      
      private function get playerInfo() : PlayerInfo
      {
         return PlayerManager.instance.currentPlayerModel.playerInfo;
      }
      
      private function get playerModel() : PlayerModel
      {
         return PlayerManager.instance.currentPlayerModel;
      }
      
      override public function dispose() : void
      {
         removeEvent();
         if(_goodList)
         {
            while(_goodList.length)
            {
               ObjectUtils.disposeObject(_goodList.pop());
            }
            _goodList = null;
         }
         ObjectUtils.disposeObject(_preBtn);
         _preBtn = null;
         ObjectUtils.disposeObject(_nextBtn);
         _nextBtn = null;
         ObjectUtils.disposeObject(_pageTxt);
         _pageTxt = null;
         ObjectUtils.disposeAllChildren(this);
         ObjectUtils.disposeSelf(this);
      }
   }
}

