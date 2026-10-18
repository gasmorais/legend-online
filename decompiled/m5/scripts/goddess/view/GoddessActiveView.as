package goddess.view
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.IconButton;
   import com.pickgliss.ui.image.MutipleImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import manager.LanguageMgr;
   import managers.GodDessManager;
   import mvc.module.goddess.GoddessInfo;
   import yishi.datas.templates.GoddessAdvaceTempInfo;
   import yishi.datas.templates.GoddessDedicationTempInfo;
   import yishi.datas.templates.GoddessTempInfo;
   import yishi.datas.templates.GoddessUpLevelTempInfo;
   import yishi.datas.templates.GoodsTemplateInfo;
   import yishi.datas.templates.SkillTempInfo;
   import yishi.manager.GoodsManager;
   import yishi.manager.TempleteManager;
   import yishi.utils.IconFactory;
   import yishi.view.base.VPropertyBox;
   import yishi.view.community.BaseIconView;
   
   public class GoddessActiveView extends Sprite
   {
      
      private var _data:GoddessInfo;
      
      private var _activeConditionTxt:FilterFrameText;
      
      private var _activeBtn:IconButton;
      
      private var _bg:MutipleImage;
      
      private var _proHbox:VPropertyBox;
      
      private var _guardSkillIcon:BaseIconView;
      
      private var _dancingSkillIcon:BaseIconView;
      
      public function GoddessActiveView()
      {
         super();
         initView();
         initEvent();
      }
      
      private function initEvent() : void
      {
         _activeBtn.addEventListener("click",btnClickHandler);
      }
      
      private function removeEvent() : void
      {
         if(_activeBtn)
         {
            _activeBtn.removeEventListener("click",btnClickHandler);
         }
      }
      
      private function btnClickHandler(param1:MouseEvent) : void
      {
         if(_data == null)
         {
            return;
         }
         GodDessManager.instance.requestOp(1,_data.tempInfo.TemplateId);
      }
      
      public function get data() : GoddessInfo
      {
         return _data;
      }
      
      public function set data(param1:GoddessInfo) : void
      {
         var _loc4_:GoddessUpLevelTempInfo = null;
         var _loc9_:GoddessAdvaceTempInfo = null;
         var _loc3_:GoddessDedicationTempInfo = null;
         var _loc7_:int = 0;
         var _loc5_:GoodsTemplateInfo = null;
         var _loc10_:String = null;
         var _loc8_:SkillTempInfo = null;
         var _loc2_:SkillTempInfo = null;
         _data = param1;
         var _loc6_:GoddessTempInfo = _data.tempInfo;
         if(_loc6_ != null)
         {
            _loc4_ = TempleteManager.instance.goddessLevelTempCate.getTemplete(_data.type,_loc6_.MaxGrade);
            _loc9_ = TempleteManager.instance.goddessAdvanceTempCate.getTemplete(_data.type,_loc6_.MaxStep);
            _loc3_ = TempleteManager.instance.goddessDedicationTempCate.getTemplete(_data.type,_loc6_.MaxDevote);
            if(_loc4_ != null)
            {
               _loc7_ = int(_loc9_ != null ? _loc9_.AddPer : 100);
               _proHbox.attVale("Attack",GodDessManager.calculationAddValue(_loc4_.Attack,_loc7_) + "");
               _proHbox.attVale("Defance",GodDessManager.calculationAddValue(_loc4_.Defance,_loc7_) + "");
               _proHbox.attVale("MagicDefance",GodDessManager.calculationAddValue(_loc4_.MagicDefance,_loc7_) + "");
               _proHbox.attVale("Live",GodDessManager.calculationAddValue(_loc4_.Live,_loc7_) + "");
            }
            _activeBtn.enable = _loc6_.NeedItemCount <= GoodsManager.instance.getGoodsNumByTempId(_loc6_.NeedItemId) ? true : false;
            _loc5_ = TempleteManager.instance.goodsTemplateCate.getTemplateByID(_loc6_.NeedItemId);
            _loc10_ = _loc5_ ? _loc5_.TemplateName + "x" + _loc6_.NeedItemCount : "";
            _activeConditionTxt.text = LanguageMgr.GetTranslation("goddess.active.needItem",_loc10_);
            _loc8_ = TempleteManager.instance.getSkillTemplateInfoById(_loc3_.SkillId);
            _guardSkillIcon.icon = IconFactory.getTecIconByIcon(_loc8_.Icons);
            _guardSkillIcon.tipData = _loc8_;
            _loc2_ = TempleteManager.instance.getSkillTemplateInfoById(_loc9_.SkillId);
            _dancingSkillIcon.icon = IconFactory.getTecIconByIcon(_loc2_.Icons);
            _dancingSkillIcon.tipData = _loc2_;
         }
      }
      
      private function initView() : void
      {
         _bg = ComponentFactory.Instance.creatComponentByStylename("ui.goddess.activeBg");
         _activeConditionTxt = ComponentFactory.Instance.creatComponentByStylename("ui.goddess.activeNeedTxt");
         _activeBtn = ComponentFactory.Instance.creatComponentByStylename("ui.goddess.activeBtn");
         _proHbox = ComponentFactory.Instance.creatComponentByStylename("ui.goddess.preProsBox");
         _guardSkillIcon = ComponentFactory.Instance.creatCustomObject("ui.goddess.active.guradeSkillIcon");
         _dancingSkillIcon = ComponentFactory.Instance.creatCustomObject("ui.goddess.active.dancingSkillIcon");
         addChild(_bg);
         addChild(_activeConditionTxt);
         addChild(_activeBtn);
         addChild(_proHbox);
         addChild(_guardSkillIcon);
         addChild(_dancingSkillIcon);
         _proHbox.register(["Attack","Defance","MagicDefance","Live"]);
      }
      
      public function dispose() : void
      {
         removeEvent();
         ObjectUtils.disposeObject(_bg);
         _bg = null;
         ObjectUtils.disposeObject(_activeConditionTxt);
         _activeConditionTxt = null;
         ObjectUtils.disposeObject(_activeBtn);
         _activeBtn = null;
         ObjectUtils.disposeObject(_proHbox);
         _proHbox = null;
         ObjectUtils.disposeObject(_guardSkillIcon);
         _guardSkillIcon = null;
         ObjectUtils.disposeObject(_dancingSkillIcon);
         _dancingSkillIcon = null;
         if(parent)
         {
            parent.removeChild(this);
         }
         _data = null;
      }
   }
}

