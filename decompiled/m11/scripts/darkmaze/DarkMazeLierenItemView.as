package darkmaze
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.ui.image.Image;
   import com.pickgliss.ui.image.MutipleImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import flash.events.MouseEvent;
   import manager.LanguageMgr;
   import managers.DarkMazeManager;
   import mvc.module.children.ChildData;
   import mvc.module.darkmaze.DarkMazeModel;
   import yishi.datas.templates.ChildTempInfo;
   import yishi.manager.PathManager;
   import yishi.manager.TempleteManager;
   import yishi.view.community.BaseIconView;
   
   public class DarkMazeLierenItemView extends Component
   {
      
      private var _bg:MutipleImage;
      
      private var _selected:Image;
      
      private var _iconView:BaseIconView;
      
      private var _battleTxt:FilterFrameText;
      
      private var _battelValueTxt:FilterFrameText;
      
      private var _nameTxt:FilterFrameText;
      
      private var _data:ChildData;
      
      private var _selectedFlag:Boolean;
      
      public function DarkMazeLierenItemView()
      {
         super();
         initView();
         addEvent();
      }
      
      private function initView() : void
      {
         _bg = ComponentFactory.Instance.creatComponentByStylename("darkMazeLierenItemView.bg");
         _selected = ComponentFactory.Instance.creatComponentByStylename("darkMazeLierenItemView.selected");
         _iconView = ComponentFactory.Instance.creatCustomObject("darkMazeCommonItemView.iconView");
         _battleTxt = ComponentFactory.Instance.creatComponentByStylename("darkMazeLierenItemView.battleTxt");
         _battelValueTxt = ComponentFactory.Instance.creatComponentByStylename("darkMazeLierenItemView.battelValueTxt");
         _nameTxt = ComponentFactory.Instance.creatComponentByStylename("darkMazeLierenItemView.nameTxt");
         addChild(_bg);
         addChild(_selected);
         addChild(_iconView);
         addChild(_battleTxt);
         addChild(_battelValueTxt);
         addChild(_nameTxt);
         _selected.visible = false;
         _battleTxt.text = LanguageMgr.GetTranslation("childpve.ChildPveOrderFrame.fightTitle");
      }
      
      private function unInitView() : void
      {
         ObjectUtils.disposeObject(_bg);
         _bg = null;
         ObjectUtils.disposeObject(_iconView);
         _iconView = null;
         ObjectUtils.disposeObject(_battleTxt);
         _battleTxt = null;
         ObjectUtils.disposeObject(_battelValueTxt);
         _battelValueTxt = null;
         ObjectUtils.disposeObject(_nameTxt);
         _nameTxt = null;
      }
      
      private function addEvent() : void
      {
         this.addEventListener("click",__clickHander);
      }
      
      private function removeEvent() : void
      {
         this.removeEventListener("click",__clickHander);
      }
      
      private function __clickHander(param1:MouseEvent) : void
      {
         model.selectedChildId = _data.childId;
      }
      
      public function set selectedFlag(param1:Boolean) : void
      {
         _selected.visible = param1;
      }
      
      public function get data() : ChildData
      {
         return _data;
      }
      
      public function set data(param1:ChildData) : void
      {
         _data = param1;
         if(!_data)
         {
            return;
         }
         var _loc2_:ChildTempInfo = TempleteManager.instance.childTemplateCate.getTemplateByJobAndGrades(_data.job,_data.growthGrade);
         if(_loc2_)
         {
            _iconView.icon = PathManager.info.ResourcePath + "icon" + _loc2_.Icon;
         }
         _battleTxt.text = LanguageMgr.GetTranslation("childpve.ChildPveOrderFrame.fightTitle");
         _battelValueTxt.text = _data.fightValue.toString();
         _nameTxt.text = _data.name.toString();
      }
      
      private function get model() : DarkMazeModel
      {
         return DarkMazeManager.instance.model;
      }
      
      override public function dispose() : void
      {
         removeEvent();
         unInitView();
         super.dispose();
      }
   }
}

