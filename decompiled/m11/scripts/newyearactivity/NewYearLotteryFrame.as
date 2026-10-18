package newyearactivity
{
   import bag.helper.BagHelper;
   import chat.datas.ChatData;
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.ui.controls.IconButton;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.image.MutipleImage;
   import com.pickgliss.ui.image.ScaleFrameImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectPool;
   import com.pickgliss.utils.ObjectUtils;
   import events.NewYearLotteryEvent;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.events.TimerEvent;
   import flash.utils.Timer;
   import manager.LanguageMgr;
   import managers.NewYearSocketOutManager;
   import mvc.ModuleFrameInfo;
   import newyearact.NewYearLotteryModel;
   import yishi.datas.ComponentGroupType;
   import yishi.datas.goods.GoodsInfo;
   import yishi.datas.playerinfo.PlayerModel;
   import yishi.events.NotificationEvent;
   import yishi.keyboard.KeyBoardRegister;
   import yishi.manager.NewYearActManager;
   import yishi.manager.NotificationManager;
   import yishi.manager.PlayerManager;
   import yishi.utils.DateFormatter;
   import yishi.view.tips.MessageTipManager;
   
   public class NewYearLotteryFrame extends Frame implements Disposeable
   {
      
      private var _bg:MutipleImage;
      
      private var _box:ScaleFrameImage;
      
      private var _tipTxt1:FilterFrameText;
      
      private var _tipTxt2:FilterFrameText;
      
      private var _tipTxt3:FilterFrameText;
      
      private var _openBtn:IconButton;
      
      private var _itemList:Array;
      
      private var _itemContainer:Sprite;
      
      private var _turnControl:NewYearLotteryTurnControl;
      
      private var _goodsList:Array;
      
      private var _timer:Timer;
      
      private var _model:NewYearLotteryModel = NewYearActManager.instance.lotteryModel;
      
      private var _playerModel:PlayerModel = PlayerManager.instance.currentPlayerModel;
      
      private var isPlayEff:Boolean = false;
      
      public function NewYearLotteryFrame()
      {
         _model.rewardItem = 0;
         _model.count = 0;
         super();
         initView();
         initViewList();
         initEvent();
         initData();
         NewYearSocketOutManager.sendLotteryRequest();
      }
      
      private function initView() : void
      {
         this.titleText = LanguageMgr.GetTranslation("ui.toptoolbar.topToolBar.newyearLottery.tipData");
         _bg = ComponentFactory.Instance.creatComponentByStylename("newyearact.NewYearLotteryFrame.FrameBg");
         _box = ComponentFactory.Instance.creatComponentByStylename("newyearact.NewYearLotteryFrame.Box");
         _tipTxt1 = ComponentFactory.Instance.creatComponentByStylename("newyearact.NewYearLotteryFrame.TipTxt1");
         _tipTxt2 = ComponentFactory.Instance.creatComponentByStylename("newyearact.NewYearLotteryFrame.TipTxt2");
         _tipTxt3 = ComponentFactory.Instance.creatComponentByStylename("newyearact.NewYearLotteryFrame.TipTxt3");
         _openBtn = ComponentFactory.Instance.creatComponentByStylename("newyearact.NewYearLotteryFrame.OpenBtn");
         _box.setFrame(1);
         addToContent(_bg);
         addToContent(_box);
         addToContent(_tipTxt1);
         addToContent(_tipTxt2);
         addToContent(_tipTxt3);
         addToContent(_openBtn);
      }
      
      private function initViewList() : void
      {
         var _loc2_:int = 0;
         var _loc1_:NewYearLotteryItem = null;
         _itemContainer = new Sprite();
         _itemContainer.x = 80;
         _itemContainer.y = 230;
         addToContent(_itemContainer);
         _itemList = [];
         _loc2_ = 0;
         while(_loc2_ < 10)
         {
            _loc1_ = new NewYearLotteryItem();
            _itemContainer.addChild(_loc1_);
            _itemList.push(_loc1_);
            _loc1_.Index = _loc2_;
            if(_loc2_ < 5)
            {
               _loc1_.x = int(_loc2_ % 5) * 65;
            }
            else
            {
               _loc1_.x = (int(4 - _loc2_ % 5)) * 65;
            }
            _loc1_.y = int(_loc2_ / 5) * 65;
            _loc2_++;
         }
         _turnControl = new NewYearLotteryTurnControl();
         _turnControl.defaultTurn(_itemList);
      }
      
      private function initData() : void
      {
         var _loc1_:int = 0;
         _goodsList = _model.lotteryGoodsList;
         _tipTxt1.text = LanguageMgr.GetTranslation("newyearactivity.NewYearLotteryFrame.TipTxt1",_model.onceNeedPoint);
         _loc1_ = 0;
         while(_loc1_ < _itemList.length)
         {
            _itemList[_loc1_].data = _goodsList[_loc1_].templateId;
            _itemList[_loc1_].count = _goodsList[_loc1_].count;
            _loc1_++;
         }
      }
      
      private function uninitView() : void
      {
         ObjectUtils.disposeObject(_bg);
         _bg = null;
         ObjectUtils.disposeObject(_box);
         _box = null;
         ObjectUtils.disposeObject(_tipTxt1);
         _tipTxt1 = null;
         ObjectUtils.disposeObject(_tipTxt2);
         _tipTxt2 = null;
         ObjectUtils.disposeObject(_tipTxt3);
         _tipTxt3 = null;
         ObjectUtils.disposeObject(_openBtn);
         _openBtn = null;
         ObjectUtils.disposeObject(_turnControl);
         _turnControl = null;
         ObjectUtils.disposeAllChildren(_itemContainer);
         _itemContainer = null;
         ObjectUtils.disposeAllChildren(this);
      }
      
      private function initEvent() : void
      {
         addEventListener("response",_respose);
         _openBtn.addEventListener("click",__openBtnClickHandler);
         NewYearActManager.instance.addEventListener("LOTTERY_INFO",__lotteryInfoHandler);
         _model.addEventListener("LOTTERY_EFFCT_COMPLETE",__effctCompleteHandler);
         NotificationManager.instance.addEventListener("REFRESH_NEWYEAR_BTN",hide);
         _timer = new Timer(1000);
         _timer.addEventListener("timer",__timerHandler);
         _timer.start();
      }
      
      private function hide(param1:NotificationEvent) : void
      {
         dispose();
      }
      
      private function removeEvent() : void
      {
         removeEventListener("response",_respose);
         _openBtn.removeEventListener("click",__openBtnClickHandler);
         NewYearActManager.instance.removeEventListener("LOTTERY_INFO",__lotteryInfoHandler);
         _model.removeEventListener("LOTTERY_EFFCT_COMPLETE",__effctCompleteHandler);
         NotificationManager.instance.removeEventListener("REFRESH_NEWYEAR_BTN",hide);
         if(_timer)
         {
            _timer.stop();
            _timer.removeEventListener("timer",__timerHandler);
         }
      }
      
      private function __timerHandler(param1:TimerEvent) : void
      {
         setRemainTime();
      }
      
      private function __effctCompleteHandler(param1:NewYearLotteryEvent) : void
      {
         var _loc3_:int = 0;
         var _loc6_:GoodsInfo = null;
         var _loc5_:int = 0;
         var _loc4_:ChatData = null;
         var _loc7_:String = null;
         var _loc2_:String = null;
         closeButton.enable = true;
         _openBtn.enable = true;
         isPlayEff = false;
         _box.setFrame(2);
         _turnControl.defaultTurn(_itemList);
         if(_model.rewardItem != 0)
         {
            _loc3_ = int(_goodsList.length);
            _loc5_ = 0;
            while(_loc5_ < _loc3_)
            {
               _loc6_ = _goodsList[_loc5_] as GoodsInfo;
               if(_loc6_.templateId == _model.rewardItem && _loc6_.count == _model.count)
               {
                  break;
               }
               _loc5_++;
            }
            if(_loc6_)
            {
               _loc7_ = LanguageMgr.GetTranslation("lottery.LotteryFrame.dropTips",_loc6_.templateInfo.TemplateName,_loc6_.count);
               _loc4_ = ObjectPool.getObject(ChatData) as ChatData;
               if(_loc4_)
               {
                  _loc4_.channel = 3;
                  _loc4_.msg = _loc7_;
                  _loc4_.commit();
                  NotificationManager.instance.sendNotification("ADD_CHAT",_loc4_);
                  MessageTipManager.instance().show(_loc7_);
               }
               if(!_model.isMail)
               {
                  BagHelper.instance.playNewGoodsEffect(_loc6_);
               }
            }
         }
         if(_model.isMail)
         {
            _loc2_ = LanguageMgr.GetTranslation("vip.view.VipBoxFrame.command03");
            MessageTipManager.instance().show(_loc2_);
         }
      }
      
      private function __lotteryInfoHandler(param1:NewYearLotteryEvent) : void
      {
         var _loc2_:int = 0;
         var _loc4_:GoodsInfo = null;
         var _loc3_:int = 0;
         refreshView();
         if(_model.rewardItem != 0)
         {
            _loc2_ = int(_goodsList.length);
            _loc3_ = 0;
            while(_loc3_ < _goodsList.length)
            {
               _loc4_ = _goodsList[_loc3_] as GoodsInfo;
               if(_loc4_.templateId == _model.rewardItem && _loc4_.count == _model.count)
               {
                  _turnControl.turnPlate(_loc3_ + 1);
               }
               _loc3_++;
            }
         }
      }
      
      private function __openBtnClickHandler(param1:MouseEvent) : void
      {
         if(_model.lotteryCount <= 0)
         {
            MessageTipManager.instance().show(LanguageMgr.GetTranslation("lottery.LotteryFrame.noLeftCounts"));
            return;
         }
         if(_model.lotteryGoodsList.length <= 0)
         {
            return;
         }
         isPlayEff = true;
         closeButton.enable = false;
         _openBtn.enable = false;
         _box.setFrame(1);
         NewYearSocketOutManager.sendLotteryRequest(1);
      }
      
      private function _respose(param1:FrameEvent) : void
      {
         switch(int(param1.responseCode))
         {
            case 0:
            case 1:
               if(!isPlayEff)
               {
                  dispose();
               }
         }
      }
      
      public function show(param1:ModuleFrameInfo = null) : void
      {
         LayerManager.Instance.addToLayer(this,3,true,true,1);
         KeyBoardRegister.instance.keyEnable = false;
      }
      
      public function setRemainTime() : void
      {
         var _loc1_:Number = _model.endTime / 1000 - _playerModel.sysCurTimeBySecond;
         if(_loc1_ >= 60)
         {
            _tipTxt3.text = LanguageMgr.GetTranslation("newyearactivity.NewYearLotteryFrame.TipTxt3",DateFormatter.getFullTimeString(_loc1_));
         }
         else if(_loc1_ > 0)
         {
            _tipTxt3.text = LanguageMgr.GetTranslation("newyearactivity.NewYearLotteryFrame.TipTxt3",DateFormatter.getFullDateString(_loc1_));
         }
         else
         {
            _tipTxt3.text = LanguageMgr.GetTranslation("feedback.FeedBackItem.outDate");
         }
         if(_model.beginTime > _playerModel.nowDate)
         {
            _tipTxt3.visible = false;
         }
         else
         {
            _tipTxt3.visible = true;
         }
      }
      
      private function refreshView() : void
      {
         _tipTxt2.text = LanguageMgr.GetTranslation("newyearactivity.NewYearLotteryFrame.TipTxt2",_model.lotteryCount);
         setRemainTime();
      }
      
      override public function get groups() : Array
      {
         return [ComponentGroupType.NONE];
      }
      
      override public function dispose() : void
      {
         KeyBoardRegister.instance.keyEnable = true;
         removeEvent();
         uninitView();
         _goodsList = null;
         super.dispose();
      }
   }
}

