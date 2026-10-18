package mounts
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.IconButton;
   import com.pickgliss.ui.controls.container.VBox;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.ui.image.CustomBitmap;
   import com.pickgliss.ui.image.Image;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import com.pickgliss.utils.SoundManager;
   import events.MountsEvent;
   import flash.display.Bitmap;
   import flash.display.MovieClip;
   import flash.events.Event;
   import flash.events.FocusEvent;
   import flash.events.MouseEvent;
   import flash.utils.getTimer;
   import manager.LanguageMgr;
   import managers.MountsManager;
   import mvc.module.mounts.MountKingInfo;
   import mvc.module.mounts.MountTrainData;
   import yishi.datas.templates.ConfigInfosTempInfo;
   import yishi.datas.templates.MountTemplate;
   import yishi.datas.templates.UpgradeTemplateInfo;
   import yishi.manager.GoodsManager;
   import yishi.manager.PlayerManager;
   import yishi.manager.RechargeAlertMannager;
   import yishi.manager.SharedManagerHelper;
   import yishi.manager.TempleteManager;
   import yishi.view.tips.MessageTipManager;
   
   public class MountKingTrainView extends Component
   {
      
      private var _leftBox:Component;
      
      private var _rightBox:Component;
      
      private var _lightImage:Image;
      
      private var _leftBg:Image;
      
      private var _rightBg:Image;
      
      private var _separateLine:CustomBitmap;
      
      private var _nameTxt:FilterFrameText;
      
      private var _bodyBox:MountsAvatarView;
      
      private var _propertyAddImg:Image;
      
      private var _preLevelText:FilterFrameText;
      
      private var _preBaseText:FilterFrameText;
      
      private var _preAddText:FilterFrameText;
      
      private var _nextLevelText:FilterFrameText;
      
      private var _nextBaseText:FilterFrameText;
      
      private var _nextAddText:FilterFrameText;
      
      private var _vbox:VBox;
      
      private var _maxTextImage:Image;
      
      private var _trainImage:Image;
      
      private var _trainCount:Image;
      
      private var _ownImage:Image;
      
      private var _mountCoinImage:Image;
      
      private var _alertTextImage:Bitmap;
      
      private var _expBack:Image;
      
      private var _expBar:MovieClip;
      
      private var _expTxt:FilterFrameText;
      
      private var _trainCountBottom:Image;
      
      private var _trainCountText:FilterFrameText;
      
      private var _ownCountTxt:FilterFrameText;
      
      private var _trainBtn:IconButton;
      
      private var _returnBtn:IconButton;
      
      private var _trainData:MountTrainData;
      
      private var _data:MountKingInfo;
      
      private var _lastClickTime:int = 0;
      
      public function MountKingTrainView()
      {
         super();
         _trainData = new MountTrainData();
         initView();
         addEvent();
      }
      
      private function initView() : void
      {
         var _loc2_:int = 0;
         var _loc1_:MountKingTrainItemView = null;
         _leftBox = new Component();
         _rightBox = new Component();
         _leftBox.mouseChildren = _leftBox.mouseEnabled = false;
         _rightBox.mouseEnabled = false;
         _rightBox.x = 294;
         _separateLine = ComponentFactory.Instance.creatCustomObject("MountKingTrainView.separateLine");
         addChild(_separateLine);
         addChild(_leftBox);
         addChild(_rightBox);
         _lightImage = ComponentFactory.Instance.creatComponentByStylename("MountKingTrainView.lightImage");
         _nameTxt = ComponentFactory.Instance.creatComponentByStylename("MountKingTrainView.nameTxt");
         _leftBg = ComponentFactory.Instance.creatComponentByStylename("MountKingTrainView.leftBg");
         _rightBg = ComponentFactory.Instance.creatComponentByStylename("MountKingTrainView.rightBg");
         _bodyBox = new MountsAvatarView();
         _bodyBox.x = 145;
         _bodyBox.y = 310;
         _leftBox.addChild(_leftBg);
         _leftBox.addChild(_lightImage);
         _leftBox.addChild(_nameTxt);
         _leftBox.addChild(_bodyBox);
         _rightBox.addChild(_rightBg);
         _propertyAddImg = ComponentFactory.Instance.creatComponentByStylename("MountKingTrainView.propertyAddImg");
         _preLevelText = ComponentFactory.Instance.creatComponentByStylename("MountKingTrainView.preLevelText");
         _preBaseText = ComponentFactory.Instance.creatComponentByStylename("MountKingTrainView.preBaseText");
         _preAddText = ComponentFactory.Instance.creatComponentByStylename("MountKingTrainView.preAddText");
         _nextLevelText = ComponentFactory.Instance.creatComponentByStylename("MountKingTrainView.nextLevelText");
         _nextBaseText = ComponentFactory.Instance.creatComponentByStylename("MountKingTrainView.nextBaseText");
         _nextAddText = ComponentFactory.Instance.creatComponentByStylename("MountKingTrainView.nextAddText");
         _rightBox.addChild(_propertyAddImg);
         _rightBox.addChild(_preLevelText);
         _rightBox.addChild(_preBaseText);
         _rightBox.addChild(_preAddText);
         _rightBox.addChild(_nextLevelText);
         _rightBox.addChild(_nextBaseText);
         _rightBox.addChild(_nextAddText);
         _vbox = ComponentFactory.Instance.creatComponentByStylename("MountKingTrainView.vBox");
         _loc2_ = 1;
         while(_loc2_ < 5)
         {
            _loc1_ = new MountKingTrainItemView(_loc2_);
            _vbox.addChild(_loc1_);
            _loc2_++;
         }
         _rightBox.addChild(_vbox);
         _maxTextImage = ComponentFactory.Instance.creatComponentByStylename("MountKingTrainView.maxTextImage");
         _trainImage = ComponentFactory.Instance.creatComponentByStylename("MountKingTrainView.trainImage");
         _trainCount = ComponentFactory.Instance.creatComponentByStylename("MountKingTrainView.trainCount");
         _ownImage = ComponentFactory.Instance.creatComponentByStylename("MountKingTrainView.ownImage");
         _mountCoinImage = ComponentFactory.Instance.creatComponentByStylename("MountKingTrainView.mountCoinImage");
         _alertTextImage = ComponentFactory.Instance.creatBitmap("asset.mountKing.alertImage");
         _rightBox.addChild(_maxTextImage);
         _maxTextImage.visible = false;
         _rightBox.addChild(_trainImage);
         _rightBox.addChild(_trainCount);
         _rightBox.addChild(_ownImage);
         _rightBox.addChild(_mountCoinImage);
         _rightBox.addChild(_alertTextImage);
         _expBack = ComponentFactory.Instance.creatComponentByStylename("MountKingTrainView.blessBack");
         _expBar = ComponentFactory.Instance.creatCustomObject("MountKingTrainView.expBar");
         _expTxt = ComponentFactory.Instance.creatComponentByStylename("MountKingTrainView.expTxt");
         _rightBox.addChild(_expBack);
         _rightBox.addChild(_expBar);
         _rightBox.addChild(_expTxt);
         _trainCountBottom = ComponentFactory.Instance.creatComponentByStylename("MountKingTrainView.trainCountBottom");
         _trainCountText = ComponentFactory.Instance.creatComponentByStylename("MountKingTrainView.trainCountText");
         _ownCountTxt = ComponentFactory.Instance.creatComponentByStylename("MountKingTrainView.ownCountTxt");
         _trainBtn = ComponentFactory.Instance.creatComponentByStylename("MountKingTrainView.trainBtn");
         _returnBtn = ComponentFactory.Instance.creatComponentByStylename("MountKingTrainView.returnBtn");
         _rightBox.addChild(_trainCountBottom);
         _rightBox.addChild(_trainCountText);
         _rightBox.addChild(_ownCountTxt);
         _rightBox.addChild(_trainBtn);
         _rightBox.addChild(_returnBtn);
         _trainCountText.text = "1";
         _trainBtn.tipData = LanguageMgr.GetTranslation("mounts.tips02",_trainData.trainPoint);
      }
      
      private function addEvent() : void
      {
         MountsManager.instance.avatarList.addEventListener("mountListChange",__kingInfoUpdateHandler);
         MountsManager.instance.avatarList.addEventListener("mountKingInfoChange",__kingInfoUpdateHandler);
         _trainBtn.addEventListener("click",__trainClickHandler);
         _returnBtn.addEventListener("click",__returnHandler);
         _trainCountText.addEventListener("change",__textChangHandler);
         _trainCountText.addEventListener("focusIn",__inHandler);
      }
      
      private function removeEvent() : void
      {
         MountsManager.instance.avatarList.removeEventListener("mountItemChange",__kingInfoUpdateHandler);
         MountsManager.instance.avatarList.removeEventListener("mountListChange",__kingInfoUpdateHandler);
         if(_trainBtn)
         {
            _trainBtn.removeEventListener("click",__trainClickHandler);
         }
         if(_returnBtn)
         {
            _returnBtn.removeEventListener("click",__returnHandler);
         }
         _trainCountText.removeEventListener("change",__textChangHandler);
         _trainCountText.removeEventListener("focusIn",__inHandler);
      }
      
      private function __kingInfoUpdateHandler(param1:MountsEvent) : void
      {
         if(!data)
         {
            return;
         }
         var _loc2_:MountKingInfo = MountsManager.instance.avatarList.getMountKingInfo(data.templateId);
         this.data = _loc2_;
      }
      
      private function __trainClickHandler(param1:MouseEvent) : void
      {
         var _loc3_:int = getTimer();
         if(_loc3_ - _lastClickTime < 400)
         {
            MessageTipManager.instance().show(LanguageMgr.GetTranslation("activity.view.ActivityItem.command01"));
            return;
         }
         _lastClickTime = _loc3_;
         SoundManager.instance.play("022");
         var _loc5_:int = parseInt(_trainCountText.text);
         var _loc4_:int = _loc5_ * _trainData.trainPoint;
         var _loc2_:String = LanguageMgr.GetTranslation("yishi.view.base.ThewAlertFrame.text");
         var _loc6_:String = LanguageMgr.GetTranslation("mounts.normaltip",_loc4_,_loc5_);
         SharedManagerHelper.ins.needAlert("mounts.MountKingTrainView.trainAlert",trainResultHandler,_loc2_,_loc6_,"");
      }
      
      private function trainResultHandler(param1:Boolean) : void
      {
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         var _loc6_:int = parseInt(_trainCountText.text);
         var _loc4_:int = _loc6_ * _trainData.trainPoint;
         var _loc5_:Array = GoodsManager.instance.getBagGoodsByTemplateId(_trainData.mountFoodTemplateId);
         if(param1)
         {
            _loc2_ = int(PlayerManager.instance.currentPlayerModel.playerInfo.allPoint);
         }
         else
         {
            _loc2_ = int(PlayerManager.instance.currentPlayerModel.playerInfo.point);
         }
         if(_loc5_ && _loc5_.length > 0 || _loc2_ >= _loc4_)
         {
            _loc3_ = param1 ? 0 : 1;
            MountsManager.instance.mountOperateSend(7,0,_loc3_,data.templateId,parseInt(_trainCountText.text));
         }
         else
         {
            RechargeAlertMannager.show();
         }
      }
      
      private function __textChangHandler(param1:Event) : void
      {
         var _loc2_:int = parseInt(_trainCountText.text);
         if(_loc2_ <= 0)
         {
            _trainCountText.text = "1";
         }
         if(_loc2_ >= 10000)
         {
            _trainCountText.text = "9999";
         }
      }
      
      private function __inHandler(param1:FocusEvent) : void
      {
         _trainCountText.setSelection(0,_trainCountText.text.length);
      }
      
      private function __returnHandler(param1:MouseEvent) : void
      {
         SoundManager.instance.play("008");
         dispose();
      }
      
      public function set data(param1:MountKingInfo) : void
      {
         var _loc2_:MountKingTrainItemView = null;
         var _loc4_:int = 0;
         var _loc15_:int = 0;
         var _loc13_:int = 0;
         var _loc9_:int = 0;
         var _loc11_:int = 0;
         var _loc16_:int = 0;
         var _loc8_:int = 0;
         if(!param1)
         {
            _nameTxt.text = "";
            _expBar.gotoAndStop(1);
            _expTxt.text = "";
            _bodyBox.data = null;
            _loc8_ = 0;
            while(_loc8_ < _vbox.numChildren)
            {
               _loc2_ = _vbox.getChildAt(_loc8_) as MountKingTrainItemView;
               _loc2_.update(0,0,0,0,0,0);
               _loc8_++;
            }
            _data = null;
            return;
         }
         _data = param1;
         var _loc3_:MountTemplate = param1.template;
         var _loc10_:UpgradeTemplateInfo = MountsManager.instance.avatarList.getMountKingUpGradeTemplateByGrade(param1.grade);
         var _loc14_:UpgradeTemplateInfo = MountsManager.instance.avatarList.getMountKingUpGradeTemplateByGrade(param1.grade + 1);
         var _loc12_:ConfigInfosTempInfo = TempleteManager.instance.getConfigInfoByConfigName("mount_king_level_add_property");
         var _loc5_:Array = _loc12_.ConfigValue.split(",");
         _bodyBox.data = _loc3_;
         _nameTxt.text = _loc3_.TemplateName;
         _preBaseText.text = _nextBaseText.text = LanguageMgr.GetTranslation("MountKingTrainView.baseText");
         _preAddText.htmlText = _nextAddText.htmlText = LanguageMgr.GetTranslation("MountKingTrainView.addText",param1.extraStar);
         var _loc7_:int = int(GoodsManager.instance.getGoodsNumByTempId(208017));
         _ownCountTxt.text = "x " + _loc7_;
         _trainCountText.text = "1";
         var _loc6_:Boolean = _loc14_ == null ? true : false;
         if(_loc14_)
         {
            _preLevelText.text = LanguageMgr.GetTranslation("public.level2",param1.grade);
            _nextLevelText.text = LanguageMgr.GetTranslation("public.level2",param1.grade + 1);
            _expTxt.text = LanguageMgr.GetTranslation("public.slash",param1.exp,_loc14_.Data);
            _expBar.gotoAndStop(int(param1.exp * 100 / _loc14_.Data));
         }
         else
         {
            _preLevelText.text = LanguageMgr.GetTranslation("public.level2",param1.grade);
            _expTxt.text = "MAX";
            _expBar.gotoAndStop(100);
            _trainBtn.enable = false;
            _maxTextImage.visible = true;
            _nextLevelText.visible = _nextBaseText.visible = _nextAddText.visible = false;
         }
         _loc8_ = 0;
         while(_loc8_ < _vbox.numChildren)
         {
            _loc2_ = _vbox.getChildAt(_loc8_) as MountKingTrainItemView;
            switch(_loc8_)
            {
               case 0:
                  _loc4_ = _loc3_.Power + param1.grade * parseInt(_loc5_[_loc8_]);
                  _loc15_ = _loc4_ * param1.extraStar * 0.01;
                  if(!_loc6_)
                  {
                     _loc13_ = _loc3_.Power + (param1.grade + 1) * parseInt(_loc5_[_loc8_]);
                     _loc9_ = _loc13_ * param1.extraStar * 0.01;
                     _loc11_ = parseInt(_loc5_[_loc8_]);
                     _loc16_ = _loc9_ - _loc15_;
                  }
                  else
                  {
                     _loc13_ = _loc9_ = _loc11_ = _loc16_ = 0;
                  }
                  _loc2_.update(_loc4_,_loc15_,_loc13_,_loc9_,_loc11_,_loc16_,_loc6_);
                  break;
               case 1:
                  _loc4_ = _loc3_.Intellect + param1.grade * parseInt(_loc5_[_loc8_]);
                  _loc15_ = _loc4_ * param1.extraStar * 0.01;
                  if(!_loc6_)
                  {
                     _loc13_ = _loc3_.Intellect + (param1.grade + 1) * parseInt(_loc5_[_loc8_]);
                     _loc9_ = _loc13_ * param1.extraStar * 0.01;
                     _loc11_ = parseInt(_loc5_[_loc8_]);
                     _loc16_ = _loc9_ - _loc15_;
                  }
                  else
                  {
                     _loc13_ = _loc9_ = _loc11_ = _loc16_ = 0;
                  }
                  _loc2_.update(_loc4_,_loc15_,_loc13_,_loc9_,_loc11_,_loc16_,_loc6_);
                  break;
               case 2:
                  _loc4_ = _loc3_.Physique + param1.grade * parseInt(_loc5_[_loc8_]);
                  _loc15_ = _loc4_ * param1.extraStar * 0.01;
                  if(!_loc6_)
                  {
                     _loc13_ = _loc3_.Physique + (param1.grade + 1) * parseInt(_loc5_[_loc8_]);
                     _loc9_ = _loc13_ * param1.extraStar * 0.01;
                     _loc11_ = parseInt(_loc5_[_loc8_]);
                     _loc16_ = _loc9_ - _loc15_;
                  }
                  else
                  {
                     _loc13_ = _loc9_ = _loc11_ = _loc16_ = 0;
                  }
                  _loc2_.update(_loc4_,_loc15_,_loc13_,_loc9_,_loc11_,_loc16_,_loc6_);
                  break;
               case 3:
                  _loc4_ = _loc3_.Agility + param1.grade * parseInt(_loc5_[_loc8_]);
                  _loc15_ = _loc4_ * param1.extraStar * 0.01;
                  if(!_loc6_)
                  {
                     _loc13_ = _loc3_.Agility + (param1.grade + 1) * parseInt(_loc5_[_loc8_]);
                     _loc9_ = _loc13_ * param1.extraStar * 0.01;
                     _loc11_ = parseInt(_loc5_[_loc8_]);
                     _loc16_ = _loc9_ - _loc15_;
                  }
                  else
                  {
                     _loc13_ = _loc9_ = _loc11_ = _loc16_ = 0;
                  }
                  _loc2_.update(_loc4_,_loc15_,_loc13_,_loc9_,_loc11_,_loc16_,_loc6_);
            }
            _loc8_++;
         }
      }
      
      public function get data() : MountKingInfo
      {
         return _data;
      }
      
      override public function dispose() : void
      {
         removeEvent();
         if(_leftBox)
         {
            ObjectUtils.disposeObject(_leftBox);
         }
         _leftBox = null;
         if(_rightBox)
         {
            ObjectUtils.disposeObject(_rightBox);
         }
         _rightBox = null;
         if(_lightImage)
         {
            ObjectUtils.disposeObject(_lightImage);
         }
         _lightImage = null;
         if(_leftBg)
         {
            ObjectUtils.disposeObject(_leftBg);
         }
         _leftBg = null;
         if(_rightBg)
         {
            ObjectUtils.disposeObject(_rightBg);
         }
         _rightBg = null;
         if(_separateLine)
         {
            ObjectUtils.disposeObject(_separateLine);
         }
         _separateLine = null;
         if(_nameTxt)
         {
            ObjectUtils.disposeObject(_nameTxt);
         }
         _nameTxt = null;
         if(_bodyBox)
         {
            ObjectUtils.disposeObject(_bodyBox);
         }
         _bodyBox = null;
         if(_propertyAddImg)
         {
            ObjectUtils.disposeObject(_propertyAddImg);
         }
         _propertyAddImg = null;
         if(_preLevelText)
         {
            ObjectUtils.disposeObject(_preLevelText);
         }
         _preLevelText = null;
         if(_preBaseText)
         {
            ObjectUtils.disposeObject(_preBaseText);
         }
         _preBaseText = null;
         if(_preAddText)
         {
            ObjectUtils.disposeObject(_preAddText);
         }
         _preAddText = null;
         if(_preBaseText)
         {
            ObjectUtils.disposeObject(_preBaseText);
         }
         _preBaseText = null;
         if(_nextLevelText)
         {
            ObjectUtils.disposeObject(_nextLevelText);
         }
         _nextLevelText = null;
         if(_nextBaseText)
         {
            ObjectUtils.disposeObject(_nextBaseText);
         }
         _nextBaseText = null;
         if(_nextAddText)
         {
            ObjectUtils.disposeObject(_nextAddText);
         }
         _nextAddText = null;
         if(_vbox)
         {
            ObjectUtils.disposeObject(_vbox);
         }
         _vbox = null;
         if(_maxTextImage)
         {
            ObjectUtils.disposeObject(_maxTextImage);
         }
         _maxTextImage = null;
         if(_trainImage)
         {
            ObjectUtils.disposeObject(_trainImage);
         }
         _trainImage = null;
         if(_trainCount)
         {
            ObjectUtils.disposeObject(_trainCount);
         }
         _trainCount = null;
         if(_ownImage)
         {
            ObjectUtils.disposeObject(_ownImage);
         }
         _ownImage = null;
         if(_mountCoinImage)
         {
            ObjectUtils.disposeObject(_mountCoinImage);
         }
         _mountCoinImage = null;
         if(_alertTextImage)
         {
            ObjectUtils.disposeObject(_alertTextImage);
         }
         _alertTextImage = null;
         if(_expBack)
         {
            ObjectUtils.disposeObject(_expBack);
         }
         _expBack = null;
         if(_expBar)
         {
            ObjectUtils.disposeObject(_expBar);
         }
         _expBar = null;
         if(_expTxt)
         {
            ObjectUtils.disposeObject(_expTxt);
         }
         _expTxt = null;
         if(_trainCountBottom)
         {
            ObjectUtils.disposeObject(_trainCountBottom);
         }
         _trainCountBottom = null;
         if(_trainCountText)
         {
            ObjectUtils.disposeObject(_trainCountText);
         }
         _trainCountText = null;
         if(_ownCountTxt)
         {
            ObjectUtils.disposeObject(_ownCountTxt);
         }
         _ownCountTxt = null;
         if(_trainBtn)
         {
            ObjectUtils.disposeObject(_trainBtn);
         }
         _trainBtn = null;
         if(_returnBtn)
         {
            ObjectUtils.disposeObject(_returnBtn);
         }
         _returnBtn = null;
         super.dispose();
         _data = null;
      }
   }
}

