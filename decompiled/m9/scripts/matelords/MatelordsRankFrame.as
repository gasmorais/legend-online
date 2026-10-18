package matelords
{
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.ui.controls.ListPanel;
   import com.pickgliss.ui.controls.SelectedButtonGroup;
   import com.pickgliss.ui.controls.SelectedIconButton;
   import com.pickgliss.ui.image.Image;
   import com.pickgliss.ui.image.MutipleImage;
   import com.pickgliss.ui.image.ScaleFrameImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import events.MatelordsEvent;
   import flash.events.Event;
   import flash.geom.Rectangle;
   import manager.LanguageMgr;
   import mvc.module.matelords.MatelordsModel;
   import mvc.module.matelords.MatelordsPlayerInfo;
   import yishi.datas.ComponentGroupType;
   import yishi.datas.ConfigInfoManager;
   import yishi.datas.playerinfo.PlayerInfo;
   import yishi.manager.MatelordsManager;
   import yishi.manager.PlayerManager;
   
   public class MatelordsRankFrame extends Frame
   {
      
      private var _bg:MutipleImage;
      
      private var _titleBg:MutipleImage;
      
      private var _rankTitleTxt:FilterFrameText;
      
      private var _nameTitleTxt:FilterFrameText;
      
      private var _fightTitleTxt:FilterFrameText;
      
      private var _winCountTitleTxt:FilterFrameText;
      
      private var _teamTypeTxt:FilterFrameText;
      
      private var _rankListPanel:ListPanel;
      
      private var _rankTips2:Image;
      
      private var _rankTips3:Image;
      
      private var _rankGroupTips:ScaleFrameImage;
      
      private var _rankTopTips:FilterFrameText;
      
      private var _notApplyTips:FilterFrameText;
      
      private var _myTeamScoreTxt:FilterFrameText;
      
      private var _groupBtn1:SelectedIconButton;
      
      private var _groupBtn2:SelectedIconButton;
      
      private var _groupBtn3:SelectedIconButton;
      
      private var _groupBtn4:SelectedIconButton;
      
      private var _groupSelectedGroup:SelectedButtonGroup;
      
      private var _curList:Vector.<MatelordsPlayerInfo>;
      
      private var _playerInfo:PlayerInfo = PlayerManager.instance.currentPlayerModel.playerInfo;
      
      private var _model:MatelordsModel = MatelordsManager.instance.model;
      
      private var scoreArr:Array = [0,0,0,0];
      
      public function MatelordsRankFrame()
      {
         scoreArr = ConfigInfoManager.instance.getMatelordsTeamSorce();
         super();
         initView();
         addEvent();
         refresh();
      }
      
      override public function get groups() : Array
      {
         return [ComponentGroupType.NONE];
      }
      
      public function get viewRectangle() : Rectangle
      {
         return new Rectangle(0,0,535,585);
      }
      
      private function initView() : void
      {
         _groupBtn1 = ComponentFactory.Instance.creatComponentByStylename("matelords.MatelordsRankFrame.GroupBtn1");
         _groupBtn2 = ComponentFactory.Instance.creatComponentByStylename("matelords.MatelordsRankFrame.GroupBtn2");
         _groupBtn3 = ComponentFactory.Instance.creatComponentByStylename("matelords.MatelordsRankFrame.GroupBtn3");
         _groupBtn4 = ComponentFactory.Instance.creatComponentByStylename("matelords.MatelordsRankFrame.GroupBtn4");
         _bg = ComponentFactory.Instance.creatComponentByStylename("matelords.MatelordsRankFrame.Bg");
         _titleBg = ComponentFactory.Instance.creatComponentByStylename("matelords.MatelordsRankFrame.TitleBg");
         _myTeamScoreTxt = ComponentFactory.Instance.creatComponentByStylename("matelords.MatelordsRankFrame.MyFightTxt");
         _rankListPanel = ComponentFactory.Instance.creatComponentByStylename("matelords.MatelordsRankFrame.RankListPanel");
         _rankTitleTxt = ComponentFactory.Instance.creatComponentByStylename("matelords.MatelordsRankFrameRankTitleTxt");
         _nameTitleTxt = ComponentFactory.Instance.creatComponentByStylename("matelords.MatelordsRankFrameNameTitleTxt");
         _fightTitleTxt = ComponentFactory.Instance.creatComponentByStylename("matelords.MatelordsRankFrameFightTitleTxt");
         _winCountTitleTxt = ComponentFactory.Instance.creatComponentByStylename("matelords.MatelordsRankFrameWinCountTitleTxt");
         _teamTypeTxt = ComponentFactory.Instance.creatComponentByStylename("matelords.MatelordsRankFrame.UpdateTimeTxt");
         _notApplyTips = ComponentFactory.Instance.creatComponentByStylename("matelords.MatelordsRankFrame.NotApplyTips");
         _rankTips2 = ComponentFactory.Instance.creatComponentByStylename("matelords.MatelordsRankFrame.RankTips2");
         _rankTips3 = ComponentFactory.Instance.creatComponentByStylename("matelords.MatelordsRankFrame.RankTips3");
         _rankGroupTips = ComponentFactory.Instance.creatComponentByStylename("matelords.MatelordsRankFrame.RankGroupTips");
         _rankTopTips = ComponentFactory.Instance.creatComponentByStylename("matelords.MatelordsRankFrame.RankTopTips");
         addToContent(_bg);
         addToContent(_myTeamScoreTxt);
         addToContent(_titleBg);
         addToContent(_rankTitleTxt);
         addToContent(_nameTitleTxt);
         addToContent(_fightTitleTxt);
         addToContent(_winCountTitleTxt);
         addToContent(_teamTypeTxt);
         addToContent(_notApplyTips);
         addToContent(_rankListPanel);
         addToContent(_rankTips3);
         addToContent(_rankGroupTips);
         addToContent(_rankTopTips);
         addToContent(_groupBtn1);
         addToContent(_groupBtn2);
         addToContent(_groupBtn3);
         addToContent(_groupBtn4);
         _groupSelectedGroup = new SelectedButtonGroup();
         _groupSelectedGroup.addSelectItem(_groupBtn1);
         _groupSelectedGroup.addSelectItem(_groupBtn2);
         _groupSelectedGroup.addSelectItem(_groupBtn3);
         _groupSelectedGroup.addSelectItem(_groupBtn4);
         _groupSelectedGroup.selectIndex = _model.teamType - 1;
         _rankTitleTxt.text = LanguageMgr.GetTranslation("colosseum.view.HeroRankFrame.rank");
         _nameTitleTxt.text = LanguageMgr.GetTranslation("matelords.MatelordsRankFrame.str03");
         _fightTitleTxt.text = LanguageMgr.GetTranslation("matelords.MatelordsRankFrame.str04");
         _winCountTitleTxt.text = LanguageMgr.GetTranslation("matelords.MatelordsRankFrame.str02");
         _notApplyTips.text = LanguageMgr.GetTranslation("colosseum.view.ColosseumPlayerItem.newPeople");
         _notApplyTips.visible = false;
      }
      
      private function uninitView() : void
      {
         ObjectUtils.disposeObject(_bg);
         _bg = null;
         ObjectUtils.disposeObject(_titleBg);
         _titleBg = null;
         ObjectUtils.disposeObject(_rankTitleTxt);
         _rankTitleTxt = null;
         ObjectUtils.disposeObject(_nameTitleTxt);
         _nameTitleTxt = null;
         ObjectUtils.disposeObject(_fightTitleTxt);
         _fightTitleTxt = null;
         ObjectUtils.disposeObject(_winCountTitleTxt);
         _winCountTitleTxt = null;
         ObjectUtils.disposeObject(_teamTypeTxt);
         _teamTypeTxt = null;
         ObjectUtils.disposeObject(_notApplyTips);
         _notApplyTips = null;
         ObjectUtils.disposeObject(_rankTips2);
         _rankTips2 = null;
         ObjectUtils.disposeObject(_rankTips3);
         _rankTips3 = null;
         ObjectUtils.disposeObject(_rankGroupTips);
         _rankGroupTips = null;
         ObjectUtils.disposeObject(_rankTopTips);
         _rankTopTips = null;
         ObjectUtils.disposeObject(_rankTopTips);
         _rankTopTips = null;
         ObjectUtils.disposeObject(_groupBtn1);
         _groupBtn1 = null;
         ObjectUtils.disposeObject(_groupBtn2);
         _groupBtn2 = null;
         ObjectUtils.disposeObject(_groupBtn3);
         _groupBtn3 = null;
         ObjectUtils.disposeObject(_groupBtn4);
         _groupBtn4 = null;
         _groupSelectedGroup = null;
         ObjectUtils.disposeObject(_myTeamScoreTxt);
         _myTeamScoreTxt = null;
         ObjectUtils.disposeAllChildren(this);
         _curList = null;
      }
      
      private function addEvent() : void
      {
         addEventListener("response",__frameResponseHandler);
         _model.addEventListener("INFO_UPDATE",__matelordsInfoUpdateHandler);
         if(_groupSelectedGroup)
         {
            _groupSelectedGroup.addEventListener("change",__onTabBtnHandler);
         }
      }
      
      private function removeEvent() : void
      {
         removeEventListener("response",__frameResponseHandler);
         _model.removeEventListener("INFO_UPDATE",__matelordsInfoUpdateHandler);
         if(_groupSelectedGroup)
         {
            _groupSelectedGroup.removeEventListener("change",__onTabBtnHandler);
         }
      }
      
      private function __onTabBtnHandler(param1:Event) : void
      {
         refresh();
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
      
      private function __matelordsInfoUpdateHandler(param1:MatelordsEvent) : void
      {
         refresh();
      }
      
      public function refresh() : void
      {
         _rankGroupTips.visible = true;
         _rankTips2.visible = true;
         _rankTips3.visible = true;
         var _loc1_:int = int(_groupSelectedGroup.selectIndex);
         _rankGroupTips.setFrame(_model.teamType);
         _rankTopTips.text = _model.order.toString();
         _myTeamScoreTxt.text = _model.totalScore.toString();
         _teamTypeTxt.text = LanguageMgr.GetTranslation("MatelordsRankFrame.UpdateTimeTxt.text" + _loc1_,scoreArr[_loc1_]);
         if(_model.order <= 0)
         {
            _notApplyTips.visible = true;
            _rankGroupTips.visible = false;
            _rankTips2.visible = false;
            _rankTips3.visible = false;
            _rankTopTips.text = "";
         }
         _rankListPanel.vectorListModel.clear();
         for each(var _loc2_:MatelordsPlayerInfo in showList)
         {
            _rankListPanel.vectorListModel.append(_loc2_);
         }
         _rankListPanel.list.updateListView();
      }
      
      private function get showList() : Array
      {
         var _loc1_:Array = [];
         for each(var _loc2_:MatelordsPlayerInfo in _model.rankList)
         {
            if(_loc2_.teamType == _groupSelectedGroup.selectIndex + 1)
            {
               _loc1_.push(_loc2_);
            }
         }
         _loc1_.sortOn("curOrder",16);
         return _loc1_;
      }
      
      public function show() : void
      {
         LayerManager.Instance.addToLayer(this,3,true,true);
         titleText = LanguageMgr.GetTranslation("matelords.MatelordsRankFrame.str01");
      }
      
      override public function dispose() : void
      {
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

