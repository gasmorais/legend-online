package lottery
{
   import bag.helper.BagHelper;
   import chat.datas.ChatData;
   import chat.utils.ChatFormat;
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.instance.IManualSize;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.ui.controls.IconButton;
   import com.pickgliss.ui.controls.ScrollPanel;
   import com.pickgliss.ui.controls.container.VBox;
   import com.pickgliss.ui.image.MutipleImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.ui.text.GradientText;
   import com.pickgliss.utils.ObjectPool;
   import com.pickgliss.utils.ObjectUtils;
   import events.LotteryEvent;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.events.TimerEvent;
   import flash.geom.Rectangle;
   import flash.utils.Timer;
   import manager.LanguageMgr;
   import managers.LotteryManager;
   import mvc.module.lottery.LotteryModel;
   import yishi.datas.goods.GoodsInfo;
   import yishi.manager.NotificationManager;
   import yishi.view.base.Progress;
   import yishi.view.tips.MessageTipManager;
   
   public class LotteryFrame extends Frame implements IManualSize
   {
      
      private var _bg:MutipleImage;
      
      private var _costTip:MutipleImage;
      
      private var _btn:IconButton;
      
      private var _progress:Progress;
      
      private var _gaps:MutipleImage;
      
      private var _boxListSp:Sprite;
      
      private var _boxList:Vector.<LotteryBoxItem>;
      
      private var _turnControl:LotteryTurnControl;
      
      private var _leftCount:FilterFrameText;
      
      private var _hasCost:FilterFrameText;
      
      private var _needCost:FilterFrameText;
      
      private var _dayAddMaxTip:GradientText;
      
      private var _endDays:FilterFrameText;
      
      private var _endHours:FilterFrameText;
      
      private var _endMins:FilterFrameText;
      
      private var _endSecs:FilterFrameText;
      
      private var _describe:FilterFrameText;
      
      private var _showVBox:VBox;
      
      private var _showInfoPanel:ScrollPanel;
      
      private var _timer:Timer;
      
      private var _initFlag:Boolean = false;
      
      private var _running:Boolean = false;
      
      public function LotteryFrame()
      {
         super();
         initView();
         initEvent();
         LotteryManager.Instance.requestInfo();
      }
      
      public function get viewRectangle() : Rectangle
      {
         return new Rectangle(0,0,868,502);
      }
      
      override public function get groups() : Array
      {
         return ["MAIN_TOOLS_GROUP","BAG_GROUP"];
      }
      
      private function initView() : void
      {
         titleText = LanguageMgr.GetTranslation("lottery.LotteryFrame.titleText");
         _bg = ComponentFactory.Instance.creatComponentByStylename("LotteryFrame.MutipleBg");
         _costTip = ComponentFactory.Instance.creatComponentByStylename("LotteryFrame.costTip");
         _btn = ComponentFactory.Instance.creatComponentByStylename("LotteryFrame.Btn");
         _progress = ComponentFactory.Instance.creatComponentByStylename("LotteryFrame.progress");
         _gaps = ComponentFactory.Instance.creatComponentByStylename("lottery.progressGaps");
         _boxListSp = ComponentFactory.Instance.creatCustomObject("lottery.BoxListSp");
         _leftCount = ComponentFactory.Instance.creatComponentByStylename("lottery.LeftCount");
         _hasCost = ComponentFactory.Instance.creatComponentByStylename("lottery.HasCost");
         _needCost = ComponentFactory.Instance.creatComponentByStylename("lottery.NeedCost");
         _dayAddMaxTip = ComponentFactory.Instance.creatComponentByStylename("core.NpcName_VipText");
         _endDays = ComponentFactory.Instance.creatComponentByStylename("lottery.endDays");
         _endHours = ComponentFactory.Instance.creatComponentByStylename("lottery.endHours");
         _endMins = ComponentFactory.Instance.creatComponentByStylename("lottery.endMins");
         _endSecs = ComponentFactory.Instance.creatComponentByStylename("lottery.endSecs");
         _describe = ComponentFactory.Instance.creatComponentByStylename("lottery.describe");
         _showVBox = ComponentFactory.Instance.creatComponentByStylename("lottery.ShowInfoVBox");
         _showInfoPanel = ComponentFactory.Instance.creatComponentByStylename("lottery.ShowInfoPanel");
         _timer = new Timer(1000);
         addToContent(_bg);
         addToContent(_costTip);
         addToContent(_btn);
         addToContent(_progress);
         addToContent(_gaps);
         addToContent(_boxListSp);
         addToContent(_leftCount);
         addToContent(_hasCost);
         addToContent(_needCost);
         addToContent(_dayAddMaxTip);
         addToContent(_endDays);
         addToContent(_endHours);
         addToContent(_endMins);
         addToContent(_endSecs);
         addToContent(_describe);
         addToContent(_showInfoPanel);
         _showInfoPanel.setView(_showVBox);
      }
      
      private function initData() : void
      {
         _dayAddMaxTip.x = 192;
         _dayAddMaxTip.y = 326;
         _dayAddMaxTip.visible = false;
         _dayAddMaxTip.text = LanguageMgr.GetTranslation("lottery.LotteryFrame.dayAddMax");
         _describe.htmlText = LanguageMgr.GetTranslation("lottery.LotteryFrame.describe",model.info.onceNeedPoint,model.info.dayMaxCount);
         var _loc1_:int = model.info.onceNeedPoint - model.info.payedPoint % model.info.onceNeedPoint;
         _needCost.text = _loc1_ + "";
         _hasCost.text = model.info.payedPoint + "";
         _progress.setData(model.info.onceNeedPoint - _loc1_,model.info.onceNeedPoint);
         if(model.info.dayAddCount < model.info.dayMaxCount)
         {
            _costTip.visible = true;
            _needCost.visible = true;
            _hasCost.visible = true;
            _dayAddMaxTip.visible = false;
         }
         else
         {
            _costTip.visible = false;
            _needCost.visible = false;
            _hasCost.visible = false;
            _dayAddMaxTip.visible = true;
            _progress.setData(1,1);
         }
         setLeftTimeText();
         _timer.start();
         _initFlag = true;
      }
      
      private function __infoHandler(param1:LotteryEvent) : void
      {
         if(!_initFlag)
         {
            initData();
         }
         _leftCount.text = model.info.leftCount + "";
      }
      
      private function setLeftTimeText() : void
      {
         var _loc1_:int = int(model.info.leftTimes);
         _endDays.text = int(_loc1_ / 86400) + "";
         _loc1_ %= 86400;
         _endHours.text = int(_loc1_ / 3600) + "";
         _loc1_ %= 3600;
         _endMins.text = int(_loc1_ / 60) + "";
         _loc1_ %= 60;
         _endSecs.text = _loc1_ + "";
         model.info.leftTimes -= 1;
      }
      
      private function refreshGoodsList() : void
      {
         var _loc3_:int = 0;
         var _loc2_:LotteryBoxItem = null;
         var _loc5_:GoodsInfo = null;
         cleanList();
         _boxList = new Vector.<LotteryBoxItem>();
         var _loc4_:int = 71;
         var _loc1_:int = int(model.lotteryGoodsList.length < 16 ? model.lotteryGoodsList.length : 16);
         _loc3_ = 0;
         while(_loc3_ < _loc1_)
         {
            _loc2_ = new LotteryBoxItem();
            _boxListSp.addChild(_loc2_);
            _boxList.push(_loc2_);
            _loc5_ = new GoodsInfo();
            _loc5_.templateId = model.lotteryGoodsList[_loc3_].tempId;
            _loc5_.count = model.lotteryGoodsList[_loc3_].count;
            _loc2_.data = _loc5_;
            if(_loc3_ < 6)
            {
               _loc2_.x = _loc3_ * _loc4_;
               _loc2_.y = 0;
            }
            else if(_loc3_ < 9)
            {
               _loc2_.x = 355;
               _loc2_.y = (_loc3_ - 5) * _loc4_;
            }
            else if(_loc3_ < 14)
            {
               _loc2_.x = 355 - (_loc3_ - 8) * _loc4_;
               _loc2_.y = 213;
            }
            else
            {
               _loc2_.x = 0;
               _loc2_.y = 213 - (_loc3_ - 13) * _loc4_;
            }
            _loc3_++;
         }
         if(_loc1_ > 0)
         {
            _turnControl = new LotteryTurnControl();
            _turnControl.defaultTurn(_boxList);
         }
      }
      
      private function initEvent() : void
      {
         addEventListener("response",__frameResponse);
         _btn.addEventListener("click",__onClickHandler);
         model.addEventListener("UPDATE_SHOW_INFO",__refreshShowInfo);
         model.addEventListener("lottery_effct_complete",__effctCompleteHandler);
         LotteryManager.Instance.addEventListener("DROP_LIST",__dropListHandler);
         LotteryManager.Instance.addEventListener("LOTTERY_INFO",__infoHandler);
         LotteryManager.Instance.addEventListener("LOTTERY_STATE",__stateHandler);
         LotteryManager.Instance.addEventListener("LOTTERY_RESULT",__resultHandler);
         _timer.addEventListener("timer",__timerHandler);
      }
      
      private function removeEvent() : void
      {
         removeEventListener("response",__frameResponse);
         if(_btn)
         {
            _btn.removeEventListener("click",__onClickHandler);
         }
         model.removeEventListener("UPDATE_SHOW_INFO",__refreshShowInfo);
         model.removeEventListener("lottery_effct_complete",__effctCompleteHandler);
         LotteryManager.Instance.removeEventListener("DROP_LIST",__dropListHandler);
         LotteryManager.Instance.removeEventListener("LOTTERY_INFO",__infoHandler);
         LotteryManager.Instance.removeEventListener("LOTTERY_STATE",__stateHandler);
         LotteryManager.Instance.removeEventListener("LOTTERY_RESULT",__resultHandler);
         if(_timer)
         {
            _timer.stop();
            _timer.removeEventListener("timer",__timerHandler);
         }
      }
      
      private function __timerHandler(param1:TimerEvent) : void
      {
         setLeftTimeText();
      }
      
      private function __stateHandler(param1:LotteryEvent) : void
      {
         if(!model.info.isOpen)
         {
            dispose();
         }
      }
      
      private function __effctCompleteHandler(param1:LotteryEvent) : void
      {
         var _loc3_:GoodsInfo = null;
         var _loc2_:ChatData = null;
         var _loc4_:String = null;
         closeButton.enable = true;
         _btn.enable = true;
         _running = false;
         _turnControl.defaultTurn(_boxList);
         __refreshShowInfo(null);
         if(param1 && param1.data)
         {
            BagHelper.instance.playNewGoodsEffect(param1.data as GoodsInfo);
         }
         if(model.dropId != 0)
         {
            _loc3_ = param1.data as GoodsInfo;
            if(_loc3_)
            {
               _loc4_ = LanguageMgr.GetTranslation("lottery.LotteryFrame.dropTips",_loc3_.templateInfo.TemplateName,_loc3_.count);
               _loc2_ = ObjectPool.getObject(ChatData) as ChatData;
               if(_loc2_)
               {
                  _loc2_.channel = 3;
                  _loc2_.msg = _loc4_;
                  _loc2_.commit();
                  NotificationManager.instance.sendNotification("ADD_CHAT",_loc2_);
                  MessageTipManager.instance().show(_loc4_);
               }
            }
         }
      }
      
      private function __resultHandler(param1:LotteryEvent) : void
      {
         var _loc3_:int = 0;
         _leftCount.text = model.info.leftCount + "";
         if(model.dropId == 0)
         {
            __effctCompleteHandler(null);
            return;
         }
         var _loc2_:int = int(_boxList.length);
         _loc3_ = 0;
         while(_loc3_ < _loc2_)
         {
            if(_boxList[_loc3_].data)
            {
               if(_boxList[_loc3_].data.templateId == model.dropId && _boxList[_loc3_].data.count == model.dropCount)
               {
                  _turnControl.turnPlate(_loc3_ + 1);
               }
            }
            _loc3_++;
         }
      }
      
      private function __dropListHandler(param1:LotteryEvent) : void
      {
         refreshGoodsList();
      }
      
      private function __frameResponse(param1:FrameEvent) : void
      {
         switch(int(param1.responseCode))
         {
            case 0:
               dispose();
         }
      }
      
      private function __onClickHandler(param1:MouseEvent) : void
      {
         if(model.info.leftCount <= 0)
         {
            MessageTipManager.instance().show(LanguageMgr.GetTranslation("lottery.LotteryFrame.noLeftCounts"));
            return;
         }
         if(model.lotteryGoodsList.length <= 0)
         {
            return;
         }
         _running = true;
         closeButton.enable = false;
         _btn.enable = false;
         LotteryManager.Instance.senLotteryRolette();
      }
      
      public function __refreshShowInfo(param1:LotteryEvent) : void
      {
         var _loc3_:int = 0;
         var _loc4_:LotteryNotic = null;
         var _loc2_:ChatData = null;
         if(_running)
         {
            return;
         }
         _showVBox.removeAllChild();
         _showVBox.disposeAllChildren();
         _showVBox.beginChanges();
         if(model.lotteryShowInfo)
         {
            _loc3_ = 0;
            while(_loc3_ < model.lotteryShowInfo.length)
            {
               _loc4_ = new LotteryNotic();
               _loc2_ = ObjectPool.getObject(ChatData) as ChatData;
               _loc2_.channel = 21;
               _loc2_.msg = model.lotteryShowInfo[_loc3_];
               _loc2_.chatItemData.cellVector = ChatFormat.getContentCellData(_loc2_);
               _loc4_.data = _loc2_;
               _showVBox.addChild(_loc4_);
               _loc3_++;
            }
         }
         _showVBox.commitChanges();
         _showInfoPanel.invalidateViewport(true);
      }
      
      private function get model() : LotteryModel
      {
         return LotteryManager.Instance.model;
      }
      
      public function show() : void
      {
         LayerManager.Instance.addToLayer(this,3,true,true,1,0,true);
      }
      
      override public function dispose() : void
      {
         removeEvent();
         _timer = null;
         ObjectUtils.disposeObject(_bg);
         _bg = null;
         ObjectUtils.disposeObject(_costTip);
         _costTip = null;
         ObjectUtils.disposeObject(_btn);
         _btn = null;
         ObjectUtils.disposeObject(_progress);
         _progress = null;
         ObjectUtils.disposeObject(_gaps);
         _gaps = null;
         ObjectUtils.disposeObject(_leftCount);
         _leftCount = null;
         ObjectUtils.disposeObject(_hasCost);
         _hasCost = null;
         ObjectUtils.disposeObject(_needCost);
         _needCost = null;
         ObjectUtils.disposeObject(_dayAddMaxTip);
         _dayAddMaxTip = null;
         ObjectUtils.disposeObject(_endDays);
         _endDays = null;
         ObjectUtils.disposeObject(_endHours);
         _endHours = null;
         ObjectUtils.disposeObject(_endMins);
         _endMins = null;
         ObjectUtils.disposeObject(_endSecs);
         _endSecs = null;
         ObjectUtils.disposeObject(_describe);
         _describe = null;
         ObjectUtils.disposeObject(_showVBox);
         _showVBox = null;
         ObjectUtils.disposeObject(_showInfoPanel);
         _showInfoPanel = null;
         _boxListSp = null;
         cleanList();
         _boxList = null;
         if(_turnControl)
         {
            _turnControl.dispose();
         }
         _turnControl = null;
         super.dispose();
      }
      
      private function cleanList() : void
      {
         if(_boxList)
         {
            while(_boxList.length > 0)
            {
               _boxList.pop().dispose();
            }
         }
      }
   }
}

