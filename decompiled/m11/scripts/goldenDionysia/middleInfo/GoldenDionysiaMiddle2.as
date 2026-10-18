package goldenDionysia.middleInfo
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.IconButton;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.ui.image.Image;
   import com.pickgliss.ui.image.ScaleFrameImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import com.pickgliss.utils.SoundManager;
   import com.road.yishi.proto.cccactive.GoldCrazyMsg;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import goldenDionysia.rank.GoldenDionysiaRankView;
   import manager.LanguageMgr;
   import mvc.module.exchargerank.ExchargeRankData;
   import yishi.datas.playerinfo.PlayerModel;
   import yishi.events.NotificationEvent;
   import yishi.manager.GoldenDionysiaManager;
   import yishi.manager.NotificationManager;
   import yishi.manager.PlayerManager;
   import yishi.utils.DateFormatter;
   
   public class GoldenDionysiaMiddle2 extends Component
   {
      
      private var _listBg:Bitmap;
      
      private var _betInfoBg:Bitmap;
      
      private var _pondTitleBmp:Bitmap;
      
      private var _effectTitleBmp:ScaleFrameImage;
      
      private var _pondTxt:FilterFrameText;
      
      private var _effectTxt:FilterFrameText;
      
      private var _resultIcon:Image;
      
      private var _mainContainer:Sprite;
      
      private var _rankView:GoldenDionysiaRankView;
      
      private var _cdBar:GoldenDionysiaCDBar;
      
      private var _betNumTitleBmp:Bitmap;
      
      private var _betNumTxt:FilterFrameText;
      
      private var _betNumIcon:Image;
      
      private var _rewardBtn:IconButton;
      
      private var _goldenMsg:GoldCrazyMsg;
      
      public function GoldenDionysiaMiddle2()
      {
         super();
         initView();
         addEvent();
      }
      
      private function initView() : void
      {
         _listBg = ComponentFactory.Instance.creatBitmap("asset.goldendionysia.listBg");
         _betInfoBg = ComponentFactory.Instance.creatBitmap("asset.goldendionysia.betInfoBg");
         _pondTitleBmp = ComponentFactory.Instance.creatBitmap("asset.goldendionysia.pondTitle");
         _effectTitleBmp = ComponentFactory.Instance.creatComponentByStylename("goldenDionysiaBetInfo.effectImage");
         _pondTxt = ComponentFactory.Instance.creatComponentByStylename("goldenDionysiaBetInfo.pond");
         _effectTxt = ComponentFactory.Instance.creatComponentByStylename("goldenDionysiaBetInfo.effect");
         _resultIcon = ComponentFactory.Instance.creatComponentByStylename("goldenDionysia.resultIcon");
         _rankView = ComponentFactory.Instance.creatCustomObject("goldenDionysia.rank.GoldenDionysiaRankView");
         _mainContainer = ComponentFactory.Instance.creatCustomObject("goldenDionysia.resultTopContainer");
         _cdBar = ComponentFactory.Instance.creatCustomObject("goldenDionysia.middleInfo.GoldenDionysiaCDBar");
         _betNumTitleBmp = ComponentFactory.Instance.creatBitmap("asset.goldendionysia.betNumTitle");
         _betNumTxt = ComponentFactory.Instance.creatComponentByStylename("goldenDionysiaBetInfo.betNum");
         _betNumIcon = ComponentFactory.Instance.creatComponentByStylename("goldenDionysia.betNumIcon");
         _rewardBtn = ComponentFactory.Instance.creatComponentByStylename("goldenDionysiaFrame.bottomRewardBtn");
         addChild(_listBg);
         addChild(_betInfoBg);
         addChild(_cdBar);
         _cdBar.x = 35;
         _cdBar.y = 9;
         addChild(_mainContainer);
         addChild(_rankView);
         _rankView.x = 7;
         _rankView.y = 140;
         addChild(_rewardBtn);
         _mainContainer.addChild(_pondTitleBmp);
         _mainContainer.addChild(_pondTxt);
         _mainContainer.addChild(_resultIcon);
         _mainContainer.addChild(_effectTitleBmp);
         _mainContainer.addChild(_effectTxt);
         _mainContainer.addChild(_betNumTitleBmp);
         _mainContainer.addChild(_betNumTxt);
         _mainContainer.addChild(_betNumIcon);
      }
      
      private function addEvent() : void
      {
         _rewardBtn.addEventListener("click",__receiveHandler);
         NotificationManager.instance.addEventListener("GOLDEN_DIONYSIA_INFO",__updateViewHandler);
         NotificationManager.instance.addEventListener("GOLDEN_DIONYSIA_RESULT",__resultHandler);
      }
      
      private function removeEvent() : void
      {
         if(_rewardBtn)
         {
            _rewardBtn.removeEventListener("click",__receiveHandler);
         }
         NotificationManager.instance.removeEventListener("GOLDEN_DIONYSIA_INFO",__updateViewHandler);
         NotificationManager.instance.removeEventListener("GOLDEN_DIONYSIA_RESULT",__resultHandler);
      }
      
      private function __receiveHandler(param1:MouseEvent) : void
      {
         SoundManager.instance.play("022");
         GoldenDionysiaManager.instance.OperateGoldenDionysiaReq(GoldenDionysiaManager.REWARD);
         _rewardBtn.enable = false;
      }
      
      private function __resultHandler(param1:NotificationEvent) : void
      {
         _rewardBtn.enable = false;
      }
      
      private function __updateViewHandler(param1:NotificationEvent = null) : void
      {
         _goldenMsg = GoldenDionysiaManager.instance.goldenMsg;
         if(_goldenMsg.state != GoldenDionysiaManager.STATE2)
         {
            return;
         }
         var _loc3_:Number = Number(DateFormatter.parse(_goldenMsg.stopTime,"YYYY-MM-DD hh:mm:ss").time);
         var _loc2_:Number = _loc3_ / 1000 - playerModel.sysCurTimeBySecond + 86400;
         _cdBar.curPhase = _goldenMsg.state - 1;
         _cdBar.startCD(_loc2_);
         _rewardBtn.enable = _goldenMsg.isLuckReward > 0;
         _pondTxt.text = _goldenMsg.currentPoint.toString();
         _betNumTxt.text = _goldenMsg.myConsumPoint.toString();
         if(GoldenDionysiaManager.instance.isActive)
         {
            _effectTitleBmp.setFrame(1);
            _effectTxt.text = LanguageMgr.GetTranslation("GoldenDionysiaItem.winCountTxt6");
         }
         else
         {
            _effectTitleBmp.setFrame(2);
            _effectTxt.text = LanguageMgr.GetTranslation("GoldenDionysiaItem.winCountTxt7");
         }
         var _loc4_:Vector.<ExchargeRankData> = GoldenDionysiaManager.instance.getLuckyRankList(1);
         _rankView.type = 1;
         _rankView.updateUI(_loc4_,1);
      }
      
      private function get playerModel() : PlayerModel
      {
         return PlayerManager.instance.currentPlayerModel;
      }
      
      override public function dispose() : void
      {
         removeEvent();
         ObjectUtils.disposeObject(_listBg);
         _listBg = null;
         ObjectUtils.disposeObject(_betInfoBg);
         _betInfoBg = null;
         ObjectUtils.disposeObject(_pondTitleBmp);
         _pondTitleBmp = null;
         ObjectUtils.disposeObject(_effectTitleBmp);
         _effectTitleBmp = null;
         ObjectUtils.disposeObject(_pondTxt);
         _pondTxt = null;
         ObjectUtils.disposeObject(_effectTxt);
         _effectTxt = null;
         ObjectUtils.disposeObject(_resultIcon);
         _resultIcon = null;
         ObjectUtils.disposeObject(_mainContainer);
         _mainContainer = null;
         ObjectUtils.disposeObject(_rankView);
         _rankView = null;
         ObjectUtils.disposeObject(_cdBar);
         _cdBar = null;
         ObjectUtils.disposeObject(_betNumTitleBmp);
         _betNumTitleBmp = null;
         ObjectUtils.disposeObject(_betNumTxt);
         _betNumTxt = null;
         ObjectUtils.disposeObject(_betNumIcon);
         _betNumIcon = null;
         ObjectUtils.disposeObject(_rewardBtn);
         _rewardBtn = null;
         _goldenMsg = null;
         super.dispose();
      }
   }
}

