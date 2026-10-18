package mvc.module.marry
{
   import flash.events.EventDispatcher;
   import flash.events.IEventDispatcher;
   import flash.geom.Point;
   import flash.utils.Dictionary;
   import yishi.datas.VersionSwitch;
   import yishi.datas.playerinfo.PlayerInfo;
   import yishi.datas.playerinfo.PlayerModel;
   import yishi.datas.playerinfo.ThaneInfo;
   import yishi.datas.templates.ConfigInfosTempInfo;
   import yishi.datas.templates.MarryQualityData;
   import yishi.datas.templates.OfferRewardConditionTemplate;
   import yishi.manager.ArmyManager;
   import yishi.manager.FrameControllerManager;
   import yishi.manager.PlayerManager;
   import yishi.manager.TempleteManager;
   import yishi.utils.SimpleDictionary;
   import yishi.utils.StringHelper;
   
   public class MarryModel extends EventDispatcher
   {
      
      public static const QUEST:String = "QUEST";
      
      public static const RECEIVE:String = "RECEIVE";
      
      public static const SUCCEED:String = "SUCCEED";
      
      public static const QUALITY_SELECT:String = "QUALITY_SELECT";
      
      public static const QUALITY_CONFIRM:String = "QUALITY_CONFIRM";
      
      public static const ROOM_LIST:String = "ROOM_LIST";
      
      public static const WEDDING_SET:String = "WEDDING_SET";
      
      public static const WEDDING_INVATE:String = "WEDDING_INVATE";
      
      public static const RING_UPGRADE:String = "RING_UPGRADE";
      
      public static const TREE_FOSTER:String = "TREE_FOSTER";
      
      public static const TASK_MAP:String = "TASK_MAP";
      
      public static const HEART:String = "HEART";
      
      public static const MARRY_TRAIN:String = "MARRY_TRAIN";
      
      public static const SEARCH_MATE:String = "SEARCH_MATE";
      
      public static const PROPOSE_RING:int = 208033;
      
      public static const ETERNAL:int = 208036;
      
      public static const RING_ADVANCE_TEMPLATEID:int = 208058;
      
      public static const MARRY_CAR_NODE_ID:int = 21;
      
      public static const MARRY_NPC_NODE_ID:int = 22;
      
      private var _selfMarryInfo:MarryInfo;
      
      private var _proposeDic:Dictionary;
      
      private var _guestDic:Dictionary;
      
      private var _weddingInfo:MarryWeddingInfo;
      
      private var _roomDic:Dictionary;
      
      private var _carList:Vector.<MarryCarInfo>;
      
      private var _carUserIdDic:Dictionary;
      
      private var _carAiList:Vector.<MarryCarAi>;
      
      private var _hasAccessList:SimpleDictionary;
      
      public var endPos1:int;
      
      public var endPos2:int;
      
      public var refreshTreeAlter:Boolean;
      
      private var _kiloRoomNum:int;
      
      private var _roomInfo:MarryRoomInfo;
      
      private var _marriageData:MarriageData;
      
      private var _isDivorce:Boolean;
      
      public var marriangeState:int;
      
      public var lockScreen:Boolean;
      
      public var curCarShowNum:int;
      
      public var isHeartAnswer:Boolean;
      
      public var needShine:Boolean = true;
      
      private var _len:int;
      
      public function MarryModel(param1:IEventDispatcher = null)
      {
         super(param1);
      }
      
      public function get carUserIdDic() : Dictionary
      {
         if(_carUserIdDic == null)
         {
            _carUserIdDic = new Dictionary();
         }
         return _carUserIdDic;
      }
      
      public function get roomInfo() : MarryRoomInfo
      {
         return _roomInfo;
      }
      
      public function get hasAccessList() : SimpleDictionary
      {
         if(!_hasAccessList)
         {
            _hasAccessList = new SimpleDictionary();
         }
         return _hasAccessList;
      }
      
      public function get carList() : Vector.<MarryCarInfo>
      {
         if(_carList == null)
         {
            _carList = new Vector.<MarryCarInfo>();
         }
         return _carList;
      }
      
      public function get kiloRoomNum() : int
      {
         return _kiloRoomNum;
      }
      
      public function get roomDic() : Dictionary
      {
         if(_roomDic == null)
         {
            _roomDic = new Dictionary();
         }
         return _roomDic;
      }
      
      public function get weddingInfo() : MarryWeddingInfo
      {
         if(_weddingInfo == null)
         {
            _weddingInfo = new MarryWeddingInfo();
         }
         return _weddingInfo;
      }
      
      public function get isWeddingMaster() : Boolean
      {
         return playerInfo.userId == weddingInfo.userIdA || playerInfo.userId == weddingInfo.userIdB;
      }
      
      public function get guestDic() : Dictionary
      {
         if(!_guestDic)
         {
            _guestDic = new Dictionary();
         }
         return _guestDic;
      }
      
      public function get isSingle() : Boolean
      {
         return selfMarryInfo.userId == 0 || selfMarryInfo.state == 2 || selfMarryInfo.state == 4;
      }
      
      public function get isEngaged() : Boolean
      {
         return selfMarryInfo.userId != 0 && selfMarryInfo.state == 1;
      }
      
      public function get isMarry() : Boolean
      {
         return selfMarryInfo.userId != 0 && selfMarryInfo.state == 3;
      }
      
      public function get isDivorce() : Boolean
      {
         return _isDivorce;
      }
      
      public function set isDivorce(param1:Boolean) : void
      {
         _isDivorce = param1;
      }
      
      public function get isEnEngaged() : Boolean
      {
         return selfMarryInfo.state == 2;
      }
      
      public function get proposeDic() : Dictionary
      {
         if(!_proposeDic)
         {
            _proposeDic = new Dictionary();
         }
         return _proposeDic;
      }
      
      public function get proposeNum() : int
      {
         return _len;
      }
      
      public function get selfMarryInfo() : MarryInfo
      {
         if(!_selfMarryInfo)
         {
            _selfMarryInfo = new MarryInfo();
         }
         return _selfMarryInfo;
      }
      
      public function get marriageData() : MarriageData
      {
         if(_marriageData == null)
         {
            _marriageData = new MarriageData();
         }
         return _marriageData;
      }
      
      public function set marriageData(param1:MarriageData) : void
      {
         _marriageData = param1;
      }
      
      private function get playerInfo() : PlayerInfo
      {
         return PlayerManager.instance.currentPlayerModel.playerInfo;
      }
      
      public function updateProposeLen() : void
      {
         _len = 0;
         for each(var _loc1_:MarryProposeInfo in proposeDic)
         {
            _len = _len + 1;
         }
      }
      
      public function updateProposeList(param1:MarryProposeInfo) : void
      {
         if(param1 == null)
         {
            return;
         }
         if(!param1.property1)
         {
            if(proposeDic[param1.userIdA])
            {
               delete proposeDic[param1.userIdA];
            }
            if(param1.property7 == 1)
            {
               FrameControllerManager.instance.openControllerByInfo("marry","QUALITY_SELECT");
            }
         }
         else
         {
            proposeDic[param1.userIdA] = param1;
         }
      }
      
      public function updateGuestDic(param1:MarryGuestInfo) : void
      {
         if(param1 == null)
         {
            return;
         }
         if(!param1.property1)
         {
            if(guestDic[param1.userIdA])
            {
               delete guestDic[param1.userIdA];
            }
         }
         else
         {
            guestDic[param1.userIdA] = param1;
         }
      }
      
      public function updateRoomDic(param1:MarryRoomInfo) : void
      {
         if(param1 == null)
         {
            return;
         }
         if(param1.property6 == 0)
         {
            if(roomDic[param1.userIdA + "_" + param1.userIdB])
            {
               if(param1.property2 == 1)
               {
                  _kiloRoomNum = _kiloRoomNum - 1;
               }
               delete roomDic[param1.userIdA + "_" + param1.userIdB];
               if(playerInfo.userId == param1.userIdA || playerInfo.userId == param1.userIdB)
               {
                  _roomInfo = null;
               }
            }
         }
         else if(param1.property6 == 1)
         {
            if(!roomDic[param1.userIdA + "_" + param1.userIdB] && param1.property2 == 1)
            {
               _kiloRoomNum = _kiloRoomNum + 1;
            }
            roomDic[param1.userIdA + "_" + param1.userIdB] = param1;
            if(playerInfo.userId == param1.userIdA || playerInfo.userId == param1.userIdB)
            {
               _roomInfo = param1;
            }
         }
      }
      
      public function updateCarList(param1:MarryCarInfo) : void
      {
         var _loc2_:Boolean = false;
         var _loc6_:int = 0;
         var _loc8_:Array = null;
         var _loc4_:Array = null;
         var _loc10_:Point = null;
         var _loc9_:int = 0;
         var _loc5_:MarryCarAi = null;
         var _loc7_:int = 0;
         if(param1 == null)
         {
            return;
         }
         var _loc3_:int = int(carList.length);
         if(param1.isExist)
         {
            _loc2_ = true;
            _loc6_ = 0;
            while(_loc6_ < _loc3_)
            {
               if(carList[_loc6_].userIdA == param1.userIdA && carList[_loc6_].userIdB == param1.userIdB)
               {
                  _loc2_ = false;
               }
               _loc6_++;
            }
            if(_loc2_)
            {
               _loc8_ = param1.property4.split("|");
               _loc9_ = 0;
               while(_loc9_ < _loc8_.length)
               {
                  _loc4_ = _loc8_[_loc9_].split(",");
                  _loc10_ = new Point();
                  _loc10_.x = _loc4_[0];
                  _loc10_.y = _loc4_[1];
                  param1.pathInfo.push(_loc10_);
                  _loc9_++;
               }
               if(param1.pathInfo.length > 0)
               {
                  if(!_carAiList)
                  {
                     _carAiList = new Vector.<MarryCarAi>();
                  }
                  _loc5_ = new MarryCarAi();
                  _loc5_.info = param1;
                  if(playerInfo.userId == param1.userIdA || playerInfo.userId == param1.userIdB)
                  {
                     carList.unshift(param1);
                     _carAiList.unshift(_loc5_);
                  }
                  else
                  {
                     carList.push(param1);
                     _carAiList.push(_loc5_);
                  }
                  carUserIdDic[param1.userIdA] = param1.userIdA;
                  carUserIdDic[param1.userIdB] = param1.userIdB;
               }
            }
         }
         else
         {
            delete carUserIdDic[param1.userIdA];
            delete carUserIdDic[param1.userIdB];
            if(playerInfo.userId == param1.userIdA || playerInfo.userId == param1.userIdB)
            {
               lockScreen = false;
            }
            _loc7_ = 0;
            while(_loc7_ < _carAiList.length)
            {
               if(_carAiList[_loc7_].info == param1)
               {
                  if(_carAiList && _carAiList[_loc7_])
                  {
                     _carAiList.splice(_loc7_,1);
                     _loc7_ = 0;
                  }
               }
               _loc7_++;
            }
         }
      }
      
      public function get canAddCake() : Boolean
      {
         return isWeddingMaster && weddingInfo.property6 == 0 && weddingInfo.property2 == 3;
      }
      
      public function get canAddBubbly() : Boolean
      {
         return isWeddingMaster && weddingInfo.property3 == 0 && weddingInfo.property2 == 3;
      }
      
      public function get canFetchFlower() : Boolean
      {
         var _loc1_:Boolean = false;
         if(isWeddingMaster && weddingInfo.property2 == 3)
         {
            if(playerInfo.userId == weddingInfo.userIdA)
            {
               _loc1_ = weddingInfo.property7 == 0;
            }
            else if(playerInfo.userId == weddingInfo.userIdB)
            {
               _loc1_ = weddingInfo.property8 == 0;
            }
         }
         return _loc1_;
      }
      
      public function get canAddSweet() : Boolean
      {
         return isWeddingMaster && weddingInfo.property2 == 3 && !weddingInfo.property1;
      }
      
      public function get canBuyFirework() : Boolean
      {
         return weddingInfo.property2 == 3;
      }
      
      public function get canHandGift() : Boolean
      {
         return !isWeddingMaster && weddingInfo.property2 == 3 && weddingInfo.property4 == "0";
      }
      
      public function get canHandPoint() : Boolean
      {
         return VersionSwitch.MarryPoint && !isWeddingMaster && weddingInfo.property2 == 3 && isCandandPoint;
      }
      
      public function get isCandandPoint() : Boolean
      {
         return weddingInfo.property9 == 3 && weddingInfo.property10 < 1 || weddingInfo.property9 == 2 && weddingInfo.property10 < 2 || weddingInfo.property9 == 1 && weddingInfo.property10 < 3;
      }
      
      public function get canBuyQuality() : Boolean
      {
         return !isSingle && selfMarryInfo.speTemplateId == 0 && !_roomInfo;
      }
      
      public function get canCreateWedding() : Boolean
      {
         return !isSingle && !_roomInfo;
      }
      
      public function get canEnterWedding() : Boolean
      {
         return thane.grades > 30;
      }
      
      public function get canDivorce() : Boolean
      {
         return isMarry && !_roomInfo;
      }
      
      public function get canCancleEngaged() : Boolean
      {
         return isEngaged && !_roomInfo;
      }
      
      private function get thane() : ThaneInfo
      {
         return ArmyManager.instance.thane;
      }
      
      public function getMarryTask() : MarryTask
      {
         return hasAccessList.getList()[0];
      }
      
      public function getTalkTaskNPCNode() : int
      {
         var _loc3_:MarryTask = getMarryTask();
         if(!_loc3_)
         {
            return -999;
         }
         var _loc1_:Array = _loc3_.marryTaskTemp.conditionList;
         var _loc2_:OfferRewardConditionTemplate = _loc1_[0];
         if(_loc2_.CondictionType == 16)
         {
            return _loc2_.Para1;
         }
         return -999;
      }
      
      public function get canRideCar() : Boolean
      {
         var _loc1_:MarryQualityData = null;
         var _loc2_:Boolean = false;
         if(roomInfo)
         {
            _loc1_ = TempleteManager.instance.getMarryQualityTemplateCate.getTempById(roomInfo.property7);
            if(_loc1_ && !StringHelper.isNullOrEmpty(_loc1_.Path))
            {
               _loc2_ = true;
            }
         }
         return _loc2_;
      }
      
      public function get canAccessTask() : Boolean
      {
         var _loc2_:ConfigInfosTempInfo = TempleteManager.instance.getConfigInfoByConfigName("marriage_task_count");
         var _loc1_:int = 10;
         if(_loc2_)
         {
            _loc1_ = int(_loc2_.ConfigValue);
         }
         return isMarry && _loc1_ - selfMarryInfo.questCount > 0 && hasAccessList.getList().length <= 0;
      }
      
      public function get canAnswer() : Boolean
      {
         var _loc2_:ConfigInfosTempInfo = TempleteManager.instance.getConfigInfoByConfigName("mar_heart_count");
         var _loc1_:int = 1;
         if(_loc2_)
         {
            _loc1_ = int(_loc2_.ConfigValue);
         }
         return isMarry && _loc1_ - selfMarryInfo.answerNum > 0;
      }
      
      public function getMarryQualityCosts(param1:int) : int
      {
         var _loc3_:MarryQualityData = TempleteManager.instance.getMarryQualityTemplateCate.getTempById(param1);
         if(!_loc3_)
         {
            return 0;
         }
         var _loc2_:int = int(selfMarryInfo.marriageTime) + 259200 - playerModel.sysCurTimeBySecond;
         var _loc4_:int = selfMarryInfo.isBackPlayerFirstMarried ? 2 : 1;
         if(_loc2_ <= 0)
         {
            return _loc3_.Points / _loc4_;
         }
         return Math.ceil(_loc3_.Points * _loc3_.Discount / 100 / _loc4_);
      }
      
      private function get playerModel() : PlayerModel
      {
         return PlayerManager.instance.currentPlayerModel;
      }
   }
}

