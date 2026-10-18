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
   import events.RemotePetEvent;
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
   import managers.RemotePetManager;
   import mvc.module.mopup.MopupModel;
   import mvc.module.remotepet.RemotePetModel;
   import ui.maintoolbar.MainToolBar;
   import ui.toptoolbar.TopToolsBar;
   import yishi.datas.goods.GoodsInfo;
   import yishi.datas.templates.GoodsTemplateInfo;
   import yishi.events.NotificationEvent;
   import yishi.keyboard.KeyBoardRegister;
   import yishi.manager.NotificationManager;
   import yishi.manager.TempleteManager;
   import yishi.utils.SimpleAlertHelper;
   import yishi.view.community.TimeDownView;
   import yishi.view.tips.MessageTipManager;
   
   public class RemoteMopupIngFrame extends Frame implements IManualSize
   {
      
      private static const MAZE_MOPUP:int = 2;
      
      private static const OPERATION_ACCELERATE:int = 2;
      
      private static const OPERATION_GET_RESULT:int = 3;
      
      private static const OPERATION_CANCEL:int = 4;
      
      private var _mopupCounts:Bitmap;
      
      private var _mopupRemainTime:Bitmap;
      
      private var _hadMopupHowCounts:Bitmap;
      
      private var _mopupBack0:Scale9CornerImage;
      
      private var _mopupBack1:Scale9CornerImage;
      
      private var _mopupBack2:ScaleBitmapImage;
      
      private var _hadMopupCountTxt:FilterFrameText;
      
      private var _remainTimeTxt:TimeDownView;
      
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
      
      public function RemoteMopupIngFrame()
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
         _mopupCounts = ComponentFactory.Instance.creatBitmap("asset.mopup.MopupTurns");
         _mopupRemainTime = ComponentFactory.Instance.creatBitmap("asset.mopup.MopupRemainTime");
         _hadMopupHowCounts = ComponentFactory.Instance.creatBitmap("asset.mopup.MopupHowTurns");
         _hadMopupCountTxt = ComponentFactory.Instance.creatComponentByStylename("mopup.HadMopupCountTxt");
         _remainTimeTxt = ComponentFactory.Instance.creatComponentByStylename("mopup.CampaignRemainTime");
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
         addToContent(_mopupCounts);
         addToContent(_mopupRemainTime);
         addToContent(_hadMopupHowCounts);
         addToContent(_hadMopupCountTxt);
         _hadMopupCountTxt.x = 405;
         _hadMopupCountTxt.text = "0";
         addToContent(_remainTimeTxt);
         _remainTimeTxt.x = 425;
         _remainTimeTxt.y = 60;
         _mopupGoodsLinkTxt.mouseEnabled = true;
         addToContent(_mopupGoodsLinkTxt);
         _mopupGoodsLinkTxt.htmlText = LanguageMgr.GetTranslation("map.campaign.view.ui.MazeView.fallItems");
         addToContent(_mopupAccelerateBtn);
         addToContent(_mopupCancelBtn);
         addToContent(_mopupEndBtn);
         _mopupEndBtn.visible = false;
         _mopupListScroll.setView(_mopupVBox);
         if(remoteModel.mopupCount == remoteModel.turnInfo.currTurn - 1)
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
         _model.isMopup = true;
         _goodsList = [];
         _goodsNameArr = [];
         _isRemoveLastLayer = false;
         _mazeCostTime = 30;
         _countTime = new Timer(5000);
         _countTime.addEventListener("timer",__timeCompleteHandler);
         _countTime.start();
         _remainTimeTxt.timeCount = (remoteModel.mopupCount - remoteModel.turnInfo.currTurn + 1) * _mazeCostTime;
         if(int(_remainTimeTxt.timeCount) < 0)
         {
            _remainTimeTxt.timeCount = 0;
         }
         _layerTxt = remoteModel.turnInfo.currTurn;
      }
      
      public function __refreshView(param1:RemotePetEvent) : void
      {
         var _loc6_:Array = null;
         var _loc4_:int = 0;
         var _loc5_:int = 0;
         var _loc2_:Array = null;
         _mopupVBox.removeAllChild();
         _mopupVBox.disposeAllChildren();
         _goodsList = [];
         _mopupVBox.beginChanges();
         if(int(_remainTimeTxt.timeCount) < 0)
         {
            _remainTimeTxt.timeCount = 0;
         }
         if(_currentBattleItem && _currentBattleItem.parent)
         {
            _currentBattleItem.parent.removeChild(_currentBattleItem);
         }
         for each(var _loc3_:Object in remoteModel.mopupList)
         {
            _loc6_ = _loc3_["items"].split("|");
            _resultItem = new Sprite();
            _mopupVBox.addChild(_resultItem);
            _resultTitle = ComponentFactory.Instance.creatComponentByStylename("mopup.MopupResultTitle");
            _resultItem.addChild(_resultTitle);
            _resultTitle.text = LanguageMgr.GetTranslation("mopup.view.RemoteMopupIngFrame.resultTitle",_loc3_["count"]);
            _layerTxt = _loc3_["count"] + 1;
            _loc4_ = 0;
            _gainGoodsTxt = ComponentFactory.Instance.creatComponentByStylename("mopup.MopupGainGoodsTxt");
            _gainGoodsTxt.y = 24;
            _resultItem.addChild(_gainGoodsTxt);
            _gainGoodsTxt.text = LanguageMgr.GetTranslation("mopup.view.MazeMopupIngFrame.gainGoodsTxt");
            _loc5_ = 0;
            while(_loc5_ < _loc6_.length)
            {
               _loc2_ = _loc6_[_loc5_].split(",");
               templateId = int(_loc2_[0]);
               goodsTemplateInfo = TempleteManager.instance.goodsTemplateCate.getTemplateByID(templateId);
               goodsInfo = new GoodsInfo();
               goodsInfo.templateId = templateId;
               goodsInfo.count = int(_loc2_[1]);
               _goodsList.push(goodsInfo);
               _colorString = goodsTemplateInfo.profileColor.toString(16);
               _goodsName = ComponentFactory.Instance.creatComponentByStylename("mopup.MopupgainGoodsItemTxt");
               _goodsName.y = 24;
               _goodsComponent = new Component();
               _resultItem.addChild(_goodsComponent);
               _goodsComponent.addChild(_goodsName);
               _goodsName.htmlText = "<font color=\'#" + _colorString + " \'>" + "[" + "<u><b>" + goodsTemplateInfo.TemplateName + "</b></u>" + "]" + "*" + goodsInfo.count + "</color>";
               _goodsName.y += _loc5_ * 20;
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
               _loc5_++;
            }
         }
         _currentBattleItem = new Sprite();
         _mopupVBox.addChild(_currentBattleItem);
         _currentBattleTitle = ComponentFactory.Instance.creatComponentByStylename("mopup.MopupResultTitle");
         _currentBattleItem.addChild(_currentBattleTitle);
         _currentBattleTitle.text = LanguageMgr.GetTranslation("mopup.view.RemoteMopupIngFrame.resultTitle",_layerTxt);
         _remainTimeTxt.timeCount = (remoteModel.mopupCount - _layerTxt + 1) * _mazeCostTime;
         _hadMopupCountTxt.text = (_layerTxt - 1).toString();
         _currentBattingTxt = ComponentFactory.Instance.creatComponentByStylename("mopup.MopupGainExpTxt");
         _currentBattleItem.addChild(_currentBattingTxt);
         _currentBattingTxt.text = LanguageMgr.GetTranslation("mopup.view.MazeMopupIngFrame.currentBattingTxt");
         _currentBattingTxt.width = 120;
         if(remoteModel.mopupCount == _layerTxt - 1)
         {
            _mopupVBox.removeChild(_currentBattleItem);
            _mopupVBox.addChild(_battleOver);
         }
         _mopupVBox.commitChanges();
         _mopupListScroll.invalidateViewport(true);
         __mopupEndHandler();
      }
      
      private function addEvent() : void
      {
         addEventListener("response",__frameResponse);
         _mopupAccelerateBtn.addEventListener("click",__accelerateHandler);
         _mopupCancelBtn.addEventListener("click",__cancelHandler);
         _mopupEndBtn.addEventListener("click",__cancelHandler);
         remoteModel.addEventListener("UPDATEMOPUP",__refreshView);
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
         remoteModel.removeEventListener("UPDATEMOPUP",__refreshView);
         _mopupGoodsLinkTxt.removeEventListener("link",__onLinkHandler);
         NotificationManager.instance.removeEventListener(NotificationEvent.HIDE_MOPUPING,_hide);
      }
      
      private function _hide(param1:NotificationEvent) : void
      {
         var _loc2_:Boolean = param1.data as Boolean;
         visible = !_loc2_;
      }
      
      private function __mopupEndHandler() : void
      {
         if(remoteModel.mopupCount == _layerTxt - 1)
         {
            _isEnd = true;
            _mopupAccelerateBtn.enable = false;
            _mopupCancelBtn.visible = false;
            _mopupEndBtn.visible = true;
            _remainTimeTxt.timeCount = 0;
            _countTime.stop();
         }
      }
      
      private function __accelerateHandler(param1:MouseEvent) : void
      {
         var _loc4_:int = 0;
         var _loc2_:String = null;
         var _loc3_:String = null;
         var _loc5_:String = null;
         var _loc6_:String = null;
         if(KingContractManager.Instance.checkHasBuffById(4))
         {
            RemotePetManager.sendMopupOP(8,1);
         }
         else
         {
            SoundManager.instance.play("022");
            _loc4_ = Math.ceil(_remainTimeTxt.timeCount / 60);
            SimpleAlertHelper.instance.data = [accelerateBack];
            _loc2_ = LanguageMgr.GetTranslation("public.confirm");
            _loc3_ = LanguageMgr.GetTranslation("public.cancel");
            _loc5_ = LanguageMgr.GetTranslation("public.prompt");
            _loc6_ = LanguageMgr.GetTranslation("mopup.view.MazeMopupIngFrame.AccelerateTip",_loc4_);
            SimpleAlertHelper.instance.popAlerFrame(_loc5_,_loc6_,_loc2_,_loc3_,true,false,false,2,"USEBINDPOINT_ALERT",0,"",null,"SimpleAlert",_loc4_);
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
               _loc4_ = 0;
               if(!param2)
               {
                  _loc4_ = 1;
               }
               RemotePetManager.sendMopupOP(8,_loc4_);
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
         RemotePetManager.sendMopupOP(10,0);
         _countTime.stop();
         _countTime = null;
         _countTime = new Timer(5000);
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
      
      private function get _model() : MopupModel
      {
         return MopupManager.instance.model;
      }
      
      private function get remoteModel() : RemotePetModel
      {
         return RemotePetManager.instance.model;
      }
      
      public function show(param1:Object = null) : void
      {
         titleText = LanguageMgr.GetTranslation("mopup.view.RemoteMopupPrepareFrame.TitleText");
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
         RemotePetManager.sendMopupOP(9,0);
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

