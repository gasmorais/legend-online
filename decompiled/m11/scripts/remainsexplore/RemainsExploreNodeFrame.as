package remainsexplore
{
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.ui.controls.IconButton;
   import com.pickgliss.ui.image.MutipleImage;
   import com.pickgliss.ui.image.ScaleFrameImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Bitmap;
   import flash.display.MovieClip;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import mainBar.StripView;
   import manager.LanguageMgr;
   import managers.FreedomTeamManager;
   import mvc.module.remainsexplore.RemainsExploreModel;
   import mvc.module.remainsexplore.RemainsExploreNodeInfo;
   import yishi.datas.ComponentGroupType;
   import yishi.datas.ConfigInfoManager;
   import yishi.datas.playerinfo.PlayerInfo;
   import yishi.manager.FrameControllerManager;
   import yishi.manager.PlayerManager;
   import yishi.manager.RechargeAlertMannager;
   import yishi.manager.RemainsExploreManager;
   import yishi.manager.TempleteManager;
   import yishi.utils.MsgMan;
   import yishi.utils.SimpleAlertHelper;
   import yishi.view.tips.MessageTipManager;
   
   public class RemainsExploreNodeFrame extends Frame
   {
      
      private var _bg:Bitmap;
      
      private var _progressMc:MovieClip;
      
      private var _progressTxt:FilterFrameText;
      
      private var _back:ScaleFrameImage;
      
      private var _exploreBtn:IconButton;
      
      private var _bossBtn1:IconButton;
      
      private var _bossBtn2:IconButton;
      
      private var _icon:Bitmap;
      
      private var _numTxt:FilterFrameText;
      
      private var _iconBack:MutipleImage;
      
      private var _countTxt:FilterFrameText;
      
      private var _buyBtn:IconButton;
      
      private var _dropBtn:IconButton;
      
      private var _stepMc:MovieClip;
      
      private var _markMc:MovieClip;
      
      private var _buyCost:int = 20;
      
      private var _getTinder:int = 100;
      
      private var _isFirstOpen:Boolean = true;
      
      private var _stripView:StripView;
      
      private var _iconBg:Bitmap;
      
      private var _tipBtn:IconButton;
      
      public function RemainsExploreNodeFrame()
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
         titleText = TempleteManager.instance.remainsExploreChapterTempCate.getChapterName(model.tempAreaId);
         _bg = ComponentFactory.Instance.creatBitmap("asset.RemainsExploreNodeFrame.bg");
         _progressMc = ComponentFactory.Instance.creat("remainsExploreFrame.progressMc");
         _progressTxt = ComponentFactory.Instance.creatComponentByStylename("remainsExploreFrame.progressTxt");
         _back = ComponentFactory.Instance.creatComponentByStylename("remainsExploreFrame.back");
         _exploreBtn = ComponentFactory.Instance.creatComponentByStylename("remainsExploreFrame.exploreBtn");
         _bossBtn1 = ComponentFactory.Instance.creatComponentByStylename("remainsExploreFrame.bossBtn1");
         _bossBtn2 = ComponentFactory.Instance.creatComponentByStylename("remainsExploreFrame.bossBtn2");
         _icon = ComponentFactory.Instance.creatBitmap("asset.RemainsExploreNodeFrame.icon");
         _numTxt = ComponentFactory.Instance.creatComponentByStylename("remainsExploreFrame.numTxt");
         _iconBack = ComponentFactory.Instance.creatComponentByStylename("remainsExploreFrame.iconBack");
         _countTxt = ComponentFactory.Instance.creatComponentByStylename("remainsExploreFrame.countTxt");
         _buyBtn = ComponentFactory.Instance.creatComponentByStylename("remainsExploreFrame.buyBtn");
         _dropBtn = ComponentFactory.Instance.creatComponentByStylename("remainsExploreFrame.dropBtn");
         _stepMc = ComponentFactory.Instance.creat("remainsExploreNodeFrame.stepMc");
         _markMc = ComponentFactory.Instance.creat("remainsExploreNodeFrame.markMc");
         _stripView = ComponentFactory.Instance.creatCustomObject("remainsExploreNodeFrame.stripView");
         _iconBg = ComponentFactory.Instance.creatBitmap("asset.shop.ShopDisplayShow02");
         _stripView.addChild(_iconBack);
         _stripView.setHitArea(0,0,210,33);
         _stripView.tipData = LanguageMgr.GetTranslation("remainsExploreNodeFrame.stripView.txt");
         _tipBtn = ComponentFactory.Instance.creatComponentByStylename("remainsExploreNodeFrame.tipBtn");
         addToContent(_bg);
         addToContent(_progressMc);
         addToContent(_progressTxt);
         addToContent(_back);
         addToContent(_exploreBtn);
         addToContent(_bossBtn1);
         addToContent(_bossBtn2);
         addToContent(_icon);
         addToContent(_numTxt);
         addToContent(_stripView);
         addToContent(_stripView);
         addToContent(_countTxt);
         addToContent(_buyBtn);
         addToContent(_dropBtn);
         addToContent(_stepMc);
         addToContent(_markMc);
         addToContent(_tipBtn);
         _progressTxt.text = LanguageMgr.GetTranslation("remainsExploreNodeFrame.progressTxt.text");
         _progressMc.gotoAndStop(1);
         _stepMc.gotoAndStop(1);
         _markMc.gotoAndStop(1);
         _stepMc.addFrameScript(_stepMc.totalFrames - 1,sendByStepMc);
         _markMc.addFrameScript(_markMc.totalFrames - 1,sendByMarkMc);
         var _loc1_:Object = {};
         _loc1_.title = LanguageMgr.GetTranslation("remainsExploreNodeFrame.tipTxt.title");
         _loc1_.content = LanguageMgr.GetTranslation("remainsExploreNodeFrame.tipTxt.content");
         _tipBtn.tipData = _loc1_;
         refreshView();
      }
      
      private function addEvent() : void
      {
         addEventListener("response",__frameResponse);
         _dropBtn.addEventListener("click",__dropBtnClickHandler);
         MsgMan.addObserver("EXPLORE_INFO_UPDATE",this,__updateInfoHandler);
         MsgMan.addObserver("DO_EXPLORE_UPDATE",this,__updateDoExploreInfoHandler);
         _exploreBtn.addEventListener("click",__exploreBtnClickHandler);
         _buyBtn.addEventListener("click",__buyBtnClickHandler);
         _bossBtn1.addEventListener("click",__bossBtnClickHandler);
         _bossBtn2.addEventListener("click",__bossBtnClickHandler);
      }
      
      private function removeEvent() : void
      {
         removeEventListener("response",__frameResponse);
         _dropBtn.removeEventListener("click",__dropBtnClickHandler);
         MsgMan.removeObserver("EXPLORE_INFO_UPDATE",this,__updateInfoHandler);
         MsgMan.removeObserver("DO_EXPLORE_UPDATE",this,__updateDoExploreInfoHandler);
         _exploreBtn.removeEventListener("click",__exploreBtnClickHandler);
         _buyBtn.removeEventListener("click",__buyBtnClickHandler);
         _bossBtn1.removeEventListener("click",__bossBtnClickHandler);
         _bossBtn2.removeEventListener("click",__bossBtnClickHandler);
         _progressMc.removeEventListener("enterFrame",__progressMcHandler);
      }
      
      private function __bossBtnClickHandler(param1:MouseEvent) : void
      {
         if(param1.currentTarget == _bossBtn1)
         {
            RemainsExploreManager.instance.sendAttack(info.checkpointId,1);
         }
         else
         {
            RemainsExploreManager.instance.sendAttack(info.checkpointId,2);
         }
      }
      
      private function __buyBtnClickHandler(param1:MouseEvent) : void
      {
         if(model.tinder >= tinderTotal)
         {
            MessageTipManager.instance().show(LanguageMgr.GetTranslation("remainsExploreNodeFrame.message.text"));
            return;
         }
         if(model.canBuyTimes <= 0)
         {
            MessageTipManager.instance().show(LanguageMgr.GetTranslation("skyboxroad.SkyBoxRoadFrame.txt3"));
            return;
         }
         var _loc5_:Array = ConfigInfoManager.instance.getRemainsExploreTinderBuy();
         var _loc7_:int = _loc5_.length - model.canBuyTimes;
         var _loc2_:String = _loc5_[_loc7_];
         var _loc6_:Array = _loc2_.split(",");
         _buyCost = _loc6_[0];
         _getTinder = _loc6_[1];
         SimpleAlertHelper.instance.data = [buyActiveCallBack];
         var _loc3_:String = LanguageMgr.GetTranslation("public.confirm");
         var _loc4_:String = LanguageMgr.GetTranslation("public.cancel");
         var _loc8_:String = LanguageMgr.GetTranslation("public.prompt");
         var _loc9_:String = LanguageMgr.GetTranslation("remainsExploreNodeFrame.alert.content",_buyCost,_getTinder,model.canBuyTimes);
         SimpleAlertHelper.instance.popAlerFrame(_loc8_,_loc9_,_loc3_,_loc4_,true,true,false,2,"SIMPLE_ALERT");
      }
      
      private function buyActiveCallBack(param1:Boolean, param2:Boolean) : void
      {
         if(param1)
         {
            if(playerInfo.point < _buyCost)
            {
               RechargeAlertMannager.show();
               return;
            }
            RemainsExploreManager.instance.sendBuy();
         }
      }
      
      private function __exploreBtnClickHandler(param1:MouseEvent) : void
      {
         if(model.tinder < info.exploreCost)
         {
            MessageTipManager.instance().show(LanguageMgr.GetTranslation("remainsExploreNodeFrame.tinder.noEnough"));
            return;
         }
         if(FreedomTeamManager.instance.hasTeam)
         {
            MessageTipManager.instance().show(LanguageMgr.GetTranslation("yishi.manager.WarlordsManager.str04"));
            return;
         }
         _exploreBtn.enable = false;
         _buyBtn.enable = false;
         _closeButton.enable = false;
         _bossBtn1.enable = false;
         _bossBtn2.enable = false;
         RemainsExploreManager.instance.sendExplore(info.checkpointId);
      }
      
      private function __updateInfoHandler(param1:String, param2:Object) : void
      {
         refreshView();
      }
      
      private function __updateDoExploreInfoHandler(param1:String, param2:Object) : void
      {
         refreshView();
         refreshMc();
      }
      
      private function __dropBtnClickHandler(param1:MouseEvent) : void
      {
         FrameControllerManager.instance.openControllerByInfo("remainsexplore",3);
      }
      
      private function refreshView() : void
      {
         _back.setFrame(model.tempAreaId);
         if(!info)
         {
            return;
         }
         if(_isFirstOpen)
         {
            _progressMc.gotoAndStop(info.progress);
            _isFirstOpen = false;
         }
         else if(info.progress > _progressMc.currentFrame)
         {
            _progressMc.addEventListener("enterFrame",__progressMcHandler);
            _progressMc.play();
         }
         _numTxt.text = info.exploreCost.toString();
         _countTxt.htmlText = LanguageMgr.GetTranslation("remiansExploreNodeFrame.countTxt.text",model.tinder,tinderTotal);
         _bossBtn1.visible = info.isShowBoss1;
         _bossBtn2.visible = info.isShowBoss2;
         if(info.checkpointId == model.boss1NodeId)
         {
            _bossBtn1.visible = true;
         }
         if(info.checkpointId == model.boss2NodeId)
         {
            _bossBtn2.visible = true;
         }
         if(info.isShowBoss1)
         {
            _bossBtn1.tipData = LanguageMgr.GetTranslation("remainsExploreNodeFrame.bossBtn1.txt");
         }
         else if(info.isShowBoss2)
         {
            _bossBtn2.tipData = LanguageMgr.GetTranslation("remainsExploreNodeFrame.bossBtn2.txt");
         }
         else
         {
            _bossBtn1.tipData = LanguageMgr.GetTranslation("remainsExploreNodeFrame.bossBtn.txt");
            _bossBtn2.tipData = LanguageMgr.GetTranslation("remainsExploreNodeFrame.bossBtn.txt");
         }
      }
      
      private function __progressMcHandler(param1:Event) : void
      {
         if(_progressMc.currentFrame == info.progress)
         {
            _progressMc.stop();
            _progressMc.removeEventListener("enterFrame",__progressMcHandler);
         }
      }
      
      private function refreshMc() : void
      {
         if(model.eventType == RemainsExploreManager.EVENT_GOODS)
         {
            _stepMc.gotoAndPlay(1);
         }
         else
         {
            _markMc.gotoAndPlay(1);
         }
      }
      
      private function sendByStepMc() : void
      {
         _stepMc.gotoAndStop(1);
         RemainsExploreManager.instance.sendAttack(info.checkpointId);
         _exploreBtn.enable = true;
         _buyBtn.enable = true;
         _closeButton.enable = true;
         _bossBtn1.enable = true;
         _bossBtn2.enable = true;
      }
      
      private function sendByMarkMc() : void
      {
         _markMc.gotoAndStop(1);
         RemainsExploreManager.instance.sendAttack(info.checkpointId);
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
         LayerManager.Instance.addToLayer(this,3,true,true,1);
      }
      
      private function get tinderTotal() : int
      {
         return ConfigInfoManager.instance.getRemainsExploreTinderTotal();
      }
      
      private function get info() : RemainsExploreNodeInfo
      {
         return model.currentInfo;
      }
      
      private function get model() : RemainsExploreModel
      {
         return RemainsExploreManager.instance.model;
      }
      
      private function get playerInfo() : PlayerInfo
      {
         return PlayerManager.instance.currentPlayerModel.playerInfo;
      }
      
      override public function dispose() : void
      {
         removeEvent();
         ObjectUtils.disposeObject(_bg);
         _bg = null;
         ObjectUtils.disposeObject(_progressTxt);
         _progressTxt = null;
         ObjectUtils.disposeObject(_back);
         _back = null;
         ObjectUtils.disposeObject(_exploreBtn);
         _exploreBtn = null;
         ObjectUtils.disposeObject(_bossBtn1);
         _bossBtn1 = null;
         ObjectUtils.disposeObject(_bossBtn2);
         _bossBtn2 = null;
         ObjectUtils.disposeObject(_icon);
         _icon = null;
         ObjectUtils.disposeObject(_numTxt);
         _numTxt = null;
         ObjectUtils.disposeObject(_iconBack);
         _iconBack = null;
         ObjectUtils.disposeObject(_stripView);
         _stripView = null;
         ObjectUtils.disposeObject(_countTxt);
         _countTxt = null;
         ObjectUtils.disposeObject(_buyBtn);
         _buyBtn = null;
         ObjectUtils.disposeObject(_dropBtn);
         _dropBtn = null;
         ObjectUtils.disposeObject(_tipBtn);
         _tipBtn = null;
         ObjectUtils.disposeViolentMc(_progressMc);
         _progressMc = null;
         ObjectUtils.disposeViolentMc(_stepMc);
         _stepMc = null;
         ObjectUtils.disposeViolentMc(_markMc);
         _markMc = null;
         ObjectUtils.disposeAllChildren(this);
         super.dispose();
      }
   }
}

