package mvc.module.fish
{
   import events.FishEvent;
   import flash.events.EventDispatcher;
   import flash.system.ApplicationDomain;
   import flash.system.LoaderContext;
   import flash.utils.Dictionary;
   import yishi.datas.playerinfo.PlayerModel;
   import yishi.manager.PlayerManager;
   import yishi.utils.SimpleDictionary;
   
   public class FishModel extends EventDispatcher
   {
      
      public static const FISH_FORK_SPEED:int = 6;
      
      public static const FISHMAX:int = 20;
      
      public static const FISHTOOLCOUNT:int = 4;
      
      public static const FISHPOOLWIDTH:int = 830;
      
      private static var _loaderContext:LoaderContext;
      
      public static const FISHCHANNEL:Array = [80,160,220,280,340];
      
      private var _fishPoolInfo:FishPoolInfo;
      
      private var _fishSigsModel:SimpleDictionary;
      
      private var _canFishArray:Array;
      
      private var _fishResult:Array;
      
      private var _fishForkInfo:FishForkInfo;
      
      private var _leftForkInfo:FishForkInfo;
      
      private var _rightForkInfo:FishForkInfo;
      
      private var _orderList:Vector.<FishOrderInfo>;
      
      private var _playerList:Vector.<FishPlayerInfo>;
      
      private var _fishForkList:Vector.<FishForkInfo>;
      
      private var _helpSuccess:Boolean;
      
      private var _classDic:Dictionary;
      
      private var _rage:Boolean;
      
      private var _powerOver:Boolean;
      
      private var _threeOver:Boolean;
      
      private var _threeCount:int;
      
      private var _toolFlag:Boolean = true;
      
      private var _isRageSuccess:Boolean;
      
      private var _isRageReward:Boolean;
      
      private var _isPointHelp:Boolean;
      
      public var fishRefuseInvitation:Boolean;
      
      public var fishRefuseInvite:Boolean;
      
      public var fishRefuseTeamInvite:Boolean;
      
      public function FishModel()
      {
         super();
         _fishPoolInfo = new FishPoolInfo();
         _fishSigsModel = new SimpleDictionary();
         _canFishArray = [];
         _fishResult = [];
         _orderList = new Vector.<FishOrderInfo>();
         _playerList = new Vector.<FishPlayerInfo>();
         _fishForkList = new Vector.<FishForkInfo>();
         _classDic = new Dictionary();
         initFishForkList();
      }
      
      public static function get loaderContext() : LoaderContext
      {
         if(!_loaderContext)
         {
            _loaderContext = new LoaderContext(false,new ApplicationDomain(ApplicationDomain.currentDomain));
         }
         return _loaderContext;
      }
      
      public static function set loaderContext(param1:LoaderContext) : void
      {
         _loaderContext = param1;
      }
      
      private function initFishForkList() : void
      {
         _fishForkList.length = 0;
         if(_fishForkInfo)
         {
            _fishForkInfo = null;
         }
         if(_leftForkInfo)
         {
            _leftForkInfo = null;
         }
         if(_rightForkInfo)
         {
            _rightForkInfo = null;
         }
         _fishForkInfo = new FishForkInfo();
         _leftForkInfo = new FishForkInfo();
         _rightForkInfo = new FishForkInfo();
         _fishForkList.push(_fishForkInfo);
         _fishForkList.push(_leftForkInfo);
         _fishForkList.push(_rightForkInfo);
      }
      
      public function clean() : void
      {
         initFishForkList();
         fishPoolInfo.userId = playermodel.userInfo.userId;
         fishSigsModel.clear();
         playerList.length = 0;
         initConst();
      }
      
      public function initConst() : void
      {
         toolFlag = true;
         isRageSuccess = false;
         rage = false;
         isPointHelp = false;
         isRageReward = false;
      }
      
      public function get fishSigsModel() : SimpleDictionary
      {
         return _fishSigsModel;
      }
      
      public function set fishSigsModel(param1:SimpleDictionary) : void
      {
         _fishSigsModel = param1;
      }
      
      public function get canFishArray() : Array
      {
         return _canFishArray;
      }
      
      public function get orderList() : Vector.<FishOrderInfo>
      {
         return _orderList;
      }
      
      public function get playerList() : Vector.<FishPlayerInfo>
      {
         return _playerList;
      }
      
      public function get fishForkList() : Vector.<FishForkInfo>
      {
         return _fishForkList;
      }
      
      public function get fishResult() : Array
      {
         return _fishResult;
      }
      
      public function set fishResult(param1:Array) : void
      {
         _fishResult = param1;
      }
      
      public function get fishForkInfo() : FishForkInfo
      {
         return _fishForkInfo;
      }
      
      public function set fishForkInfo(param1:FishForkInfo) : void
      {
         _fishForkInfo = param1;
      }
      
      public function get leftForkInfo() : FishForkInfo
      {
         return _leftForkInfo;
      }
      
      public function set leftForkInfo(param1:FishForkInfo) : void
      {
         _leftForkInfo = param1;
      }
      
      public function get rightForkInfo() : FishForkInfo
      {
         return _rightForkInfo;
      }
      
      public function set rightForkInfo(param1:FishForkInfo) : void
      {
         _rightForkInfo = param1;
      }
      
      public function setForkState(param1:int, param2:int) : void
      {
         if(param1 < fishForkList.length)
         {
            fishForkList[param1].state = param2;
         }
      }
      
      public function setAllForkState(param1:int) : void
      {
         _fishForkInfo.state = param1;
         _leftForkInfo.state = param1;
         _rightForkInfo.state = param1;
      }
      
      public function isForkState(param1:int) : Boolean
      {
         return _fishForkInfo.state == param1;
      }
      
      public function commit() : void
      {
         dispatchEvent(new FishEvent("UPDATE_FISH_POOL"));
      }
      
      public function updateOrderList() : void
      {
         dispatchEvent(new FishEvent("ORDERDATA_LOAD_COMPLETE"));
      }
      
      public function helpOver() : void
      {
         dispatchEvent(new FishEvent("HELP_OVER"));
      }
      
      public function rageOver() : void
      {
         dispatchEvent(new FishEvent("TIME_OVER"));
      }
      
      public function pointHelp() : void
      {
         dispatchEvent(new FishEvent("POINT_HELP"));
      }
      
      private function get playermodel() : PlayerModel
      {
         return PlayerManager.instance.currentPlayerModel;
      }
      
      public function get fishPoolInfo() : FishPoolInfo
      {
         return _fishPoolInfo;
      }
      
      public function set fishPoolInfo(param1:FishPoolInfo) : void
      {
         _fishPoolInfo = param1;
      }
      
      public function get rage() : Boolean
      {
         return _rage;
      }
      
      public function set rage(param1:Boolean) : void
      {
         _rage = param1;
      }
      
      public function get powerOver() : Boolean
      {
         return _powerOver;
      }
      
      public function set powerOver(param1:Boolean) : void
      {
         _powerOver = param1;
      }
      
      public function get threeOver() : Boolean
      {
         return _threeOver;
      }
      
      public function set threeOver(param1:Boolean) : void
      {
         _threeOver = param1;
      }
      
      public function get threeCount() : int
      {
         return _threeCount;
      }
      
      public function set threeCount(param1:int) : void
      {
         _threeCount = param1;
      }
      
      public function get toolFlag() : Boolean
      {
         return _toolFlag;
      }
      
      public function set toolFlag(param1:Boolean) : void
      {
         _toolFlag = param1;
      }
      
      public function get isRageSuccess() : Boolean
      {
         return _isRageSuccess;
      }
      
      public function set isRageSuccess(param1:Boolean) : void
      {
         _isRageSuccess = param1;
      }
      
      public function get isRageReward() : Boolean
      {
         return _isRageReward;
      }
      
      public function set isRageReward(param1:Boolean) : void
      {
         _isRageReward = param1;
      }
      
      public function get isPointHelp() : Boolean
      {
         return _isPointHelp;
      }
      
      public function set isPointHelp(param1:Boolean) : void
      {
         _isPointHelp = param1;
      }
      
      public function get isSelf() : Boolean
      {
         if(fishPoolInfo.userId != 0)
         {
            return fishPoolInfo.userId == playermodel.userInfo.userId;
         }
         return false;
      }
      
      public function get helpSuccess() : Boolean
      {
         return _helpSuccess;
      }
      
      public function set helpSuccess(param1:Boolean) : void
      {
         _helpSuccess = param1;
      }
      
      public function get classDic() : Dictionary
      {
         return _classDic;
      }
   }
}

