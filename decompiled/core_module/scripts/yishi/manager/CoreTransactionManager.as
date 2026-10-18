package yishi.manager
{
   import battle.transaction.CreateGameTransaction;
   import com.road.yishi.proto.battle.BattlePrepareMsg;
   import flash.utils.Dictionary;
   import manager.LanguageMgr;
   import map.internals.transaction.CampaignOverTransaction;
   import map.internals.transaction.CampaignResultTransaction;
   import map.internals.transaction.DialogTransation;
   import map.internals.transaction.MoveCampaignSceneTransaction;
   import map.internals.transaction.OpenChestTransaction;
   import map.internals.transaction.PlayerMovieClipTransaction;
   import map.internals.transaction.SessionTransaction;
   import sandbox.transaction.SandboxOverTransaction;
   import yishi.comm.PackageIn;
   import yishi.interfaces.IEnterFrame;
   import yishi.interfaces.ISocketTransaction;
   
   public class CoreTransactionManager implements IEnterFrame
   {
      
      private static var _instance:CoreTransactionManager;
      
      private var _liftTime:int;
      
      private var _executable:Array;
      
      private var _waitlist:Array;
      
      private var _handlerList:Dictionary;
      
      private var clientPkgCount:int = 0;
      
      private var prepareCache:Dictionary = new Dictionary();
      
      public function CoreTransactionManager()
      {
         super();
         _waitlist = [];
         _executable = [];
         _handlerList = new Dictionary();
      }
      
      public static function getInstance() : CoreTransactionManager
      {
         if(!_instance)
         {
            _instance = new CoreTransactionManager();
         }
         return _instance;
      }
      
      public function setup() : void
      {
         registerAllHandler();
         EnterFrameManager.instance.registeEnterFrame(this);
      }
      
      public function addHandler(param1:ISocketTransaction) : void
      {
         if(!_handlerList[param1.getCode()])
         {
            _handlerList[param1.getCode()] = param1;
         }
      }
      
      private function removeAllHandle() : void
      {
         _handlerList = new Dictionary();
      }
      
      public function getMessage() : String
      {
         return "CoreTransactionManager : " + _waitlist.length;
      }
      
      public function enterFrame() : void
      {
         var _loc5_:PackageIn = null;
         var _loc3_:int = 0;
         var _loc1_:ISocketTransaction = null;
         var _loc4_:int = 0;
         _liftTime = _liftTime + 1;
         if(_waitlist.length > 0)
         {
            _loc3_ = _waitlist.length - 1;
            while(_loc3_ >= 0)
            {
               _loc5_ = _waitlist[_loc3_] as PackageIn;
               if(_loc5_.extend2 <= _liftTime)
               {
                  _executable.push(_loc5_);
                  _waitlist.splice(_loc3_,1);
               }
               _loc3_--;
            }
         }
         var _loc2_:String = LanguageMgr.GetTranslation("yishi.manager.CoreTransactionManager.vUnregisterProtocol");
         _loc4_ = 0;
         while(_loc4_ < _executable.length)
         {
            _loc5_ = _executable[_loc4_];
            _loc1_ = _handlerList[_loc5_.code] as ISocketTransaction;
            if(!_loc1_)
            {
               throw new Error("QueueManager" + _loc2_ + ": " + _loc5_.code);
            }
            _loc1_.configure(_loc5_);
            _loc1_.handlePackage();
            _loc4_++;
         }
         _executable.splice(0,_executable.length);
      }
      
      public function addQueue(param1:PackageIn) : void
      {
         _waitlist.push(param1);
      }
      
      public function currentTimeAddQueue(param1:PackageIn) : void
      {
         param1.updateLeftTime = param1.extend2 + liftTime;
         param1.position = 20;
         addQueue(param1);
      }
      
      public function handlerPackage(param1:PackageIn) : void
      {
         var _loc3_:* = null;
         var _loc2_:BattlePrepareMsg = null;
         var _loc5_:BattlePrepareMsg = null;
         var _loc4_:String = null;
         if(param1.code == 157)
         {
            _loc2_ = new BattlePrepareMsg();
            _loc2_ = param1.readBody(_loc2_) as BattlePrepareMsg;
            _loc4_ = _loc2_.battleId;
            if(_loc2_.totalPage > 1)
            {
               clientPkgCount = clientPkgCount + 1;
               if(_loc4_ in prepareCache)
               {
                  _loc5_ = prepareCache[_loc4_] as BattlePrepareMsg;
                  _loc5_.heros = _loc2_.heros.concat(_loc5_.heros);
                  _loc5_.children = _loc2_.children.concat(_loc5_.children);
                  _loc5_.pets = _loc2_.pets.concat(_loc5_.pets);
                  _loc5_.soldiers = _loc2_.soldiers.concat(_loc5_.soldiers);
                  _loc5_.goddesses = _loc2_.soldiers.concat(_loc5_.goddesses);
                  _loc5_.chessList = _loc2_.chessList.concat(_loc5_.chessList);
               }
               else
               {
                  prepareCache[_loc4_] = _loc2_;
               }
               if(clientPkgCount >= _loc2_.totalPage)
               {
                  clientPkgCount = 0;
                  delete prepareCache[_loc4_];
                  handlerPreparePkg(param1,_loc5_);
               }
            }
            else
            {
               handlerPreparePkg(param1,_loc2_);
            }
         }
      }
      
      private function handlerPreparePkg(param1:PackageIn, param2:BattlePrepareMsg) : void
      {
         var _loc3_:CreateGameTransaction = _handlerList[param1.code] as CreateGameTransaction;
         if(_loc3_)
         {
            _loc3_.msgPkg(param2);
            _loc3_.handlePackage();
         }
      }
      
      public function get liftTime() : int
      {
         return _liftTime;
      }
      
      private function get userId() : int
      {
         return PlayerManager.instance.currentPlayerModel.userInfo.userId;
      }
      
      private function registerAllHandler() : void
      {
         addHandler(new CreateGameTransaction());
         addHandler(new MoveCampaignSceneTransaction());
         addHandler(new PlayerMovieClipTransaction());
         addHandler(new SessionTransaction());
         addHandler(new DialogTransation());
         addHandler(new OpenChestTransaction());
         addHandler(new CampaignResultTransaction());
         addHandler(new CampaignOverTransaction());
         addHandler(new SandboxOverTransaction());
      }
   }
}

