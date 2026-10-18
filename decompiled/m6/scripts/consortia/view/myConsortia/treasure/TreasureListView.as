package consortia.view.myConsortia.treasure
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.ScrollPanel;
   import com.pickgliss.ui.controls.TextButton;
   import com.pickgliss.ui.controls.container.VBox;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import com.pickgliss.utils.SoundManager;
   import consortia.net.ConsortiaSocektSendManager;
   import events.ConsortiaEvent;
   import flash.display.Bitmap;
   import flash.display.BitmapData;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import manager.LanguageMgr;
   import mvc.module.consortia.ConsortiaModel;
   import mvc.module.consortia.TreasureGroupInfo;
   import utils.LogicUtils;
   import yishi.datas.templates.ConsortiaTreasureTemplateInfo;
   import yishi.events.NotificationEvent;
   import yishi.manager.ConsortiaManager;
   import yishi.manager.FrameControllerManager;
   import yishi.manager.NotificationManager;
   import yishi.manager.PlayerManager;
   import yishi.manager.RechargeAlertMannager;
   import yishi.manager.SharedManagerHelper;
   import yishi.utils.NumberViewUtils;
   import yishi.utils.SimpleAlertHelper;
   import yishi.view.community.TimeDownView;
   import yishi.view.tips.MessageTipManager;
   
   public class TreasureListView extends Component
   {
      
      private var _TxtImg1:Bitmap;
      
      private var _ProgressBg:Bitmap;
      
      private var _Progress:Bitmap;
      
      private var _ProgressRec:Sprite;
      
      private var _ProgressTotal:Number;
      
      private var _ProgressMask:Bitmap;
      
      private var _RefreshBtn:TextButton;
      
      private var _Txt1:FilterFrameText;
      
      private var _NoListTxt:FilterFrameText;
      
      private var _CountdownTxt:FilterFrameText;
      
      private var _Countdown:TimeDownView;
      
      private var _ProgressTxt:FilterFrameText;
      
      private var _ProgressTimeDown:TimeDownView;
      
      private var _MiningTimeSprite:Sprite;
      
      private var _numBitmapData:BitmapData;
      
      private var _vbox:VBox;
      
      private var _scrollPanel:ScrollPanel;
      
      private var _ItemArr:Array;
      
      private var Times:int;
      
      private var haveBest:Boolean;
      
      public function TreasureListView()
      {
         super();
         initView();
         initEvent();
         ConsortiaSocektSendManager.sendOpenTreasure(0);
      }
      
      private function initView() : void
      {
         _TxtImg1 = ComponentFactory.Instance.creatBitmap("asset.consortia.TreasureListTxtImg1");
         _ProgressBg = ComponentFactory.Instance.creatBitmap("asset.consortia.TreasureListProgressBg");
         _Progress = ComponentFactory.Instance.creatBitmap("asset.consortia.TreasureListProgress");
         _ProgressRec = new Sprite();
         _ProgressRec.graphics.beginFill(16711680);
         _ProgressRec.graphics.drawRect(0,0,_Progress.width,_Progress.height);
         _ProgressMask = ComponentFactory.Instance.creatBitmap("asset.consortia.TreasureListProgressMask");
         _RefreshBtn = ComponentFactory.Instance.creatComponentByStylename("consortia.TreasureListRefreshBtn");
         _Txt1 = ComponentFactory.Instance.creatComponentByStylename("consortia.TreasureListTxt1");
         _NoListTxt = ComponentFactory.Instance.creatComponentByStylename("consortia.TreasureNoListTxt");
         _CountdownTxt = ComponentFactory.Instance.creatComponentByStylename("consortia.TreasureListCountdownTxt");
         _Countdown = ComponentFactory.Instance.creatComponentByStylename("consortia.TreasureListCountdown.TimeDown");
         _ProgressTxt = ComponentFactory.Instance.creatComponentByStylename("consortia.TreasureListProgressTxt");
         _ProgressTimeDown = ComponentFactory.Instance.creatComponentByStylename("consortia.TreasureListProgress.TimeDown");
         _MiningTimeSprite = ComponentFactory.Instance.creatCustomObject("consortia.Treasure.MiningTimeSprite");
         _numBitmapData = ComponentFactory.Instance.creatBitmapData("asset.consortia.MiningTime");
         _vbox = ComponentFactory.Instance.creatComponentByStylename("consortia.TreasureList.Vbox");
         _scrollPanel = ComponentFactory.Instance.creatComponentByStylename("consortia.TreasureListPanel");
         _scrollPanel.setView(_vbox);
         _ItemArr = [];
         addChild(_TxtImg1);
         addChild(_ProgressBg);
         addChild(_Progress);
         addChild(_ProgressMask);
         addChild(_ProgressRec);
         _ProgressRec.x = _Progress.x;
         _ProgressRec.y = _Progress.y;
         _Progress.mask = _ProgressRec;
         addChild(_RefreshBtn);
         addChild(_Txt1);
         addChild(_NoListTxt);
         addChild(_CountdownTxt);
         addChild(_Countdown);
         addChild(_ProgressTxt);
         addChild(_ProgressTimeDown);
         addChild(_MiningTimeSprite);
         addChild(_scrollPanel);
         _Txt1.text = LanguageMgr.GetTranslation("consortia.TreasureListTxt1Str");
         _NoListTxt.text = LanguageMgr.GetTranslation("consortia.TreasureNoListStr");
         _NoListTxt.visible = false;
         _CountdownTxt.text = LanguageMgr.GetTranslation("consortia.TreasureListCountdownStr");
         _ProgressTxt.text = LanguageMgr.GetTranslation("consortia.TreasureListProgressStr");
         _ProgressTxt.visible = false;
         _RefreshBtn.visible = false;
         _CountdownTxt.visible = false;
      }
      
      private function __updataListHandler(param1:ConsortiaEvent) : void
      {
         var _loc7_:Object = null;
         var _loc9_:TreasureListItem = null;
         var _loc5_:int = 0;
         var _loc6_:ConsortiaTreasureTemplateInfo = null;
         if(treasureGroupInfo.NoOpen)
         {
            _loc7_ = FrameControllerManager.instance["consortiaController"]["frame"];
            _loc7_.treasurePage.gotoFrame(0);
            _NoListTxt.visible = true;
            _NoListTxt.text = LanguageMgr.GetTranslation("consortia.TreasurNoOpen");
            return;
         }
         _ProgressTxt.visible = true;
         _RefreshBtn.visible = true;
         _CountdownTxt.visible = true;
         clearVox();
         var _loc2_:Date = PlayerManager.instance.currentPlayerModel.sysCurtime;
         var _loc8_:Number = _loc2_.hoursUTC % 2 * 60 * 60 + _loc2_.minutesUTC * 60 + _loc2_.secondsUTC;
         var _loc3_:Number = 7200 - _loc8_;
         _Countdown.timeCount = _loc3_;
         var _loc4_:Number = Number(PlayerManager.instance.currentPlayerModel.nowDate);
         _ProgressTotal = treasureGroupInfo.newFreeTime - _loc4_;
         _ProgressTimeDown.timeCount = Math.floor(_ProgressTotal / 1000) - 2;
         NumberViewUtils.refreshValue(treasureGroupInfo.leftCount,_MiningTimeSprite,_numBitmapData,16,20,16,16,"0123456789");
         Times = treasureGroupInfo.refreshTimes;
         if(Times >= model.refresh_costArr.length)
         {
            Times = model.refresh_costArr.length - 1;
         }
         if(model.refresh_costArr[Times] == 0)
         {
            _RefreshBtn.text = "";
            _RefreshBtn.backStyle = "consortia.TreasureListRefreshFreeBg";
         }
         else
         {
            _RefreshBtn.text = "" + model.refresh_costArr[Times];
            _RefreshBtn.backStyle = "consortia.TreasureListRefreshBg";
         }
         haveBest = false;
         _NoListTxt.visible = treasureGroupInfo.treasures.length <= 0;
         _loc5_ = 0;
         while(_loc5_ < model.treasureGroupInfo.treasures.length)
         {
            _loc9_ = new TreasureListItem();
            _loc9_.data = treasureGroupInfo.treasures[_loc5_];
            _vbox.addChild(_loc9_);
            _ItemArr.push(_loc9_);
            _loc6_ = ConsortiaManager.instance.getTreasureTempByID(treasureGroupInfo.treasures[_loc5_].treasureTemplateId);
            if(_loc6_.Quality == 5)
            {
               haveBest = true;
            }
            _loc5_++;
         }
         _vbox.refreshChildPos();
         _scrollPanel.commitChanges();
         _scrollPanel.invalidateViewport();
         refesh();
      }
      
      private function refesh() : void
      {
         var _loc1_:* = null;
         var _loc2_:int = 0;
         if(_ProgressTimeDown.timeCount == 0)
         {
            _ProgressTimeDown.visible = false;
            _ProgressTxt.x = 259;
            _ProgressTxt.text = LanguageMgr.GetTranslation("consortia.TreasureListFreeMining");
            _ProgressRec.scaleX = 1;
            _loc2_ = _ItemArr.length - 1;
            while(_loc2_ >= 0)
            {
               _ItemArr[_loc2_].free = true;
               _loc2_--;
            }
         }
         else
         {
            _ProgressTimeDown.visible = true;
            _ProgressTxt.x = 209;
         }
      }
      
      private function __allNormal(param1:NotificationEvent) : void
      {
         var _loc2_:* = null;
         var _loc3_:int = 0;
         _loc3_ = _ItemArr.length - 1;
         while(_loc3_ >= 0)
         {
            _ItemArr[_loc3_].free = false;
            _loc3_--;
         }
      }
      
      private function __openHandler(param1:ConsortiaEvent) : void
      {
         ConsortiaSocektSendManager.sendOpenTreasure(0);
      }
      
      private function __openTreasureHandler(param1:ConsortiaEvent) : void
      {
         var _loc2_:ConsortiaTreasureTemplateInfo = null;
         if(treasureGroupInfo.errorID == 0)
         {
            _loc2_ = ConsortiaManager.instance.getTreasureTempByID(treasureGroupInfo.open_treasure[0].treasureTemplateId);
            MessageTipManager.instance().show(LanguageMgr.GetTranslation("consortia.Treasure.success",_loc2_.TemplateName));
         }
         else
         {
            MessageTipManager.instance().show(LanguageMgr.GetTranslation("consortia.Treasure.fail"));
         }
         ConsortiaSocektSendManager.sendOpenTreasure(0);
      }
      
      private function initEvent() : void
      {
         _RefreshBtn.addEventListener("click",_RefreshBtnHandle);
         _Countdown.addEventListener("timerDown_complete",__timeCompleteHandler);
         _ProgressTimeDown.addEventListener("timerDown_updata",__ProgressUpDataHandler);
         _ProgressTimeDown.addEventListener("timerDown_complete",__ProgressCompleteHandler);
         NotificationManager.instance.addEventListener("OPEN_TREASURE_NORMAL",__allNormal);
         ConsortiaManager.instance.model.addEventListener("OPEN_TREASURES",__updataListHandler);
         ConsortiaManager.instance.model.addEventListener("REFRESH",__openHandler);
         ConsortiaManager.instance.model.addEventListener("OPEN_TREASURE",__openTreasureHandler);
      }
      
      private function removeEvent() : void
      {
         if(_RefreshBtn)
         {
            _RefreshBtn.removeEventListener("click",_RefreshBtnHandle);
         }
         if(_Countdown)
         {
            _Countdown.removeEventListener("timerDown_complete",__timeCompleteHandler);
         }
         if(_ProgressTimeDown)
         {
            _ProgressTimeDown.removeEventListener("timerDown_updata",__ProgressUpDataHandler);
         }
         if(_ProgressTimeDown)
         {
            _ProgressTimeDown.removeEventListener("timerDown_complete",__ProgressCompleteHandler);
         }
         NotificationManager.instance.removeEventListener("OPEN_TREASURE_NORMAL",__allNormal);
         ConsortiaManager.instance.model.removeEventListener("OPEN_TREASURES",__updataListHandler);
         ConsortiaManager.instance.model.removeEventListener("REFRESH",__openHandler);
         ConsortiaManager.instance.model.removeEventListener("OPEN_TREASURE",__openTreasureHandler);
      }
      
      private function _RefreshBtnHandle(param1:MouseEvent) : void
      {
         var _loc2_:String = null;
         var _loc3_:String = null;
         var _loc4_:String = null;
         var _loc5_:String = null;
         SoundManager.instance.play("022");
         if(haveBest)
         {
            SimpleAlertHelper.instance.data = [quickRefreshCallBack];
            _loc2_ = LanguageMgr.GetTranslation("public.confirm");
            _loc3_ = LanguageMgr.GetTranslation("public.cancel");
            _loc4_ = LanguageMgr.GetTranslation("public.prompt");
            _loc5_ = LanguageMgr.GetTranslation("consortia.Treasure.bestTip");
            SimpleAlertHelper.instance.popAlerFrame(_loc4_,_loc5_,_loc2_,_loc3_,true,false,false);
         }
         else
         {
            quickRefresh();
         }
      }
      
      private function quickRefreshCallBack(param1:Boolean, param2:Boolean) : void
      {
         if(param1)
         {
            quickRefresh();
         }
      }
      
      private function quickRefresh() : void
      {
         if(model.refresh_costArr[Times] == 0)
         {
            ConsortiaSocektSendManager.sendOpenTreasure(3);
            return;
         }
         var _loc1_:String = LanguageMgr.GetTranslation("yishi.view.base.ThewAlertFrame.text");
         var _loc2_:String = LanguageMgr.GetTranslation("consortia.TreasureList.refresh.alertText",model.refresh_costArr[Times]);
         SharedManagerHelper.ins.needAlert("farm.view.FarmUILayer.onSitDownClick",_RefreshResultHandle,_loc1_,_loc2_);
      }
      
      private function _RefreshResultHandle() : void
      {
         if(PlayerManager.instance.currentPlayerModel.playerInfo.point >= model.refresh_costArr[Times])
         {
            ConsortiaSocektSendManager.sendOpenTreasure(3);
         }
         else
         {
            RechargeAlertMannager.show();
         }
      }
      
      private function __timeCompleteHandler(param1:Event) : void
      {
         ConsortiaSocektSendManager.sendOpenTreasure(0);
      }
      
      private function __ProgressCompleteHandler(param1:Event) : void
      {
         refesh();
      }
      
      private function __ProgressUpDataHandler(param1:Event) : void
      {
         var _loc2_:Number = 1;
         if(treasureGroupInfo.totalTime > 0)
         {
            _loc2_ = _ProgressTimeDown.timeCount / treasureGroupInfo.totalTime;
         }
         _ProgressRec.scaleX = _loc2_ > 1 ? 1 : _loc2_;
      }
      
      private function get model() : ConsortiaModel
      {
         return ConsortiaManager.instance.model;
      }
      
      private function get treasureGroupInfo() : TreasureGroupInfo
      {
         return ConsortiaManager.instance.model.treasureGroupInfo;
      }
      
      private function clearVox() : void
      {
         var _loc1_:TreasureListItem = null;
         var _loc2_:int = 0;
         if(_ItemArr.length == 0)
         {
            return;
         }
         _loc2_ = _ItemArr.length - 1;
         while(_loc2_ >= 0)
         {
            _loc1_ = _ItemArr.pop();
            _loc1_.dispose();
            _loc1_ = null;
            _loc2_--;
         }
         _loc1_ = null;
         _vbox.removeAllChild();
      }
      
      override public function dispose() : void
      {
         removeEvent();
         if(_TxtImg1)
         {
            ObjectUtils.disposeObject(_TxtImg1);
         }
         _TxtImg1 = null;
         if(_ProgressBg)
         {
            ObjectUtils.disposeObject(_ProgressBg);
         }
         _ProgressBg = null;
         if(_Progress)
         {
            ObjectUtils.disposeObject(_Progress);
         }
         _Progress = null;
         if(_ProgressRec)
         {
            ObjectUtils.disposeObject(_ProgressRec);
         }
         _ProgressRec = null;
         if(_ProgressMask)
         {
            ObjectUtils.disposeObject(_ProgressMask);
         }
         _ProgressMask = null;
         if(_RefreshBtn)
         {
            ObjectUtils.disposeObject(_RefreshBtn);
         }
         _RefreshBtn = null;
         if(_Txt1)
         {
            ObjectUtils.disposeObject(_Txt1);
         }
         _Txt1 = null;
         if(_NoListTxt)
         {
            ObjectUtils.disposeObject(_NoListTxt);
         }
         _NoListTxt = null;
         if(_CountdownTxt)
         {
            ObjectUtils.disposeObject(_CountdownTxt);
         }
         _CountdownTxt = null;
         _Countdown.dispose();
         if(_Countdown)
         {
            ObjectUtils.disposeObject(_Countdown);
         }
         _Countdown = null;
         if(_ProgressTxt)
         {
            ObjectUtils.disposeObject(_ProgressTxt);
         }
         _ProgressTxt = null;
         _ProgressTimeDown.dispose();
         if(_ProgressTimeDown)
         {
            ObjectUtils.disposeObject(_ProgressTimeDown);
         }
         _ProgressTimeDown = null;
         if(_MiningTimeSprite)
         {
            ObjectUtils.disposeObject(_MiningTimeSprite);
         }
         _MiningTimeSprite = null;
         if(_numBitmapData)
         {
            ObjectUtils.disposeObject(_numBitmapData);
         }
         _numBitmapData = null;
         if(_vbox)
         {
            ObjectUtils.disposeObject(_vbox);
         }
         _vbox = null;
         if(_scrollPanel)
         {
            ObjectUtils.disposeObject(_scrollPanel);
         }
         _scrollPanel = null;
         LogicUtils.disposeDisplayCollection(_ItemArr);
         _ItemArr = null;
         ObjectUtils.disposeAllChildren(this);
         if(parent)
         {
            parent.removeChild(this);
         }
         super.dispose();
      }
   }
}

