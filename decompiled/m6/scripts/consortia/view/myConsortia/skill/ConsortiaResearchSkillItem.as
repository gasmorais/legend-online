package consortia.view.myConsortia.skill
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.TextButton;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import com.pickgliss.utils.SoundManager;
   import events.ConsortiaEvent;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import manager.LanguageMgr;
   import mvc.module.consortia.ConsortiaModel;
   import mvc.module.consortia.ConsortiaTemplete;
   import mvc.module.consortia.ConsortiaTempleteInfo;
   import yishi.filter.UIFilter;
   import yishi.interfaces.IFilterFormat;
   import yishi.manager.FrameControllerManager;
   import yishi.manager.TempleteManager;
   import yishi.utils.ConsortiaSkillHelper;
   import yishi.utils.IconFactory;
   import yishi.view.community.BaseIconView;
   import yishi.view.tips.ConsortiaSkillTipInfo;
   
   public class ConsortiaResearchSkillItem extends Sprite implements Disposeable
   {
      
      private var _bg:Bitmap;
      
      private var _iconBg:Bitmap;
      
      private var _icon:BaseIconView;
      
      private var _nameTxt:FilterFrameText;
      
      private var _effectTxt:FilterFrameText;
      
      private var _limitTxt:FilterFrameText;
      
      private var _researchSkillBtn:TextButton;
      
      private var _data:ConsortiaTempleteInfo;
      
      private var _filter:IFilterFormat;
      
      public function ConsortiaResearchSkillItem()
      {
         super();
         initView();
      }
      
      private function initView() : void
      {
         _filter = new UIFilter();
         _bg = ComponentFactory.Instance.creatBitmap("asset.consortia.researchSkillItemBg");
         _iconBg = ComponentFactory.Instance.creatBitmap("asset.consortia.skillIconBg01");
         _icon = ComponentFactory.Instance.creatCustomObject("consortia.ResearchBaseIconView");
         _nameTxt = ComponentFactory.Instance.creatComponentByStylename("consortia.ResearchSkillNameTextStyle");
         _effectTxt = ComponentFactory.Instance.creatComponentByStylename("consortia.ResearchSkillEffectTextStyle");
         _limitTxt = ComponentFactory.Instance.creatComponentByStylename("consortia.ResearchSkillLimitTextStyle");
         _researchSkillBtn = ComponentFactory.Instance.creatComponentByStylename("consortia.researchSkillBtn");
         _nameTxt.text = "";
         _effectTxt.text = "";
         _limitTxt.text = "";
         _researchSkillBtn.text = LanguageMgr.GetTranslation("consortia.view.myConsortia.skill.ConsortiaResearchSkillItem.researchSkillBtn");
         _researchSkillBtn.visible = false;
         _icon.tipStyle = "consortia.ConsortiaSkillTip";
         addChild(_bg);
         addChild(_icon);
         addChild(_nameTxt);
         addChild(_effectTxt);
         addChild(_researchSkillBtn);
      }
      
      private function uninit() : void
      {
         ObjectUtils.disposeAllChildren(this);
         ObjectUtils.disposeObject(_bg);
         _bg = null;
         _researchSkillBtn = null;
         _data = null;
      }
      
      private function addEvent() : void
      {
         _researchSkillBtn.addEventListener("click",__onResearchSkillHandler);
         _data.addEventListener("ON_TEMPLETEID_UPDATA",__onLevelUpdata);
         model.addEventListener("UPDA_CONSORTIA_RIGHTS",__setRights);
      }
      
      private function removeEvent() : void
      {
         _researchSkillBtn.removeEventListener("click",__onResearchSkillHandler);
         if(_data)
         {
            _data.removeEventListener("ON_TEMPLETEID_UPDATA",__onLevelUpdata);
         }
         model.removeEventListener("UPDA_CONSORTIA_RIGHTS",__setRights);
      }
      
      private function __onResearchSkillHandler(param1:MouseEvent) : void
      {
         SoundManager.instance.play("022");
         if(_data.nextTemplateInfo.NeedOffer > model.consortiaInfo.offer)
         {
            ConsortiaSkillHelper.addWealth();
            return;
         }
         FrameControllerManager.instance.consortiaController.consortiaUpgrade(_data.nextTemplateInfo);
      }
      
      private function __onLevelUpdata(param1:ConsortiaEvent) : void
      {
         refreshView();
      }
      
      private function __setRights(param1:Event) : void
      {
         _researchSkillBtn.visible = true;
      }
      
      private function get model() : ConsortiaModel
      {
         return FrameControllerManager.instance.consortiaController.model;
      }
      
      public function get data() : ConsortiaTempleteInfo
      {
         return _data;
      }
      
      public function set data(param1:ConsortiaTempleteInfo) : void
      {
         _data = param1;
         if(_data)
         {
            __setRights(null);
            addEvent();
            refreshView();
         }
         else
         {
            _nameTxt.text = "";
            _effectTxt.text = "";
            _researchSkillBtn.visible = false;
         }
      }
      
      private function refreshView() : void
      {
         var _loc2_:String = LanguageMgr.GetTranslation("public.level");
         var _loc1_:String = LanguageMgr.GetTranslation("consortia.view.myConsortia.skill.ConsortiaResearchSkillItem.nameTxtUseWealth");
         _nameTxt.text = _data.nextTemplateInfo.LevelName + "   " + LanguageMgr.GetTranslation("public.level2",_data.nextTemplateInfo.Levels);
         _effectTxt.text = _loc1_ + _data.nextTemplateInfo.NeedOffer;
         _icon.icon = IconFactory.getTecIconByIcon(_data.nextTemplateInfo.Icon);
         if(_researchSkillBtn.visible)
         {
            setTips();
            checkBtnEnable();
         }
         setFilter();
      }
      
      private function setFilter() : void
      {
         var _loc1_:String = null;
         var _loc2_:ConsortiaTemplete = TempleteManager.instance.getConsortiaTempleteById(_data.nextTemplateInfo.PreTemplateId);
         if(FrameControllerManager.instance.consortiaController.model.consortiaInfo.schoolLevel < _loc2_.Levels)
         {
            _filter.setGrayFilter(this);
            if(_researchSkillBtn.parent)
            {
               _researchSkillBtn.parent.removeChild(_researchSkillBtn);
            }
            _loc1_ = LanguageMgr.GetTranslation("consortia.view.myConsortia.skill.ConsortiaResearchSkillItem.limitTxtTip",String(_loc2_.Levels));
            _limitTxt.text = _loc1_;
            addChild(_limitTxt);
         }
         else
         {
            _filter.setNormalFilter(this);
            addChild(_researchSkillBtn);
            if(_limitTxt.parent)
            {
               _limitTxt.parent.removeChild(_limitTxt);
            }
         }
      }
      
      private function checkBtnEnable() : void
      {
         var _loc1_:Boolean = Boolean(FrameControllerManager.instance.consortiaController.getRightsByIndex(2));
         if(_data.level >= 10 || !_loc1_)
         {
            _researchSkillBtn.enable = false;
         }
         else
         {
            _researchSkillBtn.enable = true;
         }
      }
      
      private function setTips() : void
      {
         var _loc1_:int = 0;
         var _loc4_:String = null;
         var _loc3_:String = null;
         var _loc2_:ConsortiaTemplete = _data.nextTemplateInfo;
         var _loc6_:ConsortiaSkillTipInfo = new ConsortiaSkillTipInfo();
         if(_data.level >= 10)
         {
            _loc4_ = LanguageMgr.GetTranslation("consortia.view.myConsortia.skill.ConsortiaResearchSkillItem.tipTitle1");
            _loc6_.title = _loc4_;
            _researchSkillBtn.tipData = _loc6_;
            _icon.tipData = _loc6_;
            return;
         }
         var _loc5_:String = LanguageMgr.GetTranslation("consortia.view.myConsortia.skill.ConsortiaResearchSkillItem.tipTitle2");
         _loc6_.title = _loc5_;
         _loc6_.addItem(_loc2_.Description);
         if(getPreCondition(_loc2_))
         {
            _loc1_++;
            _loc3_ = LanguageMgr.GetTranslation("consortia.view.myConsortia.skill.ConsortiaResearchSkillItem.tipAddItem");
            _loc6_.addItem(_loc3_ + getPreCondition(_loc2_));
         }
         _researchSkillBtn.tipData = _loc6_;
         _icon.tipData = _loc6_;
      }
      
      private function getPreCondition(param1:ConsortiaTemplete) : String
      {
         var _loc2_:ConsortiaTemplete = null;
         var _loc3_:* = null;
         if(param1.PreTemplateId)
         {
            _loc2_ = TempleteManager.instance.getConsortiaTempleteById(param1.PreTemplateId);
            return LanguageMgr.GetTranslation("consortia.view.myConsortia.skill.ConsortiaResearchSkillItem.preTempTip",_loc2_.LevelName,_loc2_.Levels);
         }
         return null;
      }
      
      public function dispose() : void
      {
         removeEvent();
         uninit();
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}

