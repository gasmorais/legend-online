package goddess.view
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.IconButton;
   import com.pickgliss.ui.image.MutipleImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import flash.events.MouseEvent;
   import goddess.item.GoddessLevelItem;
   import goddess.page.GoddessBaseView;
   import goddess.vo.EquipAddVo;
   import manager.LanguageMgr;
   import managers.GodDessManager;
   import mvc.module.goddess.GoddessEquipInfo;
   import mvc.module.goddess.GoddessInfo;
   import yishi.datas.templates.GoddessEquipTempInfo;
   import yishi.datas.templates.SkillTempInfo;
   import yishi.manager.TempleteManager;
   import yishi.utils.IconFactory;
   import yishi.utils.MsgMan;
   import yishi.view.base.ProgressPanel;
   import yishi.view.community.BaseIconView;
   import yishi.view.tips.MessageTipManager;
   
   public class GoddessLevelView extends GoddessBaseView
   {
      
      private var _bg:MutipleImage;
      
      private var _upLvBtn:IconButton;
      
      private var _skillNameBg:MutipleImage;
      
      private var _guardSkillIcon:BaseIconView;
      
      private var _dancingSkillIcon:BaseIconView;
      
      private var _inputTipTxt:FilterFrameText;
      
      private var _hasTxt:FilterFrameText;
      
      private var _progress:ProgressPanel;
      
      private var _currItem:GoddessLevelItem;
      
      private var _nextItem:GoddessLevelItem;
      
      private var _item:BaseIconView;
      
      public function GoddessLevelView()
      {
         super();
         initView();
         initEvent();
      }
      
      private function initView() : void
      {
         _bg = ComponentFactory.Instance.creatComponentByStylename("ui.goddess.upLvBack");
         _inputTipTxt = ComponentFactory.Instance.creatComponentByStylename("ui.goddess.lvNeedTipTxt");
         _inputTxt = ComponentFactory.Instance.creatComponentByStylename("ui.goddess.lvInputTxt");
         _hasTxt = ComponentFactory.Instance.creatComponentByStylename("ui.goddess.lvHasTipTxt");
         _upLvBtn = ComponentFactory.Instance.creatComponentByStylename("ui.goddess.lvBtn");
         _skillNameBg = ComponentFactory.Instance.creatComponentByStylename("ui.goddess.lvSkillFont");
         _currItem = ComponentFactory.Instance.creatCustomObject("ui.goddess.currLvItem",[1]);
         _nextItem = ComponentFactory.Instance.creatCustomObject("ui.goddess.nextLvItem",[2]);
         _progress = ComponentFactory.Instance.creatCustomObject("ui.goddess.lvProgressPanel");
         _guardSkillIcon = ComponentFactory.Instance.creatCustomObject("ui.goddess.level.guradeSkillIcon");
         _dancingSkillIcon = ComponentFactory.Instance.creatCustomObject("ui.goddess.level.dancingSkillIcon");
         _item = ComponentFactory.Instance.creatCustomObject("ui.goddess.itemIcon");
         _progress.initView("asset.goddess.progressBack","asset.goddess.progressBar","ui.goddess.progressTxt");
         addChild(_bg);
         addChild(_skillNameBg);
         addChild(_inputTipTxt);
         addChild(_inputTxt);
         addChild(_hasTxt);
         addChild(_currItem);
         addChild(_nextItem);
         addChild(_progress);
         addChild(_upLvBtn);
         addChild(_guardSkillIcon);
         addChild(_dancingSkillIcon);
         addChild(_item);
         _inputTipTxt.text = LanguageMgr.GetTranslation("goddess.advance.inputItemNum");
      }
      
      override protected function initEvent() : void
      {
         super.initEvent();
         _upLvBtn.addEventListener("click",clickLevelHandler);
         MsgMan.addObserver("GodDessEvent.level",this,levelHandler);
         MsgMan.addObserver("GodDessEvent.expLevel",this,expLevelHandler);
      }
      
      override protected function removeEvent() : void
      {
         super.removeEvent();
         _upLvBtn.removeEventListener("click",clickLevelHandler);
         MsgMan.removeObserver("GodDessEvent.level",this,levelHandler);
         MsgMan.removeObserver("GodDessEvent.expLevel",this,expLevelHandler);
      }
      
      private function levelHandler(param1:String, param2:Object) : void
      {
         var _loc3_:GoddessInfo = param2 as GoddessInfo;
         if(_data == _loc3_)
         {
            data = _loc3_;
         }
      }
      
      private function expLevelHandler(param1:String, param2:Object) : void
      {
         var _loc3_:GoddessInfo = param2 as GoddessInfo;
         if(_data == _loc3_)
         {
            refreshExp(true);
         }
      }
      
      private function clickLevelHandler(param1:MouseEvent) : void
      {
         if(_data == null)
         {
            return;
         }
         var _loc2_:int = int(_inputTxt.text);
         if(_loc2_ <= 0)
         {
            MessageTipManager.instance().show(LanguageMgr.GetTranslation("goddess.input.zeroTip"));
            return;
         }
         _lastHasGoodsNum = _hasGoodsNum;
         GodDessManager.instance.requestOp(2,_data.tempInfo.TemplateId,_loc2_);
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
         if(_data != null)
         {
            refreshItems();
            refreshExp();
            refreshSkills();
         }
      }
      
      private function refreshItems() : void
      {
         var _loc1_:EquipAddVo = getEquipAddVo();
         _currItem.refreshView(_data.levelTempInfo,_data.advanceTempInfo.AddPer,_loc1_);
         _nextItem.refreshView(_data.nextLevelTempInfo,_data.advanceTempInfo.AddPer,_loc1_);
      }
      
      private function getEquipAddVo() : EquipAddVo
      {
         var _loc2_:GoddessEquipInfo = null;
         var _loc1_:EquipAddVo = new EquipAddVo();
         if(_data && _data.isActive)
         {
            _loc2_ = _data.equips[1];
            _loc1_.Live = getOneEquipAddValue(_loc2_);
            _loc2_ = _data.equips[2];
            _loc1_.Defance = getOneEquipAddValue(_loc2_);
            _loc2_ = _data.equips[3];
            _loc1_.Attack = getOneEquipAddValue(_loc2_);
            _loc2_ = _data.equips[4];
            _loc1_.MagicDefance = getOneEquipAddValue(_loc2_);
         }
         return _loc1_;
      }
      
      private function getOneEquipAddValue(param1:GoddessEquipInfo) : int
      {
         var _loc2_:int = 0;
         var _loc5_:int = 0;
         var _loc9_:int = 0;
         var _loc7_:Array = null;
         var _loc3_:Array = null;
         var _loc6_:int = 0;
         var _loc8_:GoddessEquipTempInfo = TempleteManager.instance.goddessEquipTempCate.getEquipTempInfo(1,param1.equipType,param1.equipStrengthenLevel);
         if(_loc8_)
         {
            _loc7_ = _loc8_.getKeyValues();
            _loc5_ = int(_loc7_[0][0]);
         }
         var _loc4_:GoddessEquipTempInfo = TempleteManager.instance.goddessEquipTempCate.getEquipTempInfo(2,param1.equipType,param1.equipAdvanceLevel);
         if(_loc4_)
         {
            _loc3_ = _loc4_.getKeyValues();
            _loc6_ = int(_loc3_.length == 0 ? 0 : _loc3_[0][0]);
            _loc9_ = _loc5_ * _loc6_ / 100;
         }
         return int(_loc5_ + _loc9_);
      }
      
      private function refreshExp(param1:Boolean = false) : void
      {
         if(_data.nextLevelTempInfo)
         {
            _progress.progressValue(_data.gradeGp,_data.nextLevelTempInfo.NeedGp);
            needItemId = _data.nextLevelTempInfo.NeedItemId;
            _item.icon = IconFactory.getGoodsIconByTID(_needItemId);
            _item.tipData = _gInfo;
            if(_needItemTempInfo)
            {
               _hasTxt.text = LanguageMgr.GetTranslation("goddess.level.hasItem",_needItemTempInfo.TemplateName,_hasGoodsNum);
               _inputTxt.text = Math.min(_hasGoodsNum,1) + "";
            }
            _upLvBtn.enable = true;
         }
         else
         {
            _upLvBtn.enable = false;
            needItemId = _data.levelTempInfo.NeedItemId;
            _item.icon = IconFactory.getGoodsIconByTID(_needItemId);
            _item.tipData = _gInfo;
            if(_needItemTempInfo)
            {
               _hasTxt.text = LanguageMgr.GetTranslation("goddess.level.hasItem",_needItemTempInfo.TemplateName,_hasGoodsNum);
               _inputTxt.text = Math.min(_hasGoodsNum,1) + "";
            }
            _progress.showMax();
         }
         if(param1)
         {
            showAddExp();
         }
      }
      
      private function refreshSkills() : void
      {
         var _loc2_:SkillTempInfo = TempleteManager.instance.getSkillTemplateInfoById(_data.dedicationTempInfo.SkillId);
         _guardSkillIcon.icon = IconFactory.getTecIconByIcon(_loc2_.Icons);
         _guardSkillIcon.tipData = _loc2_;
         var _loc1_:SkillTempInfo = TempleteManager.instance.getSkillTemplateInfoById(_data.advanceTempInfo.SkillId);
         _dancingSkillIcon.icon = IconFactory.getTecIconByIcon(_loc1_.Icons);
         _dancingSkillIcon.tipData = _loc1_;
      }
      
      override public function dispose() : void
      {
         removeEvent();
         ObjectUtils.disposeObject(_bg);
         _bg = null;
         ObjectUtils.disposeObject(_skillNameBg);
         _skillNameBg = null;
         ObjectUtils.disposeObject(_upLvBtn);
         _upLvBtn = null;
         ObjectUtils.disposeObject(_guardSkillIcon);
         _guardSkillIcon = null;
         ObjectUtils.disposeObject(_dancingSkillIcon);
         _dancingSkillIcon = null;
         ObjectUtils.disposeObject(_inputTxt);
         _inputTxt = null;
         ObjectUtils.disposeObject(_inputTipTxt);
         _inputTipTxt = null;
         ObjectUtils.disposeObject(_hasTxt);
         _hasTxt = null;
         ObjectUtils.disposeObject(_progress);
         _progress = null;
         ObjectUtils.disposeObject(_currItem);
         _currItem = null;
         ObjectUtils.disposeObject(_nextItem);
         _nextItem = null;
         ObjectUtils.disposeObject(_item);
         _item = null;
         super.dispose();
      }
   }
}

