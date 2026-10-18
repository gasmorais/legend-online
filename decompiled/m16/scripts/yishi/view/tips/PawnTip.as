package yishi.view.tips
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.container.HBox;
   import com.pickgliss.ui.controls.container.VBox;
   import com.pickgliss.ui.image.ScaleBitmapImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Sprite;
   import manager.LanguageMgr;
   import mvc.module.armyII.ArmyPawn;
   import yishi.datas.templates.SkillTempInfo;
   import yishi.manager.TempleteManager;
   
   public class PawnTip extends BaseTip
   {
      
      private var _contain:VBox;
      
      private var _name:FilterFrameText;
      
      private var _lifeContain:HBox;
      
      private var _life:FilterFrameText;
      
      private var _lifeValue:FilterFrameText;
      
      private var _physicalAttackContain:HBox;
      
      private var _physicalAttack:FilterFrameText;
      
      private var _physicalAttackValue:FilterFrameText;
      
      private var _physicalDefenseContain:HBox;
      
      private var _physicalDefense:FilterFrameText;
      
      private var _physicalDefenseValue:FilterFrameText;
      
      private var _magicAttackContain:HBox;
      
      private var _magicAttack:FilterFrameText;
      
      private var _magicAttackValue:FilterFrameText;
      
      private var _magicDefenceContain:HBox;
      
      private var _magicDefence:FilterFrameText;
      
      private var _magicDefenceValue:FilterFrameText;
      
      private var _skill:FilterFrameText;
      
      private var _skillValue:FilterFrameText;
      
      private var _line1:ScaleBitmapImage;
      
      private var _line2:ScaleBitmapImage;
      
      public function PawnTip()
      {
         super();
      }
      
      override protected function init() : void
      {
         super.init();
         _bg.width = 215;
         _bg.height = 240;
         _contain = ComponentFactory.Instance.creatComponentByStylename("tips.TipContain");
         _name = ComponentFactory.Instance.creatComponentByStylename("tips.PawnNameText");
         _contain.addChild(_name);
         _line1 = ComponentFactory.Instance.creatComponentByStylename("tips.PawnTipLine1");
         _contain.addChild(_line1);
         _lifeContain = ComponentFactory.Instance.creatComponentByStylename("tip.TipItemBox");
         _life = ComponentFactory.Instance.creatComponentByStylename("tips.PawnLifeText");
         _life.text = LanguageMgr.GetTranslation("armyII.ThaneAttributeView.Tip11");
         _lifeValue = ComponentFactory.Instance.creatComponentByStylename("tips.PawnLifeValueText");
         _lifeContain.addChild(_life);
         _lifeContain.addChild(_lifeValue);
         _contain.addChild(_lifeContain);
         _physicalAttackContain = ComponentFactory.Instance.creatComponentByStylename("tip.TipItemBox");
         _physicalAttack = ComponentFactory.Instance.creatComponentByStylename("tips.PawnAttackText");
         _physicalAttack.text = LanguageMgr.GetTranslation("armyII.ThaneAttributeView.Tip13");
         _physicalAttackValue = ComponentFactory.Instance.creatComponentByStylename("tips.PawnAttackValueText");
         _physicalAttackContain.addChild(_physicalAttack);
         _physicalAttackContain.addChild(_physicalAttackValue);
         _contain.addChild(_physicalAttackContain);
         _magicAttackContain = ComponentFactory.Instance.creatComponentByStylename("tip.TipItemBox");
         _magicAttack = ComponentFactory.Instance.creatComponentByStylename("tips.PawnAgilityText");
         _magicAttack.text = LanguageMgr.GetTranslation("armyII.ThaneAttributeView.Tip15");
         _magicAttackValue = ComponentFactory.Instance.creatComponentByStylename("tips.PawnAgilityValueText");
         _magicAttackContain.addChild(_magicAttack);
         _magicAttackContain.addChild(_magicAttackValue);
         _contain.addChild(_magicAttackContain);
         _physicalDefenseContain = ComponentFactory.Instance.creatComponentByStylename("tip.TipItemBox");
         _physicalDefense = ComponentFactory.Instance.creatComponentByStylename("tips.PawnDefenseText");
         _physicalDefense.text = LanguageMgr.GetTranslation("armyII.ThaneAttributeView.Tip14");
         _physicalDefenseValue = ComponentFactory.Instance.creatComponentByStylename("tips.PawnDefenseValueText");
         _physicalDefenseContain.addChild(_physicalDefense);
         _physicalDefenseContain.addChild(_physicalDefenseValue);
         _contain.addChild(_physicalDefenseContain);
         _magicDefenceContain = ComponentFactory.Instance.creatComponentByStylename("tip.TipItemBox");
         _magicDefence = ComponentFactory.Instance.creatComponentByStylename("tips.PawnAbilityText");
         _magicDefence.text = LanguageMgr.GetTranslation("armyII.ThaneAttributeView.Tip16");
         _magicDefenceValue = ComponentFactory.Instance.creatComponentByStylename("tips.PawnAbilityValueText");
         _magicDefenceContain.addChild(_magicDefence);
         _magicDefenceContain.addChild(_magicDefenceValue);
         _contain.addChild(_magicDefenceContain);
         _line2 = ComponentFactory.Instance.creatComponentByStylename("tips.PawnTipLine2");
         _contain.addChild(_line2);
         _skill = ComponentFactory.Instance.creatComponentByStylename("tips.PawnSkillText");
         _skill.text = LanguageMgr.GetTranslation("armyII.ThaneAttributeView.Tip18");
         _skillValue = ComponentFactory.Instance.creatComponentByStylename("tips.PawnSkillValueText");
         _contain.addChild(_skill);
         _contain.addChild(_skillValue);
         addChild(_contain);
      }
      
      private function clean() : void
      {
         _contain.removeAllChild();
         _contain.refreshChildPos();
      }
      
      private function refreshAttribute(param1:int, param2:int, param3:FilterFrameText, param4:Sprite) : void
      {
         if(param1 > 0)
         {
            if(param2 > 0)
            {
               param3.htmlText = param1 + "<font color=\'#48d72a\'>+" + param2 + "</font>";
            }
            else
            {
               param3.htmlText = param1.toString();
            }
            _contain.addChild(param4);
         }
      }
      
      override protected function updateTransform() : void
      {
         var _loc2_:ArmyPawn = null;
         var _loc1_:String = null;
         if(tipData is ArmyPawn)
         {
            clean();
            _loc2_ = tipData as ArmyPawn;
            _name.text = LanguageMgr.GetTranslation("public.level.name",_loc2_.templateInfo.PawnName,_loc2_.templateInfo.Level);
            _contain.addChild(_name);
            _contain.addChild(_line1);
            refreshAttribute(_loc2_.templateInfo.Live,_loc2_.live - _loc2_.templateInfo.Live,_lifeValue,_lifeContain);
            refreshAttribute(_loc2_.templateInfo.Attack,_loc2_.attack - _loc2_.templateInfo.Attack,_physicalAttackValue,_physicalAttackContain);
            refreshAttribute(_loc2_.templateInfo.MagicAttack,_loc2_.magicAttack - _loc2_.templateInfo.MagicAttack,_magicAttackValue,_magicAttackContain);
            refreshAttribute(_loc2_.templateInfo.Defence,_loc2_.defence - _loc2_.templateInfo.Defence,_physicalDefenseValue,_physicalDefenseContain);
            refreshAttribute(_loc2_.templateInfo.MagicDefence,_loc2_.magicDefence - _loc2_.templateInfo.MagicDefence,_magicDefenceValue,_magicDefenceContain);
            _loc1_ = getSkill(_loc2_.templateInfo.HighSkill);
            if(_loc1_ != "")
            {
               _skillValue.text = _loc1_;
               _skillValue.height = _skillValue.textHeight + _skillValue.numLines * 2;
               _contain.addChild(_line2);
               _contain.addChild(_skill);
               _contain.addChild(_skillValue);
            }
            _bg.height = _contain.y + _contain.height + 15;
            if(_bg.width < _name.x + _name.width + 30)
            {
               _bg.width = _name.x + _name.width + 30;
            }
         }
      }
      
      private function getSkill(param1:String) : String
      {
         var _loc4_:SkillTempInfo = null;
         var _loc2_:String = "";
         var _loc3_:Array = param1.split(",");
         for each(var _loc5_:String in _loc3_)
         {
            _loc4_ = TempleteManager.instance.getSkillTemplateInfoById(int(_loc5_));
            if(_loc4_)
            {
               _loc2_ += _loc4_.TemplateName + "\n";
            }
         }
         return _loc2_;
      }
      
      override public function dispose() : void
      {
         if(_contain)
         {
            ObjectUtils.disposeObject(_contain);
         }
         _contain = null;
         if(_name)
         {
            ObjectUtils.disposeObject(_name);
         }
         _name = null;
         if(_lifeContain)
         {
            ObjectUtils.disposeObject(_lifeContain);
         }
         _lifeContain = null;
         if(_life)
         {
            ObjectUtils.disposeObject(_life);
         }
         _life = null;
         if(_lifeValue)
         {
            ObjectUtils.disposeObject(_lifeValue);
         }
         _lifeValue = null;
         if(_physicalAttackContain)
         {
            ObjectUtils.disposeObject(_physicalAttackContain);
         }
         _physicalAttackContain = null;
         if(_physicalAttack)
         {
            ObjectUtils.disposeObject(_physicalAttack);
         }
         _physicalAttack = null;
         if(_physicalAttackValue)
         {
            ObjectUtils.disposeObject(_physicalAttackValue);
         }
         _physicalAttackValue = null;
         if(_physicalDefenseContain)
         {
            ObjectUtils.disposeObject(_physicalDefenseContain);
         }
         _physicalDefenseContain = null;
         if(_physicalDefense)
         {
            ObjectUtils.disposeObject(_physicalDefense);
         }
         _physicalDefense = null;
         if(_physicalDefenseValue)
         {
            ObjectUtils.disposeObject(_physicalDefenseValue);
         }
         _physicalDefenseValue = null;
         if(_magicAttackContain)
         {
            ObjectUtils.disposeObject(_magicAttackContain);
         }
         _magicAttackContain = null;
         if(_magicAttack)
         {
            ObjectUtils.disposeObject(_magicAttack);
         }
         _magicAttack = null;
         if(_magicAttackValue)
         {
            ObjectUtils.disposeObject(_magicAttackValue);
         }
         _magicAttackValue = null;
         if(_magicDefenceContain)
         {
            ObjectUtils.disposeObject(_magicDefenceContain);
         }
         _magicDefenceContain = null;
         if(_magicDefence)
         {
            ObjectUtils.disposeObject(_magicDefence);
         }
         _magicDefence = null;
         if(_magicDefenceValue)
         {
            ObjectUtils.disposeObject(_magicDefenceValue);
         }
         _magicDefenceValue = null;
         if(_skill)
         {
            ObjectUtils.disposeObject(_skill);
         }
         _skill = null;
         if(_skillValue)
         {
            ObjectUtils.disposeObject(_skillValue);
         }
         _skillValue = null;
         if(_line1)
         {
            ObjectUtils.disposeObject(_line1);
         }
         _line1 = null;
         if(_line2)
         {
            ObjectUtils.disposeObject(_line2);
         }
         _line2 = null;
         ObjectUtils.disposeAllChildren(this);
         super.dispose();
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}

