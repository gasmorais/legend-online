package mvc.module.store
{
   import events.StoreEvent;
   import flash.events.EventDispatcher;
   import flash.utils.Dictionary;
   import yishi.datas.goods.GoodsInfo;
   import yishi.datas.playerinfo.PlayerInfo;
   import yishi.datas.playerinfo.ThaneInfo;
   import yishi.manager.ArmyManager;
   import yishi.manager.GoodsManager;
   import yishi.manager.PlayerManager;
   import yishi.utils.SimpleDictionary;
   
   public class StoreModel extends EventDispatcher
   {
      
      public static const EQUIP_HOLE_NUMBER:int = 4;
      
      public static const REMOVE_JEWEL_CUNSUME:int = 50;
      
      public static const MOUNT_JEWEL_CUNSUME:int = 1000;
      
      public static const SUCCESS_RATE:int = 100;
      
      public static const RATE_STEP:int = 10;
      
      public static const MOUNT_NEED_PROP:int = 208004;
      
      public static const COMPOSE_TYPE_EQUIP:int = 1;
      
      public static const COMPOSE_TYPE_PROP:int = 2;
      
      public static const COMPOSE_TYPE_GEM:int = 3;
      
      public static const COMPOSE_TYPE_AVENGER:int = 4;
      
      public static const COMPOSE_TYPE_THESEUS:int = 5;
      
      public static const COMPOSE_TYPE_UPDATE_EQUIP:int = 5;
      
      public static const COMPOSE_TYPE_RESIS_GEM:int = 6;
      
      public static const COMPOSE_TYPE_PET_GEM:int = 8;
      
      public static const COMPOSE_TYPE_PET_EQUIP:int = 9;
      
      public static const COMPOSE_TYPE_CHILD_GEM:int = 12;
      
      public static const COMPOSE_TYPE_ARTIFACT:int = 20;
      
      public static const COMPOSE_TYPE_MONSTER:int = 13;
      
      public static const COMPOSE_TYPE_GODDESS_EQUIP:int = 17;
      
      public static const COMPOSE_TYPE_3TURN:int = 18;
      
      public static const COMPOSE_TYPE_3WENZHANG:int = 19;
      
      public static const AVENGER_JUDGEMENT_STONE:int = 16;
      
      public static const AVENGER_GOLD_COMPOSE_STONE:int = 104;
      
      public static const AVENGER_PEARL_TYPE111:int = 111;
      
      public static const AVENGER_PEARL_TYPE112:int = 112;
      
      public static const AVENGER_PEARL_TYPE113:int = 113;
      
      public static const AVENGER_PEARL_TYPE114:int = 114;
      
      public static const AVENGER_PEARL_TYPE115:int = 115;
      
      public static const AVENGER_PEARL_TYPE116:int = 116;
      
      public static const AVENGER_PEARL_TYPE121:int = 121;
      
      public static const AVENGER_PEARL_TYPE122:int = 122;
      
      public static const AVENGER_PEARL_TYPE123:int = 123;
      
      public static const AVENGER_PEARL_TYPE124:int = 124;
      
      public static const AVENGER_PEARL_TYPE125:int = 125;
      
      public static const AVENGER_PEARL_TYPE126:int = 126;
      
      public static const AVENGER_PEARL_TYPE131:int = 131;
      
      public static const AVENGER_PEARL_TYPE132:int = 132;
      
      public static const AVENGER_PEARL_TYPE133:int = 133;
      
      public static const AVENGER_PEARL_TYPE134:int = 134;
      
      public static const AVENGER_PEARL_TYPE135:int = 135;
      
      public static const AVENGER_PEARL_TYPE136:int = 136;
      
      public static const AVENGER_PEARL_TYPE141:int = 141;
      
      public static const AVENGER_PEARL_TYPE142:int = 142;
      
      public static const AVENGER_PEARL_TYPE143:int = 143;
      
      public static const AVENGER_PEARL_TYPE144:int = 144;
      
      public static const AVENGER_PEARL_TYPE145:int = 145;
      
      public static const AVENGER_PEARL_TYPE146:int = 146;
      
      public static const AVENGER_PEARL_TYPE151:int = 151;
      
      public static const AVENGER_PEARL_TYPE152:int = 152;
      
      public static const AVENGER_PEARL_TYPE153:int = 153;
      
      public static const AVENGER_PEARL_TYPE154:int = 154;
      
      public static const AVENGER_PEARL_TYPE155:int = 155;
      
      public static const AVENGER_PEARL_TYPE156:int = 156;
      
      public static const THESEUS_TYPE201:int = 201;
      
      public static const THESEUS_TYPE202:int = 202;
      
      public static const THESEUS_TYPE203:int = 203;
      
      public static const THESEUS_TYPE204:int = 204;
      
      public static const THESEUS_TYPE205:int = 205;
      
      public static const THESEUS_TYPE206:int = 206;
      
      public static const THESEUS_TYPE207:int = 207;
      
      public static const THESEUS_TYPE208:int = 208;
      
      public static const THESEUS_TYPE209:int = 209;
      
      public static const COMPOSE_TYPE_FARM_ESSENCE:int = 101;
      
      public static const COMPOSE_TYPE_FARM_MILKTEA:int = 103;
      
      public static const COMPOSE_TYPE_FARM_BOX:int = 102;
      
      public static const MOULD_NEED_MATERIAL1:int = 2120100;
      
      public static const MOULD_NEED_MATERIAL2:int = 2120101;
      
      public static const MOULD_NEED_MATERIAL_SENIOR1:int = 2120102;
      
      public static const MOULD_NEED_MATERIAL_SENIOR2:int = 2120103;
      
      public static const MOULD_NEED_MATERIAL_VICE1:int = 2120104;
      
      public static const MOULD_NEED_MATERIAL_VICE2:int = 2120105;
      
      public static const MOULD_NEED_MATERIAL_THREE1:int = 2120106;
      
      public static const MOULD_NEED_MATERIAL_THREE2:int = 2120107;
      
      public static const MOULD_MAX_GRADE:int = 80;
      
      public static const MOULD_MAX_GRADE_SENIOR:int = 160;
      
      public static const MOULD_MAX_GRADE_THREE:int = 240;
      
      public static const MOULD_MAX_BLESS:int = 100;
      
      public static const MOULD_EXTENS_COST:int = 200;
      
      public static const MOULD_MAX_RANK:int = 8;
      
      public static const MOULD_MAX_RANK_SENIOR:int = 16;
      
      public static const MOULD_MAX_RANK_THREE:int = 24;
      
      public static const MOULE_NEED_TEMP_GRADE:int = 50;
      
      public static const MATERIAL_TEMPID:int = 2127022;
      
      public static const MATERIAL_TEMPID2:int = 2127026;
      
      public static const TREASURE_REFRESH_TEMPID:int = 2127021;
      
      public static const TREASURE_REFRESH_TEMPID2:int = 2127025;
      
      public static const COMPOSE_SENIOR_EQUIP_NEED_MOULD_GRADE:int = 20;
      
      public static var defaultChildPanel:int = 1;
      
      public static const LIFESKILL_PRACTICELIST:int = 3;
      
      public static const LIFESKILL_GRINDLIST:int = 4;
      
      public static const LIFESKILL_EXTRACTIONLIST:int = 5;
      
      public static const LIFESKILL_JEWELY:int = 6;
      
      public static const LIFESKILL_ALCHEMY:int = 7;
      
      public static const LIFESKILL_ENCHANT:int = 8;
      
      public static const JEWELY:int = 9;
      
      public static const ENCHANT:int = 10;
      
      public static const ALCHEMY:int = 11;
      
      private var _selectedCompose:ComposeGoodsInfo;
      
      private var _currentComposeCount:int;
      
      public var propertyTemList:Vector.<ComposeGoodsInfo>;
      
      public var equipTemList:Vector.<ComposeGoodsInfo>;
      
      public var gemTemList:Vector.<ComposeGoodsInfo>;
      
      public var allTemList:Vector.<ComposeGoodsInfo>;
      
      public var revengeTemList:Vector.<ComposeGoodsInfo>;
      
      public var theseusTemList:Vector.<ComposeGoodsInfo>;
      
      public var canComposeEquipList:Vector.<ComposeGoodsInfo>;
      
      public var goodsNumList:SimpleDictionary;
      
      public var isCanMake:Boolean;
      
      public var isCanMakeLifeSKill:Boolean;
      
      public var defalutPanel:String;
      
      public var isremove:Boolean;
      
      public var autoBuy:Boolean;
      
      public var currentUpdateEquip:GoodsInfo;
      
      public var selectedDic:Dictionary;
      
      public var selectedLifeSkillDic:Dictionary;
      
      public var selectedLifeSKillType:int;
      
      public var selectedType:int;
      
      private var _skillIdArray:Array = [0,0,0,0,0];
      
      private var _skillGradeArray:Array = [0,0,0,0,0];
      
      private var _skillProce:Array = [0,0,0,0,0];
      
      public var isIntensifing:Boolean;
      
      public var isEnchantfing:Boolean;
      
      public var isViceIntensifing:Boolean;
      
      private var _selectedPanel:String;
      
      private var _composeType:int;
      
      public function StoreModel()
      {
         super();
         propertyTemList = new Vector.<ComposeGoodsInfo>();
         equipTemList = new Vector.<ComposeGoodsInfo>();
         gemTemList = new Vector.<ComposeGoodsInfo>();
         revengeTemList = new Vector.<ComposeGoodsInfo>();
         theseusTemList = new Vector.<ComposeGoodsInfo>();
         canComposeEquipList = new Vector.<ComposeGoodsInfo>();
         allTemList = new Vector.<ComposeGoodsInfo>();
         goodsNumList = new SimpleDictionary(true);
         selectedDic = new Dictionary();
         selectedLifeSkillDic = new Dictionary();
      }
      
      public static function checkIsTheseusCompose(param1:int) : Boolean
      {
         var _loc3_:Array = null;
         var _loc2_:Array = null;
         switch(param1 - 201)
         {
            case 0:
            case 1:
            case 2:
            case 3:
            case 4:
            case 5:
            case 6:
            case 7:
            case 8:
               return true;
            default:
               _loc3_ = [301,302,303,304,305,306,307,308,309,351,352,353,354,355,356];
               _loc2_ = [361,362,363,364,365,366,367,368,369];
               if(_loc3_.indexOf(param1) != -1 || _loc2_.indexOf(param1) != -1)
               {
                  return true;
               }
               return false;
         }
      }
      
      public static function checkIsTheseusWarCompose(param1:int) : Boolean
      {
         switch(param1 - 201)
         {
            case 0:
            case 1:
            case 2:
            case 3:
            case 4:
            case 5:
            case 6:
            case 7:
            case 8:
               return true;
            default:
               return false;
         }
      }
      
      public static function checkIsAvengerCompose(param1:int) : Boolean
      {
         switch(param1)
         {
            case 16:
            case 104:
            case 111:
            case 112:
            case 113:
            case 114:
            case 115:
            case 116:
            case 121:
            case 122:
            case 123:
            case 124:
            case 125:
            case 126:
            case 131:
            case 132:
            case 133:
            case 134:
            case 135:
            case 136:
            case 141:
            case 142:
            case 143:
            case 144:
            case 145:
            case 146:
            case 151:
            case 152:
            case 153:
            case 154:
            case 155:
            case 156:
               break;
            default:
               return false;
         }
         return true;
      }
      
      public function get selectedCompose() : ComposeGoodsInfo
      {
         return _selectedCompose;
      }
      
      public function set selectedCompose(param1:ComposeGoodsInfo) : void
      {
         if(_selectedCompose == param1)
         {
            return;
         }
         _selectedCompose = param1;
         selectedDic[selectedType + "SUIT_SUBCELL"] = param1;
         currentComposeCount = 0;
         dispatchEvent(new StoreEvent("UPDATE_COMPOSE_SELECTED_CELL"));
      }
      
      public function get currentComposeCount() : int
      {
         return _currentComposeCount;
      }
      
      public function set currentComposeCount(param1:int) : void
      {
         param1 = int(param1 < 0 ? 0 : param1);
         if(_selectedCompose && param1 == 0 && (_selectedCompose.canMakeCount > 0 || _selectedCompose.template && getIsStoneType(_selectedCompose.template.Types)))
         {
            param1 = 1;
         }
         _currentComposeCount = param1;
         dispatchEvent(new StoreEvent("UPDATE_COMPOSE_MAX_COUNT"));
      }
      
      private function getIsStoneType(param1:int) : Boolean
      {
         if(param1 == 3 || param1 == 6 || param1 == 8 || param1 == 12)
         {
            return true;
         }
         return false;
      }
      
      public function set selectedPanel(param1:String) : void
      {
         if(_selectedPanel != param1)
         {
            _selectedPanel = param1;
            dispatchEvent(new StoreEvent("SELECTED_PANEL_CHANGE"));
         }
      }
      
      public function get selectedPanel() : String
      {
         return _selectedPanel;
      }
      
      public function set composeType(param1:int) : void
      {
         _composeType = param1;
         dispatchEvent(new StoreEvent("COMPOSE_TYPE_CHANGE"));
      }
      
      public function get composeType() : int
      {
         return _composeType;
      }
      
      public function set composeComplete(param1:Boolean) : void
      {
         if(param1)
         {
            dispatchEvent(new StoreEvent("COMPOSE_COMPLETE"));
         }
      }
      
      public function set lifeSkillCompolete(param1:Boolean) : void
      {
         if(param1)
         {
            dispatchEvent(new StoreEvent("LIFESKILL_COMPOLETE"));
         }
      }
      
      public function getComposeListByType() : Vector.<ComposeGoodsInfo>
      {
         switch(composeType - 1)
         {
            case 0:
               return equipTemList;
            case 1:
               return propertyTemList;
            case 2:
               return gemTemList;
            case 3:
               return revengeTemList;
            case 4:
               return theseusTemList;
            default:
               return null;
         }
      }
      
      public function getCurrentUpgradeEquipGoodsInfo() : GoodsInfo
      {
         var _loc3_:int = 0;
         var _loc2_:GoodsInfo = null;
         var _loc1_:Array = null;
         if(_selectedCompose)
         {
            _loc3_ = _selectedCompose.template.Material1;
            _loc2_ = GoodsManager.instance.getGoodsByObjectIdAndGoodID(thane.id,_loc3_);
            if(_loc2_)
            {
               return _loc2_;
            }
            _loc1_ = GoodsManager.instance.getBagGoodsByTemplateId(_loc3_);
            if(_loc1_.length > 0)
            {
               _loc2_ = _loc1_[0];
            }
            return _loc2_;
         }
         return null;
      }
      
      private function get thane() : ThaneInfo
      {
         return ArmyManager.instance.thane;
      }
      
      public function getLifeSkillArray() : void
      {
         var _loc6_:Array = null;
         var _loc3_:Array = null;
         var _loc7_:Array = null;
         var _loc4_:int = 0;
         var _loc1_:String = playerInfo.lifeSkillId;
         var _loc5_:String = playerInfo.lifeSKillGrade;
         var _loc2_:String = playerInfo.lifeSKillProficiency;
         _skillIdArray = [0,0,0,0,0];
         _skillGradeArray = [0,0,0,0,0];
         _skillProce = [0,0,0,0,0];
         if(_loc1_ != "" && _loc1_ != null)
         {
            _loc6_ = _loc1_.split(",");
            _loc3_ = _loc5_.split(",");
            _loc7_ = _loc2_.split(",");
            _loc4_ = 0;
            while(_loc4_ < _loc6_.length)
            {
               if(_loc6_[_loc4_] == 1)
               {
                  _skillIdArray[0] = 1;
                  _skillGradeArray[0] = int(_loc3_[_loc4_]);
                  _skillProce[0] = int(_loc7_[_loc4_]);
               }
               else if(_loc6_[_loc4_] == 2)
               {
                  _skillIdArray[1] = 2;
                  _skillGradeArray[1] = int(_loc3_[_loc4_]);
                  _skillProce[1] = int(_loc7_[_loc4_]);
               }
               else if(_loc6_[_loc4_] == 3)
               {
                  _skillIdArray[2] = 3;
                  _skillGradeArray[2] = int(_loc3_[_loc4_]);
                  _skillProce[2] = int(_loc7_[_loc4_]);
               }
               else if(_loc6_[_loc4_] == 4)
               {
                  _skillIdArray[3] = 4;
                  _skillGradeArray[3] = int(_loc3_[_loc4_]);
                  _skillProce[3] = _loc7_[_loc4_];
               }
               else if(_loc6_[_loc4_] == 5)
               {
                  _skillIdArray[4] = 5;
                  _skillGradeArray[4] = int(_loc3_[_loc4_]);
                  _skillProce[4] = _loc7_[_loc4_];
               }
               _loc4_++;
            }
         }
      }
      
      public function get skillIdArray() : Array
      {
         return _skillIdArray;
      }
      
      public function get skillGradeArray() : Array
      {
         return _skillGradeArray;
      }
      
      private function get playerInfo() : PlayerInfo
      {
         return PlayerManager.instance.currentPlayerModel.playerInfo;
      }
      
      public function get skillProce() : Array
      {
         return _skillProce;
      }
      
      public function set skillProce(param1:Array) : void
      {
         _skillProce = param1;
      }
   }
}

