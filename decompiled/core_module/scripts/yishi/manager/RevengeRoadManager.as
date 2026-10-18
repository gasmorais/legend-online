package yishi.manager
{
   import com.pickgliss.toplevel.StageReferance;
   import com.road.yishi.proto.gameplot.PlotInfoMsg;
   import com.road.yishi.proto.gameplot.PlotMsg;
   import com.road.yishi.proto.module.RevengeRoadMsg;
   import com.road.yishi.proto.module.RevengeRoadNodeMsg;
   import com.road.yishi.proto.player.PlayerOpMsg;
   import dialog.DialogControl;
   import dialog.DialogModel;
   import dialog.data.DialogMessageInfo;
   import manager.LanguageMgr;
   import mvc.module.revenge.RevengeModel;
   import mvc.module.revenge.RevengeNodeInfo;
   import yishi.comm.PackageIn;
   import yishi.comm.PackageOut;
   import yishi.events.SLGSocketEvent;
   import yishi.scene.SceneType;
   import yishi.service.managers.SocketManager;
   import yishi.service.managers.SocketSendManager;
   
   public class RevengeRoadManager
   {
      
      private static var _ins:RevengeRoadManager;
      
      private var _model:RevengeModel;
      
      private const OP_GET_DATA:int = 0;
      
      private const OP_ATTACK:int = 1;
      
      private const OP_GET_BOX:int = 2;
      
      private const OP_BUY_REVENGE_HEART:int = 3;
      
      private const OP_BUY_ATTACK_COUNT:int = 4;
      
      public function RevengeRoadManager()
      {
         super();
         _model = new RevengeModel();
      }
      
      public static function get Ins() : RevengeRoadManager
      {
         if(_ins == null)
         {
            _ins = new RevengeRoadManager();
         }
         return _ins;
      }
      
      public function get model() : RevengeModel
      {
         return _model;
      }
      
      public function setup() : void
      {
         SocketManager.instance.addEventListener("SLGSocketEvent" + 4895,__revengeInfoHandler);
         SocketManager.instance.addEventListener("SLGSocketEvent" + 4896,onReceiveDialogData);
      }
      
      private function onReceiveDialogData(param1:SLGSocketEvent) : void
      {
         var _loc3_:DialogControl = null;
         var _loc4_:PackageIn = param1.data as PackageIn;
         var _loc2_:PlotMsg = new PlotMsg();
         _loc2_ = _loc4_.readBody(_loc2_) as PlotMsg;
         if(_loc2_.loop)
         {
            _loc3_ = new DialogControl(openMainFrame,StageReferance.stage);
            _loc3_.model = readPackage(_loc4_);
         }
         else
         {
            openMainFrame();
         }
      }
      
      private function openMainFrame() : void
      {
         FrameControllerManager.instance.openControllerByInfo("revengeroad");
      }
      
      private function readPackage(param1:PackageIn) : DialogModel
      {
         var _loc5_:int = 0;
         var _loc3_:DialogMessageInfo = null;
         var _loc4_:RegExp = null;
         var _loc6_:DialogModel = new DialogModel();
         var _loc2_:PlotMsg = new PlotMsg();
         _loc2_ = param1.readBody(_loc2_) as PlotMsg;
         _loc6_.isLoop = _loc2_.loop;
         _loc6_.scene = SceneType.getSceneTypeById(_loc2_.sceneType);
         _loc5_ = 0;
         while(_loc5_ < _loc2_.info.length)
         {
            _loc3_ = new DialogMessageInfo();
            _loc3_.index = (_loc2_.info[_loc5_] as PlotInfoMsg).index;
            _loc3_.direction = (_loc2_.info[_loc5_] as PlotInfoMsg).direction;
            _loc3_.roleId = (_loc2_.info[_loc5_] as PlotInfoMsg).roleId;
            if(_loc3_.roleId == 0)
            {
               _loc3_.roleId = PlayerManager.instance.currentPlayerModel.playerInfo.pics;
            }
            if((_loc2_.info[_loc5_] as PlotInfoMsg).roleName == "%s")
            {
               (_loc2_.info[_loc5_] as PlotInfoMsg).roleName = PlayerManager.instance.currentPlayerModel.playerInfo.nickName;
            }
            if((_loc2_.info[_loc5_] as PlotInfoMsg).roleName == PlayerManager.instance.currentPlayerModel.userInfo.userId + "$")
            {
               _loc3_.roleName = LanguageMgr.GetTranslation("public.nickName");
            }
            else
            {
               _loc3_.roleName = (_loc2_.info[_loc5_] as PlotInfoMsg).roleName;
            }
            _loc3_.event = (_loc2_.info[_loc5_] as PlotInfoMsg).event;
            _loc3_.param = (_loc2_.info[_loc5_] as PlotInfoMsg).param;
            _loc3_.txt = (_loc2_.info[_loc5_] as PlotInfoMsg).text;
            _loc3_.delayTime = (_loc2_.info[_loc5_] as PlotInfoMsg).delayTime;
            _loc4_ = /%s/g;
            _loc3_.txt = _loc3_.txt.replace(_loc4_,_loc3_.roleName);
            _loc6_.addInfo(_loc3_);
            _loc5_++;
         }
         return _loc6_;
      }
      
      private function __revengeInfoHandler(param1:SLGSocketEvent) : void
      {
         var _loc5_:RevengeNodeInfo = null;
         var _loc4_:PackageIn = param1.data as PackageIn;
         var _loc2_:RevengeRoadMsg = new RevengeRoadMsg();
         _loc2_ = _loc4_.readBody(_loc2_) as RevengeRoadMsg;
         if(_loc2_.hasType)
         {
            _model.op = _loc2_.type;
         }
         if(_loc2_.hasNodeId)
         {
            _model.nodeId = _loc2_.nodeId;
         }
         if(_loc2_.hasRevengeHeart)
         {
            _model.revengeHeart = _loc2_.revengeHeart;
         }
         if(_loc2_.hasBuyCount)
         {
            _model.buyCount = _loc2_.buyCount;
         }
         if(_loc2_.hasUpdateTime)
         {
            _model.updateTime = _loc2_.updateTime;
         }
         if(_loc2_.hasBoxState)
         {
            _model.boxState = _loc2_.boxState;
         }
         for each(var _loc3_:RevengeRoadNodeMsg in _loc2_.nodeList)
         {
            _loc5_ = _model.nodeDic[_loc3_.nodeId];
            if(_loc5_ == null)
            {
               _loc5_ = new RevengeNodeInfo();
               _model.nodeDic[_loc3_.nodeId] = _loc5_;
            }
            _loc5_.nodeId = _loc3_.nodeId;
            _loc5_.attackCount = _loc3_.attackCount;
            _loc5_.buyCount = _loc3_.buyCount;
         }
         NotificationManager.instance.sendNotification("REVENGE_ROAD_DATA");
      }
      
      public function sendGetData() : void
      {
         var _loc2_:PackageOut = new PackageOut(9688);
         var _loc1_:PlayerOpMsg = new PlayerOpMsg();
         _loc1_.op = 0;
         SocketSendManager.instance.sendProtoBuffer(_loc2_,_loc1_);
      }
      
      public function sendAttackNode(param1:int) : void
      {
         model.currFightNodeId = param1;
         var _loc3_:PackageOut = new PackageOut(9688);
         var _loc2_:PlayerOpMsg = new PlayerOpMsg();
         _loc2_.op = 1;
         _loc2_.nodeId = param1;
         SocketSendManager.instance.sendProtoBuffer(_loc3_,_loc2_);
      }
      
      public function sendBuyHeart() : void
      {
         var _loc2_:PackageOut = new PackageOut(9688);
         var _loc1_:PlayerOpMsg = new PlayerOpMsg();
         _loc1_.op = 3;
         SocketSendManager.instance.sendProtoBuffer(_loc2_,_loc1_);
      }
      
      public function sendBuyBoss(param1:int) : void
      {
         var _loc3_:PackageOut = new PackageOut(9688);
         var _loc2_:PlayerOpMsg = new PlayerOpMsg();
         _loc2_.nodeId = param1;
         _loc2_.op = 4;
         SocketSendManager.instance.sendProtoBuffer(_loc3_,_loc2_);
      }
      
      public function sendGetAreaBox(param1:int) : void
      {
         var _loc3_:PackageOut = new PackageOut(9688);
         var _loc2_:PlayerOpMsg = new PlayerOpMsg();
         _loc2_.index = param1;
         _loc2_.op = 2;
         SocketSendManager.instance.sendProtoBuffer(_loc3_,_loc2_);
      }
      
      public function battleOverHandlerView() : void
      {
         FrameControllerManager.instance.openControllerByInfo("revengeroad");
      }
   }
}

