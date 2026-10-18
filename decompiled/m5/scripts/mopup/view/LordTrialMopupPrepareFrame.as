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
   import mvc.module.lordtrial.LordTrialModel;
   import yishi.datas.VersionSwitch;
   import yishi.datas.playerinfo.PlayerInfo;
   import yishi.manager.FrameControllerManager;
   import yishi.manager.LordTrialManager;
   import yishi.manager.NotificationManager;
   import yishi.manager.PlayerManager;
   import yishi.manager.ResourceManager;
   import yishi.manager.TempleteManager;
   import yishi.scene.SceneManager;
   import yishi.utils.DateFormatter;
   import yishi.view.tips.MessageTipManager;
   
   public class LordTrialMopupPrepareFrame extends Frame implements IManualSize
   {
      
      private var _mopupHowCounts:Bitmap;
      
      private var _mopupCounts:Bitmap;
      
      private var _mopupUseTime:Bitmap;
      
      private var _mopupNeedGold:Bitmap;
      
      private var _mopupGoldBack:Bitmap;
      
      private var _mopupNeedKeyBack:Bitmap;
      
      private var _mopupNeedKeyCount:Bitmap;
      
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
      
      private var _keyCountTxt:FilterFrameText;
      
      private var _startMopupBtn:IconButton;
      
      private var _mazeTime:int;
      
      private var _mazeCostGold:int;
      
      private var _mazeCounts:int;
      
      private var _inputMaxIndex:String;
      
      private var _mopupCountsNum:int;
      
      private var _currentIndex:int;
      
      public function LordTrialMopupPrepareFrame()
      {
         super();
         initView();
         addEvent();
         initData();
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
         _mopupHowCounts = ComponentFactory.Instance.creatBitmap("asset.mopup.MopupHowTurns");
         _mopupCounts = ComponentFactory.Instance.creatBitmap("asset.mopup.MopupTurns");
         _mopupUseTime = ComponentFactory.Instance.creatBitmap("asset.mopup.MopupUseTime");
         _mopupNeedGold = ComponentFactory.Instance.creatBitmap("asset.mopup.MopupNeedGold");
         _mopupGoldBack = ComponentFactory.Instance.creatBitmap("asset.mopup.MopupGoldTxt");
         _mopupNeedKeyBack = ComponentFactory.Instance.creatBitmap("asset.mopup.NeedKey");
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
         _keyCountTxt = ComponentFactory.Instance.creatComponentByStylename("mopup.mopupKeyTxt");
         _startMopupBtn = ComponentFactory.Instance.creatComponentByStylename("mopup.StartMopupBtn");
         addToContent(_mopupBack0);
         addToContent(_mopupBack1);
         addToContent(_mopupBack2);
         addToContent(_mopupInputBack);
         _mopupInputBack.x = 398;
         addToContent(_mopupHowCounts);
         addToContent(_mopupCounts);
         addToContent(_mopupUseTime);
         _mopupUseTime.y = 61;
         addToContent(_mopupNeedGold);
         _mopupNeedGold.y = 94;
         addToContent(_mopupGoldBack);
         _mopupGoldBack.y = 97;
         addToContent(_mopupNeedKeyBack);
         _mopupNeedKeyBack.x = 295;
         _mopupNeedKeyBack.y = 120;
         addToContent(_mopupCountsTxt);
         _mopupCountsTxt.x = 402;
         addToContent(_mopupUseTimeTxt);
         _mopupUseTimeTxt.y = 60;
         _mopupUseTimeTxt.x = 355;
         addToContent(_mopupGoldTxt);
         _mopupGoldTxt.y = 96;
         addToContent(_mopupTipTitle);
         _mopupTipTitle.text = LanguageMgr.GetTranslation("mopup.view.MazeMopupPrepareFrame.mopupTipTitle");
         addToContent(_mopupTipTxt);
         _mopupTipTxt.htmlText = LanguageMgr.GetTranslation("lordtrial.mopup.LordTrialMopupPrepareFrame.mopupTipTxt");
         addToContent(_startMopupBtn);
         _startMopupBtn.y = 150;
         addToContent(_keyCountTxt);
         _keyCountTxt.x = 425;
      }
      
      public function initData() : void
      {
         var _loc1_:String = null;
         var _loc2_:Array = null;
         titleText = LanguageMgr.GetTranslation("lordtrial.LordTrialMopupPrepareFrame.titleText");
         if(TempleteManager.instance.getConfigInfoByConfigName("lord_trial_sweep_templates"))
         {
            _loc1_ = TempleteManager.instance.getConfigInfoByConfigName("lord_trial_sweep_templates").ConfigValue;
            if(_loc1_)
            {
               _loc2_ = _loc1_.split(",");
               if(_loc2_)
               {
                  if(_loc2_[0])
                  {
                     _mazeTime = _loc2_[0];
                  }
                  if(_loc2_[1])
                  {
                     _mazeCostGold = _loc2_[1];
                  }
               }
            }
         }
         _inputMaxIndex = model.maxMopupIndex.toString();
         _currentIndex = playerInfo.currentIndex;
         _mopupCountsTxt.text = _inputMaxIndex;
         if(_currentIndex == 0)
         {
            _mazeCounts = int(_mopupCountsTxt.text);
         }
         else
         {
            _mazeCounts = int(_mopupCountsTxt.text) - _currentIndex + 1;
         }
         _mopupUseTimeTxt.text = DateFormatter.getConsortiaCountDate(_mazeCounts * _mazeTime);
         initGoldAndKeyTxt();
         var _loc4_:String = LanguageMgr.GetTranslation("lordtrial.mopup.LordTrialMopupPrepareFrame.kingFreeTip");
         var _loc5_:String = "<font color=\'#06ff00\'><a href=\'event:clickLink\'><u>" + LanguageMgr.GetTranslation("mainBar.view.ChoosePayTypeFrame.openVipTxt") + "</u></a></font>";
         var _loc3_:String = LanguageMgr.GetTranslation("public.parentheses1",_loc5_);
         _kingFreeTxt.htmlText = _loc4_ + _loc3_;
      }
      
      private function get playerInfo() : PlayerInfo
      {
         return PlayerManager.instance.currentPlayerModel.playerInfo;
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
      
      private function __frameResponse(param1:FrameEvent) : void
      {
         switch(int(param1.responseCode))
         {
            case 0:
            case 1:
               dispose();
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
            _mopupCountsTxt.text = _inputMaxIndex;
            __textChangeHandler(null);
            return;
         }
         if(int(_mopupCountsTxt.text) < _currentIndex)
         {
            _loc2_ = LanguageMgr.GetTranslation("mopup.view.MazeMopupPrepareFrame.layerTipData2");
            MessageTipManager.instance().show(_loc2_);
            _mopupCountsTxt.text = _inputMaxIndex;
            __textChangeHandler(null);
            return;
         }
         if(int(_mopupCountsTxt.text) > int(_inputMaxIndex))
         {
            _loc2_ = LanguageMgr.GetTranslation("mopup.view.MazeMopupPrepareFrame.layerTipData3");
            MessageTipManager.instance().show(_loc2_);
            _mopupCountsTxt.text = _inputMaxIndex;
            __textChangeHandler(null);
            return;
         }
         if(int(_mopupGoldTxt.text) > ResourceManager.instance.gold.count)
         {
            _loc2_ = LanguageMgr.GetTranslation("mopup.MopupManager.mopupTipData02");
            MessageTipManager.instance().show(_loc2_);
            return;
         }
         if(_mazeCounts > playerInfo.lordTrialKeyCount)
         {
            _loc2_ = LanguageMgr.GetTranslation("mopup.MopupManager.mopupTipData04");
            MessageTipManager.instance().show(_loc2_);
            return;
         }
         model.mopupList = [];
         LordTrialManager.sendMopup(model.currentType,int(_mopupCountsTxt.text));
         _startMopupBtn.enable = false;
         dispose();
      }
      
      private function __textChangeHandler(param1:Event) : void
      {
         _mopupCountsNum = int(_mopupCountsTxt.text);
         _mopupCountsNum = _mopupCountsNum > model.maxMopupIndex ? model.maxMopupIndex : _mopupCountsNum;
         _mopupCountsTxt.text = String(_mopupCountsNum);
         if(_currentIndex)
         {
            _mazeCounts = int(_mopupCountsTxt.text) - _currentIndex + 1;
         }
         else
         {
            _mazeCounts = int(_mopupCountsTxt.text);
         }
         initGoldAndKeyTxt();
         if(_mazeCounts < 0)
         {
            _mopupUseTimeTxt.text = DateFormatter.getConsortiaCountDate(0);
         }
         else
         {
            _mopupUseTimeTxt.text = DateFormatter.getConsortiaCountDate(_mazeCounts * _mazeTime);
         }
      }
      
      private function initGoldAndKeyTxt() : void
      {
         _mopupGoldTxt.text = String(_mazeCounts * _mazeCostGold);
         if(int(_mopupGoldTxt.text) < 0 || hasMopupBuff)
         {
            _mopupGoldTxt.text = "0";
         }
         if(int(_mopupGoldTxt.text) < 0)
         {
            _keyCountTxt.text = "0";
         }
         else
         {
            _keyCountTxt.text = _mazeCounts.toString();
         }
      }
      
      private function __updateKingContractHandler(param1:KingContractEvents) : void
      {
         if(hasMopupBuff)
         {
            _mopupGoldTxt.text = "0";
         }
      }
      
      private function get hasMopupBuff() : Boolean
      {
         return false;
      }
      
      public function show(param1:Object = null) : void
      {
         LayerManager.Instance.addToLayer(this,3,true,true);
      }
      
      override public function get groups() : Array
      {
         return ["CASTLE_BUIDING_GROUP","BAG_GROUP"];
      }
      
      private function get model() : LordTrialModel
      {
         return LordTrialManager.instance.model;
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
         ObjectUtils.disposeObject(_mopupNeedKeyBack);
         _mopupNeedKeyBack = null;
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
         ObjectUtils.disposeObject(_keyCountTxt);
         _keyCountTxt = null;
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

