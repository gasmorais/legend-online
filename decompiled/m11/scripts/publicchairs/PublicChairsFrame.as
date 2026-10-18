package publicchairs
{
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.instance.IManualSize;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.ui.controls.IconButton;
   import com.pickgliss.ui.image.Image;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import com.pickgliss.utils.SoundManager;
   import com.road.yishi.proto.active.ChairsListMsg;
   import flash.display.Bitmap;
   import flash.display.DisplayObject;
   import flash.display.MovieClip;
   import flash.events.MouseEvent;
   import flash.events.TimerEvent;
   import flash.geom.Rectangle;
   import mainBar.StripView;
   import manager.LanguageMgr;
   import yishi.datas.templates.GoodsTemplateInfo;
   import yishi.events.NotificationEvent;
   import yishi.manager.NotificationManager;
   import yishi.manager.PlayerManager;
   import yishi.manager.PublicChairsManager;
   import yishi.manager.RechargeAlertMannager;
   import yishi.manager.TempleteManager;
   import yishi.timer.TimerTicker;
   import yishi.utils.DateFormatter;
   
   public class PublicChairsFrame extends Frame implements IManualSize
   {
      
      private var _bg:DisplayObject;
      
      private var _icon1:Image;
      
      private var _icon2:Image;
      
      private var _luckNote:FilterFrameText;
      
      private var _chairsNote:FilterFrameText;
      
      private var _chairsNames:FilterFrameText;
      
      private var _greenBar:MovieClip;
      
      private var _chargeBtn:IconButton;
      
      private var _receiveBtn:IconButton;
      
      private var _currentChairsTxt:FilterFrameText;
      
      private var _rewardCountsTxt:FilterFrameText;
      
      private var _leftTimeTxt:FilterFrameText;
      
      private var _timer:TimerTicker;
      
      private var _chairsMsg:ChairsListMsg;
      
      private var _chairsProgressTxt:FilterFrameText;
      
      private var _chairsStrip:StripView;
      
      private var _chairsNote1:Bitmap;
      
      private var _chairsNote2Bg:Bitmap;
      
      private var _chairsNote2:FilterFrameText;
      
      private var _redBg:Bitmap;
      
      private var _redBg2:Bitmap;
      
      private var _chairsNote3:Bitmap;
      
      public function PublicChairsFrame()
      {
         super();
         initView();
         addEvent();
         PublicChairsManager.instance.OperateChairsReq(1);
      }
      
      public function get viewRectangle() : Rectangle
      {
         return new Rectangle(0,0,688,593);
      }
      
      override public function get groups() : Array
      {
         return ["MAIN_TOOLS_GROUP","BAG_GROUP"];
      }
      
      private function initView() : void
      {
         titleText = LanguageMgr.GetTranslation("publicchairs.PublicChairsFrame.titleText");
         _bg = ComponentFactory.Instance.creatBitmap("asset.publicchairs.Bg");
         _icon1 = ComponentFactory.Instance.creatComponentByStylename("publicchairs.itemIcon1");
         _icon2 = ComponentFactory.Instance.creatComponentByStylename("publicchairs.itemIcon2");
         _luckNote = ComponentFactory.Instance.creatComponentByStylename("publicchairs.luckNote");
         _chairsNote = ComponentFactory.Instance.creatComponentByStylename("publicchairs.chairsNote");
         _chairsNames = ComponentFactory.Instance.creatComponentByStylename("publicchairs.chairsNames");
         _greenBar = ComponentFactory.Instance.creatCustomObject("asset.publicchairs.greenBar");
         _chargeBtn = ComponentFactory.Instance.creatComponentByStylename("publicchairs.chargeBtn");
         _receiveBtn = ComponentFactory.Instance.creatComponentByStylename("publicchairs.receiveBtn");
         _currentChairsTxt = ComponentFactory.Instance.creatComponentByStylename("publicchairs.currentChairsTxt");
         _rewardCountsTxt = ComponentFactory.Instance.creatComponentByStylename("publicchairs.rewardCountsTxt");
         _leftTimeTxt = ComponentFactory.Instance.creatComponentByStylename("publicchairs.leftTimeTxt");
         _chairsProgressTxt = ComponentFactory.Instance.creatComponentByStylename("publicchairs.fashionProgressTxt");
         _chairsStrip = ComponentFactory.Instance.creatCustomObject("publicchairs.fashionProgressStrip");
         _chairsStrip.setHitArea(0,0,208,24);
         _chairsNote1 = ComponentFactory.Instance.creatBitmap("asset.publicchairs.chairsNote1");
         _chairsNote2Bg = ComponentFactory.Instance.creatBitmap("asset.publicchairs.chairsNote2Bg");
         _chairsNote2 = ComponentFactory.Instance.creatComponentByStylename("publicchairs.chairsNoteTxt");
         _redBg = ComponentFactory.Instance.creatBitmap("asset.publicchairs.chairsRedBg");
         _redBg2 = ComponentFactory.Instance.creatBitmap("asset.publicchairs.chairsRedBg2");
         _chairsNote3 = ComponentFactory.Instance.creatBitmap("asset.publicchairs.chairsNote3");
         addToContent(_bg);
         addToContent(_icon1);
         addToContent(_icon2);
         addToContent(_luckNote);
         addToContent(_chairsNote);
         addToContent(_chairsNames);
         addToContent(_greenBar);
         addToContent(_chargeBtn);
         addToContent(_receiveBtn);
         addToContent(_leftTimeTxt);
         addToContent(_chairsProgressTxt);
         addToContent(_chairsStrip);
         addToContent(_chairsNote1);
         addToContent(_chairsNote2Bg);
         addToContent(_chairsNote2);
         addToContent(_redBg);
         addToContent(_redBg2);
         addToContent(_chairsNote3);
         addToContent(_currentChairsTxt);
         addToContent(_rewardCountsTxt);
         _greenBar.gotoAndStop(1);
      }
      
      private function addEvent() : void
      {
         addEventListener("response",__frameResponse);
         _chargeBtn.addEventListener("click",__chargeHandler);
         _receiveBtn.addEventListener("click",__receiveHandler);
         NotificationManager.instance.addEventListener("PUBLIC_CHAIRS_UPDATE",__updateViewHandler);
      }
      
      private function removeEvent() : void
      {
         removeEventListener("response",__frameResponse);
         _chargeBtn.removeEventListener("click",__chargeHandler);
         _receiveBtn.removeEventListener("click",__receiveHandler);
         NotificationManager.instance.removeEventListener("PUBLIC_CHAIRS_UPDATE",__updateViewHandler);
      }
      
      private function __chargeHandler(param1:MouseEvent) : void
      {
         SoundManager.instance.play("022");
         RechargeAlertMannager.navigateToRechargePage();
      }
      
      private function __receiveHandler(param1:MouseEvent) : void
      {
         SoundManager.instance.play("022");
         PublicChairsManager.instance.OperateChairsReq(2);
      }
      
      private function __updateViewHandler(param1:NotificationEvent) : void
      {
         var _loc3_:String = null;
         var _loc4_:int = 0;
         _chairsMsg = PublicChairsManager.instance.chairsMsg;
         if(_chairsMsg.luckyNickName.length > 0)
         {
            _loc3_ = "";
            _loc4_ = 0;
            while(_loc4_ < _chairsMsg.luckyNickName.length)
            {
               _loc3_ += _chairsMsg.luckyNickName[_loc4_] + "\n";
               _loc4_++;
            }
            _chairsNames.htmlText = _loc3_;
            _luckNote.text = LanguageMgr.GetTranslation("publicchairs.PublicChairsFrame.luckNote");
            _chairsNote.text = LanguageMgr.GetTranslation("publicchairs.PublicChairsFrame.chairsNote");
            _chairsNote3.visible = false;
         }
         else
         {
            _chairsNames.htmlText = "";
            _luckNote.text = "";
            _chairsNote.text = "";
            _chairsNote3.visible = true;
         }
         _icon1.tipData = LanguageMgr.GetTranslation("publicchairs.luckRewards.tipTxt",getTimeStr(_chairsMsg.luckyItems));
         var _loc2_:String = LanguageMgr.GetTranslation("publicchairs.chairsRewards.tipTxt1",getTimeStr(_chairsMsg.comfortItems));
         if(_chairsMsg.currentChairs > 0)
         {
            _icon2.tipData = _loc2_ + LanguageMgr.GetTranslation("publicchairs.chairsRewards.tipTxt2",_chairsMsg.currentChairs);
            _chairsNote2.text = LanguageMgr.GetTranslation("publicchairs.PublicChairsFrame.chairsNoteTxt2",_chairsMsg.leftPoint);
         }
         else
         {
            _icon2.tipData = _loc2_ + LanguageMgr.GetTranslation("publicchairs.chairsRewards.tipTxt2",_chairsMsg.currentChairs);
            _chairsNote2.text = LanguageMgr.GetTranslation("publicchairs.PublicChairsFrame.chairsNoteTxt1",_chairsMsg.chairsNeedPoints);
         }
         _currentChairsTxt.text = _chairsMsg.currentChairs.toString();
         _rewardCountsTxt.text = _chairsMsg.rewardCounts.toString();
         _receiveBtn.enable = _chairsMsg.rewardCounts > 0;
         _rewardCountsTxt.visible = _chairsMsg.rewardCounts > 0;
         _redBg2.visible = _chairsMsg.rewardCounts > 0;
         refreshGreenBar();
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
         var _loc4_:String = null;
         var _loc2_:Number = DateFormatter.parse(_chairsMsg.stopTime,"YYYY-MM-DD hh:mm:ss").time / 1000;
         var _loc3_:Number = _loc2_ - PlayerManager.instance.currentPlayerModel.sysCurTimeBySecond;
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
            _leftTimeTxt.text = LanguageMgr.GetTranslation("childarena.notAtOpenTime");
            _timer.stop();
            _timer.removeEventListener("timer",timeHandler);
            _timer = null;
         }
      }
      
      private function refreshGreenBar() : void
      {
         var _loc1_:int = 0;
         var _loc3_:int = 0;
         var _loc2_:int = 0;
         if(_chairsMsg.totalChairsCount >= _chairsMsg.rewardNeedChairs)
         {
            _chairsProgressTxt.text = "max";
            _loc1_ = 100;
         }
         else
         {
            _loc3_ = int(_chairsMsg.totalChairsCount);
            _loc2_ = int(_chairsMsg.rewardNeedChairs);
            _loc1_ = _loc3_ / _loc2_ * 100;
            _chairsProgressTxt.text = _loc1_ + "%";
         }
         _greenBar.gotoAndStop(_loc1_);
         _chairsStrip.tipData = _loc1_ + "%";
      }
      
      private function getTimeStr(param1:Array) : String
      {
         var _loc2_:Array = null;
         var _loc3_:GoodsTemplateInfo = null;
         var _loc4_:int = 0;
         var _loc5_:String = "";
         _loc4_ = 0;
         while(_loc4_ < param1.length)
         {
            _loc2_ = String(param1[_loc4_]).split("|");
            _loc3_ = TempleteManager.instance.goodsTemplateCate.getTemplateByID(_loc2_[0]);
            _loc5_ += _loc3_.TemplateName + "x" + _loc2_[1];
            if(_loc4_ != param1.length - 1)
            {
               _loc5_ += "\n";
            }
            _loc4_++;
         }
         return _loc5_;
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
         removeEvent();
         ObjectUtils.disposeObject(_bg);
         _bg = null;
         ObjectUtils.disposeObject(_icon1);
         _icon1 = null;
         ObjectUtils.disposeObject(_icon2);
         _icon2 = null;
         ObjectUtils.disposeObject(_luckNote);
         _luckNote = null;
         ObjectUtils.disposeObject(_chairsNote);
         _chairsNote = null;
         ObjectUtils.disposeObject(_chairsNames);
         _chairsNames = null;
         ObjectUtils.disposeViolentMc(_greenBar);
         _greenBar = null;
         ObjectUtils.disposeObject(_chargeBtn);
         _chargeBtn = null;
         ObjectUtils.disposeObject(_receiveBtn);
         _receiveBtn = null;
         ObjectUtils.disposeObject(_currentChairsTxt);
         _currentChairsTxt = null;
         ObjectUtils.disposeObject(_rewardCountsTxt);
         _rewardCountsTxt = null;
         ObjectUtils.disposeObject(_leftTimeTxt);
         _leftTimeTxt = null;
         ObjectUtils.disposeObject(_chairsProgressTxt);
         _chairsProgressTxt = null;
         ObjectUtils.disposeObject(_chairsStrip);
         _chairsStrip = null;
         ObjectUtils.disposeObject(_chairsNote1);
         _chairsNote1 = null;
         ObjectUtils.disposeObject(_chairsNote2Bg);
         _chairsNote2Bg = null;
         ObjectUtils.disposeObject(_chairsNote2);
         _chairsNote2 = null;
         ObjectUtils.disposeObject(_redBg);
         _redBg = null;
         ObjectUtils.disposeObject(_redBg2);
         _redBg2 = null;
         ObjectUtils.disposeObject(_chairsNote3);
         _chairsNote3 = null;
         if(_timer)
         {
            _timer.stop();
            _timer.removeEventListener("timer",timeHandler);
            _timer = null;
         }
         _chairsMsg = null;
         super.dispose();
      }
   }
}

