package goddess.item
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.BaseButton;
   import com.pickgliss.ui.image.Image;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.geom.Point;
   import managers.GodDessManager;
   import mvc.module.goddess.GoddessFormationInfo;
   import yishi.datas.templates.GoddessFormationTemp;
   import yishi.filter.UIFilter;
   import yishi.manager.PathManager;
   import yishi.manager.TempleteManager;
   import yishi.view.community.BaseIconView;
   
   public class GoddessFormationCard extends Sprite
   {
      
      private var _bg:Image;
      
      private var _btnUpgrade:BaseButton;
      
      private var _bit0:Bitmap;
      
      private var _btnAdd:BaseButton;
      
      private var _txtLv:FilterFrameText;
      
      private var _checkListView:GoddessFormationSelectList;
      
      private var _iconView:BaseIconView;
      
      private var index:int;
      
      private var _data:GoddessFormationInfo;
      
      public var clickCallback:Function;
      
      public function GoddessFormationCard(param1:int)
      {
         super();
         index = param1;
         initView();
         initEvent();
      }
      
      private function initView() : void
      {
         _iconView = ComponentFactory.Instance.creatCustomObject("goddess.formation.goddessItemIcon");
         _bit0 = ComponentFactory.Instance.creatBitmap("asset.goddess.formation.selected");
         _bg = ComponentFactory.Instance.creatComponentByStylename("goddess.formation.cardbg");
         _btnUpgrade = ComponentFactory.Instance.creatComponentByStylename("ui.goddess.btnUpgrade2");
         _btnAdd = ComponentFactory.Instance.creatComponentByStylename("ui.goddess.btnAdd");
         _txtLv = ComponentFactory.Instance.creatComponentByStylename("ui.goddess.txtLv");
         addChild(_bg);
         addChild(_bit0);
         addChild(_iconView);
         addChild(_btnAdd);
         addChild(_txtLv);
         _btnAdd.alpha = 0;
         select = false;
      }
      
      public function setNormal() : void
      {
         buttonMode = false;
         _txtLv.visible = _btnAdd.visible = false;
      }
      
      public function get data() : GoddessFormationInfo
      {
         return _data;
      }
      
      public function set data(param1:GoddessFormationInfo) : void
      {
         _data = param1;
         _txtLv.text = "Nv." + (data ? data.grade : 0);
         if(_data && _data.template)
         {
            _iconView.visible = true;
            _iconView.icon = PathManager.getGoddessSmallIcon(data.template.TemplateId);
         }
         else
         {
            _iconView.visible = false;
         }
         if(_data && isActive())
         {
            _iconView.filters = [];
         }
         else
         {
            _iconView.filters = [UIFilter.getGrayFilter()];
         }
      }
      
      public function isActive() : Boolean
      {
         return GodDessManager.instance.getGoddessInfoByFormationIndex(_data.templateId).isActive;
      }
      
      public function get levelTemplate() : GoddessFormationTemp
      {
         var _loc1_:GoddessFormationTemp = null;
         if(_data)
         {
            _loc1_ = TempleteManager.instance.goddessFormationTempCate.getTemplateByLevel(_data.grade);
         }
         else
         {
            _loc1_ = new GoddessFormationTemp();
         }
         return _loc1_;
      }
      
      public function get nextLevelTemplate() : GoddessFormationTemp
      {
         return TempleteManager.instance.goddessFormationTempCate.getTemplateByLevel(_data.grade + 1);
      }
      
      private function initEvent() : void
      {
         _btnAdd.addEventListener("click",onClickAdd);
         _btnUpgrade.addEventListener("click",onClickUpgrade);
      }
      
      private function removeEvent() : void
      {
         _btnAdd.removeEventListener("click",onClickAdd);
         _btnUpgrade.removeEventListener("click",onClickUpgrade);
      }
      
      protected function onClickAdd(param1:MouseEvent) : void
      {
         GodDessManager.instance.model.selectedArrayIndex = index;
         clickCallback && clickCallback(index);
      }
      
      public function get select() : Boolean
      {
         return _bit0.visible;
      }
      
      public function set select(param1:Boolean) : void
      {
         _bit0.visible = param1;
      }
      
      private function __onSortListDispose(param1:Event) : void
      {
         _checkListView.removeEventListener("dispose",__onSortListDispose);
         _checkListView = null;
      }
      
      protected function onClickUpgrade(param1:MouseEvent) : void
      {
         clickCallback(index);
         GodDessManager.instance.model.selectedArrayIndex = index;
      }
      
      public function dispose() : void
      {
         removeEvent();
         ObjectUtils.disposeObject(_bg);
         _bg = null;
         ObjectUtils.disposeObject(_btnUpgrade);
         _btnUpgrade = null;
         ObjectUtils.disposeObject(_iconView);
         _iconView = null;
         ObjectUtils.disposeObject(_btnAdd);
         _btnAdd = null;
         ObjectUtils.disposeObject(_bit0);
         _bit0 = null;
         ObjectUtils.disposeObject(_txtLv);
         _txtLv = null;
         ObjectUtils.disposeObject(_checkListView);
         _checkListView = null;
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}

