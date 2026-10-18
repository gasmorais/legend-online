package artifact
{
   import com.pickgliss.loader.DisplayLoader;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.BaseButton;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Bitmap;
   import flash.display.DisplayObject;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import managers.ShopManager;
   import yishi.datas.playerinfo.PlayerInfo;
   import yishi.datas.playerinfo.PlayerModel;
   import yishi.manager.PlayerManager;
   
   public class ArtifactShopView extends Sprite implements Disposeable
   {
      
      private var _shopNote:Bitmap;
      
      private var _preBtn:BaseButton;
      
      private var _nextBtn:BaseButton;
      
      private var _pageTxtBack:DisplayObject;
      
      private var _pageTxt:FilterFrameText;
      
      private var _goodList:Array;
      
      private var _currentPage:int = 1;
      
      private var _totalPage:int;
      
      private var _countGood:int = 0;
      
      public function ArtifactShopView()
      {
         super();
         initView();
         initEvent();
         updateView();
      }
      
      private function initView() : void
      {
         var _loc3_:int = 0;
         var _loc1_:* = undefined;
         var _loc4_:Sprite = null;
         _shopNote = ComponentFactory.Instance.creatBitmap("asset.artifact.shopNote");
         _nextBtn = ComponentFactory.Instance.creatComponentByStylename("artifact.NextPageBtn");
         _preBtn = ComponentFactory.Instance.creatComponentByStylename("artifact.LastPageBtn");
         _pageTxtBack = ComponentFactory.Instance.creatBitmap("asset.shop.pageNumBg");
         _pageTxt = ComponentFactory.Instance.creatComponentByStylename("artifact.PageTextStyle1");
         addChild(_shopNote);
         addChild(_preBtn);
         _preBtn.enable = false;
         addChild(_nextBtn);
         addChild(_pageTxtBack);
         _pageTxtBack.x = 414;
         _pageTxtBack.y = 284;
         addChild(_pageTxt);
         _pageTxt.text = "1/1";
         _goodList = [];
         var _loc5_:int = 0;
         var _loc2_:int = 0;
         _loc3_ = 0;
         while(_loc3_ < 4)
         {
            _loc5_ = _loc3_ / 2;
            _loc2_ = _loc3_ % 2;
            _loc1_ = DisplayLoader.Context.applicationDomain.getDefinition("view.GoodsItem9") as Class;
            _loc4_ = new _loc1_();
            _loc4_.x = _loc2_ * (_loc4_.width + 5) + 215;
            _loc4_.y = _loc5_ * (_loc4_.height - 5) + 28;
            addChild(_loc4_);
            _goodList.push(_loc4_);
            _loc3_++;
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
         var _loc5_:int = 0;
         var _loc3_:int = 0;
         var _loc2_:int = 0;
         _countGood = 0;
         var _loc4_:Array = ShopManager.Instance.model.artifactList;
         var _loc1_:Array = [];
         _loc5_ = 0;
         while(_loc5_ < _loc4_.length)
         {
            if(_loc4_[_loc5_].remainTime > 0)
            {
               _loc1_.push(_loc4_[_loc5_]);
            }
            _loc5_++;
         }
         if(_loc1_.length % 4 != 0 || _loc1_.length == 0)
         {
            _totalPage = _loc1_.length / 4 + 1;
         }
         else
         {
            _totalPage = _loc1_.length / 4;
         }
         _loc3_ = 0;
         while(_loc3_ < 4)
         {
            if(_currentPage - 1 < 0)
            {
               _loc2_ = _loc3_;
            }
            else
            {
               _loc2_ = _loc3_ + (_currentPage - 1) * 4;
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
      
      public function dispose() : void
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
         ObjectUtils.disposeObject(_shopNote);
         _shopNote = null;
         ObjectUtils.disposeObject(_preBtn);
         _preBtn = null;
         ObjectUtils.disposeObject(_nextBtn);
         _nextBtn = null;
         ObjectUtils.disposeObject(_pageTxtBack);
         _pageTxtBack = null;
         ObjectUtils.disposeObject(_pageTxt);
         _pageTxt = null;
         ObjectUtils.disposeAllChildren(this);
         ObjectUtils.disposeSelf(this);
      }
   }
}

