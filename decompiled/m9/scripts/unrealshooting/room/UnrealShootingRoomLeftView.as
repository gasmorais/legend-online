package unrealshooting.room
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.container.SimpleTileList;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.image.Image;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Sprite;
   import flash.events.Event;
   import map.campaign.data.UnrealShootingModel;
   import mvc.controler.UnrealShootingController;
   import yishi.datas.templates.VehicleObjectTempInfo;
   import yishi.manager.FrameControllerManager;
   import yishi.manager.TempleteManager;
   
   public class UnrealShootingRoomLeftView extends Sprite implements Disposeable
   {
      
      private var _bg:Image;
      
      private var _titleTxt:Image;
      
      private var _roleContainer:SimpleTileList;
      
      private var _preItem:UnrealShootingRoomLeftItemView;
      
      private var _controller:UnrealShootingController;
      
      private var _model:UnrealShootingModel;
      
      public function UnrealShootingRoomLeftView()
      {
         super();
         _controller = FrameControllerManager.instance.unrealShootingController;
         _model = _controller.model;
         initView();
         addEvent();
         initRoleList();
      }
      
      private function initView() : void
      {
         _bg = ComponentFactory.Instance.creatComponentByStylename("unrealshooting.UnrealShootingRoomLeftView.bg");
         _titleTxt = ComponentFactory.Instance.creatComponentByStylename("unrealshooting.UnrealShootingRoomLeftView.titleTxt");
         _roleContainer = ComponentFactory.Instance.creatCustomObject("unrealshooting.UnrealShootingRoomLeftView.roleContainer",[3]);
         _roleContainer.align = "align_left";
         addChild(_bg);
         addChild(_titleTxt);
         addChild(_roleContainer);
      }
      
      private function initRoleList() : void
      {
         var _loc6_:UnrealShootingRoomLeftItemView = null;
         var _loc2_:int = 0;
         var _loc4_:int = 0;
         var _loc5_:int = 0;
         var _loc7_:Array = TempleteManager.instance.vehicleObjectTempInfoCate.getTemplatesByType(12);
         var _loc1_:Array = [];
         for each(var _loc3_:VehicleObjectTempInfo in _loc7_)
         {
            _loc1_.push(_loc3_.TemplateId);
         }
         _loc1_.sortOn("templateId",16);
         _loc2_ = int(_loc1_.length);
         _loc4_ = 0;
         while(_loc4_ < _loc2_)
         {
            _loc5_ = int(_loc1_[_loc4_]);
            _loc6_ = new UnrealShootingRoomLeftItemView(_loc5_);
            _roleContainer.addChild(_loc6_);
            _loc4_++;
         }
         _roleContainer.selectedIndex = 0;
         __roleContainerSelectedHandler(null);
      }
      
      private function uninitView() : void
      {
         ObjectUtils.disposeObject(_bg);
         _bg = null;
         ObjectUtils.disposeObject(_titleTxt);
         _titleTxt = null;
         ObjectUtils.disposeObject(_roleContainer);
         _roleContainer = null;
         ObjectUtils.disposeAllChildren(this);
         ObjectUtils.disposeSelf(this);
         _controller = null;
         _model = null;
      }
      
      private function addEvent() : void
      {
         _roleContainer.addEventListener("LIST_ITEM_CLICK",__roleContainerSelectedHandler);
      }
      
      private function removeEvent() : void
      {
         _roleContainer.removeEventListener("LIST_ITEM_CLICK",__roleContainerSelectedHandler);
      }
      
      private function __roleContainerSelectedHandler(param1:Event) : void
      {
         var _loc2_:UnrealShootingRoomLeftItemView = null;
         if(_model.isLocked)
         {
            return;
         }
         if(_preItem)
         {
            _preItem.selected = false;
         }
         _loc2_ = _roleContainer.selectedItem as UnrealShootingRoomLeftItemView;
         if(_loc2_)
         {
            _loc2_.selected = true;
            _model.selectedTempalteId = _loc2_.templateId;
            _preItem = _loc2_;
         }
      }
      
      public function refreshView() : void
      {
      }
      
      public function dispose() : void
      {
         removeEvent();
         uninitView();
      }
   }
}

