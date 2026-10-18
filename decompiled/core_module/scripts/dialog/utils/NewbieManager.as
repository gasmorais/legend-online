package dialog.utils
{
   import com.pickgliss.loader.DisplayLoader;
   import flash.events.EventDispatcher;
   import map.campaign.CampaignManager;
   import map.internals.data.CampaignNode;
   import yishi.datas.playerinfo.PlayerInfo;
   import yishi.events.NotificationEvent;
   import yishi.manager.ArmyManager;
   import yishi.manager.GameBaseQueueManager;
   import yishi.manager.NotificationManager;
   import yishi.manager.PlayerManager;
   import yishi.scene.SceneManager;
   
   public class NewbieManager extends EventDispatcher
   {
      
      private static var _instance:NewbieManager;
      
      private var _currentNode:NewbieNodeBase;
      
      private var _currentNoviceTutorial:NewbieTutorialBase;
      
      public var isSelectCtrl:Boolean = true;
      
      public var isSelectCastle:Boolean = true;
      
      public var isSoundMusic:Boolean = true;
      
      private var _isPlayingLockWeek:Boolean;
      
      private var _initialized:Boolean;
      
      public function NewbieManager()
      {
         super();
      }
      
      public static function get instance() : NewbieManager
      {
         if(_instance == null)
         {
            _instance = new NewbieManager();
         }
         return _instance;
      }
      
      public function start() : void
      {
         if(isMaxNovice)
         {
            startNoviceNode();
         }
         else
         {
            nextTutorialNode();
         }
      }
      
      private function findNextNodeId() : int
      {
         var _loc4_:int = 0;
         var _loc1_:Array = [];
         for(var _loc3_:String in NewbieModel.TUTORIAL_NODES)
         {
            _loc1_.push(int(_loc3_));
         }
         _loc1_.sort(16);
         var _loc5_:int = PlayerManager.instance.currentPlayerModel.playerInfo.noviceProcess;
         var _loc2_:int = -1;
         _loc4_ = _loc1_.length - 1;
         while(_loc4_ >= 0)
         {
            if(_loc1_[_loc4_] <= _loc5_)
            {
               _loc2_ = int(_loc1_[_loc4_]);
               break;
            }
            _loc4_--;
         }
         return _loc2_;
      }
      
      public function startNoviceNode() : void
      {
         if(_currentNode)
         {
            if(_currentNode.hasEventListener("nodeComplete"))
            {
               _currentNode.removeEventListener("nodeComplete",__onCurrentNoviceNodeComplete);
            }
            _currentNode.dispose();
            _currentNode = null;
         }
         NotificationManager.instance.addEventListener("TASK_COMMIT",__onTaskCommitHandler);
         NotificationManager.instance.addEventListener("LEVEL_COMMIT",__onLevelCommitHandler);
         checkHasViceGuild();
      }
      
      public function checkHasViceGuild() : void
      {
         if(!playerInfo.needViceGuild || !isOpenVicePassword)
         {
            return;
         }
         var _loc1_:Object = NewbieModel.VICE_GUILD[50500];
         if(!_loc1_)
         {
            return;
         }
         var _loc2_:Class = DisplayLoader.Context.applicationDomain.getDefinition(_loc1_.cls) as Class;
         _currentNoviceTutorial = new _loc2_() as NewbieTutorialBase;
         _currentNoviceTutorial.nid = _loc1_.nid;
         _currentNoviceTutorial.addEventListener("tutorialComplete",__tutorialCompleteHandler);
         _currentNoviceTutorial.prepare();
      }
      
      public function testShow(param1:int) : void
      {
         var _loc2_:Object = NewbieModel.NOVICE_LEVEL_NODES[param1];
         nextNoviceNode(_loc2_);
      }
      
      public function playLockWeekGuild() : void
      {
         var _loc1_:Object = null;
         var _loc3_:Class = null;
         var _loc2_:NewbieTutorialBase = null;
         if(playerInfo.isNeedWeekLockGuild && !_isPlayingLockWeek)
         {
            _isPlayingLockWeek = true;
            _loc1_ = NewbieModel.VICE_GUILD_2[50501];
            if(!_loc1_)
            {
               return;
            }
            _loc3_ = DisplayLoader.Context.applicationDomain.getDefinition(_loc1_.cls) as Class;
            _loc2_ = new _loc3_() as NewbieTutorialBase;
            _loc2_.nid = _loc1_.nid;
            _loc2_.prepare();
         }
      }
      
      public function closePlayLockWeek() : void
      {
         _isPlayingLockWeek = false;
      }
      
      public function get isPlayingLockWeek() : Boolean
      {
         return _isPlayingLockWeek;
      }
      
      private function get isOpenVicePassword() : Boolean
      {
         return ArmyManager.instance.thane.grades >= 10;
      }
      
      private function __onLevelCommitHandler(param1:NotificationEvent) : void
      {
         var _loc3_:int = param1.data;
         var _loc2_:Object = NewbieModel.NOVICE_LEVEL_NODES[_loc3_];
         if(!_loc2_)
         {
            return;
         }
         nextNoviceNode(_loc2_);
      }
      
      private function __onTaskCommitHandler(param1:NotificationEvent) : void
      {
         var _loc3_:int = param1.data;
         var _loc2_:Object = NewbieModel.NOVICE_TASK_NODES[_loc3_];
         if(!_loc2_)
         {
            return;
         }
         nextNoviceNode(_loc2_);
      }
      
      private function nextNoviceNode(param1:Object) : void
      {
         if(!param1)
         {
            return;
         }
         if(!param1.cls || !DisplayLoader.Context.applicationDomain.hasDefinition(param1.cls))
         {
            return;
         }
         if(_currentNode)
         {
            if(_currentNode.hasEventListener("nodeComplete"))
            {
               _currentNode.removeEventListener("nodeComplete",__onCurrentNoviceNodeComplete);
            }
            GameBaseQueueManager.instance.removeAction(_currentNode);
            _currentNode.dispose();
            _currentNode = null;
         }
         var _loc2_:Class = DisplayLoader.Context.applicationDomain.getDefinition(param1.cls) as Class;
         _currentNode = new _loc2_();
         _currentNode.nid = param1.nid;
         _currentNode.addEventListener("nodeComplete",__onCurrentNoviceNodeComplete);
         GameBaseQueueManager.instance.addAction(_currentNode,_currentNode.priority);
      }
      
      private function __onCurrentNoviceNodeComplete(param1:NoviceEvent) : void
      {
         _currentNode.removeEventListener("nodeComplete",__onCurrentNoviceNodeComplete);
         _currentNode = null;
      }
      
      public function get isMaxNovice() : Boolean
      {
         return getCurrentServerId() >= 25000;
      }
      
      public function getCurrentServerId() : int
      {
         return PlayerManager.instance.currentPlayerModel.playerInfo.noviceProcess;
      }
      
      public function skipNoviceHandle() : void
      {
         var _loc1_:CampaignNode = null;
         var _loc2_:int = 0;
         if(SceneManager.instance.currentType != "CAMPAIGN_MAP_SCENE")
         {
            return;
         }
         _loc2_ = 0;
         while(_loc2_ < CampaignManager.instance.mapModel.mapNodesData.length)
         {
            _loc1_ = CampaignManager.instance.mapModel.mapNodesData[_loc2_];
            _loc1_.info.state = 8;
            _loc2_++;
         }
         NewbieSocketOutManager.sendSaveProcess(-1);
         startNoviceNode();
      }
      
      private function __tutorialCompleteHandler(param1:NoviceEvent) : void
      {
         if(_currentNoviceTutorial.hasEventListener("tutorialComplete"))
         {
            _currentNoviceTutorial.removeEventListener("tutorialComplete",__tutorialCompleteHandler);
         }
         _currentNoviceTutorial = null;
         if(isMaxNovice)
         {
            startNoviceNode();
         }
         else
         {
            nextTutorialNode();
         }
      }
      
      private function nextTutorialNode() : void
      {
         var _loc3_:Class = null;
         var _loc2_:int = findNextNodeId();
         if(!_initialized)
         {
            initialize(NewbieModel.preloadXML,_loc2_);
         }
         var _loc1_:Object = NewbieModel.TUTORIAL_NODES[_loc2_];
         if(_loc1_)
         {
            if(_currentNoviceTutorial)
            {
               if(_currentNoviceTutorial.hasEventListener("tutorialComplete"))
               {
                  _currentNoviceTutorial.removeEventListener("tutorialComplete",__tutorialCompleteHandler);
               }
               _currentNoviceTutorial.dispose();
               _currentNoviceTutorial = null;
            }
            _loc3_ = DisplayLoader.Context.applicationDomain.getDefinition(_loc1_.cls) as Class;
            _currentNoviceTutorial = new _loc3_() as NewbieTutorialBase;
            _currentNoviceTutorial.nid = _loc1_.nid;
            _currentNoviceTutorial.addEventListener("tutorialComplete",__tutorialCompleteHandler);
            _currentNoviceTutorial.prepare();
         }
      }
      
      public function initialize(param1:XML, param2:int) : void
      {
         var _loc5_:XMLList = null;
         var _loc4_:* = null;
         var _loc6_:int = 0;
         var _loc3_:int = 0;
         _loc5_ = param1..preload;
         for each(_loc4_ in _loc5_)
         {
            _loc6_ = int(_loc4_.@fromId);
            _loc3_ = int(_loc4_.@toId);
            if(_loc3_ > 0 && param2 >= _loc6_ && param2 <= _loc3_)
            {
               preLoad(_loc4_);
               _initialized = true;
               break;
            }
         }
      }
      
      public function preLoad(param1:XML) : void
      {
         var _loc4_:XMLList = null;
         var _loc6_:Class = null;
         var _loc5_:Object = null;
         var _loc3_:Array = [];
         if(param1)
         {
            _loc4_ = param1..resource;
            for each(var _loc2_:XML in _loc4_)
            {
               _loc3_.push(_loc2_.@url);
            }
         }
         if(_loc3_.length > 0)
         {
            _loc6_ = DisplayLoader.Context.applicationDomain.getDefinition("preload.NewbiePreload") as Class;
            _loc5_ = new _loc6_();
            _loc5_.load(_loc3_);
         }
      }
      
      private function get playerInfo() : PlayerInfo
      {
         return PlayerManager.instance.currentPlayerModel.playerInfo;
      }
   }
}

