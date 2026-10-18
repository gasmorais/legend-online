package yishi.view.tips
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Bitmap;
   import manager.LanguageMgr;
   import managers.PlayerCurrencyManager;
   import mvc.module.card.MagicCardInfo;
   import yishi.datas.templates.MagicCardTemplateInfo;
   import yishi.datas.templates.SkillTempInfo;
   import yishi.manager.TempleteManager;
   
   public class MagicCardLvUpTips extends BaseTip
   {
      
      private var _nameTxt:FilterFrameText;
      
      private var _lvTxt:FilterFrameText;
      
      private var _skillNameTxt0:FilterFrameText;
      
      private var _line01:Bitmap;
      
      private var _nextLvTxt:FilterFrameText;
      
      private var _skillNameTxt1:FilterFrameText;
      
      private var _lvUpNeedItemCount:FilterFrameText;
      
      public function MagicCardLvUpTips()
      {
         super();
      }
      
      override protected function init() : void
      {
         super.init();
         _bg.width = 250;
         _nameTxt = ComponentFactory.Instance.creatComponentByStylename("tips.magiccardNameTxt");
         _lvTxt = ComponentFactory.Instance.creatComponentByStylename("tips.magiccardLvTxt");
         _skillNameTxt0 = ComponentFactory.Instance.creatComponentByStylename("tips.magiccardSkillNameTxt");
         _line01 = ComponentFactory.Instance.creatBitmap("asset.tips.splitLine");
         _line01.width = 210;
         _nextLvTxt = ComponentFactory.Instance.creatComponentByStylename("tips.magiccardnextLvTxt");
         _skillNameTxt1 = ComponentFactory.Instance.creatComponentByStylename("tips.magiccardSkillNameTxt");
         _lvUpNeedItemCount = ComponentFactory.Instance.creatComponentByStylename("tips.magiccardLvUpNeedItemTxt");
         addChild(_nameTxt);
         addChild(_lvTxt);
         addChild(_skillNameTxt0);
         addChild(_line01);
         addChild(_nextLvTxt);
         addChild(_skillNameTxt1);
         addChild(_lvUpNeedItemCount);
      }
      
      private function clear() : void
      {
         _nameTxt.text = "";
         _lvTxt.text = "";
         _skillNameTxt0.text = "";
         if(_line01 && this.contains(_line01))
         {
            this.removeChild(_line01);
         }
         _nextLvTxt.text = "";
         _skillNameTxt1.text = "";
         _lvUpNeedItemCount.text = "";
      }
      
      override protected function updateTransform() : void
      {
         var _loc5_:int = 0;
         var _loc6_:SkillTempInfo = null;
         var _loc1_:MagicCardTemplateInfo = null;
         clear();
         _nameTxt.text = MagicCardInfo(tipData).templateName;
         _lvTxt.y = _nameTxt.y + 10;
         _lvTxt.text = LanguageMgr.GetTranslation("public.level2",MagicCardInfo(tipData).grades);
         var _loc4_:MagicCardTemplateInfo = TempleteManager.instance.magicCardTemplateCate.getTempInfoByTypePosGrades(MagicCardInfo(tipData).types,MagicCardInfo(tipData).pos,MagicCardInfo(tipData).grades);
         _skillNameTxt0.y = _nameTxt.y + 30;
         var _loc3_:Array = _loc4_.SkillTempIds.split(",");
         var _loc2_:String = "";
         _loc5_ = 0;
         while(_loc5_ < _loc3_.length)
         {
            _loc6_ = TempleteManager.instance.getSkillTemplateInfoById(_loc3_[_loc5_]);
            _loc2_ += _loc6_.TemplateName;
            if(_loc5_ < _loc3_.length - 1)
            {
               _loc2_ += ",";
            }
            _loc5_++;
         }
         _skillNameTxt0.text = _loc2_;
         if(MagicCardInfo(tipData).grades < TempleteManager.instance.magicCardTemplateCate.maxGP)
         {
            _line01.y = _skillNameTxt0.y + _skillNameTxt0.textHeight + 15;
            _nextLvTxt.y = _line01.y + 15;
            _nextLvTxt.text = LanguageMgr.GetTranslation("buildings.BaseBuildFrame.next");
            _loc1_ = TempleteManager.instance.magicCardTemplateCate.getTempInfoByTypePosGrades(MagicCardInfo(tipData).types,MagicCardInfo(tipData).pos,MagicCardInfo(tipData).grades + 1);
            _loc3_ = _loc1_.SkillTempIds.split(",");
            _loc2_ = "";
            _loc5_ = 0;
            while(_loc5_ < _loc3_.length)
            {
               _loc6_ = TempleteManager.instance.getSkillTemplateInfoById(_loc3_[_loc5_]);
               _loc2_ += _loc6_.TemplateName;
               if(_loc5_ < _loc3_.length - 1)
               {
                  _loc2_ += ",";
               }
               _loc5_++;
            }
            _skillNameTxt1.y = _nextLvTxt.y + 30;
            _skillNameTxt1.text = _loc2_;
            _lvUpNeedItemCount.y = _skillNameTxt1.y + 55;
            _lvUpNeedItemCount.text = LanguageMgr.GetTranslation("yishi.view.tips.MagicCardLvUpTips._lvUpNeedItemCount",_loc1_.NeedMagicDust);
            _lvUpNeedItemCount.setFrame(1);
            if(_loc1_.NeedMagicDust > PlayerCurrencyManager.instance.currencyInfo.magicDust.amount)
            {
               _lvUpNeedItemCount.setFrame(2);
            }
            _bg.height = _lvUpNeedItemCount.y + 55;
         }
         else
         {
            _lvTxt.text = LanguageMgr.GetTranslation("public.level2",MagicCardInfo(tipData).grades);
            _bg.height = _skillNameTxt0.y + _skillNameTxt0.textHeight + 50;
         }
      }
      
      override public function dispose() : void
      {
         ObjectUtils.disposeObject(_nameTxt);
         _nameTxt = null;
         ObjectUtils.disposeObject(_lvTxt);
         _lvTxt = null;
         ObjectUtils.disposeObject(_skillNameTxt0);
         _skillNameTxt0 = null;
         ObjectUtils.disposeObject(_line01);
         _line01 = null;
         ObjectUtils.disposeObject(_nextLvTxt);
         _nextLvTxt = null;
         ObjectUtils.disposeObject(_skillNameTxt1);
         _skillNameTxt1 = null;
         ObjectUtils.disposeObject(_lvUpNeedItemCount);
         _lvUpNeedItemCount = null;
         ObjectUtils.disposeAllChildren(this);
         super.dispose();
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}

