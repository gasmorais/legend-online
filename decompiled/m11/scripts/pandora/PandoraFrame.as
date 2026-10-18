package pandora
{
   import chat.datas.ChatData;
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.instance.IManualSize;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.ui.controls.IconButton;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectPool;
   import com.pickgliss.utils.ObjectUtils;
   import com.pickgliss.utils.SoundManager;
   import com.road.yishi.proto.cccactive.LotteryRewardMsg;
   import com.road.yishi.proto.cccactive.PandoraLotteryMsg;
   import flash.display.Bitmap;
   import flash.display.BitmapData;
   import flash.display.DisplayObject;
   import flash.events.MouseEvent;
   import flash.events.TimerEvent;
   import flash.geom.Rectangle;
   import flash.utils.Timer;
   import flash.utils.clearTimeout;
   import flash.utils.setTimeout;
   import mainBar.StripView;
   import manager.LanguageMgr;
   import yishi.events.NotificationEvent;
   import yishi.filter.UIFilter;
   import yishi.interfaces.IFilterFormat;
   import yishi.keyboard.KeyBoardRegister;
   import yishi.manager.NotificationManager;
   import yishi.manager.PandoraManager;
   import yishi.manager.PlayerManager;
   import yishi.manager.RechargeAlertMannager;
   import yishi.utils.DateFormatter;
   import yishi.utils.NumberViewUtils;
   import yishi.utils.TurnControlII;
   import yishi.view.tips.MessageTipManager;
   
   public class PandoraFrame extends Frame implements IManualSize
   {
      
      private var _bg:DisplayObject;
      
      private var _personBg:DisplayObject;
      
      private var _leftCountBg:DisplayObject;
      
      private var _leftCountImg:DisplayObject;
      
      private var _activeTxtImg:DisplayObject;
      
      private var _numberAsset1:BitmapData;
      
      private var _numberAsset2:BitmapData;
      
      private var _container1:Component;
      
      private var _container2:Component;
      
      private var _receiveBtn:IconButton;
      
      private var _leftTimeTxt:FilterFrameText;
      
      private var _activityText:FilterFrameText;
      
      private var _timer:Timer;
      
      private var _pandoraMsg:PandoraLotteryMsg;
      
      private var _pointImg:Bitmap;
      
      private var _btnStrip:StripView;
      
      private var _list:Array = [];
      
      private var _rewardId:int;
      
      private var _rewardCount:int;
      
      private var _turnControl:TurnControlII;
      
      private var _posArr:Array = [[312,136],[312,283],[188,350],[62,283],[62,135],[188,64]];
      
      private const NUM:int = 6;
      
      private var _canClose:Boolean = true;
      
      private var _filter:IFilterFormat;
      
      private var flickerArr:Array = [];
      
      private var _timeId:int;
      
      public function PandoraFrame()
      {
         super();
         initView();
         addEvent();
         initList();
         PandoraManager.instance.OperatePandoraReq(1);
      }
      
      public function get viewRectangle() : Rectangle
      {
         return new Rectangle(0,0,768,602);
      }
      
      override public function get groups() : Array
      {
         return ["MAIN_TOOLS_GROUP","BAG_GROUP"];
      }
      
      private function initView() : void
      {
         titleText = LanguageMgr.GetTranslation("ui.toptoolbar.TopToolsBar.tipData_pandora");
         _bg = ComponentFactory.Instance.creatBitmap("asset.pandora.Bg");
         _personBg = ComponentFactory.Instance.creatBitmap("asset.pandora.personBg");
         _leftCountBg = ComponentFactory.Instance.creatBitmap("asset.pandora.leftCountBg");
         _leftCountImg = ComponentFactory.Instance.creatBitmap("asset.pandora.leftCountImg");
         _activeTxtImg = ComponentFactory.Instance.creatBitmap("asset.pandora.activeTxtImg");
         _numberAsset1 = ComponentFactory.Instance.creatBitmapData("asset.pandora.bigNum");
         _numberAsset2 = ComponentFactory.Instance.creatBitmapData("asset.pandora.middleNum");
         _container1 = new Component();
         _container1.x = 247;
         _container1.y = 460;
         _container2 = new Component();
         _container2.x = 189;
         _container2.y = 254;
         _receiveBtn = ComponentFactory.Instance.creatComponentByStylename("pandora.receiveBtn");
         _leftTimeTxt = ComponentFactory.Instance.creatComponentByStylename("pandora.leftTimeTxt");
         _activityText = ComponentFactory.Instance.creatComponentByStylename("pandora.activityText");
         _pointImg = ComponentFactory.Instance.creatBitmap("asset.pandora.pointImg");
         _btnStrip = ComponentFactory.Instance.creatCustomObject("pandoraFrame.BtnStrip");
         addToContent(_bg);
         addToContent(_personBg);
         addToContent(_leftCountBg);
         addToContent(_leftCountImg);
         addToContent(_activeTxtImg);
         addToContent(_receiveBtn);
         addToContent(_leftTimeTxt);
         addToContent(_activityText);
         addToContent(_container1);
         addToContent(_container2);
         addToContent(_pointImg);
         _pointImg.x = 231;
         _pointImg.y = 257;
         addToContent(_btnStrip);
         _btnStrip.setHitArea(0,0,121,117);
         _btnStrip.tipData = LanguageMgr.GetTranslation("pandora.PandoraFrame.btnStrip");
         _container2.mouseEnabled = _container2.mouseChildren = false;
         _filter = new UIFilter();
      }
      
      private function addEvent() : void
      {
         addEventListener("response",__frameResponse);
         _receiveBtn.addEventListener("click",__receiveBtnHandler);
         NotificationManager.instance.addEventListener("PANDORA_RESULT_UPDATE",__pandoraResultHandler);
         NotificationManager.instance.addEventListener("ARTIFACT_BOX_FLICHER",__alertMessage);
      }
      
      private function removeEvent() : void
      {
         removeEventListener("response",__frameResponse);
         if(_receiveBtn)
         {
            _receiveBtn.removeEventListener("click",__receiveBtnHandler);
         }
         NotificationManager.instance.removeEventListener("PANDORA_RESULT_UPDATE",__pandoraResultHandler);
         NotificationManager.instance.removeEventListener("ARTIFACT_BOX_FLICHER",__alertMessage);
      }
      
      private function initList() : void
      {
         var _loc2_:int = 0;
         var _loc1_:PandoraItem = null;
         _loc2_ = 0;
         while(_loc2_ < 6)
         {
            _loc1_ = ComponentFactory.Instance.creatCustomObject("pandora.PandoraItem");
            _loc1_.x = _posArr[_loc2_][0];
            _loc1_.y = _posArr[_loc2_][1];
            _loc1_.Index = _loc2_ + 1;
            addToContent(_loc1_);
            _list.push(_loc1_);
            _loc2_++;
         }
         _turnControl = new TurnControlII();
      }
      
      private function __alertMessage(param1:NotificationEvent) : void
      {
         var _loc3_:String = LanguageMgr.GetTranslation("pandora.PandoraFrame.alertRewardTxt",_pandoraMsg.resultPoint);
         MessageTipManager.instance().show(_loc3_,true,null,true);
         var _loc2_:ChatData = ObjectPool.getObject(ChatData) as ChatData;
         if(_loc2_)
         {
            _loc2_.channel = 3;
            _loc2_.msg = _loc3_;
            _loc2_.commit();
            NotificationManager.instance.sendNotification("ADD_CHAT",_loc2_);
            MessageTipManager.instance().show(_loc3_);
         }
         closeEnable = true;
         _pandoraMsg.currentLevel = _pandoraMsg.currentLevel >= _pandoraMsg.reward.length ? _pandoraMsg.reward.length : _pandoraMsg.currentLevel + 1;
         refreshView();
      }
      
      private function __pandoraResultHandler(param1:NotificationEvent) : void
      {
         var evt:NotificationEvent = param1;
         _timeId = setTimeout(function():void
         {
            var _loc2_:int = 0;
            var _loc1_:PandoraItem = null;
            clearTimeout(_timeId);
            _pandoraMsg = PandoraManager.instance.pandoraMsg;
            if(_pandoraMsg.op == 1)
            {
               refreshView();
               timeHandler(null);
            }
            else
            {
               _loc2_ = 0;
               while(_loc2_ < flickerArr.length)
               {
                  _loc1_ = flickerArr[_loc2_] as PandoraItem;
                  if(_loc1_.count == _pandoraMsg.resultPoint)
                  {
                     _turnControl.turnPlate(_loc2_ + 1);
                  }
                  _loc2_++;
               }
            }
         },200);
      }
      
      private function refreshView() : void
      {
         _receiveBtn.enable = _pandoraMsg.leftLotteryCount > 0;
         _btnStrip.visible = _pandoraMsg.leftLotteryCount <= 0;
         var _loc2_:Number = Number(_pandoraMsg.leftLotteryCount);
         NumberViewUtils.refreshValue(_loc2_,_container1,_numberAsset1,16,24,13,16,"0123456789.");
         _loc2_ = Number(PandoraManager.instance.rewardMsg.needPoint);
         NumberViewUtils.refreshValue(_loc2_,_container2,_numberAsset2,16,22,10,16,"0123456789.");
         var _loc3_:Date = DateFormatter.parse(_pandoraMsg.openTime,"YYYY-MM-DD hh:mm:ss");
         var _loc1_:Date = DateFormatter.parse(_pandoraMsg.stopTime,"YYYY-MM-DD hh:mm:ss");
         _activityText.text = DateFormatter.timeFormat3(_loc3_) + "~" + DateFormatter.timeFormat3(_loc1_);
         setFilter();
      }
      
      private function setFilter() : void
      {
         var _loc3_:int = 0;
         var _loc2_:PandoraItem = null;
         flickerArr = [];
         var _loc1_:LotteryRewardMsg = PandoraManager.instance.rewardMsg;
         _loc3_ = 0;
         while(_loc3_ < 6)
         {
            _loc2_ = _list[_loc3_] as PandoraItem;
            _loc2_.count = _loc1_["point" + (_loc3_ + 1)];
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
      
      private function __receiveBtnHandler(param1:MouseEvent) : void
      {
         SoundManager.instance.play("022");
         if(PandoraManager.instance.rewardMsg.needPoint > PlayerManager.instance.currentPlayerModel.playerInfo.point)
         {
            RechargeAlertMannager.show();
            return;
         }
         _receiveBtn.enable = false;
         closeEnable = false;
         PandoraManager.instance.OperatePandoraReq(2);
      }
      
      private function timeHandler(param1:TimerEvent) : void
      {
         var _loc5_:String = null;
         if(_timer == null)
         {
            _timer = new Timer(1000);
            _timer.addEventListener("timer",timeHandler);
            _timer.start();
         }
         var _loc3_:PandoraLotteryMsg = PandoraManager.instance.pandoraMsg;
         var _loc2_:Date = DateFormatter.parse(_loc3_.stopTime,"YYYY-MM-DD hh:mm:ss");
         var _loc4_:Number = _loc2_.time / 1000 - PlayerManager.instance.currentPlayerModel.sysCurTimeBySecond;
         if(_loc4_ > 0)
         {
            if(_loc4_ >= 60)
            {
               _leftTimeTxt.text = LanguageMgr.GetTranslation("funny.FunnyRightView.active.remainTime",DateFormatter.getFullTimeString(_loc4_));
            }
            else
            {
               _loc5_ = LanguageMgr.GetTranslation("funny.groupbuy.buyRestTimeSecond",_loc4_);
               _leftTimeTxt.text = LanguageMgr.GetTranslation("funny.FunnyRightView.active.remainTime",_loc5_);
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
         clearTimeout(_timeId);
         ObjectUtils.disposeObject(_bg);
         _bg = null;
         ObjectUtils.disposeObject(_personBg);
         _personBg = null;
         ObjectUtils.disposeObject(_leftCountBg);
         _leftCountBg = null;
         ObjectUtils.disposeObject(_leftCountImg);
         _leftCountImg = null;
         ObjectUtils.disposeObject(_activeTxtImg);
         _activeTxtImg = null;
         ObjectUtils.disposeObject(_numberAsset1);
         _numberAsset1 = null;
         ObjectUtils.disposeObject(_numberAsset2);
         _numberAsset2 = null;
         ObjectUtils.disposeObject(_container1);
         _container1 = null;
         ObjectUtils.disposeObject(_container2);
         _container2 = null;
         ObjectUtils.disposeObject(_receiveBtn);
         _receiveBtn = null;
         ObjectUtils.disposeObject(_leftTimeTxt);
         _leftTimeTxt = null;
         ObjectUtils.disposeObject(_activityText);
         _activityText = null;
         ObjectUtils.disposeObject(_turnControl);
         _turnControl = null;
         ObjectUtils.disposeObject(_filter);
         _filter = null;
         ObjectUtils.disposeObject(_pointImg);
         _pointImg = null;
         ObjectUtils.disposeObject(_btnStrip);
         _btnStrip = null;
         if(_list)
         {
            while(_list.length)
            {
               ObjectUtils.disposeObject(_list.pop());
            }
         }
         if(_timer)
         {
            _timer.stop();
            _timer.removeEventListener("timer",timeHandler);
            _timer = null;
         }
         _pandoraMsg = null;
         _posArr = null;
         flickerArr.length = 0;
         super.dispose();
      }
   }
}

