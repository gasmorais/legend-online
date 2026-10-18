package mopup.view
{
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.instance.IManualSize;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.ui.controls.IconButton;
   import com.pickgliss.ui.image.Scale9CornerImage;
   import com.pickgliss.ui.image.ScaleBitmapImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import com.pickgliss.utils.SoundManager;
   import events.KingContractEvents;
   import flash.display.Bitmap;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.events.TextEvent;
   import flash.geom.Rectangle;
   import manager.LanguageMgr;
   import managers.KingContractManager;
   import managers.MopupManager;
   import mvc.module.mopup.MopupModel;
   import mvc.module.shadowland.ShadowLandModel;
   import yishi.datas.templates.ShadowLandTempInfo;
   import yishi.manager.FrameControllerManager;
   import yishi.manager.NotificationManager;
   import yishi.manager.ResourceManager;
   import yishi.manager.ShadowLandManager;
   import yishi.manager.TempleteManager;
   import yishi.scene.SceneManager;
   import yishi.utils.DateFormatter;
   import yishi.view.tips.MessageTipManager;
   
   public class ShadowLandMopupPrepareFrame extends Frame implements IManualSize
   {
      
      private static const SHADOW_LAND_MOPUP:int = 6;
      
      private static const OPERATION_MOPUP:int = 1;
      
      private static const WEARY:int = 10;
      
      private var _mopupHowCounts:Bitmap;
      
      private var _mopupCounts:Bitmap;
      
      private var _mopupUseTime:Bitmap;
      
      private var _mopupNeedGold:Bitmap;
      
      private var _mopupGoldBack:Bitmap;
      
      private var _needPowerBack:Bitmap;
      
      private var _mopupBack0:Scale9CornerImage;
      
      private var _mopupBack1:Scale9CornerImage;
      
      private var _mopupBack2:ScaleBitmapImage;
      
      private var _mopupInputBack:ScaleBitmapImage;
      
      private var _mopupCountsTxt:FilterFrameText;
      
      private var _mopupUseTimeTxt:FilterFrameText;
      
      private var _mopupTipTitle:FilterFrameText;
      
      private var _mopupTipTxt:FilterFrameText;
      
      private var _mopupGoldTxt:FilterFrameText;
      
      private var _needPowerText:FilterFrameText;
      
      private var _kingFreeTxt:FilterFrameText;
      
      private var _startMopupBtn:IconButton;
      
      private var _time:int;
      
      private var _weary:int;
      
      private var _canMopupCounts:int;
      
      private var _costGold:int;
      
      private var _mopupCountsNum:int;
      
      private var _tempInfo:ShadowLandTempInfo;
      
      public function ShadowLandMopupPrepareFrame()
      {
         super();
         initView();
         addEvent();
      }
      
      public function get viewRectangle() : Rectangle
      {
         return new Rectangle(0,0,555,315);
      }
      
      private function initView() : void
      {
         if(SceneManager.instance.currentType != "CASTLE_SCENE" && SceneManager.instance.currentType != "SPACE_SCENE")
         {
            SceneManager.instance.setScene("CASTLE_SCENE");
         }
         _mopupHowCounts = ComponentFactory.Instance.creatBitmap("asset.mopup.MopupHowCounts");
         _mopupCounts = ComponentFactory.Instance.creatBitmap("asset.mopup.MopupCounts");
         _mopupUseTime = ComponentFactory.Instance.creatBitmap("asset.mopup.MopupUseTime");
         _needPowerBack = ComponentFactory.Instance.creatBitmap("asset.mopup.NeededPower");
         _mopupNeedGold = ComponentFactory.Instance.creatBitmap("asset.mopup.MopupNeedGold");
         _mopupGoldBack = ComponentFactory.Instance.creatBitmap("asset.mopup.MopupGoldTxt");
         _mopupBack0 = ComponentFactory.Instance.creatComponentByStylename("mopup.MopupBack0");
         _mopupBack1 = ComponentFactory.Instance.creatComponentByStylename("mopup.MopupBack1");
         _mopupBack2 = ComponentFactory.Instance.creatComponentByStylename("mopup.MopupBack2");
         _mopupInputBack = ComponentFactory.Instance.creatComponentByStylename("mopup.MopupPrepareInputBack");
         _mopupCountsTxt = ComponentFactory.Instance.creatComponentByStylename("mopup.MopupCountsInputTxt");
         _mopupUseTimeTxt = ComponentFactory.Instance.creatComponentByStylename("mopup.MopupUseTimeTxt");
         _mopupTipTitle = ComponentFactory.Instance.creatComponentByStylename("mopup.MopupTipTitle");
         _mopupTipTxt = ComponentFactory.Instance.creatComponentByStylename("mopup.MopupTipTxt");
         _needPowerText = ComponentFactory.Instance.creatComponentByStylename("mopup.MopupNeedPowerText");
         _mopupGoldTxt = ComponentFactory.Instance.creatComponentByStylename("mopup.MazeMopupNeedGoldTxt");
         _kingFreeTxt = ComponentFactory.Instance.creatComponentByStylename("mopup.MazeMopupKingFreeTxt");
         _startMopupBtn = ComponentFactory.Instance.creatComponentByStylename("mopup.StartMopupBtn");
         _mopupBack0.height = 260;
         _mopupBack1.height = 250;
         _mopupBack2.height = 250;
         _mopupCounts.y = 10;
         _mopupHowCounts.y = 13;
         _mopupInputBack.y = 10;
         _mopupCountsTxt.y = 13;
         _mopupUseTime.y = 40;
         _mopupUseTimeTxt.y = 42;
         _needPowerBack.y = 69;
         _needPowerText.y = 69;
         _needPowerText.x = 375;
         _mopupGoldBack.y = 95;
         _mopupNeedGold.y = 92;
         _mopupGoldTxt.y = 94;
         _startMopupBtn.y = 175;
         _kingFreeTxt.y = 226;
         addToContent(_mopupBack0);
         addToContent(_mopupBack1);
         addToContent(_mopupBack2);
         addToContent(_mopupInputBack);
         addToContent(_mopupHowCounts);
         addToContent(_mopupCounts);
         addToContent(_mopupUseTime);
         addToContent(_needPowerBack);
         addToContent(_mopupNeedGold);
         addToContent(_mopupGoldBack);
         addToContent(_mopupCountsTxt);
         addToContent(_mopupUseTimeTxt);
         addToContent(_needPowerText);
         addToContent(_mopupGoldTxt);
         addToContent(_mopupTipTitle);
         _mopupTipTitle.text = LanguageMgr.GetTranslation("mopup.view.MazeMopupPrepareFrame.mopupTipTitle");
         addToContent(_mopupTipTxt);
         _mopupTipTxt.htmlText = LanguageMgr.GetTranslation("mopup.view.MazeMopupPrepareFrame.mopupTipTxt");
         addToContent(_startMopupBtn);
      }
      
      public function initData() : void
      {
         if(!_tempInfo)
         {
            return;
         }
         titleText = LanguageMgr.GetTranslation("ShadowLandMopupPrepareFrame.titleText");
         var _loc1_:String = TempleteManager.instance.getConfigInfoByConfigName("shadow_land_sweep_config").ConfigValue;
         var _loc2_:Array = _loc1_.split(",");
         if(_loc2_.length >= 1)
         {
            _time = _loc2_[0];
            _costGold = _loc2_[1];
         }
         _weary = shadowLandModel.curNum;
         _canMopupCounts = Math.floor(_weary / 10);
         _mopupCountsTxt.text = "1";
         _mopupGoldTxt.text = hasMopupBuff ? "0" : String(_costGold);
         _needPowerText.text = "10";
         _mopupUseTimeTxt.text = DateFormatter.getConsortiaCountDate(_time);
         var _loc4_:String = LanguageMgr.GetTranslation("mopup.view.CampaignMopupPrepareFrame.CampaignMopupPrepareFrame.kingFreeTip");
         var _loc5_:String = "<font color=\'#06ff00\'><a href=\'event:clickLink\'><u>" + LanguageMgr.GetTranslation("mainBar.view.ChoosePayTypeFrame.openVipTxt") + "</u></a></font>";
         var _loc3_:String = LanguageMgr.GetTranslation("public.parentheses1",_loc5_);
         _kingFreeTxt.htmlText = _loc4_ + _loc3_;
      }
      
      private function addEvent() : void
      {
         addEventListener("response",__frameResponse);
         _kingFreeTxt.addEventListener("link",__openKingClick);
         _startMopupBtn.addEventListener("click",__startMopupHandler);
         _mopupCountsTxt.addEventListener("change",__textChangeHandler);
         NotificationManager.instance.addEventListener("UPDATE_KINGCONTRACT",__updateKingContractHandler);
      }
      
      private function removeEvent() : void
      {
         removeEventListener("response",__frameResponse);
         _kingFreeTxt.removeEventListener("link",__openKingClick);
         _startMopupBtn.removeEventListener("click",__startMopupHandler);
         _mopupCountsTxt.removeEventListener("change",__textChangeHandler);
         NotificationManager.instance.removeEventListener("UPDATE_KINGCONTRACT",__updateKingContractHandler);
      }
      
      private function __updateKingContractHandler(param1:KingContractEvents) : void
      {
         if(hasMopupBuff)
         {
            _mopupGoldTxt.text = "0";
         }
      }
      
      private function __openKingClick(param1:TextEvent) : void
      {
         FrameControllerManager.instance.openControllerByInfo("kingcontract");
      }
      
      private function __startMopupHandler(param1:MouseEvent) : void
      {
         var _loc2_:String = null;
         SoundManager.instance.play("022");
         if(int(_mopupCountsTxt.text) <= 0)
         {
            _loc2_ = LanguageMgr.GetTranslation("mopup.MopupManager.mopupTipData03");
            MessageTipManager.instance().show(_loc2_);
            _mopupCountsTxt.text = "1";
            __textChangeHandler(null);
            return;
         }
         if(_weary < int(_mopupCountsTxt.text) * 10)
         {
            _loc2_ = LanguageMgr.GetTranslation("mopup.MopupManager.mopupTipData03");
            MessageTipManager.instance().show(_loc2_);
            _mopupCountsTxt.text = "1";
            __textChangeHandler(null);
            return;
         }
         if(int(_mopupGoldTxt.text) > ResourceManager.instance.gold.count)
         {
            _loc2_ = LanguageMgr.GetTranslation("mopup.MopupManager.mopupTipData02");
            MessageTipManager.instance().show(_loc2_);
            return;
         }
         model.mopupCount = int(_mopupCountsTxt.text);
         model.campaignId = _tempInfo.CheckpointId;
         MopupManager.instance.sendMopupInfo(6,1,_tempInfo.CheckpointId,model.mopupCount);
         dispose();
      }
      
      private function __textChangeHandler(param1:Event) : void
      {
         _mopupCountsNum = int(_mopupCountsTxt.text);
         _mopupCountsNum = _mopupCountsNum > _canMopupCounts ? _canMopupCounts : _mopupCountsNum;
         _mopupCountsNum = _mopupCountsNum < 1 ? 1 : _mopupCountsNum;
         _mopupCountsTxt.text = String(_mopupCountsNum);
         _mopupUseTimeTxt.text = DateFormatter.getConsortiaCountDate(int(_mopupCountsTxt.text) * _time);
         _mopupGoldTxt.text = hasMopupBuff ? "0" : String(int(_mopupCountsTxt.text) * _costGold);
         _needPowerText.text = String(int(_mopupCountsTxt.text) * 10);
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
      
      private function get hasMopupBuff() : Boolean
      {
         return false;
      }
      
      public function show(param1:ShadowLandTempInfo = null) : void
      {
         LayerManager.Instance.addToLayer(this,3,true,true);
         if(param1)
         {
            _tempInfo = param1;
         }
         initData();
      }
      
      override public function get groups() : Array
      {
         return ["CASTLE_BUIDING_GROUP","BAG_GROUP"];
      }
      
      private function get model() : MopupModel
      {
         return MopupManager.instance.model;
      }
      
      private function get shadowLandModel() : ShadowLandModel
      {
         return ShadowLandManager.instance.model;
      }
      
      private function uninit() : void
      {
         ObjectUtils.disposeAllChildren(this);
         ObjectUtils.disposeObject(_mopupHowCounts);
         _mopupHowCounts = null;
         ObjectUtils.disposeObject(_mopupCounts);
         _mopupCounts = null;
         ObjectUtils.disposeObject(_mopupUseTime);
         _mopupUseTime = null;
         ObjectUtils.disposeObject(_mopupNeedGold);
         _mopupNeedGold = null;
         ObjectUtils.disposeObject(_mopupGoldBack);
         _mopupGoldBack = null;
         ObjectUtils.disposeObject(_mopupBack0);
         _mopupBack0 = null;
         ObjectUtils.disposeObject(_mopupBack1);
         _mopupBack1 = null;
         ObjectUtils.disposeObject(_mopupBack2);
         _mopupBack2 = null;
         ObjectUtils.disposeObject(_mopupInputBack);
         _mopupInputBack = null;
         ObjectUtils.disposeObject(_mopupCountsTxt);
         _mopupCountsTxt = null;
         ObjectUtils.disposeObject(_mopupUseTimeTxt);
         _mopupUseTimeTxt = null;
         ObjectUtils.disposeObject(_mopupTipTitle);
         _mopupTipTitle = null;
         ObjectUtils.disposeObject(_mopupTipTxt);
         _mopupTipTxt = null;
         ObjectUtils.disposeObject(_mopupGoldTxt);
         _mopupGoldTxt = null;
         ObjectUtils.disposeObject(_startMopupBtn);
         _startMopupBtn = null;
         ObjectUtils.disposeObject(_kingFreeTxt);
         _kingFreeTxt = null;
         ObjectUtils.disposeAllChildren(this);
      }
      
      override public function dispose() : void
      {
         removeEvent();
         uninit();
         if(parent)
         {
            parent.removeChild(this);
         }
         super.dispose();
      }
   }
}

