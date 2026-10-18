package child.attribute
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Sprite;
   import manager.LanguageMgr;
   import mvc.module.avenger.AvengerChildNsInfo;
   import yishi.datas.templates.SkillTempInfo;
   import yishi.manager.TempleteManager;
   
   public class ChildAttriTwoStepView extends Sprite
   {
      
      private var _reduceTxt:FilterFrameText;
      
      private var _lifeTxt:FilterFrameText;
      
      private var _defandTxt:FilterFrameText;
      
      private var _attackTxt:FilterFrameText;
      
      private var _magicDefandTxt:FilterFrameText;
      
      private var _data:AvengerChildNsInfo;
      
      public function ChildAttriTwoStepView()
      {
         super();
         initView();
      }
      
      private function initView() : void
      {
         _reduceTxt = ComponentFactory.Instance.creatComponentByStylename("ChildAttriTwoStepView.pro.decText");
         _lifeTxt = ComponentFactory.Instance.creatComponentByStylename("ChildAttriTwoStepView.pro.lifeTxt");
         _defandTxt = ComponentFactory.Instance.creatComponentByStylename("ChildAttriTwoStepView.pro.phgicDefTxt");
         _attackTxt = ComponentFactory.Instance.creatComponentByStylename("ChildAttriTwoStepView.pro.attackTxt");
         _magicDefandTxt = ComponentFactory.Instance.creatComponentByStylename("ChildAttriTwoStepView.pro.magicDefTxt");
         addChild(_reduceTxt);
         addChild(_lifeTxt);
         addChild(_defandTxt);
         addChild(_attackTxt);
         addChild(_magicDefandTxt);
      }
      
      public function set data(param1:AvengerChildNsInfo) : void
      {
         _data = param1;
         if(_data)
         {
            _lifeTxt.htmlText = LanguageMgr.GetTranslation("AvengerSkillEvolvePropItem.propText13",_data.addLive);
            _defandTxt.htmlText = LanguageMgr.GetTranslation("AvengerSkillEvolvePropItem.propText27",_data.addDefence);
            _attackTxt.htmlText = LanguageMgr.GetTranslation("AvengerSkillEvolvePropItem.propText11",_data.addAttack);
            _magicDefandTxt.htmlText = LanguageMgr.GetTranslation("AvengerSkillEvolvePropItem.propText28",_data.addMagicDefence);
         }
      }
      
      public function updateReduce(param1:int) : void
      {
         var _loc2_:SkillTempInfo = TempleteManager.instance.getSkillById(param1);
         if(_loc2_)
         {
            _reduceTxt.htmlText = LanguageMgr.GetTranslation("AvengerSkillEvolvePropItem.propText29",Math.abs(_loc2_.Parameter1));
         }
         else
         {
            _reduceTxt.htmlText = LanguageMgr.GetTranslation("AvengerSkillEvolvePropItem.propText29",0);
         }
      }
      
      public function dispose() : void
      {
         ObjectUtils.disposeObject(_reduceTxt);
         _reduceTxt = null;
         ObjectUtils.disposeObject(_lifeTxt);
         _lifeTxt = null;
         ObjectUtils.disposeObject(_defandTxt);
         _defandTxt = null;
         ObjectUtils.disposeObject(_attackTxt);
         _attackTxt = null;
         ObjectUtils.disposeObject(_magicDefandTxt);
         _magicDefandTxt = null;
         if(parent)
         {
            parent.removeChild(this);
         }
         _data = null;
      }
   }
}

