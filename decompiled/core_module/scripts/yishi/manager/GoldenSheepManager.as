package yishi.manager
{
   import com.netease.protobuf.Message;
   import com.road.yishi.proto.cccactive.GoldenSheepMsg;
   import com.road.yishi.proto.cccactive.GoldenSheepPlayerMsg;
   import mvc.module.goldensheep.GoldenSheepModel;
   import mvc.module.goldensheep.GoldenSheepRecordInfo;
   import yishi.comm.PackageIn;
   import yishi.comm.PackageOut;
   import yishi.events.SLGSocketEvent;
   import yishi.service.managers.SocketManager;
   import yishi.service.managers.SocketSendManager;
   import yishi.utils.DateFormatter;
   
   public class GoldenSheepManager
   {
      
      private static var _instance:GoldenSheepManager;
      
      private var _model:GoldenSheepModel;
      
      private const OP_CHECK:int = 1;
      
      private const OP_OPEN:int = 2;
      
      private const OP_CLOSE:int = 3;
      
      public function GoldenSheepManager()
      {
         super();
         _model = new GoldenSheepModel();
      }
      
      public static function get instance() : GoldenSheepManager
      {
         if(!_instance)
         {
            _instance = new GoldenSheepManager();
         }
         return _instance;
      }
      
      public function get model() : GoldenSheepModel
      {
         return _model;
      }
      
      public function setup() : void
      {
         initEvent();
      }
      
      private function initEvent() : void
      {
         SocketManager.instance.addEventListener("SLGSocketEvent" + 4881,__goldenSheepHandler);
      }
      
      private function __goldenSheepHandler(param1:SLGSocketEvent) : void
      {
         var _loc4_:GoldenSheepRecordInfo = null;
         var _loc6_:PackageIn = param1.data as PackageIn;
         var _loc2_:GoldenSheepMsg = new GoldenSheepMsg();
         _loc2_ = _loc6_.readBody(_loc2_) as GoldenSheepMsg;
         if(_loc2_.op == 3)
         {
            FrameControllerManager.instance.goldenSheepController.closeFrame();
            return;
         }
         model.index = _loc2_.index;
         model.myCount = _loc2_.myCount;
         model.isReward = _loc2_.isReward;
         model.rewardId = _loc2_.rewardId;
         model.totalCount = _loc2_.totalCount;
         model.curCount = _loc2_.curCount;
         model.isOpen = _loc2_.isOpen;
         model.state = _loc2_.state;
         model.openTime = DateFormatter.parse(_loc2_.openTime,"YYYY-MM-DD hh:mm:ss");
         model.endTime = DateFormatter.parse(_loc2_.stopTime,"YYYY-MM-DD hh:mm:ss");
         var _loc3_:Vector.<GoldenSheepRecordInfo> = new Vector.<GoldenSheepRecordInfo>();
         if(_loc2_.sheepData && _loc2_.sheepData.length > 0)
         {
            for each(var _loc5_:GoldenSheepPlayerMsg in _loc2_.sheepData)
            {
               _loc4_ = new GoldenSheepRecordInfo();
               _loc4_.nickName = _loc5_.nickName;
               _loc4_.money = _loc5_.money;
               _loc4_.isBest = _loc5_.isBest;
               _loc3_.push(_loc4_);
            }
         }
         model.recordList = _loc3_;
         switch(_loc2_.op - 1)
         {
            case 0:
               if(model.hasGotReward)
               {
                  FrameControllerManager.instance.openControllerByInfo("goldensheep");
               }
               else
               {
                  FrameControllerManager.instance.openControllerByInfo("goldensheep",2);
               }
               break;
            case 1:
               model.updateAnimation();
               break;
            default:
               model.updateState();
         }
         model.commit();
      }
      
      public function checkState() : void
      {
         var _loc2_:PackageOut = new PackageOut(9645,0,31);
         var _loc1_:GoldenSheepMsg = new GoldenSheepMsg();
         _loc1_.op = 1;
         sendProtoBuffer(_loc2_,_loc1_);
      }
      
      public function openBox() : void
      {
         var _loc2_:PackageOut = new PackageOut(9645,0,31);
         var _loc1_:GoldenSheepMsg = new GoldenSheepMsg();
         _loc1_.op = 2;
         sendProtoBuffer(_loc2_,_loc1_);
      }
      
      private function sendProtoBuffer(param1:PackageOut, param2:Message) : void
      {
         SocketSendManager.instance.sendProtoBuffer(param1,param2);
      }
   }
}

