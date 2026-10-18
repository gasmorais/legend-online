package magicspring.item
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Bitmap;
   import flash.events.MouseEvent;
   import manager.LanguageMgr;
   import managers.MagicSpringManager;
   import mvc.module.magicspring.MagicSpringModel;
   import yishi.datas.playerinfo.ThaneInfo;
   import yishi.datas.templates.MagicSpringFormulaTempInfo;
   import yishi.filter.UIFilter;
   import yishi.manager.ArmyManager;
   import yishi.utils.IconFactory;
   import yishi.view.community.BaseIconView;
   
   public class MagicSpringFormulaLeftItem extends Component
   {
      
      private var _back:Bitmap;
      
      private var _selectBg:Bitmap;
      
      private var _formulaIcon:BaseIconView;
      
      private var _nameText:FilterFrameText;
      
      private var _data:MagicSpringFormulaTempInfo;
      
      public function MagicSpringFormulaLeftItem()
      {
         super();
         initView();
         addEvent();
      }
      
      private function initView() : void
      {
         _back = ComponentFactory.Instance.creatBitmap("asset.MagicSpringFormulaLeftItem.back");
         _selectBg = ComponentFactory.Instance.creatBitmap("asset.MagicSpringFormulaLeftItem.selectBg");
         _formulaIcon = ComponentFactory.Instance.creatCustomObject("MagicSpringFormulaLeftItem.formulaIcon");
         _nameText = ComponentFactory.Instance.creatComponentByStylename("MagicSpringFormulaLeftItem.nameText");
         addChild(_back);
         addChild(_selectBg);
         addChild(_formulaIcon);
         addChild(_nameText);
         _selectBg.visible = false;
      }
      
      private function addEvent() : void
      {
         addEventListener("click",__itemClickHandler);
      }
      
      private function removeEvent() : void
      {
         removeEventListener("click",__itemClickHandler);
      }
      
      protected function __itemClickHandler(param1:MouseEvent) : void
      {
         if(!data)
         {
            return;
         }
         model.selectFormula = data;
      }
      
      public function get data() : MagicSpringFormulaTempInfo
      {
         return _data;
      }
      
      public function set data(param1:MagicSpringFormulaTempInfo) : void
      {
         if(_data == param1)
         {
            return;
         }
         _data = param1;
         _formulaIcon.tipData = null;
         if(data)
         {
            _formulaIcon.icon = IconFactory.getMagicSpringPath(data.Icon);
            _nameText.text = data.TemplateName;
            _nameText.setFrame(1);
            if(_nameText.numLines == 1)
            {
               _nameText.y = 45;
            }
            else if(_nameText.numLines == 2)
            {
               _nameText.y = 40;
            }
            else
            {
               _nameText.y = 35;
            }
            _selectBg.visible = data.TemplateId == model.selectFormula.TemplateId;
            if(data.NeedGrade > thane.totalGrade)
            {
               this.filters = [UIFilter.getGrayFilter()];
               _formulaIcon.tipData = LanguageMgr.GetTranslation("MagicSpringFormulaLeftItem.formulaIcon.openGrade",data.NeedGrade);
            }
            else
            {
               this.filters = [];
            }
         }
         else
         {
            _formulaIcon.icon = null;
            _nameText.text = LanguageMgr.GetTranslation("CrossGuildCourseFrame.noVsText.text");
            _nameText.setFrame(2);
            _selectBg.visible = false;
            this.filters = [];
         }
      }
      
      public function set select(param1:Boolean) : void
      {
         _selectBg.visible = param1;
      }
      
      public function get model() : MagicSpringModel
      {
         return MagicSpringManager.instance.model;
      }
      
      private function get thane() : ThaneInfo
      {
         return ArmyManager.instance.thane;
      }
      
      override public function dispose() : void
      {
         removeEvent();
         ObjectUtils.disposeObject(_back);
         _back = null;
         ObjectUtils.disposeObject(_formulaIcon);
         _formulaIcon = null;
         ObjectUtils.disposeObject(_selectBg);
         _selectBg = null;
         ObjectUtils.disposeObject(_nameText);
         _nameText = null;
         super.dispose();
      }
   }
}

