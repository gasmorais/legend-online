package godsevening
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.BaseButton;
   import com.pickgliss.ui.controls.container.VBox;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.ui.image.Image;
   import com.pickgliss.ui.image.MutipleImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import events.GodsEveningEvent;
   import flash.events.MouseEvent;
   import flash.utils.Dictionary;
   import manager.LanguageMgr;
   import mvc.module.godsevening.GERankItemServerData;
   import mvc.module.godsevening.GodsEveningModel;
   import yishi.manager.GodsEveningManager;
   
   public class GERankServerView extends Component
   {
      
      private const PAGE_NUM:int = 8;
      
      private var _bg:Image;
      
      private var _rank:FilterFrameText;
      
      private var _server:FilterFrameText;
      
      private var _fightPower:FilterFrameText;
      
      private var _score:FilterFrameText;
      
      private var _vBox:VBox;
      
      private var _pageTxt:FilterFrameText;
      
      private var _prePageBtn:BaseButton;
      
      private var _nextPageBtn:BaseButton;
      
      private var _tip:Image;
      
      private var _selfInfoBg:MutipleImage;
      
      private var _myRank:FilterFrameText;
      
      private var _myScore:FilterFrameText;
      
      private var _totalPage:int;
      
      private var _curPage:int = 1;
      
      private var _curDic:Dictionary;
      
      private var _model:GodsEveningModel = GodsEveningManager.instance.model;
      
      private var _itemArr:Array;
      
      public function GERankServerView()
      {
         super();
         initView();
         addEvent();
         GodsEveningManager.instance.sendRequstMainFrameRankInfo(1);
         __infoChangeHandler(null);
      }
      
      private function initView() : void
      {
         var _loc2_:int = 0;
         var _loc1_:GERankServerItem = null;
         _bg = ComponentFactory.Instance.creatComponentByStylename("GERankPersonalView.Bg");
         _rank = ComponentFactory.Instance.creatComponentByStylename("GERankPersonalView.Rank");
         _server = ComponentFactory.Instance.creatComponentByStylename("GERankPersonalView.ServerName");
         _fightPower = ComponentFactory.Instance.creatComponentByStylename("GERankPersonalView.FightPower");
         _score = ComponentFactory.Instance.creatComponentByStylename("GERankPersonalView.Score");
         _vBox = ComponentFactory.Instance.creatCustomObject("GERankPersonalView.vbox");
         _pageTxt = ComponentFactory.Instance.creatComponentByStylename("GERankPersonalView.pageTxt");
         _prePageBtn = ComponentFactory.Instance.creatComponentByStylename("GERankPersonalView.prePageBtn");
         _nextPageBtn = ComponentFactory.Instance.creatComponentByStylename("GERankPersonalView.nextPageBtn");
         _tip = ComponentFactory.Instance.creatComponentByStylename("GERankServerView.Tip");
         _selfInfoBg = ComponentFactory.Instance.creatComponentByStylename("GERankPersonalView.RankBg");
         _myRank = ComponentFactory.Instance.creatComponentByStylename("GERankPersonalView.MyRankTxt");
         _myScore = ComponentFactory.Instance.creatComponentByStylename("GERankPersonalView.MyScoreTxt");
         addChild(_bg);
         addChild(_rank);
         _rank.x = 20;
         addChild(_server);
         _server.x = 175;
         addChild(_fightPower);
         _fightPower.x = 320;
         addChild(_score);
         addChild(_pageTxt);
         addChild(_prePageBtn);
         addChild(_nextPageBtn);
         addChild(_tip);
         addChild(_selfInfoBg);
         addChild(_myRank);
         addChild(_myScore);
         addChild(_vBox);
         _rank.text = LanguageMgr.GetTranslation("godsEvening.rank");
         _server.text = LanguageMgr.GetTranslation("godsEvening.serverName");
         _fightPower.text = LanguageMgr.GetTranslation("godsEvening.fightPower");
         _score.text = LanguageMgr.GetTranslation("godsEvening.score");
         _itemArr = [];
         _loc2_ = 0;
         while(_loc2_ < 8)
         {
            _loc1_ = new GERankServerItem();
            _vBox.addChild(_loc1_);
            _itemArr.push(_loc1_);
            _loc2_++;
         }
      }
      
      private function unInitView() : void
      {
         ObjectUtils.disposeObject(_bg);
         _rank = null;
         ObjectUtils.disposeObject(_rank);
         _rank = null;
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
         ObjectUtils.disposeObject(_myRank);
         _myRank = null;
         ObjectUtils.disposeObject(_myScore);
         _myScore = null;
         for each(var _loc1_:GERankServerItem in _itemArr)
         {
            ObjectUtils.disposeObject(_loc1_);
            _loc1_ = null;
         }
         ObjectUtils.disposeObject(_vBox);
         _vBox = null;
         _curDic = null;
      }
      
      private function addEvent() : void
      {
         GodsEveningManager.instance.addEventListener("MAIN_FRAME_RANK_INFO",__infoChangeHandler);
         _prePageBtn.addEventListener("click",__onChangePageClick);
         _nextPageBtn.addEventListener("click",__onChangePageClick);
      }
      
      private function removeEvent() : void
      {
         GodsEveningManager.instance.removeEventListener("MAIN_FRAME_RANK_INFO",__infoChangeHandler);
         _prePageBtn.removeEventListener("click",__onChangePageClick);
         _nextPageBtn.removeEventListener("click",__onChangePageClick);
      }
      
      override public function dispose() : void
      {
         removeEvent();
         unInitView();
         super.dispose();
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
      
      private function __infoChangeHandler(param1:GodsEveningEvent) : void
      {
         refreshRanks();
         refreshMyInfo();
      }
      
      private function refreshRanks() : void
      {
         var _loc2_:GERankItemServerData = null;
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         var _loc1_:int = 1 + 8 * (_curPage - 1);
         _loc4_ = 0;
         while(_loc4_ < 8)
         {
            _loc3_ = _loc1_ + _loc4_;
            _loc2_ = _model.mainFrameServerRankDic[_loc3_];
            (_itemArr[_loc4_] as GERankServerItem).data = _loc2_;
            _loc4_++;
         }
         _prePageBtn.enable = _curPage > 1;
         _nextPageBtn.enable = _curPage < totalPage;
         _pageTxt.text = LanguageMgr.GetTranslation("unrealshooting.UnrealShootingRankView.page",_curPage,totalPage > 0 ? totalPage : 1);
      }
      
      private function refreshMyInfo() : void
      {
         var _loc1_:int = int(_model.serverOrder);
         if(_loc1_ == 0)
         {
            _myRank.text = LanguageMgr.GetTranslation("godsEvening.GodsEveningSelfInfoView.noRank");
         }
         else
         {
            _myRank.text = _loc1_.toString();
         }
         _myScore.text = _model.serverScore.toString();
      }
      
      private function get totalPage() : int
      {
         var _loc2_:int = 0;
         for each(var _loc1_:GERankItemServerData in _model.mainFrameServerRankDic)
         {
            _loc2_++;
         }
         return Math.ceil(_loc2_ / 8);
      }
   }
}

