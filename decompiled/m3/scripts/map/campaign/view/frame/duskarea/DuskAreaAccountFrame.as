package map.campaign.view.frame.duskarea
{
   import com.pickgliss.instance.IManualSize;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.IconButton;
   import com.pickgliss.ui.image.ScaleFrameImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Bitmap;
   import flash.events.MouseEvent;
   import flash.geom.Rectangle;
   import manager.LanguageMgr;
   import map.campaign.CampaignManager;
   import map.campaign.data.PvpWarFightModel;
   import yishi.utils.WorldBossHelper;
   
   public class DuskAreaAccountFrame extends DuskAreaPointRankFrame implements IManualSize
   {
      
      private var _winImg:Bitmap;
      
      private var _lossImg:Bitmap;
      
      private var _bg:Bitmap;
      
      private var _getRewardImg:Bitmap;
      
      private var _leaveBtn:IconButton;
      
      private var _rewardImgA:ScaleFrameImage;
      
      private var _rewardTxtA:FilterFrameText;
      
      private var _rewardImgB:Bitmap;
      
      private var _rewardTxtB:FilterFrameText;
      
      private var _rewardImgC:Bitmap;
      
      private var _rewardTxtC:FilterFrameText;
      
      public function DuskAreaAccountFrame()
      {
         super();
      }
      
      override protected function initView() : void
      {
         super.initView();
         titleText = LanguageMgr.GetTranslation("map.campaign.view.frame.duskarea.DuskAreaAccountFrame");
         super._bagBack.height = 480;
         _winImg = ComponentFactory.Instance.creatBitmap("asset.DuskAreaAccountFrame.winImg");
         _winImg.smoothing = true;
         _winImg.visible = false;
         _lossImg = ComponentFactory.Instance.creatBitmap("asset.DuskAreaAccountFrame.lossImg");
         _lossImg.smoothing = true;
         _lossImg.visible = false;
         _bg = ComponentFactory.Instance.creatBitmap("asset.DuskAreaAccountFrame.bg");
         _getRewardImg = ComponentFactory.Instance.creatBitmap("asset.DuskAreaAccountFrame.getRewardTxtImg");
         _leaveBtn = ComponentFactory.Instance.creatComponentByStylename("duskarea.DuskAreaAccountFrame.LeaveBtn");
         _rewardImgA = ComponentFactory.Instance.creatComponentByStylename("duskarea.DuskAreaAccountFrame.RewardImgA");
         _rewardImgB = ComponentFactory.Instance.creatBitmap("asset.DuskAreaAccountFrame.RewardImgB");
         _rewardImgC = ComponentFactory.Instance.creatBitmap("asset.DuskAreaAccountFrame.RewardImgC");
         _rewardTxtA = ComponentFactory.Instance.creatComponentByStylename("duskarea.DuskAreaAccountFrame.RewardTxtA");
         _rewardTxtA.text = "× 0";
         _rewardTxtB = ComponentFactory.Instance.creatComponentByStylename("duskarea.DuskAreaAccountFrame.RewardTxtB");
         _rewardTxtB.text = "× 0";
         _rewardTxtC = ComponentFactory.Instance.creatComponentByStylename("duskarea.DuskAreaAccountFrame.RewardTxtC");
         _rewardTxtC.text = "× 0";
         addToContent(_winImg);
         addToContent(_lossImg);
         addToContent(_bg);
         addToContent(_getRewardImg);
         addToContent(_leaveBtn);
         addToContent(_rewardImgA);
         addToContent(_rewardImgB);
         addToContent(_rewardImgC);
         addToContent(_rewardTxtA);
         addToContent(_rewardTxtB);
         addToContent(_rewardTxtC);
         initEvent();
         updateView();
      }
      
      private function initEvent() : void
      {
         _leaveBtn.addEventListener("click",onLeaveClick);
      }
      
      private function removeEvent() : void
      {
         _leaveBtn.removeEventListener("click",onLeaveClick);
      }
      
      private function onLeaveClick(param1:MouseEvent) : void
      {
         dispose();
      }
      
      public function updateView() : void
      {
         super.setDate(pvpWarFightModel.warFightOrderList);
         _winImg.visible = false;
         _lossImg.visible = true;
         if(pvpWarFightModel.pvpWarFightInfo.teamId == pvpWarFightModel.fightReportInfo.oneTeamId)
         {
            _winImg.visible = true;
            _lossImg.visible = false;
         }
         if(pvpWarFightModel.findSelfInfo())
         {
            _rewardTxtA.text = "× " + pvpWarFightModel.findSelfInfo().medal.toString();
            _rewardTxtB.text = "× " + pvpWarFightModel.findSelfInfo().honner.toString();
            _rewardTxtC.text = "× " + pvpWarFightModel.findSelfInfo().soulsStoreCount.toString();
         }
      }
      
      private function get pvpWarFightModel() : PvpWarFightModel
      {
         return CampaignManager.instance.pvpWarFightModel;
      }
      
      override public function get viewRectangle() : Rectangle
      {
         return new Rectangle(0,0,665,610);
      }
      
      override public function show(param1:Object = null) : void
      {
         super.show(param1);
         if(WorldBossHelper.checkDuskArea(mapId))
         {
            _rewardImgA.setFrame(3);
            _rewardImgA.y = 385;
         }
         else if(WorldBossHelper.checkFlameTemple(mapId))
         {
            _rewardImgA.setFrame(2);
            _rewardImgA.y = 385;
         }
         else if(WorldBossHelper.checkIceFireTemple(mapId))
         {
            _rewardImgA.setFrame(1);
            _rewardImgA.y = 380;
         }
      }
      
      override public function dispose() : void
      {
         removeEvent();
         ObjectUtils.disposeObject(_winImg);
         _winImg = null;
         ObjectUtils.disposeObject(_lossImg);
         _lossImg = null;
         ObjectUtils.disposeObject(_bg);
         _bg = null;
         ObjectUtils.disposeObject(_getRewardImg);
         _getRewardImg = null;
         ObjectUtils.disposeObject(_leaveBtn);
         _leaveBtn = null;
         ObjectUtils.disposeObject(_rewardImgA);
         _rewardImgA = null;
         ObjectUtils.disposeObject(_rewardImgB);
         _rewardImgB = null;
         ObjectUtils.disposeObject(_rewardImgC);
         _rewardImgC = null;
         ObjectUtils.disposeObject(_rewardTxtA);
         _rewardTxtA = null;
         ObjectUtils.disposeObject(_rewardTxtB);
         _rewardTxtB = null;
         ObjectUtils.disposeObject(_rewardTxtC);
         _rewardTxtC = null;
         super.dispose();
      }
   }
}

