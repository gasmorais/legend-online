package unrealshooting.room
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.image.Image;
   import com.pickgliss.ui.text.GradientText;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Sprite;
   import map.campaign.data.UnrealShootingModel;
   import mvc.controler.UnrealShootingController;
   import yishi.datas.templates.VehicleObjectTempInfo;
   import yishi.manager.FrameControllerManager;
   import yishi.manager.PathManager;
   import yishi.manager.TempleteManager;
   import yishi.view.community.BaseIconView;
   
   public class UnrealShootingRoomLeftItemView extends Sprite implements Disposeable
   {
      
      private var _bg:Image;
      
      private var _headIcon:BaseIconView;
      
      private var _nameTxt:GradientText;
      
      private var _effect:Image;
      
      private var _templateId:int;
      
      private var _controller:UnrealShootingController;
      
      private var _model:UnrealShootingModel;
      
      private var _selected:Boolean;
      
      public function UnrealShootingRoomLeftItemView(param1:int = 0)
      {
         _templateId = param1;
         super();
         _controller = FrameControllerManager.instance.unrealShootingController;
         _model = _controller.model;
         initView();
         addEvent();
      }
      
      private function initView() : void
      {
         _bg = ComponentFactory.Instance.creatComponentByStylename("unrealshooting.UnrealShootingRoomLeftItemView.bg");
         _headIcon = ComponentFactory.Instance.creatCustomObject("unrealshooting.UnrealShootingRoomLeftItemView.headIcon");
         _nameTxt = ComponentFactory.Instance.creatComponentByStylename("unrealshooting.UnrealShootingRoomLeftItemView.nameTxt");
         _effect = ComponentFactory.Instance.creatComponentByStylename("unrealshooting.UnrealShootingRoomLeftItemView.effect");
         var _loc2_:VehicleObjectTempInfo = TempleteManager.instance.vehicleObjectTempInfoCate.getTemplateByIndex(_templateId);
         var _loc1_:String = "";
         if(_loc2_)
         {
            _loc1_ = PathManager.getVehicleShowAvatarPath(_loc2_.Avatar);
            if(_loc1_ != String(_headIcon.icon))
            {
               _headIcon.icon = _loc1_;
            }
            _nameTxt.text = _loc2_.TemplateName;
         }
         selected = false;
         addChild(_bg);
         addChild(_headIcon);
         addChild(_nameTxt);
         addChild(_effect);
      }
      
      private function uninitView() : void
      {
         ObjectUtils.disposeObject(_bg);
         _bg = null;
         ObjectUtils.disposeObject(_headIcon);
         _headIcon = null;
         ObjectUtils.disposeObject(_nameTxt);
         _nameTxt = null;
         ObjectUtils.disposeObject(_effect);
         _effect = null;
         ObjectUtils.disposeAllChildren(this);
         ObjectUtils.disposeSelf(this);
         _controller = null;
         _model = null;
      }
      
      private function addEvent() : void
      {
      }
      
      private function removeEvent() : void
      {
      }
      
      public function get templateId() : int
      {
         return _templateId;
      }
      
      public function get selected() : Boolean
      {
         return _selected;
      }
      
      public function set selected(param1:Boolean) : void
      {
         _selected = param1;
         if(_effect)
         {
            _effect.visible = _selected;
         }
      }
      
      public function dispose() : void
      {
         removeEvent();
         uninitView();
      }
   }
}

