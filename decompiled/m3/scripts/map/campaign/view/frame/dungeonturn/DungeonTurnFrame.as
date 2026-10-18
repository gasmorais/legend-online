package map.campaign.view.frame.dungeonturn
{
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.BaseButton;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.ui.controls.IconButton;
   import com.pickgliss.ui.controls.TextButton;
   import com.pickgliss.ui.image.Image;
   import com.pickgliss.ui.image.MutipleImage;
   import com.pickgliss.ui.image.ScaleFrameImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import com.pickgliss.utils.SoundManager;
   import flash.display.BitmapData;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.utils.Dictionary;
   import mainBar.StripView;
   import manager.LanguageMgr;
   import managers.DungeoTurnManager;
   import managers.RoomManager;
   import map.campaign.CampaignManager;
   import map.campaign.data.CampaignArmy;
   import mvc.module.DungeoTurnModel;
   import yishi.manager.FrameControllerManager;
   import yishi.manager.NotificationManager;
   import yishi.manager.PlayerManager;
   import yishi.utils.NumberViewUtils;
   import yishi.view.frame.SimpleHelpFrame;
   
   public class DungeonTurnFrame extends Frame
   {
      
      private var _diceView:DiceView;
      
      private var _controlIconButton:TextButton;
      
      private var _shakeIconButton:IconButton;
      
      private var _bottomView:MutipleImage;
      
      private var _blueProgress:MovieClip;
      
      private var _redProgress:MovieClip;
      
      private var _greenProgress:MovieClip;
      
      private var _blueProgressTxt:FilterFrameText;
      
      private var _redProgressTxt:FilterFrameText;
      
      private var _greenProgressTxt:FilterFrameText;
      
      private var _heroItemContainer:Sprite;
      
      private var _heroItemList:Vector.<HeroItem>;
      
      private var _startBg:Image;
      
      private var _TurnItemView:TurnItemView;
      
      private var _normalBox:ScaleFrameImage;
      
      private var _bossBox:ScaleFrameImage;
      
      private var _normalBoxPicText:Image;
      
      private var _bossBoxPicText:Image;
      
      private var _normalBring:Image;
      
      private var _bossBring:Image;
      
      private var _multi:Image;
      
      private var _numImg:Sprite;
      
      private var _numBmp:BitmapData;
      
      private var _allUserArmy:Dictionary;
      
      private var _roomId:int;
      
      private var _canRoll:Boolean;
      
      private var _playerDice:Boolean;
      
      private var _blueProgressStripView:StripView;
      
      private var _redProgressStripView:StripView;
      
      private var _greenProgressStripView:StripView;
      
      private var _bossBoxStripView:StripView;
      
      private var _normalBoxStripView:StripView;
      
      private var _bossBoxMc:MovieClip;
      
      private var _normalBoxMc:MovieClip;
      
      private var playBossBoxLevelMc:Boolean;
      
      private var playNormalBoxLevelMc:Boolean;
      
      private var _helpBtn:BaseButton;
      
      public function DungeonTurnFrame()
      {
         super();
         initView();
         addEvent();
      }
      
      override public function get groups() : Array
      {
         return ["MAIN_TOOLS_GROUP","BAG_GROUP"];
      }
      
      private function initView() : void
      {
         _diceView = ComponentFactory.Instance.creatCustomObject("dungeonturn.DungeonTurnFrame.diceView");
         _controlIconButton = ComponentFactory.Instance.creatComponentByStylename("dungeonturn.DungeonTurnFrame.controlIconButton");
         _shakeIconButton = ComponentFactory.Instance.creatComponentByStylename("dungeonturn.DungeonTurnFrame.shakeIconButton");
         _bottomView = ComponentFactory.Instance.creatComponentByStylename("dungeonturn.DungeonTurnFrame.bottomView");
         _blueProgress = ComponentFactory.Instance.creatCustomObject("dungeoturn.DungeonTurnFrame.progress1");
         _redProgress = ComponentFactory.Instance.creatCustomObject("dungeoturn.DungeonTurnFrame.progress2");
         _greenProgress = ComponentFactory.Instance.creatCustomObject("dungeoturn.DungeonTurnFrame.progress3");
         _blueProgressTxt = ComponentFactory.Instance.creatComponentByStylename("dungeoturn.DungeonTurnFrame.progressTxt1");
         _redProgressTxt = ComponentFactory.Instance.creatComponentByStylename("dungeoturn.DungeonTurnFrame.progressTxt2");
         _greenProgressTxt = ComponentFactory.Instance.creatComponentByStylename("dungeoturn.DungeonTurnFrame.progressTxt3");
         _heroItemContainer = ComponentFactory.Instance.creatCustomObject("dungeoturn.dungeoturnFrame.heroContainer");
         _startBg = ComponentFactory.Instance.creatComponentByStylename("dungeoturn.DungeoTurnFrame.startBg");
         _heroItemList = new Vector.<HeroItem>();
         _TurnItemView = ComponentFactory.Instance.creatCustomObject("dungeonturn.DungeonTurnFrame.TurnItemView");
         _bossBox = ComponentFactory.Instance.creatComponentByStylename("dungeonturn.DungeonTurnFrame.BottomBg.bossBox");
         _normalBox = ComponentFactory.Instance.creatComponentByStylename("dungeonturn.DungeonTurnFrame.BottomBg.normalBox");
         _normalBoxPicText = ComponentFactory.Instance.creatComponentByStylename("dungeonturn.BottomBg.normalBoxTxt");
         _bossBoxPicText = ComponentFactory.Instance.creatComponentByStylename("dungeonturn.BottomBg.bossBoxTxt");
         _bossBring = ComponentFactory.Instance.creatComponentByStylename("dungeonturn.BottomBg.bossBring");
         _normalBring = ComponentFactory.Instance.creatComponentByStylename("dungeonturn.BottomBg.normalBring");
         _multi = ComponentFactory.Instance.creatComponentByStylename("dungeoturn.sign");
         _numBmp = ComponentFactory.Instance.creatBitmapData("asset.dungeoturn.num");
         _numImg = new Sprite();
         _numImg.x = 545;
         _numImg.y = 538;
         _helpBtn = ComponentFactory.Instance.creatComponentByStylename("dungeoturn.HelpBtn");
         addToContent(_helpBtn);
         _helpBtn.tipData = LanguageMgr.GetTranslation("dungeoturn.helpFrame.helpTitle");
         _bossBoxMc = ComponentFactory.Instance.creatCustomObject("dungeoturn.bossBoxMc");
         _bossBoxMc.visible = false;
         _normalBoxMc = ComponentFactory.Instance.creatCustomObject("dungeoturn.normalBoxMc");
         _normalBoxMc.visible = false;
         addToContent(_controlIconButton);
         _controlIconButton.text = "0";
         addToContent(_shakeIconButton);
         addToContent(_diceView);
         addToContent(_bottomView);
         addToContent(_startBg);
         _blueProgressStripView = ComponentFactory.Instance.creatCustomObject("dungeoturn.dunturnFrame.blueProgressStripView");
         _redProgressStripView = ComponentFactory.Instance.creatCustomObject("dungeoturn.dunturnFrame.redProgressStripView");
         _greenProgressStripView = ComponentFactory.Instance.creatCustomObject("dungeoturn.dunturnFrame.greenProgressStripView");
         _bossBoxStripView = ComponentFactory.Instance.creatCustomObject("dungeoturn.dunturnFrame.bossBoxStripView");
         _normalBoxStripView = ComponentFactory.Instance.creatCustomObject("dungeoturn.dunturnFrame.normalBoxStripView");
         addToContent(_blueProgressStripView);
         _blueProgress.gotoAndStop(0);
         addToContent(_redProgressStripView);
         _redProgress.gotoAndStop(0);
         addToContent(_greenProgressStripView);
         _greenProgress.gotoAndStop(0);
         _blueProgressStripView.addChild(_blueProgress);
         _redProgressStripView.addChild(_redProgress);
         _greenProgressStripView.addChild(_greenProgress);
         _blueProgressStripView.tipData = LanguageMgr.GetTranslation("dungeoturn.Dungeonturn.blueTipdata");
         _redProgressStripView.tipData = LanguageMgr.GetTranslation("dungeoturn.Dungeonturn.redTipdata");
         _greenProgressStripView.tipData = LanguageMgr.GetTranslation("dungeoturn.Dungeonturn.greenTipdata");
         addToContent(_blueProgressTxt);
         addToContent(_redProgressTxt);
         addToContent(_greenProgressTxt);
         addToContent(_heroItemContainer);
         _bossBoxMc.mouseEnabled = false;
         _bossBoxMc.mouseChildren = false;
         addToContent(_bossBoxStripView);
         addToContent(_bossBoxMc);
         _bossBoxStripView.addChild(_bossBring);
         _bossBoxStripView.addChild(_bossBox);
         addToContent(_normalBoxStripView);
         _normalBoxStripView.addChild(_normalBring);
         _normalBoxStripView.addChild(_normalBox);
         addToContent(_normalBoxMc);
         _normalBoxMc.mouseEnabled = _normalBoxMc.mouseChildren = false;
         addToContent(_normalBoxPicText);
         _normalBoxPicText.mouseEnabled = _normalBoxPicText.mouseChildren = false;
         addToContent(_bossBoxPicText);
         _bossBoxPicText.mouseEnabled = _bossBoxPicText.mouseChildren = false;
         addToContent(_multi);
         _multi.visible = false;
         addToContent(_TurnItemView);
         addToContent(_numImg);
         _shakeIconButton.tipData = LanguageMgr.GetTranslation("DungeonTurnFrame.shakeIconButton.tipdata");
         _controlIconButton.tipData = LanguageMgr.GetTranslation("DungeonTurnFrame.controlIconButton.tipdata");
      }
      
      private function _refreshView(param1:Event) : void
      {
         _redProgressTxt.text = model.red + "/" + 100;
         _blueProgressTxt.text = model.blue + "/" + 100;
         _greenProgressTxt.text = model.green + "/" + 100;
         _controlIconButton.text = model.controlNum + "";
         _redProgress.gotoAndStop(model.red);
         _blueProgress.gotoAndStop(model.blue);
         _greenProgress.gotoAndStop(model.green);
         _TurnItemView.data = model.posStatusMsg;
         NumberViewUtils.refreshValue(2,_numImg,_numBmp,21,24,21,21,"0123456789");
         cleanAllUser();
         initUserStatus();
         setbox();
         _refreshPlayerInfo();
         _refreshControlButton(null);
         if(!param1)
         {
            _diceView.selectBox(model.rollNum);
            _TurnItemView.curentIndex = model.currentIndex;
            model.canDispose = true;
         }
         else
         {
            _diceView.roll(model.rollNum);
         }
      }
      
      private function addEvent() : void
      {
         addEventListener("response",__frameResponse);
         _shakeIconButton.addEventListener("click",_shakeIconButtonClickHandler,false,-1);
         _helpBtn.addEventListener("click",__helpBtnClickHandler);
         _controlIconButton.addEventListener("click",_controlIconButtonClickHandler,false,-1);
         NotificationManager.instance.addEventListener("DUNGEO_TURN_ROLL",_refreshView);
         NotificationManager.instance.addEventListener("DUNGEO_START_ROLL",_disableRoll);
         NotificationManager.instance.addEventListener("DUNGEO_ROLL_OVER",_enableRoll);
         NotificationManager.instance.addEventListener("DUNGEO_FINISH_FIGHT",_enableRoll);
         NotificationManager.instance.addEventListener("DUNGEO_START_FIGHT",_startFight);
         NotificationManager.instance.addEventListener("DUNGEO_UPDATA_ROOM_OWNER",_updataRoomOwner);
      }
      
      private function removeEvent() : void
      {
         removeEventListener("response",__frameResponse);
         _helpBtn.removeEventListener("click",__helpBtnClickHandler);
         if(_shakeIconButton)
         {
            _shakeIconButton.removeEventListener("click",_shakeIconButtonClickHandler);
         }
         if(_controlIconButton)
         {
            _controlIconButton.removeEventListener("click",_controlIconButtonClickHandler);
         }
         NotificationManager.instance.removeEventListener("DUNGEO_TURN_ROLL",_refreshView);
         NotificationManager.instance.removeEventListener("DUNGEO_START_ROLL",_disableRoll);
         NotificationManager.instance.removeEventListener("DUNGEO_ROLL_OVER",_enableRoll);
         NotificationManager.instance.removeEventListener("DUNGEO_FINISH_FIGHT",_enableRoll);
         NotificationManager.instance.removeEventListener("DUNGEO_START_FIGHT",_startFight);
         NotificationManager.instance.removeEventListener("DUNGEO_UPDATA_ROOM_OWNER",_updataRoomOwner);
      }
      
      private function __helpBtnClickHandler(param1:MouseEvent) : void
      {
         SoundManager.instance.play("022");
         var _loc2_:SimpleHelpFrame = ComponentFactory.Instance.creatComponentByStylename("dungeonturn.HelpFrame");
         _loc2_.show();
      }
      
      private function _updataRoomOwner(param1:Event) : void
      {
         _refreshView(null);
      }
      
      private function _startFight(param1:Event) : void
      {
         model.canDispose = true;
         _shakeIconButton.enable = false;
         _controlIconButton.enable = false;
      }
      
      private function _enableRoll(param1:Event) : void
      {
         model.canDispose = true;
         _playerDice = false;
         _refreshView(null);
      }
      
      private function _disableRoll(param1:Event) : void
      {
         _shakeIconButton.enable = false;
         _controlIconButton.enable = false;
         _playerDice = true;
         _refreshView(null);
      }
      
      private function _refreshControlButton(param1:Event) : void
      {
         _roomId = RoomManager.instance.roomInfo.houseOwnerId;
         if(PlayerManager.instance.currentPlayerModel.playerInfo.userId == _roomId && !_playerDice && !model.fighting)
         {
            _canRoll = true;
         }
         else
         {
            _canRoll = false;
         }
         if(model.controlNum > 0 && _canRoll)
         {
            _controlIconButton.enable = true;
         }
         else
         {
            _controlIconButton.enable = false;
         }
         _shakeIconButton.enable = _canRoll;
      }
      
      private function cleanAllUser() : void
      {
         for each(var _loc1_:HeroItem in _heroItemList)
         {
            _heroItemContainer.removeChild(_loc1_);
            _loc1_.dispose();
         }
      }
      
      private function initUserStatus() : void
      {
         var _loc2_:HeroItem = null;
         var _loc5_:Array = null;
         _heroItemList = new Vector.<HeroItem>();
         _allUserArmy = CampaignManager.instance.mapModel.allUserArmy;
         var _loc3_:Array = [[0,0],[68,0],[0,65],[68,65]];
         for each(var _loc1_:CampaignArmy in _allUserArmy)
         {
            _loc2_ = new HeroItem();
            _loc2_.data = _loc1_;
            _heroItemList.push(_loc2_);
         }
         _heroItemList.sort(sortHero);
         for each(var _loc4_:HeroItem in _heroItemList)
         {
            _loc5_ = _loc3_.shift();
            _loc4_.x = _loc5_[0];
            _loc4_.y = _loc5_[1];
            _heroItemContainer.addChild(_loc4_);
         }
      }
      
      private function sortHero(param1:HeroItem, param2:HeroItem) : int
      {
         if(param1._userId > param2._userId)
         {
            return 1;
         }
         return -1;
      }
      
      public function get model() : DungeoTurnModel
      {
         return DungeoTurnManager.instance.model;
      }
      
      private function _refreshPlayerInfo() : void
      {
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         var _loc1_:Array = model.playerInfo;
         _loc2_ = 0;
         while(_loc2_ < _loc1_.length)
         {
            _loc3_ = 0;
            while(_loc3_ < _heroItemList.length)
            {
               if(_heroItemList[_loc3_]._userId == _loc1_[_loc2_].userId)
               {
                  _heroItemList[_loc3_].hp = _loc1_[_loc2_].hpPercent;
               }
               _loc3_++;
            }
            _loc2_++;
         }
      }
      
      private function setbox() : void
      {
         playBossBoxLevelMc = model.getneedPlayBossBoxLevelUp();
         playNormalBoxLevelMc = model.getneedPlayBossBoxLevelUp();
         if(playBossBoxLevelMc)
         {
            _bossBoxMc.visible = true;
            _bossBoxMc.gotoAndPlay(1);
            _bossBox.visible = false;
         }
         else
         {
            _bossBox.setFrame(model.bossBoxLevel);
         }
         if(playNormalBoxLevelMc)
         {
            _normalBoxMc.visible = true;
            _normalBoxMc.gotoAndPlay(1);
            _normalBox.visible = false;
         }
         else
         {
            _normalBox.setFrame(model.normalBoxLevel);
         }
         _numImg.visible = model.doubleNormalBox;
         _multi.visible = model.doubleNormalBox;
         var _loc2_:int = _TurnItemView.killedCount;
         if(model.doubleNormalBox)
         {
            _loc2_ *= 2;
         }
         var _loc1_:int = 0;
         if(model.normalBoxLevel == 1)
         {
            _normalBoxStripView.tipData = LanguageMgr.GetTranslation("dungeoturn.dungeonturnFrame.norrmalCount",_loc2_);
         }
         else
         {
            _normalBoxStripView.tipData = LanguageMgr.GetTranslation("dungeoturn.dungeonturnFrame.bigNorrmalCount",_loc2_);
         }
         if(model.bossBoxLevel == 1)
         {
            _bossBoxStripView.tipData = LanguageMgr.GetTranslation("dungeoturn.dungeonturnFrame.bossCount",_loc1_);
         }
         else
         {
            _bossBoxStripView.tipData = LanguageMgr.GetTranslation("dungeoturn.dungeonturnFrame.bigBossCount",_loc1_);
         }
      }
      
      private function _shakeIconButtonClickHandler(param1:MouseEvent) : void
      {
         DungeoTurnManager.instance.model.isByControl = false;
         DungeoTurnManager.instance.rollDice(0);
      }
      
      private function _controlIconButtonClickHandler(param1:MouseEvent) : void
      {
         FrameControllerManager.instance.openControllerByInfo("dungeonturn",2);
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
      
      public function show() : void
      {
         LayerManager.Instance.addToLayer(this,3,true,true);
         _TurnItemView.curentIndex = model.currentIndex;
         _TurnItemView.selectItem(model.currentIndex);
         _refreshView(null);
      }
      
      override public function dispose() : void
      {
         if(!model.canDispose)
         {
            ComponentFactory.Instance.preStylename = "";
            return;
         }
         removeEvent();
         ObjectUtils.disposeObject(_diceView);
         _diceView = null;
         ObjectUtils.disposeObject(_controlIconButton);
         _controlIconButton = null;
         ObjectUtils.disposeObject(_shakeIconButton);
         _shakeIconButton = null;
         ObjectUtils.disposeObject(_bottomView);
         _bottomView = null;
         ObjectUtils.disposeViolentMc(_blueProgress);
         _blueProgress = null;
         ObjectUtils.disposeViolentMc(_redProgress);
         _redProgress = null;
         ObjectUtils.disposeViolentMc(_greenProgress);
         _greenProgress = null;
         ObjectUtils.disposeObject(_blueProgressTxt);
         _blueProgressTxt = null;
         ObjectUtils.disposeObject(_redProgressTxt);
         _redProgressTxt = null;
         ObjectUtils.disposeObject(_greenProgressTxt);
         _greenProgressTxt = null;
         ObjectUtils.disposeObject(_heroItemContainer);
         _heroItemContainer = null;
         ObjectUtils.disposeObject(_startBg);
         _startBg = null;
         ObjectUtils.disposeObject(_TurnItemView);
         _TurnItemView = null;
         ObjectUtils.disposeObject(_normalBox);
         _normalBox = null;
         ObjectUtils.disposeObject(_bossBox);
         _bossBox = null;
         ObjectUtils.disposeObject(_normalBoxPicText);
         _normalBoxPicText = null;
         ObjectUtils.disposeObject(_bossBoxPicText);
         _bossBoxPicText = null;
         ObjectUtils.disposeObject(_normalBring);
         _normalBring = null;
         ObjectUtils.disposeObject(_bossBring);
         _bossBring = null;
         ObjectUtils.disposeObject(_multi);
         _multi = null;
         ObjectUtils.disposeObject(_numImg);
         _numImg = null;
         ObjectUtils.disposeObject(_blueProgressStripView);
         _blueProgressStripView = null;
         ObjectUtils.disposeObject(_redProgressStripView);
         _redProgressStripView = null;
         ObjectUtils.disposeObject(_greenProgressStripView);
         _greenProgressStripView = null;
         ObjectUtils.disposeViolentMc(_bossBoxMc);
         _bossBoxMc = null;
         ObjectUtils.disposeViolentMc(_normalBoxMc);
         _normalBoxMc = null;
         _numBmp = null;
         ObjectUtils.disposeObject(_helpBtn);
         _helpBtn = null;
         ObjectUtils.disposeObject(_bossBoxStripView);
         _bossBoxStripView = null;
         ObjectUtils.disposeObject(_normalBoxStripView);
         _normalBoxStripView = null;
         for each(var _loc1_:HeroItem in _heroItemList)
         {
            _loc1_.dispose();
         }
         _heroItemList = null;
         _allUserArmy = null;
         super.dispose();
      }
   }
}

