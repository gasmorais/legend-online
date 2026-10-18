package planeswar.view
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.ui.image.ScaleFrameImage;
   import com.pickgliss.utils.ObjectUtils;
   import flash.events.MouseEvent;
   import mvc.module.planeswar.PlanesWarModel;
   import yishi.datas.templates.PlanesFuncTemplateInfo;
   import yishi.manager.PathManager;
   import yishi.manager.PlanesWarManager;
   import yishi.manager.TempleteManager;
   import yishi.view.community.BaseIconView;
   
   public class PlanesFuncItem extends Component
   {
      
      private var iconBack:ScaleFrameImage;
      
      private var funcIcon:BaseIconView;
      
      private var _tempId:int = -1;
      
      private var showType:int;
      
      public function PlanesFuncItem(param1:int)
      {
         super();
         showType = param1;
         initView();
         addEvent();
      }
      
      public function initView() : void
      {
         iconBack = ComponentFactory.Instance.creatComponentByStylename("PlanesFuncItem.iconBack");
         funcIcon = ComponentFactory.Instance.creatCustomObject("PlanesFuncItem.funcIcon");
         addChild(iconBack);
         addChild(funcIcon);
         iconBack.setFrame(2);
      }
      
      private function addEvent() : void
      {
         funcIcon.addEventListener("click",__iconClickHandler);
      }
      
      private function removeEvent() : void
      {
         if(funcIcon)
         {
            funcIcon.removeEventListener("click",__iconClickHandler);
         }
      }
      
      private function __iconClickHandler(param1:MouseEvent) : void
      {
         model.skillSelectedTempId = tempId;
         model.skillSelectedType = showType;
         PlanesWarManager.instance.sendDispatchEvent("PLANES_FUNCSELECT_CHANGE");
      }
      
      public function get tempId() : int
      {
         return _tempId;
      }
      
      public function set tempId(param1:int) : void
      {
         _tempId = param1;
         var _loc2_:PlanesFuncTemplateInfo = TempleteManager.instance.planesFuncTemplateCate.getTemplateByID(param1);
         if(_loc2_)
         {
            funcIcon.icon = PathManager.getPlanesFuncIconByTempId(param1);
            funcIcon.visible = true;
         }
         else
         {
            funcIcon.icon = "";
            funcIcon.visible = false;
         }
      }
      
      public function set selected(param1:Boolean) : void
      {
         if(param1)
         {
            iconBack.setFrame(1);
            iconBack.x = iconBack.y = -6;
         }
         else
         {
            iconBack.setFrame(2);
            iconBack.x = iconBack.y = 0;
         }
      }
      
      private function get model() : PlanesWarModel
      {
         return PlanesWarManager.instance.model;
      }
      
      override public function dispose() : void
      {
         removeEvent();
         ObjectUtils.disposeObject(iconBack);
         iconBack = null;
         ObjectUtils.disposeObject(funcIcon);
         funcIcon = null;
         super.dispose();
      }
   }
}

