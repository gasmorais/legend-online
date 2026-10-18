package yishi.view.tips
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.container.HBox;
   import com.pickgliss.ui.controls.container.VBox;
   import com.pickgliss.ui.image.ScaleBitmapImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import flash.text.TextField;
   import manager.LanguageMgr;
   import yishi.datas.playerinfo.ThaneInfo;
   
   public class HeroTip extends BaseTip
   {
      
      private var _contain:VBox;
      
      private var _nameText:FilterFrameText;
      
      private var _levelText:TextField;
      
      private var _vocationText:TextField;
      
      private var _attackContain:HBox;
      
      private var _attackText:TextField;
      
      private var _attackTextSet:TextField;
      
      private var _agilityContain:HBox;
      
      private var _agilityText:TextField;
      
      private var _agilityTextSet:TextField;
      
      private var _spiritContain:HBox;
      
      private var _spiritText:TextField;
      
      private var _spiritTextSet:TextField;
      
      private var _growthContain:HBox;
      
      private var _growthText:TextField;
      
      private var _growthTextSet:TextField;
      
      private var _captainContain:HBox;
      
      private var _captainText:TextField;
      
      private var _captainTextSet:TextField;
      
      private var _line1:ScaleBitmapImage;
      
      private var _line2:ScaleBitmapImage;
      
      public function HeroTip()
      {
         super();
      }
      
      override protected function init() : void
      {
         super.init();
         _bg.width = 140;
         _bg.height = 200;
         _contain = ComponentFactory.Instance.creatComponentByStylename("tips.TipContain");
         _nameText = ComponentFactory.Instance.creatComponentByStylename("tips.HeroNameText");
         _contain.addChild(_nameText);
         _levelText = ComponentFactory.Instance.creatComponentByStylename("tips.HeroLevelText");
         _contain.addChild(_levelText);
         _vocationText = ComponentFactory.Instance.creatComponentByStylename("tips.HeroVocationText");
         _contain.addChild(_vocationText);
         _line1 = ComponentFactory.Instance.creatComponentByStylename("tips.HeroTipLine1");
         _contain.addChild(_line1);
         _growthContain = ComponentFactory.Instance.creatComponentByStylename("tip.TipItemBox");
         _growthText = ComponentFactory.Instance.creatComponentByStylename("tips.HeroGrowthText");
         _growthText.text = LanguageMgr.GetTranslation("yishi.view.tips.HeroTip.growth");
         _growthTextSet = ComponentFactory.Instance.creatComponentByStylename("tips.HeroGrowthValueText");
         _growthContain.addChild(_growthText);
         _growthContain.addChild(_growthTextSet);
         _contain.addChild(_growthContain);
         _line2 = ComponentFactory.Instance.creatComponentByStylename("tips.HeroTipLine1");
         _contain.addChild(_line2);
         _attackContain = ComponentFactory.Instance.creatComponentByStylename("tip.TipItemBox");
         _attackText = ComponentFactory.Instance.creatComponentByStylename("tips.HeroAttackText");
         _attackText.text = LanguageMgr.GetTranslation("yishi.view.tips.HeroTip.attack");
         _attackTextSet = ComponentFactory.Instance.creatComponentByStylename("tips.HeroAttackValueText");
         _attackContain.addChild(_attackText);
         _attackContain.addChild(_attackTextSet);
         _contain.addChild(_attackContain);
         _agilityContain = ComponentFactory.Instance.creatComponentByStylename("tip.TipItemBox");
         _agilityText = ComponentFactory.Instance.creatComponentByStylename("tips.HeroAgilityText");
         _agilityText.text = LanguageMgr.GetTranslation("yishi.view.tips.HeroTip.agility");
         _agilityTextSet = ComponentFactory.Instance.creatComponentByStylename("tips.HeroAgilityValueText");
         _agilityContain.addChild(_agilityText);
         _agilityContain.addChild(_agilityTextSet);
         _contain.addChild(_agilityContain);
         _spiritContain = ComponentFactory.Instance.creatComponentByStylename("tip.TipItemBox");
         _spiritText = ComponentFactory.Instance.creatComponentByStylename("tips.HeroAbilityText");
         _spiritText.text = LanguageMgr.GetTranslation("yishi.view.tips.HeroTip.spirit");
         _spiritTextSet = ComponentFactory.Instance.creatComponentByStylename("tips.HeroAbilityValueText");
         _spiritContain.addChild(_spiritText);
         _spiritContain.addChild(_spiritTextSet);
         _contain.addChild(_spiritContain);
         _captainContain = ComponentFactory.Instance.creatComponentByStylename("tip.TipItemBox");
         _captainText = ComponentFactory.Instance.creatComponentByStylename("tips.HeroCaptainText");
         _captainText.text = LanguageMgr.GetTranslation("yishi.view.tips.HeroTip.captain");
         _captainTextSet = ComponentFactory.Instance.creatComponentByStylename("tips.HeroCaptainValueText");
         _captainContain.addChild(_captainText);
         _captainContain.addChild(_captainTextSet);
         _contain.addChild(_captainContain);
         addChild(_contain);
      }
      
      override protected function updateTransform() : void
      {
         if(tipData)
         {
            _nameText.setFrame(1);
            _nameText.text = (tipData as ThaneInfo).nickName;
            _levelText.text = LanguageMgr.GetTranslation("yishi.view.tips.HeroTip.level") + ":" + (tipData as ThaneInfo).grades;
            _vocationText.text = LanguageMgr.GetTranslation("yishi.view.tips.HeroTip.vocation") + ":" + getJob(tipData);
            _attackTextSet.text = (tipData as ThaneInfo).baseProperty.baseAgilityPoint.toString();
            _agilityTextSet.text = (tipData as ThaneInfo).baseProperty.baseAgilityPoint.toString();
            _spiritTextSet.text = (tipData as ThaneInfo).baseProperty.baseIntellectPoint.toString();
            _growthTextSet.text = "0";
            _captainTextSet.text = (tipData as ThaneInfo).baseProperty.baseCaptainPoint.toString();
         }
      }
      
      private function getJob(param1:Object) : String
      {
         var _loc2_:int = int((param1 as ThaneInfo).templateInfo.Job);
         switch(_loc2_ - 1)
         {
            case 0:
               return LanguageMgr.GetTranslation("yishi.datas.consant.JobType.Name02");
            case 1:
               return LanguageMgr.GetTranslation("yishi.datas.consant.JobType.Name03");
            case 2:
               return LanguageMgr.GetTranslation("yishi.datas.consant.JobType.Name04");
            default:
               return "";
         }
      }
      
      override public function dispose() : void
      {
         if(_contain)
         {
            ObjectUtils.disposeObject(_contain);
         }
         _contain = null;
         if(_nameText)
         {
            ObjectUtils.disposeObject(_nameText);
         }
         _nameText = null;
         if(_levelText)
         {
            ObjectUtils.disposeObject(_levelText);
         }
         _levelText = null;
         if(_vocationText)
         {
            ObjectUtils.disposeObject(_vocationText);
         }
         _vocationText = null;
         if(_attackContain)
         {
            ObjectUtils.disposeObject(_attackContain);
         }
         _attackContain = null;
         if(_attackText)
         {
            ObjectUtils.disposeObject(_attackText);
         }
         _attackText = null;
         if(_attackTextSet)
         {
            ObjectUtils.disposeObject(_attackTextSet);
         }
         _attackTextSet = null;
         if(_agilityContain)
         {
            ObjectUtils.disposeObject(_agilityContain);
         }
         _agilityContain = null;
         if(_agilityText)
         {
            ObjectUtils.disposeObject(_agilityText);
         }
         _agilityText = null;
         if(_agilityTextSet)
         {
            ObjectUtils.disposeObject(_agilityTextSet);
         }
         _agilityTextSet = null;
         if(_spiritContain)
         {
            ObjectUtils.disposeObject(_spiritContain);
         }
         _spiritContain = null;
         if(_spiritText)
         {
            ObjectUtils.disposeObject(_spiritText);
         }
         _spiritText = null;
         if(_spiritTextSet)
         {
            ObjectUtils.disposeObject(_spiritTextSet);
         }
         _spiritTextSet = null;
         if(_growthContain)
         {
            ObjectUtils.disposeObject(_growthContain);
         }
         _growthContain = null;
         if(_growthText)
         {
            ObjectUtils.disposeObject(_growthText);
         }
         _growthText = null;
         if(_growthTextSet)
         {
            ObjectUtils.disposeObject(_growthTextSet);
         }
         _growthTextSet = null;
         if(_captainContain)
         {
            ObjectUtils.disposeObject(_captainContain);
         }
         _captainContain = null;
         if(_captainText)
         {
            ObjectUtils.disposeObject(_captainText);
         }
         _captainText = null;
         if(_captainTextSet)
         {
            ObjectUtils.disposeObject(_captainTextSet);
         }
         _captainTextSet = null;
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

