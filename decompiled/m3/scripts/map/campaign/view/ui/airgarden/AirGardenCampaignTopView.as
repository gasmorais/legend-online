package map.campaign.view.ui.airgarden
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.SelectedButtonGroup;
   import com.pickgliss.ui.controls.SelectedIconButton;
   import com.pickgliss.ui.controls.container.HBox;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.ui.image.MutipleImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Bitmap;
   import flash.events.Event;
   import manager.LanguageMgr;
   import managers.AirGardenManager;
   import mvc.module.airgarden.AirGardenModel;
   import utils.LogicUtils;
   import yishi.datas.ConfigInfoManager;
   import yishi.datas.playerinfo.PlayerModel;
   import yishi.events.PlayerEvent;
   import yishi.manager.PlayerManager;
   import yishi.utils.DateFormatter;
   import yishi.utils.MsgMan;
   import yishi.view.base.TokenAmountItem;
   
   public class AirGardenCampaignTopView extends Component
   {
      
      private var _topBack:Bitmap;
      
      private var _masterNameText:FilterFrameText;
      
      private var _noPartyCon:Component;
      
      private var _gardenBtn:SelectedIconButton;
      
      private var _selfBtn:SelectedIconButton;
      
      private var _gardenUpItem:TokenAmountItem;
      
      private var _gardenUpText:FilterFrameText;
      
      private var _leftUpCount:FilterFrameText;
      
      private var _upCountDown:FilterFrameText;
      
      private var _btnGroup:SelectedButtonGroup;
      
      private var _partyCon:Component;
      
      private var _scoreImage:MutipleImage;
      
      private var _gameHbox:HBox;
      
      private var _totalScoreText:FilterFrameText;
      
      private var _selfScoreText:FilterFrameText;
      
      private var _selfCountText:FilterFrameText;
      
      private var gameList:Vector.<TokenAmountItem>;
      
      private var gameCount:int = 3;
      
      private var gardenUpMaxCount:int;
      
      private var selfUpMaxCount:int;
      
      public function AirGardenCampaignTopView()
      {
         super();
         initView();
         initGameBox();
         addEvent();
         AirGardenManager.instance.reqAirGardenCampaign(8,model.campaignInfo.masterUserId);
         refreshView();
      }
      
      private function initView() : void
      {
         _topBack = ComponentFactory.Instance.creatBitmap("asset.AirGardenCampaignTopView.topBack");
         _masterNameText = ComponentFactory.Instance.creatComponentByStylename("AirGardenCampaignTopView.masterNameText");
         _noPartyCon = ComponentFactory.Instance.creatComponentByStylename("AirGardenCampaignTopView.noPartyCon");
         _gardenBtn = ComponentFactory.Instance.creatComponentByStylename("AirGardenCampaignTopView.gardenBtn");
         _selfBtn = ComponentFactory.Instance.creatComponentByStylename("AirGardenCampaignTopView.selfBtn");
         _gardenUpItem = ComponentFactory.Instance.creatComponentByStylename("AirGardenCampaignTopView.gardenUpItem");
         _gardenUpText = ComponentFactory.Instance.creatComponentByStylename("AirGardenCampaignTopView.gardenUpText");
         _leftUpCount = ComponentFactory.Instance.creatComponentByStylename("AirGardenCampaignTopView.leftUpCount");
         _upCountDown = ComponentFactory.Instance.creatComponentByStylename("AirGardenCampaignTopView.upCountDown");
         _partyCon = ComponentFactory.Instance.creatComponentByStylename("AirGardenCampaignTopView.partyCon");
         _scoreImage = ComponentFactory.Instance.creatComponentByStylename("AirGardenCampaignTopView.scoreImage");
         _gameHbox = ComponentFactory.Instance.creatComponentByStylename("AirGardenCampaignTopView.gameHbox");
         _selfCountText = ComponentFactory.Instance.creatComponentByStylename("AirGardenCampaignTopView.selfCountText");
         _totalScoreText = ComponentFactory.Instance.creatComponentByStylename("AirGardenCampaignTopView.totalScoreText");
         _selfScoreText = ComponentFactory.Instance.creatComponentByStylename("AirGardenCampaignTopView.selfScoreText");
         addChild(_topBack);
         addChild(_masterNameText);
         addChild(_noPartyCon);
         addChild(_partyCon);
         _noPartyCon.addChild(_gardenBtn);
         _noPartyCon.addChild(_selfBtn);
         _noPartyCon.addChild(_gardenUpItem);
         _noPartyCon.addChild(_gardenUpText);
         _noPartyCon.addChild(_leftUpCount);
         _noPartyCon.addChild(_upCountDown);
         _partyCon.addChild(_scoreImage);
         _partyCon.addChild(_totalScoreText);
         _partyCon.addChild(_selfScoreText);
         _partyCon.addChild(_gameHbox);
         _partyCon.addChild(_selfCountText);
         _btnGroup = new SelectedButtonGroup();
         _btnGroup.addSelectItem(_gardenBtn);
         _btnGroup.addSelectItem(_selfBtn);
         _btnGroup.selectIndex = 0;
         gardenUpMaxCount = ConfigInfoManager.instance.getAirGardenUpMaxCount();
         selfUpMaxCount = ConfigInfoManager.instance.getAirGardenSelfUpMaxCount();
         this.mouseEnabled = false;
      }
      
      private function initGameBox() : void
      {
         var _loc2_:int = 0;
         var _loc1_:TokenAmountItem = null;
         gameList = new Vector.<TokenAmountItem>();
         _loc2_ = 0;
         while(_loc2_ < gameCount)
         {
            _loc1_ = ComponentFactory.Instance.creatComponentByStylename("AirGardenJoinPartyItem.gameItem" + _loc2_);
            _gameHbox.addChild(_loc1_);
            gameList.push(_loc1_);
            _loc2_++;
         }
      }
      
      private function addEvent() : void
      {
         MsgMan.addObserver("SELF_INFO_UPDATE",this,__updateSelfInfoHandler);
         MsgMan.addObserver("AIRGARDEN_STATE_CHANGE",this,__updateSelfInfoHandler);
         MsgMan.addObserver("CAMPAIGN_INFO_UPDATE",this,__updateCampaignInfoHandler);
         MsgMan.addObserver("AIRGARDEN_STATE_CHANGE",this,__updateCampaignInfoHandler);
         playerModel.addEventListener("SYSTIME_UPGRADE_SECOND",__updateTimeDownHandler);
         _btnGroup.addEventListener("change",__tabChangeHandler);
      }
      
      private function removeEvent() : void
      {
         MsgMan.removeObserver("SELF_INFO_UPDATE",this,__updateSelfInfoHandler);
         MsgMan.removeObserver("AIRGARDEN_STATE_CHANGE",this,__updateSelfInfoHandler);
         MsgMan.removeObserver("CAMPAIGN_INFO_UPDATE",this,__updateCampaignInfoHandler);
         MsgMan.removeObserver("AIRGARDEN_STATE_CHANGE",this,__updateCampaignInfoHandler);
         playerModel.removeEventListener("SYSTIME_UPGRADE_SECOND",__updateTimeDownHandler);
         if(_btnGroup)
         {
            _btnGroup.removeEventListener("change",__tabChangeHandler);
         }
      }
      
      private function __tabChangeHandler(param1:Event) : void
      {
         tabChangeView();
      }
      
      private function __updateTimeDownHandler(param1:PlayerEvent) : void
      {
         refreshCountDown();
      }
      
      private function __updateSelfInfoHandler(param1:String, param2:Object) : void
      {
         refreshView();
      }
      
      private function __updateCampaignInfoHandler(param1:String, param2:Object) : void
      {
         refreshView();
      }
      
      private function refreshView() : void
      {
         var _loc2_:int = 0;
         var _loc1_:TokenAmountItem = null;
         if(!model.campaignInfo)
         {
            return;
         }
         _masterNameText.text = model.campaignInfo.nickName;
         if(model.campaignInfo.isParty)
         {
            _partyCon.visible = true;
            _noPartyCon.visible = false;
            _totalScoreText.text = model.campaignInfo.totalScore + "";
            _selfScoreText.text = model.selfScore + "";
            _selfCountText.htmlText = LanguageMgr.GetTranslation("AirGardenCampaignTopView.selfCountText.text",model.gameRemain,model.extraGameCount);
            _loc2_ = 0;
            while(_loc2_ < gameCount)
            {
               _loc1_ = gameList[_loc2_];
               _loc1_.firstText = model.campaignInfo.gameRemainList[_loc2_] + "";
               _loc2_++;
            }
         }
         else
         {
            _partyCon.visible = false;
            _noPartyCon.visible = true;
            tabChangeView();
         }
      }
      
      private function tabChangeView() : void
      {
         var _loc1_:int = 0;
         if(_btnGroup.selectIndex == 0)
         {
            _loc1_ = gardenUpMaxCount - model.campaignInfo.upCount;
            _gardenUpItem.firstText = LanguageMgr.GetTranslation("AirGardenCampaignTopView.gardenUpItem.text1",model.campaignInfo.hotCount);
            _gardenUpText.text = LanguageMgr.GetTranslation("AirGardenCampaignTopView.gardenUpText.text1",_loc1_,gardenUpMaxCount);
            _leftUpCount.text = "";
            _upCountDown.text = "";
         }
         else
         {
            _loc1_ = selfUpMaxCount - model.selfUpCount;
            _gardenUpItem.firstText = LanguageMgr.GetTranslation("AirGardenCampaignTopView.gardenUpItem.text2",model.roomSelfUpCount);
            _gardenUpText.text = LanguageMgr.GetTranslation("AirGardenCampaignTopView.gardenUpText.text2",_loc1_,selfUpMaxCount);
            refreshCountDown();
         }
      }
      
      private function refreshCountDown() : void
      {
         if(_btnGroup.selectIndex == 0)
         {
            return;
         }
         if(!model.campaignInfo || Boolean(model.campaignInfo.isParty))
         {
            return;
         }
         var _loc2_:Number = (model.upCdEndTime - playerModel.sysCurtime.time) / 1000;
         var _loc1_:String = "00:00:00";
         if(_loc2_ <= 0)
         {
            _upCountDown.text = LanguageMgr.GetTranslation("AirGardenCampaignTopView.upCountDown.text",_loc1_);
         }
         else
         {
            _loc1_ = DateFormatter.getConsortiaCountDate(_loc2_);
            _upCountDown.text = LanguageMgr.GetTranslation("AirGardenCampaignTopView.upCountDown.text",_loc1_);
         }
      }
      
      public function show() : void
      {
         LayerManager.Instance.addToLayer(this,4,false,false);
      }
      
      private function get model() : AirGardenModel
      {
         return AirGardenManager.instance.model;
      }
      
      private function get playerModel() : PlayerModel
      {
         return PlayerManager.instance.currentPlayerModel;
      }
      
      override public function dispose() : void
      {
         removeEvent();
         ObjectUtils.disposeObject(_topBack);
         _topBack = null;
         ObjectUtils.disposeObject(_masterNameText);
         _masterNameText = null;
         ObjectUtils.disposeObject(_noPartyCon);
         _noPartyCon = null;
         ObjectUtils.disposeObject(_gardenBtn);
         _gardenBtn = null;
         ObjectUtils.disposeObject(_selfBtn);
         _selfBtn = null;
         ObjectUtils.disposeObject(_gardenUpItem);
         _gardenUpItem = null;
         ObjectUtils.disposeObject(_gardenUpText);
         _gardenUpText = null;
         ObjectUtils.disposeObject(_leftUpCount);
         _leftUpCount = null;
         ObjectUtils.disposeObject(_upCountDown);
         _upCountDown = null;
         ObjectUtils.disposeObject(_partyCon);
         _partyCon = null;
         ObjectUtils.disposeObject(_scoreImage);
         _scoreImage = null;
         ObjectUtils.disposeObject(_selfCountText);
         _selfCountText = null;
         ObjectUtils.disposeObject(_gameHbox);
         _gameHbox = null;
         ObjectUtils.disposeObject(_totalScoreText);
         _totalScoreText = null;
         ObjectUtils.disposeObject(_selfScoreText);
         _selfScoreText = null;
         ObjectUtils.disposeObject(_btnGroup);
         _btnGroup = null;
         LogicUtils.disposeDisplayCollection(gameList);
         gameList = null;
         super.dispose();
      }
   }
}

