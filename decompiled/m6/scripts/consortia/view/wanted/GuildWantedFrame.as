package consortia.view.wanted
{
   import avatar.view.ShowAvatar;
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.instance.IManualSize;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.ui.controls.IconButton;
   import com.pickgliss.ui.controls.ScrollPanel;
   import com.pickgliss.ui.controls.TextButton;
   import com.pickgliss.ui.controls.container.VBox;
   import com.pickgliss.ui.image.MutipleImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.geom.Point;
   import flash.geom.Rectangle;
   import manager.LanguageMgr;
   import mvc.module.guildwanted.GuildWantedModel;
   import mvc.module.sort.SortModel;
   import utils.LogicUtils;
   import yishi.datas.ConfigInfoManager;
   import yishi.datas.goods.GoodsInfo;
   import yishi.datas.playerinfo.PlayerInfo;
   import yishi.datas.playerinfo.ThaneInfo;
   import yishi.manager.GuildWantedManager;
   import yishi.manager.PlayerManager;
   import yishi.manager.RechargeAlertMannager;
   import yishi.manager.SharedManager;
   import yishi.utils.MsgMan;
   import yishi.utils.SimpleDictionary;
   import yishi.view.base.ProgressCommon;
   import yishi.view.base.StarGroupView;
   import yishi.view.community.TimeDownView;
   import yishi.view.frame.TodayNotAlertFrame;
   
   public class GuildWantedFrame extends Frame implements IManualSize
   {
      
      private static const NUM:int = 6;
      
      public var _back:MutipleImage;
      
      public var _spanel:ScrollPanel;
      
      public var _vBox:VBox;
      
      public var _refreshBtn:IconButton;
      
      public var _fightBtn:IconButton;
      
      public var _selfScoreTxt:FilterFrameText;
      
      public var _guildScoreTxt:FilterFrameText;
      
      public var _selfScoreDesc:FilterFrameText;
      
      public var _guildScoreDesc:FilterFrameText;
      
      public var _targetTxt:FilterFrameText;
      
      public var _starTxt:FilterFrameText;
      
      public var _rewardTxt:FilterFrameText;
      
      public var _countTxt:FilterFrameText;
      
      public var _rank:FilterFrameText;
      
      public var _name:FilterFrameText;
      
      public var _score:FilterFrameText;
      
      public var _totalScoreTxt:FilterFrameText;
      
      public var _selfRankTxt:FilterFrameText;
      
      public var _rewardListBtn:TextButton;
      
      private var _selfBar:ProgressCommon;
      
      private var _guildBar:ProgressCommon;
      
      private var _selfItemList:Vector.<GuildWantedChestItem>;
      
      private var _guildItemList:Vector.<GuildWantedChestItem>;
      
      private var _starGroup:StarGroupView;
      
      private var _downTime:TimeDownView;
      
      private var _refreshTxt:FilterFrameText;
      
      private var _figure:ShowAvatar;
      
      private var _sortModel:SortModel;
      
      private var _thane:ThaneInfo;
      
      private var _nickNameTxt:FilterFrameText;
      
      private var _consortiaNameTxt:FilterFrameText;
      
      private var _tipView:GuildWantedRewardTipView;
      
      public function GuildWantedFrame()
      {
         super();
         GuildWantedManager.instance.sendRequest(2);
         initView();
         initEvent();
         refreshView();
      }
      
      private function initView() : void
      {
         titleText = LanguageMgr.GetTranslation("guildWantedFrame.titleText.text");
         _back = ComponentFactory.Instance.creatComponentByStylename("ui.guildwanted.back");
         _spanel = ComponentFactory.Instance.creatComponentByStylename("ui.guildwanted.spanel");
         _vBox = ComponentFactory.Instance.creatCustomObject("ui.guildwanted.vBox");
         _refreshBtn = ComponentFactory.Instance.creatComponentByStylename("ui.guildwanted.refreshBtn");
         _fightBtn = ComponentFactory.Instance.creatComponentByStylename("ui.guildwanted.fightBtn");
         _selfScoreTxt = ComponentFactory.Instance.creatComponentByStylename("ui.guildwanted.selfScoreTxt");
         _guildScoreTxt = ComponentFactory.Instance.creatComponentByStylename("ui.guildwanted.guildScoreTxt");
         _selfScoreDesc = ComponentFactory.Instance.creatComponentByStylename("ui.guildwanted.selfScoreDesc");
         _guildScoreDesc = ComponentFactory.Instance.creatComponentByStylename("ui.guildwanted.guildScoreDesc");
         _targetTxt = ComponentFactory.Instance.creatComponentByStylename("ui.guildwanted.targetTxt");
         _starTxt = ComponentFactory.Instance.creatComponentByStylename("ui.guildwanted.starTxt");
         _rewardTxt = ComponentFactory.Instance.creatComponentByStylename("ui.guildwanted.rewardTxt");
         _countTxt = ComponentFactory.Instance.creatComponentByStylename("ui.guildwanted.countTxt");
         _rank = ComponentFactory.Instance.creatComponentByStylename("ui.guildwanted.rank");
         _name = ComponentFactory.Instance.creatComponentByStylename("ui.guildwanted.name");
         _score = ComponentFactory.Instance.creatComponentByStylename("ui.guildwanted.score");
         _totalScoreTxt = ComponentFactory.Instance.creatComponentByStylename("ui.guildwanted.totalScoreTxt");
         _selfRankTxt = ComponentFactory.Instance.creatComponentByStylename("ui.guildwanted.selfRankTxt");
         _rewardListBtn = ComponentFactory.Instance.creatComponentByStylename("GuildWantedFrame.rewardListBtn");
         _selfBar = ComponentFactory.Instance.creatComponentByStylename("GuildWantedFrame.selfBar");
         _guildBar = ComponentFactory.Instance.creatComponentByStylename("GuildWantedFrame.guildBar");
         _downTime = ComponentFactory.Instance.creatComponentByStylename("GuildWantedFrame.downUpdateTime");
         _refreshTxt = ComponentFactory.Instance.creatComponentByStylename("GuildWantedFrame.refreshTxt");
         _nickNameTxt = ComponentFactory.Instance.creatComponentByStylename("GuildWantedFrame.nickNameTxt");
         _consortiaNameTxt = ComponentFactory.Instance.creatComponentByStylename("GuildWantedFrame.consortiaNameTxt");
         addToContent(_back);
         addToContent(_spanel);
         addToContent(_vBox);
         addToContent(_refreshBtn);
         addToContent(_selfScoreTxt);
         addToContent(_guildScoreTxt);
         addToContent(_selfScoreDesc);
         addToContent(_guildScoreDesc);
         addToContent(_targetTxt);
         addToContent(_starTxt);
         addToContent(_rewardTxt);
         addToContent(_countTxt);
         addToContent(_rank);
         addToContent(_name);
         addToContent(_score);
         addToContent(_totalScoreTxt);
         addToContent(_selfRankTxt);
         _selfRankTxt.y = 518;
         addToContent(_rewardListBtn);
         addToContent(_selfBar);
         addToContent(_guildBar);
         addToContent(_downTime);
         addToContent(_refreshTxt);
         initSelfChest();
         initGuildChest();
         _starGroup = new StarGroupView();
         _starGroup.initParams("asset.guildwanted.grayStar",22,"asset.guildwanted.lightStar",22,5);
         _starGroup.x = 470;
         _starGroup.y = 229;
         addToContent(_starGroup);
         _figure = new ShowAvatar();
         _figure.x = 60;
         _figure.y = 270;
         _figure.scaleX = 0.9;
         _figure.scaleY = 0.9;
         addToContent(_figure);
         addToContent(_fightBtn);
         addToContent(_nickNameTxt);
         addToContent(_consortiaNameTxt);
         _selfScoreDesc.text = LanguageMgr.GetTranslation("guildWantedFrame.selfScoreDesc.text");
         _guildScoreDesc.text = LanguageMgr.GetTranslation("guildWantedFrame.guildScoreDesc.text");
         _rank.text = LanguageMgr.GetTranslation("guildWantedFrame.rank.text");
         _name.text = LanguageMgr.GetTranslation("guildWantedFrame.name.text");
         _score.text = LanguageMgr.GetTranslation("guildWantedFrame.score.text");
         _refreshTxt.text = LanguageMgr.GetTranslation("guildWantedFrame.refreshTxt.text");
         _starTxt.text = LanguageMgr.GetTranslation("guildWantedFrame.starTxt.text");
         _rewardListBtn.text = LanguageMgr.GetTranslation("guildWantedFrame.rewardListTxt.text");
         _spanel.setView(_vBox);
      }
      
      private function refreshAvatar() : void
      {
         var _loc5_:int = 0;
         var _loc7_:GoodsInfo = null;
         var _loc1_:String = null;
         if(model.targetInfo.fashion == "")
         {
            return;
         }
         var _loc6_:ThaneInfo = new ThaneInfo();
         var _loc4_:SimpleDictionary = new SimpleDictionary(true);
         _loc6_.templateId = model.targetInfo.job;
         _loc6_.hideFashion = model.targetInfo.isHiden;
         var _loc2_:Array = ["wingAvata","hairFashionAvata","bodyFashionAvata","armsFashionAvata","armsEquipAvata","bodyEquipAvata"];
         var _loc3_:Array = model.targetInfo.fashion.split("|");
         _loc5_ = 0;
         while(_loc5_ < _loc3_.length)
         {
            _loc7_ = new GoodsInfo();
            _loc7_.templateId = _loc3_[_loc5_];
            _loc1_ = "";
            if(_loc7_ && _loc7_.templateInfo)
            {
               _loc1_ = _loc7_.templateInfo.Avata;
            }
            _loc6_[_loc2_[_loc5_]] = _loc1_;
            _loc5_++;
         }
         _figure.data = _loc6_;
      }
      
      private function initSelfChest() : void
      {
         var _loc1_:GuildWantedChestItem = null;
         var _loc2_:int = 0;
         _selfItemList = new Vector.<GuildWantedChestItem>();
         _loc2_ = 0;
         while(_loc2_ < 6)
         {
            _loc1_ = new GuildWantedChestItem(_loc2_,1);
            _loc1_.x = 255 + _loc2_ * 80;
            _loc1_.y = 80;
            _selfItemList.push(_loc1_);
            addToContent(_loc1_);
            _loc2_++;
         }
      }
      
      private function initGuildChest() : void
      {
         var _loc1_:GuildWantedChestItem = null;
         var _loc2_:int = 0;
         _guildItemList = new Vector.<GuildWantedChestItem>();
         _loc2_ = 0;
         while(_loc2_ < 6)
         {
            _loc1_ = new GuildWantedChestItem(_loc2_,2);
            _loc1_.x = 255 + _loc2_ * 80;
            _loc1_.y = 135;
            _guildItemList.push(_loc1_);
            addToContent(_loc1_);
            _loc2_++;
         }
      }
      
      private function initEvent() : void
      {
         addEventListener("response",__frameResponse);
         _downTime.addEventListener("timerDown_complete",__timeCompleteHandler);
         MsgMan.addObserver("GUILD_WANTED_INFO_CHANGE",this,__updateInfoChange);
         _fightBtn.addEventListener("click",__fightBtnClickHandler);
         _refreshBtn.addEventListener("click",__refreshBtnClickHandler);
         _rewardListBtn.addEventListener("click",__rewardListBtnClickHandler);
      }
      
      private function removeEvent() : void
      {
         removeEventListener("response",__frameResponse);
         _downTime.removeEventListener("timerDown_complete",__timeCompleteHandler);
         MsgMan.removeObserver("GUILD_WANTED_INFO_CHANGE",this,__updateInfoChange);
         _fightBtn.removeEventListener("click",__fightBtnClickHandler);
         _refreshBtn.removeEventListener("click",__refreshBtnClickHandler);
         _rewardListBtn.removeEventListener("click",__rewardListBtnClickHandler);
      }
      
      private function __rewardListBtnClickHandler(param1:MouseEvent) : void
      {
         if(_tipView && !_tipView.isDie)
         {
            ObjectUtils.disposeObject(_tipView);
            _tipView = null;
            return;
         }
         _tipView = new GuildWantedRewardTipView();
         var _loc2_:Point = new Point();
         _loc2_ = _rewardListBtn.localToGlobal(_loc2_);
         _tipView.x = _loc2_.x + _rewardListBtn.width + 5;
         _tipView.y = _loc2_.y;
         if(_tipView.y < 0)
         {
            _tipView.y = 20;
         }
         _tipView.show();
         param1.stopPropagation();
      }
      
      private function __refreshBtnClickHandler(param1:MouseEvent) : void
      {
         if(openAlert())
         {
            return;
         }
         var _loc2_:int = int(playerInfo.point);
         if(SharedManager.instance.guildWantedRefreshUseBind)
         {
            _loc2_ = playerInfo.point + playerInfo.giftToken;
         }
         if(_loc2_ < point)
         {
            RechargeAlertMannager.show();
            return;
         }
         refreshStar(SharedManager.instance.guildWantedRefreshUseBind);
      }
      
      private function openAlert() : Boolean
      {
         var _loc7_:TodayNotAlertFrame = null;
         var _loc6_:String = null;
         var _loc2_:String = null;
         var _loc3_:Date = SharedManager.instance.guildWantedRefreshStarCheckDate;
         var _loc5_:Boolean = Boolean(SharedManager.instance.guildWantedRefreshStar);
         var _loc4_:Date = new Date();
         var _loc1_:Boolean = false;
         if(!_loc5_ || _loc3_.month <= _loc3_.month && _loc3_.date < _loc4_.date)
         {
            _loc1_ = true;
         }
         if(_loc1_)
         {
            _loc7_ = ComponentFactory.Instance.creatComponentByStylename("GuildWantedFrame.RefreshAlertFrame");
            _loc6_ = LanguageMgr.GetTranslation("guildWantedFrame.todayNotAlert.content.text",point);
            _loc2_ = LanguageMgr.GetTranslation("yishi.view.base.ThewAlertFrame.text");
            _loc7_.show(_loc6_,_loc2_,openAlertBack,null,"center");
         }
         return _loc1_;
      }
      
      private function openAlertBack(param1:Boolean, param2:Boolean) : void
      {
         SharedManager.instance.guildWantedRefreshStar = param1;
         SharedManager.instance.guildWantedRefreshStarCheckDate = new Date();
         SharedManager.instance.guildWantedRefreshStarCheck();
         SharedManager.instance.guildWantedRefreshUseBind = param2;
         refreshStar(param2);
      }
      
      private function refreshStar(param1:Boolean) : void
      {
         var _loc2_:int = param1 ? 1 : 0;
         GuildWantedManager.instance.sendRequest(3,0,_loc2_);
      }
      
      private function __fightBtnClickHandler(param1:MouseEvent) : void
      {
         GuildWantedManager.instance.sendRequest(5);
      }
      
      private function __updateInfoChange(param1:String, param2:Object) : void
      {
         refreshView();
      }
      
      private function __timeCompleteHandler(param1:Event) : void
      {
         _downTime.timeCount = 0;
      }
      
      private function refreshView() : void
      {
         _selfScoreTxt.text = model.personalScore.toString();
         _guildScoreTxt.text = model.consortiaScore.toString();
         _starGroup.setStars(model.targetInfo.starLevel);
         _rewardTxt.htmlText = LanguageMgr.GetTranslation("guildWantedFrame.rewardTxt.text",model.targetInfo.score);
         _countTxt.htmlText = LanguageMgr.GetTranslation("guildWantedFrame.countTxt.text",model.leftCount);
         _totalScoreTxt.htmlText = LanguageMgr.GetTranslation("guildWantedFrame.totalScoreTxt.text",model.totalScore);
         _selfRankTxt.htmlText = LanguageMgr.GetTranslation("guildWantedFrame.selfRankTxt.text",model.myRank);
         _downTime.timeCount = model.leftFreeRefreshCD;
         _nickNameTxt.text = model.targetInfo.nickName;
         _targetTxt.htmlText = LanguageMgr.GetTranslation("guildWantedFrame.targetTxt.text",model.targetInfo.nickName);
         _consortiaNameTxt.text = model.targetInfo.consortiaName;
         refreshAvatar();
         refreshProgressBar();
         refreshBoxState();
         refreshRank();
      }
      
      private function refreshProgressBar() : void
      {
         var _loc1_:Array = ConfigInfoManager.instance.getGuildWantedSelfBoxScore();
         var _loc2_:Array = ConfigInfoManager.instance.getGuildWantedGuildBoxScore();
         _selfBar.value = model.personalScore / _loc1_[6 - 1];
         _guildBar.value = model.consortiaScore / _loc2_[6 - 1];
      }
      
      private function refreshBoxState() : void
      {
         var _loc1_:* = null;
         for each(_loc1_ in _selfItemList)
         {
            _loc1_.refreshView();
         }
         for each(_loc1_ in _guildItemList)
         {
            _loc1_.refreshView();
         }
      }
      
      private function refreshRank() : void
      {
         var _loc1_:GuildWantedRankItem = null;
         var _loc2_:int = 0;
         _vBox.removeAllChild();
         _loc2_ = 1;
         while(_loc2_ <= model.rankInfoList.keys.length)
         {
            _loc1_ = new GuildWantedRankItem();
            _loc1_.data = model.rankInfoList[_loc2_];
            _vBox.addChild(_loc1_);
            _loc2_++;
         }
         _spanel.beginChanges();
         _spanel.setView(_vBox);
         _spanel.commitChanges();
         _spanel.invalidateViewport();
      }
      
      public function show() : void
      {
         LayerManager.Instance.addToLayer(this,3,true,true,1);
      }
      
      override public function get groups() : Array
      {
         return ["CASTLE_BUIDING_GROUP","MAIN_TOOLS_GROUP"];
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
      
      public function get model() : GuildWantedModel
      {
         return GuildWantedManager.instance.model;
      }
      
      private function get playerInfo() : PlayerInfo
      {
         return PlayerManager.instance.currentPlayerModel.playerInfo;
      }
      
      private function get point() : int
      {
         return ConfigInfoManager.instance.getGuildWantedRefreshPoint();
      }
      
      public function get viewRectangle() : Rectangle
      {
         return new Rectangle(0,0,751,604);
      }
      
      override public function dispose() : void
      {
         removeEvent();
         ObjectUtils.disposeObject(_back);
         _back = null;
         ObjectUtils.disposeObject(_spanel);
         _spanel = null;
         ObjectUtils.disposeObject(_vBox);
         _vBox = null;
         ObjectUtils.disposeObject(_refreshBtn);
         _refreshBtn = null;
         ObjectUtils.disposeObject(_fightBtn);
         _fightBtn = null;
         ObjectUtils.disposeObject(_selfScoreTxt);
         _selfScoreTxt = null;
         ObjectUtils.disposeObject(_guildScoreTxt);
         _guildScoreTxt = null;
         ObjectUtils.disposeObject(_selfScoreDesc);
         _selfScoreDesc = null;
         ObjectUtils.disposeObject(_guildScoreDesc);
         _guildScoreDesc = null;
         ObjectUtils.disposeObject(_targetTxt);
         _targetTxt = null;
         ObjectUtils.disposeObject(_starTxt);
         _starTxt = null;
         ObjectUtils.disposeObject(_rewardTxt);
         _rewardTxt = null;
         ObjectUtils.disposeObject(_countTxt);
         _countTxt = null;
         ObjectUtils.disposeObject(_rank);
         _rank = null;
         ObjectUtils.disposeObject(_name);
         _name = null;
         ObjectUtils.disposeObject(_score);
         _score = null;
         ObjectUtils.disposeObject(_totalScoreTxt);
         _totalScoreTxt = null;
         ObjectUtils.disposeObject(_selfRankTxt);
         _selfRankTxt = null;
         ObjectUtils.disposeObject(_rewardListBtn);
         _rewardListBtn = null;
         ObjectUtils.disposeObject(_selfBar);
         _selfBar = null;
         ObjectUtils.disposeObject(_guildBar);
         _guildBar = null;
         ObjectUtils.disposeObject(_tipView);
         _tipView = null;
         ObjectUtils.disposeObject(_starGroup);
         _starGroup = null;
         ObjectUtils.disposeObject(_downTime);
         _downTime = null;
         ObjectUtils.disposeObject(_refreshTxt);
         _refreshTxt = null;
         _figure.data = null;
         ObjectUtils.disposeObject(_figure);
         _figure = null;
         ObjectUtils.disposeObject(_nickNameTxt);
         _nickNameTxt = null;
         ObjectUtils.disposeObject(_consortiaNameTxt);
         _consortiaNameTxt = null;
         LogicUtils.disposeDisplayCollection(_selfItemList);
         _selfItemList = null;
         LogicUtils.disposeDisplayCollection(_guildItemList);
         _guildItemList = null;
         super.dispose();
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}

