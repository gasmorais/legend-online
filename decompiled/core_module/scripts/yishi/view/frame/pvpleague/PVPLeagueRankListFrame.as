package yishi.view.frame.pvpleague
{
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.loader.LoaderManagerII;
   import com.pickgliss.loader.data.LoaderInfo;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.BaseButton;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.ui.controls.IconButton;
   import com.pickgliss.ui.controls.SelectedButtonGroup;
   import com.pickgliss.ui.controls.SelectedIconButton;
   import com.pickgliss.ui.controls.container.VBox;
   import com.pickgliss.ui.image.CustomBitmap;
   import com.pickgliss.ui.image.Image;
   import com.pickgliss.ui.image.ScaleBitmapImage;
   import com.pickgliss.ui.image.ScaleFrameImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import com.pickgliss.utils.SoundManager;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import manager.LanguageMgr;
   import mvc.module.gvgcross.GvgCrossGuildInfo;
   import mvc.module.gvgcross.GvgCrossSortData;
   import yishi.datas.playerinfo.PlayerInfo;
   import yishi.manager.FrameControllerManager;
   import yishi.manager.PathManager;
   import yishi.manager.PlayerManager;
   
   public class PVPLeagueRankListFrame extends Frame
   {
      
      private var _bg:ScaleBitmapImage;
      
      private var _contentBg:Image;
      
      private var _rankNum:FilterFrameText;
      
      private var _nickName:FilterFrameText;
      
      private var _serverName:FilterFrameText;
      
      private var _totleScore:FilterFrameText;
      
      private var _fightTxt:FilterFrameText;
      
      private var _showReward:Image;
      
      private var _rankTips2:CustomBitmap;
      
      private var _rankTips3:CustomBitmap;
      
      private var _rankTips4:CustomBitmap;
      
      private var _rankGroupTips:ScaleFrameImage;
      
      private var _rankTopTips:FilterFrameText;
      
      private var _notApplyTips:FilterFrameText;
      
      private var _itemList:Vector.<PVPLeagueRankItem>;
      
      private var _vBox:VBox;
      
      private var _pageBg:Image;
      
      private var _pageTxt:FilterFrameText;
      
      private var _lastPageBtn:IconButton;
      
      private var _nextPageBtn:IconButton;
      
      private var _helpBtn:BaseButton;
      
      private var _groupBtn1:SelectedIconButton;
      
      private var _groupBtn2:SelectedIconButton;
      
      private var _groupBtn3:SelectedIconButton;
      
      private var _groupBtn4:SelectedIconButton;
      
      private var _groupSelectedGroup:SelectedButtonGroup;
      
      private var _currentShowSortInfo:Array;
      
      private var _sortInfo1:Array;
      
      private var _sortInfo2:Array;
      
      private var _sortInfo3:Array;
      
      private var _sortInfo4:Array;
      
      private var _playerInfo:PlayerInfo;
      
      private var _selfGroup:int = 0;
      
      private var _selfOrder:int = 0;
      
      private var _pageStartIndex:int = 0;
      
      private var _currentPage:int = 1;
      
      private var _totalPage:int = 1;
      
      private const PAGE_NUM:int = 10;
      
      public function PVPLeagueRankListFrame()
      {
         super();
         _currentShowSortInfo = [];
         _sortInfo1 = [];
         _sortInfo2 = [];
         _sortInfo3 = [];
         _sortInfo4 = [];
         _playerInfo = PlayerManager.instance.currentPlayerModel.playerInfo;
         initView();
         addEvent();
         loadData();
      }
      
      override public function get groups() : Array
      {
         return ["CASTLE_BUIDING_GROUP","MAIN_TOOLS_GROUP","BAG_GROUP"];
      }
      
      private function initView() : void
      {
         var _loc2_:int = 0;
         var _loc1_:PVPLeagueRankItem = null;
         titleText = LanguageMgr.GetTranslation("yishi.view.frame.pvpleague.PVPLeagueRankListFrame.Title");
         _bg = ComponentFactory.Instance.creatComponentByStylename("sort.league.FrameBg");
         _contentBg = ComponentFactory.Instance.creatComponentByStylename("sort.league.RankContentBg");
         _rankNum = ComponentFactory.Instance.creatComponentByStylename("sort.league.RankListTitle.rankNum");
         _nickName = ComponentFactory.Instance.creatComponentByStylename("sort.league.RankListTitle.nickName");
         _serverName = ComponentFactory.Instance.creatComponentByStylename("sort.league.RankListTitle.serverName");
         _totleScore = ComponentFactory.Instance.creatComponentByStylename("sort.league.RankListTitle.totleScore");
         _fightTxt = ComponentFactory.Instance.creatComponentByStylename("sort.league.RankListTitle.fightTxt");
         _showReward = ComponentFactory.Instance.creatComponentByStylename("sort.league.ShowReward");
         _rankTips2 = ComponentFactory.Instance.creatCustomObject("matelords.sort.RankTips2");
         _rankTips3 = ComponentFactory.Instance.creatCustomObject("matelords.sort.RankTips3");
         _rankTips4 = ComponentFactory.Instance.creatCustomObject("matelords.sort.RankTips4");
         _rankGroupTips = ComponentFactory.Instance.creatComponentByStylename("sort.league.RankGroupTips");
         _rankTopTips = ComponentFactory.Instance.creatComponentByStylename("sort.league.RankTopTips");
         _notApplyTips = ComponentFactory.Instance.creatComponentByStylename("sort.league.NotApplyTips");
         _vBox = ComponentFactory.Instance.creatComponentByStylename("sort.league.RankItemVbox");
         _itemList = new Vector.<PVPLeagueRankItem>();
         _loc2_ = 0;
         while(_loc2_ < 10)
         {
            _loc1_ = new PVPLeagueRankItem();
            _loc1_.data = null;
            _itemList.push(_loc1_);
            _vBox.addChild(_loc1_);
            _loc2_++;
         }
         _pageBg = ComponentFactory.Instance.creatComponentByStylename("sort.league.pageBg");
         _pageTxt = ComponentFactory.Instance.creatComponentByStylename("sort.league.PageTxt");
         _lastPageBtn = ComponentFactory.Instance.creatComponentByStylename("sort.league.LastPageBtn");
         _nextPageBtn = ComponentFactory.Instance.creatComponentByStylename("sort.league.NextPageBtn");
         _groupBtn1 = ComponentFactory.Instance.creatComponentByStylename("sort.league.GroupBtn1");
         _groupBtn2 = ComponentFactory.Instance.creatComponentByStylename("sort.league.GroupBtn2");
         _groupBtn3 = ComponentFactory.Instance.creatComponentByStylename("sort.league.GroupBtn3");
         _groupBtn4 = ComponentFactory.Instance.creatComponentByStylename("sort.league.GroupBtn4");
         _groupSelectedGroup = new SelectedButtonGroup();
         _helpBtn = ComponentFactory.Instance.creatComponentByStylename("sort.league.HelpBtn");
         _rankNum.text = LanguageMgr.GetTranslation("gvgcross.view.ranklists.Rank.Title1");
         _nickName.text = LanguageMgr.GetTranslation("PvpHeroFrame.PlayerName");
         _serverName.text = LanguageMgr.GetTranslation("gvgcross.view.ranklists.Rank.Title3");
         _totleScore.text = LanguageMgr.GetTranslation("gvgcross.view.ranklists.Rank.Title5");
         _fightTxt.text = LanguageMgr.GetTranslation("gvgcross.view.ranklists.Rank.Title6");
         _pageTxt.text = "1/1";
         _rankGroupTips.setFrame(1);
         _notApplyTips.text = LanguageMgr.GetTranslation("colosseum.view.ColosseumPlayerItem.newPeople");
         _rankTips2.visible = false;
         _rankTips3.visible = false;
         _rankTips4.visible = false;
         _rankGroupTips.visible = false;
         _rankTopTips.visible = false;
         _notApplyTips.visible = false;
         _helpBtn.tipData = LanguageMgr.GetTranslation("public.help");
         _showReward.tipData = LanguageMgr.GetTranslation("yishi.view.tips.PVPLeagueRewardTips.Txt01");
         addToContent(_bg);
         addToContent(_contentBg);
         addToContent(_rankNum);
         addToContent(_nickName);
         addToContent(_serverName);
         addToContent(_totleScore);
         addToContent(_fightTxt);
         addToContent(_showReward);
         addToContent(_rankTips3);
         addToContent(_rankTips4);
         addToContent(_rankGroupTips);
         addToContent(_rankTopTips);
         addToContent(_notApplyTips);
         addToContent(_vBox);
         addToContent(_pageBg);
         addToContent(_pageTxt);
         addToContent(_lastPageBtn);
         addToContent(_nextPageBtn);
         addToContent(_groupBtn1);
         addToContent(_groupBtn2);
         addToContent(_groupBtn3);
         addToContent(_groupBtn4);
         _groupSelectedGroup.addSelectItem(_groupBtn1);
         _groupSelectedGroup.addSelectItem(_groupBtn2);
         _groupSelectedGroup.addSelectItem(_groupBtn3);
         _groupSelectedGroup.addSelectItem(_groupBtn4);
         addToContent(_helpBtn);
         _groupSelectedGroup.selectIndex = 0;
      }
      
      private function uninitView() : void
      {
         ObjectUtils.disposeAllChildren(this);
         _playerInfo = null;
      }
      
      private function addEvent() : void
      {
         addEventListener("response",__frameResponse);
         _helpBtn.addEventListener("click",__helpHandler);
         _lastPageBtn.addEventListener("click",__onPageHandler);
         _nextPageBtn.addEventListener("click",__onPageHandler);
         if(_groupSelectedGroup)
         {
            _groupSelectedGroup.addEventListener("change",__onTabBtnHandler);
         }
      }
      
      private function removeEvent() : void
      {
         removeEventListener("response",__frameResponse);
         _helpBtn.removeEventListener("click",__helpHandler);
         _lastPageBtn.removeEventListener("click",__onPageHandler);
         _nextPageBtn.removeEventListener("click",__onPageHandler);
         if(_groupSelectedGroup)
         {
            _groupSelectedGroup.removeEventListener("change",__onTabBtnHandler);
         }
      }
      
      private function __onTabBtnHandler(param1:Event) : void
      {
         _currentShowSortInfo = this["_sortInfo" + (_groupSelectedGroup.selectIndex + 1)];
         refreshPageInfo();
         refreshBtnState();
         refreshView();
      }
      
      private function __helpHandler(param1:MouseEvent) : void
      {
         SoundManager.instance.play("022");
         var _loc2_:Frame = ComponentFactory.Instance.creatComponentByStylename("sort.league.HelpFrame");
         _loc2_["show"]();
         param1.stopPropagation();
         param1.stopImmediatePropagation();
      }
      
      private function __onPageHandler(param1:MouseEvent) : void
      {
         SoundManager.instance.play("022");
         pageBtnHandler(param1.currentTarget == _lastPageBtn);
         refreshBtnState();
         refreshView();
      }
      
      private function __frameResponse(param1:FrameEvent) : void
      {
         switch(param1.responseCode)
         {
            case 0:
            case 1:
               FrameControllerManager.instance.openControllerByInfo("pvproomlist");
               dispose();
         }
      }
      
      private function loadData() : void
      {
         var _loc1_:String = PathManager.orderPath + "leaguescore.xml";
         LoaderManagerII.instance.load(_loc1_,5,8,__onDataLoaded);
      }
      
      private function __onDataLoaded(param1:LoaderInfo, param2:Object) : void
      {
         if(isDie)
         {
            return;
         }
         resolveXML(new XML(param2));
         refreshPageInfo();
         refreshBtnState();
         refreshView();
      }
      
      private function resolveXML(param1:XML) : void
      {
         var _loc7_:XMLList = null;
         var _loc4_:* = null;
         var _loc6_:GvgCrossGuildInfo = null;
         var _loc3_:int = 0;
         var _loc5_:int = 0;
         var _loc2_:int = 0;
         _currentShowSortInfo = [];
         _sortInfo1 = [];
         _sortInfo2 = [];
         _sortInfo3 = [];
         _sortInfo4 = [];
         _loc7_ = param1..CrossLeagueConfig;
         for each(_loc4_ in _loc7_)
         {
            _loc3_ = int(_loc4_.@DaimondGroupScoreLevel);
            _loc5_ = int(_loc4_.@GoldenGroupScoreLevel);
            _loc2_ = int(_loc4_.@SilverGroupScoreLevel);
         }
         _loc7_ = param1..CrossLeagueScoreRank;
         for each(_loc4_ in _loc7_)
         {
            _loc6_ = new GvgCrossGuildInfo();
            _loc6_.winCount = int(_loc4_.@rank);
            _loc6_.guildId = int(_loc4_.@userid);
            _loc6_.serverName = _loc4_.@site;
            _loc6_.consortiaName = _loc4_.@nickName;
            _loc6_.fightPower = int(_loc4_.@fightPower);
            _loc6_.totalScore = int(_loc4_.@leagueScore);
            _loc6_.groupId = int(_loc4_.@groupType);
            _loc6_.crossOrder = int(_loc4_.@groupRank);
            this["_sortInfo" + _loc6_.groupId].push(_loc6_);
            if(_loc6_.guildId == _playerInfo.userId)
            {
               _selfGroup = _loc6_.groupId;
               _selfOrder = _loc6_.crossOrder;
            }
         }
         _sortInfo1.sort(sortByCrossOrder);
         _sortInfo2.sort(sortByCrossOrder);
         _sortInfo3.sort(sortByCrossOrder);
         _sortInfo4.sort(sortByCrossOrder);
         _groupBtn1.tipData = LanguageMgr.GetTranslation("yishi.view.frame.pvpleague.PVPLeagueRankListFrame.GroupBtnTips01",_loc3_);
         _groupBtn2.tipData = LanguageMgr.GetTranslation("yishi.view.frame.pvpleague.PVPLeagueRankListFrame.GroupBtnTips01",_loc5_);
         _groupBtn3.tipData = LanguageMgr.GetTranslation("yishi.view.frame.pvpleague.PVPLeagueRankListFrame.GroupBtnTips01",_loc2_);
         _groupBtn4.tipData = LanguageMgr.GetTranslation("yishi.view.frame.pvpleague.PVPLeagueRankListFrame.GroupBtnTips02",_loc2_);
         _currentShowSortInfo = _sortInfo1;
      }
      
      private function sortByCrossOrder(param1:GvgCrossGuildInfo, param2:GvgCrossGuildInfo) : int
      {
         if(param1.crossOrder != 0 && param2.crossOrder == 0)
         {
            return -1;
         }
         if(param1.crossOrder == 0 && param2.crossOrder != 0)
         {
            return 1;
         }
         if(param1.crossOrder < param2.crossOrder)
         {
            return -1;
         }
         if(param1.crossOrder > param2.crossOrder)
         {
            return 1;
         }
         if(param1.totalScore > param2.totalScore)
         {
            return -1;
         }
         if(param1.totalScore < param2.totalScore)
         {
            return 1;
         }
         if(param1.fightPower > param2.fightPower)
         {
            return -1;
         }
         if(param1.fightPower < param2.fightPower)
         {
            return 1;
         }
         return 0;
      }
      
      private function refreshPageInfo() : void
      {
         _currentPage = 1;
         _totalPage = Math.ceil(_currentShowSortInfo.length / 10);
         _totalPage = _totalPage <= _currentPage ? _currentPage : _totalPage;
         _pageStartIndex = (_currentPage - 1) * 10;
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
      
      private function refreshBtnState() : void
      {
         _pageTxt.text = _currentPage + "/" + _totalPage;
         _lastPageBtn.enable = _currentPage != 1;
         _nextPageBtn.enable = _currentPage != _totalPage;
      }
      
      private function refreshView() : void
      {
         var _loc3_:GvgCrossSortData = null;
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         _loc2_ = 0;
         while(_loc2_ < _itemList.length)
         {
            _loc1_ = _pageStartIndex + _loc2_;
            _loc3_ = new GvgCrossSortData();
            if(_loc1_ < _currentShowSortInfo.length)
            {
               _loc3_.guildInfo = _currentShowSortInfo[_loc1_] as GvgCrossGuildInfo;
               _itemList[_loc2_].data = _loc3_;
            }
            else
            {
               _itemList[_loc2_].data = null;
            }
            _loc2_++;
         }
         if(_selfOrder > 0)
         {
            _rankGroupTips.setFrame(_selfGroup);
            _rankTopTips.text = _selfOrder.toString();
            _rankTopTips.width = _rankTopTips.textWidth + 4;
            _rankTips3.x = _rankTopTips.x + _rankTopTips.width;
            if(_selfGroup == 1)
            {
               _rankTopTips.x = 290;
               _rankTips3.x = 325;
            }
            else
            {
               _rankTopTips.x = 250;
               _rankTips3.x = 290;
            }
            _rankTips2.visible = true;
            _rankTips3.visible = true;
            _rankTips4.visible = true;
            _rankGroupTips.visible = true;
            _rankTopTips.visible = true;
            _notApplyTips.visible = false;
         }
         else
         {
            _rankTips2.visible = false;
            _rankTips3.visible = false;
            _rankTips4.visible = true;
            _rankGroupTips.visible = false;
            _rankTopTips.visible = false;
            _notApplyTips.visible = true;
         }
      }
      
      public function show() : void
      {
         LayerManager.Instance.addToLayer(this,3,true,true,2,0,true);
      }
      
      override public function dispose() : void
      {
         if(isDie)
         {
            return;
         }
         removeEvent();
         uninitView();
         if(parent)
         {
            parent.removeChild(this);
         }
         super.dispose();
      }
   }
}

