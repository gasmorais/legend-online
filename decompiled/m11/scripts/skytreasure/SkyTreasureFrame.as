package skytreasure
{
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.instance.IManualSize;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.BaseButton;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.ui.image.Image;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import com.pickgliss.utils.SoundManager;
   import events.SkyTreasureEvent;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.geom.Rectangle;
   import manager.LanguageMgr;
   import map.space.SpaceManager;
   import mvc.module.armyII.BaseArmy;
   import skytreasure.view.SkyTreasureBagView;
   import skytreasure.view.SkyTreasureBoxView;
   import skytreasure.view.SkyTreasureCenterView;
   import skytreasure.view.SkyTreasureRankShowView;
   import skytreasure.view.SkyTreasureRankView;
   import yishi.keyboard.KeyBoardRegister;
   import yishi.manager.SkyTreasureManager;
   import yishi.utils.DateFormatter;
   import yishi.view.tips.MessageTipManager;
   
   public class SkyTreasureFrame extends Frame implements IManualSize
   {
      
      private var _skyTreasureBagView:SkyTreasureBagView;
      
      private var _skyTreasureBoxView:SkyTreasureBoxView;
      
      private var _skyTreasureCenterView:SkyTreasureCenterView;
      
      private var _skyTreasureRankView:SkyTreasureRankView;
      
      private var _shyTreasureRankShowView:SkyTreasureRankShowView;
      
      private var _skyTreasureFrameBg:Bitmap;
      
      private var _countText:FilterFrameText;
      
      private var _rankText:FilterFrameText;
      
      private var _countBmp:Bitmap;
      
      private var _rankBmp1:Bitmap;
      
      private var _rankBmp2:Bitmap;
      
      private var _rankBmp3:Bitmap;
      
      private var _seekReward:Image;
      
      private var _containerView:Sprite;
      
      private var _helpBtn:BaseButton;
      
      private var _startTimeText:FilterFrameText;
      
      private var _endTimeText:FilterFrameText;
      
      private var _startStr:String;
      
      private var _endStr:String;
      
      public function SkyTreasureFrame()
      {
         super();
         SkyTreasureManager.Instance.getActivesInfo();
         SkyTreasureManager.Instance.getRanksInfo();
         initView();
         initEvent();
      }
      
      private function initView() : void
      {
         _titleText = LanguageMgr.GetTranslation("activity.skytreasure.skyTreasureFrame.title");
         _skyTreasureBagView = ComponentFactory.Instance.creatCustomObject("skyTreasureFrame.skyTreasureBagView");
         _skyTreasureBoxView = ComponentFactory.Instance.creatCustomObject("skyTreasureFrame.skyTreasureBoxView");
         _skyTreasureCenterView = ComponentFactory.Instance.creatCustomObject("skyTreasureFrame.skyTreasureCenterView");
         _skyTreasureRankView = ComponentFactory.Instance.creatCustomObject("skyTreasureFrame.skyTreasureRankView");
         _shyTreasureRankShowView = ComponentFactory.Instance.creatCustomObject("skyTreasureFrame.SkyTreasureRankShowView");
         _startStr = DateFormatter.transDate(SkyTreasureManager.Instance.startTime / 1000);
         _endStr = DateFormatter.transDate(SkyTreasureManager.Instance.endTime / 1000);
         _startTimeText = ComponentFactory.Instance.creatComponentByStylename("skyTreasureFrame.startText");
         _endTimeText = ComponentFactory.Instance.creatComponentByStylename("skyTreasureFrame.endText");
         _startStr = DateFormatter.transDate(SkyTreasureManager.Instance.startTime / 1000);
         _endStr = DateFormatter.transDate(SkyTreasureManager.Instance.endTime / 1000);
         _startTimeText.text = LanguageMgr.GetTranslation("activity.skytreasure.activity.startTime",_startStr.slice(5,_startStr.length).toString());
         _endTimeText.text = LanguageMgr.GetTranslation("activity.skytreasure.activity.endTime",_endStr.toString().slice(5,_endStr.length).toString());
         _countText = ComponentFactory.Instance.creatComponentByStylename("skyTreasureFrame.countText");
         _rankText = ComponentFactory.Instance.creatComponentByStylename("skyTreasureFrame.rankText");
         _skyTreasureFrameBg = ComponentFactory.Instance.creatBitmap("asset.skytreasure.largeBg");
         _countBmp = ComponentFactory.Instance.creatBitmap("asset.skytreasure.myIntegral");
         _rankBmp1 = ComponentFactory.Instance.creatBitmap("asset.skytreasure.myRank");
         _rankBmp2 = ComponentFactory.Instance.creatBitmap("asset.skytreasure.theFirst");
         _rankBmp3 = ComponentFactory.Instance.creatBitmap("asset.skytreasure.rank");
         _seekReward = ComponentFactory.Instance.creatComponentByStylename("skyTreasureFrame.lookReward");
         _seekReward.tipData = _shyTreasureRankShowView;
         _helpBtn = ComponentFactory.Instance.creatComponentByStylename("skyTreasureFrame.helpBtn");
         _helpBtn.tipData = [LanguageMgr.GetTranslation("skytreasure.SkyTreasureFrame.helpBtnTips")];
         _containerView = new Sprite();
         addToContent(_containerView);
         _containerView.addChild(_skyTreasureFrameBg);
         _containerView.addChild(_helpBtn);
         _containerView.addChild(_countText);
         _containerView.addChild(_rankText);
         _containerView.addChild(_startTimeText);
         _containerView.addChild(_endTimeText);
         _containerView.addChild(_countBmp);
         _containerView.addChild(_rankBmp1);
         _containerView.addChild(_rankBmp2);
         _containerView.addChild(_rankBmp3);
         _containerView.addChild(_seekReward);
         _containerView.addChild(_skyTreasureBoxView);
         _containerView.addChild(_skyTreasureBagView);
         _containerView.addChild(_skyTreasureCenterView);
         _containerView.addChild(_skyTreasureRankView);
      }
      
      private function refreshActiviteTime() : void
      {
         _startStr = DateFormatter.transDate(SkyTreasureManager.Instance.startTime / 1000);
         _endStr = DateFormatter.transDate(SkyTreasureManager.Instance.endTime / 1000);
         _startTimeText.text = LanguageMgr.GetTranslation("activity.skytreasure.activity.startTime",_startStr.slice(5,_startStr.length).toString());
         _endTimeText.text = LanguageMgr.GetTranslation("activity.skytreasure.activity.endTime",_endStr.toString().slice(5,_endStr.length).toString());
      }
      
      private function initData() : void
      {
         if(SkyTreasureManager.Instance.model.joinInfoVO)
         {
            _countText.text = String(SkyTreasureManager.Instance.model.joinInfoVO.height);
            _rankText.text = String(SkyTreasureManager.Instance.model.joinInfoVO.rank);
         }
      }
      
      private function initEvent() : void
      {
         addEventListener("response",__frameResponse);
         SkyTreasureManager.Instance.addEventListener("SKYTREASURE_RANK_UPDATE",__updateHandle);
         SkyTreasureManager.Instance.addEventListener("SKYTREASURE_ACTIVES_INFO",__updateActivityHandler);
         if(_helpBtn)
         {
            _helpBtn.addEventListener("click",__helpBtnHandler);
         }
      }
      
      private function __helpBtnHandler(param1:MouseEvent) : void
      {
         SoundManager.instance.play("022");
         var _loc2_:Frame = ComponentFactory.Instance.creatComponentByStylename("skyTreasure.help");
         _loc2_["show"]();
      }
      
      private function __updateHandle(param1:SkyTreasureEvent) : void
      {
         initData();
      }
      
      private function __updateActivityHandler(param1:SkyTreasureEvent) : void
      {
         refreshActiviteTime();
         if(!SkyTreasureManager.Instance.isOpen)
         {
            super.onResponse(0);
         }
      }
      
      override protected function __onCloseClick(param1:MouseEvent) : void
      {
         if(SkyTreasureManager.Instance.isStart())
         {
            MessageTipManager.instance().show(LanguageMgr.GetTranslation("activity.skytreasure.center.tips"));
            return;
         }
         super.__onCloseClick(param1);
      }
      
      private function __frameResponse(param1:FrameEvent) : void
      {
         switch(int(param1.responseCode))
         {
            case 0:
               dispose();
         }
      }
      
      private function removeEvent() : void
      {
         removeEventListener("response",__frameResponse);
         SkyTreasureManager.Instance.removeEventListener("SKYTREASURE_RANK_UPDATE",__updateHandle);
         SkyTreasureManager.Instance.removeEventListener("SKYTREASURE_ACTIVES_INFO",__updateActivityHandler);
         if(_helpBtn)
         {
            _helpBtn.removeEventListener("click",__helpBtnHandler);
         }
      }
      
      public function get viewRectangle() : Rectangle
      {
         return new Rectangle(0,0,900,600);
      }
      
      override public function dispose() : void
      {
         removeEvent();
         ObjectUtils.disposeObject(_skyTreasureBagView);
         _skyTreasureBagView = null;
         ObjectUtils.disposeObject(_skyTreasureBoxView);
         _skyTreasureBoxView = null;
         ObjectUtils.disposeObject(_skyTreasureCenterView);
         _skyTreasureCenterView = null;
         ObjectUtils.disposeObject(_skyTreasureRankView);
         _skyTreasureRankView = null;
         ObjectUtils.disposeObject(_skyTreasureFrameBg);
         _skyTreasureFrameBg = null;
         ObjectUtils.disposeObject(_countText);
         _countText = null;
         ObjectUtils.disposeObject(_rankText);
         _rankText = null;
         ObjectUtils.disposeObject(_countBmp);
         _countBmp = null;
         ObjectUtils.disposeObject(_rankBmp1);
         _rankBmp1 = null;
         ObjectUtils.disposeObject(_rankBmp2);
         _rankBmp2 = null;
         ObjectUtils.disposeObject(_rankBmp3);
         _rankBmp3 = null;
         ObjectUtils.disposeObject(_seekReward);
         _seekReward = null;
         ObjectUtils.disposeObject(_helpBtn);
         _helpBtn = null;
         ObjectUtils.disposeObject(_containerView);
         _containerView = null;
         ObjectUtils.disposeAllChildren(this);
         super.dispose();
      }
      
      override public function get groups() : Array
      {
         return ["BAG_GROUP","MAIN_TOOLS_GROUP"];
      }
      
      public function show() : void
      {
         var _loc1_:* = undefined;
         KeyBoardRegister.instance.keyEnable = false;
         LayerManager.Instance.addToLayer(this,3,true,true,1);
         try
         {
            _loc1_ = SpaceManager.instance.controller.getArmyView(SpaceManager.instance.model.selfArmy as BaseArmy);
            _loc1_.stopWalkByOut();
         }
         catch(e:Error)
         {
         }
      }
   }
}

