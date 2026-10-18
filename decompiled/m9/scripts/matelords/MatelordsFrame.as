package matelords
{
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.instance.IManualSize;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.BaseButton;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.ui.controls.IconButton;
   import com.pickgliss.ui.image.Image;
   import com.pickgliss.ui.image.MutipleImage;
   import com.pickgliss.ui.image.ScaleBitmapImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import com.pickgliss.utils.SoundManager;
   import events.MatelordsEvent;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.events.TextEvent;
   import flash.geom.Rectangle;
   import flash.utils.getTimer;
   import manager.LanguageMgr;
   import managers.FreedomTeamManager;
   import managers.MarryManager;
   import mvc.module.matelords.MatelordsModel;
   import yishi.datas.ConfigInfoManager;
   import yishi.datas.playerinfo.PlayerModel;
   import yishi.datas.playerinfo.ThaneInfo;
   import yishi.manager.ArmyManager;
   import yishi.manager.FrameControllerManager;
   import yishi.manager.MatelordsManager;
   import yishi.manager.PlayerManager;
   import yishi.manager.ResourceManager;
   import yishi.utils.NumberViewUtils;
   import yishi.utils.SimpleAlertHelper;
   import yishi.view.tips.MessageTipManager;
   
   public class MatelordsFrame extends Frame implements IManualSize
   {
      
      private var _upBgBorder:ScaleBitmapImage;
      
      private var _upBg:Bitmap;
      
      private var _upArabesquitic:MutipleImage;
      
      private var _titleBg:MutipleImage;
      
      private var _titleContainer:Sprite;
      
      private var _serviceName:FilterFrameText;
      
      private var _downBgBorder:ScaleBitmapImage;
      
      private var _downBg:Bitmap;
      
      private var _readyBg:MutipleImage;
      
      private var _readyTxt1:FilterFrameText;
      
      private var _readyTxt2:FilterFrameText;
      
      private var _readyTxt3:FilterFrameText;
      
      private var _processBg:Image;
      
      private var _marchImg:Image;
      
      private var _marchNumberBitmap:Bitmap;
      
      private var _marchWheelContainer:Sprite;
      
      private var _marchTurnContainer:Sprite;
      
      private var _nextImg:Image;
      
      private var _nextTxt:FilterFrameText;
      
      private var _finishImg:Image;
      
      private var _shopBtn:BaseButton;
      
      private var _helpLinkTxt:FilterFrameText;
      
      private var _rankLinkTxt:FilterFrameText;
      
      private var _signupBtn:IconButton;
      
      private var _joinBtn:IconButton;
      
      private var _topListView:MatelordsTopListView;
      
      private var _thane:ThaneInfo = ArmyManager.instance.thane;
      
      private var _model:MatelordsModel = MatelordsManager.instance.model;
      
      private var signCost:int = ConfigInfoManager.instance.getMatelordsJoinCost();
      
      private var _clickTime:int;
      
      public function MatelordsFrame()
      {
         super();
         initView();
         addEvent();
         MatelordsManager.instance.matelordsMainInfo();
      }
      
      public function get viewRectangle() : Rectangle
      {
         return new Rectangle(0,0,690,614);
      }
      
      override public function get groups() : Array
      {
         return ["CASTLE_BUIDING_GROUP","MAIN_TOOLS_GROUP"];
      }
      
      private function initView() : void
      {
         titleText = LanguageMgr.GetTranslation("matelords.MatelordsFrame.title");
         _upBgBorder = ComponentFactory.Instance.creatComponentByStylename("matelords.MatelordsFrameUpBgBorder");
         _upBg = ComponentFactory.Instance.creatBitmap("asset.matelords.MatelordsFrameUpBg");
         _upArabesquitic = ComponentFactory.Instance.creatComponentByStylename("matelords.MatelordsBetFrame.Arabesquitic");
         _titleContainer = ComponentFactory.Instance.creatCustomObject("matelords.MatelordsFrame.TitleContainer");
         _titleBg = ComponentFactory.Instance.creatComponentByStylename("matelords.MatelordsFrame.TitleImg");
         _serviceName = ComponentFactory.Instance.creatComponentByStylename("matelords.MatelordsFrame.ServiceName");
         _downBgBorder = ComponentFactory.Instance.creatComponentByStylename("matelords.MatelordsFrameDownBgBorder");
         _downBg = ComponentFactory.Instance.creatBitmap("asset.matelords.MatelordsFrameDownBg");
         _readyBg = ComponentFactory.Instance.creatComponentByStylename("matelords.MatelordsFrame.ReadyBg");
         _readyTxt1 = ComponentFactory.Instance.creatComponentByStylename("matelords.MatelordsFrame.ReadyTxt1");
         _readyTxt2 = ComponentFactory.Instance.creatComponentByStylename("matelords.MatelordsFrame.ReadyTxt2");
         _readyTxt3 = ComponentFactory.Instance.creatComponentByStylename("matelords.MatelordsFrame.ReadyTxt3");
         _processBg = ComponentFactory.Instance.creatComponentByStylename("matelords.MatelordsFrame.ProcessBg");
         _marchImg = ComponentFactory.Instance.creatComponentByStylename("matelords.MatelordsFrame.MarchImg");
         _marchNumberBitmap = ComponentFactory.Instance.creatBitmap("asset.matelords.marchNumberBitmap");
         _marchWheelContainer = ComponentFactory.Instance.creatCustomObject("matelords.MatelordsFrame.MarchWheelContainer");
         _marchTurnContainer = ComponentFactory.Instance.creatCustomObject("matelords.MatelordsFrame.MarchTurnContainer");
         _nextImg = ComponentFactory.Instance.creatComponentByStylename("matelords.MatelordsFrame.NextImg");
         _nextTxt = ComponentFactory.Instance.creatComponentByStylename("matelords.MatelordsFrame.NextTxt");
         _finishImg = ComponentFactory.Instance.creatComponentByStylename("matelords.MatelordsFrame.FinishImg");
         _shopBtn = ComponentFactory.Instance.creatComponentByStylename("matelords.MatelordsFrame.ShopBtn");
         _helpLinkTxt = ComponentFactory.Instance.creatComponentByStylename("matelords.MatelordsFrame.HelpLinkTxt");
         _rankLinkTxt = ComponentFactory.Instance.creatComponentByStylename("matelords.MatelordsFrame.RankLinkTxt");
         _signupBtn = ComponentFactory.Instance.creatComponentByStylename("matelords.MatelordsFrame.SignupBtn");
         _joinBtn = ComponentFactory.Instance.creatComponentByStylename("matelords.MatelordsFrame.JoinBtn");
         _topListView = new MatelordsTopListView();
         _helpLinkTxt.htmlText = "<a href=\'event:#\'>" + LanguageMgr.GetTranslation("public.help") + "</a>";
         _rankLinkTxt.htmlText = "<a href=\'event:#\'>" + LanguageMgr.GetTranslation("mainBar.SmallMapBar.rankingBtnTipData") + "</a>";
         _readyTxt1.text = LanguageMgr.GetTranslation("matelords.MatelordsFrame.ReadyTxt1");
         _readyTxt2.text = LanguageMgr.GetTranslation("matelords.MatelordsFrame.str02",signCost);
         _titleContainer.addChild(_serviceName);
         addToContent(_upBgBorder);
         addToContent(_upBg);
         addToContent(_upArabesquitic);
         addToContent(_titleBg);
         addToContent(_titleContainer);
         addToContent(_topListView);
         addToContent(_downBgBorder);
         addToContent(_downBg);
         addToContent(_readyBg);
         addToContent(_readyTxt1);
         addToContent(_readyTxt2);
         addToContent(_readyTxt3);
         addToContent(_processBg);
         addToContent(_marchImg);
         addToContent(_marchWheelContainer);
         addToContent(_marchTurnContainer);
         addToContent(_nextImg);
         addToContent(_nextTxt);
         addToContent(_finishImg);
         addToContent(_shopBtn);
         addToContent(_helpLinkTxt);
         addToContent(_rankLinkTxt);
         addToContent(_signupBtn);
         addToContent(_joinBtn);
      }
      
      private function uninitView() : void
      {
         ObjectUtils.disposeAllChildren(_titleContainer);
         ObjectUtils.disposeAllChildren(_marchWheelContainer);
         ObjectUtils.disposeAllChildren(_marchTurnContainer);
         ObjectUtils.disposeObject(_upBgBorder);
         _upBgBorder = null;
         ObjectUtils.disposeObject(_upBg);
         _upBg = null;
         ObjectUtils.disposeObject(_upArabesquitic);
         _upArabesquitic = null;
         ObjectUtils.disposeObject(_titleBg);
         _titleBg = null;
         ObjectUtils.disposeObject(_titleContainer);
         _titleContainer = null;
         ObjectUtils.disposeObject(_serviceName);
         _serviceName = null;
         ObjectUtils.disposeObject(_titleBg);
         _titleBg = null;
         ObjectUtils.disposeObject(_downBgBorder);
         _downBgBorder = null;
         ObjectUtils.disposeObject(_downBg);
         _downBg = null;
         ObjectUtils.disposeObject(_readyBg);
         _readyBg = null;
         ObjectUtils.disposeObject(_readyTxt1);
         _readyTxt1 = null;
         ObjectUtils.disposeObject(_readyTxt2);
         _readyTxt2 = null;
         ObjectUtils.disposeObject(_readyTxt3);
         _readyTxt3 = null;
         ObjectUtils.disposeObject(_processBg);
         _processBg = null;
         ObjectUtils.disposeObject(_marchImg);
         _marchImg = null;
         ObjectUtils.disposeObject(_marchNumberBitmap);
         _marchNumberBitmap = null;
         ObjectUtils.disposeObject(_marchWheelContainer);
         _marchWheelContainer = null;
         ObjectUtils.disposeObject(_marchTurnContainer);
         _marchTurnContainer = null;
         ObjectUtils.disposeObject(_nextImg);
         _nextImg = null;
         ObjectUtils.disposeObject(_nextTxt);
         _nextTxt = null;
         ObjectUtils.disposeObject(_finishImg);
         _finishImg = null;
         ObjectUtils.disposeObject(_shopBtn);
         _shopBtn = null;
         ObjectUtils.disposeObject(_helpLinkTxt);
         _helpLinkTxt = null;
         ObjectUtils.disposeObject(_rankLinkTxt);
         _rankLinkTxt = null;
         ObjectUtils.disposeObject(_signupBtn);
         _signupBtn = null;
         ObjectUtils.disposeObject(_joinBtn);
         _joinBtn = null;
         ObjectUtils.disposeObject(_topListView);
         _topListView = null;
         ObjectUtils.disposeAllChildren(this);
      }
      
      private function addEvent() : void
      {
         addEventListener("response",__frameResponseHandler);
         _shopBtn.addEventListener("click",__shopBtnClickHandler);
         _helpLinkTxt.addEventListener("link",__helpLinkClickHandler);
         _rankLinkTxt.addEventListener("link",__rankLinkClickHandler);
         _signupBtn.addEventListener("click",__signupBtnClickHandler);
         _joinBtn.addEventListener("click",__joinBtnClickHandler);
         _model.addEventListener("INFO_UPDATE",__matelordsInfoUpdateHandler);
      }
      
      private function removeEvent() : void
      {
         removeEventListener("response",__frameResponseHandler);
         _shopBtn.removeEventListener("click",__shopBtnClickHandler);
         _helpLinkTxt.removeEventListener("link",__helpLinkClickHandler);
         _rankLinkTxt.removeEventListener("link",__rankLinkClickHandler);
         _signupBtn.removeEventListener("click",__signupBtnClickHandler);
         _joinBtn.removeEventListener("click",__joinBtnClickHandler);
         _model.removeEventListener("INFO_UPDATE",__matelordsInfoUpdateHandler);
      }
      
      private function __matelordsInfoUpdateHandler(param1:MatelordsEvent) : void
      {
         refreshView();
      }
      
      private function __joinBtnClickHandler(param1:MouseEvent) : void
      {
         SoundManager.instance.play("016",true);
         var _loc2_:int = getTimer();
         if(_loc2_ - _clickTime < 3000)
         {
            return;
         }
         _clickTime = _loc2_;
         MatelordsManager.instance.matelordsCreateRoom();
      }
      
      private function __signupBtnClickHandler(param1:MouseEvent) : void
      {
         var _loc5_:String = null;
         SoundManager.instance.play("022");
         if(!MarryManager.instance.model.isMarry)
         {
            _loc5_ = LanguageMgr.GetTranslation("matelords.MatelordsFrame.str06");
            MessageTipManager.instance().show(_loc5_);
            return;
         }
         if(!FreedomTeamManager.instance.hasTeam)
         {
            _loc5_ = LanguageMgr.GetTranslation("matelords.MatelordsFrame.str07");
            MessageTipManager.instance().show(_loc5_);
            return;
         }
         if(!FreedomTeamManager.instance.isCaptain)
         {
            _loc5_ = LanguageMgr.GetTranslation("matelords.MatelordsFrame.str08");
            MessageTipManager.instance().show(_loc5_);
            return;
         }
         if(!FreedomTeamManager.instance.isMarryTeam)
         {
            _loc5_ = LanguageMgr.GetTranslation("matelords.MatelordsFrame.str09");
            MessageTipManager.instance().show(_loc5_);
            return;
         }
         if(!FreedomTeamManager.instance.memeberGradesValid(36))
         {
            _loc5_ = LanguageMgr.GetTranslation("matelords.MatelordsFrame.str10",36);
            MessageTipManager.instance().show(_loc5_);
            return;
         }
         _loc5_ = LanguageMgr.GetTranslation("matelords.MatelordsFrame.str03",signCost);
         var _loc2_:String = LanguageMgr.GetTranslation("public.confirm");
         var _loc3_:String = LanguageMgr.GetTranslation("public.cancel");
         var _loc4_:String = LanguageMgr.GetTranslation("public.prompt");
         SimpleAlertHelper.instance.data = [signupCallBack];
         SimpleAlertHelper.instance.popAlerFrame(_loc4_,_loc5_,_loc2_,_loc3_,false,true);
      }
      
      private function signupCallBack(param1:Boolean, param2:Boolean) : void
      {
         if(param1)
         {
            if(ResourceManager.instance.gold.count < signCost)
            {
               MessageTipManager.instance().show(LanguageMgr.GetTranslation("public.gold"));
               return;
            }
            MatelordsManager.instance.matelordsSignup();
         }
      }
      
      private function __rankLinkClickHandler(param1:TextEvent) : void
      {
         SoundManager.instance.play("022");
         FrameControllerManager.instance.openControllerByInfo("matelords",1);
      }
      
      private function __helpLinkClickHandler(param1:TextEvent) : void
      {
         SoundManager.instance.play("022");
         var _loc2_:Frame = ComponentFactory.Instance.creatComponentByStylename("matelords.MatelordsHelpFrame");
         _loc2_["show"]();
      }
      
      private function __shopBtnClickHandler(param1:MouseEvent) : void
      {
         SoundManager.instance.play("022");
         FrameControllerManager.instance.openControllerByInfo("shop",20);
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
      
      public function refreshView() : void
      {
         var _loc1_:int = 0;
         if(_topListView)
         {
            _topListView.refresh();
         }
         _finishImg.visible = false;
         _titleContainer.visible = true;
         if(!_model.isSign && !_model.isOpen)
         {
            _signupBtn.visible = _readyTxt1.visible = _readyTxt2.visible = _readyTxt3.visible = true;
            _readyBg.visible = true;
            _joinBtn.visible = _processBg.visible = false;
            _readyTxt3.text = _model.openTime;
         }
         else
         {
            _signupBtn.visible = _readyTxt1.visible = _readyTxt2.visible = _readyTxt3.visible = false;
            _readyBg.visible = false;
            _joinBtn.visible = _processBg.visible = true;
         }
         _nextTxt.visible = _nextImg.visible = false;
         _marchWheelContainer.visible = _marchTurnContainer.visible = _marchImg.visible = false;
         if(_model.isOpen)
         {
            NumberViewUtils.refreshTimeValue(_model.warIndex.toString(),_marchWheelContainer,_marchNumberBitmap.bitmapData,16,21,16,16,"0123456789/");
            _loc1_ = int(_model.currentTurn < _model.maxTurnCount ? _model.currentTurn + 1 : _model.currentTurn);
            NumberViewUtils.refreshTimeValue(_loc1_ + "/" + _model.maxTurnCount,_marchTurnContainer,_marchNumberBitmap.bitmapData,16,21,16,16,"0123456789/");
            _marchWheelContainer.visible = _marchTurnContainer.visible = _marchImg.visible = true;
         }
         else if(_model.isSign)
         {
            _nextTxt.text = _model.openTime;
            _nextTxt.visible = _nextImg.visible = true;
         }
         if(_model.isSign)
         {
            _serviceName.text = LanguageMgr.GetTranslation("multilords.MultilordsMamanger.TeamTipsTxt",_model.teamName);
            _serviceName.width = _serviceName.textWidth + 10;
            _titleContainer.x = (_upBg.width - _titleContainer.width) * 0.5;
            _titleContainer.visible = true;
         }
         if(_model.isOver)
         {
            _finishImg.visible = _processBg.visible = true;
            _signupBtn.visible = _readyTxt1.visible = _readyTxt2.visible = _readyTxt3.visible = false;
            _readyBg.visible = _joinBtn.visible = false;
            _nextTxt.visible = _nextImg.visible = false;
         }
         else
         {
            _finishImg.visible = false;
         }
      }
      
      private function get playerModel() : PlayerModel
      {
         return PlayerManager.instance.currentPlayerModel;
      }
      
      public function show() : void
      {
         LayerManager.Instance.addToLayer(this,3,true,true,2);
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

