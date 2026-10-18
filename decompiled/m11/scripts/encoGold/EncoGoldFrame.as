package encoGold
{
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.instance.IManualSize;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.ui.controls.IconButton;
   import com.pickgliss.ui.image.MutipleImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import encoGold.view.EncoGoldDayItemView;
   import encoGold.view.EncoGoldMsgView;
   import events.EncoGoldEvents;
   import flash.display.Bitmap;
   import flash.display.BitmapData;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.events.TimerEvent;
   import flash.geom.Rectangle;
   import manager.LanguageMgr;
   import managers.EncoGoldManager;
   import mvc.module.encoGold.EncoGoldModel;
   import utils.LogicUtils;
   import yishi.manager.PlayerManager;
   import yishi.timer.TimerTicker;
   import yishi.utils.DateFormatter;
   import yishi.utils.NumberViewUtils;
   
   public class EncoGoldFrame extends Frame implements IManualSize
   {
      
      private var _backBit:Bitmap;
      
      private var _progressBack:Bitmap;
      
      private var _progress:Bitmap;
      
      private var _progressMask:Sprite;
      
      private var _back:MutipleImage;
      
      private var _lastBtn:IconButton;
      
      private var _nextBtn:IconButton;
      
      private var _itemList:Array = [];
      
      private var _msgView:EncoGoldMsgView;
      
      private var _timeTxt:FilterFrameText;
      
      private var _encoGoldTxt:FilterFrameText;
      
      private var _ruleTitleTxt:FilterFrameText;
      
      private var _ruleMsgTxt:FilterFrameText;
      
      private var _encoGoldBackTxt:FilterFrameText;
      
      private var _numberPanel:Sprite;
      
      private var _numberBtmData:BitmapData;
      
      private var _timer:TimerTicker;
      
      private var _itemPosList:Array = [{
         "x":202,
         "y":65
      },{
         "x":335,
         "y":75
      },{
         "x":415,
         "y":185
      },{
         "x":315,
         "y":360
      },{
         "x":202,
         "y":375
      },{
         "x":110,
         "y":300
      },{
         "x":70,
         "y":270
      },{
         "x":90,
         "y":140
      }];
      
      public function EncoGoldFrame()
      {
         super();
         initView();
         addEvent();
         EncoGoldManager.instance.sendSeverInfo();
      }
      
      public function get viewRectangle() : Rectangle
      {
         return new Rectangle(0,0,760,605);
      }
      
      override public function get groups() : Array
      {
         return ["MAIN_TOOLS_GROUP","BAG_GROUP"];
      }
      
      private function initView() : void
      {
         var _loc1_:EncoGoldDayItemView = null;
         var _loc3_:int = 0;
         _backBit = ComponentFactory.Instance.creatBitmap("asset.encoGold.back");
         _progressBack = ComponentFactory.Instance.creatBitmap("asset.encoGold.proessBack");
         _progress = ComponentFactory.Instance.creatBitmap("asset.encoGold.proessShow");
         _progressMask = new Sprite();
         _progressMask.graphics.beginFill(16711680);
         _progressMask.graphics.drawRect(0,0,360,_progress.height);
         _progressMask.x = _progress.x + 10;
         _progressMask.y = _progress.y;
         _back = ComponentFactory.Instance.creatComponentByStylename("encoGold.back");
         _lastBtn = ComponentFactory.Instance.creatComponentByStylename("encoGold.lastDayBtn");
         _nextBtn = ComponentFactory.Instance.creatComponentByStylename("encoGold.nextDayBtn");
         _msgView = ComponentFactory.Instance.creatCustomObject("encoGold.encoGoldMsgView");
         _timeTxt = ComponentFactory.Instance.creatComponentByStylename("encoGold.hasTimeTxt");
         _encoGoldTxt = ComponentFactory.Instance.creatComponentByStylename("encoGold.hasGoldTxt");
         _ruleTitleTxt = ComponentFactory.Instance.creatComponentByStylename("encoGold.msgRuleTitleTxt");
         _ruleMsgTxt = ComponentFactory.Instance.creatComponentByStylename("encoGold.msgRuleTxt");
         _encoGoldBackTxt = ComponentFactory.Instance.creatComponentByStylename("encoGold.encoGoldBackTxt");
         _numberBtmData = ComponentFactory.Instance.creatBitmapData("asset.encoGold.goldNum").clone();
         _numberPanel = ComponentFactory.Instance.creatCustomObject("encoGold.scorepanel");
         addToContent(_backBit);
         addToContent(_progressBack);
         addToContent(_progress);
         addToContent(_progressMask);
         addToContent(_back);
         addToContent(_lastBtn);
         addToContent(_nextBtn);
         addToContent(_msgView);
         addToContent(_timeTxt);
         addToContent(_encoGoldTxt);
         addToContent(_ruleTitleTxt);
         addToContent(_ruleMsgTxt);
         addToContent(_encoGoldBackTxt);
         addToContent(_numberPanel);
         _progress.mask = _progressMask;
         var _loc2_:int = int(_itemPosList.length);
         _loc3_ = 0;
         while(_loc3_ < _loc2_)
         {
            _loc1_ = new EncoGoldDayItemView(_loc3_);
            addToContent(_loc1_);
            _loc1_.x = _itemPosList[_loc3_].x;
            _loc1_.y = _itemPosList[_loc3_].y;
            _itemList.push(_loc1_);
            _loc3_ += 1;
         }
         _ruleTitleTxt.text = LanguageMgr.GetTranslation("encoGold.encoGoldTips03");
         _ruleMsgTxt.htmlText = LanguageMgr.GetTranslation("encoGold.encoGoldTips04");
      }
      
      private function addEvent() : void
      {
         addEventListener("response",__frameResponse);
         _lastBtn.addEventListener("click",__onLastDayClick);
         _nextBtn.addEventListener("click",__onNextDayClick);
         model.addEventListener("ENCO_GOLD_INFO_UP_DATA",__updataInfo);
      }
      
      private function removeEvent() : void
      {
         removeEventListener("response",__frameResponse);
         _lastBtn.removeEventListener("click",__onLastDayClick);
         _nextBtn.removeEventListener("click",__onNextDayClick);
         model.removeEventListener("ENCO_GOLD_INFO_UP_DATA",__updataInfo);
         if(_timer)
         {
            _timer.stop();
            _timer.removeEventListener("timer",timeHandler);
         }
      }
      
      private function timeTick() : void
      {
         if(_timer == null)
         {
            _timer = new TimerTicker(1000);
            _timer.addEventListener("timer",timeHandler);
            _timer.start();
         }
         timeHandler(null);
      }
      
      protected function timeHandler(param1:TimerEvent) : void
      {
         var _loc3_:Number = Number(PlayerManager.instance.currentPlayerModel.sysCurTimeBySecond);
         var _loc2_:Number = DateFormatter.parse(model.stopTime,"YYYY-MM-DD hh:mm:ss").time / 1000;
         if(_loc3_ >= _loc2_)
         {
            if(_timer)
            {
               _timer.stop();
               _timer.removeEventListener("timer",timeHandler);
               _timer = null;
            }
         }
         else
         {
            _timeTxt.text = LanguageMgr.GetTranslation("encoGold.encoGoldTimeTips",DateFormatter.getFullTimeString(_loc2_ - _loc3_));
         }
      }
      
      private function __updataInfo(param1:EncoGoldEvents = null) : void
      {
         var _loc3_:int = int(model.totalTakePoint);
         var _loc5_:int = int(model.totalBackPoint);
         var _loc4_:int = int(model.maxBackPoint);
         var _loc6_:String = "";
         var _loc2_:String = "";
         if(_loc5_ > 0)
         {
            _loc6_ = LanguageMgr.GetTranslation("encoGold.encoGoldTips02");
            _loc2_ = LanguageMgr.GetTranslation("encoGold.encoGoldTips15",0,_loc4_,_loc6_);
         }
         else
         {
            _loc6_ = "";
            _loc2_ = LanguageMgr.GetTranslation("encoGold.encoGoldTips01",_loc3_,_loc4_,_loc6_);
         }
         _encoGoldTxt.htmlText = _loc2_;
         _progressMask.scaleX = _loc3_ / _loc4_;
         _encoGoldBackTxt.text = LanguageMgr.GetTranslation("encoGold.encoGoldTips17",model.limitBackPer,model.maxBackPer);
         NumberViewUtils.getNumberView(model.limitConsumePoint,_numberPanel,_numberBtmData,13,20,10,13,"0123456789",1);
         timeTick();
         changeDay();
      }
      
      private function initListInfo() : void
      {
         var _loc2_:EncoGoldDayItemView = null;
         var _loc4_:int = 0;
         var _loc1_:Array = model.currentMsgList;
         var _loc3_:int = int(_itemPosList.length);
         _loc4_ = 0;
         while(_loc4_ < _loc3_)
         {
            _loc2_ = _itemList[_loc4_];
            _loc2_.visible = false;
            if(_loc4_ < _loc1_.length)
            {
               _loc2_.visible = true;
               _loc2_.info = _loc1_[_loc4_];
            }
            _loc4_ += 1;
         }
         _msgView.creatList();
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
      
      private function __onLastDayClick(param1:MouseEvent) : void
      {
         var _loc2_:int = int(model.currentDay);
         if(_loc2_ - 1 > 0)
         {
            model.currentDay -= 1;
         }
         changeDay();
      }
      
      private function __onNextDayClick(param1:MouseEvent) : void
      {
         var _loc2_:int = int(model.currentDay);
         if(_loc2_ + 1 <= model.dayMsgList.length)
         {
            model.currentDay += 1;
         }
         changeDay();
      }
      
      private function changeDay() : void
      {
         var _loc1_:int = int(model.currentDay);
         _lastBtn.enable = true;
         _nextBtn.enable = true;
         if(_loc1_ == 1)
         {
            _lastBtn.enable = false;
         }
         else if(_loc1_ == model.dayMsgList.length)
         {
            _nextBtn.enable = false;
         }
         initListInfo();
      }
      
      public function show() : void
      {
         this.titleText = LanguageMgr.GetTranslation("ui.toptoolbar.TopToolsBar.tipData_encoGold");
         LayerManager.Instance.addToLayer(this,3,true,true,1);
      }
      
      private function get model() : EncoGoldModel
      {
         return EncoGoldManager.instance.model;
      }
      
      override public function dispose() : void
      {
         removeEvent();
         ObjectUtils.disposeObject(_backBit);
         _backBit = null;
         ObjectUtils.disposeObject(_progressBack);
         _progressBack = null;
         ObjectUtils.disposeObject(_progress);
         _progress = null;
         ObjectUtils.disposeObject(_progressMask);
         _progressMask = null;
         ObjectUtils.disposeObject(_back);
         _back = null;
         ObjectUtils.disposeObject(_lastBtn);
         _lastBtn = null;
         ObjectUtils.disposeObject(_nextBtn);
         _nextBtn = null;
         ObjectUtils.disposeObject(_msgView);
         _msgView = null;
         ObjectUtils.disposeObject(_timeTxt);
         _timeTxt = null;
         ObjectUtils.disposeObject(_encoGoldTxt);
         _encoGoldTxt = null;
         ObjectUtils.disposeObject(_ruleTitleTxt);
         _ruleTitleTxt = null;
         ObjectUtils.disposeObject(_ruleMsgTxt);
         _ruleMsgTxt = null;
         ObjectUtils.disposeObject(_numberPanel);
         _numberPanel = null;
         ObjectUtils.disposeObject(_numberBtmData);
         _numberBtmData = null;
         ObjectUtils.disposeObject(_encoGoldBackTxt);
         _encoGoldBackTxt = null;
         _timer = null;
         LogicUtils.disposeDisplayCollection(_itemList);
         _itemList = null;
         _itemPosList = [];
         super.dispose();
      }
   }
}

