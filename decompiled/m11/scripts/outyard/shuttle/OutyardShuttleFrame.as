package outyard.shuttle
{
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.BaseButton;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.ui.controls.IconButton;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import com.pickgliss.utils.SoundManager;
   import com.road.yishi.proto.shuttle.ArcaneZoneMsg;
   import com.road.yishi.proto.shuttle.ShuttleInfoMsg;
   import flash.display.Bitmap;
   import flash.display.BitmapData;
   import flash.display.MovieClip;
   import flash.events.MouseEvent;
   import manager.LanguageMgr;
   import managers.MagicSpringManager;
   import mvc.module.magicspring.MagicSpringSlotInfo;
   import utils.LogicUtils;
   import yishi.datas.ConfigInfoManager;
   import yishi.events.NotificationEvent;
   import yishi.manager.FrameControllerManager;
   import yishi.manager.NotificationManager;
   import yishi.manager.OutyardManager;
   import yishi.manager.PlayerManager;
   import yishi.manager.RechargeAlertMannager;
   import yishi.manager.SharedManagerHelper;
   import yishi.utils.NumberViewUtils;
   import yishi.view.community.MagicSpringBufferAddView;
   import yishi.view.frame.SimpleHelpFrame;
   import yishi.view.tips.MessageTipManager;
   
   public class OutyardShuttleFrame extends Frame
   {
      
      private var _titleBmp:Bitmap;
      
      private var _levelItem1:OutyardLevelItem;
      
      private var _levelItem2:OutyardLevelItem;
      
      private var _levelItem3:OutyardLevelItem;
      
      private var _levelItem4:OutyardLevelItem;
      
      private var _progressView:OutyardProgressView;
      
      private var _petHeadList:ShuttlePetHeadListView;
      
      private var _forbiddenBmp:MovieClip;
      
      private var _forbiddenTxt:Bitmap;
      
      private var _bossNumBmp:Bitmap;
      
      private var _bossTxt:FilterFrameText;
      
      private var _forbiddenContain:Component;
      
      private var _scoreTxt:FilterFrameText;
      
      private var _resetBtn:IconButton;
      
      private var _refreshBtn:IconButton;
      
      private var _receiveBtn:IconButton;
      
      private var _scoreNote:Bitmap;
      
      private var _stoneBmp1:Bitmap;
      
      private var _stoneBmp2:Bitmap;
      
      private var _stoneTxt1:FilterFrameText;
      
      private var _stoneTxt2:FilterFrameText;
      
      private var _leftBmp1:Bitmap;
      
      private var _leftBmp2:Bitmap;
      
      private var _numberAsset:BitmapData;
      
      private var _container1:Component;
      
      private var _container2:Component;
      
      private var _helpBtn:BaseButton;
      
      private var _itemPosArr:Array = [[157,245],[304,336],[292,161],[433,252],[570,329],[713,328],[850,327]];
      
      private var _goodList:Array;
      
      private var freeCount:int;
      
      private var resetArr:Array;
      
      private var refreshArr:Array;
      
      private var resetNeedStone:int;
      
      private var resetLeftCount:int;
      
      private var _freshNoteTxt:FilterFrameText;
      
      private var _bufferView:MagicSpringBufferAddView;
      
      public function OutyardShuttleFrame()
      {
         super();
         initView();
         addEvent();
         OutyardManager.instance.OperateShuttle(1);
      }
      
      override public function get groups() : Array
      {
         return ["MAIN_TOOLS_GROUP","BAG_GROUP"];
      }
      
      private function initView() : void
      {
         var _loc2_:int = 0;
         var _loc1_:OutyardShuttleItem = null;
         _titleBmp = ComponentFactory.Instance.creatBitmap("asset.outyard.shuttle.titleBmp");
         _levelItem1 = ComponentFactory.Instance.creatCustomObject("outyard.shuttle.OutyardLevelItem1");
         _levelItem2 = ComponentFactory.Instance.creatCustomObject("outyard.shuttle.OutyardLevelItem2");
         _levelItem3 = ComponentFactory.Instance.creatCustomObject("outyard.shuttle.OutyardLevelItem3");
         _levelItem4 = ComponentFactory.Instance.creatCustomObject("outyard.shuttle.OutyardLevelItem4");
         _progressView = ComponentFactory.Instance.creatCustomObject("outyard.shuttle.OutyardProgressView");
         _petHeadList = ComponentFactory.Instance.creatCustomObject("outyard.shuttle.ShuttlePetHeadListView");
         _forbiddenContain = ComponentFactory.Instance.creatCustomObject("outyard.shuttle.forbiddenContain");
         _forbiddenBmp = ComponentFactory.Instance.creatCustomObject("asset.outyard.shuttle.forbiddenBmp");
         _forbiddenTxt = ComponentFactory.Instance.creatBitmap("asset.outyard.shuttle.forbiddenTxt");
         _bossNumBmp = ComponentFactory.Instance.creatBitmap("asset.outyard.shuttle.bossNumBmp");
         _bossTxt = ComponentFactory.Instance.creatComponentByStylename("outyard.shuttle.shuttleBossTxt");
         _helpBtn = ComponentFactory.Instance.creatComponentByStylename("outyard.ShuttleHelpBtn");
         _scoreTxt = ComponentFactory.Instance.creatComponentByStylename("outyard.shuttle.shuttleScoreTxt");
         _resetBtn = ComponentFactory.Instance.creatComponentByStylename("outyard.shuttle.resetBtn");
         _refreshBtn = ComponentFactory.Instance.creatComponentByStylename("outyard.shuttle.refreshBtn");
         _receiveBtn = ComponentFactory.Instance.creatComponentByStylename("outyard.shuttle.receiveBtn");
         _scoreNote = ComponentFactory.Instance.creatBitmap("asset.outyard.shuttle.scoreBmp");
         _stoneBmp1 = ComponentFactory.Instance.creatBitmap("asset.core.SmallPointImg");
         _stoneBmp2 = ComponentFactory.Instance.creatBitmap("asset.core.SmallPointImg");
         _stoneTxt1 = ComponentFactory.Instance.creatComponentByStylename("outyard.shuttle.stoneTxt1");
         _stoneTxt2 = ComponentFactory.Instance.creatComponentByStylename("outyard.shuttle.stoneTxt2");
         _freshNoteTxt = ComponentFactory.Instance.creatComponentByStylename("outyard.shuttle.freshNoteTxt");
         _leftBmp1 = ComponentFactory.Instance.creatBitmap("asset.outyard.shuttle.leftBmp");
         _leftBmp1.x = 310;
         _leftBmp1.y = 614;
         _leftBmp2 = ComponentFactory.Instance.creatBitmap("asset.outyard.shuttle.leftBmp");
         _leftBmp2.x = 504;
         _leftBmp2.y = 614;
         _numberAsset = ComponentFactory.Instance.creatBitmapData("asset.outyard.shuttle.assetNumBmp");
         _container1 = new Component();
         _container1.x = 385;
         _container1.y = 616;
         _container2 = new Component();
         _container2.x = 573;
         _container2.y = 616;
         _container1.mouseEnabled = _container1.mouseChildren = false;
         _container2.mouseEnabled = _container2.mouseChildren = false;
         addToContent(_titleBmp);
         addToContent(_levelItem1);
         addToContent(_levelItem2);
         addToContent(_levelItem3);
         addToContent(_levelItem4);
         addToContent(_progressView);
         addToContent(_petHeadList);
         addToContent(_scoreTxt);
         addToContent(_resetBtn);
         addToContent(_refreshBtn);
         addToContent(_receiveBtn);
         addToContent(_leftBmp1);
         addToContent(_container1);
         addToContent(_leftBmp2);
         addToContent(_container2);
         addToContent(_scoreNote);
         addToContent(_stoneBmp1);
         _stoneBmp1.x = 353;
         _stoneBmp1.y = 644;
         addToContent(_stoneBmp2);
         _stoneBmp2.x = 548;
         _stoneBmp2.y = 644;
         addToContent(_stoneTxt1);
         addToContent(_stoneTxt2);
         addToContent(_helpBtn);
         addToContent(_freshNoteTxt);
         addToContent(_forbiddenContain);
         _forbiddenContain.addChild(_forbiddenBmp);
         _forbiddenContain.addChild(_forbiddenTxt);
         _forbiddenContain.addChild(_bossNumBmp);
         _forbiddenContain.addChild(_bossTxt);
         _forbiddenContain.buttonMode = true;
         _goodList = [];
         _loc2_ = 0;
         while(_loc2_ < 7)
         {
            _loc1_ = ComponentFactory.Instance.creatCustomObject("outyard.shuttle.OutyardShuttleItem");
            _loc1_.x = _itemPosArr[_loc2_][0];
            _loc1_.y = _itemPosArr[_loc2_][1];
            addToContent(_loc1_);
            _goodList.push(_loc1_);
            _loc2_++;
         }
         _levelItem1.index = 1;
         _levelItem2.index = 2;
         _levelItem3.index = 3;
         _levelItem4.index = 4;
         _refreshBtn.tipData = LanguageMgr.GetTranslation("outyard.OutyardShuttleView.refreshTips");
         _receiveBtn.tipData = LanguageMgr.GetTranslation("outyard.OutyardShuttleView.receiveTips");
         _forbiddenContain.tipData = LanguageMgr.GetTranslation("outyard.OutyardShuttleView.forbiddenTips");
         _freshNoteTxt.text = LanguageMgr.GetTranslation("outyard.OutyardShuttleView.freshNoteTips");
         freeCount = ConfigInfoManager.instance.getShuttleResetFree();
         resetArr = ConfigInfoManager.instance.getShuttleReset();
         refreshArr = ConfigInfoManager.instance.getShuttleRefresh();
         var _loc3_:MagicSpringSlotInfo = MagicSpringManager.instance.model.checkIsExistBuffer(16);
         if(_loc3_)
         {
            _bufferView = new MagicSpringBufferAddView(_loc3_);
            _bufferView.setDescText(_loc3_.tempInfo.Desc);
            _bufferView.x = 80;
            _bufferView.y = 600;
            addToContent(_bufferView);
         }
      }
      
      private function addEvent() : void
      {
         addEventListener("response",_frameResponse);
         _resetBtn.addEventListener("click",__restBtnClick);
         _refreshBtn.addEventListener("click",__refreshBtnClick);
         _receiveBtn.addEventListener("click",__receiveBtnClick);
         _forbiddenContain.addEventListener("click",__forbiddenBtnClick);
         _helpBtn.addEventListener("click",__helpClick);
         NotificationManager.instance.addEventListener("UPDATE_SHUTTLE_VIEW",__updateShuttleHandler);
         NotificationManager.instance.addEventListener("UPDATE_ARCANE_VIEW",__updateArcaneHandler);
         NotificationManager.instance.addEventListener("CLICK_SHUTTLE_VIEW",__shuttleClickHandler);
      }
      
      private function removeEvent() : void
      {
         removeEventListener("response",_frameResponse);
         _resetBtn.removeEventListener("click",__restBtnClick);
         _refreshBtn.removeEventListener("click",__refreshBtnClick);
         _receiveBtn.removeEventListener("click",__receiveBtnClick);
         _forbiddenContain.removeEventListener("click",__forbiddenBtnClick);
         _helpBtn.removeEventListener("click",__helpClick);
         NotificationManager.instance.removeEventListener("UPDATE_SHUTTLE_VIEW",__updateShuttleHandler);
         NotificationManager.instance.removeEventListener("UPDATE_ARCANE_VIEW",__updateArcaneHandler);
         NotificationManager.instance.removeEventListener("CLICK_SHUTTLE_VIEW",__shuttleClickHandler);
      }
      
      private function __shuttleClickHandler(param1:NotificationEvent) : void
      {
         var _loc3_:int = 0;
         var _loc2_:OutyardShuttleItem = null;
         _loc3_ = 0;
         while(_loc3_ < 7)
         {
            _loc2_ = _goodList[_loc3_];
            _loc2_.index = _loc3_ + 1;
            _loc3_++;
         }
         __updateShuttleHandler(null);
      }
      
      private function __updateArcaneHandler(param1:NotificationEvent) : void
      {
         var _loc2_:ArcaneZoneMsg = OutyardManager.instance.shuttleModel.arcaneMsg;
         _bossTxt.text = String(_loc2_.bossList.length);
         if(_loc2_.bossList.length > 0)
         {
            _forbiddenBmp.play();
         }
         else
         {
            _forbiddenBmp.gotoAndStop(1);
         }
      }
      
      private function __updateShuttleHandler(param1:NotificationEvent) : void
      {
         var _loc3_:int = 0;
         var _loc4_:OutyardShuttleItem = null;
         var _loc5_:int = 0;
         var _loc2_:ShuttleInfoMsg = OutyardManager.instance.shuttleModel.shuttleMsg;
         if(!_loc2_)
         {
            return;
         }
         _progressView.refreshView();
         _petHeadList.refreshView();
         _loc3_ = 1;
         while(_loc3_ <= 4)
         {
            this["_levelItem" + _loc3_].selected = false;
            if(this["_levelItem" + _loc3_].index == _loc2_.currentDifficulty)
            {
               this["_levelItem" + _loc3_].selected = true;
            }
            _loc3_++;
         }
         _loc5_ = 0;
         while(_loc5_ < 7)
         {
            _loc4_ = _goodList[_loc5_] as OutyardShuttleItem;
            _loc4_.leftCount = _loc2_.areaLeftCount[_loc5_ + 1];
            _loc5_++;
         }
         _bossTxt.text = String(_loc2_.arcaneZoneCount);
         _stoneTxt2.text = String(refreshArr[1]);
         _scoreTxt.text = _loc2_.shuttleScore + "/" + OutyardManager.instance.shuttleModel.maxShuttleScore;
         if(_loc2_.arcaneZoneCount > 0)
         {
            _forbiddenBmp.play();
         }
         else
         {
            _forbiddenBmp.gotoAndStop(1);
         }
         if(freeCount > _loc2_.resetCount)
         {
            resetNeedStone = 0;
            resetLeftCount = freeCount - _loc2_.resetCount;
            _resetBtn.tipData = LanguageMgr.GetTranslation("outyard.OutyardShuttleView.resetFree");
         }
         else
         {
            resetNeedStone = resetArr[1];
            resetLeftCount = resetArr[0] - (_loc2_.resetCount - freeCount);
            _resetBtn.tipData = LanguageMgr.GetTranslation("outyard.OutyardShuttleView.resetCost");
         }
         _stoneTxt1.text = String(resetNeedStone);
         NumberViewUtils.refreshValue(resetLeftCount,_container1,_numberAsset,17,21,11,17,"0123456789");
         NumberViewUtils.refreshValue(refreshArr[0] - _loc2_.refreshCount,_container2,_numberAsset,17,21,11,17,"0123456789");
         if(refreshArr[0] - _loc2_.refreshCount > 9)
         {
            _container2.x = 573;
         }
         else
         {
            _container2.x = 578;
         }
      }
      
      private function __restBtnClick(param1:MouseEvent) : void
      {
         SoundManager.instance.play("022");
         FrameControllerManager.instance.outyardControler.refreshBtnClick(0);
      }
      
      private function __refreshBtnClick(param1:MouseEvent) : void
      {
         SoundManager.instance.play("022");
         var _loc2_:ShuttleInfoMsg = OutyardManager.instance.shuttleModel.shuttleMsg;
         if(_loc2_.refreshCount >= refreshArr[0])
         {
            MessageTipManager.instance().show(LanguageMgr.GetTranslation("outyard.OutyardShuttleView.RefreshMax"));
            return;
         }
         SoundManager.instance.play("022");
         var _loc3_:String = LanguageMgr.GetTranslation("yishi.view.base.ThewAlertFrame.text");
         var _loc4_:String = LanguageMgr.GetTranslation("outyard.OutyardShuttleView.addRefreshTxt",refreshArr[1],1);
         SharedManagerHelper.ins.needAlert("outyard.OutyardShuttleView.RefreshAlert",payCallBack,_loc3_,_loc4_,"");
      }
      
      private function payCallBack(param1:Boolean) : void
      {
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         var _loc4_:int = int(refreshArr[1]);
         if(param1)
         {
            _loc2_ = int(PlayerManager.instance.currentPlayerModel.playerInfo.allPoint);
         }
         else
         {
            _loc2_ = int(PlayerManager.instance.currentPlayerModel.playerInfo.point);
         }
         if(_loc2_ >= _loc4_)
         {
            _loc3_ = param1 ? 2 : 1;
            OutyardManager.instance.OperateShuttle(7,0,0,0,0,null,_loc3_);
         }
         else
         {
            RechargeAlertMannager.show();
         }
      }
      
      public function __helpClick(param1:MouseEvent) : void
      {
         var _loc2_:SimpleHelpFrame = ComponentFactory.Instance.creatComponentByStylename("outyard.ShuttleHelpFrame");
         _loc2_.show();
      }
      
      private function __receiveBtnClick(param1:MouseEvent) : void
      {
         SoundManager.instance.play("022");
         OutyardManager.instance.OperateShuttle(9);
      }
      
      private function __forbiddenBtnClick(param1:MouseEvent) : void
      {
         SoundManager.instance.play("022");
         FrameControllerManager.instance.openControllerByInfo("outyard",5);
      }
      
      private function _frameResponse(param1:FrameEvent) : void
      {
         switch(int(param1.responseCode))
         {
            case 0:
            case 1:
               dispose();
         }
      }
      
      public function show() : void
      {
         LayerManager.Instance.addToLayer(this,3,true,true,1);
      }
      
      override public function dispose() : void
      {
         removeEvent();
         ObjectUtils.disposeObject(_titleBmp);
         _titleBmp = null;
         ObjectUtils.disposeObject(_levelItem1);
         _levelItem1 = null;
         ObjectUtils.disposeObject(_levelItem2);
         _levelItem2 = null;
         ObjectUtils.disposeObject(_levelItem3);
         _levelItem3 = null;
         ObjectUtils.disposeObject(_levelItem4);
         _levelItem4 = null;
         ObjectUtils.disposeObject(_progressView);
         _progressView = null;
         ObjectUtils.disposeObject(_petHeadList);
         _petHeadList = null;
         ObjectUtils.disposeViolentMc(_forbiddenBmp);
         _forbiddenBmp = null;
         ObjectUtils.disposeObject(_forbiddenTxt);
         _forbiddenTxt = null;
         ObjectUtils.disposeObject(_bossNumBmp);
         _bossNumBmp = null;
         ObjectUtils.disposeObject(_bossTxt);
         _bossTxt = null;
         ObjectUtils.disposeObject(_forbiddenContain);
         _forbiddenContain = null;
         ObjectUtils.disposeObject(_scoreTxt);
         _scoreTxt = null;
         ObjectUtils.disposeObject(_resetBtn);
         _resetBtn = null;
         ObjectUtils.disposeObject(_refreshBtn);
         _refreshBtn = null;
         ObjectUtils.disposeObject(_receiveBtn);
         _receiveBtn = null;
         ObjectUtils.disposeObject(_scoreNote);
         _scoreNote = null;
         ObjectUtils.disposeObject(_stoneBmp1);
         _stoneBmp1 = null;
         ObjectUtils.disposeObject(_stoneBmp2);
         _stoneBmp2 = null;
         ObjectUtils.disposeObject(_stoneTxt1);
         _stoneTxt1 = null;
         ObjectUtils.disposeObject(_stoneTxt2);
         _stoneTxt2 = null;
         ObjectUtils.disposeObject(_leftBmp1);
         _leftBmp1 = null;
         ObjectUtils.disposeObject(_leftBmp2);
         _leftBmp2 = null;
         ObjectUtils.disposeObject(_numberAsset);
         _numberAsset = null;
         ObjectUtils.disposeObject(_container1);
         _container1 = null;
         ObjectUtils.disposeObject(_container2);
         _container2 = null;
         ObjectUtils.disposeObject(_helpBtn);
         _helpBtn = null;
         ObjectUtils.disposeObject(_freshNoteTxt);
         _freshNoteTxt = null;
         LogicUtils.disposeDisplayCollection(_goodList);
         _goodList = null;
         ObjectUtils.disposeObject(_bufferView);
         _bufferView = null;
         _itemPosArr = null;
         resetArr = null;
         refreshArr = null;
         super.dispose();
      }
   }
}

