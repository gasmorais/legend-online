package vehicle.daimontrial.view
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import manager.LanguageMgr;
   import mvc.module.vehicle.DaimonModel;
   import yishi.datas.templates.VehicleObjectTempInfo;
   import yishi.datas.templates.VehicleSkillTempInfo;
   import yishi.manager.TempleteManager;
   import yishi.utils.StringHelper;
   import yishi.view.tips.BaseTip;
   
   public class DaimonInfoTip extends BaseTip
   {
      
      private var _titleTxt:FilterFrameText;
      
      private var _labelTxt01:FilterFrameText;
      
      private var _labelTxt02:FilterFrameText;
      
      private var _labelTxt03:FilterFrameText;
      
      private var _labelTxt04:FilterFrameText;
      
      private var _valueTxt:FilterFrameText;
      
      private var _condition:FilterFrameText;
      
      private var _skillTxt:FilterFrameText;
      
      private var _conditionTxt:FilterFrameText;
      
      public function DaimonInfoTip()
      {
         super();
      }
      
      override protected function init() : void
      {
         super.init();
         _titleTxt = ComponentFactory.Instance.creatComponentByStylename("DaimonInfoTip.TitleTxt");
         _labelTxt01 = ComponentFactory.Instance.creatComponentByStylename("DaimonInfoTip.NameTxt");
         _labelTxt02 = ComponentFactory.Instance.creatComponentByStylename("DaimonInfoTip.NameTxt");
         _labelTxt03 = ComponentFactory.Instance.creatComponentByStylename("DaimonInfoTip.NameTxt");
         _labelTxt04 = ComponentFactory.Instance.creatComponentByStylename("DaimonInfoTip.NameTxt");
         _valueTxt = ComponentFactory.Instance.creatComponentByStylename("DaimonInfoTip.ValueTxt");
         _skillTxt = ComponentFactory.Instance.creatComponentByStylename("DaimonInfoTip.DescTxt");
         _conditionTxt = ComponentFactory.Instance.creatComponentByStylename("DaimonInfoTip.ConditionTxt");
         _labelTxt02.y = 52;
         _labelTxt03.y = 70;
         _labelTxt04.y = 88;
         addChild(_titleTxt);
         addChild(_labelTxt01);
         addChild(_labelTxt02);
         addChild(_labelTxt03);
         addChild(_labelTxt04);
         addChild(_valueTxt);
         addChild(_skillTxt);
         addChild(_conditionTxt);
         _bg.width = 190;
         updateTransform();
      }
      
      override protected function updateTransform() : void
      {
         var _loc2_:VehicleObjectTempInfo = null;
         var _loc3_:VehicleSkillTempInfo = null;
         var _loc1_:String = null;
         super.updateTransform();
         var _loc5_:DaimonModel = new DaimonModel();
         var _loc4_:String = "{0}+<font color=\'#50ea3c\'>{1}</font><br/>{2}+<font color=\'#50ea3c\'>{3}</font><br/>{4}+<font color=\'#50ea3c\'>{5}</font><br/>{6}<br/>";
         if(tipData)
         {
            _loc2_ = tipData as VehicleObjectTempInfo;
            if(_loc2_ && !_loc5_.isActive(_loc2_.TemplateId))
            {
               _loc1_ = "";
               if(_loc2_.autoOpenGrade > 1)
               {
                  _loc1_ = LanguageMgr.GetTranslation("vehicle.condition");
                  _loc1_ += "<br/>" + LanguageMgr.GetTranslation("vehicle.autoOpen",_loc2_.autoOpenGrade);
               }
               if(_loc2_.NeedDiamond > 0)
               {
                  if(_loc1_ == "")
                  {
                     _loc1_ = LanguageMgr.GetTranslation("vehicle.condition");
                  }
                  _loc1_ += "<br/>" + LanguageMgr.GetTranslation("vehicle.moneyOpen",_loc2_.NeedGrades,_loc2_.NeedDiamond);
               }
               _conditionTxt.htmlText = _loc1_;
            }
            else
            {
               _conditionTxt.text = "";
            }
            _bg.width = 190;
            _skillTxt.width = 168;
         }
         else
         {
            _loc2_ = _loc5_.vehicleTemplate;
            _conditionTxt.htmlText = "";
            _bg.width = 150;
            _skillTxt.width = 130;
         }
         if(!_loc2_)
         {
            return;
         }
         _loc3_ = TempleteManager.instance.vehicleSkillTempteCate.getTemplateByTid(_loc2_.GeniusSkill);
         _titleTxt.htmlText = _loc2_.TemplateName;
         _labelTxt01.text = LanguageMgr.GetTranslation("armyII.ThaneAttributeView.Tip11");
         _labelTxt02.text = LanguageMgr.GetTranslation("public.attack1");
         _labelTxt03.text = LanguageMgr.GetTranslation("battle.view.ui.AttackModeView.defenseBtnModeName");
         _labelTxt04.text = LanguageMgr.GetTranslation("vehicle.DaimonInfoTipSpeed");
         _valueTxt.htmlText = StringHelper.format(_loc4_,_loc2_.Hp,_loc5_.hp,_loc2_.Attack,_loc5_.attack,_loc2_.Defence,_loc5_.defence,_loc2_.Speed);
         _skillTxt.htmlText = LanguageMgr.GetTranslation("public.colon",_loc3_.TemplateName) + _loc3_.Description;
         if(!StringHelper.isNullOrEmpty(_conditionTxt.htmlText))
         {
            _conditionTxt.y = _skillTxt.y + _skillTxt.textHeight + 10;
            _bg.height = _conditionTxt.y + _conditionTxt.textHeight + 20;
         }
         else
         {
            _bg.height = _skillTxt.y + _skillTxt.textHeight + 20;
         }
      }
      
      override public function dispose() : void
      {
         ObjectUtils.disposeAllChildren(this);
         super.dispose();
      }
   }
}

