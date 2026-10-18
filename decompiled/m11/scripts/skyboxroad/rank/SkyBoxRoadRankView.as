package skyboxroad.rank
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.IconButton;
   import com.pickgliss.ui.controls.container.VBox;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.ui.image.Image;
   import com.pickgliss.ui.image.MutipleImage;
   import com.pickgliss.ui.image.ScaleLeftRightImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import com.pickgliss.utils.SoundManager;
   import flash.display.Bitmap;
   import flash.events.MouseEvent;
   import manager.LanguageMgr;
   import managers.SkyboxRoadManager;
   import mvc.module.skyboxroad.SkyboxRoadModel;
   import utils.LogicUtils;
   import yishi.utils.DateFormatter;
   import yishi.utils.PageUtils;
   
   public class SkyBoxRoadRankView extends Component
   {
      
      private var _back:MutipleImage;
      
      private var _myRankBit:Bitmap;
      
      private var _myRankBack:ScaleLeftRightImage;
      
      private var _timeBit:Bitmap;
      
      private var _timeBack:ScaleLeftRightImage;
      
      private var _itemList:Array = [];
      
      private var _vBox:VBox;
      
      private var _pageBg:Image;
      
      private var _pageTxt:FilterFrameText;
      
      private var _lastPageBtn:IconButton;
      
      private var _nextPageBtn:IconButton;
      
      private var _titleTxt01:FilterFrameText;
      
      private var _titleTxt02:FilterFrameText;
      
      private var _titleTxt03:FilterFrameText;
      
      private var _titleTxt04:FilterFrameText;
      
      private var _myRankTxt:FilterFrameText;
      
      private var _rankTimeTxt:FilterFrameText;
      
      private var _rankTipTxt:FilterFrameText;
      
      private var _totalPage:int;
      
      private var _curPage:int = 1;
      
      private var _tableIndex:int;
      
      public function SkyBoxRoadRankView()
      {
         super();
         initView();
         addEvent();
         updateView();
      }
      
      private function initView() : void
      {
         var _loc2_:int = 0;
         var _loc1_:SkyBoxRoadRankItem = null;
         _back = ComponentFactory.Instance.creatComponentByStylename("skysecretarea.rankBack");
         _pageBg = ComponentFactory.Instance.creatComponentByStylename("skysecretarea.pageBg");
         _lastPageBtn = ComponentFactory.Instance.creatComponentByStylename("skysecretarea.LastPageBtn");
         _nextPageBtn = ComponentFactory.Instance.creatComponentByStylename("skysecretarea.NextPageBtn");
         _pageTxt = ComponentFactory.Instance.creatComponentByStylename("skysecretarea.PageTextStyle");
         _myRankBit = ComponentFactory.Instance.creatBitmap("asset.skysecretarea.rankBg6");
         _myRankBack = ComponentFactory.Instance.creatComponentByStylename("skysecretarea.textBg1");
         _timeBit = ComponentFactory.Instance.creatBitmap("asset.skysecretarea.dayTime");
         _timeBack = ComponentFactory.Instance.creatComponentByStylename("skysecretarea.textBg2");
         _titleTxt01 = ComponentFactory.Instance.creatComponentByStylename("skysecretarea.rankTitle01");
         _titleTxt02 = ComponentFactory.Instance.creatComponentByStylename("skysecretarea.rankTitle02");
         _titleTxt03 = ComponentFactory.Instance.creatComponentByStylename("skysecretarea.rankTitle03");
         _titleTxt04 = ComponentFactory.Instance.creatComponentByStylename("skysecretarea.rankTitle04");
         _myRankTxt = ComponentFactory.Instance.creatComponentByStylename("skysecretarea.rankTxt");
         _rankTimeTxt = ComponentFactory.Instance.creatComponentByStylename("skysecretarea.rankTimeTxt");
         _rankTipTxt = ComponentFactory.Instance.creatComponentByStylename("skysecretarea.rankTipTxt");
         addChild(_back);
         addChild(_pageBg);
         addChild(_lastPageBtn);
         addChild(_nextPageBtn);
         addChild(_pageTxt);
         addChild(_myRankBit);
         addChild(_myRankBack);
         addChild(_timeBit);
         addChild(_timeBack);
         addChild(_titleTxt01);
         addChild(_titleTxt02);
         addChild(_titleTxt03);
         addChild(_titleTxt04);
         addChild(_myRankTxt);
         addChild(_rankTimeTxt);
         addChild(_rankTipTxt);
         _titleTxt01.text = LanguageMgr.GetTranslation("skysecretareaView.rankTitle01");
         _titleTxt02.text = LanguageMgr.GetTranslation("skysecretareaView.rankTitle02");
         _titleTxt03.text = LanguageMgr.GetTranslation("skysecretareaView.rankTitle03");
         _titleTxt04.text = LanguageMgr.GetTranslation("skysecretareaView.rankTitle04");
         _myRankTxt.text = LanguageMgr.GetTranslation("skysecretareaView.rankTips01");
         _rankTimeTxt.text = "00:00:00";
         _rankTipTxt.text = LanguageMgr.GetTranslation("skysecretareaView.rankTips02");
         _vBox = new VBox();
         addChild(_vBox);
         _vBox.spacing = 2;
         _vBox.y = 37;
         _loc2_ = 0;
         while(_loc2_ < 8)
         {
            _loc1_ = new SkyBoxRoadRankItem();
            _vBox.addChild(_loc1_);
            _itemList.push(_loc1_);
            _loc2_ += 1;
         }
      }
      
      private function addEvent() : void
      {
         _lastPageBtn.addEventListener("click",__onPageBtnHandler);
         _nextPageBtn.addEventListener("click",__onPageBtnHandler);
      }
      
      private function remveEvent() : void
      {
         if(_lastPageBtn)
         {
            _lastPageBtn.removeEventListener("click",__onPageBtnHandler);
         }
         if(_nextPageBtn)
         {
            _nextPageBtn.removeEventListener("click",__onPageBtnHandler);
         }
      }
      
      private function __onPageBtnHandler(param1:MouseEvent) : void
      {
         SoundManager.instance.play("022");
         switch(param1.currentTarget)
         {
            case _nextPageBtn:
               _curPage = _curPage + 1;
               break;
            case _lastPageBtn:
               _curPage = _curPage - 1;
         }
         refreshView();
      }
      
      private function refreshView() : void
      {
         var _loc4_:int = 0;
         var _loc2_:SkyBoxRoadRankItem = null;
         var _loc5_:Array = model.showRankListByType(_tableIndex);
         _totalPage = PageUtils.getTotalPages(_loc5_,8);
         if(_totalPage <= 0)
         {
            _totalPage = 1;
         }
         setPageEnable();
         var _loc1_:Array = PageUtils.getTargetPageList(_loc5_,_curPage,8) as Array;
         if(!_loc1_)
         {
            _loc1_ = [];
         }
         var _loc3_:int = int(_loc1_.length);
         _loc4_ = 0;
         while(_loc4_ < 8)
         {
            _loc2_ = _itemList[_loc4_];
            _loc2_.visible = false;
            if(_loc4_ < _loc3_)
            {
               _loc2_.visible = true;
               _loc2_.data = _loc1_[_loc4_];
            }
            _loc4_ += 1;
         }
         _pageTxt.text = _curPage + "/" + _totalPage;
      }
      
      private function setPageEnable() : void
      {
         _lastPageBtn.enable = _curPage > 1;
         _nextPageBtn.enable = _curPage < _totalPage;
      }
      
      public function set tableIndex(param1:int) : void
      {
         _tableIndex = param1;
         if(param1 == 0)
         {
            _timeBit.bitmapData = ComponentFactory.Instance.creatBitmapData("asset.skysecretarea.dayTime");
         }
         else
         {
            _timeBit.bitmapData = ComponentFactory.Instance.creatBitmapData("asset.skysecretarea.weekTime");
         }
         updateView();
      }
      
      public function updateView() : void
      {
         _curPage = 1;
         refreshView();
         if(!model.myRank)
         {
            return;
         }
         if(_tableIndex == 0)
         {
            if(model.myRank.dayOrder <= 100)
            {
               _myRankTxt.text = String(model.myRank.dayOrder);
            }
            else
            {
               _myRankTxt.text = LanguageMgr.GetTranslation("skysecretareaView.rankTips04");
            }
            _rankTimeTxt.text = DateFormatter.getConsortiaCountDate(model.myRank.dayTime);
         }
         else
         {
            if(model.myRank.weekOrder <= 100)
            {
               _myRankTxt.text = String(model.myRank.weekOrder);
            }
            else
            {
               _myRankTxt.text = LanguageMgr.GetTranslation("skysecretareaView.rankTips04");
            }
            _rankTimeTxt.text = DateFormatter.getConsortiaCountDate(model.myRank.weekTime);
         }
      }
      
      private function get model() : SkyboxRoadModel
      {
         return SkyboxRoadManager.instance.model;
      }
      
      override public function dispose() : void
      {
         remveEvent();
         ObjectUtils.disposeObject(_back);
         _back = null;
         ObjectUtils.disposeObject(_pageBg);
         _pageBg = null;
         ObjectUtils.disposeObject(_lastPageBtn);
         _lastPageBtn = null;
         ObjectUtils.disposeObject(_pageTxt);
         _pageTxt = null;
         ObjectUtils.disposeObject(_nextPageBtn);
         _nextPageBtn = null;
         ObjectUtils.disposeObject(_myRankBit);
         _myRankBit = null;
         ObjectUtils.disposeObject(_myRankBack);
         _myRankBack = null;
         ObjectUtils.disposeObject(_timeBit);
         _timeBit = null;
         ObjectUtils.disposeObject(_timeBack);
         _timeBack = null;
         ObjectUtils.disposeObject(_titleTxt01);
         _titleTxt01 = null;
         ObjectUtils.disposeObject(_titleTxt02);
         _titleTxt02 = null;
         ObjectUtils.disposeObject(_titleTxt03);
         _titleTxt03 = null;
         ObjectUtils.disposeObject(_titleTxt04);
         _titleTxt04 = null;
         ObjectUtils.disposeObject(_myRankTxt);
         _myRankTxt = null;
         ObjectUtils.disposeObject(_rankTimeTxt);
         _rankTimeTxt = null;
         ObjectUtils.disposeObject(_rankTipTxt);
         _rankTipTxt = null;
         ObjectUtils.disposeAllChildren(_vBox);
         ObjectUtils.disposeObject(_vBox);
         _vBox = null;
         ObjectUtils.disposeAllChildren(this);
         LogicUtils.disposeDisplayCollection(_itemList);
         _itemList = null;
         super.dispose();
      }
   }
}

