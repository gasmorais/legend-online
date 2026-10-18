package mvc.controler
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.Frame;
   import events.VIPEvent;
   import managers.VIPManager;
   import mvc.FrameController;
   import mvc.ModuleFrameInfo;
   import mvc.module.vip.VIPModel;
   import yishi.datas.consant.ArmyPanelEnum;
   import yishi.manager.FrameControllerManager;
   import yishi.manager.TempleteManager;
   
   public class VIPControler extends FrameController
   {
      
      private var _privilegeFrame:Frame;
      
      private var _giftFrame:Frame;
      
      public function VIPControler()
      {
         super();
         initEvent();
         setVipTemplete();
      }
      
      private function initEvent() : void
      {
         model.addEventListener("vip_open_box",__openBoxHandler);
      }
      
      private function setVipTemplete() : void
      {
         model.one_MonthPoint = int(TempleteManager.instance.getConfigInfoByConfigName("One_MonthPoint").ConfigValue);
         model.three_MonthPoint = int(TempleteManager.instance.getConfigInfoByConfigName("Three_MonthPoint").ConfigValue);
         model.six_MonthPoint = int(TempleteManager.instance.getConfigInfoByConfigName("Six_MonthPoint").ConfigValue);
      }
      
      private function __openBoxHandler(param1:VIPEvent) : void
      {
         if(!_frame)
         {
            FrameControllerManager.instance.openControllerByInfo("vip",VIPModel.OPEN_VIPBOX_FRAME);
         }
      }
      
      override public function start(param1:ModuleFrameInfo = null) : void
      {
         super.start(param1);
      }
      
      override protected function showFrame() : void
      {
         if(_data && _data.openType == VIPModel.OPEN_VIPBOX_FRAME)
         {
            model.curOpenVipBox = true;
         }
         super.showFrame();
         _frame["show"]();
         if(_data && _data.openType == VIPModel.OPEN_PRIVILEGE_FRAME)
         {
            showPrivilegeFrame();
         }
         else if(_data && _data.openType == VIPModel.OPEN_GIFT_FRAME)
         {
            showGiftFrame();
         }
      }
      
      override public function get frameClassName() : String
      {
         if(_data && _data.openType == VIPModel.OPEN_VIPBOX_FRAME)
         {
            return "vip.VipBoxFrame";
         }
         return "vip.VIPFrame";
      }
      
      override protected function exitFrame() : void
      {
         super.exitFrame();
      }
      
      public function hideBoxFrame() : void
      {
         if(_frame)
         {
            _frame.dispose();
         }
         _frame = null;
         model.curOpenVipBox = false;
         FrameControllerManager.instance.armyController.startFrameByType(ArmyPanelEnum.EQUIP_PANEL);
      }
      
      public function showGiftFrame() : void
      {
         _giftFrame = ComponentFactory.Instance.creatComponentByStylename("vip.VipGiftFrame");
         _giftFrame["show"]();
      }
      
      public function hideGiftFrame() : void
      {
         if(_giftFrame)
         {
            _giftFrame.dispose();
         }
         _giftFrame = null;
      }
      
      public function showPrivilegeFrame() : void
      {
         _privilegeFrame = ComponentFactory.Instance.creatComponentByStylename("vip.VipPrivilegeFrame");
         _privilegeFrame["show"]();
         hide();
      }
      
      public function hidePrivilegeFrame(param1:Boolean = true) : void
      {
         if(_privilegeFrame)
         {
            _privilegeFrame.dispose();
         }
         _privilegeFrame = null;
         if(param1)
         {
            show();
         }
      }
      
      private function hide() : void
      {
         if(_frame)
         {
            _frame.visible = false;
         }
      }
      
      private function show() : void
      {
         if(_frame)
         {
            _frame.visible = true;
         }
      }
      
      public function get model() : VIPModel
      {
         return VIPManager.Instance.model;
      }
   }
}

