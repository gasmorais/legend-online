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
   import mvc.module.revenge.RevengeModel;
   import yishi.datas.templates.ConfigInfosTempInfo;
   import yishi.datas.templates.RevengeRoadTempInfo;
   import yishi.events.NotificationEvent;
   import yishi.manager.FrameControllerManager;
   import yishi.manager.NotificationManager;
   import yishi.manager.RevengeRoadManager;
   import yishi.manager.TempleteManager;
   import yishi.scene.SceneManager;
   import yishi.utils.DateFormatter;
   import yishi.utils.SimpleAlertHelper;
   
   public class RevengeRoadMopupPrepareFrame extends Frame implements IManualSize
   {
      
      private static var WEARY:int = 10;
      
      private const REVENGE_ROAD_LAND_MOPUP:int = 5;
      
      private const OPERATION_MOPUP:int = 1;
      
      private var _mopupHowCounts:Bitmap;
      
      private var _mopupCounts:Bitmap;
      
      private var _mopupUseTime:Bitmap;
      
      private var _mopupNeedGold:Bitmap;
      
      private var _mopupGoldBack:Bitmap;
      
      private var _needPowerBack:Bitmap;
      
      private var _remainCount:Bitmap;
      
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
      
      private var _demonlandSwapCountTxt:FilterFrameText;
      
      private var _startMopupBtn:IconButton;
      
      private var _campaignId:int;
      
      private var _campaignTime:int;
      
      private var _weary:int;
      
      private var _canMopupCounts:int;
      
      private var _campaignCostGold:int;
      
      private var _mopupCountsNum:int;
      
      private var _maxNum:int;
      
      public function RevengeRoadMopupPrepareFrame()
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
         _needPowerBack = ComponentFactory.Instance.creatBitmap("asset.mopup.demonland.revengeHeart");
         _mopupNeedGold = ComponentFactory.Instance.creatBitmap("asset.mopup.MopupNeedGold");
         _mopupGoldBack = ComponentFactory.Instance.creatBitmap("asset.mopup.MopupGoldTxt");
         _remainCount = ComponentFactory.Instance.creatBitmap("asset.mopup.demonland.count");
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
         _demonlandSwapCountTxt = ComponentFactory.Instance.creatComponentByStylename("mopup.demonland.swapCount");
         _startMopupBtn = ComponentFactory.Instance.creatComponentByStylename("mopup.StartMopupBtn");
         _mopupBack0.height = 260;
         _mopupBack1.height = 250;
         _mopupBack2.height = 250;
         _mopupCounts.y = 10;
         _mopupHowCounts.y = 11;
         _mopupInputBack.y = 10;
         _mopupCountsTxt.y = 13;
         _mopupUseTime.y = 40;
         _mopupUseTimeTxt.y = 40;
         _mopupUseTimeTxt.x = 355;
         _needPowerBack.y = 69;
         _needPowerText.y = 68;
         _needPowerBack.x = 277;
         _needPowerText.x = 450;
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
         addToContent(_remainCount);
         addToContent(_mopupTipTitle);
         _mopupTipTitle.text = LanguageMgr.GetTranslation("mopup.view.MazeMopupPrepareFrame.mopupTipTitle");
         addToContent(_mopupTipTxt);
         _mopupTipTxt.htmlText = LanguageMgr.GetTranslation("mopup.view.MazeMopupPrepareFrame.mopupTipTxt");
         addToContent(_startMopupBtn);
         addToContent(_demonlandSwapCountTxt);
      }
      
      public function initData() : void
      {
         var _loc7_:ConfigInfosTempInfo = null;
         titleText = LanguageMgr.GetTranslation("revengeroad.main.mopup");
         _loc7_ = TempleteManager.instance.getConfigInfoByConfigName("revengeroad_sweep_time");
         if(_loc7_)
         {
            _campaignTime = int(_loc7_.ConfigValue);
         }
         _loc7_ = TempleteManager.instance.getConfigInfoByConfigName("revengeroad_sweep_gold");
         if(_loc7_)
         {
            _campaignCostGold = int(_loc7_.ConfigValue);
         }
         var _loc2_:int = 2147483647;
         var _loc4_:RevengeRoadTempInfo = TempleteManager.instance.revengeRoadTempCate.getTempInfo(_campaignId);
         if(_loc4_.AttackCount > 0)
         {
            _remainCount.visible = true;
            _demonlandSwapCountTxt.visible = true;
            _loc2_ = _maxNum;
         }
         else
         {
            _remainCount.visible = false;
            _demonlandSwapCountTxt.visible = false;
         }
         WEARY = _loc4_.Cost;
         _weary = RevengeRoadManager.Ins.model.revengeHeart;
         var _loc1_:int = _weary / WEARY;
         _canMopupCounts = Math.floor(_weary / WEARY);
         _canMopupCounts = Math.min(_canMopupCounts,_loc1_,_loc2_);
         _mopupCountsTxt.text = "1";
         _mopupGoldTxt.text = hasMopupBuff ? "0" : String(_campaignCostGold);
         _needPowerText.text = WEARY + "";
         _demonlandSwapCountTxt.text = _canMopupCounts + "/" + _loc2_;
         _mopupUseTimeTxt.text = DateFormatter.getConsortiaCountDate(_campaignTime);
         var _loc5_:String = LanguageMgr.GetTranslation("mopup.view.CampaignMopupPrepareFrame.CampaignMopupPrepareFrame.kingFreeTip");
         var _loc6_:String = "<font color=\'#06ff00\'><a href=\'event:clickLink\'><u>" + LanguageMgr.GetTranslation("mainBar.view.ChoosePayTypeFrame.openVipTxt") + "</u></a></font>";
         var _loc3_:String = LanguageMgr.GetTranslation("public.parentheses1",_loc6_);
         _kingFreeTxt.htmlText = _loc5_ + _loc3_;
      }
      
      private function addEvent() : void
      {
         addEventListener("response",__frameResponse);
         _kingFreeTxt.addEventListener("link",__openKingClick);
         _startMopupBtn.addEventListener("click",__startMopupHandler);
         _mopupCountsTxt.addEventListener("change",__textChangeHandler);
         NotificationManager.instance.addEventListener("UPDATE_KINGCONTRACT",__updateKingContractHandler);
         NotificationManager.instance.addEventListener("REVENGE_ROAD_DATA",dataHandler);
      }
      
      private function removeEvent() : void
      {
         removeEventListener("response",__frameResponse);
         _kingFreeTxt.removeEventListener("link",__openKingClick);
         _startMopupBtn.removeEventListener("click",__startMopupHandler);
         _mopupCountsTxt.removeEventListener("change",__textChangeHandler);
         NotificationManager.instance.removeEventListener("UPDATE_KINGCONTRACT",__updateKingContractHandler);
         NotificationManager.instance.removeEventListener("REVENGE_ROAD_DATA",dataHandler);
      }
      
      private function dataHandler(param1:NotificationEvent) : void
      {
         var _loc3_:int = 2147483647;
         var _loc4_:RevengeRoadTempInfo = TempleteManager.instance.revengeRoadTempCate.getTempInfo(_campaignId);
         if(_loc4_.AttackCount > 0)
         {
            _remainCount.visible = true;
            _demonlandSwapCountTxt.visible = true;
            _loc3_ = _maxNum;
         }
         else
         {
            _remainCount.visible = false;
            _demonlandSwapCountTxt.visible = false;
         }
         WEARY = _loc4_.Cost;
         _weary = revengeModel.revengeHeart;
         var _loc2_:int = _weary / WEARY;
         _canMopupCounts = Math.floor(_weary / WEARY);
         _canMopupCounts = Math.min(_canMopupCounts,_loc2_,_loc3_);
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
         var _loc4_:String = null;
         var _loc2_:String = null;
         var _loc3_:String = null;
         var _loc5_:String = null;
         SoundManager.instance.play("022");
         if(revengeModel.checkIsNeedBuyAlert(_campaignId))
         {
            _loc4_ = LanguageMgr.GetTranslation("revengeroad.main.text5",revengeModel.buyTimePrice,revengeModel.MAX_VALUE,revengeModel.buyTimeMax - revengeModel.buyCount);
            SimpleAlertHelper.instance.data = [confirmBuy];
            _loc2_ = LanguageMgr.GetTranslation("public.confirm");
            _loc3_ = LanguageMgr.GetTranslation("public.cancel");
            _loc5_ = LanguageMgr.GetTranslation("public.prompt");
            SimpleAlertHelper.instance.popAlerFrame(_loc5_,_loc4_,_loc2_,_loc3_,true,true);
            return;
         }
         _model.mopupCount = int(_mopupCountsTxt.text);
         _model.campaignId = _campaignId;
         MopupManager.instance.sendMopupInfo(5,1,_campaignId,_model.mopupCount,_campaignId);
         dispose();
      }
      
      private function confirmBuy(param1:Boolean, param2:Boolean) : void
      {
         if(param1)
         {
            RevengeRoadManager.Ins.sendBuyHeart();
         }
      }
      
      private function __textChangeHandler(param1:Event) : void
      {
         _mopupCountsNum = int(_mopupCountsTxt.text);
         _mopupCountsNum = _mopupCountsNum > _canMopupCounts ? _canMopupCounts : _mopupCountsNum;
         _mopupCountsNum = _mopupCountsNum < 1 ? 1 : _mopupCountsNum;
         _mopupCountsTxt.text = String(_mopupCountsNum);
         _mopupUseTimeTxt.text = DateFormatter.getConsortiaCountDate(int(_mopupCountsTxt.text) * _campaignTime);
         _mopupGoldTxt.text = hasMopupBuff ? "0" : String(int(_mopupCountsTxt.text) * _campaignCostGold);
         _needPowerText.text = String(int(_mopupCountsTxt.text) * WEARY);
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
      
      public function show(param1:Object = null) : void
      {
         _campaignId = param1.nodeId;
         _maxNum = param1.bossFightCount;
         initData();
         LayerManager.Instance.addToLayer(this,3,true,true);
      }
      
      override public function get groups() : Array
      {
         return ["CASTLE_BUIDING_GROUP","BAG_GROUP"];
      }
      
      private function get _model() : MopupModel
      {
         return MopupManager.instance.model;
      }
      
      private function get revengeModel() : RevengeModel
      {
         return RevengeRoadManager.Ins.model;
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
         ObjectUtils.disposeObject(_needPowerBack);
         _needPowerBack = null;
         ObjectUtils.disposeObject(_demonlandSwapCountTxt);
         _demonlandSwapCountTxt = null;
         ObjectUtils.disposeObject(_remainCount);
         _remainCount = null;
         ObjectUtils.disposeObject(_needPowerText);
         _needPowerText = null;
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

