package unrealshooting.room
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.IconButton;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.image.Image;
   import com.pickgliss.utils.ObjectUtils;
   import com.pickgliss.utils.SoundManager;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import map.campaign.data.UnrealShootingModel;
   import mvc.controler.UnrealShootingController;
   import yishi.datas.templates.VehicleObjectTempInfo;
   import yishi.datas.templates.VehicleSkillTempInfo;
   import yishi.manager.FrameControllerManager;
   import yishi.manager.TempleteManager;
   import yishi.utils.IconFactory;
   import yishi.view.community.BaseIconView;
   
   public class UnrealShootingRoomBottomView extends Sprite implements Disposeable
   {
      
      private var _player:UnrealShootingRoomRightItemView;
      
      private var _bg:Image;
      
      private var _icon01:BaseIconView;
      
      private var _icon02:BaseIconView;
      
      private var _icon03:BaseIconView;
      
      private var _confirmBtn:IconButton;
      
      private var _controller:UnrealShootingController;
      
      private var _model:UnrealShootingModel;
      
      public function UnrealShootingRoomBottomView()
      {
         super();
         _controller = FrameControllerManager.instance.unrealShootingController;
         _model = _controller.model;
         initView();
         addEvent();
      }
      
      private function initView() : void
      {
         _bg = ComponentFactory.Instance.creatComponentByStylename("unrealshooting.UnrealShootingRoomBottomView.bg");
         _icon01 = ComponentFactory.Instance.creatCustomObject("unrealshooting.UnrealShootingRoomBottomView.icon01");
         _icon02 = ComponentFactory.Instance.creatCustomObject("unrealshooting.UnrealShootingRoomBottomView.icon02");
         _icon03 = ComponentFactory.Instance.creatCustomObject("unrealshooting.UnrealShootingRoomBottomView.icon03");
         _confirmBtn = ComponentFactory.Instance.creatComponentByStylename("unrealshooting.UnrealShootingRoomBottomView.confirmBtn");
         _player = new UnrealShootingRoomRightItemView();
         addChild(_player);
         addChild(_bg);
         addChild(_icon01);
         addChild(_icon02);
         addChild(_icon03);
         addChild(_confirmBtn);
      }
      
      private function uninitView() : void
      {
         ObjectUtils.disposeObject(_player);
         _player = null;
         ObjectUtils.disposeObject(_bg);
         _bg = null;
         ObjectUtils.disposeObject(_confirmBtn);
         _confirmBtn = null;
         ObjectUtils.disposeObject(_icon01);
         _icon01 = null;
         ObjectUtils.disposeObject(_icon02);
         _icon02 = null;
         ObjectUtils.disposeObject(_icon03);
         _icon03 = null;
         ObjectUtils.disposeAllChildren(this);
         ObjectUtils.disposeSelf(this);
         _controller = null;
         _model = null;
      }
      
      private function addEvent() : void
      {
         _confirmBtn.addEventListener("click",__confirmBtnClickHandler);
      }
      
      private function removeEvent() : void
      {
         _confirmBtn.removeEventListener("click",__confirmBtnClickHandler);
      }
      
      private function __confirmBtnClickHandler(param1:MouseEvent) : void
      {
         SoundManager.instance.play("022");
         _controller.sendUnrealShootingConfirmTemplate(_model.selectedTempalteId);
      }
      
      public function refreshView() : void
      {
         var _loc2_:VehicleSkillTempInfo = null;
         var _loc1_:int = 0;
         if(_model.isLocked)
         {
            _confirmBtn.enable = false;
         }
         else
         {
            _confirmBtn.enable = true;
         }
         var _loc3_:VehicleObjectTempInfo = TempleteManager.instance.vehicleObjectTempInfoCate.getTemplateByIndex(_model.selectedTempalteId);
         if(_loc3_)
         {
            _loc1_ = int(_loc3_.NormalSkill);
            _loc2_ = TempleteManager.instance.vehicleSkillTempteCate.getTemplateByTid(_loc1_);
            if(_loc2_)
            {
               _icon01.icon = IconFactory.getCommonIconPath(_loc2_.Icons);
               _icon01.tipData = _loc2_;
            }
            _loc1_ = _loc3_.NormalSkill + 1;
            _loc2_ = TempleteManager.instance.vehicleSkillTempteCate.getTemplateByTid(_loc1_);
            if(_loc2_)
            {
               _icon02.icon = IconFactory.getCommonIconPath(_loc2_.Icons);
               _icon02.tipData = _loc2_;
            }
            _loc1_ = _loc3_.NormalSkill + 2;
            _loc2_ = TempleteManager.instance.vehicleSkillTempteCate.getTemplateByTid(_loc1_);
            if(_loc2_)
            {
               _icon03.icon = IconFactory.getCommonIconPath(_loc2_.Icons);
               _icon03.tipData = _loc2_;
            }
         }
      }
      
      public function dispose() : void
      {
         removeEvent();
         uninitView();
      }
   }
}

