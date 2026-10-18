package consortia.view.myConsortia.newui
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.BaseButton;
   import com.pickgliss.ui.controls.IconButton;
   import com.pickgliss.ui.controls.SelectedButtonGroup;
   import com.pickgliss.ui.controls.SelectedIconButton;
   import com.pickgliss.ui.controls.container.VBox;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.ui.image.MutipleImage;
   import com.pickgliss.ui.image.ScaleBitmapImage;
   import com.pickgliss.ui.image.ScaleFrameImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import com.pickgliss.utils.SoundManager;
   import events.ConsortiaEvent;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.utils.clearTimeout;
   import flash.utils.setTimeout;
   import manager.LanguageMgr;
   import mvc.controler.ConsortiaControler;
   import mvc.module.consortia.ConsortiaInfo;
   import mvc.module.consortia.ConsortiaModel;
   import mvc.module.consortia.ConsortiaTemplete;
   import yishi.manager.ConsortiaManager;
   import yishi.manager.FrameControllerManager;
   import yishi.manager.TempleteManager;
   import yishi.utils.DateFormatter;
   import yishi.utils.SimpleAlertHelper;
   import yishi.view.tips.MessageTipManager;
   
   public class ConsortiaDevelopView extends Component
   {
      
      private static const MASTER_SCHOOL_TYPE:int = 26;
      
      private var _btnVbox:VBox;
      
      private var _btnGroup:SelectedButtonGroup;
      
      private var _lineImage:ScaleBitmapImage;
      
      private var _costTypeImage:ScaleFrameImage;
      
      private var _nextDescText:FilterFrameText;
      
      private var _descText:FilterFrameText;
      
      private var _tipText:FilterFrameText;
      
      private var _hasAssetText:FilterFrameText;
      
      private var _wealthText:FilterFrameText;
      
      private var _coldDownText:FilterFrameText;
      
      private var _costAssetText:FilterFrameText;
      
      private var _gradeText:FilterFrameText;
      
      private var _textBack2:ScaleBitmapImage;
      
      private var _textBack1:ScaleBitmapImage;
      
      private var _back:MutipleImage;
      
      private var _upgradeBtn:IconButton;
      
      private var _speedBtn:BaseButton;
      
      private var _prevNeedText:FilterFrameText;
      
      private var _buildIcon:ScaleFrameImage;
      
      private var curTemp:ConsortiaTemplete;
      
      private var nextTemp:ConsortiaTemplete;
      
      private var tempType:int;
      
      private var isNewBuild:Boolean;
      
      private var _timeId:int;
      
      public function ConsortiaDevelopView()
      {
         super();
         initView();
         initBtnView();
         addEvent();
         setCoolDownTime();
         _btnGroup.selectIndex = 0;
      }
      
      private static function addOfferCallBack(param1:Boolean, param2:Boolean) : void
      {
         if(!param1)
         {
            return;
         }
         FrameControllerManager.instance.consortiaController.showContributeFrame();
      }
      
      private function initView() : void
      {
         _nextDescText = ComponentFactory.Instance.creatComponentByStylename("Consortia.ConsortiaDevelopView.nextDescText");
         _descText = ComponentFactory.Instance.creatComponentByStylename("Consortia.ConsortiaDevelopView.descText");
         _tipText = ComponentFactory.Instance.creatComponentByStylename("Consortia.ConsortiaDevelopView.tipText");
         _hasAssetText = ComponentFactory.Instance.creatComponentByStylename("Consortia.ConsortiaDevelopView.hasAssetText");
         _wealthText = ComponentFactory.Instance.creatComponentByStylename("Consortia.ConsortiaDevelopView.wealthText");
         _coldDownText = ComponentFactory.Instance.creatComponentByStylename("Consortia.ConsortiaDevelopView.coldDownText");
         _costAssetText = ComponentFactory.Instance.creatComponentByStylename("Consortia.ConsortiaDevelopView.costAssetText");
         _gradeText = ComponentFactory.Instance.creatComponentByStylename("Consortia.ConsortiaDevelopView.gradeText");
         _textBack2 = ComponentFactory.Instance.creatComponentByStylename("Consortia.ConsortiaDevelopView.textBack2");
         _textBack1 = ComponentFactory.Instance.creatComponentByStylename("Consortia.ConsortiaDevelopView.textBack1");
         _back = ComponentFactory.Instance.creatComponentByStylename("Consortia.ConsortiaDevelopView.back");
         _upgradeBtn = ComponentFactory.Instance.creatComponentByStylename("Consortia.ConsortiaDevelopView.upgradeBtn");
         _speedBtn = ComponentFactory.Instance.creatComponentByStylename("Consortia.ConsortiaDevelopView.speedBtn");
         _prevNeedText = ComponentFactory.Instance.creatComponentByStylename("Consortia.ConsortiaDevelopView.prevNeedText");
         _lineImage = ComponentFactory.Instance.creatComponentByStylename("ConsortiaDevelopView.lineImage");
         _btnVbox = ComponentFactory.Instance.creatComponentByStylename("Consortia.ConsortiaDevelopView.btnVbox");
         _buildIcon = ComponentFactory.Instance.creatComponentByStylename("Consortia.ConsortiaDevelopView.buildIcon");
         _costTypeImage = ComponentFactory.Instance.creatComponentByStylename("Consortia.ConsortiaDevelopView.costTypeImage");
         addChild(_btnVbox);
         addChild(_lineImage);
         addChild(_back);
         addChild(_buildIcon);
         addChild(_costTypeImage);
         addChild(_speedBtn);
         addChild(_prevNeedText);
         addChild(_gradeText);
         addChild(_costAssetText);
         addChild(_coldDownText);
         addChild(_textBack1);
         addChild(_textBack2);
         addChild(_tipText);
         addChild(_descText);
         addChild(_nextDescText);
         addChild(_upgradeBtn);
         addChild(_wealthText);
         addChild(_hasAssetText);
         _speedBtn.tipData = LanguageMgr.GetTranslation("consortia.view.myConsortia.ConsortiaFrameTopView.quickBtnTipData");
      }
      
      private function initBtnView() : void
      {
         var _loc2_:int = 0;
         var _loc1_:SelectedIconButton = null;
         _btnGroup = new SelectedButtonGroup();
         _loc2_ = 0;
         while(_loc2_ < 6)
         {
            _loc1_ = ComponentFactory.Instance.creatComponentByStylename("Consortia.ConsortiaDevelopView.buildBtn" + _loc2_);
            _btnVbox.addChild(_loc1_);
            _btnGroup.addSelectItem(_loc1_);
            _loc2_++;
         }
      }
      
      private function addEvent() : void
      {
         _speedBtn.addEventListener("click",_speedBtnClickHandler);
         _upgradeBtn.addEventListener("click",_upgradeBtnClickHandler);
         if(_btnGroup)
         {
            _btnGroup.addEventListener("change",__tabChangeHandler);
         }
         model.addEventListener("UPDA_CONSORTIA_INFO",__onConsortiaInfoUpdateHandler);
      }
      
      private function removeEvent() : void
      {
         if(_speedBtn)
         {
            _speedBtn.removeEventListener("click",_speedBtnClickHandler);
         }
         if(_upgradeBtn)
         {
            _upgradeBtn.removeEventListener("click",_upgradeBtnClickHandler);
         }
         if(_btnGroup)
         {
            _btnGroup.removeEventListener("change",__tabChangeHandler);
         }
         model.removeEventListener("UPDA_CONSORTIA_INFO",__onConsortiaInfoUpdateHandler);
      }
      
      private function __onConsortiaInfoUpdateHandler(param1:ConsortiaEvent) : void
      {
         setCoolDownTime();
         refreshView();
      }
      
      private function __tabChangeHandler(param1:Event) : void
      {
         SoundManager.instance.play("022");
         refreshView();
      }
      
      private function refreshView() : void
      {
         _buildIcon.setFrame(_btnGroup.selectIndex + 1);
         var _loc2_:int = int(consortiaInfo.buildBtnLevelAry[_btnGroup.selectIndex]);
         tempType = consortiaInfo.buildBtnTypeAry[_btnGroup.selectIndex];
         _gradeText.text = _loc2_ + "";
         _wealthText.text = consortiaInfo.offer + "";
         _hasAssetText.text = consortiaInfo.consortiaAsset + "";
         curTemp = TempleteManager.instance.getConsortiaTempleteByTypeAndLevel(tempType,_loc2_);
         nextTemp = TempleteManager.instance.getConsortiaTempleteByTypeAndLevel(tempType,_loc2_ + 1);
         _descText.text = curTemp ? curTemp.Description : "";
         _nextDescText.text = nextTemp ? nextTemp.Description : "";
         _costAssetText.text = nextTemp ? nextTemp.NeedOffer + "" : "0";
         isNewBuild = tempType == 26;
         isNewBuild ? _costTypeImage.setFrame(2) : _costTypeImage.setFrame(1);
         _upgradeBtn.visible = control.getRightsByIndex(3);
         var _loc1_:Boolean = checkPrevReached(nextTemp);
         if(_loc2_ >= 10 || model.timeLeft > 0 || !_loc1_)
         {
            _upgradeBtn.enable = false;
         }
         else
         {
            _upgradeBtn.enable = true;
         }
      }
      
      private function _speedBtnClickHandler(param1:MouseEvent) : void
      {
         SoundManager.instance.play("022");
         var _loc5_:Array = TempleteManager.instance.getConfigInfoByConfigName("Consortia_Fast").ConfigValue.split(",");
         var _loc6_:int = Math.ceil(model.timeLeft / (60 * _loc5_[1])) * _loc5_[0];
         SimpleAlertHelper.instance.data = [SpeedAlertBack];
         var _loc2_:String = LanguageMgr.GetTranslation("public.confirm");
         var _loc3_:String = LanguageMgr.GetTranslation("public.cancel");
         var _loc4_:String = LanguageMgr.GetTranslation("public.prompt");
         var _loc7_:String = LanguageMgr.GetTranslation("consortia.view.myConsortia.ConsortiaFrameTopView.quickBtnAlertTipData",_loc6_);
         SimpleAlertHelper.instance.popAlerFrame(_loc4_,_loc7_,_loc2_,_loc3_,true,true,false,2,"USEBINDPOINT_ALERT",0,"",null,"SimpleAlert",_loc6_);
      }
      
      private function SpeedAlertBack(param1:Boolean, param2:Boolean) : void
      {
         if(!param1)
         {
            return;
         }
         FrameControllerManager.instance.consortiaController.sendQuickTime(param2);
      }
      
      private function checkPrevReached(param1:ConsortiaTemplete) : Boolean
      {
         var _loc3_:int = 0;
         var _loc2_:int = 0;
         _prevNeedText.text = "";
         if(!param1)
         {
            return false;
         }
         var _loc4_:ConsortiaTemplete = TempleteManager.instance.getConsortiaTempleteById(param1.PreTemplateId);
         if(_loc4_)
         {
            _loc3_ = int(consortiaInfo.buildBtnTypeAry.indexOf(_loc4_.Types));
            if(_loc3_ == -1)
            {
               return false;
            }
            _loc2_ = int(consortiaInfo.buildBtnLevelAry[_loc3_]);
            if(_loc2_ >= _loc4_.Levels)
            {
               return true;
            }
            if(control.getRightsByIndex(3))
            {
               _prevNeedText.text = LanguageMgr.GetTranslation("Consortia.consortiaDevelopView.upgradePreAlertText",_loc4_.LevelName,_loc4_.Levels);
            }
            return false;
         }
         return true;
      }
      
      private function _upgradeBtnClickHandler(param1:MouseEvent) : void
      {
         var _loc2_:String = null;
         var _loc3_:String = null;
         var _loc4_:String = null;
         var _loc5_:String = null;
         SoundManager.instance.play("022");
         if(!nextTemp)
         {
            return;
         }
         if(isNewBuild)
         {
            if(consortiaInfo.consortiaAsset < nextTemp.NeedOffer)
            {
               MessageTipManager.instance().show(LanguageMgr.GetTranslation("consortia.noAsset.alert"));
               return;
            }
            FrameControllerManager.instance.consortiaController.consortiaUpgrade(tempType);
         }
         else
         {
            if(consortiaInfo.offer < nextTemp.NeedOffer)
            {
               SimpleAlertHelper.instance.data = [addOfferCallBack];
               _loc2_ = LanguageMgr.GetTranslation("public.confirm");
               _loc3_ = LanguageMgr.GetTranslation("public.cancel");
               _loc4_ = LanguageMgr.GetTranslation("public.prompt");
               _loc5_ = LanguageMgr.GetTranslation("consortia.helper.ConsortiaUpgradeHelper.content");
               SimpleAlertHelper.instance.popAlerFrame(_loc4_,_loc5_,_loc2_,_loc3_);
               return;
            }
            FrameControllerManager.instance.consortiaController.consortiaUpgrade(tempType);
         }
      }
      
      private function setCoolDownTime() : void
      {
         var _loc1_:int = (consortiaInfo.currentDate.time - consortiaInfo.codeBeginDate.time) / 1000;
         timeLeft = consortiaInfo.codeNeedDate - _loc1_;
      }
      
      public function get timeLeft() : int
      {
         return model.timeLeft;
      }
      
      public function set timeLeft(param1:int) : void
      {
         model.timeLeft = param1;
         if(model.timeLeft <= 0)
         {
            model.timeLeft = 0;
            _coldDownText.text = "00:00:00";
            _speedBtn.visible = false;
            _upgradeBtn.enable = true;
         }
         else
         {
            _coldDownText.text = DateFormatter.getConsortiaCountDate(model.timeLeft);
            clearTimeout(_timeId);
            _timeId = 0;
            _timeId = setTimeout(refreshColdDownTime,1000);
            _speedBtn.visible = control.getRightsByIndex(3);
            _upgradeBtn.enable = false;
         }
      }
      
      private function refreshColdDownTime() : void
      {
         timeLeft -= 1;
         if(timeLeft > 0)
         {
            _coldDownText.text = DateFormatter.getConsortiaCountDate(model.timeLeft);
         }
      }
      
      private function get consortiaInfo() : ConsortiaInfo
      {
         return model.consortiaInfo;
      }
      
      private function get model() : ConsortiaModel
      {
         return ConsortiaManager.instance.model;
      }
      
      private function get control() : ConsortiaControler
      {
         return FrameControllerManager.instance.consortiaController;
      }
      
      override public function dispose() : void
      {
         removeEvent();
         clearTimeout(_timeId);
         ObjectUtils.disposeObject(_nextDescText);
         _nextDescText = null;
         ObjectUtils.disposeObject(_lineImage);
         _lineImage = null;
         ObjectUtils.disposeObject(_costTypeImage);
         _costTypeImage = null;
         ObjectUtils.disposeObject(_descText);
         _descText = null;
         ObjectUtils.disposeObject(_tipText);
         _tipText = null;
         ObjectUtils.disposeObject(_hasAssetText);
         _hasAssetText = null;
         ObjectUtils.disposeObject(_wealthText);
         _wealthText = null;
         ObjectUtils.disposeObject(_coldDownText);
         _coldDownText = null;
         ObjectUtils.disposeObject(_costAssetText);
         _costAssetText = null;
         ObjectUtils.disposeObject(_gradeText);
         _gradeText = null;
         ObjectUtils.disposeObject(_textBack2);
         _textBack2 = null;
         ObjectUtils.disposeObject(_textBack1);
         _textBack1 = null;
         ObjectUtils.disposeObject(_back);
         _back = null;
         ObjectUtils.disposeObject(_upgradeBtn);
         _upgradeBtn = null;
         ObjectUtils.disposeObject(_speedBtn);
         _speedBtn = null;
         ObjectUtils.disposeObject(_btnGroup);
         _btnGroup = null;
         ObjectUtils.disposeObject(_btnVbox);
         _btnVbox = null;
         ObjectUtils.disposeObject(_buildIcon);
         _buildIcon = null;
         ObjectUtils.disposeObject(_prevNeedText);
         _prevNeedText = null;
         super.dispose();
      }
   }
}

