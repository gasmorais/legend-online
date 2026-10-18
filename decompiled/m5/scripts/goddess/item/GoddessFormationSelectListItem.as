package goddess.item
{
   import com.pickgliss.instance.IManualSize;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.DisplayObject;
   import flash.geom.Rectangle;
   import manager.LanguageMgr;
   import managers.GodDessManager;
   import mvc.module.goddess.GodDessModel;
   import mvc.module.goddess.GoddessFormationInfo;
   import yishi.datas.templates.GoddessTempInfo;
   import yishi.filter.UIFilter;
   import yishi.manager.PathManager;
   import yishi.view.community.BaseIconView;
   
   public class GoddessFormationSelectListItem extends Component implements IManualSize
   {
      
      private var _back:DisplayObject;
      
      private var _iconView:BaseIconView;
      
      private var _template:GoddessTempInfo;
      
      private var _formationInfo:GoddessFormationInfo;
      
      private var _isActive:Boolean;
      
      public function GoddessFormationSelectListItem()
      {
         super();
         initView();
      }
      
      public function get viewRectangle() : Rectangle
      {
         return new Rectangle(0,0,60,60);
      }
      
      private function initView() : void
      {
         _back = ComponentFactory.Instance.creatComponentByStylename("goddess.formation.bagEquipBack");
         _iconView = ComponentFactory.Instance.creatCustomObject("goddess.formation.goddessItemIcon");
         addChild(_back);
         addChild(_iconView);
         _iconView.x = 0;
         _iconView.y = 0;
      }
      
      private function get model() : GodDessModel
      {
         return GodDessManager.instance.model;
      }
      
      public function set formationInfo(param1:GoddessFormationInfo) : void
      {
         _formationInfo = param1;
      }
      
      public function get template() : GoddessTempInfo
      {
         return _template;
      }
      
      public function set template(param1:GoddessTempInfo) : void
      {
         var _loc3_:* = null;
         _template = param1;
         this.tipData = LanguageMgr.GetTranslation("goddess.array.text10");
         var _loc2_:String = "";
         if(_template)
         {
            _iconView.icon = PathManager.getGoddessSmallIcon(_template.TemplateId);
            this.tipData = _template.TemplateName;
         }
         else
         {
            _iconView.icon = null;
         }
      }
      
      public function get isActive() : Boolean
      {
         return _isActive;
      }
      
      public function set isActive(param1:Boolean) : void
      {
         _isActive = param1;
         if(param1)
         {
            filters = [];
         }
         else
         {
            filters = [UIFilter.getGrayFilter()];
         }
      }
      
      override public function dispose() : void
      {
         ObjectUtils.disposeObject(_back);
         _back = null;
         ObjectUtils.disposeObject(_iconView);
         _iconView = null;
         super.dispose();
      }
   }
}

