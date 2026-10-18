package mopup.view
{
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.instance.IManualSize;
   import com.pickgliss.toplevel.StageReferance;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.ui.controls.IconButton;
   import com.pickgliss.ui.controls.ScrollPanel;
   import com.pickgliss.ui.controls.container.VBox;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.ui.image.Scale9CornerImage;
   import com.pickgliss.ui.image.ScaleBitmapImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import com.pickgliss.utils.SoundManager;
   import events.MopupEvent;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.events.TextEvent;
   import flash.events.TimerEvent;
   import flash.geom.Rectangle;
   import flash.utils.Timer;
   import mainBar.SmallMapBar;
   import manager.LanguageMgr;
   import managers.KingContractManager;
   import managers.MopupManager;
   import mvc.module.mopup.MopupModel;
   import ui.maintoolbar.MainToolBar;
   import ui.toptoolbar.TopToolsBar;
   import yishi.datas.goods.GoodsInfo;
   import yishi.datas.playerinfo.TowerInfo;
   import yishi.datas.templates.GoodsTemplateInfo;
   import yishi.events.NotificationEvent;
   import yishi.keyboard.KeyBoardRegister;
   import yishi.manager.NotificationManager;
   import yishi.manager.PlayerManager;
   import yishi.manager.TempleteManager;
   import yishi.utils.SimpleAlertHelper;
   import yishi.view.community.TimeDownView;
   import yishi.view.tips.MessageTipManager;
   
   public class MazeMopupIngFrame extends Frame implements IManualSize
   {
      
      private static const MAZE_MOPUP:int = 2;
      
      private static const OPERATION_ACCELERATE:int = 2;
      
      private static const OPERATION_GET_RESULT:int = 3;
      
      private static const OPERATION_CANCEL:int = 4;
      
      private var _mopupExp:Bitmap;
      
      private var _mopupCounts:Bitmap;
      
      private var _mopupRemainTime:Bitmap;
      
      private var _hadMopupHowCounts:Bitmap;
      
      private var _mopupBack0:Scale9CornerImage;
      
      private var _mopupBack1:Scale9CornerImage;
      
      private var _mopupBack2:ScaleBitmapImage;
      
      private var _hadMopupCountTxt:FilterFrameText;
      
      private var _remainTimeTxt:TimeDownView;
      
      private var _mopupExpTxt:FilterFrameText;
      
      private var _mopupGoodsLinkTxt:FilterFrameText;
      
      private var _mopupAccelerateBtn:IconButton;
      
      private var _mopupCancelBtn:IconButton;
      
      private var _mopupEndBtn:IconButton;
      
      private var _mopupListScroll:ScrollPanel;
      
      private var _mopupVBox:VBox;
      
      private var _countTime:Timer;
      
      private var _goodsList:Array;
      
      private var _goodsNameArr:Array;
      
      private var _layerTxt:int;
      
      private var _mazeCostTime:int;
      
      private var _isRemoveLastLayer:Boolean;
      
      private var _isEnd:Boolean;
      
      private var mopupGoodsFrame:MopupGainGoodsFrame;
      
      private var _resultItem:Sprite;
      
      private var _resultTitle:FilterFrameText;
      
      private var _gainExpTxt:FilterFrameText;
      
      private var _gainExpCountsTxt:FilterFrameText;
      
      private var _gainGoodsTxt:FilterFrameText;
      
      private var templateId:int;
      
      private var goodsTemplateInfo:GoodsTemplateInfo;
      
      private var goodsInfo:GoodsInfo;
      
      private var _colorString:String;
      
      private var _goodsName:FilterFrameText;
      
      private var _goodsComponent:Component;
      
      private var _currentBattleItem:Sprite;
      
      private var _currentBattleTitle:FilterFrameText;
      
      private var _currentBattingTxt:FilterFrameText;
      
      private var _battleOver:Bitmap;
      
      private var _battleBreak:Bitmap;
      
      public function MazeMopupIngFrame()
      {
         super();
         initView();
         addEvent();
         initData();
         __refreshView(null);
      }
      
      public function get viewRectangle() : Rectangle
      {
         return new Rectangle(0,0,542,315);
      }
      
      private function initView() : void
      {
         _mopupExp = ComponentFactory.Instance.creatBitmap("asset.mopup.MopupExp");
         _mopupCounts = ComponentFactory.Instance.creatBitmap("asset.mopup.MopupLayers");
         _mopupRemainTime = ComponentFactory.Instance.creatBitmap("asset.mopup.MopupRemainTime");
         _hadMopupHowCounts = ComponentFactory.Instance.creatBitmap("asset.mopup.HadMopupHowLayers");
         _hadMopupCountTxt = ComponentFactory.Instance.creatComponentByStylename("mopup.HadMopupCountTxt");
         _remainTimeTxt = ComponentFactory.Instance.creatComponentByStylename("mopup.CampaignRemainTime");
         _mopupExpTxt = ComponentFactory.Instance.creatComponentByStylename("mopup.MopupExpTxt");
         _mopupGoodsLinkTxt = ComponentFactory.Instance.creatComponentByStylename("mopup.MopupGoodsLinkTxt");
         _mopupAccelerateBtn = ComponentFactory.Instance.creatComponentByStylename("mopup.MopupAccelerateBtn");
         _mopupCancelBtn = ComponentFactory.Instance.creatComponentByStylename("mopup.MopupCancelBtn");
         _mopupEndBtn = ComponentFactory.Instance.creatComponentByStylename("mopup.MopupEndBtn");
         _mopupListScroll = ComponentFactory.Instance.creatComponentByStylename("mopup.MopupListScrollPanel");
         _mopupVBox = ComponentFactory.Instance.creatComponentByStylename("mopup.MopupListVbox");
         _mopupBack0 = ComponentFactory.Instance.creatComponentByStylename("mopup.MopupBack0");
         _mopupBack1 = ComponentFactory.Instance.creatComponentByStylename("mopup.MopupBack1");
         _mopupBack2 = ComponentFactory.Instance.creatComponentByStylename("mopup.MopupBack2");
         _battleOver = ComponentFactory.Instance.creatBitmap("asset.mopup.BattleOverTxt");
         _battleBreak = ComponentFactory.Instance.creatBitmap("asset.mopup.BattleBreakTxt");
         addToContent(_mopupBack0);
         addToContent(_mopupBack1);
         addToContent(_mopupBack2);
         addToContent(_mopupListScroll);
         addToContent(_mopupExp);
         addToContent(_mopupCounts);
         addToContent(_mopupRemainTime);
         addToContent(_hadMopupHowCounts);
         addToContent(_hadMopupCountTxt);
         _hadMopupCountTxt.x = 410;
         _hadMopupCountTxt.y = 25;
         addToContent(_remainTimeTxt);
         _remainTimeTxt.x = 425;
         _remainTimeTxt.y = 59;
         addToContent(_mopupExpTxt);
         _mopupExpTxt.text = "0";
         _mopupExpTxt.x = 375;
         _mopupExpTxt.y = 94;
         _mopupGoodsLinkTxt.mouseEnabled = true;
         addToContent(_mopupGoodsLinkTxt);
         _mopupGoodsLinkTxt.htmlText = LanguageMgr.GetTranslation("map.campaign.view.ui.MazeView.fallItems");
         addToContent(_mopupAccelerateBtn);
         addToContent(_mopupCancelBtn);
         addToContent(_mopupEndBtn);
         _mopupEndBtn.visible = false;
         _mopupListScroll.setView(_mopupVBox);
         if(_model.mopupEnd)
         {
            _mopupAccelerateBtn.enable = false;
            _mopupCancelBtn.visible = false;
            _mopupEndBtn.visible = true;
            _isEnd = true;
         }
         MainToolBar.instance.mopupIng();
         SmallMapBar.instance.mopupIng();
         TopToolsBar.instance.mopupIng();
         KeyBoardRegister.instance.keyEnable = false;
      }
      
      public function initData() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         _model.isMopup = true;
         if(towerInfo.campaignId == 8101 || _model.campaignId == 8101)
         {
            titleText = LanguageMgr.GetTranslation("mopup.view.MazeMopupPrepareFrame.AbyssTitleText");
         }
         else if(towerInfo.campaignId == 8001 || _model.campaignId == 8001)
         {
            titleText = LanguageMgr.GetTranslation("mopup.view.MazeMopupPrepareFrame.titleText");
         }
         _goodsList = [];
         _goodsNameArr = [];
         if(towerInfo.towerIndex == 0)
         {
            _layerTxt = 1;
            _hadMopupCountTxt.text = String(towerInfo.towerIndex);
         }
         else
         {
            _layerTxt = towerInfo.towerIndex;
            _hadMopupCountTxt.text = String(towerInfo.towerIndex - 1);
         }
         _isRemoveLastLayer = false;
         _mazeCostTime = int(TempleteManager.instance.getConfigInfoByConfigName("Tower_Sweep_Time").ConfigValue);
         if(_model.mopupRemainTime)
         {
            _loc1_ = _model.mopupRemainTime - int(_model.mopupRemainTime / _mazeCostTime) * _mazeCostTime;
            _countTime = new Timer(_loc1_ * 1000);
         }
         else
         {
            _countTime = new Timer(_mazeCostTime * 1000);
         }
         _countTime.addEventListener("timer",__timeCompleteHandler);
         _countTime.start();
         if(_model.mopupRemainTime)
         {
            _remainTimeTxt.timeCount = _model.mopupRemainTime;
         }
         else
         {
            _remainTimeTxt.timeCount = (_model.mopupLayer - towerInfo.towerIndex + 1) * _mazeCostTime;
         }
         if(int(_remainTimeTxt.timeCount) < 0)
         {
            _remainTimeTxt.timeCount = 0;
         }
         if(_model.mopupGoods)
         {
            _loc2_ = 0;
            while(_loc2_ < _model.mopupGoods.length)
            {
               templateId = _model.mopupGoods[_loc2_].templateId;
               goodsTemplateInfo = TempleteManager.instance.goodsTemplateCate.getTemplateByID(templateId);
               goodsInfo = new GoodsInfo();
               goodsInfo.templateId = templateId;
               goodsInfo.count = _model.mopupGoods[_loc2_].count;
               _goodsList.push(goodsInfo);
               _loc2_++;
            }
         }
      }
      
      public function __refreshView(param1:MopupEvent) : void
      {
         var _loc3_:int = 0;
         var _loc2_:int = 0;
         var _loc4_:int = 0;
         _mopupVBox.beginChanges();
         if(_model.mopupExt)
         {
            _mopupExpTxt.text = String(_model.mopupExt);
         }
         if(_model.mopupRemainTime)
         {
            _remainTimeTxt.timeCount = _model.mopupRemainTime;
         }
         else if(_model.mopupEnd)
         {
            _remainTimeTxt.timeCount = 0;
         }
         if(_currentBattleItem && _currentBattleItem.parent)
         {
            _currentBattleItem.parent.removeChild(_currentBattleItem);
         }
         if(_model.resultInfoList)
         {
            _loc3_ = 0;
            while(_loc3_ < _model.resultInfoList.length)
            {
               if(_model.resultInfoList[_loc3_].type == 1)
               {
                  _resultItem = new Sprite();
                  _mopupVBox.addChild(_resultItem);
                  _resultTitle = ComponentFactory.Instance.creatComponentByStylename("mopup.MopupResultTitle");
                  _resultItem.addChild(_resultTitle);
                  _resultTitle.text = LanguageMgr.GetTranslation("mopup.view.MazeMopupIngFrame.resultTitle",String(_model.resultInfoList[_loc3_].cIndex));
                  _gainExpTxt = ComponentFactory.Instance.creatComponentByStylename("mopup.MopupGainExpTxt");
                  _resultItem.addChild(_gainExpTxt);
                  _gainExpTxt.text = LanguageMgr.GetTranslation("mopup.view.MazeMopupIngFrame.gainExpTxt");
                  _gainExpCountsTxt = ComponentFactory.Instance.creatComponentByStylename("mopup.MopupGainExpCountsTxt");
                  _resultItem.addChild(_gainExpCountsTxt);
                  _gainExpCountsTxt.text = _model.resultInfoList[_loc3_].gp;
                  _loc2_ = 0;
                  if(_model.resultInfoList[_loc3_].items.length > 0)
                  {
                     _gainGoodsTxt = ComponentFactory.Instance.creatComponentByStylename("mopup.MopupGainGoodsTxt");
                     _resultItem.addChild(_gainGoodsTxt);
                     _gainGoodsTxt.text = LanguageMgr.GetTranslation("mopup.view.MazeMopupIngFrame.gainGoodsTxt");
                     _loc4_ = 0;
                     while(_loc4_ < _model.resultInfoList[_loc3_].items.length)
                     {
                        templateId = _model.resultInfoList[_loc3_].items[_loc4_].templateId;
                        goodsTemplateInfo = TempleteManager.instance.goodsTemplateCate.getTemplateByID(templateId);
                        goodsInfo = new GoodsInfo();
                        goodsInfo.templateId = templateId;
                        goodsInfo.count = _model.resultInfoList[_loc3_].items[_loc4_].count;
                        _goodsList.push(goodsInfo);
                        _colorString = goodsTemplateInfo.profileColor.toString(16);
                        _goodsName = ComponentFactory.Instance.creatComponentByStylename("mopup.MopupgainGoodsItemTxt");
                        _goodsComponent = new Component();
                        _resultItem.addChild(_goodsComponent);
                        _goodsComponent.addChild(_goodsName);
                        _goodsName.htmlText = "<font color=\'#" + _colorString + " \'>" + "[" + "<u><b>" + goodsTemplateInfo.TemplateName + "</b></u>" + "]" + "*" + goodsInfo.count + "</color>";
                        _goodsName.y += _loc4_ * 20;
                        _goodsNameArr.push(_goodsComponent);
                        if(goodsTemplateInfo.MasterType == 1 || goodsTemplateInfo.MasterType == 3)
                        {
                           _goodsComponent.tipStyle = "yishi.view.tips.goods.EquipContrastTips";
                        }
                        else
                        {
                           _goodsComponent.tipStyle = "yishi.view.tips.goods.PropTips";
                        }
                        _goodsComponent.tipData = goodsInfo;
                        _loc4_++;
                     }
                  }
                  _layerTxt = _model.resultInfoList[_loc3_].cIndex + 1;
                  _hadMopupCountTxt.text = String(_model.resultInfoList[_loc3_].cIndex);
               }
               else
               {
                  _layerTxt = _model.resultInfoList[_loc3_].cIndex;
                  _hadMopupCountTxt.text = String(_model.resultInfoList[_loc3_].cIndex - 1);
               }
               if(_model.resultInfoList[_loc3_].cIndex == _model.resultInfoList[_loc3_].eIndex && _model.resultInfoList[_loc3_].cIndex != 0 || _model.mopupEnd == true)
               {
                  _isRemoveLastLayer = true;
               }
               _loc3_++;
            }
         }
         _currentBattleItem = new Sprite();
         _mopupVBox.addChild(_currentBattleItem);
         _currentBattleTitle = ComponentFactory.Instance.creatComponentByStylename("mopup.MopupResultTitle");
         _currentBattleItem.addChild(_currentBattleTitle);
         _currentBattleTitle.text = LanguageMgr.GetTranslation("mopup.view.MazeMopupIngFrame.resultTitle",String(_layerTxt));
         _currentBattingTxt = ComponentFactory.Instance.creatComponentByStylename("mopup.MopupGainExpTxt");
         _currentBattleItem.addChild(_currentBattingTxt);
         _currentBattingTxt.text = LanguageMgr.GetTranslation("mopup.view.MazeMopupIngFrame.currentBattingTxt");
         _currentBattingTxt.width = 120;
         if(_isRemoveLastLayer)
         {
            _mopupVBox.removeChild(_currentBattleItem);
            if(_model.isNormalEnd)
            {
               _mopupVBox.addChild(_battleOver);
            }
            else
            {
               _mopupVBox.addChild(_battleBreak);
            }
         }
         _mopupVBox.commitChanges();
         _mopupListScroll.invalidateViewport(true);
      }
      
      private function addEvent() : void
      {
         addEventListener("response",__frameResponse);
         _mopupAccelerateBtn.addEventListener("click",__accelerateHandler);
         _mopupCancelBtn.addEventListener("click",__cancelHandler);
         _mopupEndBtn.addEventListener("click",__cancelHandler);
         _model.addEventListener("MOPUP_RESULT_LIST_REFRESH",__refreshView);
         _model.addEventListener("MOPUP_END",__mopupEndHandler);
         _mopupGoodsLinkTxt.addEventListener("link",__onLinkHandler);
         NotificationManager.instance.addEventListener(NotificationEvent.HIDE_MOPUPING,_hide);
      }
      
      private function removeEvent() : void
      {
         removeEventListener("response",__frameResponse);
         _mopupAccelerateBtn.removeEventListener("click",__accelerateHandler);
         _mopupCancelBtn.removeEventListener("click",__cancelHandler);
         _mopupEndBtn.removeEventListener("click",__cancelHandler);
         _countTime.removeEventListener("timer",__timeCompleteHandler);
         _model.removeEventListener("MOPUP_RESULT_LIST_REFRESH",__refreshView);
         _model.removeEventListener("MOPUP_END",__mopupEndHandler);
         _mopupGoodsLinkTxt.removeEventListener("link",__onLinkHandler);
         NotificationManager.instance.removeEventListener(NotificationEvent.HIDE_MOPUPING,_hide);
      }
      
      private function _hide(param1:NotificationEvent) : void
      {
         var _loc2_:Boolean = param1.data as Boolean;
         visible = !_loc2_;
      }
      
      private function __mopupEndHandler(param1:MopupEvent) : void
      {
         _isEnd = true;
         _mopupAccelerateBtn.enable = false;
         _mopupCancelBtn.visible = false;
         _mopupEndBtn.visible = true;
         _remainTimeTxt.timeCount = 0;
         _countTime.stop();
      }
      
      private function __accelerateHandler(param1:MouseEvent) : void
      {
         var _loc6_:Array = null;
         var _loc4_:int = 0;
         var _loc2_:String = null;
         var _loc3_:String = null;
         var _loc5_:String = null;
         var _loc7_:String = null;
         if(KingContractManager.Instance.checkHasBuffById(4))
         {
            MopupManager.instance.sendMopupInfo(2,2,0,0,0,1,false,false);
         }
         else
         {
            SoundManager.instance.play("022");
            _loc6_ = TempleteManager.instance.getConfigInfoByConfigName("Sweep_Fast").ConfigValue.split(",");
            _loc4_ = int(Math.ceil(_remainTimeTxt.timeCount / (60 * _loc6_[1]))) * _loc6_[0];
            SimpleAlertHelper.instance.data = [accelerateBack];
            _loc2_ = LanguageMgr.GetTranslation("public.confirm");
            _loc3_ = LanguageMgr.GetTranslation("public.cancel");
            _loc5_ = LanguageMgr.GetTranslation("public.prompt");
            _loc7_ = LanguageMgr.GetTranslation("mopup.view.MazeMopupIngFrame.AccelerateTip",_loc4_);
            SimpleAlertHelper.instance.popAlerFrame(_loc5_,_loc7_,_loc2_,_loc3_,true,false,false,2,"USEBINDPOINT_ALERT",0,"",null,"SimpleAlert",_loc4_);
         }
      }
      
      private function accelerateBack(param1:Boolean, param2:Boolean) : void
      {
         var _loc3_:String = null;
         var _loc4_:int = 0;
         if(param1)
         {
            if(_isEnd)
            {
               _loc3_ = LanguageMgr.GetTranslation("mopup.view.MazeMopupIngFrame.mopupEnd");
               MessageTipManager.instance().show(_loc3_);
            }
            else
            {
               _loc4_ = 2;
               if(!param2)
               {
                  _loc4_ = 1;
               }
               MopupManager.instance.sendMopupInfo(2,2,0,0,0,1,false,false,_loc4_);
            }
         }
      }
      
      private function __cancelHandler(param1:MouseEvent) : void
      {
         if(!_isEnd)
         {
            useAlertDispose();
         }
         else
         {
            dispose();
         }
      }
      
      private function __timeCompleteHandler(param1:TimerEvent) : void
      {
         _countTime.removeEventListener("timerComplete",__timeCompleteHandler);
         MopupManager.instance.sendMopupInfo(2,3);
         _countTime.stop();
         _countTime = null;
         _countTime = new Timer(_mazeCostTime * 1000);
         _countTime.reset();
         _countTime.addEventListener("timer",__timeCompleteHandler);
         _countTime.start();
      }
      
      private function __onLinkHandler(param1:TextEvent) : void
      {
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         SoundManager.instance.play("022");
         mopupGoodsFrame = ComponentFactory.Instance.creatComponentByStylename("mopup.view.MopupGainGoodsFrame");
         _loc2_ = 0;
         while(_loc2_ < _goodsList.length)
         {
            _loc3_ = _loc2_ + 1;
            while(_loc3_ < _goodsList.length)
            {
               if(_goodsList[_loc2_].templateId == _goodsList[_loc3_].templateId)
               {
                  _goodsList[_loc2_].count += _goodsList[_loc3_].count;
                  _goodsList.splice(_loc3_,1);
                  _loc3_--;
               }
               _loc3_++;
            }
            _loc2_++;
         }
         mopupGoodsFrame.data = _goodsList;
         mopupGoodsFrame.show(this);
         StageReferance.stage.focus = mopupGoodsFrame;
      }
      
      private function __frameResponse(param1:FrameEvent) : void
      {
         switch(int(param1.responseCode))
         {
            case 0:
            case 1:
               if(!_isEnd)
               {
                  useAlertDispose();
                  break;
               }
               dispose();
         }
      }
      
      private function useAlertDispose() : void
      {
         SimpleAlertHelper.instance.data = [disposeBack];
         var _loc1_:String = LanguageMgr.GetTranslation("public.confirm");
         var _loc2_:String = LanguageMgr.GetTranslation("public.cancel");
         var _loc3_:String = LanguageMgr.GetTranslation("public.prompt");
         var _loc4_:String = LanguageMgr.GetTranslation("mopup.view.MazeMopupIngFrame.alertContent");
         SimpleAlertHelper.instance.popAlerFrame(_loc3_,_loc4_,_loc1_,_loc2_,true);
      }
      
      private function disposeBack(param1:Boolean, param2:Boolean) : void
      {
         if(param1)
         {
            dispose();
         }
      }
      
      private function get towerInfo() : TowerInfo
      {
         return PlayerManager.instance.currentPlayerModel.towerInfo;
      }
      
      private function get _model() : MopupModel
      {
         return MopupManager.instance.model;
      }
      
      public function show(param1:Object = null) : void
      {
         LayerManager.Instance.addToLayer(this,3,true,true,0,0,true);
      }
      
      override public function get groups() : Array
      {
         return ["MOPUP"];
      }
      
      private function uninit() : void
      {
         ObjectUtils.disposeAllChildren(this);
         if(_goodsNameArr.length > 0)
         {
            for each(var _loc1_:Component in _goodsNameArr)
            {
               ObjectUtils.disposeObject(_loc1_);
               _loc1_ = null;
            }
         }
         _goodsList = null;
         _model.resultInfoList = null;
         _model.mopupExt = 0;
         _model.mopupRemainTime = 0;
         _model.mopupEnd = false;
         _model.mopupGoods = null;
         ObjectUtils.disposeObject(_mopupExp);
         _mopupExp = null;
         ObjectUtils.disposeObject(_mopupCounts);
         _mopupCounts = null;
         ObjectUtils.disposeObject(_mopupRemainTime);
         _mopupRemainTime = null;
         ObjectUtils.disposeObject(_hadMopupHowCounts);
         _hadMopupHowCounts = null;
         ObjectUtils.disposeObject(_mopupBack0);
         _mopupBack0 = null;
         ObjectUtils.disposeObject(_mopupBack1);
         _mopupBack1 = null;
         ObjectUtils.disposeObject(_mopupBack2);
         _mopupBack2 = null;
         ObjectUtils.disposeObject(_hadMopupCountTxt);
         _hadMopupCountTxt = null;
         ObjectUtils.disposeObject(_remainTimeTxt);
         _remainTimeTxt = null;
         ObjectUtils.disposeObject(_mopupExpTxt);
         _mopupExpTxt = null;
         ObjectUtils.disposeObject(_mopupGoodsLinkTxt);
         _mopupGoodsLinkTxt = null;
         ObjectUtils.disposeObject(_mopupAccelerateBtn);
         _mopupAccelerateBtn = null;
         ObjectUtils.disposeObject(_mopupCancelBtn);
         _mopupCancelBtn = null;
         ObjectUtils.disposeObject(_mopupEndBtn);
         _mopupEndBtn = null;
         ObjectUtils.disposeObject(_mopupListScroll);
         _mopupListScroll = null;
         if(_mopupVBox)
         {
            _mopupVBox.removeAllChild();
            ObjectUtils.disposeObject(_mopupVBox);
            _mopupVBox = null;
         }
         ObjectUtils.disposeObject(_countTime);
         _countTime = null;
         ObjectUtils.disposeObject(_currentBattleItem);
         _currentBattleItem = null;
         ObjectUtils.disposeObject(_battleOver);
         _battleOver = null;
         ObjectUtils.disposeObject(_battleBreak);
         _battleBreak = null;
         ObjectUtils.disposeAllChildren(this);
      }
      
      override public function dispose() : void
      {
         MopupManager.instance.sendMopupInfo(2,4);
         _model.isMopup = false;
         MainToolBar.instance.mopupEnd();
         SmallMapBar.instance.mopupEnd();
         TopToolsBar.instance.mopupEnd();
         KeyBoardRegister.instance.keyEnable = true;
         _countTime.stop();
         removeEvent();
         uninit();
         super.dispose();
      }
   }
}

