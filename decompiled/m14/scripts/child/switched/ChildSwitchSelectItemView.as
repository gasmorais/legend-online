package child.switched
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.ui.image.Image;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import flash.events.MouseEvent;
   import manager.LanguageMgr;
   import mvc.module.children.ChildData;
   import yishi.datas.templates.ChildTempInfo;
   import yishi.manager.PathManager;
   import yishi.manager.TempleteManager;
   import yishi.utils.MsgMan;
   import yishi.view.community.BaseIconView;
   
   public class ChildSwitchSelectItemView extends Component
   {
      
      private var _back:Image;
      
      private var _childIcon:BaseIconView;
      
      private var _level:FilterFrameText;
      
      private var _data:ChildData;
      
      public function ChildSwitchSelectItemView()
      {
         super();
         initView();
         addEvent();
      }
      
      private function initView() : void
      {
         _back = ComponentFactory.Instance.creatComponentByStylename("ChildSwitchSelectItemView.headBack");
         _level = ComponentFactory.Instance.creatComponentByStylename("ChildSwitchSelectItemView.levelTxt");
         _childIcon = ComponentFactory.Instance.creatCustomObject("ChildSwitchSelectItemView.childIcon");
         addChild(_back);
         addChild(_childIcon);
         addChild(_level);
      }
      
      private function addEvent() : void
      {
         addEventListener("click",__itemSelectHandler);
      }
      
      private function removeEvent() : void
      {
         removeEventListener("click",__itemSelectHandler);
      }
      
      private function __itemSelectHandler(param1:MouseEvent) : void
      {
         MsgMan.notifyObserver("ChildEvent.CHILD_SWITCH_SELECT",data);
      }
      
      public function get data() : ChildData
      {
         return _data;
      }
      
      public function set data(param1:ChildData) : void
      {
         var _loc2_:ChildTempInfo = null;
         _data = param1;
         if(_data)
         {
            _loc2_ = TempleteManager.instance.childTemplateCate.getTemplateByJobAndGrades(_data.job,_data.growthGrade);
            if(_loc2_)
            {
               _childIcon.icon = PathManager.info.ResourcePath + "icon" + _loc2_.Icon;
            }
            _childIcon.tipData = _data;
            _level.text = LanguageMgr.GetTranslation("public.level2",_data.growthGrade);
         }
         else
         {
            _childIcon.icon = null;
            _childIcon.tipData = null;
            _level.text = "";
         }
      }
      
      override public function dispose() : void
      {
         removeEvent();
         ObjectUtils.disposeObject(_back);
         _back = null;
         ObjectUtils.disposeObject(_childIcon);
         _childIcon = null;
         ObjectUtils.disposeObject(_level);
         _level = null;
         _data = null;
         super.dispose();
      }
   }
}

