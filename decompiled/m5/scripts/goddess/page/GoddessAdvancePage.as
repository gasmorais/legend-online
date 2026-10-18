package goddess.page
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.IconButton;
   import com.pickgliss.ui.image.Image;
   import com.pickgliss.ui.image.MutipleImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import flash.events.MouseEvent;
   import goddess.item.GoddessAdvanceItem;
   import manager.LanguageMgr;
   import managers.GodDessManager;
   import mvc.module.goddess.GodDessModel;
   import mvc.module.goddess.GoddessInfo;
   import yishi.datas.templates.GoddessAdvaceTempInfo;
   import yishi.datas.templates.GoddessUpLevelTempInfo;
   import yishi.utils.IconFactory;
   import yishi.utils.MsgMan;
   import yishi.view.base.ProgressPanel;
   import yishi.view.base.TextAddBitmap;
   import yishi.view.community.BaseIconView;
   import yishi.view.tips.MessageTipManager;
   
   public class GoddessAdvancePage extends GoddessBaseView
   {
      
      private var _bg:MutipleImage;
      
      private var _currItem:GoddessAdvanceItem;
      
      private var _nextItem:GoddessAdvanceItem;
      
      private var _advanceBtn:IconButton;
      
      private var _progress:ProgressPanel;
      
      private var _item:BaseIconView;
      
      private var _needGradeTxt:FilterFrameText;
      
      private var _proback:MutipleImage;
      
      private var _needItemNumTxt:FilterFrameText;
      
      private var _inputTitle:FilterFrameText;
      
      private var _inputBack:Image;
      
      private var _attackPro:TextAddBitmap;
      
      private var _defancePro:TextAddBitmap;
      
      private var _magicDefancePro:TextAddBitmap;
      
      private var _livePro:TextAddBitmap;
      
      public function GoddessAdvancePage()
      {
         super();
         initView();
         initEvent();
         data = model.selectInfo;
      }
      
      private function get model() : GodDessModel
      {
         return GodDessManager.instance.model;
      }
      
      override protected function initEvent() : void
      {
         super.initEvent();
         _advanceBtn.addEventListener("mouseOut",outHandler);
         _advanceBtn.addEventListener("mouseOver",overHandler);
         _advanceBtn.addEventListener("click",clickAdvanceHandler);
         MsgMan.addObserver("GodDessEvent.step",this,stepHandler);
         MsgMan.addObserver("GodDessEvent.expStep",this,expStepHandler);
         MsgMan.addObserver("GodDessEvent.choose",this,chooseHandler);
      }
      
      override protected function removeEvent() : void
      {
         super.removeEvent();
         _advanceBtn.removeEventListener("mouseOut",outHandler);
         _advanceBtn.removeEventListener("mouseOver",overHandler);
         _advanceBtn.removeEventListener("click",clickAdvanceHandler);
         MsgMan.removeObserver("GodDessEvent.step",this,stepHandler);
         MsgMan.removeObserver("GodDessEvent.expStep",this,expStepHandler);
         MsgMan.removeObserver("GodDessEvent.choose",this,chooseHandler);
      }
      
      private function chooseHandler(param1:String, param2:Object) : void
      {
         var _loc3_:GoddessInfo = param2 as GoddessInfo;
         data = _loc3_;
      }
      
      private function clickAdvanceHandler(param1:MouseEvent) : void
      {
         if(_data == null)
         {
            return;
         }
         if(_data.nextAdvanceTempInfo && _data.grade < _data.nextAdvanceTempInfo.NeedGrade && _data.stepGp >= _data.nextAdvanceTempInfo.NeedGp)
         {
            MessageTipManager.instance().show(LanguageMgr.GetTranslation("goddess.advance.gradeNoArm"));
            return;
         }
         var _loc2_:int = int(_inputTxt.text);
         if(_loc2_ <= 0)
         {
            MessageTipManager.instance().show(LanguageMgr.GetTranslation("goddess.input.zeroTip"));
            return;
         }
         _lastHasGoodsNum = _hasGoodsNum;
         GodDessManager.instance.requestOp(3,_data.tempInfo.TemplateId,_loc2_);
      }
      
      private function stepHandler(param1:String, param2:Object) : void
      {
         var _loc3_:GoddessInfo = param2 as GoddessInfo;
         if(_data == _loc3_)
         {
            data = _loc3_;
         }
      }
      
      private function expStepHandler(param1:String, param2:Object) : void
      {
         var _loc3_:GoddessInfo = param2 as GoddessInfo;
         if(_data == _loc3_)
         {
            refreshExp(true);
         }
      }
      
      private function outHandler(param1:MouseEvent = null) : void
      {
         if(_data == null)
         {
            return;
         }
         showProValues(_data.levelTempInfo,_data.advanceTempInfo);
      }
      
      private function overHandler(param1:MouseEvent) : void
      {
         if(_data == null)
         {
            return;
         }
         showProValues(_data.levelTempInfo,_data.nextAdvanceTempInfo,2);
      }
      
      private function initView() : void
      {
         _bg = ComponentFactory.Instance.creatComponentByStylename("ui.goddess.advanceBg");
         _currItem = ComponentFactory.Instance.creatCustomObject("ui.goddess.currAdvanceItem",[1]);
         _nextItem = ComponentFactory.Instance.creatCustomObject("ui.goddess.nextAdvanceItem",[2]);
         _progress = ComponentFactory.Instance.creatCustomObject("ui.goddess.advanceProgressPanel");
         _item = ComponentFactory.Instance.creatCustomObject("ui.goddess.itemIcon");
         _advanceBtn = ComponentFactory.Instance.creatComponentByStylename("ui.goddess.advanceBtn");
         _needGradeTxt = ComponentFactory.Instance.creatComponentByStylename("ui.goddess.advanceNeedTxt");
         _proback = ComponentFactory.Instance.creatComponentByStylename("ui.goddess.advanceFontBg");
         _attackPro = ComponentFactory.Instance.creatCustomObject("ui.goddess.advanceProAttack");
         _defancePro = ComponentFactory.Instance.creatCustomObject("ui.goddess.advanceProDefance");
         _magicDefancePro = ComponentFactory.Instance.creatCustomObject("ui.goddess.advanceProMagicDefance");
         _livePro = ComponentFactory.Instance.creatCustomObject("ui.goddess.advanceProLife");
         _needItemNumTxt = ComponentFactory.Instance.creatComponentByStylename("ui.goddess.advanceHasTipTxt");
         _inputTitle = ComponentFactory.Instance.creatComponentByStylename("ui.goddess.advanceInputTitleTxt");
         _inputTxt = ComponentFactory.Instance.creatComponentByStylename("ui.goddess.advanceInputTxt");
         _inputBack = ComponentFactory.Instance.creatComponentByStylename("ui.goddess.advanceInputBack");
         _progress.initView("asset.goddess.progressBack","asset.goddess.progressBar","ui.goddess.progressTxt");
         _attackPro.initView("ui.goddess.advanceProTxt","asset.goddess.advanceArrow","left");
         _defancePro.initView("ui.goddess.advanceProTxt","asset.goddess.advanceArrow","left");
         _magicDefancePro.initView("ui.goddess.advanceProTxt","asset.goddess.advanceArrow","left");
         _livePro.initView("ui.goddess.advanceProTxt","asset.goddess.advanceArrow","left");
         addChild(_bg);
         addChild(_currItem);
         addChild(_nextItem);
         addChild(_progress);
         addChild(_item);
         addChild(_needGradeTxt);
         addChild(_needItemNumTxt);
         addChild(_inputTitle);
         addChild(_inputBack);
         addChild(_inputTxt);
         addChild(_advanceBtn);
         addChild(_proback);
         addChild(_attackPro);
         addChild(_defancePro);
         addChild(_magicDefancePro);
         addChild(_livePro);
         _inputTitle.text = LanguageMgr.GetTranslation("goddess.advance.inputItemNum");
      }
      
      override public function dispose() : void
      {
         removeEvent();
         ObjectUtils.disposeObject(_bg);
         _bg = null;
         ObjectUtils.disposeObject(_currItem);
         _currItem = null;
         ObjectUtils.disposeObject(_nextItem);
         _nextItem = null;
         ObjectUtils.disposeObject(_progress);
         _progress = null;
         ObjectUtils.disposeObject(_item);
         _item = null;
         ObjectUtils.disposeObject(_advanceBtn);
         _advanceBtn = null;
         ObjectUtils.disposeObject(_needGradeTxt);
         _needGradeTxt = null;
         ObjectUtils.disposeObject(_proback);
         _proback = null;
         ObjectUtils.disposeObject(_needItemNumTxt);
         _needItemNumTxt = null;
         ObjectUtils.disposeObject(_inputTitle);
         _inputTitle = null;
         ObjectUtils.disposeObject(_inputBack);
         _inputBack = null;
         ObjectUtils.disposeObject(_inputTxt);
         _inputTxt = null;
         ObjectUtils.disposeObject(_attackPro);
         _attackPro = null;
         ObjectUtils.disposeObject(_defancePro);
         _defancePro = null;
         ObjectUtils.disposeObject(_magicDefancePro);
         _magicDefancePro = null;
         ObjectUtils.disposeObject(_livePro);
         _livePro = null;
         super.dispose();
      }
      
      override public function set data(param1:GoddessInfo) : void
      {
         if(_isDispose)
         {
            return;
         }
         super.data = param1;
         refreshView();
      }
      
      private function refreshView() : void
      {
         if(_data == null)
         {
            return;
         }
         _currItem.data = _data.advanceTempInfo;
         _nextItem.data = _data.nextAdvanceTempInfo;
         refreshExp();
         showProValues(_data.levelTempInfo,_data.advanceTempInfo);
      }
      
      private function refreshExp(param1:Boolean = false) : void
      {
         if(_data.nextAdvanceTempInfo)
         {
            _needGradeTxt.text = LanguageMgr.GetTranslation("goddess.advance.needGrade",_data.nextAdvanceTempInfo.NeedGrade);
            if(_data.grade >= _data.nextAdvanceTempInfo.NeedGrade)
            {
               _needGradeTxt.setFrame(2);
            }
            else
            {
               _needGradeTxt.setFrame(1);
            }
            _progress.progressValue(_data.stepGp,_data.nextAdvanceTempInfo.NeedGp);
            needItemId = _data.nextAdvanceTempInfo.NeedItemId;
            _item.icon = IconFactory.getGoodsIconByTID(_needItemId);
            _item.tipData = _gInfo;
            if(_needItemTempInfo)
            {
               _needItemNumTxt.text = LanguageMgr.GetTranslation("goddess.level.hasItem",_needItemTempInfo.TemplateName,_hasGoodsNum);
               _inputTxt.text = Math.min(_hasGoodsNum,1) + "";
            }
            _advanceBtn.enable = true;
         }
         else
         {
            needItemId = _data.advanceTempInfo.NeedItemId;
            _item.icon = IconFactory.getGoodsIconByTID(_needItemId);
            _item.tipData = _gInfo;
            if(_needItemTempInfo)
            {
               _needItemNumTxt.text = LanguageMgr.GetTranslation("goddess.level.hasItem",_needItemTempInfo.TemplateName,_hasGoodsNum);
               _inputTxt.text = Math.min(_hasGoodsNum,1) + "";
            }
            _advanceBtn.enable = false;
            _needGradeTxt.text = "";
            _progress.showMax();
         }
         if(param1)
         {
            showAddExp();
         }
      }
      
      private function showProValues(param1:GoddessUpLevelTempInfo, param2:GoddessAdvaceTempInfo, param3:int = 1) : void
      {
         var _loc6_:int = 0;
         var _loc4_:int = 0;
         var _loc5_:int = 0;
         var _loc7_:int = 0;
         var _loc8_:int = 0;
         if(param1 != null && param2 != null)
         {
            _loc6_ = int(param2.AddPer);
            _loc4_ = int(GodDessManager.calculationAddValue(param1.Attack,_loc6_));
            _loc5_ = int(GodDessManager.calculationAddValue(param1.Defance,_loc6_));
            _loc7_ = int(GodDessManager.calculationAddValue(param1.MagicDefance,_loc6_));
            _loc8_ = int(GodDessManager.calculationAddValue(param1.Live,_loc6_));
            if(param3 == 1)
            {
               _attackPro.outText(_loc4_ + "");
               _defancePro.outText(_loc5_ + "");
               _magicDefancePro.outText(_loc7_ + "");
               _livePro.outText(_loc8_ + "");
            }
            else
            {
               _attackPro.overText(_loc4_ + "");
               _defancePro.overText(_loc5_ + "");
               _magicDefancePro.overText(_loc7_ + "");
               _livePro.overText(_loc8_ + "");
            }
         }
      }
   }
}

