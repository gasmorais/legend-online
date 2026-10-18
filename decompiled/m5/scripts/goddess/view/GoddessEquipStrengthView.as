package goddess.view
{
   import bag.events.BagEvent;
   import com.greensock.TweenLite;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.IconButton;
   import com.pickgliss.ui.image.Image;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Bitmap;
   import flash.events.MouseEvent;
   import flash.utils.clearInterval;
   import flash.utils.setInterval;
   import goddess.item.GoddessEquipCell;
   import goddess.item.GoddessEquipStrengthItem;
   import manager.LanguageMgr;
   import managers.GodDessManager;
   import mvc.module.goddess.GodDessModel;
   import mvc.module.goddess.GoddessEquipInfo;
   import yishi.datas.templates.GoddessEquipTempInfo;
   import yishi.datas.templates.GoodsTemplateInfo;
   import yishi.events.NotificationEvent;
   import yishi.events.ResourceEvent;
   import yishi.manager.GoodsManager;
   import yishi.manager.NotificationManager;
   import yishi.manager.ResourceManager;
   import yishi.manager.TempleteManager;
   import yishi.view.base.ProgressPanel;
   import yishi.view.tips.MessageTipManager;
   
   public class GoddessEquipStrengthView extends GoddessBaseEquipView
   {
      
      public var _eqGoldTxt:FilterFrameText;
      
      public var _eqMetrailTxt:FilterFrameText;
      
      public var _eqMetrailHasTxt:FilterFrameText;
      
      public var _zfFt:Bitmap;
      
      public var _activity:Bitmap;
      
      public var _effect:Bitmap;
      
      public var _numBack:Bitmap;
      
      public var _eqStrengN1Txt:FilterFrameText;
      
      public var _eqStrengN2Txt:FilterFrameText;
      
      public var _currItem:GoddessEquipStrengthItem;
      
      public var _nextItem:GoddessEquipStrengthItem;
      
      public var _equipCell:GoddessEquipCell;
      
      public var _arrow:Image;
      
      public var _progress:ProgressPanel;
      
      public var _strengBtn:IconButton;
      
      public var _autoStrengBtn:IconButton;
      
      public var _cancelAutoBtn:IconButton;
      
      private var _maxFlag:Bitmap;
      
      private var _isAuto:Boolean;
      
      private var _timer:int = 0;
      
      private var _lastStrengthLv:int;
      
      public var _strengthKitIcon:Image;
      
      public var _strengthGoldIcon:Image;
      
      private var _materialTemp:GoddessEquipTempInfo;
      
      private var _enoughMaterial:Boolean;
      
      private var _enoughGold:Boolean;
      
      private var _enoughStep:Boolean;
      
      private var isValueChanged:Boolean;
      
      private var _effectOriY:int;
      
      public function GoddessEquipStrengthView()
      {
         super();
         initView();
         initEvent();
         data = model.equipSelectInfo;
      }
      
      private function initView() : void
      {
         _eqGoldTxt = ComponentFactory.Instance.creatComponentByStylename("ui.goddess.eqGoldTxt");
         _eqMetrailTxt = ComponentFactory.Instance.creatComponentByStylename("ui.goddess.eqMetrailTxt");
         _eqMetrailHasTxt = ComponentFactory.Instance.creatComponentByStylename("ui.goddess.eqMetrailHasTxt");
         _zfFt = ComponentFactory.Instance.creatBitmap("asset.goddess.eq.zfFt");
         _activity = ComponentFactory.Instance.creatBitmap("asset.goddess.eq.activity");
         _effect = ComponentFactory.Instance.creatBitmap("asset.goddess.eq.double");
         _numBack = ComponentFactory.Instance.creatBitmap("asset.goddess.eq.numBack");
         _eqStrengN1Txt = ComponentFactory.Instance.creatComponentByStylename("ui.goddess.eqStrengN1Txt");
         _eqStrengN2Txt = ComponentFactory.Instance.creatComponentByStylename("ui.goddess.eqStrengN2Txt");
         _currItem = ComponentFactory.Instance.creatComponentByStylename("ui.goddess.strengthItem1");
         _nextItem = ComponentFactory.Instance.creatComponentByStylename("ui.goddess.strengthItem2");
         _equipCell = ComponentFactory.Instance.creatComponentByStylename("ui.goddess.strengthCell");
         _arrow = ComponentFactory.Instance.creatComponentByStylename("ui.goddess.strengthArrow");
         _progress = ComponentFactory.Instance.creatCustomObject("ui.goddess.strengthProgressPanel");
         _strengBtn = ComponentFactory.Instance.creatComponentByStylename("ui.goddess.strengBtn");
         _autoStrengBtn = ComponentFactory.Instance.creatComponentByStylename("ui.goddess.autoStrengBtn");
         _cancelAutoBtn = ComponentFactory.Instance.creatComponentByStylename("ui.goddess.cancelAutoStrengBtn");
         _maxFlag = ComponentFactory.Instance.creatBitmap("asset.goddess.equip.maxStrength");
         _strengthKitIcon = ComponentFactory.Instance.creatComponentByStylename("ui.goddess.strengthKitIcon");
         _strengthGoldIcon = ComponentFactory.Instance.creatComponentByStylename("ui.goddess.strengthGoldIcon");
         addChild(_eqGoldTxt);
         addChild(_eqMetrailTxt);
         addChild(_eqMetrailHasTxt);
         addChild(_zfFt);
         addChild(_equipCell);
         addChild(_numBack);
         addChild(_activity);
         addChild(_eqStrengN1Txt);
         addChild(_eqStrengN2Txt);
         addChild(_currItem);
         addChild(_arrow);
         addChild(_nextItem);
         addChild(_progress);
         addChild(_strengBtn);
         addChild(_autoStrengBtn);
         addChild(_cancelAutoBtn);
         addChild(_maxFlag);
         addChild(_strengthKitIcon);
         addChild(_strengthGoldIcon);
         _cancelAutoBtn.visible = false;
         _progress.initView("asset.goddess.progressBack","asset.goddess.progressBar","ui.goddess.progressTxt");
         _progress.progressValue(0,100);
         var _loc1_:GoodsTemplateInfo = TempleteManager.instance.goodsTemplateCate.getTemplateByID(208500);
         _strengthKitIcon.tipData = _loc1_.TemplateName + ":" + _loc1_.Description;
         addChild(_effect);
         updateEffectShow();
         _effect.alpha = 0;
         _effectOriY = _effect.y;
      }
      
      private function updateEffectShow() : void
      {
         _activity.visible = model.doubleOpen;
         _effect.visible = model.doubleOpen;
      }
      
      private function get model() : GodDessModel
      {
         return GodDessManager.instance.model;
      }
      
      override public function set data(param1:GoddessEquipInfo) : void
      {
         var maxStrength:int;
         var currTemp:GoddessEquipTempInfo;
         var blessArr:Array;
         var nextTemp:GoddessEquipTempInfo;
         var value:GoddessEquipInfo = param1;
         super.data = value;
         maxStrength = int(TempleteManager.instance.goddessEquipTempCate.getMaxStrength());
         if(_data)
         {
            _lastStrengthLv = _data.equipStrengthenLevel;
            currTemp = TempleteManager.instance.goddessEquipTempCate.getEquipTempInfo(1,_data.equipType,_data.equipStrengthenLevel);
            _currItem.equipTemp = currTemp;
            _currItem.nameProfile = _data.equipAdvanceLevel + 1;
            refreshMetrals(currTemp);
            blessArr = currTemp.Blessing.split(",");
            _progress.progressValue(_data.equipCurBlessing,int(blessArr[1]));
            _eqStrengN1Txt.text = GoddessEquipTempInfo.getEquipName(currTemp.EquipType);
            _eqStrengN1Txt.setFrame(_data.equipAdvanceLevel + 1);
            _eqStrengN2Txt.text = "+" + currTemp.Grade;
            _equipCell.data = _data;
            if(isValueChanged)
            {
               _effect.alpha = 1;
               _effect.y = _effectOriY;
               TweenLite.from(_effect,0.5,{
                  "y":_effectOriY + 50,
                  "alpha":0,
                  "onComplete":function():void
                  {
                     TweenLite.to(_effect,0.5,{"alpha":0});
                  }
               });
               isValueChanged = false;
            }
            updateEffectShow();
            if(_data.equipStrengthenLevel >= maxStrength)
            {
               _data.isStrengthMax = true;
               _maxFlag.visible = true;
               _currItem.x = 85;
               _nextItem.visible = false;
               _xihaoImage.visible = false;
               _arrow.visible = false;
               _strengthKitIcon.visible = false;
               _strengthGoldIcon.visible = false;
               _eqGoldTxt.visible = false;
               _eqMetrailTxt.visible = false;
               _eqMetrailHasTxt.visible = false;
               _progress.showMax();
               _strengBtn.visible = false;
               _autoStrengBtn.visible = false;
               _cancelAutoBtn.visible = false;
            }
            else
            {
               _maxFlag.visible = false;
               _currItem.x = 12;
               _nextItem.visible = true;
               _xihaoImage.visible = true;
               _strengthKitIcon.visible = true;
               _strengthGoldIcon.visible = true;
               _eqGoldTxt.visible = true;
               _eqMetrailTxt.visible = true;
               _eqMetrailHasTxt.visible = true;
               _strengBtn.visible = true;
               nextTemp = TempleteManager.instance.goddessEquipTempCate.getEquipTempInfo(1,_data.equipType,_data.equipStrengthenLevel + 1);
               _nextItem.equipTemp = nextTemp;
               _nextItem.nameProfile = _data.equipAdvanceLevel + 1;
            }
         }
      }
      
      private function refreshMetrals(param1:GoddessEquipTempInfo) : void
      {
         if(_materialTemp == param1)
         {
            return;
         }
         _materialTemp = param1;
         refreshNeedGolds();
         refreshGoods();
      }
      
      private function refreshNeedGolds() : void
      {
         var _loc1_:int = 0;
         if(_materialTemp)
         {
            _loc1_ = _materialTemp.Grade * 10000 + 1000000;
            _eqGoldTxt.text = "" + _loc1_;
            _enoughGold = ResourceManager.instance.gold.count >= _loc1_;
         }
      }
      
      private function refreshGoods() : void
      {
         var _loc4_:Array = null;
         var _loc3_:Array = null;
         var _loc2_:int = 0;
         var _loc1_:GoddessEquipTempInfo = null;
         _enoughMaterial = false;
         if(_materialTemp)
         {
            _loc4_ = _materialTemp.AdvanceCost.split("#");
            _loc3_ = _loc4_[0].split(",");
            _eqMetrailTxt.text = "" + _loc3_[1];
            _loc2_ = int(GoodsManager.instance.getGoodsNumByTempId(int(_loc3_[0])));
            _eqMetrailHasTxt.text = LanguageMgr.GetTranslation("goddess.equip.hasMetral",_loc2_);
            _enoughMaterial = _loc2_ >= int(_loc3_[1]);
            _loc1_ = TempleteManager.instance.goddessEquipTempCate.getEquipTempInfo(2,_data.equipType,_data.equipAdvanceLevel);
            _enoughStep = _data.equipStrengthenLevel < _loc1_.StrengthenLevelMax;
         }
      }
      
      private function initEvent() : void
      {
         _strengBtn.addEventListener("click",clickStrengthHandler);
         _autoStrengBtn.addEventListener("click",clickAutoStrengthHandler);
         _cancelAutoBtn.addEventListener("click",clickCancelAutoStrengthHandler);
         GoodsManager.instance.addEventListener("DELETE_BAG",refreshGoodsHandler);
         GoodsManager.instance.addEventListener("UPDATE_BAG",refreshGoodsHandler);
         ResourceManager.instance.gold.addEventListener(ResourceEvent.RESOURCE_UPDATE,__refreshGoldHandler);
         NotificationManager.instance.addEventListener("GODDESS_EQUIMENT_DOUBLE",__refreshDouble);
      }
      
      private function removeEvent() : void
      {
         _strengBtn.removeEventListener("click",clickStrengthHandler);
         _autoStrengBtn.removeEventListener("click",clickAutoStrengthHandler);
         _cancelAutoBtn.removeEventListener("click",clickCancelAutoStrengthHandler);
         GoodsManager.instance.removeEventListener("DELETE_BAG",refreshGoodsHandler);
         GoodsManager.instance.removeEventListener("UPDATE_BAG",refreshGoodsHandler);
         ResourceManager.instance.gold.removeEventListener(ResourceEvent.RESOURCE_UPDATE,__refreshGoldHandler);
         NotificationManager.instance.removeEventListener("GODDESS_EQUIMENT_DOUBLE",__refreshDouble);
      }
      
      private function __refreshDouble(param1:NotificationEvent) : void
      {
         updateEffectShow();
      }
      
      private function __refreshGoldHandler(param1:ResourceEvent) : void
      {
         refreshNeedGolds();
      }
      
      private function refreshGoodsHandler(param1:BagEvent) : void
      {
         refreshGoods();
      }
      
      private function clickStrengthHandler(param1:MouseEvent) : void
      {
         if(isCanUp)
         {
            GodDessManager.instance.requestOp(8,_data.ownerId,_data.equipType);
         }
      }
      
      private function clickAutoStrengthHandler(param1:MouseEvent) : void
      {
         if(isCanUp)
         {
            isAuto = true;
            GodDessManager.instance.requestOp(8,_data.ownerId,_data.equipType);
         }
         else
         {
            isAuto = false;
         }
      }
      
      private function clickCancelAutoStrengthHandler(param1:MouseEvent) : void
      {
         isAuto = false;
      }
      
      private function set cancelBtnVisible(param1:Boolean) : void
      {
         if(!_data.isStrengthMax)
         {
            _cancelAutoBtn.visible = param1;
            _autoStrengBtn.visible = !param1;
         }
         else
         {
            _cancelAutoBtn.visible = false;
            _autoStrengBtn.visible = false;
         }
      }
      
      public function get isAuto() : Boolean
      {
         return _isAuto;
      }
      
      public function set isAuto(param1:Boolean) : void
      {
         _isAuto = param1;
         cancelBtnVisible = _isAuto;
         if(!_isAuto)
         {
            clearTimer();
         }
      }
      
      private function clearTimer() : void
      {
         if(_timer != 0)
         {
            clearInterval(_timer);
         }
         _timer = 0;
      }
      
      override public function updateView() : void
      {
         if(_data.equipStrengthenLevel > _lastStrengthLv)
         {
            isAuto = false;
         }
         else
         {
            autoDoHandlerUp();
         }
         isValueChanged = true;
         super.updateView();
      }
      
      private function autoDoHandlerUp() : void
      {
         if(_isAuto)
         {
            clearTimer();
            _timer = setInterval(autoHandPhaseUp,100);
         }
      }
      
      private function autoHandPhaseUp() : void
      {
         clearTimer();
         if(isCanUp)
         {
            GodDessManager.instance.requestOp(8,_data.ownerId,_data.equipType);
         }
         else
         {
            isAuto = false;
         }
      }
      
      private function get isCanUp() : Boolean
      {
         if(!_enoughStep)
         {
            MessageTipManager.instance().show(LanguageMgr.GetTranslation("goddess.equip.needStep"));
         }
         else if(!_enoughGold)
         {
            MessageTipManager.instance().show(LanguageMgr.GetTranslation("goddess.equip.noGold"));
         }
         else if(!_enoughMaterial)
         {
            MessageTipManager.instance().show(LanguageMgr.GetTranslation("goddess.equip.noMaterial"));
         }
         return _enoughMaterial && _enoughGold && _enoughStep;
      }
      
      override public function dispose() : void
      {
         isAuto = false;
         removeEvent();
         TweenLite.killTweensOf(_effect);
         ObjectUtils.disposeObject(_eqGoldTxt);
         _eqGoldTxt = null;
         ObjectUtils.disposeObject(_eqMetrailTxt);
         _eqMetrailTxt = null;
         ObjectUtils.disposeObject(_eqMetrailHasTxt);
         _eqMetrailHasTxt = null;
         ObjectUtils.disposeObject(_zfFt);
         _zfFt = null;
         ObjectUtils.disposeObject(_numBack);
         _numBack = null;
         ObjectUtils.disposeObject(_eqStrengN1Txt);
         _eqStrengN1Txt = null;
         ObjectUtils.disposeObject(_eqStrengN2Txt);
         _eqStrengN2Txt = null;
         ObjectUtils.disposeObject(_currItem);
         _currItem = null;
         ObjectUtils.disposeObject(_nextItem);
         _nextItem = null;
         ObjectUtils.disposeObject(_equipCell);
         _equipCell = null;
         ObjectUtils.disposeObject(_arrow);
         _arrow = null;
         ObjectUtils.disposeObject(_progress);
         _progress = null;
         ObjectUtils.disposeObject(_strengBtn);
         _strengBtn = null;
         ObjectUtils.disposeObject(_autoStrengBtn);
         _autoStrengBtn = null;
         ObjectUtils.disposeObject(_cancelAutoBtn);
         _cancelAutoBtn = null;
         ObjectUtils.disposeObject(_maxFlag);
         _maxFlag = null;
         ObjectUtils.disposeObject(_strengthKitIcon);
         _strengthKitIcon = null;
         ObjectUtils.disposeObject(_strengthGoldIcon);
         _strengthGoldIcon = null;
         ObjectUtils.disposeObject(_activity);
         _activity = null;
         ObjectUtils.disposeObject(_effect);
         _effect = null;
         super.dispose();
      }
   }
}

