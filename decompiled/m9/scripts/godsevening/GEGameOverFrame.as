package godsevening
{
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.BaseButton;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.ui.controls.container.VBox;
   import com.pickgliss.ui.image.Image;
   import com.pickgliss.ui.image.MutipleImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import flash.events.MouseEvent;
   import flash.utils.Dictionary;
   import manager.LanguageMgr;
   import mvc.module.godsevening.GERankItemPersonData;
   import mvc.module.godsevening.GERankItemServerData;
   import yishi.datas.ComponentGroupType;
   import yishi.datas.goods.GoodsInfo;
   import yishi.view.community.BaseItemView;
   
   public class GEGameOverFrame extends Frame
   {
      
      private const PAGE_NUM:int = 8;
      
      private var _bg:Image;
      
      private var _serverVbox:VBox;
      
      private var _rank:FilterFrameText;
      
      private var _nickName:FilterFrameText;
      
      private var _server:FilterFrameText;
      
      private var _fightPower:FilterFrameText;
      
      private var _score:FilterFrameText;
      
      private var _vBox:VBox;
      
      private var _pageTxt:FilterFrameText;
      
      private var _prePageBtn:BaseButton;
      
      private var _nextPageBtn:BaseButton;
      
      private var _tip:Image;
      
      private var _selfInfoBg:MutipleImage;
      
      private var _myRankTxt:FilterFrameText;
      
      private var _myScoreTxt:FilterFrameText;
      
      private var _rewardGot:Image;
      
      private var _rewardItem:BaseItemView;
      
      private var _totalPage:int;
      
      private var _curPage:int = 1;
      
      private var _itemArr:Array;
      
      private var _serverArr:Array;
      
      private var _personRankDic:Dictionary;
      
      private var _serverRankDic:Dictionary;
      
      private var _myRank:int;
      
      private var _myScore:int;
      
      private var _myServerRank:int;
      
      public function GEGameOverFrame()
      {
         super();
         initView();
         addEvent();
      }
      
      override public function get groups() : Array
      {
         return [ComponentGroupType.NONE];
      }
      
      private function initView() : void
      {
         var _loc2_:GEGameOverServerItem = null;
         var _loc4_:int = 0;
         var _loc1_:GERankPersonalItem = null;
         var _loc3_:int = 0;
         _bg = ComponentFactory.Instance.creatComponentByStylename("GEGameOverFrame.bg");
         _serverVbox = ComponentFactory.Instance.creatCustomObject("GEGameOverFrame.ServerVBox");
         _rank = ComponentFactory.Instance.creatComponentByStylename("GERankPersonalView.Rank");
         _nickName = ComponentFactory.Instance.creatComponentByStylename("GERankPersonalView.NickName");
         _server = ComponentFactory.Instance.creatComponentByStylename("GERankPersonalView.ServerName");
         _fightPower = ComponentFactory.Instance.creatComponentByStylename("GERankPersonalView.FightPower");
         _score = ComponentFactory.Instance.creatComponentByStylename("GERankPersonalView.Score");
         _vBox = ComponentFactory.Instance.creatCustomObject("GERankPersonalView.vbox");
         _pageTxt = ComponentFactory.Instance.creatComponentByStylename("GERankPersonalView.pageTxt");
         _prePageBtn = ComponentFactory.Instance.creatComponentByStylename("GERankPersonalView.prePageBtn");
         _nextPageBtn = ComponentFactory.Instance.creatComponentByStylename("GERankPersonalView.nextPageBtn");
         _tip = ComponentFactory.Instance.creatComponentByStylename("GERankPersonalView.Tip");
         _selfInfoBg = ComponentFactory.Instance.creatComponentByStylename("GERankPersonalView.RankBg");
         _myRankTxt = ComponentFactory.Instance.creatComponentByStylename("GERankPersonalView.MyRankTxt");
         _myScoreTxt = ComponentFactory.Instance.creatComponentByStylename("GERankPersonalView.MyScoreTxt");
         _rewardGot = ComponentFactory.Instance.creatComponentByStylename("GEGameOverFrame.RewardGot");
         _rewardItem = ComponentFactory.Instance.creatCustomObject("GEGameOverFrame.Item");
         addToContent(_bg);
         addToContent(_serverVbox);
         addToContent(_rank);
         _rank.x += 270;
         addToContent(_nickName);
         _nickName.x += 270;
         addToContent(_server);
         _server.x += 270;
         addToContent(_fightPower);
         _fightPower.x += 250;
         addToContent(_score);
         _score.x += 290;
         addToContent(_pageTxt);
         _pageTxt.x += 270;
         addToContent(_prePageBtn);
         _prePageBtn.x += 270;
         addToContent(_nextPageBtn);
         _nextPageBtn.x += 270;
         addToContent(_tip);
         _tip.x += 270;
         addToContent(_selfInfoBg);
         _selfInfoBg.x += 270;
         addToContent(_myRankTxt);
         _myRankTxt.x += 315;
         addToContent(_myScoreTxt);
         _myScoreTxt.x += 270;
         addToContent(_vBox);
         _vBox.x += 270;
         addToContent(_rewardGot);
         addToContent(_rewardItem);
         _rank.text = LanguageMgr.GetTranslation("godsEvening.rank");
         _nickName.text = LanguageMgr.GetTranslation("godsEvening.nickName");
         _server.text = LanguageMgr.GetTranslation("godsEvening.serverName");
         _fightPower.text = LanguageMgr.GetTranslation("godsEvening.fightPower");
         _score.text = LanguageMgr.GetTranslation("godsEvening.score");
         _serverArr = [];
         _loc4_ = 0;
         while(_loc4_ < 3)
         {
            _loc2_ = new GEGameOverServerItem(_loc4_ + 1);
            _serverVbox.addChild(_loc2_);
            _serverArr.push(_loc2_);
            _loc4_++;
         }
         _itemArr = [];
         _loc3_ = 0;
         while(_loc3_ < 8)
         {
            _loc1_ = new GERankPersonalItem();
            _vBox.addChild(_loc1_);
            _itemArr.push(_loc1_);
            _loc3_++;
         }
         titleText = LanguageMgr.GetTranslation("godsEvening.GEGameOverFrame.title");
      }
      
      private function unInitView() : void
      {
         ObjectUtils.disposeObject(_bg);
         _bg = null;
         ObjectUtils.disposeObject(_rank);
         _rank = null;
         ObjectUtils.disposeObject(_nickName);
         _nickName = null;
         ObjectUtils.disposeObject(_server);
         _server = null;
         ObjectUtils.disposeObject(_fightPower);
         _fightPower = null;
         ObjectUtils.disposeObject(_score);
         _score = null;
         ObjectUtils.disposeObject(_pageTxt);
         _pageTxt = null;
         ObjectUtils.disposeObject(_prePageBtn);
         _prePageBtn = null;
         ObjectUtils.disposeObject(_nextPageBtn);
         _nextPageBtn = null;
         ObjectUtils.disposeObject(_tip);
         _tip = null;
         ObjectUtils.disposeObject(_selfInfoBg);
         _selfInfoBg = null;
         ObjectUtils.disposeObject(_myRankTxt);
         _myRankTxt = null;
         ObjectUtils.disposeObject(_myScoreTxt);
         _myScoreTxt = null;
         for each(var _loc1_:GERankPersonalItem in _itemArr)
         {
            ObjectUtils.disposeObject(_loc1_);
            _loc1_ = null;
         }
         ObjectUtils.disposeObject(_vBox);
         _vBox = null;
         ObjectUtils.disposeObject(_rewardGot);
         _rewardGot = null;
         ObjectUtils.disposeObject(_rewardItem);
         _rewardItem = null;
      }
      
      private function addEvent() : void
      {
         addEventListener("response",__frameResponse);
         _prePageBtn.addEventListener("click",__onChangePageClick);
         _nextPageBtn.addEventListener("click",__onChangePageClick);
      }
      
      private function removeEvent() : void
      {
         removeEventListener("response",__frameResponse);
         _prePageBtn.removeEventListener("click",__onChangePageClick);
         _nextPageBtn.removeEventListener("click",__onChangePageClick);
      }
      
      override public function dispose() : void
      {
         removeEvent();
         unInitView();
         super.dispose();
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
      
      private function __onChangePageClick(param1:MouseEvent) : void
      {
         if(param1.target == _prePageBtn)
         {
            _curPage = _curPage - 1;
         }
         if(param1.target == _nextPageBtn)
         {
            _curPage = _curPage + 1;
         }
         refreshRanks();
      }
      
      private function refreshView() : void
      {
         refreshRanks();
         refreshMyInfo();
         refreshServerRank();
      }
      
      private function refreshServerRank() : void
      {
         var _loc3_:int = 0;
         var _loc2_:GERankItemServerData = null;
         var _loc4_:int = 0;
         for each(var _loc1_:GERankItemServerData in _serverRankDic)
         {
            _loc3_++;
         }
         if(_loc3_ > 3)
         {
            _loc3_ = 3;
         }
         _loc4_ = 0;
         while(_loc4_ < _loc3_)
         {
            _loc2_ = _serverRankDic[_loc4_ + 1];
            (_serverArr[_loc4_] as GEGameOverServerItem).setData(_loc2_.serverName,getServerRewardCountByRank(_loc4_ + 1),_loc2_.teamId);
            _loc4_++;
         }
      }
      
      private function getServerRewardCountByRank(param1:int) : int
      {
         var _loc2_:int = 0;
         if(param1 == 1)
         {
            _loc2_ = 3500;
         }
         else if(param1 == 2)
         {
            _loc2_ = 2500;
         }
         else if(param1 == 3)
         {
            _loc2_ = 1500;
         }
         return _loc2_;
      }
      
      private function getPersonRewardCountByRank(param1:int) : int
      {
         var _loc2_:int = 0;
         if(param1 == 1)
         {
            _loc2_ = 3500;
         }
         else if(param1 == 2)
         {
            _loc2_ = 3000;
         }
         else if(param1 == 3)
         {
            _loc2_ = 2500;
         }
         else if(param1 >= 4 && param1 <= 20)
         {
            _loc2_ = 2000;
         }
         else if(param1 >= 21 && param1 <= 50)
         {
            _loc2_ = 1500;
         }
         else if(param1 >= 51 && param1 <= 100)
         {
            _loc2_ = 1000;
         }
         return int(_loc2_ + getServerRewardCountByRank(_myServerRank));
      }
      
      private function refreshRanks() : void
      {
         var _loc2_:GERankItemPersonData = null;
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         var _loc1_:int = 1 + 8 * (_curPage - 1);
         _loc4_ = 0;
         while(_loc4_ < 8)
         {
            _loc3_ = _loc1_ + _loc4_;
            _loc2_ = _personRankDic[_loc3_];
            (_itemArr[_loc4_] as GERankPersonalItem).data = _loc2_;
            _loc4_++;
         }
         _prePageBtn.enable = _curPage > 1;
         _nextPageBtn.enable = _curPage < totalPage;
         _pageTxt.text = LanguageMgr.GetTranslation("unrealshooting.UnrealShootingRankView.page",_curPage,totalPage > 0 ? totalPage : 1);
      }
      
      private function refreshMyInfo() : void
      {
         if(_myRank == 0)
         {
            _myRankTxt.text = LanguageMgr.GetTranslation("godsEvening.GodsEveningSelfInfoView.noRank");
         }
         else
         {
            _myRankTxt.text = _myRank.toString();
         }
         _myScoreTxt.text = _myScore.toString();
         var _loc1_:GoodsInfo = new GoodsInfo();
         _loc1_.templateId = -11000;
         _loc1_.count = getPersonRewardCountByRank(_myRank);
         _rewardItem.data = _loc1_;
      }
      
      private function get totalPage() : int
      {
         var _loc2_:int = 0;
         for each(var _loc1_:GERankItemPersonData in _personRankDic)
         {
            _loc2_++;
         }
         return Math.ceil(_loc2_ / 8);
      }
      
      public function show(param1:Object) : void
      {
         _personRankDic = param1.personRankDic;
         _serverRankDic = param1.serverRankDic;
         _myRank = param1.myRank;
         _myScore = param1.myScore;
         _myServerRank = param1.myServerRank;
         refreshView();
         LayerManager.Instance.addToLayer(this,3,true,true);
      }
   }
}

