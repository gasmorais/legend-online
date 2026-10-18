package publicegg
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.IconButton;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import com.pickgliss.utils.SoundManager;
   import com.road.yishi.proto.sumpassion.EggItemMsg;
   import com.road.yishi.proto.sumpassion.EggListMsg;
   import flash.display.Bitmap;
   import flash.display.DisplayObject;
   import flash.display.MovieClip;
   import flash.events.MouseEvent;
   import flash.events.TimerEvent;
   import flash.utils.Timer;
   import mainBar.StripView;
   import manager.LanguageMgr;
   import utils.LogicUtils;
   import yishi.datas.templates.GoodsTemplateInfo;
   import yishi.events.NotificationEvent;
   import yishi.manager.NotificationManager;
   import yishi.manager.PlayerManager;
   import yishi.manager.PublicEggManager;
   import yishi.manager.TempleteManager;
   import yishi.utils.DateFormatter;
   
   public class PublicEggView extends Component
   {
      
      private var itemList:Array = [];
      
      private var posArr:Array = [[134,103],[347,104],[550,104],[70,294],[253,294],[436,294],[616,294]];
      
      private var _bg:DisplayObject;
      
      private var _boxBtn:IconButton;
      
      private var _greenBar:MovieClip;
      
      private var _progressTxt:FilterFrameText;
      
      private var _timer:Timer;
      
      private var _timeBg:Bitmap;
      
      private var _timeNote:Bitmap;
      
      private var _leftTimeTxt:FilterFrameText;
      
      private var _eggListMsg:EggListMsg;
      
      private var _stripView:StripView;
      
      private var _receivedImg:Bitmap;
      
      public function PublicEggView()
      {
         super();
         initView();
         initEvent();
         PublicEggManager.instance.OperateEggReq(1);
      }
      
      private function initView() : void
      {
         var _loc2_:int = 0;
         var _loc1_:PublicEggItem = null;
         _bg = ComponentFactory.Instance.creatBitmap("asset.publicegg.egg.Bg");
         _boxBtn = ComponentFactory.Instance.creatComponentByStylename("publicegg.egg.allRewardBtn");
         _greenBar = ComponentFactory.Instance.creatCustomObject("asset.publicegg.egg.greenBar");
         _progressTxt = ComponentFactory.Instance.creatComponentByStylename("publicegg.publiceggProgressTxt");
         _timeBg = ComponentFactory.Instance.creatBitmap("asset.publicegg.egg.timeBg");
         _timeNote = ComponentFactory.Instance.creatBitmap("asset.publicegg.egg.timeNote");
         _leftTimeTxt = ComponentFactory.Instance.creatComponentByStylename("publicegg.leftTimeTxt");
         _stripView = ComponentFactory.Instance.creatComponentByStylename("publicegg.frame.tipsStripView");
         _receivedImg = ComponentFactory.Instance.creatBitmap("asset.publicegg.egg.receivedImg");
         addChild(_bg);
         addChild(_boxBtn);
         addChild(_greenBar);
         addChild(_progressTxt);
         addChild(_timeBg);
         addChild(_timeNote);
         addChild(_leftTimeTxt);
         addChild(_receivedImg);
         addChild(_stripView);
         _receivedImg.x = 552;
         _receivedImg.y = 31;
         _loc2_ = 0;
         while(_loc2_ < 7)
         {
            _loc1_ = new PublicEggItem();
            _loc1_.x = posArr[_loc2_][0];
            _loc1_.y = posArr[_loc2_][1];
            _loc1_.index = _loc2_ + 1;
            addChild(_loc1_);
            itemList.push(_loc1_);
            _loc2_++;
         }
         _greenBar.gotoAndStop(1);
         _stripView.setHitArea(0,0,60,60);
         _receivedImg.visible = false;
      }
      
      private function initEvent() : void
      {
         _boxBtn.addEventListener("click",__allRewardHandler);
         NotificationManager.instance.addEventListener("PUBLIC_EGG_UPDATE",__updateViewHandler);
      }
      
      private function removeEvent() : void
      {
         _boxBtn.removeEventListener("click",__allRewardHandler);
         NotificationManager.instance.removeEventListener("PUBLIC_EGG_UPDATE",__updateViewHandler);
      }
      
      private function __allRewardHandler(param1:MouseEvent) : void
      {
         SoundManager.instance.play("022");
         PublicEggManager.instance.OperateEggReq(3);
      }
      
      private function __updateViewHandler(param1:NotificationEvent) : void
      {
         var _loc4_:int = 0;
         var _loc3_:int = 0;
         var _loc6_:int = 0;
         var _loc5_:int = 0;
         _eggListMsg = PublicEggManager.instance.eggListMsg;
         _loc4_ = 0;
         while(_loc4_ < _eggListMsg.egg.length)
         {
            itemList[_loc4_].data = _eggListMsg.egg[_loc4_];
            _loc4_++;
         }
         var _loc2_:Array = _eggListMsg.scoreBoxShow.split("|");
         if(int(_loc2_[0]) >= int(_loc2_[1]))
         {
            _progressTxt.text = "max";
            _loc3_ = 100;
         }
         else
         {
            _loc6_ = int(_loc2_[0]);
            _loc5_ = int(_loc2_[1]);
            _progressTxt.text = _loc6_ + "/" + _loc5_;
            _loc3_ = _loc6_ / _loc5_ * 100;
         }
         _greenBar.gotoAndStop(_loc3_);
         _boxBtn.enable = _eggListMsg.canTake;
         _stripView.visible = !_eggListMsg.canTake;
         _boxBtn.tipData = LanguageMgr.GetTranslation("publicegg.PublicEggView.boxBtn.tipData",getTimeStr(_eggListMsg.boxRewardsTemps));
         _stripView.tipData = LanguageMgr.GetTranslation("publicegg.PublicEggView.boxBtn.tipData",getTimeStr(_eggListMsg.boxRewardsTemps));
         _receivedImg.visible = _eggListMsg.allTaked;
         timeHandler(null);
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
         var _loc2_:Date = DateFormatter.parse(_eggListMsg.stopTime,"YYYY-MM-DD hh:mm:ss");
         var _loc3_:Number = _loc2_.time / 1000 - PlayerManager.instance.currentPlayerModel.sysCurTimeBySecond;
         if(_loc3_ > 0)
         {
            if(_loc3_ >= 60)
            {
               _leftTimeTxt.text = DateFormatter.getFullTimeString(_loc3_);
            }
            else
            {
               _loc4_ = LanguageMgr.GetTranslation("funny.groupbuy.buyRestTimeSecond",_loc3_);
               _leftTimeTxt.text = _loc4_;
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
      
      private function getTimeStr(param1:Array) : String
      {
         var _loc2_:EggItemMsg = null;
         var _loc3_:GoodsTemplateInfo = null;
         var _loc4_:int = 0;
         var _loc5_:String = "";
         _loc4_ = 0;
         while(_loc4_ < param1.length)
         {
            _loc2_ = EggItemMsg(param1[_loc4_]);
            _loc3_ = TempleteManager.instance.goodsTemplateCate.getTemplateByID(_loc2_.templateId);
            _loc5_ += _loc3_.TemplateName + "x" + _loc2_.counts;
            if(_loc4_ != param1.length - 1)
            {
               _loc5_ += "\n";
            }
            _loc4_++;
         }
         return _loc5_;
      }
      
      override public function dispose() : void
      {
         removeEvent();
         LogicUtils.disposeDisplayCollection(itemList);
         itemList = null;
         ObjectUtils.disposeObject(_bg);
         _bg = null;
         ObjectUtils.disposeObject(_boxBtn);
         _boxBtn = null;
         ObjectUtils.disposeViolentMc(_greenBar);
         _greenBar = null;
         ObjectUtils.disposeObject(_progressTxt);
         _progressTxt = null;
         ObjectUtils.disposeObject(_timeBg);
         _timeBg = null;
         ObjectUtils.disposeObject(_timeNote);
         _timeNote = null;
         ObjectUtils.disposeObject(_leftTimeTxt);
         _leftTimeTxt = null;
         ObjectUtils.disposeObject(_stripView);
         _stripView = null;
         ObjectUtils.disposeObject(_receivedImg);
         _receivedImg = null;
         if(_timer)
         {
            _timer.stop();
            _timer.removeEventListener("timer",timeHandler);
            _timer = null;
         }
         posArr = null;
         _eggListMsg = null;
         super.dispose();
      }
   }
}

