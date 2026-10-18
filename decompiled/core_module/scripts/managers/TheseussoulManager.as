package managers
{
   import com.road.yishi.proto.collection.BoxOpenItemMsg;
   import com.road.yishi.proto.collection.CollectionDataMsg;
   import com.road.yishi.proto.collection.CollectionMsg;
   import com.road.yishi.proto.collection.CollectionRewardMsg;
   import com.road.yishi.proto.collection.RewardTask;
   import com.road.yishi.proto.player.PlayerOpMsg;
   import com.road.yishi.proto.simple.PropertyMsg;
   import com.road.yishi.proto.slate.SlateMsg;
   import com.road.yishi.proto.slate.SlatePropertyMsg;
   import com.road.yishi.proto.slate.UserSlateMsg;
   import com.road.yishi.proto.storehouse.StoreHouseAddSkillMsg;
   import com.road.yishi.proto.storehouse.StoreHouseFightMsg;
   import com.road.yishi.proto.storehouse.StoreHouseUseMsg;
   import com.road.yishi.proto.theseus.TheseusEquipListMsg;
   import com.road.yishi.proto.theseus.TheseusEquipMsg;
   import com.road.yishi.proto.theseus.TheseusPropertyMsg;
   import com.road.yishi.proto.theseus.TheseusRageListMsg;
   import com.road.yishi.proto.theseus.TheseusRageMsg;
   import com.road.yishi.proto.theseus.TheseusUserMsg;
   import com.road.yishi.proto.theseus.WarSoulHatchListMsg;
   import com.road.yishi.proto.theseus.WarSoulHatchMsg;
   import com.road.yishi.proto.theseus.WarSoulListMsg;
   import com.road.yishi.proto.theseus.WarSoulMsg;
   import com.road.yishi.proto.theseus.WarSoulRefreshMsg;
   import flash.events.Event;
   import flash.events.EventDispatcher;
   import mvc.module.raveparty.RavePartyRewardInfo;
   import mvc.module.theseus.TheseusCollenTionModel;
   import mvc.module.theseus.TheseusGodheadModel;
   import mvc.module.theseus.TheseusGodheadStoneInfo;
   import mvc.module.theseus.TheseusWarRfineInfo;
   import mvc.module.theseus.TheseusWarsoulHatchInfo;
   import mvc.module.theseus.TheseusWarsoulItemInfo;
   import mvc.module.theseus.TheseusYiCellInfo;
   import mvc.module.theseus.TheseussoulModel;
   import mvc.module.theseus.ThessBoxInfo;
   import mvc.module.theseus.ThessTowerInfo;
   import mvc.module.theseus.ThessboxFightInfo;
   import mvc.module.theseus.WarFrameItemInfo;
   import mvc.module.theseus.WarSoulModel;
   import yishi.comm.PackageIn;
   import yishi.comm.PackageOut;
   import yishi.datas.templates.CollectionRewardTemplateInfo;
   import yishi.datas.templates.TheseusSlateInfo;
   import yishi.events.NotificationEvent;
   import yishi.events.SLGSocketEvent;
   import yishi.manager.FrameControllerManager;
   import yishi.manager.TempleteManager;
   import yishi.service.managers.SocketManager;
   import yishi.service.managers.SocketSendManager;
   
   public class TheseussoulManager extends EventDispatcher
   {
      
      public static const EVENT_SUIT_UPDATE:String = "EVENT_SUIT_UPDATE";
      
      public static const EVENT_YI_UPDATE:String = "EVENT_YI_UPDATE";
      
      public static const EVENT_PROPERTY_UPDATE:String = "EVENT_PROPERTY_UPDATE";
      
      public static const EVENT_COLLECTION_UPDATE:String = "EVENT_COLLECTION_UPDATE";
      
      public static const EVENT_SLATE_UPDATE:String = "EVENT_SLATE_UPDATE";
      
      public static const THESEUSCOLLECTIONBOXEXCHANGE_BUY_BACK:String = "THESEUSCOLLECTIONBOXEXCHANGE_BUY_BACK";
      
      public static const EVENT_WAR_EQUIP:String = "EVENT_WAR_EQUIP";
      
      public static const EVENT_WAR_EGG:String = "EVENT_WAR_EGG";
      
      public static const EVENT_WAR_REFINE:String = "EVENT_WAR_REFINE";
      
      public static const EVENT_WAR_CHOOSE:String = "EVENT_WAR_CHOOSE";
      
      public static const EVENT_TOWER:String = "EVENT_TOWER";
      
      public static const EVENT_BOX_RANK:String = "EVENT_BOX_RANK";
      
      public static const EVENT_BOX_FIGHT:String = "EVENT_BOX_FIGHT";
      
      public static const EVENT_BOX_USER:String = "EVENT_BOX_USER";
      
      private static var _ins:TheseussoulManager;
      
      public static const OP_COLLECTION_UPGRADETASK:String = "OP_COLLECTION_UPGRADETASK";
      
      public static const OP_OPEN:int = 1;
      
      public static const OP_EQUIP:int = 2;
      
      public static const OP_UNEQUIP:int = 3;
      
      public static const OP_RAGE_STRENGTHEN:int = 4;
      
      public static const OP_CORE_STRENGTHEN:int = 5;
      
      public static const OP_TIDY_BAG:int = 6;
      
      public static const OP_WARSOUL_HATCH:int = 7;
      
      public static const OP_WARSOUL_HATCH_FAST:int = 8;
      
      public static const OP_WARSOUL_HATCH_GET:int = 9;
      
      public static const OP_WARSOUL_EQUIP:int = 10;
      
      public static const OP_WARSOUL_STAR:int = 11;
      
      public static const OP_WARSOUL_STRENGTHEN:int = 12;
      
      public static const OP_WARSOUL_REFORM:int = 13;
      
      public static const OP_WARSOUL_LEARN_SKILL:int = 14;
      
      public static const OP_WARSOUL_REFRESH:int = 15;
      
      public static const OP_WARSOUL_VIEW_REFRESH:int = 16;
      
      public static const OP_WARSOUL_REPLACE:int = 17;
      
      public static const OP_WARSOUL_DECOMPOSE:int = 18;
      
      public static const OP_WARSOUL_FIGHT:int = 19;
      
      public static const OP_WARSOUL_LEARN_SKILL_REPLACE:int = 20;
      
      public static const OP_WARSOUL_SPLIT:int = 21;
      
      public static const OP_WARSOUL_LOCK:int = 23;
      
      public static const OP_WarTIDY_BAG:int = 1;
      
      public static const OP_WarMOVE:int = 2;
      
      public static const OP_WarLOCK:int = 3;
      
      public static const OP_WarEQUIP_DECOMPOSE:int = 4;
      
      public static const OP_WarEQUIP_STRENGTHEN:int = 5;
      
      public static const OP_WarEQUIP_QUALITY:int = 6;
      
      public static const OP_WarEQUIP:int = 7;
      
      public static const OP_WarUNEQUIP:int = 8;
      
      public static const OP_WarEQUIP_STRENGTHENSTR:String = "OP_WarEQUIP_STRENGTHENSTR";
      
      public static const OP_WarEQUIP_QUALITYSTR:String = "OP_WarEQUIP_STRENGTHENSTR";
      
      public static const OP_COLLECTION_DATA:int = 1;
      
      public static const OP_COLLECTION_UPGRADE:int = 2;
      
      public static const OP_COLLECTION_UPGRADETask:int = 5;
      
      private var _model:TheseussoulModel;
      
      private var _warsoulModel:WarSoulModel;
      
      private var _warframeModel:WarSoulModel;
      
      private var _thessTowerInfo:ThessTowerInfo;
      
      private var _modelCollenTion:TheseusCollenTionModel;
      
      private var _thessboxOutInfo:ThessBoxInfo;
      
      private var _modelGodhead:TheseusGodheadModel;
      
      private var _thessboxInInfo:ThessboxFightInfo;
      
      public function TheseussoulManager()
      {
         super();
         _model = new TheseussoulModel();
         _warsoulModel = new WarSoulModel();
         _warframeModel = new WarSoulModel();
         _thessTowerInfo = new ThessTowerInfo();
         _modelCollenTion = new TheseusCollenTionModel();
         _modelGodhead = new TheseusGodheadModel();
         _thessboxOutInfo = new ThessBoxInfo();
         _thessboxInInfo = new ThessboxFightInfo();
      }
      
      public static function get Instance() : TheseussoulManager
      {
         if(_ins == null)
         {
            _ins = new TheseussoulManager();
         }
         return _ins;
      }
      
      public function get thessboxOutInfo() : ThessBoxInfo
      {
         return _thessboxOutInfo;
      }
      
      public function get thessboxInInfo() : ThessboxFightInfo
      {
         return _thessboxInInfo;
      }
      
      public function get model() : TheseussoulModel
      {
         return _model;
      }
      
      public function get modelCollenTion() : TheseusCollenTionModel
      {
         return _modelCollenTion;
      }
      
      public function setup() : void
      {
         SocketManager.instance.addEventListener("SLGSocketEvent" + 4298,__suitInfosHandler);
         SocketManager.instance.addEventListener("SLGSocketEvent" + 4299,__yiInfosHandler);
         SocketManager.instance.addEventListener("SLGSocketEvent" + 4300,__propertyInfosHandler);
         SocketManager.instance.addEventListener("SLGSocketEvent" + 4302,__treasurePropertyInfosHandler);
         SocketManager.instance.addEventListener("SLGSocketEvent" + 4306,__warsoulInfosHandler);
         SocketManager.instance.addEventListener("SLGSocketEvent" + 4307,__warsoulInfosHandler);
         SocketManager.instance.addEventListener("SLGSocketEvent" + 4308,__hatchInfosHandler);
         SocketManager.instance.addEventListener("SLGSocketEvent" + 4309,__hatchInfosHandler);
         SocketManager.instance.addEventListener("SLGSocketEvent" + 4310,__refineInfosHandler);
         SocketManager.instance.addEventListener("SLGSocketEvent" + 4323,__warFrameInfosHandler);
         SocketManager.instance.addEventListener("SLGSocketEvent" + 768,__thessTowerDataHandler);
         SocketManager.instance.addEventListener("SLGSocketEvent" + 584,__treasureCollectionInfosHandler);
         SocketManager.instance.addEventListener("SLGSocketEvent" + 585,__updateBuyDataHandler);
         SocketManager.instance.addEventListener("SLGSocketEvent" + 769,__thessBoxDataHandler);
         SocketManager.instance.addEventListener("SLGSocketEvent" + 770,__thessBoxFightDataHandler);
         SocketManager.instance.addEventListener("SLGSocketEvent" + 771,__thessBoxADDSKHandler);
         SocketManager.instance.addEventListener("SLGSocketEvent" + 594,__updatePartyTempHandler);
         SocketManager.instance.addEventListener("SLGSocketEvent" + 1024,__slateInfosHandler);
      }
      
      private function __slateInfosHandler(param1:SLGSocketEvent) : void
      {
         var _loc4_:PackageIn = param1.data as PackageIn;
         var _loc2_:UserSlateMsg = new UserSlateMsg();
         _loc2_ = _loc4_.readBody(_loc2_) as UserSlateMsg;
         _modelGodhead.initialize();
         if(_loc2_.hasPosMark)
         {
            _modelGodhead.setPosMark(_loc2_.posMark);
         }
         var _loc3_:int = _loc2_.opType;
         switch(_loc3_ - 1)
         {
            case 0:
               _modelGodhead.clearPag();
               onQueryShibanInfo(_loc2_);
               updateTaskInfo(_loc2_);
               break;
            case 1:
            case 5:
            case 6:
               onUplevShiban(_loc2_);
               break;
            case 2:
            case 3:
            case 8:
            case 9:
            case 10:
               onQueryShibanInfo(_loc2_);
               break;
            case 4:
               decomposeShiban(_loc2_);
               break;
            case 7:
               updateTaskInfo(_loc2_);
         }
         dispatchEvent(new NotificationEvent("EVENT_SLATE_UPDATE",_loc3_));
      }
      
      public function decomposeShiban(param1:UserSlateMsg) : void
      {
         var _loc2_:SlateMsg = null;
         var _loc4_:int = 0;
         var _loc3_:int = int(param1.slates.length);
         _loc4_ = 0;
         while(_loc4_ < _loc3_)
         {
            _loc2_ = param1.slates[_loc4_];
            _modelGodhead.removeFromBag(_loc2_.id);
            _loc4_++;
         }
      }
      
      public function onUplevShiban(param1:UserSlateMsg) : void
      {
         var _loc2_:TheseusGodheadStoneInfo = null;
         if(param1.slates && param1.slates.length > 0)
         {
            for each(var _loc3_:SlateMsg in param1.slates)
            {
               _loc2_ = _modelGodhead.getStoneById(_loc3_.id);
               _loc2_.pos = _loc3_.pos;
               _loc2_.level = _loc3_.grade;
               _loc2_.star = _loc3_.star;
               _loc2_.rotate = _loc3_.rotate;
               _loc2_.equipPos = _loc3_.equipPos;
               _loc2_.isLock = _loc3_.isLock;
               _loc2_.isExist = _loc3_.isExist;
            }
         }
      }
      
      public function onQueryShibanInfo(param1:UserSlateMsg) : void
      {
         var _loc10_:int = 0;
         var _loc6_:TheseusGodheadStoneInfo = null;
         var _loc2_:TheseusGodheadStoneInfo = null;
         var _loc4_:Object = null;
         var _loc14_:int = 0;
         var _loc11_:TheseusGodheadStoneInfo = null;
         var _loc5_:TheseusSlateInfo = null;
         var _loc8_:SlatePropertyMsg = null;
         var _loc13_:Object = null;
         var _loc3_:Array = [];
         var _loc9_:Array = _modelGodhead.getBagStones();
         _loc10_ = 0;
         while(_loc10_ < _loc9_.length)
         {
            _loc6_ = _loc9_[_loc10_] as TheseusGodheadStoneInfo;
            if(_loc6_ && _loc6_.isExist)
            {
               _loc3_.push(_loc6_.stoneId);
            }
            _loc10_++;
         }
         var _loc7_:Array = [];
         if(param1.slates && param1.slates.length > 0)
         {
            for each(var _loc12_:SlateMsg in param1.slates)
            {
               _loc7_.push(_loc12_.id);
               _loc2_ = _modelGodhead.getStoneById(_loc12_.id);
               if(_loc2_)
               {
                  _loc4_ = {
                     "templateId":_loc12_.templateId,
                     "pos":_loc12_.pos,
                     "level":_loc12_.grade,
                     "star":_loc12_.templateId % 10,
                     "rotate":_loc12_.rotate,
                     "equipPos":_loc12_.equipPos,
                     "isLock":_loc12_.isLock,
                     "isExist":_loc12_.isExist
                  };
                  _loc14_ = _loc2_.equipPos;
                  _modelGodhead.updateStoneById(_loc12_.id,_loc4_);
                  if(_loc12_.hasEquipPos && _loc12_.equipPos >= 0 && _loc12_.equipPos < 25)
                  {
                     if(_loc14_ != _loc12_.equipPos)
                     {
                        if(_loc14_ == -1)
                        {
                           _modelGodhead.setStoneToEquipPos(_loc12_.equipPos,_loc2_);
                           _modelGodhead.removeFromBag(_loc12_.id);
                        }
                     }
                  }
                  else if(_loc12_.hasPos && _loc12_.pos >= 0)
                  {
                     if(_loc14_ >= 0 && _loc14_ < 25)
                     {
                        _modelGodhead.addStoneToBag(_loc2_);
                        _modelGodhead.removeHasEquipedinfo(_loc12_.id);
                     }
                  }
                  else if(_loc12_.pos == -1)
                  {
                     _modelGodhead.removeFromBag(_loc12_.id);
                  }
               }
               else
               {
                  _loc11_ = new TheseusGodheadStoneInfo();
                  _loc11_.stoneId = _loc12_.id;
                  _loc11_.templateId = _loc12_.templateId;
                  _loc11_.pos = _loc12_.pos;
                  _loc11_.level = _loc12_.grade;
                  _loc11_.star = _loc12_.templateId % 10;
                  _loc11_.rotate = _loc12_.rotate;
                  _loc11_.equipPos = _loc12_.equipPos;
                  _loc11_.isLock = _loc12_.isLock;
                  _loc11_.isExist = _loc12_.isExist;
                  _loc5_ = _modelGodhead.getStoneTemplate(_loc12_.templateId);
                  if(_loc5_)
                  {
                     _loc11_.quality = _loc5_.SlateProfile;
                     _loc11_.name = _loc5_.SlateName;
                     _loc11_.icon = _loc5_.SlateIcon;
                     _loc11_.type = _loc5_.SlateType;
                     _loc11_.shape = _loc5_.SlateShape;
                     if(_loc5_.hasOwnProperty("SlateAttr"))
                     {
                        _modelGodhead.parseSlateAttributes(_loc11_.baseAttributes,_loc5_.SlateAttr);
                     }
                     if(_loc5_.hasOwnProperty("SlateLvAttr"))
                     {
                        _modelGodhead.parseSlateAttributes(_loc11_.levelUpAttributes,_loc5_.SlateLvAttr);
                     }
                  }
                  _loc11_.updateMaxLevel();
                  if(_loc12_.hasEquipPos && _loc12_.equipPos >= 0 && _loc12_.equipPos < 25)
                  {
                     trace("处理装备数据: equipPos=" + _loc12_.equipPos + ", stoneId=" + _loc12_.id);
                     _modelGodhead.setStoneToEquipPos(_loc12_.equipPos,_loc11_);
                  }
                  else if(_loc12_.hasPos && _loc12_.pos >= 0)
                  {
                     _modelGodhead.addStoneToBag(_loc11_);
                  }
               }
            }
         }
         if(param1.hasProperty)
         {
            _loc8_ = param1.property;
            _loc13_ = {
               "attack":(_loc8_.hasAttack ? _loc8_.attack : 0),
               "defence":(_loc8_.hasDefence ? _loc8_.defence : 0),
               "magicAttack":(_loc8_.hasMagicAttack ? _loc8_.magicAttack : 0),
               "magicDefence":(_loc8_.hasMagicDefence ? _loc8_.magicDefence : 0),
               "forceHit":(_loc8_.hasForceHit ? _loc8_.forceHit : 0),
               "parry":(_loc8_.hasParry ? _loc8_.parry : 0),
               "live":(_loc8_.hasLive ? _loc8_.live : 0),
               "penetrate":(_loc8_.hasPenetrate ? _loc8_.penetrate : 0)
            };
            _modelGodhead.setTotalPropertyFromServer(_loc13_);
         }
      }
      
      public function updateTaskInfo(param1:UserSlateMsg) : void
      {
         var _loc3_:Array = [];
         if(param1.tasks && param1.tasks.length > 0)
         {
            for each(var _loc2_ in param1.tasks)
            {
               _modelGodhead.setTaskStatus(_loc2_.templateId,_loc2_.state);
            }
         }
      }
      
      private function __updatePartyTempHandler(param1:SLGSocketEvent) : void
      {
         var _loc15_:int = 0;
         var _loc8_:RavePartyRewardInfo = null;
         var _loc24_:String = null;
         var _loc25_:RavePartyRewardInfo = null;
         var _loc12_:Array = null;
         var _loc16_:int = 0;
         var _loc18_:RavePartyRewardInfo = null;
         var _loc5_:PackageIn = param1.data as PackageIn;
         var _loc2_:CollectionRewardMsg = new CollectionRewardMsg();
         _loc2_ = _loc5_.readBody(_loc2_) as CollectionRewardMsg;
         modelCollenTion.allTotallevel = _loc2_.boxCount;
         var _loc21_:Array = [];
         if(_loc2_.tasks)
         {
            _loc21_ = resolveMsgToArr(_loc2_.tasks);
         }
         var _loc13_:Object = {};
         for each(var _loc7_:RavePartyRewardInfo in _loc21_)
         {
            _loc13_[_loc7_.uuid] = _loc7_;
         }
         _loc15_ = 0;
         while(_loc15_ < modelCollenTion.playerScoreRewardList.length)
         {
            _loc8_ = modelCollenTion.playerScoreRewardList[_loc15_];
            if(_loc13_[_loc8_.uuid])
            {
               modelCollenTion.playerScoreRewardList[_loc15_] = _loc13_[_loc8_.uuid];
               delete _loc13_[_loc8_.uuid];
            }
            _loc15_++;
         }
         for(var _loc10_:String in _loc13_)
         {
            modelCollenTion.playerScoreRewardList.push(_loc13_[_loc10_]);
         }
         var _loc20_:Array = TempleteManager.instance.collectionRewardTempCate.getallGoods();
         var _loc3_:Object = {};
         for each(var _loc11_:RavePartyRewardInfo in modelCollenTion.playerScoreRewardList)
         {
            _loc3_[_loc11_.uuid] = true;
         }
         for each(var _loc4_:CollectionRewardTemplateInfo in _loc20_)
         {
            _loc24_ = _loc4_.Id + "";
            if(!_loc3_[_loc24_])
            {
               _loc25_ = new RavePartyRewardInfo();
               _loc25_.uuid = _loc24_;
               _loc25_.rewardLevel = _loc4_.Level;
               _loc25_.needValue = _loc4_.NeedNum;
               _loc12_ = _loc4_.Reward.split("|");
               _loc25_.rewardItem1 = _loc12_.length > 0 ? _loc12_[0] : "";
               _loc25_.rewardItem2 = _loc12_.length > 1 ? _loc12_[1] : "";
               _loc25_.rewardItem3 = _loc12_.length > 2 ? _loc12_[2] : "";
               _loc25_.rewardItem4 = _loc12_.length > 3 ? _loc12_[3] : "";
               _loc25_.rewardItem5 = _loc12_.length > 4 ? _loc12_[4] : "";
               _loc25_.rewardItem6 = _loc12_.length > 5 ? _loc12_[5] : "";
               _loc25_.rewardState = 0;
               modelCollenTion.playerScoreRewardList.push(_loc25_);
               _loc3_[_loc24_] = true;
            }
         }
         modelCollenTion.playerScoreRewardList.sortOn(["rewardLevel","rewardState"],[16,16]);
         var _loc22_:Array = [];
         var _loc17_:Array = [];
         var _loc23_:Array = [];
         var _loc9_:Array = [];
         var _loc14_:Array = [];
         modelCollenTion.playerScoreRewardList.sortOn("rewardLevel",16);
         var _loc19_:int = -1;
         for each(var _loc6_:RavePartyRewardInfo in modelCollenTion.playerScoreRewardList)
         {
            if(_loc6_.rewardState >= 1)
            {
               _loc19_++;
            }
            if(_loc6_.rewardState == 1)
            {
               _loc17_.push(_loc6_);
            }
            else if(_loc6_.rewardState == 0)
            {
               _loc23_.push(_loc6_);
            }
            else
            {
               _loc9_.push(_loc6_);
            }
         }
         _loc14_ = _loc14_.concat(_loc9_);
         _loc14_ = _loc14_.concat(_loc17_);
         _loc14_ = _loc14_.concat(_loc23_.slice(0,10));
         _loc22_ = _loc22_.concat(_loc17_);
         _loc22_ = _loc22_.concat(_loc23_.slice(0,10));
         _loc22_ = _loc22_.concat(_loc9_);
         modelCollenTion.playerScoreRewardList = _loc22_;
         modelCollenTion.allred = false;
         _loc16_ = 0;
         while(_loc16_ < modelCollenTion.playerScoreRewardList.length)
         {
            _loc18_ = modelCollenTion.playerScoreRewardList[_loc16_];
            if(_loc18_.rewardState == 1)
            {
               modelCollenTion.allred = true;
            }
            _loc16_++;
         }
         modelCollenTion.myTotalScore = _loc2_.boxCount;
         if(modelCollenTion.playerScoreRewardList.length == 0)
         {
            modelCollenTion.myTotalid = 1001;
         }
         else if(_loc19_ >= 0 && _loc19_ + 1 < modelCollenTion.playerScoreRewardList.length)
         {
            modelCollenTion.myTotalid = int(_loc14_[_loc19_ + 1].uuid);
         }
         else if(_loc19_ > 0)
         {
            modelCollenTion.myTotalid = int(_loc14_[_loc19_].uuid);
         }
         else
         {
            modelCollenTion.myTotalid = 1001;
         }
         dispatchEvent(new NotificationEvent("OP_COLLECTION_UPGRADETASK"));
      }
      
      private function resolveMsgToArr(param1:Array) : Array
      {
         var _loc4_:RavePartyRewardInfo = null;
         var _loc6_:CollectionRewardTemplateInfo = null;
         var _loc2_:Array = null;
         var _loc5_:Array = [];
         for each(var _loc3_:RewardTask in param1)
         {
            _loc4_ = new RavePartyRewardInfo();
            _loc4_.uuid = _loc3_.taskId + "";
            _loc6_ = TempleteManager.instance.collectionRewardTempCate.getTemplateByID(_loc3_.taskId);
            _loc4_.rewardLevel = _loc6_.Level;
            _loc4_.needValue = _loc6_.NeedNum;
            _loc2_ = _loc6_.Reward.split("|");
            _loc4_.rewardItem1 = _loc2_.length > 0 ? _loc2_[0] : "";
            _loc4_.rewardItem2 = _loc2_.length > 1 ? _loc2_[1] : "";
            _loc4_.rewardItem3 = _loc2_.length > 2 ? _loc2_[2] : "";
            _loc4_.rewardItem4 = _loc2_.length > 3 ? _loc2_[3] : "";
            _loc4_.rewardItem5 = _loc2_.length > 4 ? _loc2_[4] : "";
            _loc4_.rewardItem6 = _loc2_.length > 5 ? _loc2_[5] : "";
            _loc4_.rewardState = _loc3_.status;
            _loc5_.push(_loc4_);
         }
         _loc5_.sortOn("rewardLevel",16);
         return _loc5_;
      }
      
      public function opThessbox(param1:int, param2:int) : void
      {
         var _loc4_:PackageOut = new PackageOut(9761);
         var _loc3_:PlayerOpMsg = new PlayerOpMsg();
         _loc3_.op = param1;
         _loc3_.chapterId = param2;
         SocketManager.instance.socket.sendProtobuffer(_loc4_,_loc3_);
      }
      
      private function __thessBoxADDSKHandler(param1:SLGSocketEvent) : void
      {
         var _loc3_:PackageIn = param1.data as PackageIn;
         var _loc2_:StoreHouseAddSkillMsg = new StoreHouseAddSkillMsg();
         _loc2_ = _loc3_.readBody(_loc2_) as StoreHouseAddSkillMsg;
         FrameControllerManager.instance.openControllerByInfo("thessbox","ThessBoxDropFrame",_loc2_);
      }
      
      private function __thessBoxDataHandler(param1:SLGSocketEvent) : void
      {
         var _loc3_:PackageIn = param1.data as PackageIn;
         var _loc2_:StoreHouseUseMsg = new StoreHouseUseMsg();
         _loc2_ = _loc3_.readBody(_loc2_) as StoreHouseUseMsg;
         _thessboxOutInfo.opType = _loc2_.opType;
         _thessboxOutInfo.count = _loc2_.count;
         _thessboxOutInfo.passChapter = _loc2_.passChapter;
         _thessboxOutInfo.firstReward = _loc2_.firstReward;
         dispatchEvent(new NotificationEvent("EVENT_BOX_USER"));
      }
      
      private function __thessBoxFightDataHandler(param1:SLGSocketEvent) : void
      {
         var _loc3_:PackageIn = param1.data as PackageIn;
         var _loc2_:StoreHouseFightMsg = new StoreHouseFightMsg();
         _loc2_ = _loc3_.readBody(_loc2_) as StoreHouseFightMsg;
         _thessboxInInfo.type = _loc2_.type;
         _thessboxInInfo.curLevel = _loc2_.curLevel;
         _thessboxInInfo.chapterId = _loc2_.chapterId;
         _thessboxInInfo.mapId = _loc2_.mapId;
         _thessboxInInfo.equipSkills = _loc2_.equipSkills;
         _thessboxInInfo.allSkills = _loc2_.allSkills;
         _thessboxInInfo.addSkill = _loc2_.addSkill;
         dispatchEvent(new NotificationEvent("EVENT_BOX_FIGHT"));
      }
      
      public function doTowerParam(param1:int) : void
      {
         var _loc3_:PackageOut = new PackageOut(9760);
         var _loc2_:PlayerOpMsg = new PlayerOpMsg();
         _loc2_.op = param1;
         SocketManager.instance.socket.sendProtobuffer(_loc3_,_loc2_);
      }
      
      private function __thessTowerDataHandler(param1:SLGSocketEvent) : void
      {
         var _loc4_:PackageIn = param1.data as PackageIn;
         var _loc2_:PropertyMsg = new PropertyMsg();
         _loc2_ = _loc4_.readBody(_loc2_) as PropertyMsg;
         _thessTowerInfo.passLevel = _loc2_.param1;
         _thessTowerInfo.normalTime = _loc2_.param2;
         _thessTowerInfo.buyTime = _loc2_.param3;
         _thessTowerInfo.hasBuyTime = _loc2_.param10;
         var _loc3_:int = _loc2_.param11;
         dispatchEvent(new NotificationEvent("EVENT_TOWER",_loc3_));
      }
      
      private function __warFrameInfosHandler(param1:SLGSocketEvent) : void
      {
         var _loc4_:WarFrameItemInfo = null;
         var _loc5_:PackageIn = param1.data as PackageIn;
         var _loc2_:TheseusEquipListMsg = new TheseusEquipListMsg();
         _loc2_ = _loc5_.readBody(_loc2_) as TheseusEquipListMsg;
         var _loc3_:int = _loc2_.op;
         if(_loc2_.theseusEquips)
         {
            for each(var _loc6_:TheseusEquipMsg in _loc2_.theseusEquips)
            {
               _loc4_ = new WarFrameItemInfo();
               _loc4_.id = _loc6_.id;
               _loc4_.type = _loc6_.type;
               _loc4_.pos = _loc6_.pos;
               _loc4_.templateId = _loc6_.templateId;
               if(_loc6_.type == 1)
               {
                  _loc4_.strengthen = _loc6_.strengthen;
                  _loc4_.reform = _loc6_.quality;
               }
               _loc4_.isEquip = _loc6_.isEquip;
               _loc4_.isExist = _loc6_.isExist;
               _loc4_.count = _loc6_.count;
               _loc4_.isLock = _loc6_.isLock;
               if(_loc3_ == 8 || _loc3_ == 0 && _loc4_.count <= 0 && _loc4_.type == 1)
               {
                  _model.updateSuite2(_loc4_.id,"suite" + _loc4_.warTempInfo.Property1);
               }
               if(_loc6_.isEquip)
               {
                  _model.updateSuite1(_loc6_.equipPos,_loc4_.id,"suite" + _loc4_.warTempInfo.Property1);
               }
               if(_loc3_ == 4)
               {
                  if(_loc4_.count <= 0)
                  {
                     _model.delItem(_loc4_.id);
                  }
                  else
                  {
                     _model.putItem(_loc4_.id,_loc4_);
                  }
               }
               else
               {
                  _model.putItem(_loc4_.id,_loc4_);
               }
            }
         }
         _model.sortArmorBagDic();
         if(_loc3_ == 5)
         {
            dispatchEvent(new NotificationEvent("OP_WarEQUIP_STRENGTHENSTR",_loc3_));
         }
         else if(_loc3_ == 6)
         {
            dispatchEvent(new NotificationEvent("OP_WarEQUIP_STRENGTHENSTR",_loc3_));
         }
         dispatchEvent(new Event("EVENT_SUIT_UPDATE"));
      }
      
      private function __refineInfosHandler(param1:SLGSocketEvent) : void
      {
         var _loc4_:PackageIn = param1.data as PackageIn;
         var _loc2_:WarSoulRefreshMsg = new WarSoulRefreshMsg();
         _loc2_ = _loc4_.readBody(_loc2_) as WarSoulRefreshMsg;
         var _loc3_:int = _loc2_.opType;
         var _loc5_:TheseusWarRfineInfo = _warsoulModel.refineInfo;
         _loc5_.id = _loc2_.id;
         _loc5_.skills = _loc2_.skills.concat();
         dispatchEvent(new Event("EVENT_WAR_REFINE"));
      }
      
      private function __warsoulInfosHandler(param1:SLGSocketEvent) : void
      {
         var _loc6_:TheseusWarsoulItemInfo = null;
         var _loc5_:PackageIn = param1.data as PackageIn;
         var _loc2_:WarSoulListMsg = new WarSoulListMsg();
         _loc2_ = _loc5_.readBody(_loc2_) as WarSoulListMsg;
         var _loc3_:int = _loc2_.op;
         _warsoulModel.fightIdx = _loc2_.fightIdx;
         for each(var _loc4_:WarSoulMsg in _loc2_.warSouls)
         {
            if(!_loc4_.isExist)
            {
               _warsoulModel.delItem(_loc4_.id);
            }
            else
            {
               _loc6_ = _warsoulModel.getItemInfo(_loc4_.id);
               if(_loc6_ == null)
               {
                  _loc6_ = new TheseusWarsoulItemInfo();
                  _loc6_.id = _loc4_.id;
                  _warsoulModel.putItem(_loc6_.id,_loc6_);
               }
               _loc6_.isLock = _loc4_.isLock;
               _loc6_.warSoulId = _loc4_.warSoulId;
               _loc6_.star = _loc4_.star;
               _loc6_.strengthen = _loc4_.strengthen;
               _loc6_.reform = _loc4_.reform;
               _loc6_.reformBuff = _loc4_.reformBuff;
               _loc6_.learnSkill = _loc4_.learnSkill;
               _loc6_.ramdomSkills = _loc4_.ramdomSkills;
               _loc6_.isEquip = _loc4_.isEquip;
               _loc6_.isExist = _loc4_.isExist;
               _loc6_.num = _loc4_.count;
               _loc6_.newLearnSkill = _loc4_.newLearnSkill;
            }
         }
         dispatchEvent(new NotificationEvent("EVENT_WAR_EQUIP",_loc3_));
      }
      
      private function __hatchInfosHandler(param1:SLGSocketEvent) : void
      {
         var _loc6_:TheseusWarsoulHatchInfo = null;
         var _loc5_:PackageIn = param1.data as PackageIn;
         var _loc2_:WarSoulHatchListMsg = new WarSoulHatchListMsg();
         _loc2_ = _loc5_.readBody(_loc2_) as WarSoulHatchListMsg;
         var _loc3_:int = _loc2_.op;
         for each(var _loc4_:WarSoulHatchMsg in _loc2_.hatchs)
         {
            if(_loc3_ == 9)
            {
               _warsoulModel.delIHatch(_loc4_.hatchNum);
            }
            else
            {
               _loc6_ = _warsoulModel.getHatchInfo(_loc4_.hatchNum);
               if(_loc6_ == null)
               {
                  _loc6_ = new TheseusWarsoulHatchInfo();
                  _loc6_.hatchNum = _loc4_.hatchNum;
                  _warsoulModel.putHatch(_loc6_.hatchNum,_loc6_);
               }
               _loc6_.useItem = _loc4_.useItem;
               _loc6_.startDate = _loc4_.startDate;
               _loc6_.stopDate = _loc4_.stopDate;
            }
         }
         dispatchEvent(new Event("EVENT_WAR_EGG"));
      }
      
      private function __suitInfosHandler(param1:SLGSocketEvent) : void
      {
         var _loc3_:* = null;
         var _loc4_:PackageIn = param1.data as PackageIn;
         var _loc2_:TheseusUserMsg = new TheseusUserMsg();
         _loc2_ = _loc4_.readBody(_loc2_) as TheseusUserMsg;
         _model.hokeInfo = _loc2_.hokeInfo;
         _model.coreLevel = _loc2_.coreLevel;
         _model.checkEquipRed();
         dispatchEvent(new Event("EVENT_SUIT_UPDATE"));
      }
      
      private function __updateBuyDataHandler(param1:SLGSocketEvent) : void
      {
         var _loc4_:PackageIn = param1.data as PackageIn;
         var _loc2_:BoxOpenItemMsg = new BoxOpenItemMsg();
         _loc2_ = _loc4_.readBody(_loc2_) as BoxOpenItemMsg;
         var _loc3_:Object = {};
         if(_loc2_.items)
         {
            _loc3_.list = _loc2_.items;
         }
         dispatchEvent(new NotificationEvent("THESEUSCOLLECTIONBOXEXCHANGE_BUY_BACK",_loc3_));
      }
      
      private function __yiInfosHandler(param1:SLGSocketEvent) : void
      {
         var _loc5_:TheseusYiCellInfo = null;
         var _loc4_:int = 0;
         var _loc6_:PackageIn = param1.data as PackageIn;
         var _loc2_:TheseusRageListMsg = new TheseusRageListMsg();
         _loc2_ = _loc6_.readBody(_loc2_) as TheseusRageListMsg;
         for each(var _loc3_:TheseusRageMsg in _loc2_.rages)
         {
            _loc4_ = _loc3_.pos;
            _loc5_ = _model.yiDic[_loc4_];
            if(!_loc5_)
            {
               _loc5_ = new TheseusYiCellInfo();
               _model.yiDic.add(_loc4_,_loc5_);
            }
            _loc5_.pos = _loc4_;
            _loc5_.level = _loc3_.level;
         }
         dispatchEvent(new Event("EVENT_YI_UPDATE"));
      }
      
      private function __treasureCollectionInfosHandler(param1:SLGSocketEvent) : void
      {
         var item:CollectionDataMsg;
         var e:SLGSocketEvent = param1;
         var pkg:PackageIn = e.data as PackageIn;
         var msg:CollectionMsg = new CollectionMsg();
         msg = pkg.readBody(msg) as CollectionMsg;
         modelCollenTion.boxDropId = msg.dropId;
         modelCollenTion.boxProcess = msg.boxProcess;
         if(msg.opType == 2)
         {
            _modelCollenTion.setupstarCollectionData(msg.datas,function():void
            {
               dispatchEvent(new Event("EVENT_COLLECTION_UPDATE"));
            });
         }
         else
         {
            for each(item in msg.datas)
            {
               _modelCollenTion.hasCollectionArray.push(item);
            }
            _modelCollenTion.setHasCollection();
            dispatchEvent(new Event("EVENT_COLLECTION_UPDATE"));
         }
      }
      
      private function __treasurePropertyInfosHandler(param1:SLGSocketEvent) : void
      {
         var _loc3_:PackageIn = param1.data as PackageIn;
         var _loc2_:TheseusPropertyMsg = new TheseusPropertyMsg();
         _loc2_ = _loc3_.readBody(_loc2_) as TheseusPropertyMsg;
         _model.treasurePros.power = _loc2_.power;
         _model.treasurePros.agility = _loc2_.agility;
         _model.treasurePros.intellect = _loc2_.intellect;
         _model.treasurePros.captain = _loc2_.captain;
         _model.treasurePros.physique = _loc2_.physique;
         _model.treasurePros.attack = _loc2_.attack;
         _model.treasurePros.defence = _loc2_.defence;
         _model.treasurePros.magicAttack = _loc2_.magicAttack;
         _model.treasurePros.magicDefence = _loc2_.magicDefence;
         _model.treasurePros.forceHit = _loc2_.forceHit;
         _model.treasurePros.parry = _loc2_.parry;
         _model.treasurePros.live = _loc2_.live;
         _model.treasurePros.conat = _loc2_.conat;
         _model.treasurePros.reduceResi = _loc2_.reduceResi;
         _model.treasurePros.fireResi = _loc2_.fireResi;
         _model.treasurePros.waterResi = _loc2_.waterResi;
         _model.treasurePros.electResi = _loc2_.electResi;
         _model.treasurePros.windResi = _loc2_.windResi;
         _model.treasurePros.darkResi = _loc2_.darkResi;
         _model.treasurePros.lightResi = _loc2_.lightResi;
         _model.treasurePros.strength = _loc2_.strength;
         _model.treasurePros.tenacity = _loc2_.tenacity;
         _model.treasurePros.penetrate = _loc2_.penetrate;
         _model.treasurePros.stunAttr = _loc2_.stunAttr;
         _model.treasurePros.reduceResiAgainst = _loc2_.reduceResiAgainst;
         _model.treasurePros.resiPenetrate = _loc2_.resiPenetrate;
         dispatchEvent(new Event("EVENT_SUIT_UPDATE"));
      }
      
      private function __propertyInfosHandler(param1:SLGSocketEvent) : void
      {
         var _loc3_:PackageIn = param1.data as PackageIn;
         var _loc2_:TheseusPropertyMsg = new TheseusPropertyMsg();
         _loc2_ = _loc3_.readBody(_loc2_) as TheseusPropertyMsg;
         _model.propertys.power = _loc2_.power;
         _model.propertys.agility = _loc2_.agility;
         _model.propertys.intellect = _loc2_.intellect;
         _model.propertys.captain = _loc2_.captain;
         _model.propertys.physique = _loc2_.physique;
         _model.propertys.attack = _loc2_.attack;
         _model.propertys.defence = _loc2_.defence;
         _model.propertys.magicAttack = _loc2_.magicAttack;
         _model.propertys.magicDefence = _loc2_.magicDefence;
         _model.propertys.forceHit = _loc2_.forceHit;
         _model.propertys.parry = _loc2_.parry;
         _model.propertys.live = _loc2_.live;
         _model.propertys.conat = _loc2_.conat;
         _model.propertys.reduceResi = _loc2_.reduceResi;
         _model.propertys.fireResi = _loc2_.fireResi;
         _model.propertys.waterResi = _loc2_.waterResi;
         _model.propertys.electResi = _loc2_.electResi;
         _model.propertys.windResi = _loc2_.windResi;
         _model.propertys.darkResi = _loc2_.darkResi;
         _model.propertys.lightResi = _loc2_.lightResi;
         _model.propertys.strength = _loc2_.strength;
         _model.propertys.tenacity = _loc2_.tenacity;
         _model.propertys.penetrate = _loc2_.penetrate;
         _model.propertys.stunAttr = _loc2_.stunAttr;
         _model.propertys.reduceResiAgainst = _loc2_.reduceResiAgainst;
         _model.propertys.resiPenetrate = _loc2_.resiPenetrate;
         _model.propertys.armour = _loc2_.armour;
         dispatchEvent(new Event("EVENT_PROPERTY_UPDATE"));
      }
      
      public function doCollectionthing(param1:int, param2:int = 0, param3:int = 0) : void
      {
         var _loc5_:PackageOut = new PackageOut(9740);
         var _loc4_:PlayerOpMsg = new PlayerOpMsg();
         _loc4_.op = param1;
         _loc4_.templateId = param2;
         _loc4_.count = param3;
         SocketManager.instance.socket.sendProtobuffer(_loc5_,_loc4_);
      }
      
      public function doSomething(param1:int, param2:int = 0, param3:int = 0, param4:int = 0) : void
      {
         var _loc6_:PackageOut = new PackageOut(8680);
         var _loc5_:PlayerOpMsg = new PlayerOpMsg();
         _loc5_.op = param1;
         _loc5_.index = param2;
         _loc5_.templateId = param3;
         _loc5_.pos = param4;
         SocketManager.instance.socket.sendProtobuffer(_loc6_,_loc5_);
      }
      
      public function doWarFrameParam(param1:int, param2:int = 0, param3:int = 0, param4:String = "", param5:Array = null) : void
      {
         var _loc7_:PackageOut = new PackageOut(8684);
         var _loc6_:PlayerOpMsg = new PlayerOpMsg();
         _loc6_.op = param1;
         _loc6_.pos = param3;
         _loc6_.param1 = param4;
         _loc6_.id = param2;
         if(param5 != null)
         {
            _loc6_.ids = param5;
         }
         SocketManager.instance.socket.sendProtobuffer(_loc7_,_loc6_);
      }
      
      public function doWarsoulParam(param1:int, param2:int = -1, param3:int = 0, param4:int = -1, param5:Array = null) : void
      {
         var _loc7_:PackageOut = new PackageOut(8680);
         var _loc6_:PlayerOpMsg = new PlayerOpMsg();
         _loc6_.op = param1;
         _loc6_.index = param2;
         _loc6_.type = param4;
         _loc6_.id = param3;
         if(param5 != null)
         {
            _loc6_.ids = param5;
         }
         SocketManager.instance.socket.sendProtobuffer(_loc7_,_loc6_);
      }
      
      public function sendTheseusResolve(param1:String, param2:int) : void
      {
         var _loc4_:PackageOut = new PackageOut(8681);
         var _loc3_:PlayerOpMsg = new PlayerOpMsg();
         _loc3_.type = param2;
         _loc3_.param1 = param1;
         SocketSendManager.instance.sendProtoBuffer(_loc4_,_loc3_);
      }
      
      public function get warsoulModel() : WarSoulModel
      {
         return _warsoulModel;
      }
      
      public function get thessTowerInfo() : ThessTowerInfo
      {
         return _thessTowerInfo;
      }
      
      public function get modelGodhead() : TheseusGodheadModel
      {
         return _modelGodhead;
      }
      
      public function requestSlateData() : void
      {
         var _loc2_:PackageOut = new PackageOut(9762);
         var _loc1_:PlayerOpMsg = new PlayerOpMsg();
         _loc1_.op = 1;
         SocketManager.instance.socket.sendProtobuffer(_loc2_,_loc1_);
      }
      
      public function unlockPos(param1:int) : void
      {
         var _loc3_:PackageOut = new PackageOut(9762);
         var _loc2_:PlayerOpMsg = new PlayerOpMsg();
         _loc2_.op = 2;
         _loc2_.pos = param1;
         SocketManager.instance.socket.sendProtobuffer(_loc3_,_loc2_);
      }
      
      public function upgradeSlate(param1:int) : void
      {
         var _loc3_:PackageOut = new PackageOut(9762);
         var _loc2_:PlayerOpMsg = new PlayerOpMsg();
         _loc2_.op = 3;
         _loc2_.id = param1;
         SocketManager.instance.socket.sendProtobuffer(_loc3_,_loc2_);
      }
      
      public function starUpSlate(param1:int, param2:int) : void
      {
         var _loc4_:PackageOut = new PackageOut(9762);
         var _loc3_:PlayerOpMsg = new PlayerOpMsg();
         _loc3_.op = 4;
         _loc3_.id = param1;
         _loc3_.pos = param2;
         SocketManager.instance.socket.sendProtobuffer(_loc4_,_loc3_);
      }
      
      public function resolveSlate(param1:Array) : void
      {
         var _loc3_:PackageOut = new PackageOut(9762);
         var _loc2_:PlayerOpMsg = new PlayerOpMsg();
         _loc2_.op = 5;
         _loc2_.ids = param1;
         SocketManager.instance.socket.sendProtobuffer(_loc3_,_loc2_);
      }
      
      public function rotateSlate(param1:int) : void
      {
         var _loc3_:PackageOut = new PackageOut(9762);
         var _loc2_:PlayerOpMsg = new PlayerOpMsg();
         _loc2_.op = 6;
         _loc2_.id = param1;
         SocketManager.instance.socket.sendProtobuffer(_loc3_,_loc2_);
      }
      
      public function lockSlate(param1:int) : void
      {
         var _loc3_:PackageOut = new PackageOut(9762);
         var _loc2_:PlayerOpMsg = new PlayerOpMsg();
         _loc2_.op = 7;
         _loc2_.id = param1;
         SocketManager.instance.socket.sendProtobuffer(_loc3_,_loc2_);
      }
      
      public function getMissionReward(param1:int) : void
      {
         var _loc3_:PackageOut = new PackageOut(9762);
         var _loc2_:PlayerOpMsg = new PlayerOpMsg();
         _loc2_.op = 8;
         _loc2_.id = param1;
         SocketManager.instance.socket.sendProtobuffer(_loc3_,_loc2_);
      }
      
      public function moveSlatePos(param1:int, param2:int) : void
      {
         var _loc4_:PackageOut = new PackageOut(9762);
         var _loc3_:PlayerOpMsg = new PlayerOpMsg();
         _loc3_.op = 9;
         _loc3_.id = param1;
         _loc3_.pos = param2;
         SocketManager.instance.socket.sendProtobuffer(_loc4_,_loc3_);
      }
      
      public function movegirdSlatePos(param1:int, param2:int) : void
      {
         var _loc4_:PackageOut = new PackageOut(9762);
         var _loc3_:PlayerOpMsg = new PlayerOpMsg();
         _loc3_.op = 10;
         _loc3_.id = param1;
         _loc3_.pos = param2;
         SocketManager.instance.socket.sendProtobuffer(_loc4_,_loc3_);
      }
      
      public function movebagSlatePos(param1:int, param2:int) : void
      {
         var _loc4_:PackageOut = new PackageOut(9762);
         var _loc3_:PlayerOpMsg = new PlayerOpMsg();
         _loc3_.op = 11;
         _loc3_.id = param1;
         _loc3_.pos = param2;
         SocketManager.instance.socket.sendProtobuffer(_loc4_,_loc3_);
      }
   }
}

