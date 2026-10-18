package battle.transaction
{
   import battle.BattleManager;
   import com.pickgliss.ui.core.Disposeable;
   import flash.utils.Dictionary;
   import manager.LanguageMgr;
   import yishi.comm.PackageIn;
   import yishi.events.SLGSocketEvent;
   import yishi.interfaces.IEnterFrame;
   import yishi.interfaces.ISocketTransaction;
   import yishi.manager.EnterFrameManager;
   import yishi.service.managers.SocketManager;
   
   public class BattleTransactionManager implements IEnterFrame, Disposeable
   {
      
      private static const maxWaitTime:int = 125;
      
      private static var _instance:BattleTransactionManager;
      
      private var _executable:Array;
      
      private var _waitlist:Array;
      
      private var _handlerList:Dictionary;
      
      private var _lastHandle:ISocketTransaction;
      
      public function BattleTransactionManager()
      {
         super();
      }
      
      public static function getInstance() : BattleTransactionManager
      {
         if(!_instance)
         {
            _instance = new BattleTransactionManager();
         }
         return _instance;
      }
      
      public function setup() : void
      {
         _waitlist = [];
         _executable = [];
         _handlerList = new Dictionary();
         registerAllHandler();
         EnterFrameManager.instance.registeEnterFrame(this);
         SocketManager.instance.addEventListener("GAME_CMD",__gameCmdHandler);
      }
      
      public function uninstall() : void
      {
         _waitlist = null;
         _executable = null;
         _handlerList = null;
         EnterFrameManager.instance.unRegisteEnterFrame(this);
         SocketManager.instance.removeEventListener("GAME_CMD",__gameCmdHandler);
      }
      
      private function __gameCmdHandler(param1:SLGSocketEvent) : void
      {
         addQueue(param1.data as PackageIn);
      }
      
      public function addHandler(param1:ISocketTransaction) : void
      {
         if(!_handlerList[param1.getCode()])
         {
            _handlerList[param1.getCode()] = param1;
         }
      }
      
      public function enterFrame() : void
      {
         var _loc5_:PackageIn = null;
         var _loc3_:int = 0;
         var _loc1_:String = null;
         var _loc2_:ISocketTransaction = null;
         var _loc4_:int = 0;
         BattleManager.getInstance().battleNextFrame();
         _loc3_ = 0;
         while(_loc3_ < _waitlist.length)
         {
            _loc5_ = _waitlist[_loc3_] as PackageIn;
            if(_loc5_.extend2 > 0 && _loc5_.code == 5)
            {
               _loc1_ = LanguageMgr.GetTranslation("battle.transaction.BattleTransactionManager.Error");
               throw new Error(_loc1_);
            }
            if(_loc5_.extend2 <= BattleManager.getInstance().BattleFrameCount)
            {
               _executable.push(_loc5_);
               _waitlist.splice(_loc3_,1);
               break;
            }
            _loc3_++;
         }
         _loc4_ = 0;
         while(_loc4_ < _executable.length)
         {
            _loc5_ = _executable[_loc4_] as PackageIn;
            _loc2_ = _handlerList[_loc5_.code] as ISocketTransaction;
            if(_loc2_)
            {
               _loc2_.configure(_loc5_);
               _loc2_.handlePackage();
            }
            _loc4_++;
         }
         _lastHandle = _loc2_;
         _executable = [];
      }
      
      public function addQueue(param1:PackageIn) : void
      {
         _waitlist.push(param1);
      }
      
      public function dispose() : void
      {
         EnterFrameManager.instance.unRegisteEnterFrame(this);
         SocketManager.instance.removeEventListener("GAME_CMD",__gameCmdHandler);
         _executable = null;
         _waitlist = null;
      }
      
      private function registerAllHandler() : void
      {
         addHandler(new BattleGoddessMovieTransaction());
         addHandler(new BattleAttackTransaction());
         addHandler(new BattleAwakenTransaction());
         addHandler(new BattleAvengerSpTransaction());
         addHandler(new BattleChildChangeTransaction());
         addHandler(new BattleStartTransaction());
         addHandler(new ReinfoTransaction());
         addHandler(new SwapTransaction());
         addHandler(new ReviveTransaction());
         addHandler(new ReinfoResTransaction());
         addHandler(new BattleStopTransaction());
         addHandler(new AttackModeTransaction());
         addHandler(new BattleNoticeTransaction());
         addHandler(new BattleAvengerSkillChangeTransaction());
         addHandler(new BattleWarsoulSpTransaction());
      }
   }
}

