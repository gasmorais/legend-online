package christmas
{
   import avatar.view.ShowAvatar;
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.instance.IManualSize;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.ui.controls.IconButton;
   import com.pickgliss.ui.controls.ScrollPanel;
   import com.pickgliss.ui.controls.container.VBox;
   import com.pickgliss.ui.image.Image;
   import com.pickgliss.ui.image.ScaleFrameImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.ui.text.GradientText;
   import com.pickgliss.utils.ObjectUtils;
   import com.road.yishi.proto.christmas.SnowyMistTeamPlayerMsg;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.events.TimerEvent;
   import flash.geom.Rectangle;
   import flash.utils.Timer;
   import manager.LanguageMgr;
   import mvc.module.christmas.ChristmasModel;
   import mvc.module.stararea.StarareaManager;
   import mvc.module.stararea.event.StarareaEvent;
   import utils.LogicUtils;
   import yishi.datas.playerinfo.PlayerInfo;
   import yishi.datas.playerinfo.ThaneInfo;
   import yishi.events.NotificationEvent;
   import yishi.manager.ChristmasManager;
   import yishi.manager.FrameControllerManager;
   import yishi.manager.NotificationManager;
   import yishi.manager.PlayerManager;
   import yishi.view.frame.SimpleHelpFrame;
   
   public class ChristmasSnowymistFrame extends Frame implements IManualSize
   {
      
      private static const POINT_ARR:Array = [[30,60],[775,60],[30,320],[775,320]];
      
      private var _back:ScaleFrameImage;
      
      private var _bg:Image;
      
      private var _timeBg:Bitmap;
      
      private var _timeTxt:FilterFrameText;
      
      private var _teamBg:Bitmap;
      
      private var _refreshBtn:IconButton;
      
      private var _createBtn:IconButton;
      
      private var _quitBtn:IconButton;
      
      private var _startBtn:IconButton;
      
      private var _txt:FilterFrameText;
      
      private var _panel:ScrollPanel;
      
      private var _vbox:VBox;
      
      private var _sprite1:Sprite;
      
      private var _sprite2:Sprite;
      
      private var _avatarSp:Sprite;
      
      private var _mapBg:Image;
      
      private var _energyTxt:FilterFrameText;
      
      private var _myPointTxt:FilterFrameText;
      
      private var _teamPointTxt:FilterFrameText;
      
      private var _mapItemList:Array = [];
      
      private var _timer:Timer;
      
      private var _helpBtn:IconButton;
      
      private var _prayIconBtn:IconButton;
      
      public function ChristmasSnowymistFrame()
      {
         super();
         initView();
         addEvent();
         __refreshBtnClickHandler(null);
      }
      
      public function get viewRectangle() : Rectangle
      {
         return new Rectangle(0,0,1043,651);
      }
      
      override public function get groups() : Array
      {
         return ["MAIN_TOOLS_GROUP","BAG_GROUP"];
      }
      
      private function initView() : void
      {
         _back = ComponentFactory.Instance.creatComponentByStylename("christmasSnowymistFrame.back");
         _bg = ComponentFactory.Instance.creatComponentByStylename("christmasSnowymistFrame.bg");
         _timeBg = ComponentFactory.Instance.creatBitmap("asset.ChristmasFrame.timeBg");
         _timeTxt = ComponentFactory.Instance.creatComponentByStylename("christmasSnowymistFrame.timeTxt");
         _teamBg = ComponentFactory.Instance.creatBitmap("asset.ChristmasSnowymistFrame.teamBg");
         _refreshBtn = ComponentFactory.Instance.creatComponentByStylename("christmasSnowymistFrame.refreshBtn");
         _createBtn = ComponentFactory.Instance.creatComponentByStylename("christmasSnowymistFrame.creatBtn");
         _quitBtn = ComponentFactory.Instance.creatComponentByStylename("christmasSnowymistFrame.quitBtn");
         _startBtn = ComponentFactory.Instance.creatComponentByStylename("christmasSnowymistFrame.startBtn");
         _txt = ComponentFactory.Instance.creatComponentByStylename("christmasSnowymistFrame.txt");
         _panel = ComponentFactory.Instance.creatComponentByStylename("christmasSnowymistFrame.scollPanel");
         _vbox = ComponentFactory.Instance.creatCustomObject("christmasSnowymistFrame.vBox");
         _mapBg = ComponentFactory.Instance.creatComponentByStylename("christmasSnowymistFrame.mapBg");
         _energyTxt = ComponentFactory.Instance.creatComponentByStylename("christmasSnowymistFrame.energyTxt");
         _myPointTxt = ComponentFactory.Instance.creatComponentByStylename("christmasSnowymistFrame.myPointTxt");
         _teamPointTxt = ComponentFactory.Instance.creatComponentByStylename("christmasSnowymistFrame.teamPointTxt");
         _helpBtn = ComponentFactory.Instance.creatComponentByStylename("ChristmasSnowymistFrame.helpBtn");
         _prayIconBtn = ComponentFactory.Instance.creatComponentByStylename("christmasPrayFrame.previewBtn");
         _sprite1 = new Sprite();
         _sprite2 = new Sprite();
         _avatarSp = new Sprite();
         addToContent(_back);
         addToContent(_bg);
         addToContent(_sprite1);
         _sprite1.visible = false;
         addToContent(_sprite2);
         _sprite2.visible = false;
         addToContent(_timeTxt);
         addToContent(_helpBtn);
         _sprite1.addChild(_timeBg);
         _sprite1.addChild(_teamBg);
         _sprite1.addChild(_refreshBtn);
         _sprite1.addChild(_createBtn);
         _sprite1.addChild(_quitBtn);
         _sprite1.addChild(_startBtn);
         _sprite1.addChild(_txt);
         _sprite1.addChild(_panel);
         _sprite1.addChild(_prayIconBtn);
         _panel.setView(_vbox);
         _sprite2.addChild(_mapBg);
         _sprite2.addChild(_avatarSp);
         _sprite2.addChild(_energyTxt);
         _sprite2.addChild(_myPointTxt);
         _sprite2.addChild(_teamPointTxt);
         _prayIconBtn.x = 730;
         _prayIconBtn.y = 35;
         _quitBtn.visible = false;
         _startBtn.visible = false;
         _prayIconBtn.icon.x = 39;
         _timeBg.x = 320;
         _timeBg.y = 47;
         _back.setFrame(1);
         _timeTxt.htmlText = LanguageMgr.GetTranslation("ChristmasFrame.timeTxt.text",model.openTimeStr,model.stopTimeStr);
         _txt.text = LanguageMgr.GetTranslation("christmasSnowymistFrame.txt");
         initMapItem();
         _timer = new Timer(2000);
         _timer.start();
         _timer.addEventListener("timer",__timerHandler);
      }
      
      private function addEvent() : void
      {
         _prayIconBtn.addEventListener("click",__prayIconBtnClickHandler);
         addEventListener("response",__frameResponse);
         ChristmasManager.instance.addEventListener("SNOWYMIST_UPDATE",updateInfoHandler);
         _refreshBtn.addEventListener("click",__refreshBtnClickHandler);
         _createBtn.addEventListener("click",__creatBtnClickHandler);
         _quitBtn.addEventListener("click",__quitBtnClickHandler);
         _startBtn.addEventListener("click",__startBtnClickHandler);
         NotificationManager.instance.addEventListener("REFRESH_TOPTOOLS",__refreshTopToolsHandler);
         StarareaManager.instance.addEventListener("GAME_PASS",miniGamePass);
         _helpBtn.addEventListener("click",__helpBtnClickHandler);
      }
      
      private function removeEvent() : void
      {
         _prayIconBtn.removeEventListener("click",__prayIconBtnClickHandler);
         removeEventListener("response",__frameResponse);
         ChristmasManager.instance.removeEventListener("SNOWYMIST_UPDATE",updateInfoHandler);
         _refreshBtn.removeEventListener("click",__refreshBtnClickHandler);
         _createBtn.removeEventListener("click",__creatBtnClickHandler);
         _quitBtn.removeEventListener("click",__quitBtnClickHandler);
         _startBtn.removeEventListener("click",__startBtnClickHandler);
         NotificationManager.instance.removeEventListener("REFRESH_TOPTOOLS",__refreshTopToolsHandler);
         StarareaManager.instance.removeEventListener("GAME_PASS",miniGamePass);
         _helpBtn.removeEventListener("click",__helpBtnClickHandler);
         timerStop();
      }
      
      private function __prayIconBtnClickHandler(param1:MouseEvent) : void
      {
         FrameControllerManager.instance.openControllerByInfo("christmas",13);
      }
      
      private function __helpBtnClickHandler(param1:MouseEvent) : void
      {
         var _loc2_:SimpleHelpFrame = ComponentFactory.Instance.creatComponentByStylename("ChristmasSnowymistFrame.helperFrame");
         _loc2_.show();
      }
      
      private function miniGamePass(param1:StarareaEvent) : void
      {
         ChristmasManager.instance.opRequest(22,model.selecedNodeId);
      }
      
      private function __refreshTopToolsHandler(param1:NotificationEvent) : void
      {
         if(!model.isOpen)
         {
            dispose();
         }
      }
      
      private function timerStop() : void
      {
         _timer.stop();
         _timer.removeEventListener("timer",__timerHandler);
      }
      
      private function __timerHandler(param1:TimerEvent) : void
      {
         __refreshBtnClickHandler(null);
      }
      
      private function __startBtnClickHandler(param1:MouseEvent) : void
      {
         ChristmasManager.instance.opRequest(21);
      }
      
      private function __quitBtnClickHandler(param1:MouseEvent) : void
      {
         ChristmasManager.instance.opRequest(19);
      }
      
      private function __creatBtnClickHandler(param1:MouseEvent) : void
      {
         ChristmasManager.instance.opRequest(17);
      }
      
      private function __refreshBtnClickHandler(param1:MouseEvent) : void
      {
         ChristmasManager.instance.opRequest(16);
      }
      
      private function updateInfoHandler(param1:NotificationEvent) : void
      {
         refreshView();
      }
      
      public function refreshView() : void
      {
         if(model.opType == 2)
         {
            _timeTxt.x = 590;
            _timeTxt.y = 541;
            _sprite1.visible = false;
            _sprite2.visible = true;
            _back.setFrame(2);
            refreshMap();
            timerStop();
         }
         else
         {
            _timeTxt.x = 335;
            _timeTxt.y = 53;
            _sprite1.visible = true;
            _sprite2.visible = false;
            _back.setFrame(1);
            refreshList();
         }
      }
      
      private function refreshMap() : void
      {
         _energyTxt.htmlText = LanguageMgr.GetTranslation("christmasSnowymistFrame.energyTxt.text",model.selfPlayer.energy);
         _myPointTxt.htmlText = LanguageMgr.GetTranslation("christmasSnowymistFrame.myPointTxt.text",model.selfPlayer.myPoint);
         _teamPointTxt.htmlText = LanguageMgr.GetTranslation("christmasSnowymistFrame.teamPointTxt.text",model.selfSnowyMist.teamPoint);
         updateAvatar();
         refreshItem();
      }
      
      private function refreshItem() : void
      {
         var _loc2_:int = 0;
         var _loc1_:ChristmasSnowymistMapItem = null;
         _loc2_ = 0;
         while(_loc2_ < _mapItemList.length)
         {
            _loc1_ = _mapItemList[_loc2_];
            _loc1_.refreshView();
            _loc2_++;
         }
      }
      
      private function initMapItem() : void
      {
         var _loc2_:int = 0;
         var _loc1_:ChristmasSnowymistMapItem = null;
         _loc2_ = 0;
         while(_loc2_ < 64)
         {
            _loc1_ = new ChristmasSnowymistMapItem(_loc2_);
            _loc1_.x = 245 + int(_loc2_ % 8) * 65;
            _loc1_.y = 45 + int(_loc2_ / 8) * 61;
            _mapItemList.push(_loc1_);
            _sprite2.addChild(_loc1_);
            _loc2_++;
         }
      }
      
      private function updateAvatar() : void
      {
         var _loc4_:int = 0;
         var _loc5_:SnowyMistTeamPlayerMsg = null;
         var _loc2_:GradientText = null;
         var _loc1_:ShowAvatar = null;
         var _loc3_:ThaneInfo = null;
         if(_avatarSp.numChildren > 0)
         {
            return;
         }
         _loc4_ = 0;
         while(_loc4_ < model.selfSnowyMist.teamPlayers.length)
         {
            _loc5_ = model.selfSnowyMist.teamPlayers[_loc4_];
            _loc2_ = ComponentFactory.Instance.creatComponentByStylename("christmasSnowymistFrame.nameTxt");
            _loc2_.x = POINT_ARR[_loc4_][0];
            _loc2_.y = POINT_ARR[_loc4_][1] - 20;
            _loc1_ = new ShowAvatar(true);
            _loc1_.x = POINT_ARR[_loc4_][0];
            _loc1_.y = POINT_ARR[_loc4_][1];
            _loc1_.mouseChildren = _loc1_.mouseEnabled = false;
            _loc3_ = new ThaneInfo();
            _loc3_.userId = _loc5_.userId;
            _loc3_.sexs = _loc5_.sex;
            _loc3_.job = _loc5_.job;
            _loc3_.templateId = _loc5_.templateId;
            _loc3_.nickName = _loc5_.nickName;
            _loc3_.armsEquipAvata = _loc5_.arm;
            _loc3_.wingAvata = _loc5_.wing;
            _loc3_.hairFashionAvata = _loc5_.hat;
            _loc3_.bodyEquipAvata = _loc5_.cloth;
            _loc3_.armsFashionAvata = _loc5_.fashionArm;
            _loc3_.bodyFashionAvata = _loc5_.fashionCloth;
            _loc3_.hideFashion = _loc5_.hideFashion;
            _loc2_.text = _loc3_.nickName;
            _loc1_.data = _loc3_;
            _loc1_.scaleX = 0.7;
            _loc1_.scaleY = 0.7;
            _avatarSp.addChild(_loc1_);
            _avatarSp.addChild(_loc2_);
            _loc4_++;
         }
      }
      
      private function refreshList() : void
      {
         var _loc2_:int = 0;
         var _loc1_:ChristmasSnowymistItemView = null;
         _vbox.removeAllChild();
         _panel.beginChanges();
         _vbox.beginChanges();
         _loc2_ = 0;
         while(_loc2_ < model.snowyMistList.length)
         {
            _loc1_ = new ChristmasSnowymistItemView();
            _loc1_.data = model.snowyMistList[_loc2_];
            _vbox.addChild(_loc1_);
            _loc2_++;
         }
         _vbox.commitChanges();
         _panel.commitChanges();
         _panel.invalidateViewport();
         if(model.opType == 0)
         {
            _refreshBtn.visible = true;
            _createBtn.visible = true;
            _quitBtn.visible = false;
            _startBtn.visible = false;
         }
         else if(model.opType == 1)
         {
            _refreshBtn.visible = false;
            _createBtn.visible = false;
            _quitBtn.visible = true;
            _startBtn.visible = model.selfSnowyMist.teamLeaderUserId == playerInfo.userId;
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
      
      public function show() : void
      {
         LayerManager.Instance.addToLayer(this,3,true,true,2,0,true);
      }
      
      public function get playerInfo() : PlayerInfo
      {
         return PlayerManager.instance.currentPlayerModel.playerInfo;
      }
      
      private function get model() : ChristmasModel
      {
         return ChristmasManager.instance.model;
      }
      
      override public function dispose() : void
      {
         removeEvent();
         ObjectUtils.disposeObject(_back);
         _back = null;
         ObjectUtils.disposeObject(_bg);
         _bg = null;
         ObjectUtils.disposeObject(_timeBg);
         _timeBg = null;
         ObjectUtils.disposeObject(_timeTxt);
         _timeTxt = null;
         ObjectUtils.disposeObject(_teamBg);
         _teamBg = null;
         ObjectUtils.disposeObject(_refreshBtn);
         _refreshBtn = null;
         ObjectUtils.disposeObject(_createBtn);
         _createBtn = null;
         ObjectUtils.disposeObject(_quitBtn);
         _quitBtn = null;
         ObjectUtils.disposeObject(_startBtn);
         _startBtn = null;
         ObjectUtils.disposeObject(_txt);
         _txt = null;
         ObjectUtils.disposeAllChildren(_vbox);
         _vbox = null;
         ObjectUtils.disposeObject(_panel);
         _panel = null;
         ObjectUtils.disposeObject(_mapBg);
         _mapBg = null;
         ObjectUtils.disposeObject(_energyTxt);
         _energyTxt = null;
         ObjectUtils.disposeObject(_myPointTxt);
         _myPointTxt = null;
         ObjectUtils.disposeObject(_teamPointTxt);
         _teamPointTxt = null;
         ObjectUtils.disposeAllChildren(_sprite1);
         _sprite1 = null;
         ObjectUtils.disposeAllChildren(_sprite2);
         _sprite2 = null;
         ObjectUtils.disposeAllChildren(_avatarSp);
         _sprite1 = null;
         LogicUtils.disposeDisplayCollection(_mapItemList);
         _mapItemList = null;
         ObjectUtils.disposeObject(_helpBtn);
         _helpBtn = null;
         _timer = null;
         ObjectUtils.disposeObject(_prayIconBtn);
         _prayIconBtn = null;
         super.dispose();
      }
   }
}

