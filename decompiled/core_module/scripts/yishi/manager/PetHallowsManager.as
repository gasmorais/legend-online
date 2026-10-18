package yishi.manager
{
   import com.road.yishi.proto.pet.PetContractInfoMsg;
   import com.road.yishi.proto.pet.PetHallowInfoMsg;
   import com.road.yishi.proto.pet.PetHallowListMsg;
   import flash.utils.Dictionary;
   import mvc.module.pet.pethallows.PetHallowsInfo;
   import mvc.module.pet.pethallows.PetHallowsModel;
   import yishi.comm.PackageIn;
   import yishi.comm.PackageOut;
   import yishi.events.SLGSocketEvent;
   import yishi.service.managers.SocketManager;
   import yishi.service.managers.SocketSendManager;
   import yishi.utils.MsgMan;
   
   public class PetHallowsManager
   {
      
      private static var _instance:PetHallowsManager;
      
      private var _model:PetHallowsModel;
      
      public function PetHallowsManager()
      {
         super();
      }
      
      public static function get instance() : PetHallowsManager
      {
         if(!_instance)
         {
            _instance = new PetHallowsManager();
         }
         return _instance;
      }
      
      public function get model() : PetHallowsModel
      {
         if(!_model)
         {
            _model = new PetHallowsModel();
         }
         return _model;
      }
      
      public function setup() : void
      {
         addEvent();
      }
      
      private function addEvent() : void
      {
         SocketManager.instance.addEventListener("SLGSocketEvent" + 388,__updateHallowsMsgHandler);
      }
      
      private function __updateHallowsMsgHandler(param1:SLGSocketEvent) : void
      {
         var _loc3_:PetHallowsInfo = null;
         var _loc5_:PackageIn = param1.data as PackageIn;
         var _loc2_:PetHallowListMsg = new PetHallowListMsg();
         _loc2_ = _loc5_.readBody(_loc2_) as PetHallowListMsg;
         model.hallowsInfoList.length = 0;
         for each(var _loc6_:PetHallowInfoMsg in _loc2_.hallowInfo)
         {
            _loc3_ = new PetHallowsInfo();
            _loc3_.hallowType = _loc6_.hallowSonType;
            _loc3_.hallowTempId = _loc6_.hallowTempId;
            _loc3_.infuseIndex = _loc6_.infuseIndex;
            _loc3_.equipPetId = _loc6_.equipPetId;
            _loc3_.propAddValue0 = _loc6_.attackData;
            _loc3_.propAddValue1 = _loc6_.defenceData;
            _loc3_.propAddValue2 = _loc6_.magicDefenceData;
            _loc3_.propAddValue3 = _loc6_.liveData;
            _loc3_.propAddValue4 = _loc6_.reduceResiData;
            _loc3_.propAddValue5 = _loc6_.otherResiData;
            _loc3_.propAddGp0 = _loc6_.attackGp;
            _loc3_.propAddGp1 = _loc6_.defenceGp;
            _loc3_.propAddGp2 = _loc6_.magicDefenceGp;
            _loc3_.propAddGp3 = _loc6_.liveGp;
            _loc3_.propAddGp4 = _loc6_.reduceResiGp;
            _loc3_.propAddGp5 = _loc6_.otherResiGp;
            _loc3_.propAddGrade0 = _loc6_.attackGrade;
            _loc3_.propAddGrade1 = _loc6_.defenceGrade;
            _loc3_.propAddGrade2 = _loc6_.magicDefenceGrade;
            _loc3_.propAddGrade3 = _loc6_.liveGrade;
            _loc3_.propAddGrade4 = _loc6_.reduceResiGrade;
            _loc3_.propAddGrade5 = _loc6_.otherResiGrade;
            _loc3_.activeSkillTempId = _loc6_.activeSkillTempId;
            model.hallowsInfoList.push(_loc3_);
         }
         model.hallowsInfoList.sortOn("hallowType",16);
         model.contracInfoDic = new Dictionary(true);
         for each(var _loc4_:PetContractInfoMsg in _loc2_.contractInfo)
         {
            model.contracInfoDic[_loc4_.petSonType] = _loc4_.contractTempId;
         }
         MsgMan.notifyObserver("PET_HALLOWS_MSG_UPDATE");
      }
      
      public function sendPetHallowsRequest(param1:int, param2:int = 0, param3:int = 0) : void
      {
         var _loc5_:PackageOut = new PackageOut(9627);
         var _loc4_:PetHallowListMsg = new PetHallowListMsg();
         _loc4_.op = param1;
         if(param2 != 0)
         {
            _loc4_.sonType = param2;
         }
         if(param3 != 0)
         {
            _loc4_.petId = param3;
         }
         SocketSendManager.instance.sendProtoBuffer(_loc5_,_loc4_);
      }
      
      public function sendPetInscriptionRequest(param1:int, param2:int, param3:int, param4:Array) : void
      {
         var _loc6_:PackageOut = new PackageOut(9627);
         var _loc5_:PetHallowListMsg = new PetHallowListMsg();
         _loc5_.op = 5;
         _loc5_.sonType = param1;
         _loc5_.removeItemTempId = param2;
         _loc5_.payType = param3;
         _loc5_.lockSet = param4;
         SocketSendManager.instance.sendProtoBuffer(_loc6_,_loc5_);
      }
   }
}

