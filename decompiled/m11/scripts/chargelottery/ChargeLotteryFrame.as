package chargelottery
{
   import chat.datas.ChatData;
   import chat.utils.ChatFormat;
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.instance.IManualSize;
   import com.pickgliss.loader.DisplayLoader;
   import com.pickgliss.ui.AlertManager;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.ui.controls.IconButton;
   import com.pickgliss.ui.controls.ScrollPanel;
   import com.pickgliss.ui.controls.alert.BaseAlerFrame;
   import com.pickgliss.ui.controls.container.VBox;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectPool;
   import com.pickgliss.utils.ObjectUtils;
   import com.pickgliss.utils.SoundManager;
   import com.road.yishi.proto.cccactive.ChargePointLotteryMsg;
   import flash.display.DisplayObject;
   import flash.events.MouseEvent;
   import flash.events.TimerEvent;
   import flash.geom.Rectangle;
   import flash.utils.Timer;
   import manager.LanguageMgr;
   import yishi.datas.goods.GoodsInfo;
   import yishi.datas.templates.GoodsTemplateInfo;
   import yishi.events.NotificationEvent;
   import yishi.filter.UIFilter;
   import yishi.interfaces.IFilterFormat;
   import yishi.keyboard.KeyBoardRegister;
   import yishi.manager.ChargeLotteryManager;
   import yishi.manager.NotificationManager;
   import yishi.manager.PlayerManager;
   import yishi.manager.RechargeAlertMannager;
   import yishi.manager.TempleteManager;
   import yishi.utils.DateFormatter;
   import yishi.utils.TurnControlII;
   import yishi.view.tips.MessageTipManager;
   
   public class ChargeLotteryFrame extends Frame implements IManualSize
   {
      
      private var _back:DisplayObject;
      
      private var _bg:DisplayObject;
      
      private var _personBg:DisplayObject;
      
      private var _receiveBtn:IconButton;
      
      private var _receiveAllBtn:IconButton;
      
      private var _leftTimeTxt:FilterFrameText;
      
      private var _leftCountText:FilterFrameText;
      
      private var _rechargeText:FilterFrameText;
      
      private var _timer:Timer;
      
      private var _chargeMsg:ChargePointLotteryMsg;
      
      private var _scrolPanel:ScrollPanel;
      
      private var _vBox:VBox;
      
      private var _chargeRare:Boolean;
      
      private var _guizeBmp:DisplayObject;
      
      private var _zhanshiBmp:DisplayObject;
      
      private var _desText:FilterFrameText;
      
      private var _numBg1:DisplayObject;
      
      private var _numBg2:DisplayObject;
      
      private var _shengyuNote:FilterFrameText;
      
      private var _chongzhiNote:FilterFrameText;
      
      private var _list:Array = [];
      
      private var _list2:Array = [];
      
      private var _rewardId:int;
      
      private var _rewardCount:int;
      
      private var _turnControl:TurnControlII;
      
      private var _posArr:Array = [[178,13],[242,13],[307,13],[372,13],[437,13],[501,13],[565,13],[584,86],[584,150],[584,218],[584,287],[584,353],[518,353],[452,353],[386,353],[320,353],[255,353],[179,339],[178,273],[178,209],[178,142],[178,78]];
      
      private var _posArr2:Array = [[293,125],[351,125],[408,125],[466,125],[466,183],[408,183],[351,183],[293,183]];
      
      private const NUM:int = 22;
      
      private const NUM2:int = 8;
      
      private var _canClose:Boolean = true;
      
      private var _filter:IFilterFormat;
      
      private var flickerArr:Array = [];
      
      public function ChargeLotteryFrame()
      {
         super();
         initView();
         addEvent();
         ChargeLotteryManager.instance.OperateChargeReq(1);
      }
      
      public function get viewRectangle() : Rectangle
      {
         return new Rectangle(0,0,900,566);
      }
      
      override public function get groups() : Array
      {
         return ["MAIN_TOOLS_GROUP","BAG_GROUP"];
      }
      
      private function initView() : void
      {
         titleText = LanguageMgr.GetTranslation("ui.toptoolbar.TopToolsBar.tipData_chargelottery");
         _back = ComponentFactory.Instance.creatComponentByStylename("chargelottery.chargelotteryFrame.back");
         _bg = ComponentFactory.Instance.creatBitmap("asset.chargelottery.Bg");
         _personBg = ComponentFactory.Instance.creatBitmap("asset.chargelottery.personBg");
         _receiveBtn = ComponentFactory.Instance.creatComponentByStylename("chargelottery.receiveBtn");
         _receiveAllBtn = ComponentFactory.Instance.creatComponentByStylename("chargelottery.receiveAllBtn");
         _leftTimeTxt = ComponentFactory.Instance.creatComponentByStylename("chargelottery.leftTimeTxt");
         _leftCountText = ComponentFactory.Instance.creatComponentByStylename("chargelottery.leftCountText");
         _rechargeText = ComponentFactory.Instance.creatComponentByStylename("chargelottery.rechargeText");
         _scrolPanel = ComponentFactory.Instance.creatComponentByStylename("chargelottery.ScrollPanel");
         _vBox = ComponentFactory.Instance.creatComponentByStylename("chargelottery.Vbox");
         _guizeBmp = ComponentFactory.Instance.creatBitmap("asset.chargelottery.guizeshuoming");
         _zhanshiBmp = ComponentFactory.Instance.creatBitmap("asset.chargelottery.dongtaizhanshi");
         _desText = ComponentFactory.Instance.creatComponentByStylename("chargelottery.desText");
         _numBg1 = ComponentFactory.Instance.creatBitmap("asset.chargelottery.numBg");
         _numBg1.x = 330;
         _numBg1.y = 83;
         _numBg2 = ComponentFactory.Instance.creatBitmap("asset.chargelottery.numBg");
         _numBg2.x = 473;
         _numBg2.y = 83;
         _shengyuNote = ComponentFactory.Instance.creatComponentByStylename("chargelottery.shengyuNote");
         _chongzhiNote = ComponentFactory.Instance.creatComponentByStylename("chargelottery.chongzhiNote");
         addToContent(_personBg);
         addToContent(_back);
         addToContent(_bg);
         addToContent(_receiveBtn);
         addToContent(_receiveAllBtn);
         addToContent(_leftTimeTxt);
         addToContent(_scrolPanel);
         addToContent(_guizeBmp);
         addToContent(_zhanshiBmp);
         addToContent(_desText);
         addToContent(_numBg1);
         addToContent(_numBg2);
         addToContent(_shengyuNote);
         addToContent(_chongzhiNote);
         addToContent(_leftCountText);
         addToContent(_rechargeText);
         _scrolPanel.beginChanges();
         _scrolPanel.setView(_vBox,true);
         _scrolPanel.invalidateViewport();
         _shengyuNote.text = LanguageMgr.GetTranslation("chargelottery.ChargeLotteryFrame.shengyuNote");
         _chongzhiNote.text = LanguageMgr.GetTranslation("chargelottery.ChargeLotteryFrame.chongzhiNote");
         _filter = new UIFilter();
      }
      
      private function addEvent() : void
      {
         addEventListener("response",__frameResponse);
         _receiveBtn.addEventListener("click",__receiveBtnHandler);
         _receiveAllBtn.addEventListener("click",__receiveAllBtnHandler);
         NotificationManager.instance.addEventListener("CHARGELOTTERY_RESULT_UPDATE",__chargeResultHandler);
         NotificationManager.instance.addEventListener("ARTIFACT_BOX_FLICHER",__alertMessage);
      }
      
      private function removeEvent() : void
      {
         removeEventListener("response",__frameResponse);
         if(_receiveBtn)
         {
            _receiveBtn.removeEventListener("click",__receiveBtnHandler);
         }
         if(_receiveAllBtn)
         {
            _receiveAllBtn.removeEventListener("click",__receiveAllBtnHandler);
         }
         NotificationManager.instance.removeEventListener("CHARGELOTTERY_RESULT_UPDATE",__chargeResultHandler);
         NotificationManager.instance.removeEventListener("ARTIFACT_BOX_FLICHER",__alertMessage);
      }
      
      private function initList() : void
      {
         var _loc1_:Array = null;
         var _loc2_:ChargeLotteryItem = null;
         var _loc4_:GoodsInfo = null;
         var _loc3_:int = 0;
         _loc1_ = ChargeLotteryManager.instance.normalArr;
         _loc3_ = 0;
         while(_loc3_ < _loc1_.length)
         {
            _loc2_ = ComponentFactory.Instance.creatCustomObject("chargelottery.ChargeLotteryItem",[_loc3_]);
            _loc4_ = new GoodsInfo();
            _loc4_.templateId = _loc1_[_loc3_].templateId;
            _loc4_.count = _loc1_[_loc3_].count;
            _loc2_.templateType = _loc1_[_loc3_].templateType;
            _loc2_.pos = _loc1_[_loc3_].pos;
            _loc2_.data = _loc4_;
            _loc2_.x = _posArr[_loc3_][0];
            _loc2_.y = _posArr[_loc3_][1];
            addToContent(_loc2_);
            _list.push(_loc2_);
            _loc3_++;
         }
         _loc1_ = ChargeLotteryManager.instance.rareArr;
         _loc3_ = 22;
         while(_loc3_ < 8 + 22)
         {
            _loc2_ = ComponentFactory.Instance.creatCustomObject("chargelottery.ChargeLotteryItem",[_loc3_]);
            _loc4_ = new GoodsInfo();
            _loc4_.templateId = _loc1_[_loc3_ - 22].templateId;
            _loc4_.count = _loc1_[_loc3_ - 22].count;
            _loc2_.templateType = _loc1_[_loc3_ - 22].templateType;
            _loc2_.pos = _loc1_[_loc3_ - 22].pos;
            _loc2_.data = _loc4_;
            _loc2_.x = _posArr2[_loc3_ - 22][0];
            _loc2_.y = _posArr2[_loc3_ - 22][1];
            addToContent(_loc2_);
            _list2.push(_loc2_);
            _loc3_++;
         }
         _turnControl = new TurnControlII();
      }
      
      private function __alertMessage(param1:NotificationEvent) : void
      {
         closeEnable = true;
         showMsgHandler();
         refreshView();
      }
      
      private function __chargeResultHandler(param1:NotificationEvent) : void
      {
         var _loc3_:int = 0;
         var _loc2_:ChargeLotteryItem = null;
         _chargeMsg = ChargeLotteryManager.instance.chargeMsg;
         if(_chargeMsg.op == 1)
         {
            initList();
            refreshView();
            timeHandler(null);
         }
         else if(_chargeMsg.op == 2)
         {
            if(_chargeMsg.resultPos.length == 1)
            {
               _loc3_ = 0;
               while(_loc3_ < flickerArr.length)
               {
                  _loc2_ = flickerArr[_loc3_] as ChargeLotteryItem;
                  if(_loc2_.pos == _chargeMsg.resultPos[0])
                  {
                     _turnControl.turnPlate(_loc3_ + 1);
                  }
                  _loc3_++;
               }
            }
            else
            {
               showMsgHandler();
               refreshView();
            }
         }
         else if(_chargeMsg.op == 3)
         {
            updateChatInfo();
         }
      }
      
      private function showMsgHandler() : void
      {
         var _loc1_:GoodsTemplateInfo = null;
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         var _loc5_:String = LanguageMgr.GetTranslation("chargelottery.ChargeLotteryFrame.rewardStr");
         _loc3_ = 0;
         while(_loc3_ < _chargeMsg.resultPos.length)
         {
            _loc4_ = 0;
            while(_loc4_ < _chargeMsg.reward.length)
            {
               if(_chargeMsg.resultPos[_loc3_] == _chargeMsg.reward[_loc4_].pos)
               {
                  _loc1_ = TempleteManager.instance.goodsTemplateCate.getTemplateByID(_chargeMsg.reward[_loc4_].templateId);
                  if(_loc1_)
                  {
                     _loc5_ += _loc1_.TemplateName + "*" + _chargeMsg.reward[_loc4_].count + ",";
                  }
               }
               _loc4_++;
            }
            _loc3_++;
         }
         if(_loc5_ == LanguageMgr.GetTranslation("chargelottery.ChargeLotteryFrame.rewardStr"))
         {
            _loc5_ = LanguageMgr.GetTranslation("chargelottery.ChargeLotteryFrame.alertShowTxt");
         }
         else
         {
            _loc5_ = _loc5_.substr(0,_loc5_.length - 1);
         }
         MessageTipManager.instance().show(_loc5_,true,null,true);
         var _loc2_:ChatData = ObjectPool.getObject(ChatData) as ChatData;
         if(_loc2_)
         {
            _loc2_.channel = 3;
            _loc2_.msg = _loc5_;
            _loc2_.commit();
            NotificationManager.instance.sendNotification("ADD_CHAT",_loc2_);
            MessageTipManager.instance().show(_loc5_);
         }
      }
      
      private function refreshView() : void
      {
         _receiveBtn.enable = _chargeMsg.leftCount > 0 || Boolean(_chargeMsg.isRare);
         _receiveAllBtn.enable = _chargeMsg.leftCount > 0;
         _leftCountText.text = _chargeMsg.leftCount.toString();
         _rechargeText.text = _chargeMsg.leftNeedPoint.toString();
         _desText.text = LanguageMgr.GetTranslation("chargelottery.ChargeLotteryFrame.desText",_chargeMsg.oneNeedPoint,_chargeMsg.dayMaxCount);
         setFilter();
      }
      
      private function setFilter() : void
      {
         var _loc1_:Array = null;
         var _loc4_:Array = null;
         var _loc3_:int = 0;
         var _loc2_:ChargeLotteryItem = null;
         flickerArr = [];
         if(_chargeRare != _chargeMsg.isRare)
         {
            clearFilter();
            _chargeRare = _chargeMsg.isRare;
         }
         if(!_chargeMsg.isRare)
         {
            _loc1_ = ChargeLotteryManager.instance.normalArr;
            _loc4_ = _list;
         }
         else
         {
            _loc1_ = ChargeLotteryManager.instance.rareArr;
            _loc4_ = _list2;
         }
         _loc3_ = 0;
         while(_loc3_ < _loc4_.length)
         {
            _loc2_ = _loc4_[_loc3_] as ChargeLotteryItem;
            _loc2_.clearFlicker();
            _filter.setNormalFilter(_loc2_);
            flickerArr.push(_loc2_);
            _loc3_++;
         }
         if(flickerArr.length != 0)
         {
            _turnControl.defaultTurn(flickerArr);
         }
         else
         {
            _turnControl.dispose();
            _turnControl = null;
            _turnControl = new TurnControlII();
         }
      }
      
      private function updateChatInfo() : void
      {
         var _loc4_:int = 0;
         var _loc2_:* = undefined;
         var _loc3_:ChatData = null;
         _vBox.disposeAllChildren();
         _vBox.beginChanges();
         _scrolPanel.beginChanges();
         var _loc1_:Class = DisplayLoader.Context.applicationDomain.getDefinition("chargelottery.ChargelotteryShopEventItem") as Class;
         if(_chargeMsg.logs)
         {
            _loc4_ = 0;
            while(_loc4_ < _chargeMsg.logs.length)
            {
               _loc2_ = new _loc1_();
               _loc3_ = ObjectPool.getObject(ChatData) as ChatData;
               _loc3_.channel = 103;
               _loc3_.msg = _chargeMsg.logs[_loc4_];
               _loc3_.chatItemData.cellVector = ChatFormat.getContentCellData(_loc3_);
               _loc2_.lineWidth = 183;
               _loc2_.data = _loc3_;
               _vBox.addChild(_loc2_);
               _loc4_++;
            }
         }
         _vBox.commitChanges();
         _scrolPanel.invalidateViewport();
      }
      
      private function clearFilter() : void
      {
         var _loc1_:ChargeLotteryItem = null;
         var _loc2_:int = 0;
         _loc2_ = 0;
         while(_loc2_ < _list.length)
         {
            _loc1_ = _list[_loc2_] as ChargeLotteryItem;
            _loc1_.clearFlicker();
            _filter.setNormalFilter(_loc1_);
            _loc2_++;
         }
         _loc2_ = 0;
         while(_loc2_ < _list2.length)
         {
            _loc1_ = _list2[_loc2_] as ChargeLotteryItem;
            _loc1_.clearFlicker();
            _filter.setNormalFilter(_loc1_);
            _loc2_++;
         }
      }
      
      private function __receiveBtnHandler(param1:MouseEvent) : void
      {
         SoundManager.instance.play("022");
         if(_chargeMsg.leftCount <= 0 && !_chargeMsg.isRare)
         {
            rechargeAlertHandler();
            return;
         }
         if(!ChargeLotteryManager.instance.openChargeLottery)
         {
            return;
         }
         _receiveBtn.enable = false;
         _receiveAllBtn.enable = false;
         closeEnable = false;
         ChargeLotteryManager.instance.OperateChargeReq(2);
      }
      
      private function __receiveAllBtnHandler(param1:MouseEvent) : void
      {
         SoundManager.instance.play("022");
         if(_chargeMsg.leftCount <= 0)
         {
            rechargeAlertHandler();
            return;
         }
         if(!ChargeLotteryManager.instance.openChargeLottery)
         {
            return;
         }
         if(_chargeMsg.isRare)
         {
            return;
         }
         _receiveBtn.enable = false;
         _receiveAllBtn.enable = false;
         ChargeLotteryManager.instance.OperateChargeReq(2,true);
      }
      
      private function rechargeAlertHandler() : void
      {
         var rechargeHandler:* = function(param1:FrameEvent):void
         {
            RechargeAlertMannager.navigateToRechargePage();
            alert.removeEventListener("response",rechargeHandler);
            alert.dispose();
         };
         var prompt:String = LanguageMgr.GetTranslation("public.prompt");
         var content:String = LanguageMgr.GetTranslation("yishi.manager.rechargeAlertHandler.content");
         var alert:BaseAlerFrame = AlertManager.Instance.simpleAlert(prompt,content,"","");
         alert.addEventListener("response",rechargeHandler);
      }
      
      private function timeHandler(param1:TimerEvent) : void
      {
         var _loc4_:String = null;
         if(_timer == null)
         {
            _timer = new Timer(1000);
            _timer.addEventListener("timer",timeHandler);
            _timer.start();
         }
         var _loc2_:Date = DateFormatter.parse(_chargeMsg.stopTime,"YYYY-MM-DD hh:mm:ss");
         var _loc3_:Number = _loc2_.time / 1000 - PlayerManager.instance.currentPlayerModel.sysCurTimeBySecond;
         if(_loc3_ > 0)
         {
            if(_loc3_ >= 60)
            {
               _leftTimeTxt.text = LanguageMgr.GetTranslation("funny.FunnyRightView.active.remainTime",DateFormatter.getFullTimeString(_loc3_));
            }
            else
            {
               _loc4_ = LanguageMgr.GetTranslation("funny.groupbuy.buyRestTimeSecond",_loc3_);
               _leftTimeTxt.text = LanguageMgr.GetTranslation("funny.FunnyRightView.active.remainTime",_loc4_);
            }
         }
         else
         {
            _leftTimeTxt.text = LanguageMgr.GetTranslation("mainBar.TopToolsBar.rechargeBtn.click04");
            _timer.stop();
            _timer.removeEventListener("timer",timeHandler);
            _timer = null;
         }
      }
      
      private function set closeEnable(param1:Boolean) : void
      {
         if(param1)
         {
            KeyBoardRegister.instance.keyEnable = true;
            _canClose = true;
         }
         else
         {
            KeyBoardRegister.instance.keyEnable = false;
            _canClose = false;
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
      
      public function show() : void
      {
         LayerManager.Instance.addToLayer(this,3,true,true,0,0,true);
      }
      
      override public function dispose() : void
      {
         if(!_canClose)
         {
            return;
         }
         removeEvent();
         ObjectUtils.disposeObject(_back);
         _back = null;
         ObjectUtils.disposeObject(_bg);
         _bg = null;
         ObjectUtils.disposeObject(_personBg);
         _personBg = null;
         ObjectUtils.disposeObject(_receiveBtn);
         _receiveBtn = null;
         ObjectUtils.disposeObject(_receiveAllBtn);
         _receiveAllBtn = null;
         ObjectUtils.disposeObject(_leftTimeTxt);
         _leftTimeTxt = null;
         ObjectUtils.disposeObject(_leftCountText);
         _leftCountText = null;
         ObjectUtils.disposeObject(_rechargeText);
         _rechargeText = null;
         ObjectUtils.disposeObject(_scrolPanel);
         _scrolPanel = null;
         ObjectUtils.disposeObject(_vBox);
         _vBox = null;
         ObjectUtils.disposeObject(_guizeBmp);
         _guizeBmp = null;
         ObjectUtils.disposeObject(_zhanshiBmp);
         _zhanshiBmp = null;
         ObjectUtils.disposeObject(_desText);
         _desText = null;
         ObjectUtils.disposeObject(_numBg1);
         _numBg1 = null;
         ObjectUtils.disposeObject(_numBg2);
         _numBg2 = null;
         ObjectUtils.disposeObject(_shengyuNote);
         _shengyuNote = null;
         ObjectUtils.disposeObject(_chongzhiNote);
         _chongzhiNote = null;
         ObjectUtils.disposeObject(_turnControl);
         _turnControl = null;
         ObjectUtils.disposeObject(_filter);
         _filter = null;
         if(_list)
         {
            while(_list.length)
            {
               ObjectUtils.disposeObject(_list.pop());
            }
         }
         if(_list2)
         {
            while(_list2.length)
            {
               ObjectUtils.disposeObject(_list2.pop());
            }
         }
         if(_timer)
         {
            _timer.stop();
            _timer.removeEventListener("timer",timeHandler);
            _timer = null;
         }
         _chargeMsg = null;
         _posArr = null;
         _posArr2 = null;
         flickerArr.length = 0;
         super.dispose();
      }
   }
}

