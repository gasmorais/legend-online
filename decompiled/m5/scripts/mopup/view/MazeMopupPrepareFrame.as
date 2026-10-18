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
   import yishi.datas.VersionSwitch;
   import yishi.datas.playerinfo.TowerInfo;
   import yishi.manager.FrameControllerManager;
   import yishi.manager.NotificationManager;
   import yishi.manager.PlayerManager;
   import yishi.manager.ResourceManager;
   import yishi.manager.TempleteManager;
   import yishi.scene.SceneManager;
   import yishi.utils.DateFormatter;
   import yishi.view.tips.MessageTipManager;
   
   public class MazeMopupPrepareFrame extends Frame implements IManualSize
   {
      
      private static const MAZE_MOPUP:int = 2;
      
      private static const OPERATION_MOPUP:int = 1;
      
      private var _mopupHowCounts:Bitmap;
      
      private var _mopupCounts:Bitmap;
      
      private var _mopupUseTime:Bitmap;
      
      private var _mopupNeedGold:Bitmap;
      
      private var _mopupGoldBack:Bitmap;
      
      private var _mopupBack0:Scale9CornerImage;
      
      private var _mopupBack1:Scale9CornerImage;
      
      private var _mopupBack2:ScaleBitmapImage;
      
      private var _mopupInputBack:ScaleBitmapImage;
      
      private var _mopupCountsTxt:FilterFrameText;
      
      private var _mopupUseTimeTxt:FilterFrameText;
      
      private var _mopupTipTitle:FilterFrameText;
      
      private var _mopupTipTxt:FilterFrameText;
      
      private var _mopupGoldTxt:FilterFrameText;
      
      private var _kingFreeTxt:FilterFrameText;
      
      private var _startMopupBtn:IconButton;
      
      private var _mazeTime:int;
      
      private var _mazeCostGold:int;
      
      private var _mazeCounts:int;
      
      private var inputMaxIndex:String;
      
      private var _mopupCountsNum:int;
      
      public function MazeMopupPrepareFrame()
      {
         super();
         initView();
         initData();
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
         _mopupHowCounts = ComponentFactory.Instance.creatBitmap("asset.mopup.MopupHowLayers");
         _mopupCounts = ComponentFactory.Instance.creatBitmap("asset.mopup.MopupLayers");
         _mopupUseTime = ComponentFactory.Instance.creatBitmap("asset.mopup.MopupUseTime");
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
         _mopupGoldTxt = ComponentFactory.Instance.creatComponentByStylename("mopup.MazeMopupNeedGoldTxt");
         _kingFreeTxt = ComponentFactory.Instance.creatComponentByStylename("mopup.MazeMopupKingFreeTxt");
         _startMopupBtn = ComponentFactory.Instance.creatComponentByStylename("mopup.StartMopupBtn");
         addToContent(_mopupBack0);
         addToContent(_mopupBack1);
         addToContent(_mopupBack2);
         addToContent(_mopupInputBack);
         _mopupInputBack.x = 440;
         _mopupInputBack.y = 22;
         addToContent(_mopupHowCounts);
         addToContent(_mopupCounts);
         addToContent(_mopupUseTime);
         _mopupUseTime.y = 56;
         addToContent(_mopupNeedGold);
         _mopupNeedGold.y = 94;
         addToContent(_mopupGoldBack);
         _mopupGoldBack.y = 95;
         addToContent(_mopupCountsTxt);
         _mopupCountsTxt.x = 442;
         _mopupCountsTxt.y = 25;
         addToContent(_mopupUseTimeTxt);
         _mopupUseTimeTxt.x = 355;
         _mopupUseTimeTxt.y = 59;
         addToContent(_mopupGoldTxt);
         _mopupGoldTxt.y = 95;
         addToContent(_mopupTipTitle);
         _mopupTipTitle.text = LanguageMgr.GetTranslation("mopup.view.MazeMopupPrepareFrame.mopupTipTitle");
         addToContent(_mopupTipTxt);
         _mopupTipTxt.htmlText = LanguageMgr.GetTranslation("mopup.view.MazeMopupPrepareFrame.mopupTipTxt");
         addToContent(_startMopupBtn);
         _startMopupBtn.y = 138;
      }
      
      public function initData() : void
      {
         titleText = LanguageMgr.GetTranslation("mopup.view.MazeMopupPrepareFrame.titleText");
         _mazeTime = int(TempleteManager.instance.getConfigInfoByConfigName("Tower_Sweep_Time").ConfigValue);
         _mazeCostGold = int(TempleteManager.instance.getConfigInfoByConfigName("Tower_Sweep_Gold").ConfigValue);
         if(towerInfo.maxIndex)
         {
            inputMaxIndex = String(towerInfo.maxIndex);
         }
         else
         {
            inputMaxIndex = "0";
         }
         _mopupCountsTxt.text = inputMaxIndex;
         if(towerInfo.towerIndex)
         {
            _mazeCounts = int(_mopupCountsTxt.text) - towerInfo.towerIndex + 1;
         }
         else
         {
            _mazeCounts = int(_mopupCountsTxt.text);
         }
         _mopupGoldTxt.text = String(_mazeCounts * _mazeCostGold);
         if(int(_mopupGoldTxt.text) < 0 || hasMopupBuff)
         {
            _mopupGoldTxt.text = "0";
         }
         if((int(_mopupCountsTxt.text) - towerInfo.towerIndex + 1) * _mazeTime < 0)
         {
            _mopupUseTimeTxt.text = DateFormatter.getConsortiaCountDate(0);
         }
         else
         {
            _mopupUseTimeTxt.text = DateFormatter.getConsortiaCountDate((int(_mopupCountsTxt.text) - towerInfo.towerIndex + 1) * _mazeTime);
         }
         var _loc2_:String = LanguageMgr.GetTranslation("mopup.view.CampaignMopupPrepareFrame.CampaignMopupPrepareFrame.kingFreeTip");
         var _loc3_:String = "<font color=\'#06ff00\'><a href=\'event:clickLink\'><u>" + LanguageMgr.GetTranslation("mainBar.view.ChoosePayTypeFrame.openVipTxt") + "</u></a></font>";
         var _loc1_:String = LanguageMgr.GetTranslation("public.parentheses1",_loc3_);
         _kingFreeTxt.htmlText = _loc2_ + _loc1_;
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
         if(int(_mopupCountsTxt.text) == 0)
         {
            _loc2_ = LanguageMgr.GetTranslation("mopup.view.MazeMopupPrepareFrame.layerTipData1");
            MessageTipManager.instance().show(_loc2_);
            _mopupCountsTxt.text = inputMaxIndex;
            __textChangeHandler(null);
            return;
         }
         if(int(_mopupCountsTxt.text) < towerInfo.towerIndex)
         {
            _loc2_ = LanguageMgr.GetTranslation("mopup.view.MazeMopupPrepareFrame.layerTipData2");
            MessageTipManager.instance().show(_loc2_);
            _mopupCountsTxt.text = inputMaxIndex;
            __textChangeHandler(null);
            return;
         }
         if(int(_mopupCountsTxt.text) > int(inputMaxIndex))
         {
            _loc2_ = LanguageMgr.GetTranslation("mopup.view.MazeMopupPrepareFrame.layerTipData3");
            MessageTipManager.instance().show(_loc2_);
            _mopupCountsTxt.text = inputMaxIndex;
            __textChangeHandler(null);
            return;
         }
         if(int(_mopupGoldTxt.text) > ResourceManager.instance.gold.count)
         {
            _loc2_ = LanguageMgr.GetTranslation("mopup.MopupManager.mopupTipData02");
            MessageTipManager.instance().show(_loc2_);
            return;
         }
         _model.mopupLayer = int(_mopupCountsTxt.text);
         MopupManager.instance.sendMopupInfo(2,1,towerInfo.campaignId,0,_model.mopupLayer,_model.isDoubleProfit);
         _startMopupBtn.enable = false;
         dispose();
      }
      
      private function __textChangeHandler(param1:Event) : void
      {
         _mopupCountsNum = int(_mopupCountsTxt.text);
         _mopupCountsNum = _mopupCountsNum < 1 ? 1 : _mopupCountsNum;
         if(towerInfo.campaignId == 8001)
         {
            _mopupCountsNum = _mopupCountsNum > 100 ? 100 : _mopupCountsNum;
         }
         else
         {
            _mopupCountsNum = _mopupCountsNum > 30 ? 30 : _mopupCountsNum;
         }
         _mopupCountsTxt.text = String(_mopupCountsNum);
         if(towerInfo.towerIndex)
         {
            _mazeCounts = int(_mopupCountsTxt.text) - towerInfo.towerIndex + 1;
         }
         else
         {
            _mazeCounts = int(_mopupCountsTxt.text);
         }
         _mopupGoldTxt.text = String(_mazeCounts * _mazeCostGold);
         if(int(_mopupGoldTxt.text) < 0 || hasMopupBuff)
         {
            _mopupGoldTxt.text = "0";
         }
         if((int(_mopupCountsTxt.text) - towerInfo.towerIndex + 1) * _mazeTime < 0)
         {
            _mopupUseTimeTxt.text = DateFormatter.getConsortiaCountDate(0);
         }
         else
         {
            _mopupUseTimeTxt.text = DateFormatter.getConsortiaCountDate((int(_mopupCountsTxt.text) - towerInfo.towerIndex + 1) * _mazeTime);
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
      
      private function get hasMopupBuff() : Boolean
      {
         return false;
      }
      
      public function show(param1:Object) : void
      {
         if(param1)
         {
            if(int(param1) == 0)
            {
               titleText = LanguageMgr.GetTranslation("mopup.view.MazeMopupPrepareFrame.mopupTipTitle");
            }
            else if(int(param1) == 1)
            {
               titleText = LanguageMgr.GetTranslation("mopup.view.MazeMopupPrepareFrame.AbyssTitleText");
            }
         }
         LayerManager.Instance.addToLayer(this,3,true,true);
      }
      
      override public function get groups() : Array
      {
         return ["CASTLE_BUIDING_GROUP","BAG_GROUP"];
      }
      
      private function get towerInfo() : TowerInfo
      {
         return PlayerManager.instance.currentPlayerModel.towerInfo;
      }
      
      private function get _model() : MopupModel
      {
         return MopupManager.instance.model;
      }
      
      private function unint() : void
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
         unint();
         super.dispose();
      }
   }
}

