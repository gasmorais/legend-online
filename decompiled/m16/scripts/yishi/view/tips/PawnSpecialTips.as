package yishi.view.tips
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import manager.LanguageMgr;
   import yishi.datas.templates.PawnSpecialTempInfo;
   
   public class PawnSpecialTips extends BaseTip
   {
      
      private var _name:FilterFrameText;
      
      private var _describe:FilterFrameText;
      
      public function PawnSpecialTips()
      {
         super();
      }
      
      override protected function init() : void
      {
         super.init();
         _bg.width = 250;
         _name = ComponentFactory.Instance.creatComponentByStylename("tip.PawnSpecialName");
         _describe = ComponentFactory.Instance.creatComponentByStylename("tip.PawnSpecialDesc");
         addChild(_name);
         addChild(_describe);
      }
      
      override protected function updateTransform() : void
      {
         if(tipData)
         {
            _name.htmlText = (tipData as PawnSpecialTempInfo).TemplateName + " <font color=\'#ffffff\'>" + LanguageMgr.GetTranslation("public.level2",(tipData as PawnSpecialTempInfo).Grades) + "</font>";
            _describe.text = (tipData as PawnSpecialTempInfo).Description;
            _describe.height = _describe.textHeight + 5;
            _bg.height = _describe.y + _describe.height + 10;
         }
      }
      
      override public function dispose() : void
      {
         if(_name)
         {
            ObjectUtils.disposeObject(_name);
         }
         _name = null;
         if(_describe)
         {
            ObjectUtils.disposeObject(_describe);
         }
         _describe = null;
         ObjectUtils.disposeAllChildren(this);
         super.dispose();
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}

