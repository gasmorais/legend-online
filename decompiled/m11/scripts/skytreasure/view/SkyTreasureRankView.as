package skytreasure.view
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.BaseButton;
   import com.pickgliss.ui.controls.container.VBox;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import events.SkyTreasureEvent;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import manager.LanguageMgr;
   import mvc.module.skytreasure.SkyTreasureModel;
   import mvc.module.skytreasure.info.SkyTreasurePlayerRankInfoVO;
   import yishi.manager.SkyTreasureManager;
   
   public class SkyTreasureRankView extends Sprite implements Disposeable
   {
      
      private var _rankText:FilterFrameText;
      
      private var _nameText:FilterFrameText;
      
      private var _countText:FilterFrameText;
      
      private var _pageNumTxt:FilterFrameText;
      
      private var _preBtn:BaseButton;
      
      private var _nextBtn:BaseButton;
      
      private var _pageBg:Bitmap;
      
      private var _itemVBox:VBox;
      
      private var _currentPage:int = 1;
      
      private var _totalPage:int = 1;
      
      private var _itemList:Array = [];
      
      private var _model:SkyTreasureModel;
      
      public function SkyTreasureRankView()
      {
         super();
         _model = SkyTreasureManager.Instance.model;
         _itemList = _model.rankList;
         initView();
         initEvent();
         initVBoxData();
         refreshVBoxData();
      }
      
      private function initView() : void
      {
         _rankText = ComponentFactory.Instance.creatComponentByStylename("skyTreasureFrame.rankView.rankText");
         _nameText = ComponentFactory.Instance.creatComponentByStylename("skyTreasureFrame.rankView.nameText");
         _countText = ComponentFactory.Instance.creatComponentByStylename("skyTreasureFrame.rankView.countText");
         _rankText.text = LanguageMgr.GetTranslation("activity.skytreasure.ranktext");
         _nameText.text = LanguageMgr.GetTranslation("activity.skytreasure.nameText");
         _countText.text = LanguageMgr.GetTranslation("activity.skytreasure.countTex");
         _pageNumTxt = ComponentFactory.Instance.creatComponentByStylename("skyTreasureFrame.rankView.pageNumTxt");
         _preBtn = ComponentFactory.Instance.creatComponentByStylename("skytreasure.rankview.prePage");
         _nextBtn = ComponentFactory.Instance.creatComponentByStylename("skytreasure.rankview.nextPage");
         _pageBg = ComponentFactory.Instance.creatBitmap("asset.skytreasure.pageBg");
         _itemVBox = ComponentFactory.Instance.creatComponentByStylename("skyTreasureFrame.rankView.VBox");
         addChild(_rankText);
         addChild(_nameText);
         addChild(_countText);
         addChild(_preBtn);
         addChild(_nextBtn);
         addChild(_pageBg);
         addChild(_pageNumTxt);
         addChild(_itemVBox);
         initPageText();
         initBtnStatus();
      }
      
      private function initEvent() : void
      {
         if(_preBtn)
         {
            _preBtn.addEventListener("click",__preBtnHandler);
         }
         if(_nextBtn)
         {
            _nextBtn.addEventListener("click",__nextBtnHandler);
         }
         SkyTreasureManager.Instance.addEventListener("SKYTREASURE_RANK_UPDATE",rankUpdateHandler);
      }
      
      private function removeEvent() : void
      {
         if(_preBtn)
         {
            _preBtn.removeEventListener("click",__preBtnHandler);
         }
         if(_nextBtn)
         {
            _nextBtn.removeEventListener("click",__nextBtnHandler);
         }
         SkyTreasureManager.Instance.removeEventListener("SKYTREASURE_RANK_UPDATE",rankUpdateHandler);
      }
      
      private function rankUpdateHandler(param1:SkyTreasureEvent) : void
      {
         _itemList = _model.rankList;
         refreshView();
      }
      
      private function initPageText() : void
      {
         var _loc1_:int = 0;
         if(_model.rankList)
         {
            _loc1_ = int(_model.rankList.length);
         }
         _totalPage = Math.max(Math.ceil(_loc1_ / 10),1);
         _pageNumTxt.text = _currentPage + "/" + _totalPage;
      }
      
      private function initBtnStatus() : void
      {
         _preBtn.enable = _currentPage > 1;
         _nextBtn.enable = _currentPage < _totalPage;
         _pageNumTxt.text = _currentPage + "/" + _totalPage;
      }
      
      private function initVBoxData() : void
      {
         var _loc2_:int = 0;
         var _loc1_:SkyTreasureRankItem = null;
         if(_itemVBox)
         {
            _itemVBox.disposeAllChildren();
            _itemVBox.removeAllChild();
         }
         _loc2_ = 0;
         while(_loc2_ < 10)
         {
            _loc1_ = new SkyTreasureRankItem();
            _loc1_.height = 31;
            _loc1_.scaleY = 1;
            _itemVBox.addChild(_loc1_);
            _loc2_++;
         }
      }
      
      private function refreshVBoxData() : void
      {
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         if(!_itemList)
         {
            return;
         }
         var _loc1_:int = int(_itemList.length);
         if(_loc1_ > 10)
         {
            _loc2_ = 0;
            while(_loc2_ < 10)
            {
               (_itemVBox.getChildAt(_loc2_) as SkyTreasureRankItem).data = _itemList[_loc2_] as SkyTreasurePlayerRankInfoVO;
               _loc2_++;
            }
         }
         else
         {
            _loc3_ = 0;
            while(_loc3_ < _loc1_)
            {
               (_itemVBox.getChildAt(_loc3_) as SkyTreasureRankItem).data = _itemList[_loc3_] as SkyTreasurePlayerRankInfoVO;
               _loc3_++;
            }
         }
      }
      
      private function refreshView() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         initVBoxData();
         var _loc3_:Array = [];
         _loc1_ = (_currentPage - 1) * 10;
         while(_loc1_ < _currentPage * 10)
         {
            _loc3_.push(_itemList[_loc1_]);
            _loc1_++;
         }
         _loc2_ = 0;
         while(_loc2_ < 10)
         {
            (_itemVBox.getChildAt(_loc2_) as SkyTreasureRankItem).data = _loc3_[_loc2_] as SkyTreasurePlayerRankInfoVO;
            _loc2_++;
         }
      }
      
      private function __preBtnHandler(param1:MouseEvent) : void
      {
         _currentPage = _currentPage - 1;
         initBtnStatus();
         refreshView();
      }
      
      private function __nextBtnHandler(param1:MouseEvent) : void
      {
         _currentPage = _currentPage + 1;
         initBtnStatus();
         refreshView();
      }
      
      public function dispose() : void
      {
         removeEvent();
         ObjectUtils.disposeObject(_rankText);
         _rankText = null;
         ObjectUtils.disposeObject(_nameText);
         _nameText = null;
         ObjectUtils.disposeObject(_countText);
         _countText = null;
         ObjectUtils.disposeObject(_preBtn);
         _preBtn = null;
         ObjectUtils.disposeObject(_nextBtn);
         _nextBtn = null;
         ObjectUtils.disposeObject(_pageBg);
         _pageBg = null;
         ObjectUtils.disposeObject(_pageNumTxt);
         _pageNumTxt = null;
         ObjectUtils.disposeObject(_itemVBox);
         _itemVBox = null;
         ObjectUtils.disposeObject(_itemList);
         _itemList = [];
      }
   }
}

