package yishi.manager
{
   import com.road.yishi.proto.player.PlayerOpMsg;
   import com.road.yishi.proto.simple.PropertyMsg;
   import mvc.module.proficiency.ProficiencyModel;
   import yishi.comm.PackageIn;
   import yishi.comm.PackageOut;
   import yishi.events.SLGSocketEvent;
   import yishi.service.managers.SocketManager;
   import yishi.service.managers.SocketSendManager;
   import yishi.utils.MsgMan;
   
   public class ProficiencyManager
   {
      
      private static var _instance:ProficiencyManager;
      
      private var _model:ProficiencyModel;
      
      public function ProficiencyManager()
      {
         super();
         if(!_model)
         {
            _model = new ProficiencyModel();
         }
      }
      
      public static function get instance() : ProficiencyManager
      {
         if(!_instance)
         {
            _instance = new ProficiencyManager();
         }
         return _instance;
      }
      
      public function get model() : ProficiencyModel
      {
         return _model;
      }
      
      public function setup() : void
      {
         SocketManager.instance.addEventListener("SLGSocketEvent" + 210,__proficiencyUpdateHandler);
      }
      
      private function __proficiencyUpdateHandler(param1:SLGSocketEvent) : void
      {
         var _loc3_:PackageIn = param1.data as PackageIn;
         var _loc2_:PropertyMsg = new PropertyMsg();
         _loc2_ = _loc3_.readBody(_loc2_) as PropertyMsg;
         model.proficiencyGrade = _loc2_.param1;
         model.proficiencyValue = _loc2_.param2;
         MsgMan.notifyObserver("PROFICIENCY_INFO_UPDATE");
      }
      
      public function sendProficiencyRequest(param1:int) : void
      {
         var _loc3_:PackageOut = new PackageOut(8660);
         var _loc2_:PlayerOpMsg = new PlayerOpMsg();
         _loc2_.op = param1;
         SocketSendManager.instance.sendProtoBuffer(_loc3_,_loc2_);
      }
   }
}

