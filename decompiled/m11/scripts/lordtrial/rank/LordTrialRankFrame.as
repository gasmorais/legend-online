package lordtrial.rank
{
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.BaseButton;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.ui.controls.ListPanel;
   import com.pickgliss.ui.controls.SelectedButtonGroup;
   import com.pickgliss.ui.controls.SelectedIconButton;
   import com.pickgliss.ui.controls.TextButton;
   import com.pickgliss.ui.image.Image;
   import com.pickgliss.ui.image.MutipleImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import events.LordTrialEvent;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.geom.Point;
   import manager.LanguageMgr;
   import mvc.module.lordtrial.LordTrialModel;
   import mvc.module.lordtrial.LordTrialRankInfo;
   import yishi.datas.playerinfo.PlayerInfo;
   import yishi.manager.FrameControllerManager;
   import yishi.manager.LordTrialManager;
   import yishi.manager.PlayerManager;
   
   public class LordTrialRankFrame extends Frame
   {
      
      private var _bg:MutipleImage;
      
      private var _bg2:MutipleImage;
      
      private var _bg3:MutipleImage;
      
      private var _titleTxt1:FilterFrameText;
      
      private var _titleTxt2:FilterFrameText;
      
      private var _titleTxt3:FilterFrameText;
      
      private var _groupBtn1:SelectedIconButton;
      
      private var _groupBtn2:SelectedIconButton;
      
      private var _groupBtn3:SelectedIconButton;
      
      private var _groupSelectedGroup:SelectedButtonGroup;
      
      private var _rankListPanel:ListPanel;
      
      private var _myRankTxt:FilterFrameText;
      
      private var _noteTxt:FilterFrameText;
      
      private var _pageBg:Image;
      
      private var _nextBtn:BaseButton;
      
      private var _preBtn:BaseButton;
      
      private var _currentPageTxt:FilterFrameText;
      
      private var _lookRewardBtn:TextButton;
      
      private var _tipView:LordTrialRankRewardTipView;
      
      private var _currentNum:int;
      
      private var _model:LordTrialModel;
      
      private var _itemList:Vector.<LordTrialRankInfo>;
      
      private var _data:LordTrialRankInfo;
      
      private var _page:int = 0;
      
      private var _maxPage:int;
      
      private const PagePerNum:int = 8;
      
      private var _orderArray:Array;
      
      private var _selectedIndex:int;
      
      public function LordTrialRankFrame()
      {
         super();
         _model = LordTrialManager.instance.model;
         initView();
         addEvent();
         FrameControllerManager.instance.lordTrialController.loadRankXML();
         _groupSelectedGroup.selectIndex = 0;
         __onTabBtnHandler(null);
      }
      
      private function initView() : void
      {
         titleText = LanguageMgr.GetTranslation("mainBar.SmallMapBar.rankingBtnTipData");
         _bg = ComponentFactory.Instance.creatComponentByStylename("lordTrialRankFrame.bg");
         _bg2 = ComponentFactory.Instance.creatComponentByStylename("lordTrialRankFrame.bg2");
         _titleTxt1 = ComponentFactory.Instance.creatComponentByStylename("lordTrialRankFrame.titleTxt1");
         _titleTxt2 = ComponentFactory.Instance.creatComponentByStylename("lordTrialRankFrame.titleTxt2");
         _titleTxt3 = ComponentFactory.Instance.creatComponentByStylename("lordTrialRankFrame.titleTxt3");
         _groupBtn1 = ComponentFactory.Instance.creatComponentByStylename("lordTrialRankFrame.groupBtn1");
         _groupBtn2 = ComponentFactory.Instance.creatComponentByStylename("lordTrialRankFrame.groupBtn2");
         _groupBtn3 = ComponentFactory.Instance.creatComponentByStylename("lordTrialRankFrame.groupBtn3");
         _myRankTxt = ComponentFactory.Instance.creatComponentByStylename("lordTrialRankFrame.myRankTxt");
         _nextBtn = ComponentFactory.Instance.creatComponentByStylename("lordTrialRankFrame.nextBtn");
         _preBtn = ComponentFactory.Instance.creatComponentByStylename("lordTrialRankFrame.preBtn");
         _currentPageTxt = ComponentFactory.Instance.creatComponentByStylename("lordTrialRankFrame.currentPageTxt");
         _rankListPanel = ComponentFactory.Instance.creatComponentByStylename("lordTrialRankFrame.RankFrameList");
         _pageBg = ComponentFactory.Instance.creatComponentByStylename("lordTrialRankFrame.pageBg");
         _lookRewardBtn = ComponentFactory.Instance.creatComponentByStylename("lordTrialRankFrame.lookRewardBtn");
         _noteTxt = ComponentFactory.Instance.creatComponentByStylename("lordTrialRankFrame.noteTxt");
         addToContent(_bg);
         addToContent(_bg2);
         addToContent(_titleTxt1);
         addToContent(_titleTxt2);
         addToContent(_titleTxt3);
         addToContent(_groupBtn1);
         addToContent(_groupBtn2);
         addToContent(_groupBtn3);
         addToContent(_myRankTxt);
         addToContent(_pageBg);
         addToContent(_nextBtn);
         addToContent(_preBtn);
         addToContent(_currentPageTxt);
         addToContent(_rankListPanel);
         addToContent(_lookRewardBtn);
         addToContent(_noteTxt);
         _groupSelectedGroup = new SelectedButtonGroup();
         _groupSelectedGroup.addSelectItem(_groupBtn1);
         _groupSelectedGroup.addSelectItem(_groupBtn2);
         _groupSelectedGroup.addSelectItem(_groupBtn3);
         _groupSelectedGroup.selectIndex = 0;
         _titleTxt1.text = LanguageMgr.GetTranslation("colosseum.view.HeroRankFrame.rank");
         _titleTxt2.text = LanguageMgr.GetTranslation("colosseum.view.HeroRankFrame.nickName");
         _titleTxt3.text = LanguageMgr.GetTranslation("lordtrial.rank.titleTxt3");
         _lookRewardBtn.text = LanguageMgr.GetTranslation("PetChallengeInfoView.lookReward");
         _noteTxt.text = LanguageMgr.GetTranslation("lordtrial.rank.lordTrialRankFrame.noteTxt");
      }
      
      private function unInitView() : void
      {
         ObjectUtils.disposeObject(_bg);
         _bg = null;
         ObjectUtils.disposeObject(_bg2);
         _bg2 = null;
         ObjectUtils.disposeObject(_pageBg);
         _pageBg = null;
         ObjectUtils.disposeObject(_titleTxt1);
         _titleTxt1 = null;
         ObjectUtils.disposeObject(_titleTxt2);
         _titleTxt2 = null;
         ObjectUtils.disposeObject(_titleTxt3);
         _titleTxt3 = null;
         ObjectUtils.disposeObject(_groupBtn1);
         _groupBtn1 = null;
         ObjectUtils.disposeObject(_groupBtn2);
         _groupBtn2 = null;
         ObjectUtils.disposeObject(_groupBtn3);
         _groupBtn3 = null;
         ObjectUtils.disposeObject(_groupSelectedGroup);
         _groupSelectedGroup = null;
         ObjectUtils.disposeObject(_myRankTxt);
         _myRankTxt = null;
         ObjectUtils.disposeObject(_noteTxt);
         _noteTxt = null;
         ObjectUtils.disposeObject(_nextBtn);
         _nextBtn = null;
         ObjectUtils.disposeObject(_preBtn);
         _preBtn = null;
         ObjectUtils.disposeObject(_currentPageTxt);
         _currentPageTxt = null;
         ObjectUtils.disposeObject(_rankListPanel);
         _rankListPanel = null;
         ObjectUtils.disposeObject(_lookRewardBtn);
         _lookRewardBtn = null;
         ObjectUtils.disposeObject(_tipView);
         _tipView = null;
      }
      
      private function addEvent() : void
      {
         addEventListener("response",__frameResponse);
         if(_preBtn)
         {
            _preBtn.addEventListener("click",__preBtnHandler);
         }
         if(_nextBtn)
         {
            _nextBtn.addEventListener("click",__nextBtnHandler);
         }
         if(_lookRewardBtn)
         {
            _lookRewardBtn.addEventListener("mouseDown",__lookRewardBtnHandler);
         }
         if(_groupSelectedGroup)
         {
            _groupSelectedGroup.addEventListener("change",__onTabBtnHandler);
         }
         if(_model)
         {
            _model.addEventListener("UPDATE_RANKDATA",__updateView);
         }
      }
      
      private function removeEvent() : void
      {
         removeEventListener("response",__frameResponse);
         if(_preBtn)
         {
            _preBtn.removeEventListener("click",__preBtnHandler);
         }
         if(_nextBtn)
         {
            _nextBtn.removeEventListener("click",__nextBtnHandler);
         }
         if(_lookRewardBtn)
         {
            _lookRewardBtn.removeEventListener("mouseDown",__lookRewardBtnHandler);
         }
         if(_groupSelectedGroup)
         {
            _groupSelectedGroup.removeEventListener("change",__onTabBtnHandler);
         }
         if(_model)
         {
            _model.removeEventListener("UPDATE_RANKDATA",__updateView);
         }
      }
      
      private function __frameResponse(param1:FrameEvent) : void
      {
         switch(int(param1.responseCode))
         {
            case 0:
            case 1:
               dispose();
         }
      }
      
      private function __preBtnHandler(param1:MouseEvent) : void
      {
         var _loc2_:int = Math.max(1,_page - 1);
         if(_loc2_ != _page)
         {
            currentPage = _loc2_;
         }
      }
      
      private function __nextBtnHandler(param1:MouseEvent) : void
      {
         var _loc2_:int = Math.min(_maxPage,_page + 1);
         if(_loc2_ != _page)
         {
            currentPage = _loc2_;
         }
      }
      
      private function __onTabBtnHandler(param1:Event) : void
      {
         _page = 1;
         if(_model.lordTrialRankData)
         {
            _itemList = _model.lordTrialRankData.filter(filterRankByTab);
            _itemList.sort(sortByRank);
            _maxPage = Math.max(Math.ceil(_itemList.length / 8),1);
         }
         currentPage = Math.max(Math.min(_page,_maxPage),1);
         _orderArray = playerInfo.order;
         _selectedIndex = _groupSelectedGroup.selectIndex;
         if(_orderArray)
         {
            if(_orderArray[_selectedIndex] <= 0 || _orderArray[_selectedIndex] > 100)
            {
               _myRankTxt.text = LanguageMgr.GetTranslation("colosseum.view.ColosseumPlayerItem.newPeople");
            }
            else
            {
               _myRankTxt.text = _orderArray[_selectedIndex].toString();
            }
         }
      }
      
      private function get playerInfo() : PlayerInfo
      {
         return PlayerManager.instance.currentPlayerModel.playerInfo;
      }
      
      private function __updateView(param1:LordTrialEvent) : void
      {
         __onTabBtnHandler(null);
      }
      
      private function __lookRewardBtnHandler(param1:MouseEvent) : void
      {
         if(_tipView && !_tipView.isDie)
         {
            ObjectUtils.disposeObject(_tipView);
            _tipView = null;
            return;
         }
         _tipView = new LordTrialRankRewardTipView();
         var _loc2_:Point = new Point();
         _loc2_ = _lookRewardBtn.localToGlobal(_loc2_);
         _tipView.x = _loc2_.x - _tipView.displayWidth - 10;
         _tipView.y = _loc2_.y - 254;
         if(_tipView.y < 0)
         {
            _tipView.y = 20;
         }
         _tipView.show();
         param1.stopPropagation();
      }
      
      private function sortByRank(param1:Object, param2:Object) : int
      {
         if(param1.rank < param2.rank)
         {
            return -1;
         }
         if(param1.rank > param2.rank)
         {
            return 1;
         }
         return 0;
      }
      
      private function filterRankByTab(param1:Object, param2:int, param3:*) : Boolean
      {
         return param1.gate == _groupSelectedGroup.selectIndex + 1;
      }
      
      public function set currentPage(param1:int) : void
      {
         var _loc2_:* = undefined;
         var _loc4_:int = 0;
         var _loc3_:int = 0;
         _page = param1;
         _currentPageTxt.text = _page + "/" + _maxPage;
         _preBtn.enable = _page != 1;
         _nextBtn.enable = _page != _maxPage;
         _rankListPanel.vectorListModel.clear();
         if(_itemList)
         {
            _loc2_ = _itemList.slice((_page - 1) * 8,_page * 8);
            if(_loc2_)
            {
               _loc4_ = 0;
               _loc3_ = int(_loc2_.length);
               while(_loc4_ < _loc3_)
               {
                  _rankListPanel.vectorListModel.append(_loc2_[_loc4_]);
                  _loc4_++;
               }
            }
         }
         _rankListPanel.list.updateListView();
      }
      
      override public function get groups() : Array
      {
         return ["CASTLE_BUIDING_GROUP","BAG_GROUP"];
      }
      
      public function show(param1:int = 0) : void
      {
         LayerManager.Instance.addToLayer(this,3,true,true,1,0,true);
      }
      
      override public function dispose() : void
      {
         removeEvent();
         unInitView();
         _itemList = null;
         super.dispose();
      }
   }
}

