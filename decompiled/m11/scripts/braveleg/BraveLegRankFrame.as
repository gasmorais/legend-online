package braveleg
{
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.instance.IManualSize;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.BaseButton;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.ui.controls.ListPanel;
   import com.pickgliss.ui.controls.SelectedButtonGroup;
   import com.pickgliss.ui.controls.SelectedIconButton;
   import com.pickgliss.ui.controls.container.HBox;
   import com.pickgliss.ui.image.Image;
   import com.pickgliss.ui.image.MutipleImage;
   import com.pickgliss.ui.image.ScaleFrameImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import events.BraveLegEvent;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.geom.Rectangle;
   import manager.LanguageMgr;
   import mvc.module.braveleg.BraveLegModel;
   import mvc.module.braveleg.BraveLegPlayerInfo;
   import mvc.module.braveleg.BraveLegRankInfo;
   import yishi.datas.ComponentGroupType;
   import yishi.datas.ConfigInfoManager;
   import yishi.manager.BraveLegManager;
   
   public class BraveLegRankFrame extends Frame implements IManualSize
   {
      
      private var _bg:MutipleImage;
      
      private var _titleBg:MutipleImage;
      
      private var _bottomBg:MutipleImage;
      
      private var _rankTitleTxt:FilterFrameText;
      
      private var _nameTitleTxt:FilterFrameText;
      
      private var _fightTitleTxt:FilterFrameText;
      
      private var _pointTitleTxt:FilterFrameText;
      
      private var _updateTimeTxt:FilterFrameText;
      
      private var _rankListPanel:ListPanel;
      
      private var _rankTitle:Image;
      
      private var _rankGroup:ScaleFrameImage;
      
      private var _rankTxt:FilterFrameText;
      
      private var _notApplyTips:FilterFrameText;
      
      private var _myPointTxt:FilterFrameText;
      
      private var _groupBox:HBox;
      
      private var _groupBtn1:SelectedIconButton;
      
      private var _groupBtn2:SelectedIconButton;
      
      private var _groupBtn3:SelectedIconButton;
      
      private var _groupBtn4:SelectedIconButton;
      
      private var _groupBtn5:SelectedIconButton;
      
      private var _groupBtn6:SelectedIconButton;
      
      private var _groupSelectedGroup:SelectedButtonGroup;
      
      private var _pageNumTxt:FilterFrameText;
      
      private var _prePageBtn:BaseButton;
      
      private var _nextPageBtn:BaseButton;
      
      private var _model:BraveLegModel = BraveLegManager.instance.model;
      
      private var _data:BraveLegRankInfo;
      
      private var _rankList:Vector.<BraveLegPlayerInfo>;
      
      private var _page:int = 0;
      
      private var _maxPage:int;
      
      private const PagePerNum:int = 10;
      
      private var _groupScore:Array = ConfigInfoManager.instance.getBraveLegTeamScore();
      
      public function BraveLegRankFrame()
      {
         super();
         initView();
         addEvent();
         refresh();
      }
      
      private function initView() : void
      {
         var _loc3_:int = 0;
         var _loc1_:String = null;
         var _loc2_:int = 0;
         var _loc4_:int = 0;
         _bg = ComponentFactory.Instance.creatComponentByStylename("braveleg.RankFrameBg");
         _groupBtn1 = ComponentFactory.Instance.creatComponentByStylename("braveleg.RankFrameGroupBtn1");
         _groupBtn2 = ComponentFactory.Instance.creatComponentByStylename("braveleg.RankFrameGroupBtn2");
         _groupBtn3 = ComponentFactory.Instance.creatComponentByStylename("braveleg.RankFrameGroupBtn3");
         _groupBtn4 = ComponentFactory.Instance.creatComponentByStylename("braveleg.RankFrameGroupBtn4");
         _groupBtn5 = ComponentFactory.Instance.creatComponentByStylename("braveleg.RankFrameGroupBtn5");
         _groupBtn6 = ComponentFactory.Instance.creatComponentByStylename("braveleg.RankFrameGroupBtn6");
         _titleBg = ComponentFactory.Instance.creatComponentByStylename("braveleg.RankFrameTitleBg");
         _bottomBg = ComponentFactory.Instance.creatComponentByStylename("braveleg.RankFrameBottomBg");
         _myPointTxt = ComponentFactory.Instance.creatComponentByStylename("braveleg.RankFrameMyPointTxt");
         _rankListPanel = ComponentFactory.Instance.creatComponentByStylename("braveleg.RankFrameList");
         _rankTitleTxt = ComponentFactory.Instance.creatComponentByStylename("braveleg.RankFrameRankTitleTxt");
         _nameTitleTxt = ComponentFactory.Instance.creatComponentByStylename("braveleg.RankFrameNameTitleTxt");
         _fightTitleTxt = ComponentFactory.Instance.creatComponentByStylename("braveleg.RankFrameFightTitleTxt");
         _pointTitleTxt = ComponentFactory.Instance.creatComponentByStylename("braveleg.RankFramePointTitleTxt");
         _updateTimeTxt = ComponentFactory.Instance.creatComponentByStylename("braveleg.RankFrameUpdateTimeTxt");
         _notApplyTips = ComponentFactory.Instance.creatComponentByStylename("braveleg.RankFrameNotApplyTips");
         _rankTitle = ComponentFactory.Instance.creatComponentByStylename("braveleg.RankFrameRankTitle");
         _rankGroup = ComponentFactory.Instance.creatComponentByStylename("braveleg.RankFrameRankGroup");
         _rankTxt = ComponentFactory.Instance.creatComponentByStylename("braveleg.RankFrameRankTxt");
         _pageNumTxt = ComponentFactory.Instance.creatComponentByStylename("braveleg.RankFramePageTxt");
         _prePageBtn = ComponentFactory.Instance.creatComponentByStylename("braveleg.RankFramePrePageBtn");
         _nextPageBtn = ComponentFactory.Instance.creatComponentByStylename("braveleg.RankFrameNextPageBtn");
         addToContent(_bg);
         addToContent(_groupBtn1);
         addToContent(_groupBtn2);
         addToContent(_groupBtn3);
         addToContent(_groupBtn4);
         addToContent(_groupBtn5);
         addToContent(_groupBtn6);
         addToContent(_titleBg);
         addToContent(_bottomBg);
         addToContent(_myPointTxt);
         addToContent(_rankListPanel);
         addToContent(_rankTitleTxt);
         addToContent(_nameTitleTxt);
         addToContent(_fightTitleTxt);
         addToContent(_pointTitleTxt);
         addToContent(_updateTimeTxt);
         addToContent(_notApplyTips);
         addToContent(_rankTitle);
         addToContent(_rankGroup);
         addToContent(_rankTxt);
         addToContent(_pageNumTxt);
         addToContent(_prePageBtn);
         addToContent(_nextPageBtn);
         _groupSelectedGroup = new SelectedButtonGroup();
         _groupSelectedGroup.addSelectItem(_groupBtn1);
         _groupSelectedGroup.addSelectItem(_groupBtn2);
         _groupSelectedGroup.addSelectItem(_groupBtn3);
         _groupSelectedGroup.addSelectItem(_groupBtn4);
         _groupSelectedGroup.addSelectItem(_groupBtn5);
         _groupSelectedGroup.addSelectItem(_groupBtn6);
         _groupSelectedGroup.selectIndex = 0;
         titleText = LanguageMgr.GetTranslation("braveleg.RankFrame.title");
         _rankTitleTxt.text = LanguageMgr.GetTranslation("braveleg.RankFrame.str01");
         _nameTitleTxt.text = LanguageMgr.GetTranslation("braveleg.RankFrame.str02");
         _fightTitleTxt.text = LanguageMgr.GetTranslation("braveleg.RankFrame.str03");
         _pointTitleTxt.text = LanguageMgr.GetTranslation("braveleg.RankFrame.str04");
         _notApplyTips.text = LanguageMgr.GetTranslation("braveleg.RankFrame.str05");
         _notApplyTips.visible = false;
         _loc4_ = 0;
         while(_loc4_ < 6)
         {
            _loc1_ = LanguageMgr.GetTranslation("braveleg.GroupName.full" + (_loc4_ + 1));
            if(_groupScore[_loc4_ - 1])
            {
               _loc2_ = int(_groupScore[_loc4_ - 1]);
            }
            else
            {
               _loc2_ = 0;
            }
            if(_groupScore[_loc4_])
            {
               _loc3_ = _groupScore[_loc4_] - 1;
               this["_groupBtn" + (_loc4_ + 1)].tipData = LanguageMgr.GetTranslation("braveleg.RankFrame.tabTip",_loc1_,_loc2_,_loc3_);
            }
            else
            {
               this["_groupBtn" + (_loc4_ + 1)].tipData = LanguageMgr.GetTranslation("braveleg.RankFrame.tabTipTop",_loc1_,_loc2_);
            }
            _loc4_++;
         }
      }
      
      private function addEvent() : void
      {
         addEventListener("response",__frameResponseHandler);
         _groupSelectedGroup.addEventListener("change",__onTabBtnHandler);
         _model.addEventListener("BraveLegEvent.RANK_INFO",__rankInfoUpdateHandler);
         _prePageBtn.addEventListener("click",__pagePreBtnClickHandler);
         _nextPageBtn.addEventListener("click",__pageNextBtnClickHandler);
      }
      
      private function removeEvent() : void
      {
         removeEventListener("response",__frameResponseHandler);
         _groupSelectedGroup.removeEventListener("change",__onTabBtnHandler);
         _model.removeEventListener("BraveLegEvent.RANK_INFO",__rankInfoUpdateHandler);
         _prePageBtn.removeEventListener("click",__pagePreBtnClickHandler);
         _nextPageBtn.removeEventListener("click",__pageNextBtnClickHandler);
      }
      
      override public function dispose() : void
      {
         removeEvent();
         ObjectUtils.disposeObject(_bg);
         _bg = null;
         ObjectUtils.disposeObject(_titleBg);
         _titleBg = null;
         ObjectUtils.disposeObject(_bottomBg);
         _bottomBg = null;
         ObjectUtils.disposeObject(_myPointTxt);
         _myPointTxt = null;
         ObjectUtils.disposeObject(_rankListPanel);
         _rankListPanel = null;
         ObjectUtils.disposeObject(_rankTitleTxt);
         _rankTitleTxt = null;
         ObjectUtils.disposeObject(_nameTitleTxt);
         _nameTitleTxt = null;
         ObjectUtils.disposeObject(_fightTitleTxt);
         _fightTitleTxt = null;
         ObjectUtils.disposeObject(_pointTitleTxt);
         _pointTitleTxt = null;
         ObjectUtils.disposeObject(_notApplyTips);
         _notApplyTips = null;
         ObjectUtils.disposeObject(_updateTimeTxt);
         _updateTimeTxt = null;
         ObjectUtils.disposeObject(_rankTitle);
         _rankTitle = null;
         ObjectUtils.disposeObject(_rankGroup);
         _rankGroup = null;
         ObjectUtils.disposeObject(_rankTxt);
         _rankTxt = null;
         ObjectUtils.disposeObject(_pageNumTxt);
         _pageNumTxt = null;
         ObjectUtils.disposeObject(_prePageBtn);
         _prePageBtn = null;
         ObjectUtils.disposeObject(_nextPageBtn);
         _nextPageBtn = null;
         ObjectUtils.disposeObject(_groupSelectedGroup);
         _groupSelectedGroup = null;
         _model = null;
         _data = null;
         _groupScore = null;
         BraveLegManager.instance.clearRankInfo();
         super.dispose();
      }
      
      private function __frameResponseHandler(param1:FrameEvent) : void
      {
         switch(int(param1.responseCode))
         {
            case 0:
            case 1:
               dispose();
         }
      }
      
      private function __onTabBtnHandler(param1:Event) : void
      {
         _page = 1;
         _rankList = _data.rankList.filter(filterRankByTab);
         _rankList.sort(sortByRank);
         _maxPage = Math.max(Math.ceil(_rankList.length / 10),1);
         currentPage = Math.max(Math.min(_page,_maxPage),1);
      }
      
      private function __pagePreBtnClickHandler(param1:MouseEvent) : void
      {
         var _loc2_:int = Math.max(1,_page - 1);
         if(_loc2_ != _page)
         {
            currentPage = _loc2_;
         }
      }
      
      private function __pageNextBtnClickHandler(param1:MouseEvent) : void
      {
         var _loc2_:int = Math.min(_maxPage,_page + 1);
         if(_loc2_ != _page)
         {
            currentPage = _loc2_;
         }
      }
      
      private function __rankInfoUpdateHandler(param1:BraveLegEvent) : void
      {
         refresh();
      }
      
      public function refresh() : void
      {
         _data = _model.rankInfo;
         if(_data)
         {
            if(_data.order)
            {
               _notApplyTips.visible = false;
               _rankTitle.visible = true;
               _rankGroup.visible = true;
               _rankGroup.setFrame(_data.teamType + 1);
               if(_groupSelectedGroup.selectIndex == _data.teamType)
               {
                  __onTabBtnHandler(null);
               }
               else
               {
                  _groupSelectedGroup.selectIndex = _data.teamType;
               }
               _rankTxt.text = _data.order + "";
            }
            else
            {
               _notApplyTips.visible = true;
               _rankTitle.visible = false;
               _rankGroup.visible = false;
               __onTabBtnHandler(null);
               _rankTxt.text = "";
            }
            _myPointTxt.text = _data.totalScore + "";
            if(_data.lastUpdate)
            {
               _updateTimeTxt.text = LanguageMgr.GetTranslation("braveleg.RankFrame.update",_data.lastUpdate);
            }
            else
            {
               _updateTimeTxt.text = LanguageMgr.GetTranslation("braveleg.RankFrame.updateNone");
            }
         }
         else
         {
            _notApplyTips.visible = true;
            _rankTitle.visible = false;
            _rankGroup.visible = false;
            _rankTxt.text = "";
            _myPointTxt.text = "";
            _updateTimeTxt.text = "";
         }
      }
      
      public function set currentPage(param1:int) : void
      {
         var _loc4_:int = 0;
         var _loc3_:int = 0;
         _page = param1;
         _pageNumTxt.text = _page + "/" + _maxPage;
         _prePageBtn.enable = _page != 1;
         _nextPageBtn.enable = _page != _maxPage;
         _rankListPanel.beginChanges();
         _rankListPanel.vectorListModel.clear();
         var _loc2_:Vector.<BraveLegPlayerInfo> = _rankList.slice((_page - 1) * 10,_page * 10);
         _loc4_ = 0;
         _loc3_ = int(_loc2_.length);
         while(_loc4_ < _loc3_)
         {
            _rankListPanel.vectorListModel.append(_loc2_[_loc4_]);
            _loc4_++;
         }
         _rankListPanel.commitChanges();
         _rankListPanel.list.updateListView();
      }
      
      private function filterRankByTab(param1:Object, param2:int, param3:*) : Boolean
      {
         return param1.teamType == _groupSelectedGroup.selectIndex;
      }
      
      private function sortByRank(param1:Object, param2:Object) : int
      {
         if(param1.rankOrder < param2.rankOrder)
         {
            return -1;
         }
         if(param1.rankOrder > param2.rankOrder)
         {
            return 1;
         }
         return 0;
      }
      
      public function show() : void
      {
         LayerManager.Instance.addToLayer(this,3,true,true,2);
      }
      
      public function get viewRectangle() : Rectangle
      {
         return new Rectangle(0,0,535,585);
      }
      
      override public function get groups() : Array
      {
         return [ComponentGroupType.NONE];
      }
   }
}

