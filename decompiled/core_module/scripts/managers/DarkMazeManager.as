package managers
{
   import com.road.yishi.proto.avenger.DarkMazeChildMsg;
   import com.road.yishi.proto.avenger.DarkMazeMsg;
   import com.road.yishi.proto.player.PlayerOpMsg;
   import com.road.yishi.proto.simple.PropertyMsg;
   import flash.events.Event;
   import flash.utils.Dictionary;
   import manager.LanguageMgr;
   import mvc.module.darkmaze.DarkMazeBattleChildInfo;
   import mvc.module.darkmaze.DarkMazeChildPosInfo;
   import mvc.module.darkmaze.DarkMazeModel;
   import mvc.module.darkmaze.DarkMazeNodeInfo;
   import ui.toptoolbar.TopToolsBar;
   import yishi.SwitchPageHelp;
   import yishi.comm.PackageIn;
   import yishi.comm.PackageOut;
   import yishi.datas.templates.DarkMazeEventTemplateInfo;
   import yishi.events.NotificationEvent;
   import yishi.events.SLGSocketEvent;
   import yishi.manager.NotificationManager;
   import yishi.manager.PlayerManager;
   import yishi.manager.TempleteManager;
   import yishi.scene.SceneManager;
   import yishi.service.managers.SocketManager;
   import yishi.utils.DateFormatter;
   import yishi.utils.StringHelper;
   import yishi.view.tips.MessageTipManager;
   
   public class DarkMazeManager
   {
      
      private static var _instance:DarkMazeManager;
      
      private var _model:DarkMazeModel;
      
      public function DarkMazeManager()
      {
         super();
         _model = new DarkMazeModel();
      }
      
      public static function get instance() : DarkMazeManager
      {
         if(!_instance)
         {
            _instance = new DarkMazeManager();
         }
         return _instance;
      }
      
      public function get model() : DarkMazeModel
      {
         return _model;
      }
      
      public function enterScene() : void
      {
         var _loc2_:String = null;
         var _loc1_:Date = _model.findNearResetTime();
         var _loc3_:Date = PlayerManager.instance.currentPlayerModel.sysCurtime;
         if(_loc1_)
         {
            _loc2_ = DateFormatter.timeFormat1(_loc1_) + ":00";
         }
         if(_model.openStatus == 2)
         {
            MessageTipManager.instance().show(LanguageMgr.GetTranslation("mainBar.TopToolsBar.rechargeBtn.click04"));
            return;
         }
         if(_model.isCanRefresh())
         {
            if(_loc1_ && _loc3_ && _loc1_.time - _loc3_.time < 1800000)
            {
               MessageTipManager.instance().show(LanguageMgr.GetTranslation("darkmaze.topToolsBar.clickTips8",_loc2_));
               return;
            }
         }
         if(_model.passDarkMaze)
         {
            if(_model.isCanRefresh())
            {
               MessageTipManager.instance().show(LanguageMgr.GetTranslation("darkmaze.topToolsBar.clickTips7",_loc2_));
               return;
            }
            MessageTipManager.instance().show(LanguageMgr.GetTranslation("darkmaze.topToolsBar.clickTips2"));
            return;
         }
         if(FreedomTeamManager.instance.hasTeam)
         {
            MessageTipManager.instance().show(LanguageMgr.GetTranslation("darkmaze.topToolsBar.clickTips5"));
            return;
         }
         if(SceneManager.instance.currentType == "CAMPAIGN_MAP_SCENE")
         {
            MessageTipManager.instance().show(LanguageMgr.GetTranslation("darkmaze.topToolsBar.clickTips6"));
            return;
         }
         SceneManager.instance.setScene("DARK_MAZE_SCENE",null,true);
      }
      
      public function setup() : void
      {
         SocketManager.instance.addEventListener("SLGSocketEvent" + 4278,__onInfoHandler);
         SocketManager.instance.addEventListener("SLGSocketEvent" + 4590,__darkmazeBtnHandler);
      }
      
      private function __darkmazeBtnHandler(param1:SLGSocketEvent) : void
      {
         var _loc3_:PackageIn = param1.data as PackageIn;
         var _loc2_:PropertyMsg = new PropertyMsg();
         _loc2_ = _loc3_.readBody(_loc2_) as PropertyMsg;
         if(_loc2_.param1 == 2065)
         {
            model.darkMazeIsOpen = _loc2_.param7;
            model.passDarkMaze = _loc2_.param8;
            model.openStatus = _loc2_.param2;
            TopToolsBar.instance.darkmazeStatus = _loc2_.param2;
            NotificationManager.instance.sendNotification("REFRESH_TOPTOOLS");
         }
      }
      
      private function __onInfoHandler(param1:SLGSocketEvent) : void
      {
         var _loc3_:PackageIn = param1.data as PackageIn;
         var _loc2_:DarkMazeMsg = new DarkMazeMsg();
         _loc2_ = _loc3_.readBody(_loc2_) as DarkMazeMsg;
         if(_loc2_)
         {
            if(_loc2_.opType == 1 || _loc2_.opType == 3)
            {
               initCurrentAndTargetNodeInfo(_loc2_);
               if(_loc2_.pathInfo && !StringHelper.isNullOrEmpty(_loc2_.pathInfo))
               {
                  model.hasWalkedNodeArray = _loc2_.pathInfo.split(",");
               }
               if(_loc2_.nodeInfo && !StringHelper.isNullOrEmpty(_loc2_.nodeInfo))
               {
                  initNodeInfo(_loc2_.nodeInfo);
               }
               if(_loc2_.posInfo && !StringHelper.isNullOrEmpty(_loc2_.posInfo))
               {
                  initBattlePosInfo(_loc2_.posInfo);
               }
               if(_loc2_.childs)
               {
                  initChidList(_loc2_);
               }
               if(_loc2_.buyInfo && !StringHelper.isNullOrEmpty(_loc2_.buyInfo))
               {
                  model.buyInfoArr = _loc2_.buyInfo.split(",");
               }
               NotificationManager.instance.dispatchEvent(new Event("DARK_MAZE_DATA_INIT"));
            }
            else if(_loc2_.opType == 2)
            {
               initCurrentAndTargetNodeInfo(_loc2_);
               if(_loc2_.pathInfo && !StringHelper.isNullOrEmpty(_loc2_.pathInfo))
               {
                  model.hasWalkedNodeArray = _loc2_.pathInfo.split(",");
               }
               if(_loc2_.childs)
               {
                  initChidList(_loc2_);
               }
               NotificationManager.instance.dispatchEvent(new Event("DARK_MAZE_MOVE"));
            }
            else if(_loc2_.opType == 4)
            {
               if(_loc2_.posInfo && !StringHelper.isNullOrEmpty(_loc2_.posInfo))
               {
                  initBattlePosInfo(_loc2_.posInfo);
                  NotificationManager.instance.dispatchEvent(new NotificationEvent("DARK_MAZE_BATTLE_INFO_UPDATA"));
               }
            }
            else if(_loc2_.opType == 5)
            {
               if(_loc2_.childs)
               {
                  initChidList(_loc2_);
               }
            }
            else if(_loc2_.opType == 6)
            {
               if(_loc2_.buyInfo && !StringHelper.isNullOrEmpty(_loc2_.buyInfo))
               {
                  model.buyInfoArr = _loc2_.buyInfo.split(",");
               }
               NotificationManager.instance.dispatchEvent(new NotificationEvent("DARK_MAZE_SHOP_BUY_UPDATE"));
            }
            else if(_loc2_.opType == 7)
            {
               SwitchPageHelp.enterToSpace();
            }
         }
      }
      
      private function initCurrentAndTargetNodeInfo(param1:DarkMazeMsg) : void
      {
         model.currentLayer = param1.layer;
         model.currentNodeId = param1.nodeId;
         model.currentIndexPosX = model.posIndexArray[model.currentNodeId - 1].x;
         model.currentIndexPosY = model.posIndexArray[model.currentNodeId - 1].y;
         model.targetNodeId = param1.targetId;
         if(model.targetNodeId > 1)
         {
            model.targetIndexPosX = model.posIndexArray[model.targetNodeId - 1].x;
            model.targetIndexPosY = model.posIndexArray[model.targetNodeId - 1].y;
         }
      }
      
      private function initNodeInfo(param1:String) : void
      {
         var _loc2_:int = 0;
         var _loc6_:DarkMazeNodeInfo = null;
         var _loc4_:int = 0;
         var _loc7_:int = 0;
         var _loc8_:DarkMazeEventTemplateInfo = null;
         var _loc5_:int = 0;
         var _loc3_:Array = param1.split("|");
         if(_loc3_)
         {
            _loc2_ = int(_loc3_.length);
            model.nodeInfoDic = new Dictionary();
            _loc5_ = 0;
            while(_loc5_ < _loc2_)
            {
               _loc6_ = new DarkMazeNodeInfo();
               _loc6_.nodeId = _loc3_[_loc5_].split(",")[0];
               _loc6_.eventTemp = new DarkMazeEventTemplateInfo();
               _loc7_ = int(_loc3_[_loc5_].split(",")[1]);
               _loc8_ = TempleteManager.instance.darkMazeEventTempCate.getTemplateByID(_loc7_);
               if(_loc8_)
               {
                  _loc6_.eventTemp = _loc8_;
               }
               model.nodeInfoDic[_loc6_.nodeId] = _loc6_;
               _loc5_++;
            }
         }
      }
      
      private function initBattlePosInfo(param1:String) : void
      {
         var _loc2_:int = 0;
         var _loc4_:DarkMazeChildPosInfo = null;
         var _loc5_:int = 0;
         var _loc3_:Array = param1.split("|");
         if(_loc3_)
         {
            _loc2_ = int(_loc3_.length);
            model.battleArray = [];
            model.battleChildIdList = [];
            _loc5_ = 0;
            while(_loc5_ < _loc2_)
            {
               _loc4_ = new DarkMazeChildPosInfo();
               _loc4_.pos = _loc3_[_loc5_].split(",")[0];
               _loc4_.childId = _loc3_[_loc5_].split(",")[1];
               model.battleArray.push(_loc4_);
               if(_loc4_.childId != 0)
               {
                  model.battleChildIdList.push(_loc4_.childId);
               }
               _loc5_++;
            }
         }
         model.battleArray.sort(infoSortByPos);
      }
      
      private function initChidList(param1:DarkMazeMsg) : void
      {
         var _loc3_:DarkMazeChildMsg = null;
         var _loc4_:DarkMazeBattleChildInfo = null;
         var _loc5_:int = 0;
         var _loc2_:Array = param1.childs;
         model.childList = [];
         _loc5_ = 0;
         while(_loc5_ < _loc2_.length)
         {
            _loc3_ = _loc2_[_loc5_] as DarkMazeChildMsg;
            _loc4_ = new DarkMazeBattleChildInfo();
            _loc4_.childId = _loc3_.childId;
            _loc4_.currentHp = _loc3_.hp;
            _loc4_.totalHp = _loc3_.maxHp;
            _loc4_.fightValue = _loc3_.fightPower;
            model.childList.push(_loc4_);
            _loc5_++;
         }
         model.childList.sort(infoSortByChildId);
      }
      
      private function infoSortByPos(param1:DarkMazeChildPosInfo, param2:DarkMazeChildPosInfo) : int
      {
         if(param1.pos < param2.pos)
         {
            return -1;
         }
         if(param1.pos > param2.pos)
         {
            return 1;
         }
         return 0;
      }
      
      private function infoSortByChildId(param1:DarkMazeBattleChildInfo, param2:DarkMazeBattleChildInfo) : int
      {
         if(param1.childId < param2.childId)
         {
            return 1;
         }
         if(param1.childId > param2.childId)
         {
            return -1;
         }
         return 0;
      }
      
      public function darkMazeOperation(param1:int, param2:int = 0, param3:int = 0, param4:String = "") : void
      {
         var _loc6_:PackageOut = new PackageOut(8662);
         var _loc5_:PlayerOpMsg = new PlayerOpMsg();
         _loc5_.op = param1;
         if(param2 != 0)
         {
            _loc5_.nodeId = param2;
         }
         if(param3 != 0)
         {
            _loc5_.id = param3;
         }
         if(!StringHelper.isNullOrEmpty(param4))
         {
            _loc5_.param1 = param4;
         }
         SocketManager.instance.socket.sendProtobuffer(_loc6_,_loc5_);
      }
   }
}

