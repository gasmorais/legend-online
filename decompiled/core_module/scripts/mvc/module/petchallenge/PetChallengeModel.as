package mvc.module.petchallenge
{
   import com.pickgliss.loader.LoaderManagerII;
   import com.pickgliss.loader.data.LoaderInfo;
   import flash.display.DisplayObject;
   import flash.display.MovieClip;
   import flash.events.Event;
   import flash.events.EventDispatcher;
   import flash.system.ApplicationDomain;
   import flash.utils.Dictionary;
   import mvc.module.pet.PetData;
   import yishi.datas.ConfigInfoManager;
   import yishi.datas.playerinfo.BuildingOrderInfo;
   import yishi.datas.playerinfo.PlayerInfo;
   import yishi.manager.FrameControllerManager;
   import yishi.manager.PathManager;
   import yishi.manager.PlayerManager;
   import yishi.utils.DateFormatter;
   import yishi.utils.StringHelper;
   
   public class PetChallengeModel extends EventDispatcher
   {
      
      public static const RANK_WEEK:int = 2;
      
      public static const STATUS_HAS:int = 0;
      
      public static const STATUS_GET:int = 1;
      
      public static const STATUS_NONE:int = 2;
      
      public static var CHALLENGE_INFO_CHAGNE:String = "CHALLENGE_INFO_CHAGNE";
      
      public static var CHALLENGE_TIME_CHANGE:String = "CHALLENGE_TIME_CHANGE";
      
      public static var FRAME_INDEX_CHANGE:String = "FRAME_INDEX_CHANGE";
      
      public static var SORT_LIST_REFRESH:String = "SORT_LIST_REFRESH";
      
      private var _weekInfo:Object;
      
      public var groupArr:Array;
      
      public var sortList:Array;
      
      public var reportList:Array;
      
      public var challengeList:Array;
      
      private var _selfInfo:PetChallengeObjectData;
      
      public var buildingOrder:BuildingOrderInfo;
      
      public var formationString:String;
      
      public var weekResiPointArr:Array;
      
      private var _curSelectIndex:int;
      
      public var challengeMaxCount:int;
      
      public var nextRefreshTime:Number;
      
      private var _applicationDomain:ApplicationDomain;
      
      private var _applicationMap:Dictionary;
      
      private var _loadedUrl:Array;
      
      private var resiIndexArr:Array = [101,104,106,103,102,105,117,118,119];
      
      public function PetChallengeModel()
      {
         super();
         sortList = [];
         challengeList = [];
         reportList = [];
         weekResiPointArr = [];
         buildingOrder = new BuildingOrderInfo();
         _applicationDomain = new ApplicationDomain(ApplicationDomain.currentDomain);
         _applicationMap = new Dictionary();
         _loadedUrl = [];
         groupArr = ConfigInfoManager.instance.getPetChallengeGroupArr();
         challengeMaxCount = ConfigInfoManager.instance.getPetChallengeMaxCount();
      }
      
      public function get selfInfo() : PetChallengeObjectData
      {
         if(_selfInfo == null)
         {
            _selfInfo = new PetChallengeObjectData();
         }
         return _selfInfo;
      }
      
      public function get petChallengeFormationOfArray() : Array
      {
         if(formationString)
         {
            return formationString.split(",");
         }
         return [];
      }
      
      public function getInstanceByPath(param1:String, param2:int = 0) : Object
      {
         var _loc4_:Class = null;
         var _loc3_:* = null;
         switch(param2)
         {
            case 0:
               _loc4_ = ApplicationDomain(_applicationMap[param1]).getDefinition("ClassExport") as Class;
               break;
            default:
               _loc4_ = ApplicationDomain(_applicationMap[param1]).getDefinition("ClassExport" + param2) as Class;
         }
         return new _loc4_();
      }
      
      public function getInstanceByDefinition(param1:String) : Object
      {
         var _loc3_:Class = getDefinition(param1);
         if(!_loc3_)
         {
            _loc3_ = MovieClip;
         }
         return new _loc3_();
      }
      
      private function getDefinition(param1:String) : Class
      {
         var _loc2_:Class = null;
         if(_applicationDomain.hasDefinition(param1))
         {
            _loc2_ = _applicationDomain.getDefinition(param1) as Class;
         }
         return _loc2_;
      }
      
      public function addSingleClassResourcePath(param1:String) : void
      {
         param1 = param1.toLowerCase();
         if(_applicationMap[param1])
         {
            return;
         }
         var _loc2_:ApplicationDomain = new ApplicationDomain(_applicationDomain);
         _applicationMap[param1] = _loc2_;
      }
      
      public function addMultiClassResourcePath(param1:String) : void
      {
         param1 = param1.toLowerCase();
         if(_applicationMap[param1])
         {
            return;
         }
         _applicationMap[param1] = _applicationDomain;
      }
      
      public function getDomainByPaty(param1:String) : ApplicationDomain
      {
         return _applicationMap[param1];
      }
      
      public function isLoaded(param1:String) : Boolean
      {
         return _loadedUrl.indexOf(param1) < 0 ? false : true;
      }
      
      public function get weekInfo() : Object
      {
         return _weekInfo;
      }
      
      public function set weekInfo(param1:Object) : void
      {
         _weekInfo = param1;
      }
      
      public function getGroupIdByRankAndScore(param1:int, param2:int, param3:Boolean = true) : int
      {
         var _loc6_:int = 0;
         var _loc5_:int = 2;
         var _loc4_:int = int(groupArr.length);
         if(param2 <= 0 || !groupArr)
         {
            return 6;
         }
         if(param1 == 1 && param3)
         {
            return 1;
         }
         _loc6_ = _loc4_ - 1;
         while(_loc6_ >= 0)
         {
            if(param2 >= groupArr[_loc6_])
            {
               return _loc5_;
            }
            if(++_loc5_ >= 6)
            {
               return 6;
            }
            _loc6_--;
         }
         return 6;
      }
      
      public function getGroupIdByScore(param1:int) : int
      {
         var _loc4_:int = 0;
         var _loc3_:int = 2;
         var _loc2_:int = int(groupArr.length);
         if(param1 <= 0 || !groupArr)
         {
            return 6;
         }
         _loc4_ = _loc2_ - 1;
         while(_loc4_ >= 0)
         {
            if(param1 >= groupArr[_loc4_])
            {
               return _loc3_;
            }
            if(++_loc3_ >= 6)
            {
               return 6;
            }
            _loc4_--;
         }
         return 6;
      }
      
      public function get groupScoreArr() : Array
      {
         var _loc3_:int = 0;
         var _loc5_:String = null;
         var _loc4_:Array = [];
         var _loc1_:int = int(groupArr.length);
         var _loc2_:int = 200;
         _loc3_ = 0;
         while(_loc3_ < _loc1_)
         {
            _loc5_ = _loc2_ + "-" + (int(groupArr[_loc3_] - 1));
            _loc4_.push(_loc5_);
            _loc2_ = int(groupArr[_loc3_]);
            _loc3_++;
         }
         _loc4_.push(groupArr[_loc1_ - 1] + "+");
         _loc4_.reverse();
         return _loc4_;
      }
      
      public function getPetChallengeTeamList() : Array
      {
         var _loc3_:PetData = null;
         var _loc2_:Array = [];
         for each(var _loc1_:String in playerInfo.petChallengeFormationOfArray)
         {
            if(_loc1_)
            {
               _loc3_ = playerInfo.getPet(int(_loc1_));
               if(_loc3_)
               {
                  _loc2_.push(_loc3_);
               }
            }
         }
         _loc2_.sortOn("fightPower",0x10 | 2);
         return _loc2_;
      }
      
      public function getAddPointByIndex(param1:int) : int
      {
         if(weekResiPointArr.length <= 0)
         {
            return 0;
         }
         return weekResiPointArr[param1 - 1];
      }
      
      public function checkSize(param1:int) : int
      {
         var _loc4_:Array = weekResiPointArr.slice().sort();
         var _loc2_:int = int(_loc4_[0]);
         var _loc3_:int = int(_loc4_[_loc4_.length - 1]);
         if(_loc3_ == _loc2_)
         {
            return 3;
         }
         if(param1 == _loc2_)
         {
            return 1;
         }
         if(param1 == _loc3_)
         {
            return 3;
         }
         return 2;
      }
      
      public function loadSortData() : void
      {
         var _loc1_:String = PathManager.petChallengSortPath();
         LoaderManagerII.instance.load(_loc1_,5,8,__onSortDataLoaded,null,__onSortDataLoaded);
      }
      
      public function clearSortLoad() : void
      {
         LoaderManagerII.instance.clearLoaderInfoByCompleteFunction(__onSortDataLoaded);
      }
      
      private function __onSortDataLoaded(param1:LoaderInfo, param2:Object) : void
      {
         if(FrameControllerManager.instance.petchallengeController.frame.isDie)
         {
            return;
         }
         resolveXML(new XML(param2));
      }
      
      private function resolveXML(param1:XML) : void
      {
         var _loc4_:XMLList = null;
         var _loc2_:* = null;
         var _loc3_:PetChallengeObjectData = null;
         var _loc6_:PetData = null;
         var _loc5_:XML = param1;
         if(StringHelper.isNullOrEmpty(_loc5_.@createDate) == false)
         {
            nextRefreshTime = int(DateFormatter.parse(_loc5_.@createDate,"YYYY-MM-DD hh:mm:ss").time / 1000) + 1800;
         }
         _loc4_ = _loc5_..CrossPetScoreRank;
         sortList.splice(0);
         for each(_loc2_ in _loc4_)
         {
            _loc3_ = new PetChallengeObjectData();
            _loc3_.isSelf = false;
            _loc3_.uuid = _loc2_.@uuid;
            _loc3_.userId = int(_loc2_.@userid);
            _loc3_.userName = _loc2_.@nickName;
            _loc3_.serverName = _loc2_.@serverName;
            _loc3_.score = int(_loc2_.@score);
            _loc3_.ranking = int(_loc2_.@rank);
            _loc3_.fightCapacity = int(_loc2_.@fightCapacity);
            _loc6_ = createWithXml(_loc2_.@Pet1);
            if(_loc6_)
            {
               _loc3_.petList.push(_loc6_);
            }
            _loc6_ = createWithXml(_loc2_.@Pet2);
            if(_loc6_)
            {
               _loc3_.petList.push(_loc6_);
            }
            _loc6_ = createWithXml(_loc2_.@Pet3);
            if(_loc6_)
            {
               _loc3_.petList.push(_loc6_);
            }
            sortList.push(_loc3_);
         }
         sortList.sortOn("ranking",16);
         dispatchEvent(new Event(PetChallengeModel.SORT_LIST_REFRESH));
      }
      
      private function createWithXml(param1:String) : PetData
      {
         if(StringHelper.isNullOrEmpty(param1))
         {
            return null;
         }
         var _loc2_:Array = param1.split(",");
         if(_loc2_.length < 5)
         {
            return null;
         }
         var _loc3_:PetData = new PetData();
         _loc3_.templateId = int(_loc2_[0]);
         _loc3_.name = _loc2_[1];
         _loc3_.grade = int(_loc2_[2]);
         _loc3_.temQuality = int(_loc2_[3]);
         if(int(_loc2_[3]) < 26)
         {
            _loc3_.quality = (int(_loc2_[3]) - 1) / 5 + 1;
         }
         else
         {
            _loc3_.quality = (int(_loc2_[3]) - 1) / 5;
         }
         _loc3_.fightPower = int(_loc2_[4]);
         return _loc3_;
      }
      
      public function getShowList() : Array
      {
         if(curSelectIndex == 0)
         {
            return sortList;
         }
         if(curSelectIndex == 1)
         {
            return challengeList;
         }
         if(curSelectIndex == 2)
         {
            return reportList;
         }
         return [];
      }
      
      public function get totalResiScore() : int
      {
         var _loc1_:int = 0;
         for each(var _loc2_:PetData in selfInfo.petList)
         {
            if(_loc2_.template.PetType == 117)
            {
               _loc1_ += int(weekResiPointArr[2]) + int(weekResiPointArr[5]);
            }
            else if(_loc2_.template.PetType == 118)
            {
               _loc1_ += int(weekResiPointArr[1]) + int(weekResiPointArr[4]);
            }
            else if(_loc2_.template.PetType == 119)
            {
               _loc1_ += int(weekResiPointArr[0]) + int(weekResiPointArr[3]);
            }
            else
            {
               _loc1_ += int(weekResiPointArr[resiIndexArr.indexOf(_loc2_.template.PetType)]);
            }
         }
         return _loc1_;
      }
      
      public function get curSelectIndex() : int
      {
         return _curSelectIndex;
      }
      
      public function set curSelectIndex(param1:int) : void
      {
         if(curSelectIndex == param1)
         {
            return;
         }
         _curSelectIndex = param1;
         dispatchEvent(new Event(PetChallengeModel.FRAME_INDEX_CHANGE));
      }
      
      private function get playerInfo() : PlayerInfo
      {
         return PlayerManager.instance.currentPlayerModel.playerInfo;
      }
      
      public function commitInfoChange() : void
      {
         dispatchEvent(new Event(PetChallengeModel.CHALLENGE_INFO_CHAGNE));
      }
      
      public function commitTimeChange() : void
      {
         dispatchEvent(new Event(PetChallengeModel.CHALLENGE_TIME_CHANGE));
      }
   }
}

