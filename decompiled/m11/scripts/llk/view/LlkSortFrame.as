package llk.view
{
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.instance.IManualSize;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.ui.controls.IconButton;
   import com.pickgliss.ui.controls.container.VBox;
   import com.pickgliss.ui.image.Image;
   import com.pickgliss.ui.image.ScaleBitmapImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import com.pickgliss.utils.SoundManager;
   import flash.display.Bitmap;
   import flash.events.MouseEvent;
   import flash.geom.Rectangle;
   import manager.LanguageMgr;
   import managers.LlkManager;
   import mvc.module.llk.LlkModel;
   import mvc.module.llk.LlkSortData;
   import yishi.datas.ComponentGroupType;
   import yishi.utils.MsgMan;
   
   public class LlkSortFrame extends Frame implements IManualSize
   {
      
      private var _bg:ScaleBitmapImage;
      
      private var _contentBg:Image;
      
      private var _rankNum:FilterFrameText;
      
      private var _nickName:FilterFrameText;
      
      private var _gateName:FilterFrameText;
      
      private var _scoreTxt:FilterFrameText;
      
      private var _appellTxt:FilterFrameText;
      
      private var _mySortBmp:Bitmap;
      
      private var _mySortTxt:FilterFrameText;
      
      private var _itemList:Vector.<LlkSortItemView>;
      
      private var _vBox:VBox;
      
      private var _pageBg:Image;
      
      private var _pageTxt:FilterFrameText;
      
      private var _lastPageBtn:IconButton;
      
      private var _nextPageBtn:IconButton;
      
      private var _pageStartIndex:int = 0;
      
      private var _currentPage:int = 1;
      
      private var _totalPage:int = 1;
      
      private const PAGE_NUM:int = 10;
      
      public function LlkSortFrame()
      {
         super();
         initView();
         initEvent();
         refreshView();
      }
      
      public function get viewRectangle() : Rectangle
      {
         return new Rectangle(0,0,575,550);
      }
      
      override public function get groups() : Array
      {
         return [ComponentGroupType.NONE];
      }
      
      private function initView() : void
      {
         titleText = LanguageMgr.GetTranslation("gvgcross.view.ranklists.GvgCrossRankListFrame.title");
         _bg = ComponentFactory.Instance.creatComponentByStylename("LlkSortFrame.FrameBg");
         _contentBg = ComponentFactory.Instance.creatComponentByStylename("LlkSortFrame.RankContentBg");
         _rankNum = ComponentFactory.Instance.creatComponentByStylename("sort.league.RankListTitle.rankNum");
         _nickName = ComponentFactory.Instance.creatComponentByStylename("PetChallengeSortFrame.RankListTitle.nickName");
         _gateName = ComponentFactory.Instance.creatComponentByStylename("PetChallengeSortFrame.RankListTitle.serverName");
         _scoreTxt = ComponentFactory.Instance.creatComponentByStylename("sort.league.RankListTitle.totleScore");
         _appellTxt = ComponentFactory.Instance.creatComponentByStylename("PetChallengeSortFrame.RankListTitle.fightTxt");
         _mySortBmp = ComponentFactory.Instance.creatBitmap("asset.llk.mySortImg");
         _mySortTxt = ComponentFactory.Instance.creatComponentByStylename("LlkSortFrame.mySortTxt");
         _vBox = ComponentFactory.Instance.creatComponentByStylename("PetChallengeSortFrame.RankItemVbox");
         _pageBg = ComponentFactory.Instance.creatComponentByStylename("LlkSortFrame.pageBg");
         _pageTxt = ComponentFactory.Instance.creatComponentByStylename("LlkSortFrame.PageTxt");
         _lastPageBtn = ComponentFactory.Instance.creatComponentByStylename("LlkSortFrame.LastPageBtn");
         _nextPageBtn = ComponentFactory.Instance.creatComponentByStylename("LlkSortFrame.NextPageBtn");
         _itemList = new Vector.<LlkSortItemView>();
         _rankNum.text = LanguageMgr.GetTranslation("gvgcross.view.ranklists.Rank.Title1");
         _nickName.text = LanguageMgr.GetTranslation("maze.order.MazeOrderView.Name");
         _gateName.text = LanguageMgr.GetTranslation("llk.view.LlkSortFrame.gateName");
         _scoreTxt.text = LanguageMgr.GetTranslation("gvgcross.view.ranklists.Rank.Title5");
         _appellTxt.text = LanguageMgr.GetTranslation("appell.AppellFrame.Title");
         addToContent(_bg);
         addToContent(_contentBg);
         addToContent(_rankNum);
         addToContent(_nickName);
         addToContent(_gateName);
         addToContent(_scoreTxt);
         addToContent(_appellTxt);
         _appellTxt.y = 50;
         addToContent(_mySortBmp);
         addToContent(_mySortTxt);
         addToContent(_vBox);
         addToContent(_pageBg);
         addToContent(_pageTxt);
         addToContent(_lastPageBtn);
         addToContent(_nextPageBtn);
         refreshBtnState();
      }
      
      private function unInitView() : void
      {
         while(_itemList && _itemList.length > 0)
         {
            _itemList.pop().dispose();
         }
         _itemList = null;
         ObjectUtils.disposeObject(_bg);
         _bg = null;
         ObjectUtils.disposeObject(_contentBg);
         _contentBg = null;
         ObjectUtils.disposeObject(_rankNum);
         _rankNum = null;
         ObjectUtils.disposeObject(_nickName);
         _nickName = null;
         ObjectUtils.disposeObject(_gateName);
         _gateName = null;
         ObjectUtils.disposeObject(_scoreTxt);
         _scoreTxt = null;
         ObjectUtils.disposeObject(_appellTxt);
         _appellTxt = null;
         ObjectUtils.disposeObject(_mySortBmp);
         _mySortBmp = null;
         ObjectUtils.disposeObject(_mySortTxt);
         _mySortTxt = null;
         ObjectUtils.disposeObject(_vBox);
         _vBox = null;
         ObjectUtils.disposeObject(_pageBg);
         _pageBg = null;
         ObjectUtils.disposeObject(_pageTxt);
         _pageTxt = null;
         ObjectUtils.disposeObject(_lastPageBtn);
         _lastPageBtn = null;
         ObjectUtils.disposeObject(_nextPageBtn);
         _nextPageBtn = null;
      }
      
      private function refreshView() : void
      {
         var _loc2_:int = 0;
         var _loc1_:LlkSortItemView = null;
         if(model.info.selfOrder > 0)
         {
            _mySortTxt.text = LanguageMgr.GetTranslation("warlords.WarlordsGeneralListCell.str02",model.info.selfOrder);
         }
         else
         {
            _mySortTxt.text = LanguageMgr.GetTranslation("colosseum.view.ColosseumPlayerItem.newPeople");
         }
         _loc2_ = 0;
         while(_loc2_ < 10)
         {
            if(_itemList.length < _loc2_ + 1)
            {
               _loc1_ = new LlkSortItemView();
               _itemList.push(_loc1_);
               _vBox.addChild(_loc1_);
            }
            if(model.info.sortList[(_currentPage - 1) * 10 + _loc2_])
            {
               _itemList[_loc2_].data = model.info.sortList[(_currentPage - 1) * 10 + _loc2_] as LlkSortData;
            }
            else
            {
               _itemList[_loc2_].data = null;
            }
            _loc2_++;
         }
      }
      
      private function initEvent() : void
      {
         addEventListener("response",__responseHandler);
         MsgMan.addObserver(LlkModel.LLK_SORT,this,__sortHandler);
         if(_lastPageBtn)
         {
            _lastPageBtn.addEventListener("click",__onPageHandler);
         }
         if(_nextPageBtn)
         {
            _nextPageBtn.addEventListener("click",__onPageHandler);
         }
      }
      
      private function removeEvent() : void
      {
         removeEventListener("response",__responseHandler);
         MsgMan.removeObserver(LlkModel.LLK_SORT,this,__sortHandler);
         if(_lastPageBtn)
         {
            _lastPageBtn.removeEventListener("click",__onPageHandler);
         }
         if(_nextPageBtn)
         {
            _nextPageBtn.removeEventListener("click",__onPageHandler);
         }
      }
      
      private function __onPageHandler(param1:MouseEvent) : void
      {
         SoundManager.instance.play("022");
         pageBtnHandler(param1.currentTarget == _lastPageBtn);
         refreshBtnState();
         refreshView();
      }
      
      private function refreshBtnState() : void
      {
         _totalPage = Math.ceil(model.info.sortList.length / 10);
         if(_totalPage < 1)
         {
            _totalPage = 1;
         }
         _pageTxt.text = _currentPage + "/" + _totalPage;
         _lastPageBtn.enable = _currentPage > 1;
         _nextPageBtn.enable = _currentPage < _totalPage;
      }
      
      private function pageBtnHandler(param1:Boolean) : void
      {
         if(param1 && _currentPage > 1)
         {
            _currentPage = _currentPage - 1;
         }
         else
         {
            if(!(!param1 && _currentPage < _totalPage))
            {
               return;
            }
            _currentPage = _currentPage + 1;
         }
         _pageStartIndex = (_currentPage - 1) * 10;
      }
      
      private function __sortHandler(param1:String, param2:Object) : void
      {
         refreshView();
         refreshBtnState();
      }
      
      private function __responseHandler(param1:FrameEvent) : void
      {
         switch(int(param1.responseCode))
         {
            case 0:
            case 1:
               dispose();
         }
      }
      
      private function get model() : LlkModel
      {
         return LlkManager.instance.model;
      }
      
      public function show() : void
      {
         LayerManager.Instance.addToLayer(this,3,true,true,1);
      }
      
      override public function dispose() : void
      {
         model.info.sortList.length = 0;
         removeEvent();
         unInitView();
         super.dispose();
      }
   }
}

