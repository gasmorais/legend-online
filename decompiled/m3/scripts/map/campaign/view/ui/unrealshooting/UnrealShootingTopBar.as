package map.campaign.view.ui.unrealshooting
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.image.Image;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Bitmap;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import mainBar.StripView;
   import manager.LanguageMgr;
   import map.campaign.CampaignManager;
   import map.campaign.data.CampaignMapModel;
   import map.campaign.data.UnrealShootingModel;
   import map.campaign.event.UnrealShootingEvent;
   import map.campaign.view.ui.DownTimeView;
   import map.internals.data.CampaignNode;
   import yishi.manager.FrameControllerManager;
   
   public class UnrealShootingTopBar extends Sprite implements Disposeable
   {
      
      private var _bg:Bitmap;
      
      private var _blueLogo:Image;
      
      private var _blueScoreTip:StripView;
      
      private var _blueScoreBar:MovieClip;
      
      private var _blueScoreLabel:Image;
      
      private var _blueScoreTxt:FilterFrameText;
      
      private var _redLogo:Image;
      
      private var _redScoreTip:StripView;
      
      private var _redScoreBar:MovieClip;
      
      private var _redScoreLabel:Image;
      
      private var _redScoreTxt:FilterFrameText;
      
      private var _topDownTime:DownTimeView;
      
      private var _mapModel:CampaignMapModel;
      
      private var _model:UnrealShootingModel;
      
      public function UnrealShootingTopBar()
      {
         super();
         _mapModel = CampaignManager.instance.mapModel;
         _model = FrameControllerManager.instance.unrealShootingController.model;
         initView();
         addEvent();
         updateTime();
         update();
         this.mouseEnabled = false;
      }
      
      private function initView() : void
      {
         _bg = ComponentFactory.Instance.creatBitmap("asset.unrealshooting.TopBottomImg");
         _blueLogo = ComponentFactory.Instance.creatComponentByStylename("unrealshooting.UnrealShootingTopBar.blueLogo");
         _blueScoreTip = ComponentFactory.Instance.creatCustomObject("unrealshooting.UnrealShootingTopBar.buleScoreTip");
         _blueScoreBar = ComponentFactory.Instance.creatCustomObject("unrealshooting.UnrealShootingTopBar.buleScoreBar");
         _blueScoreLabel = ComponentFactory.Instance.creatComponentByStylename("unrealshooting.UnrealShootingTopBar.blueScoreLabel");
         _blueScoreTxt = ComponentFactory.Instance.creatComponentByStylename("unrealshooting.UnrealShootingTopBar.blueScoreTxt");
         _redLogo = ComponentFactory.Instance.creatComponentByStylename("unrealshooting.UnrealShootingTopBar.redLogo");
         _redScoreTip = ComponentFactory.Instance.creatCustomObject("unrealshooting.UnrealShootingTopBar.redScoreTip");
         _redScoreBar = ComponentFactory.Instance.creatCustomObject("unrealshooting.UnrealShootingTopBar.redScoreBar");
         _redScoreLabel = ComponentFactory.Instance.creatComponentByStylename("unrealshooting.UnrealShootingTopBar.redScoreLabel");
         _redScoreTxt = ComponentFactory.Instance.creatComponentByStylename("unrealshooting.UnrealShootingTopBar.redScoreTxt");
         _topDownTime = new DownTimeView(false);
         _topDownTime.x = 161;
         _topDownTime.y = -16;
         _blueScoreTxt.text = "0";
         _redScoreTxt.text = "0";
         _blueScoreBar.gotoAndStop(100);
         _redScoreBar.gotoAndStop(100);
         _blueScoreTip.addChild(_blueScoreBar);
         _redScoreTip.addChild(_redScoreBar);
         addChild(_bg);
         addChild(_blueLogo);
         addChild(_blueScoreTip);
         addChild(_blueScoreLabel);
         addChild(_blueScoreTxt);
         addChild(_redLogo);
         addChild(_redScoreTip);
         addChild(_redScoreLabel);
         addChild(_redScoreTxt);
      }
      
      private function uintView() : void
      {
         ObjectUtils.disposeObject(_bg);
         _bg = null;
         ObjectUtils.disposeObject(_blueLogo);
         _blueLogo = null;
         ObjectUtils.disposeObject(_blueScoreTip);
         _blueScoreTip = null;
         ObjectUtils.disposeViolentMc(_blueScoreBar);
         _blueScoreBar = null;
         ObjectUtils.disposeObject(_blueScoreLabel);
         _blueScoreLabel = null;
         ObjectUtils.disposeObject(_redLogo);
         _redLogo = null;
         ObjectUtils.disposeObject(_redScoreTip);
         _redScoreTip = null;
         ObjectUtils.disposeViolentMc(_redScoreBar);
         _redScoreBar = null;
         ObjectUtils.disposeObject(_redScoreLabel);
         _redScoreLabel = null;
         ObjectUtils.disposeObject(_redScoreTxt);
         _redScoreTxt = null;
         ObjectUtils.disposeObject(_topDownTime);
         _topDownTime = null;
         ObjectUtils.disposeObject(_blueScoreTxt);
         _blueScoreTxt = null;
         ObjectUtils.disposeAllChildren(this);
         ObjectUtils.disposeSelf(this);
      }
      
      private function addEvent() : void
      {
         _model.addEventListener("UNREAL_SHOOTING_INFO_CHANGE",__infoChangeHandler);
         _model.addEventListener("UNREAL_SHOOTING_RANK_DETAIL_LIST_CHANGE",__rankDetailListChangeHandler);
      }
      
      private function removeEvent() : void
      {
         if(_model)
         {
            _model.removeEventListener("UNREAL_SHOOTING_INFO_CHANGE",__infoChangeHandler);
            _model.removeEventListener("UNREAL_SHOOTING_RANK_DETAIL_LIST_CHANGE",__rankDetailListChangeHandler);
         }
      }
      
      private function __infoChangeHandler(param1:UnrealShootingEvent) : void
      {
         update();
      }
      
      private function __rankDetailListChangeHandler(param1:UnrealShootingEvent) : void
      {
         update();
      }
      
      private function updateTime() : void
      {
         if(_topDownTime)
         {
            _topDownTime.count = _model.leftTime;
         }
         if(!contains(_topDownTime))
         {
            addChild(_topDownTime);
         }
      }
      
      public function update() : void
      {
         var _loc1_:CampaignNode = null;
         var _loc2_:Number = NaN;
         var _loc3_:Number = NaN;
         var _loc4_:int = 1;
         _blueScoreTxt.text = _model.teamScoreBlue.toString();
         _loc1_ = _mapModel.getBaseTowerUnrealShooting(1);
         if(_loc1_)
         {
            _loc2_ = Number(_loc1_.curHp);
            _loc3_ = Number(_loc1_.totalHp);
         }
         _loc4_ = _loc2_ * 100 / _loc3_;
         if(_loc4_ <= 0)
         {
            _loc4_ = 1;
         }
         _blueScoreBar.gotoAndStop(_loc4_);
         _blueScoreTip.tipData = LanguageMgr.GetTranslation("map.campaign.view.ui.unrealshooting.UnrealShootingTopBar.blueScoreTip",_loc2_);
         _redScoreTxt.text = _model.teamScoreRed.toString();
         _loc1_ = _mapModel.getBaseTowerUnrealShooting(2);
         if(_loc1_)
         {
            _loc2_ = Number(_loc1_.curHp);
            _loc3_ = Number(_loc1_.totalHp);
         }
         _loc4_ = _loc2_ * 100 / _loc3_;
         if(_loc4_ <= 0)
         {
            _loc4_ = 1;
         }
         _redScoreBar.gotoAndStop(_loc4_);
         _redScoreTip.tipData = LanguageMgr.GetTranslation("map.campaign.view.ui.unrealshooting.UnrealShootingTopBar.redScoreTip",_loc2_);
      }
      
      override public function get width() : Number
      {
         return 501;
      }
      
      public function show() : void
      {
         LayerManager.Instance.addToLayer(this,4,false,false,0,0);
      }
      
      public function dispose() : void
      {
         removeEvent();
         uintView();
      }
   }
}

