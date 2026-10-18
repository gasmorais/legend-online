package funny.mountact
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.ui.image.Image;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.ui.text.GradientText;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Bitmap;
   import flash.events.TimerEvent;
   import flash.utils.Timer;
   import funny.datas.FunnyData;
   import manager.LanguageMgr;
   import managers.FunnyManager;
   import mountact.MountActModel;
   import yishi.datas.playerinfo.PlayerModel;
   import yishi.datas.templates.MountTemplate;
   import yishi.events.NotificationEvent;
   import yishi.manager.NotificationManager;
   import yishi.manager.PlayerManager;
   import yishi.manager.TempleteManager;
   import yishi.utils.DateFormatter;
   
   public class MountActView extends Component
   {
      
      private var _bg:Bitmap;
      
      private var _bg02:Bitmap;
      
      private var _arrow:Bitmap;
      
      private var _title:Bitmap;
      
      private var _mountItemBg01:Image;
      
      private var _mountItemBg02:Image;
      
      private var _currMountView:MountsAvatarView;
      
      private var _nextMountView:MountsAvatarView;
      
      private var _currMountNameTxt:FilterFrameText;
      
      private var _currMountLvTxt:FilterFrameText;
      
      private var _nextMountNameTxt:FilterFrameText;
      
      private var _nextMountLvTxt:FilterFrameText;
      
      private var _costTxt:GradientText;
      
      private var _returnTxt:GradientText;
      
      private var _costValueTxt:FilterFrameText;
      
      private var _returnValueTxt:FilterFrameText;
      
      private var _promptTxt:FilterFrameText;
      
      private var _diamondImg:Bitmap;
      
      private var _bindDiamondImg:Bitmap;
      
      private var _buttomImg:Image;
      
      private var _timeImage:Bitmap;
      
      private var _timeText:FilterFrameText;
      
      private var _remainTimeText:FilterFrameText;
      
      private var _data:FunnyData;
      
      private var _timer:Timer;
      
      public function MountActView()
      {
         super();
         initView();
         initEvent();
         initData();
      }
      
      private function initView() : void
      {
         _bg = ComponentFactory.Instance.creatBitmap("asset.funny.mountBg");
         _bg02 = ComponentFactory.Instance.creatBitmap("asset.funny.mountBg02");
         _arrow = ComponentFactory.Instance.creatBitmap("asset.funny.mountArrow");
         _title = ComponentFactory.Instance.creatBitmap("asset.funny.mountTitle");
         _mountItemBg01 = ComponentFactory.Instance.creatComponentByStylename("funny.mountAct.mountItemBg01");
         _mountItemBg02 = ComponentFactory.Instance.creatComponentByStylename("funny.mountAct.mountItemBg02");
         _currMountView = new MountsAvatarView();
         _nextMountView = new MountsAvatarView();
         _currMountNameTxt = ComponentFactory.Instance.creatComponentByStylename("funny.mountAct.currMountName");
         _nextMountNameTxt = ComponentFactory.Instance.creatComponentByStylename("funny.mountAct.nextMountName");
         _currMountLvTxt = ComponentFactory.Instance.creatComponentByStylename("funny.mountAct.currMountLv");
         _nextMountLvTxt = ComponentFactory.Instance.creatComponentByStylename("funny.mountAct.nextMountLv");
         _costTxt = ComponentFactory.Instance.creatComponentByStylename("funny.mountAct.costTxt");
         _returnTxt = ComponentFactory.Instance.creatComponentByStylename("funny.mountAct.returnTxt");
         _costValueTxt = ComponentFactory.Instance.creatComponentByStylename("funny.mountAct.costValueTxtField");
         _returnValueTxt = ComponentFactory.Instance.creatComponentByStylename("funny.mountAct.returnValueTxt");
         _promptTxt = ComponentFactory.Instance.creatComponentByStylename("funny.mountAct.promptTxt");
         _diamondImg = ComponentFactory.Instance.creatBitmap("asset.core.SmallPointImg");
         _bindDiamondImg = ComponentFactory.Instance.creatBitmap("asset.funny.BindPointImg");
         _buttomImg = ComponentFactory.Instance.creatComponentByStylename("funny.buttonBg");
         _timeImage = ComponentFactory.Instance.creatBitmap("asset.funny.timeImage");
         _timeText = ComponentFactory.Instance.creatComponentByStylename("funnyRightView.timeText");
         _remainTimeText = ComponentFactory.Instance.creatComponentByStylename("funnyRightView.remainTimeText");
         _currMountView.x = 103;
         _nextMountView.x = 420;
         _currMountView.y = _nextMountView.y = 214;
         _currMountView.scaleX = _currMountView.scaleY = _nextMountView.scaleX = _nextMountView.scaleY = 0.8;
         _diamondImg.y = _bindDiamondImg.y = 284;
         addChild(_bg);
         addChild(_bg02);
         addChild(_arrow);
         addChild(_title);
         addChild(_mountItemBg01);
         addChild(_mountItemBg02);
         addChild(_currMountView);
         addChild(_nextMountView);
         addChild(_currMountNameTxt);
         addChild(_currMountLvTxt);
         addChild(_nextMountNameTxt);
         addChild(_nextMountLvTxt);
         addChild(_costTxt);
         addChild(_returnTxt);
         addChild(_costValueTxt);
         addChild(_returnValueTxt);
         addChild(_currMountNameTxt);
         addChild(_currMountLvTxt);
         addChild(_nextMountNameTxt);
         addChild(_nextMountLvTxt);
         addChild(_diamondImg);
         addChild(_bindDiamondImg);
         addChild(_promptTxt);
         _promptTxt.text = LanguageMgr.GetTranslation("funny.mountact.MountActView.prompt");
         addChild(_buttomImg);
         addChild(_timeImage);
         addChild(_timeText);
         addChild(_remainTimeText);
      }
      
      private function initEvent() : void
      {
         NotificationManager.instance.addEventListener("REFRESH_MOUNT_ACT",initData);
         _timer = new Timer(1000);
         _timer.addEventListener("timer",__timerHandler);
         _timer.start();
      }
      
      public function initData(param1:NotificationEvent = null) : void
      {
         var _loc5_:MountActModel = FunnyManager.instance.mountModel;
         var _loc3_:MountTemplate = TempleteManager.instance.getDefaultMountTempByLevel(_loc5_.mountLevel);
         var _loc2_:MountTemplate = TempleteManager.instance.getDefaultMountTempByLevel(_loc5_.mountLevel + 1);
         _data = FunnyManager.instance.selectedFunnyData;
         _currMountView.data = _loc3_;
         _nextMountView.data = _loc2_;
         _currMountNameTxt.text = _loc3_.TemplateName;
         _currMountLvTxt.text = LanguageMgr.GetTranslation("mounts.command01",_loc3_.Property2);
         _nextMountNameTxt.text = _loc2_.TemplateName;
         _nextMountLvTxt.text = LanguageMgr.GetTranslation("mounts.command01",_loc2_.Property2);
         _costTxt.text = LanguageMgr.GetTranslation("fund.fundBuyItemTip.consumeTxt");
         _returnTxt.text = LanguageMgr.GetTranslation("funny.mountact.MountActView.returnPoint",_loc5_.rebate);
         _costValueTxt.text = _loc5_.toalCost + "";
         _returnValueTxt.text = _loc5_.rebatePoint + "";
         var _loc4_:int = _costTxt.textWidth + _costValueTxt.width + _returnTxt.textWidth + _returnValueTxt.textWidth + _diamondImg.width + _bindDiamondImg.width;
         _costTxt.x = _bg02.x + (_bg02.width - _loc4_) / 2 + 10;
         _costValueTxt.x = _costTxt.x + _costTxt.textWidth + 8;
         _diamondImg.x = _costValueTxt.x + _costValueTxt.textWidth + 5;
         _returnTxt.x = _diamondImg.x + _diamondImg.width + 2;
         _returnValueTxt.x = _returnTxt.x + _returnTxt.textWidth + 8;
         _bindDiamondImg.x = _returnValueTxt.x + _returnValueTxt.textWidth + 5;
         setRemainTime();
      }
      
      private function removeEvent() : void
      {
         NotificationManager.instance.removeEventListener("REFRESH_MOUNT_ACT",initData);
         if(_timer)
         {
            _timer.stop();
            _timer.removeEventListener("timer",__timerHandler);
         }
      }
      
      public function setRemainTime() : void
      {
         if(!_data || _data.type == 1003)
         {
            return;
         }
         var _loc1_:Number = _data.endTime / 1000 - playerModel.sysCurTimeBySecond;
         if(_loc1_ >= 60)
         {
            _remainTimeText.text = LanguageMgr.GetTranslation("funny.FunnyRightView.active.remainTime",DateFormatter.getFullTimeString(_loc1_));
         }
         else if(_loc1_ > 0)
         {
            _remainTimeText.text = LanguageMgr.GetTranslation("funny.FunnyRightView.active.remainTime",DateFormatter.getFullDateString(_loc1_));
         }
         else
         {
            _remainTimeText.text = LanguageMgr.GetTranslation("feedback.FeedBackItem.outDate");
         }
         if(_data.startTime > playerModel.nowDate)
         {
            _timeImage.visible = _timeText.visible = true;
            _remainTimeText.visible = false;
         }
         else
         {
            _timeImage.visible = _timeText.visible = false;
            _remainTimeText.visible = true;
         }
      }
      
      private function get playerModel() : PlayerModel
      {
         return PlayerManager.instance.currentPlayerModel;
      }
      
      private function __timerHandler(param1:TimerEvent) : void
      {
         setRemainTime();
      }
      
      override public function dispose() : void
      {
         removeEvent();
         ObjectUtils.disposeObject(_bg);
         ObjectUtils.disposeObject(_bg02);
         ObjectUtils.disposeObject(_arrow);
         ObjectUtils.disposeObject(_title);
         ObjectUtils.disposeObject(_mountItemBg01);
         ObjectUtils.disposeObject(_mountItemBg02);
         ObjectUtils.disposeObject(_currMountView);
         ObjectUtils.disposeObject(_nextMountView);
         ObjectUtils.disposeObject(_currMountNameTxt);
         ObjectUtils.disposeObject(_currMountLvTxt);
         ObjectUtils.disposeObject(_nextMountNameTxt);
         ObjectUtils.disposeObject(_nextMountLvTxt);
         ObjectUtils.disposeObject(_costTxt);
         ObjectUtils.disposeObject(_costValueTxt);
         ObjectUtils.disposeObject(_returnTxt);
         ObjectUtils.disposeObject(_returnValueTxt);
         ObjectUtils.disposeObject(_diamondImg);
         ObjectUtils.disposeObject(_bindDiamondImg);
         ObjectUtils.disposeObject(_buttomImg);
         ObjectUtils.disposeObject(_timeImage);
         ObjectUtils.disposeObject(_timeText);
         ObjectUtils.disposeObject(_remainTimeText);
      }
   }
}

