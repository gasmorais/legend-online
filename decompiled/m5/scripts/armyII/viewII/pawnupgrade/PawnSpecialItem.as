package armyII.viewII.pawnupgrade
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Sprite;
   import manager.LanguageMgr;
   import yishi.datas.templates.PawnSpecialTempInfo;
   import yishi.utils.IconFactory;
   import yishi.view.community.BaseIconView;
   
   public class PawnSpecialItem extends Sprite implements Disposeable
   {
      
      private var _icon:BaseIconView;
      
      private var _name:FilterFrameText;
      
      private var _grade:FilterFrameText;
      
      public function PawnSpecialItem()
      {
         super();
         initView();
      }
      
      private function initView() : void
      {
         _icon = ComponentFactory.Instance.creatCustomObject("armyII.PawnSpecialIcon");
         _name = ComponentFactory.Instance.creatComponentByStylename("armyII.PawnSpecialName");
         _grade = ComponentFactory.Instance.creatComponentByStylename("armyII.PawnSpecialGrade");
         addChild(_icon);
         addChild(_name);
         addChild(_grade);
      }
      
      public function set data(param1:PawnSpecialTempInfo) : void
      {
         if(param1)
         {
            _icon.icon = IconFactory.getCommonIconPath(param1.ResPath);
            _icon.tipData = param1;
            _name.text = param1.TemplateName;
            _grade.htmlText = "<font face=\'Arial\' size=\'14\'>" + LanguageMgr.GetTranslation("public.level") + "</font>" + param1.Grades.toString();
         }
         else
         {
            _icon.icon = null;
            _name.text = "";
            _grade.htmlText = "";
         }
         if(_name.numLines > 2)
         {
            _name.y = -20;
         }
      }
      
      public function dispose() : void
      {
         ObjectUtils.disposeObject(_icon);
         _icon = null;
         ObjectUtils.disposeObject(_name);
         _name = null;
         ObjectUtils.disposeObject(_grade);
         _grade = null;
         ObjectUtils.disposeAllChildren(this);
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}

