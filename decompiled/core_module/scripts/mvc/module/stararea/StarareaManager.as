package mvc.module.stararea
{
   import com.road.yishi.proto.active.StarAreaMessage;
   import com.road.yishi.proto.simple.PropertyMsg;
   import flash.events.EventDispatcher;
   import manager.LanguageMgr;
   import managers.MonopolyGemMazeManager;
   import mvc.module.stararea.event.StarareaEvent;
   import simplegame.hamster.HamsterGameFrame;
   import yishi.SwitchPageHelp;
   import yishi.comm.PackageIn;
   import yishi.comm.PackageOut;
   import yishi.datas.templates.StarareaRoadsTemplate;
   import yishi.events.SLGSocketEvent;
   import yishi.manager.FrameControllerManager;
   import yishi.manager.TempleteManager;
   import yishi.scene.SceneManager;
   import yishi.service.managers.SocketManager;
   import yishi.service.managers.SocketSendManager;
   import yishi.utils.CheckUIModuleUtil;
   import yishi.utils.SimpleAlertHelper;
   import yishi.view.tips.MessageTipManager;
   
   public class StarareaManager extends EventDispatcher
   {
      
      public static const OP_OPEN:int = 1;
      
      public static const OP_MOVE:int = 2;
      
      public static const OP_USE_LIGHT:int = 3;
      
      public static const OP_GAME:int = 4;
      
      public static const OP_AWARD:int = 5;
      
      public static const OP_OVERGAME:int = 6;
      
      public static const GAME_TYPE_GEM:int = 1;
      
      public static const GAME_TYPE_LINK:int = 2;
      
      public static const GAME_OP_OPEN:int = 1;
      
      public static const GAME_OP_MOVE:int = 2;
      
      public static const NODE_TYPE_USED:int = -1;
      
      public static const NODE_TYPE_NORMAL:int = 0;
      
      public static const NODE_TYPE_LIGHT:int = 1;
      
      public static const NODE_TYPE_BOX:int = 2;
      
      public static const NODE_TYPE_BIGBOX:int = 5;
      
      public static const NODE_TYPE_KEY:int = 4;
      
      public static const ROAD_TYPE_NORMAL:int = 0;
      
      public static const ROAD_TYPE_BAN:int = 1;
      
      public static const ROAD_TYPE_LOCK:int = 2;
      
      public static const ROAD_TYPE_BATTLE:int = 3;
      
      public static const ROAD_TYPE_GAME:int = 4;
      
      public static const FROG_ADD:int = 100;
      
      public static const NODE_TYPE_FOG2:int = 50;
      
      public static const EX_MOUNTS_ID:int = 3295;
      
      private static var _instance:StarareaManager;
      
      private var _model:StarareaModel;
      
      public var isExit:Boolean;
      
      public var isStarareaGame:Boolean = false;
      
      public function StarareaManager()
      {
         super();
         _model = new StarareaModel();
      }
      
      public static function get instance() : StarareaManager
      {
         if(!_instance)
         {
            _instance = new StarareaManager();
         }
         return _instance;
      }
      
      public function start() : void
      {
         sendOpenView();
      }
      
      public function setup() : void
      {
         SocketManager.instance.addEventListener("SLGSocketEvent" + 4899,receiveStarareaInfo);
      }
      
      private function __gemMazeInfoBuffHandler(param1:SLGSocketEvent) : void
      {
         if(isStarareaGame)
         {
            FrameControllerManager.instance.openControllerByInfo("monopoly",8);
         }
      }
      
      private function receiveStarareaInfo(param1:SLGSocketEvent) : void
      {
         var _loc3_:PackageIn = param1.data as PackageIn;
         var _loc2_:StarAreaMessage = new StarAreaMessage();
         _loc2_ = _loc3_.readBody(_loc2_) as StarAreaMessage;
         model.lightCount = _loc2_.light;
         model.keyCount = _loc2_.key;
         model.actionPower = _loc2_.actionPower;
         if(model.nodes.toString() != _loc2_.nodes)
         {
            model.nodes = _loc2_.nodes.split(",");
         }
         if(model.roads.toString() != _loc2_.roads)
         {
            model.roads = _loc2_.roads.split(",");
            StarareaManager.instance.sendEvent("UPDATE_ROADS");
         }
         if(_loc2_.nowNode != model.myPointId)
         {
            if(model.myPointId == -1)
            {
               model.myPointId = _loc2_.nowNode;
            }
         }
         else
         {
            StarareaManager.instance.sendEvent("UPDATE_NODES");
            StarareaManager.instance.sendEvent("UPDATE_ROADS");
            StarareaManager.instance.sendEvent("UPDATE_DATA");
            model.targetType = 0;
         }
         StarareaManager.instance.sendEvent("UPDATE_TAB_VIEW");
      }
      
      public function sendEvent(param1:String, param2:* = null) : void
      {
         dispatchEvent(new StarareaEvent(param1,param2));
      }
      
      public function sendOpenView() : void
      {
         var _loc2_:PackageOut = new PackageOut(9691);
         var _loc1_:PropertyMsg = new PropertyMsg();
         _loc1_.param1 = 1;
         SocketSendManager.instance.sendProtoBuffer(_loc2_,_loc1_);
      }
      
      private function checkRoadArrive(param1:int) : Boolean
      {
         var _loc2_:int = 0;
         var _loc3_:Array = TempleteManager.instance.starareaRoadsTempCate.getNodesByNodeid(param1);
         for each(var _loc4_:int in _loc3_)
         {
            _loc2_ = int(model.nodes[_loc4_]);
            if(_loc2_ == -1)
            {
               return true;
            }
         }
         return false;
      }
      
      public function sendMove(param1:int) : void
      {
         var _loc2_:String = null;
         var _loc7_:String = null;
         var _loc4_:String = null;
         var _loc5_:String = null;
         if(param1 == model.myPointId)
         {
            return;
         }
         var _loc3_:StarareaRoadsTemplate = TempleteManager.instance.starareaRoadsTempCate.getTemplete(model.myPointId,param1);
         if(!_loc3_)
         {
            if(model.lightCount == 0 || model.getNodeType(param1) < 100)
            {
               MessageTipManager.instance().show(LanguageMgr.GetTranslation("stararea.hint1"));
            }
            else
            {
               _loc2_ = LanguageMgr.GetTranslation("stararea.hint5");
               _loc7_ = LanguageMgr.GetTranslation("public.prompt");
               _loc4_ = LanguageMgr.GetTranslation("public.confirm");
               _loc5_ = LanguageMgr.GetTranslation("public.cancel");
               SimpleAlertHelper.instance.data = [sendUseLight,param1];
               SimpleAlertHelper.instance.popAlerFrame(_loc7_,_loc2_,_loc4_,_loc5_,false,false,false,1);
            }
            return;
         }
         var _loc6_:int = model.getRoadType(_loc3_.Id);
         if(_loc6_ == 1)
         {
            MessageTipManager.instance().show(LanguageMgr.GetTranslation("stararea.hint2"));
            return;
         }
         if(_loc6_ == 2)
         {
            if(model.keyCount)
            {
               _loc2_ = LanguageMgr.GetTranslation("stararea.hint3");
               _loc7_ = LanguageMgr.GetTranslation("public.prompt");
               _loc4_ = LanguageMgr.GetTranslation("public.confirm");
               _loc5_ = LanguageMgr.GetTranslation("public.cancel");
               SimpleAlertHelper.instance.data = [realSendMove,_loc3_];
               SimpleAlertHelper.instance.popAlerFrame(_loc7_,_loc2_,_loc4_,_loc5_,false,false,false,1);
            }
            else
            {
               MessageTipManager.instance().show(LanguageMgr.GetTranslation("stararea.hint4"));
            }
            return;
         }
         realSendMove(true,false,_loc3_);
      }
      
      public function moveRoad(param1:int) : void
      {
         var _loc3_:PackageOut = new PackageOut(9691);
         var _loc2_:PropertyMsg = new PropertyMsg();
         _loc2_.param1 = 2;
         _loc2_.param2 = param1;
         SocketSendManager.instance.sendProtoBuffer(_loc3_,_loc2_);
      }
      
      public function gameFinsh(param1:int) : void
      {
         if(_model.gameRoadId == -1)
         {
            return;
         }
         var _loc3_:PackageOut = new PackageOut(9691);
         var _loc2_:PropertyMsg = new PropertyMsg();
         _loc2_.param1 = 6;
         _loc2_.param2 = param1;
         SocketSendManager.instance.sendProtoBuffer(_loc3_,_loc2_);
      }
      
      private function realSendMove(param1:Boolean, param2:Boolean, param3:StarareaRoadsTemplate) : void
      {
         var _loc5_:PackageOut = null;
         var _loc4_:PropertyMsg = null;
         if(param1)
         {
            model.targetType = model.getNodeType(param3.targetId);
            _loc5_ = new PackageOut(9691);
            _loc4_ = new PropertyMsg();
            _loc4_.param1 = 2;
            _loc4_.param2 = param3.Id;
            SocketSendManager.instance.sendProtoBuffer(_loc5_,_loc4_);
         }
      }
      
      public function startMiniGame(param1:int = -1) : void
      {
         var _loc2_:int = 0;
         if(param1 == -1)
         {
            _loc2_ = Math.random() * 2;
         }
         else
         {
            _loc2_ = param1;
         }
         isStarareaGame = true;
         if(_loc2_ == 0)
         {
            CheckUIModuleUtil.instance.tryCall("hamster",__showHamster);
         }
         else if(_loc2_ == 1)
         {
            FrameControllerManager.instance.openControllerByInfo("airgarden","GAME_TYPE_LLK");
         }
      }
      
      private function __showHamster() : void
      {
         var hamsterGame:HamsterGameFrame = new HamsterGameFrame(60,1500,function():void
         {
            MessageTipManager.instance().show(LanguageMgr.GetTranslation("MonopolyManager.GameTip02"));
            sendEvent("GAME_PASS");
         });
         hamsterGame.show();
      }
      
      public function sendPlayGame(param1:int, param2:int, param3:String = "") : void
      {
         MonopolyGemMazeManager.Instance.getInitInfo();
         var _loc5_:PackageOut = new PackageOut(9691);
         var _loc4_:PropertyMsg = new PropertyMsg();
         _loc4_.param1 = 4;
         _loc4_.param2 = param1;
         _loc4_.param3 = param2;
         _loc4_.param4 = param3;
         SocketSendManager.instance.sendProtoBuffer(_loc5_,_loc4_);
      }
      
      public function sendUseLight(param1:Boolean, param2:Boolean, param3:int) : void
      {
         var _loc5_:PackageOut = null;
         var _loc4_:PropertyMsg = null;
         if(param1)
         {
            _loc5_ = new PackageOut(9691);
            _loc4_ = new PropertyMsg();
            _loc4_.param1 = 3;
            _loc4_.param2 = param3;
            SocketSendManager.instance.sendProtoBuffer(_loc5_,_loc4_);
         }
      }
      
      public function sendGetAward(param1:int) : void
      {
         var _loc2_:String = LanguageMgr.GetTranslation("stararea.hint5");
         var _loc7_:String = LanguageMgr.GetTranslation("public.prompt");
         var _loc4_:String = LanguageMgr.GetTranslation("public.confirm");
         var _loc5_:String = LanguageMgr.GetTranslation("public.cancel");
         var _loc6_:int = int(model.nodes[param1 - 1]);
         if(_loc6_ > 50)
         {
            if(model.lightCount > 0)
            {
               sendUseLight(true,false,param1);
            }
            return;
         }
         var _loc8_:PackageOut = new PackageOut(9691);
         var _loc3_:PropertyMsg = new PropertyMsg();
         _loc3_.param1 = 5;
         _loc3_.param2 = param1;
         SocketSendManager.instance.sendProtoBuffer(_loc8_,_loc3_);
      }
      
      public function exit() : void
      {
         SwitchPageHelp.returnToSpace({"isOpenStararea":true});
      }
      
      public function enterGameHallScene() : void
      {
         SceneManager.instance.setScene("STARAREA_SCENE");
      }
      
      public function get model() : StarareaModel
      {
         return _model;
      }
      
      public function set model(param1:StarareaModel) : void
      {
         _model = param1;
      }
   }
}

