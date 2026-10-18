package vehicle.daimontrial
{
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.BaseButton;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.ui.image.Scale9CornerImage;
   import com.pickgliss.utils.ObjectUtils;
   import com.pickgliss.utils.SoundManager;
   import flash.events.MouseEvent;
   import manager.LanguageMgr;
   import vehicle.VehicleEventII;
   import vehicle.daimontrial.view.DaimonTrialBottomView;
   import vehicle.daimontrial.view.DaimonTrialLeftView;
   import vehicle.daimontrial.view.DaimonTrialRightView;
   import yishi.datas.playerinfo.PlayerInfo;
   import yishi.events.PlayerEvent;
   import yishi.manager.PlayerManager;
   import yishi.view.frame.NewVipOpenView;
   
   public class DaimonTrialFrame extends Frame
   {
      
      private var _bg:Scale9CornerImage;
      
      private var _leftView:DaimonTrialLeftView;
      
      private var _rightView:DaimonTrialRightView;
      
      private var _bottomView:DaimonTrialBottomView;
      
      private var _helpBtn:BaseButton;
      
      private var _playerInfo:PlayerInfo = PlayerManager.instance.currentPlayerModel.playerInfo;
      
      private var _vipOpenView:NewVipOpenView;
      
      public function DaimonTrialFrame()
      {
         super();
         initView();
         addEvent();
         update();
      }
      
      private function initView() : void
      {
         _bg = ComponentFactory.Instance.creatComponentByStylename("DaimonTrialFrame.Back");
         _leftView = new DaimonTrialLeftView();
         _rightView = new DaimonTrialRightView();
         _bottomView = new DaimonTrialBottomView();
         _helpBtn = ComponentFactory.Instance.creatComponentByStylename("mounts.helpBtn");
         _helpBtn.tipData = LanguageMgr.GetTranslation("vehicle.helptip02");
         _vipOpenView = new NewVipOpenView(203);
         _helpBtn.x = 540;
         _helpBtn.y = -41;
         _vipOpenView.x = 10;
         _vipOpenView.y = 355;
         _vipOpenView.nickNameTxt.width = 300;
         _leftView.x = 8;
         _leftView.y = 4;
         _rightView.x = 317;
         _rightView.y = 4;
         _bottomView.x = 8;
         _bottomView.y = 241;
         addToContent(_bg);
         addToContent(_leftView);
         addToContent(_rightView);
         addToContent(_bottomView);
         addToContent(_helpBtn);
         addToContent(_vipOpenView);
      }
      
      private function unitView() : void
      {
         _bg = null;
         _leftView = null;
         _rightView = null;
         _bottomView = null;
         _vipOpenView = null;
         ObjectUtils.disposeObject(_helpBtn);
         _helpBtn = null;
      }
      
      private function addEvent() : void
      {
         addEventListener("response",__frameResponse);
         _playerInfo.addEventListener("PLAYER_VEHICLE_CHANGE",__vehicleChangeHandler);
         _helpBtn.addEventListener("click",__openHelpHandler);
         if(_bottomView)
         {
            _bottomView.addEventListener("SINGLE_START",__startHandler);
         }
         if(_bottomView)
         {
            _bottomView.addEventListener("SINGLE_CANCLE",__cancleHandler);
         }
      }
      
      private function removeEvent() : void
      {
         removeEventListener("response",__frameResponse);
         if(_playerInfo)
         {
            _playerInfo.removeEventListener("PLAYER_VEHICLE_CHANGE",__vehicleChangeHandler);
         }
         if(_helpBtn)
         {
            _helpBtn.removeEventListener("click",__openHelpHandler);
         }
         if(_bottomView)
         {
            _bottomView.removeEventListener("SINGLE_START",__startHandler);
         }
         if(_bottomView)
         {
            _bottomView.removeEventListener("SINGLE_CANCLE",__cancleHandler);
         }
      }
      
      private function __cancleHandler(param1:VehicleEventII) : void
      {
         closeButton.enable = true;
         escEnable = true;
      }
      
      private function __startHandler(param1:VehicleEventII) : void
      {
         closeButton.enable = false;
         escEnable = false;
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
      
      private function __vehicleChangeHandler(param1:PlayerEvent) : void
      {
         update();
      }
      
      private function update() : void
      {
         _rightView.update();
      }
      
      private function __openHelpHandler(param1:MouseEvent) : void
      {
         SoundManager.instance.play("022");
         var _loc2_:Frame = ComponentFactory.Instance.creatComponentByStylename("vehicle.helpFrame1");
         _loc2_["show"]();
      }
      
      public function show() : void
      {
         titleText = LanguageMgr.GetTranslation("vehicle.molishilian");
         LayerManager.Instance.addToLayer(this,3,true,true);
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
         removeEvent();
         unitView();
         super.dispose();
      }
   }
}

