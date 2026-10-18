package playerinfo.view.playerattribute
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import yishi.datas.playerinfo.ThaneInfo;
   
   public class PlayerDetailedAttributeView extends Component
   {
      
      private var _physicAttackTxt:FilterFrameText;
      
      private var _physicDefenceTxt:FilterFrameText;
      
      private var _magicAttackTxt:FilterFrameText;
      
      private var _magicDefence:FilterFrameText;
      
      private var _critTxt:FilterFrameText;
      
      private var _parryTxt:FilterFrameText;
      
      private var _hpTxt:FilterFrameText;
      
      private var _countTxt:FilterFrameText;
      
      private var _strengthTxt:FilterFrameText;
      
      private var _agilityTxt:FilterFrameText;
      
      private var _abilityTxt:FilterFrameText;
      
      private var _physiqueTxt:FilterFrameText;
      
      private var _captainTxt:FilterFrameText;
      
      public function PlayerDetailedAttributeView()
      {
         super();
         initView();
      }
      
      private function initView() : void
      {
         _physicAttackTxt = ComponentFactory.Instance.creatComponentByStylename("army.attribute.PhysicAttackTxt");
         _physicDefenceTxt = ComponentFactory.Instance.creatComponentByStylename("army.attribute.PhysicDefenceTxt");
         _magicAttackTxt = ComponentFactory.Instance.creatComponentByStylename("army.attribute.MgicAttackTxt");
         _magicDefence = ComponentFactory.Instance.creatComponentByStylename("army.attribute.MagicDefenceTxt");
         _critTxt = ComponentFactory.Instance.creatComponentByStylename("army.attribute.CritTxt");
         _parryTxt = ComponentFactory.Instance.creatComponentByStylename("army.attribute.ParryTxt");
         _hpTxt = ComponentFactory.Instance.creatComponentByStylename("army.attribute.HpTxt");
         _countTxt = ComponentFactory.Instance.creatComponentByStylename("army.attribute.CountTxt");
         _strengthTxt = ComponentFactory.Instance.creatComponentByStylename("army.attribute.StrengthTxt");
         _agilityTxt = ComponentFactory.Instance.creatComponentByStylename("army.attribute.AgilityTxt");
         _abilityTxt = ComponentFactory.Instance.creatComponentByStylename("army.attribute.AbilityTxt");
         _physiqueTxt = ComponentFactory.Instance.creatComponentByStylename("army.attribute.PhysiqueTxt");
         _captainTxt = ComponentFactory.Instance.creatComponentByStylename("army.attribute.CaptainTxt");
         addChild(_physicAttackTxt);
         addChild(_physicDefenceTxt);
         addChild(_magicAttackTxt);
         addChild(_magicDefence);
         addChild(_critTxt);
         addChild(_parryTxt);
         addChild(_hpTxt);
         addChild(_countTxt);
         addChild(_strengthTxt);
         addChild(_agilityTxt);
         addChild(_abilityTxt);
         addChild(_physiqueTxt);
         addChild(_captainTxt);
      }
      
      public function refresh(param1:ThaneInfo) : void
      {
         _physicAttackTxt.text = param1.attackProrerty.totalPhyAttack.toString();
         _physicDefenceTxt.text = param1.attackProrerty.totalPhyDefence.toString();
         _magicAttackTxt.text = param1.attackProrerty.totalMagicAttack.toString();
         _magicDefence.text = param1.attackProrerty.totalMagicDefence.toString();
         _critTxt.text = param1.attackProrerty.totalForceHit.toString();
         _parryTxt.text = param1.attackProrerty.totalParry.toString();
         _hpTxt.text = param1.attackProrerty.totalLive.toString();
         _countTxt.text = param1.attackProrerty.totalConatArmy.toString();
         _strengthTxt.text = param1.baseProperty.totalPower.toString();
         _agilityTxt.text = param1.baseProperty.totalAgility.toString();
         _abilityTxt.text = param1.baseProperty.totalIntellect.toString();
         _captainTxt.text = param1.baseProperty.totalCaptain.toString();
         _physiqueTxt.text = param1.baseProperty.totalPhysique.toString();
      }
      
      override public function dispose() : void
      {
         ObjectUtils.disposeObject(_physicAttackTxt);
         _physicAttackTxt = null;
         ObjectUtils.disposeObject(_physicDefenceTxt);
         _physicDefenceTxt = null;
         ObjectUtils.disposeObject(_magicAttackTxt);
         _magicAttackTxt = null;
         ObjectUtils.disposeObject(_magicDefence);
         _magicDefence = null;
         ObjectUtils.disposeObject(_critTxt);
         _critTxt = null;
         ObjectUtils.disposeObject(_parryTxt);
         _parryTxt = null;
         ObjectUtils.disposeObject(_hpTxt);
         _hpTxt = null;
         ObjectUtils.disposeObject(_countTxt);
         _countTxt = null;
         ObjectUtils.disposeObject(_strengthTxt);
         _strengthTxt = null;
         ObjectUtils.disposeObject(_agilityTxt);
         _agilityTxt = null;
         ObjectUtils.disposeObject(_abilityTxt);
         _abilityTxt = null;
         ObjectUtils.disposeObject(_captainTxt);
         _captainTxt = null;
         ObjectUtils.disposeObject(_physiqueTxt);
         _physiqueTxt = null;
         ObjectUtils.disposeAllChildren(this);
         super.dispose();
      }
   }
}

