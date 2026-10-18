package yishi.view.tips
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.container.VBox;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Sprite;
   import manager.LanguageMgr;
   import yishi.datas.templates.VehicleSkillBuffTemplate;
   import yishi.datas.templates.VehicleSkillTempInfo;
   
   public class DaimonSkillTip extends BaseTip
   {
      
      private var _nameSprite:Sprite;
      
      private var _totalBox:VBox;
      
      private var _injuryTxt:FilterFrameText;
      
      private var _nameTxt:FilterFrameText;
      
      private var _castTime:FilterFrameText;
      
      private var _coolDown:FilterFrameText;
      
      private var _descTxt:FilterFrameText;
      
      public function DaimonSkillTip()
      {
         super();
      }
      
      override protected function init() : void
      {
         super.init();
         _totalBox = ComponentFactory.Instance.creatComponentByStylename("DaimonSkillTip.totalVBox");
         _nameTxt = ComponentFactory.Instance.creatComponentByStylename("DaimonSkillTip.NameTxt1");
         _injuryTxt = ComponentFactory.Instance.creatComponentByStylename("DaimonSkillTip.NameTxt2");
         _castTime = ComponentFactory.Instance.creatComponentByStylename("tips.SkillCoolDownText");
         _coolDown = ComponentFactory.Instance.creatComponentByStylename("tips.SkillCoolDownText");
         _descTxt = ComponentFactory.Instance.creatComponentByStylename("DaimonSkillTip.DescTxt");
         _nameSprite = new Sprite();
         _bg.width = 200;
         addChild(_totalBox);
      }
      
      override protected function updateTransform() : void
      {
         var _loc2_:VehicleSkillTempInfo = null;
         var _loc1_:VehicleSkillBuffTemplate = null;
         _totalBox.removeAllChild();
         super.updateTransform();
         if(tipData)
         {
            if(tipData is VehicleSkillTempInfo)
            {
               _loc2_ = tipData as VehicleSkillTempInfo;
               _nameTxt.text = _loc2_.TemplateName;
               _injuryTxt.text = LanguageMgr.GetTranslation("yishi.view.tips.DaimonSkillTip.injuryTxt" + _loc2_.InjuryEffect);
               _castTime.text = LanguageMgr.GetTranslation("yishi.view.tips.goods.SkillTips.castTime",_loc2_.CastTime / 1000);
               _coolDown.text = LanguageMgr.GetTranslation("yishi.view.tips.goods.SkillTips.cooldown01",_loc2_.CoolDown / 1000);
               _descTxt.htmlText = _loc2_.Description;
               _nameSprite.addChild(_nameTxt);
               _nameSprite.addChild(_injuryTxt);
               _totalBox.addChild(_nameSprite);
               if(_loc2_.InjuryEffect == 3)
               {
                  _totalBox.addChild(_descTxt);
               }
               else
               {
                  _totalBox.addChild(_castTime);
                  _totalBox.addChild(_coolDown);
                  _totalBox.addChild(_descTxt);
               }
            }
            else if(tipData is VehicleSkillBuffTemplate)
            {
               _loc1_ = tipData as VehicleSkillBuffTemplate;
               _nameTxt.text = _loc1_.Name;
               _descTxt.htmlText = _loc1_.Description;
               _castTime.text = LanguageMgr.GetTranslation("yishi.view.tips.goods.SkillTips.lastTime",int(_loc1_.Duration / 1000));
               _coolDown.text = LanguageMgr.GetTranslation("emailII.view.EmailItemView.leftTime",_loc1_.leftTime) + LanguageMgr.GetTranslation("public.time.second");
               _totalBox.addChild(_nameTxt);
               _totalBox.addChild(_castTime);
               _totalBox.addChild(_coolDown);
               _totalBox.addChild(_descTxt);
            }
            else
            {
               _nameTxt.text = LanguageMgr.GetTranslation("vehicle.vehicleTech");
               _descTxt.htmlText = LanguageMgr.GetTranslation("vehicle.vehicleTechDesc");
               _totalBox.addChild(_nameTxt);
               _totalBox.addChild(_descTxt);
            }
            _totalBox.refreshChildPos();
            _bg.height = _descTxt.y + _descTxt.textHeight + 20;
            _bg.width = _totalBox.displayWidth + 10;
         }
      }
      
      override public function dispose() : void
      {
         ObjectUtils.disposeAllChildren(this);
         _nameTxt = null;
         _descTxt = null;
         _injuryTxt = null;
         _nameSprite = null;
         _castTime = null;
         _coolDown = null;
         super.dispose();
      }
   }
}

