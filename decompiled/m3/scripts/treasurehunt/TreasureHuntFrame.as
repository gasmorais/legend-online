package treasurehunt
{
   import bag.events.BagEvent;
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.instance.IManualSize;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.BaseButton;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.ui.controls.IconButton;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.image.MutipleImage;
   import com.pickgliss.ui.image.ScaleBitmapImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import com.pickgliss.utils.SoundManager;
   import com.road.yishi.proto.seek.MessageForSeekMsg;
   import flash.display.Bitmap;
   import flash.display.MovieClip;
   import flash.display.Shape;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.events.TimerEvent;
   import flash.geom.Point;
   import flash.geom.Rectangle;
   import flash.utils.Timer;
   import manager.LanguageMgr;
   import managers.TreasureHuntManager;
   import mvc.controler.TreasureHuntControler;
   import mvc.module.treasurehunt.HuntEvent;
   import mvc.module.treasurehunt.HuntPointModel;
   import yishi.datas.ai.AIBaseInfo;
   import yishi.interfaces.IEnterFrame;
   import yishi.manager.EnterFrameManager;
   import yishi.manager.FrameControllerManager;
   import yishi.manager.GoodsManager;
   import yishi.manager.TempleteManager;
   import yishi.utils.DateFormatter;
   
   public class TreasureHuntFrame extends Frame implements Disposeable, IManualSize, IEnterFrame
   {
      
      private var _back:ScaleBitmapImage;
      
      private var _pointContain:Component;
      
      private var _pointBack:MutipleImage;
      
      private var _shineMc:MovieClip;
      
      private var _pointTxt:FilterFrameText;
      
      private var _addNoteTxt:FilterFrameText;
      
      private var _zeroAlertTxt:FilterFrameText;
      
      private var _addCountBtn:BaseButton;
      
      private var _worldBg:Bitmap;
      
      private var _worldBgMask:Shape;
      
      private var _aboveContain:Sprite;
      
      private var _exchangeBtn:IconButton;
      
      private var _huntBtn:IconButton;
      
      private var _person:HeroHunterView;
      
      private var _prePos:Point;
      
      private var _infoTxtList:Array = [];
      
      private var _infoList:Array = [];
      
      private var _timer:Timer;
      
      private var _tickleSec:int;
      
      private var _nextAddTime:int;
      
      public function TreasureHuntFrame()
      {
         super();
         initView();
         initEvent();
      }
      
      override public function get groups() : Array
      {
         return ["MAIN_TOOLS_GROUP","BAG_GROUP"];
      }
      
      public function get viewRectangle() : Rectangle
      {
         return new Rectangle(0,0,1000,600);
      }
      
      private function initView() : void
      {
         _aboveContain = new Sprite();
         _back = ComponentFactory.Instance.creatComponentByStylename("treasurehunt.DescribeBackground");
         _worldBg = ComponentFactory.Instance.creatBitmap("asset.treasurehunt.treasurehuntBg");
         _pointContain = ComponentFactory.Instance.creatComponentByStylename("treasurehunt.magicPointContain");
         _pointBack = ComponentFactory.Instance.creatComponentByStylename("treasurehunt.magicPointImage");
         _pointTxt = ComponentFactory.Instance.creatComponentByStylename("treasurehunt.PointTextStyle1");
         _shineMc = ComponentFactory.Instance.creatCustomObject("treasurehunt.starShineMc");
         _exchangeBtn = ComponentFactory.Instance.creatComponentByStylename("treasurehunt.exchangeBtn");
         _huntBtn = ComponentFactory.Instance.creatComponentByStylename("treasurehunt.huntStartBtn");
         _addNoteTxt = ComponentFactory.Instance.creatComponentByStylename("treasurehunt.AddSeekCount");
         _addCountBtn = ComponentFactory.Instance.creatComponentByStylename("treasurehunt.AddSeekCountBtn");
         var _loc1_:String = TempleteManager.instance.goodsTemplateCate.getTemplateByID(2131022).TemplateName;
         _addCountBtn.tipData = [LanguageMgr.GetTranslation("treasurehunt.addCountBtn.tipData",_loc1_)];
         _zeroAlertTxt = ComponentFactory.Instance.creatComponentByStylename("treasurehunt.ZeroAlertCount");
         _person = ComponentFactory.Instance.creatComponentByStylename("treasurehunt.HeroHunterView");
         addToContent(_back);
         addToContent(_aboveContain);
         addToContent(_pointContain);
         addToContent(_exchangeBtn);
         addToContent(_huntBtn);
         addToContent(_addNoteTxt);
         addToContent(_addCountBtn);
         addToContent(_zeroAlertTxt);
         _pointContain.addChild(_pointBack);
         _pointContain.addChild(_pointTxt);
         _aboveContain.addChild(_worldBg);
         _aboveContain.addChild(_shineMc);
         _pointContain.tipData = LanguageMgr.GetTranslation("hunt.TreasureHuntFrame.exchangeBtnTipData");
         _exchangeBtn.tipData = LanguageMgr.GetTranslation("hunt.TreasureHuntFrame.exchangeBtnTipData");
         _pointTxt.text = GoodsManager.instance.getGoodsNumByTempId(2131019).toString();
         _worldBgMask = new Shape();
         _worldBgMask.graphics.beginFill(16777215,0);
         _worldBgMask.graphics.drawRect(0,0,_worldBg.width,_worldBg.height);
         _worldBgMask.graphics.endFill();
         _worldBgMask.x = _worldBg.x;
         _worldBgMask.y = _worldBg.y;
         _worldBg.mask = _worldBgMask;
         _aboveContain.addChild(_worldBgMask);
         controller.sendHuntRequest(1);
         setInfoTexts();
      }
      
      private function setInfoTexts() : void
      {
         var _loc2_:int = 0;
         var _loc1_:FilterFrameText = null;
         _loc2_ = 0;
         while(_loc2_ < 3)
         {
            _loc1_ = ComponentFactory.Instance.creatComponentByStylename("treasurehunt.InfoTextStyle1");
            _loc1_.y += _loc1_.height * _loc2_;
            _aboveContain.addChild(_loc1_);
            _infoTxtList.push(_loc1_);
            _loc2_++;
         }
      }
      
      private function initEvent() : void
      {
         addEventListener("response",__frameResponse);
         TreasureHuntManager.instance.addEventListener("HUNT_TEM",__refreshHandler);
         TreasureHuntManager.instance.addEventListener("INFO_SHOW",__infoTxtHandler);
         _exchangeBtn.addEventListener("click",_exchangeBtnClick);
         _huntBtn.addEventListener("click",_huntBtnClick);
         _addCountBtn.addEventListener("click",_addSeekCountClick);
         EnterFrameManager.instance.registeEnterFrame(this);
         GoodsManager.instance.addEventListener("UPDATE_BAG",__updateMagicPoint);
         GoodsManager.instance.addEventListener("DELETE_BAG",__updateMagicPoint);
      }
      
      private function __refreshHandler(param1:HuntEvent = null) : void
      {
         var _loc3_:AIBaseInfo = null;
         var _loc2_:Point = model.getPos();
         if(model.op == 1)
         {
            _person.x = _loc2_.x;
            _person.y = _loc2_.y;
            _aboveContain.addChild(_person);
            _person.scaleX = _person.scaleY = 0.6;
            _prePos = _loc2_;
            _loc3_ = new AIBaseInfo();
            _loc3_.isLiving = true;
            _loc3_.speed = 2;
            model.aiInfo = _loc3_;
            _person.info = _loc3_;
            if(model.state == 1)
            {
               controller.showDialogFrame();
            }
            if(model.seekCount < 10)
            {
               setTime();
            }
         }
         else if(model.op == 3 && model.state == 1)
         {
            model.aiInfo.pathInfo = [_prePos,_loc2_];
            _prePos = _loc2_;
            closeButton.enable = false;
         }
         else if(model.op == 4 && model.state == 0)
         {
            controller.closeAlerFrame();
         }
         _nextAddTime = model.nextAddTime;
         setTxtState();
         _shineMc.x = _loc2_.x - 21;
         _shineMc.y = _loc2_.y;
         if(model.seekCount < 10 && _timer)
         {
            _timer.reset();
            _timer.repeatCount = model.nextAddTime;
            _timer.start();
         }
      }
      
      private function setTxtState() : void
      {
         var _loc1_:String = LanguageMgr.GetTranslation("hunt.TreasureHuntFrame.lastcount",model.seekCount);
         _loc1_ += "\n";
         if(model.seekCount > 10 || model.seekCount == 10)
         {
            _loc1_ += LanguageMgr.GetTranslation("hunt.TreasureHuntFrame.huntcountFull");
         }
         else
         {
            _loc1_ += LanguageMgr.GetTranslation("hunt.TreasureHuntFrame.addLastTime",DateFormatter.getFullTimeString(_nextAddTime));
         }
         _huntBtn.tipData = _loc1_;
         _huntBtn.enable = model.seekCount > 0;
         if(model.op == 3 && model.state == 1)
         {
            _huntBtn.enable = false;
            _addCountBtn.enable = false;
         }
         _addNoteTxt.text = LanguageMgr.GetTranslation("hunt.TreasureHuntFrame.lastNum",model.seekCount);
         _addNoteTxt.visible = model.seekCount > 0;
         _zeroAlertTxt.text = LanguageMgr.GetTranslation("hunt.TreasureHuntFrame.zeroAlertTime",DateFormatter.getFullTimeString(_nextAddTime));
         _zeroAlertTxt.visible = model.seekCount == 0;
      }
      
      private function setTime() : void
      {
         _timer = new Timer(1000,model.nextAddTime / 1000);
         _timer.addEventListener("timer",onTimerHandler);
         _timer.addEventListener("timerComplete",onTimerCompleteHandler);
         _timer.start();
      }
      
      private function onTimerHandler(param1:Event) : void
      {
         _tickleSec = _timer.currentCount;
         if(_tickleSec % 60 == 0)
         {
            _nextAddTime -= 60;
            if(_nextAddTime < 0)
            {
               _nextAddTime = 0;
            }
            setTxtState();
         }
      }
      
      private function onTimerCompleteHandler(param1:TimerEvent) : void
      {
         _timer.stop();
         controller.sendHuntRequest(2);
      }
      
      private function removeTime() : void
      {
         if(_timer)
         {
            _timer.stop();
            _timer.removeEventListener("timer",onTimerHandler);
            _timer.removeEventListener("timerComplete",onTimerCompleteHandler);
         }
         _timer = null;
      }
      
      private function __infoTxtHandler(param1:HuntEvent) : void
      {
         var _loc3_:int = 0;
         var _loc2_:MessageForSeekMsg = param1.data as MessageForSeekMsg;
         _infoList.push(_loc2_.info);
         while(_infoList.length > 3)
         {
            _infoList.shift();
         }
         _loc3_ = 0;
         while(_loc3_ < 3)
         {
            if(_infoList[_loc3_])
            {
               FilterFrameText(_infoTxtList[_loc3_]).text = _infoList[_loc3_];
            }
            _loc3_++;
         }
      }
      
      private function _exchangeBtnClick(param1:MouseEvent) : void
      {
         SoundManager.instance.play("022");
         controller.showExchangeAlerFrame();
      }
      
      private function _huntBtnClick(param1:MouseEvent) : void
      {
         SoundManager.instance.play("022");
         controller.sendHuntRequest(3);
      }
      
      private function _addSeekCountClick(param1:MouseEvent) : void
      {
         SoundManager.instance.play("022");
         controller.sendHuntRequest(7);
      }
      
      private function __updateMagicPoint(param1:BagEvent) : void
      {
         _pointTxt.text = GoodsManager.instance.getGoodsNumByTempId(2131019).toString();
      }
      
      private function get controller() : TreasureHuntControler
      {
         return FrameControllerManager.instance.treasureHuntControler;
      }
      
      private function get model() : HuntPointModel
      {
         return TreasureHuntManager.instance.model;
      }
      
      public function setStartBtnState(param1:Boolean) : void
      {
         _huntBtn.enable = param1;
         _addCountBtn.enable = param1;
         _huntBtn.enable = model.seekCount > 0;
      }
      
      private function removeEvent() : void
      {
         removeEventListener("response",__frameResponse);
         TreasureHuntManager.instance.removeEventListener("HUNT_TEM",__refreshHandler);
         TreasureHuntManager.instance.removeEventListener("INFO_SHOW",__infoTxtHandler);
         _exchangeBtn.removeEventListener("click",_exchangeBtnClick);
         _huntBtn.removeEventListener("click",_huntBtnClick);
         _addCountBtn.removeEventListener("click",_addSeekCountClick);
         EnterFrameManager.instance.unRegisteEnterFrame(this);
         GoodsManager.instance.removeEventListener("UPDATE_BAG",__updateMagicPoint);
         GoodsManager.instance.removeEventListener("DELETE_BAG",__updateMagicPoint);
      }
      
      private function __frameResponse(param1:FrameEvent) : void
      {
         switch(int(param1.responseCode))
         {
            case 0:
            case 1:
               if(closeButton.enable)
               {
                  dispose();
                  controller.closeAlerFrame();
               }
         }
      }
      
      public function enterFrame() : void
      {
         if(_person && _person.info)
         {
            _person.execute();
         }
      }
      
      public function show() : void
      {
         titleText = LanguageMgr.GetTranslation("hunt.TreasureHuntFrame.title");
         LayerManager.Instance.addToLayer(this,3,true,true);
      }
      
      override public function dispose() : void
      {
         removeEvent();
         removeTime();
         _infoList = null;
         _infoTxtList = null;
         ObjectUtils.disposeAllChildren(this);
         super.dispose();
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}

