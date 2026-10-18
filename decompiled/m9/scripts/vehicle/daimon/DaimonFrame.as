package vehicle.daimon
{
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.BaseButton;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.ui.image.Scale9CornerImage;
   import com.pickgliss.ui.image.ScaleBitmapImage;
   import com.pickgliss.utils.ObjectUtils;
   import com.pickgliss.utils.SoundManager;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import manager.LanguageMgr;
   import mvc.module.vehicle.DaimonModel;
   import vehicle.daimon.view.DaimonBottomView;
   import vehicle.daimon.view.DaimonLeftView;
   import vehicle.daimon.view.DaimonRightView;
   import yishi.datas.playerinfo.PlayerInfo;
   import yishi.keyboard.KeyBoardRegister;
   import yishi.manager.FrameControllerManager;
   import yishi.manager.PlayerManager;
   
   public class DaimonFrame extends Frame
   {
      
      private var _border:ScaleBitmapImage;
      
      private var _back:Scale9CornerImage;
      
      private var _leftView:DaimonLeftView;
      
      private var _rightView:DaimonRightView;
      
      private var _bottomView:DaimonBottomView;
      
      private var _helpBtn:BaseButton;
      
      private var _model:DaimonModel = FrameControllerManager.instance.vehicleDaimonController.model;
      
      private var maskBack:Boolean = false;
      
      public function DaimonFrame()
      {
         super();
         initView();
         addEvent();
         update();
      }
      
      private function initView() : void
      {
         _border = ComponentFactory.Instance.creatComponentByStylename("daimonFrame.BgBorder");
         _back = ComponentFactory.Instance.creatComponentByStylename("daimonFrame.BgBorder2");
         _helpBtn = ComponentFactory.Instance.creatComponentByStylename("mounts.helpBtn");
         _helpBtn.tipData = LanguageMgr.GetTranslation("vehicle.helptip01");
         _helpBtn.x = 712;
         _helpBtn.y = -34;
         _leftView = new DaimonLeftView();
         _rightView = new DaimonRightView();
         _bottomView = new DaimonBottomView();
         _leftView.x = 11;
         _leftView.y = 17;
         _rightView.x = 307;
         _rightView.y = 20;
         _bottomView.x = 6;
         _bottomView.y = 366;
         addToContent(_border);
         addToContent(_back);
         addToContent(_bottomView);
         addToContent(_rightView);
         addToContent(_leftView);
         addToContent(_helpBtn);
      }
      
      private function uintView() : void
      {
         ObjectUtils.disposeObject(_leftView);
         _leftView = null;
         ObjectUtils.disposeObject(_rightView);
         _rightView = null;
         ObjectUtils.disposeObject(_bottomView);
         _bottomView = null;
         ObjectUtils.disposeObject(_helpBtn);
         _helpBtn = null;
         _border = null;
         _back = null;
      }
      
      private function addEvent() : void
      {
         addEventListener("response",__frameResponse);
         playerInfo.addEventListener("PLAYER_VEHICLE_CHANGE",__onPlayerVehicleChangeHandler);
         playerInfo.addEventListener("PLAYER_VEHICLEINFO_CHANGE",__onVehicleChangeHandler);
         _model.addEventListener("PLAYER_VEHICLE_CHANGE",__onVehicleChangeHandler);
         _helpBtn.addEventListener("click",__openHelpHandler);
      }
      
      private function removeEvent() : void
      {
         removeEventListener("response",__frameResponse);
         playerInfo.removeEventListener("PLAYER_VEHICLE_CHANGE",__onPlayerVehicleChangeHandler);
         playerInfo.removeEventListener("PLAYER_VEHICLEINFO_CHANGE",__onVehicleChangeHandler);
         if(_model)
         {
            _model.removeEventListener("PLAYER_VEHICLE_CHANGE",__onVehicleChangeHandler);
         }
         if(_helpBtn)
         {
            _helpBtn.removeEventListener("click",__openHelpHandler);
         }
      }
      
      private function __frameResponse(param1:FrameEvent) : void
      {
         switch(int(param1.responseCode))
         {
            case 0:
            case 1:
               dispose();
         }
      }
      
      private function __onPlayerVehicleChangeHandler(param1:Event) : void
      {
         _model.currentVehicleTempid = playerInfo.vehicleTempId;
      }
      
      private function __onVehicleChangeHandler(param1:Event) : void
      {
         update();
      }
      
      private function __openHelpHandler(param1:MouseEvent) : void
      {
         SoundManager.instance.play("022");
         var _loc2_:Frame = ComponentFactory.Instance.creatComponentByStylename("vehicle.helpFrame1");
         _loc2_["show"]();
      }
      
      private function update() : void
      {
         _leftView.update();
         _rightView.update();
         _bottomView.update();
      }
      
      private function get playerInfo() : PlayerInfo
      {
         return PlayerManager.instance.currentPlayerModel.playerInfo;
      }
      
      public function show(param1:Boolean = false) : void
      {
         titleText = LanguageMgr.GetTranslation("vehicle.daimon");
         maskBack = param1;
         if(maskBack)
         {
            LayerManager.Instance.addToLayer(this,3,true,true,2);
            KeyBoardRegister.instance.keyEnable = false;
         }
         else
         {
            LayerManager.Instance.addToLayer(this,3,true,true);
         }
      }
      
      override public function get groups() : Array
      {
         return ["MAIN_TOOLS_GROUP","CASTLE_BUIDING_GROUP","BAG_GROUP"];
      }
      
      override public function dispose() : void
      {
         if(isDie)
         {
            return;
         }
         if(maskBack)
         {
            KeyBoardRegister.instance.keyEnable = true;
         }
         removeEvent();
         uintView();
         super.dispose();
      }
   }
}

