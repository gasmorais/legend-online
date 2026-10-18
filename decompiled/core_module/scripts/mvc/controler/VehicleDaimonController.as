package mvc.controler
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.Frame;
   import com.road.yishi.proto.simple.PropertyMsg;
   import mvc.FrameController;
   import mvc.ModuleFrameInfo;
   import mvc.module.vehicle.DaimonModel;
   import yishi.comm.PackageOut;
   import yishi.datas.playerinfo.PlayerInfo;
   import yishi.manager.PlayerManager;
   import yishi.service.managers.SocketSendManager;
   
   public class VehicleDaimonController extends FrameController
   {
      
      private var _model:DaimonModel;
      
      private var addMask:Boolean = false;
      
      public function VehicleDaimonController()
      {
         super();
      }
      
      private function addEvent() : void
      {
      }
      
      private function removeEvent() : void
      {
      }
      
      private function get playerInfo() : PlayerInfo
      {
         return PlayerManager.instance.currentPlayerModel.playerInfo;
      }
      
      override public function start(param1:ModuleFrameInfo = null) : void
      {
         if(!_model)
         {
            _model = new DaimonModel();
         }
         addMask = false;
         super.start(param1);
      }
      
      override protected function showFrame() : void
      {
         super.showFrame();
         _frame["show"](addMask);
      }
      
      override public function get frameClassName() : String
      {
         return "vehicle.DaimonFrame";
      }
      
      override protected function exitFrame() : void
      {
         _model = null;
         removeEvent();
         super.exitFrame();
      }
      
      public function get model() : DaimonModel
      {
         return _model;
      }
      
      public function openWithoutGroup() : Frame
      {
         if(!_model)
         {
            _model = new DaimonModel();
         }
         _frame = ComponentFactory.Instance.creatComponentByStylename(frameClassName);
         addMask = true;
         showFrame();
         return _frame;
      }
      
      public function sendOpenVehicle(param1:int, param2:Boolean) : void
      {
         var _loc4_:PackageOut = new PackageOut(8619);
         var _loc3_:PropertyMsg = new PropertyMsg();
         _loc3_.param1 = param1;
         _loc3_.param2 = 0;
         if(!param2)
         {
            _loc3_.param2 = 1;
         }
         SocketSendManager.instance.sendProtoBuffer(_loc4_,_loc3_);
      }
   }
}

