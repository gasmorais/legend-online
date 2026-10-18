package mvc.module.children
{
   import flash.utils.Dictionary;
   import yishi.datas.VersionSwitch;
   import yishi.datas.goods.GoodsInfo;
   import yishi.datas.playerinfo.PlayerModel;
   import yishi.datas.templates.ChildComposeTempInfo;
   import yishi.datas.templates.ChildTempInfo;
   import yishi.datas.templates.ComposeGoodsTemplete;
   import yishi.manager.GoodsManager;
   import yishi.manager.PlayerManager;
   import yishi.manager.TempleteManager;
   import yishi.utils.MsgMan;
   
   public class ChildModel
   {
      
      public static const CELL_EQUIP:String = "CELL_EQUIP";
      
      public static const CELL_ATTRIBE:String = "CELL_ATTRIBE";
      
      public static const CELL_CARE:String = "CELL_CARE";
      
      public static const CELL_LOOKUP:String = "CELL_LOOKUP";
      
      public static const CELL_BOTTOM:String = "CELL_BOTTOM";
      
      public static const CELL_HIDE:String = "CELL_HIDE";
      
      public static const RESI_REDUCE:int = 1;
      
      public static const RESI_FIRE:int = 2;
      
      public static const RESI_WATER:int = 3;
      
      public static const RESI_ELECT:int = 4;
      
      public static const RESI_WIND:int = 5;
      
      public static const RESI_DARK:int = 6;
      
      public static const RESI_LIGHT:int = 7;
      
      public static const OPEN_EMBLEM_TEMID:int = 208046;
      
      public static const RESI_TEMID:int = 208047;
      
      public static const REDUEC_TEMID:int = 208048;
      
      public static const GROWTH_TEMID:int = 2250001;
      
      public static const CLEAN_TEMID:int = 208042;
      
      public static const RENAME_TEMID:int = 208043;
      
      public static const SEX_TEMID:int = 208044;
      
      public static const AWAKE_UPGRADE_TEMID:int = 212014;
      
      public static const MAX_CALL_COUNT:int = 8;
      
      public static const CHILD_MAX_GRADE:int = 12;
      
      public static const CHILD_ARENA_FORMATION:int = 1;
      
      public static const EXPEDITION_FORMATION_TYPE:int = 2;
      
      public var firstChildId:int;
      
      public var childList:Vector.<ChildData>;
      
      public var applyInfo:ChildApplyInfo;
      
      private var _composeList:Vector.<ComposeGoodsTemplete>;
      
      private var _selectedChild:ChildData;
      
      public var cleanAlert:Boolean = false;
      
      private var _selectedChildTemp:ChildTempInfo;
      
      public var totalGrowth:int;
      
      public var collectionInfoList:Array;
      
      private var _collectionTempList:Array;
      
      private var jobDic:Dictionary;
      
      public var _selectItemTemp:ChildTempInfo;
      
      private var _hideGoods:GoodsInfo;
      
      public var formationString:String;
      
      public function ChildModel()
      {
         super();
         if(childList == null)
         {
            childList = new Vector.<ChildData>();
         }
         if(applyInfo == null)
         {
            applyInfo = new ChildApplyInfo();
         }
         if(jobDic == null)
         {
            jobDic = new Dictionary();
         }
         if(_collectionTempList == null)
         {
            _collectionTempList = [];
         }
         if(collectionInfoList == null)
         {
            collectionInfoList = [];
         }
         var _loc2_:Dictionary = TempleteManager.instance.childTemplateCate.getTemplates();
         for each(var _loc1_:ChildTempInfo in _loc2_)
         {
            if(jobDic[_loc1_.JobType] == null)
            {
               jobDic[_loc1_.JobType] = [];
            }
            jobDic[_loc1_.JobType].push(_loc1_);
            if(_loc1_.Grades == 1 && _loc1_.MasterType != 1)
            {
               _collectionTempList.push(_loc1_);
            }
         }
      }
      
      public function get collectionTempList() : Array
      {
         return _collectionTempList;
      }
      
      public function sortByTypeAndGrade(param1:ChildTempInfo, param2:ChildTempInfo) : int
      {
         var _loc4_:ChildCollectInfo = getChildCollecInfoByType(param1.JobType);
         var _loc5_:ChildCollectInfo = getChildCollecInfoByType(param2.JobType);
         var _loc3_:Boolean = getChildTypeList(param1.JobType).length > 0;
         var _loc6_:Boolean = getChildTypeList(param2.JobType).length > 0;
         if(_loc3_ && !_loc6_)
         {
            return -1;
         }
         if(_loc6_ && !_loc3_)
         {
            return 1;
         }
         if(!_loc3_ && !_loc6_)
         {
            if(param1.JobType > param2.JobType)
            {
               return -1;
            }
            return 1;
         }
         if(_loc4_.soulWakes > _loc5_.soulWakes)
         {
            return -1;
         }
         if(_loc4_.soulWakes < _loc5_.soulWakes)
         {
            return 1;
         }
         if(_loc4_.growth > _loc5_.growth)
         {
            return -1;
         }
         if(_loc4_.growth < _loc5_.growth)
         {
            return 1;
         }
         if(param1.JobType > param2.JobType)
         {
            return -1;
         }
         return 1;
      }
      
      public function get selectedChild() : ChildData
      {
         return _selectedChild;
      }
      
      public function set selectedChild(param1:ChildData) : void
      {
         if(_selectedChild == param1)
         {
            return;
         }
         _selectedChild = param1;
         MsgMan.notifyObserver("ChildEvent.HEAD_CHANGE");
      }
      
      public function get omposeList() : Vector.<ComposeGoodsTemplete>
      {
         if(_composeList == null)
         {
            initComposeList();
         }
         return _composeList;
      }
      
      public function getComposeTemByGoodsId(param1:int) : ComposeGoodsTemplete
      {
         if(_composeList == null)
         {
            initComposeList();
         }
         for each(var _loc2_:ComposeGoodsTemplete in _composeList)
         {
            if(_loc2_.Material1 == param1)
            {
               return _loc2_;
            }
         }
         return null;
      }
      
      private function initComposeList() : void
      {
         var _loc2_:Dictionary = null;
         if(_composeList == null)
         {
            _composeList = new Vector.<ComposeGoodsTemplete>();
            _loc2_ = TempleteManager.instance.getComposeTempleteList();
            for each(var _loc1_:ComposeGoodsTemplete in _loc2_)
            {
               if(_loc1_.Types == 11)
               {
                  _composeList.push(_loc1_);
               }
            }
         }
      }
      
      public function get hideGoods() : GoodsInfo
      {
         return _hideGoods;
      }
      
      public function set hideGoods(param1:GoodsInfo) : void
      {
         _hideGoods = param1;
         MsgMan.notifyObserver("ChildEvent.HIDE_CHANGE");
      }
      
      public function moveGoodsBack() : void
      {
         var _loc1_:Array = GoodsManager.instance.getGoodsByBagType(29);
         for each(var _loc2_:GoodsInfo in _loc1_)
         {
            ChildSender.moveBagToBag(_loc2_.bagType,_loc2_.pos,28,0);
         }
         _hideGoods = null;
      }
      
      public function getChildById(param1:int) : ChildData
      {
         for each(var _loc2_:ChildData in childList)
         {
            if(_loc2_ && _loc2_.childId == param1)
            {
               return _loc2_;
            }
         }
         return null;
      }
      
      public function getEnterWar() : ChildData
      {
         for each(var _loc1_:ChildData in childList)
         {
            if(_loc1_.fightUserId == playerModel.userInfo.userId)
            {
               return _loc1_;
            }
         }
         return null;
      }
      
      public function getSlavedEnterWar() : ChildData
      {
         for each(var _loc1_:ChildData in childList)
         {
            if(_loc1_.fightSlaveUserId == playerModel.userInfo.userId)
            {
               return _loc1_;
            }
         }
         return null;
      }
      
      public function addChild(param1:ChildData) : void
      {
      }
      
      public function removeChild(param1:int) : void
      {
         var _loc2_:int = 0;
         _loc2_ = 0;
         while(_loc2_ < childList.length)
         {
            if(childList[_loc2_].childId == param1)
            {
               childList[_loc2_].state = -1;
               MsgMan.notifyObserver("ChildEvent.CHILD_DELETE",childList.splice(_loc2_,1)[0]);
            }
            _loc2_++;
         }
      }
      
      private function get playerModel() : PlayerModel
      {
         return PlayerManager.instance.currentPlayerModel;
      }
      
      public function get childpveFormationOfArray() : Array
      {
         if(formationString)
         {
            return formationString.split(",");
         }
         return [];
      }
      
      public function getFightChildCount() : int
      {
         var _loc2_:int = 0;
         var _loc1_:int = 0;
         _loc2_ = 0;
         while(_loc2_ < childpveFormationOfArray.length)
         {
            if(childpveFormationOfArray[_loc2_] != -1)
            {
               _loc1_++;
            }
            _loc2_++;
         }
         return _loc1_;
      }
      
      public function setfirstChild(param1:int) : void
      {
         var _loc3_:int = 0;
         firstChildId = param1;
         var _loc4_:Vector.<ChildData> = new Vector.<ChildData>();
         var _loc2_:ChildData = getChildById(firstChildId);
         if(_loc2_)
         {
            _loc4_.push(_loc2_);
         }
         childList.sort(childrenCompareFunction);
         _loc3_ = 0;
         while(_loc3_ < childList.length)
         {
            if(childList[_loc3_].childId != firstChildId)
            {
               _loc4_.push(childList[_loc3_]);
            }
            _loc3_++;
         }
         childList = _loc4_;
      }
      
      private function childrenCompareFunction(param1:ChildData, param2:ChildData) : int
      {
         if(param1.growthGrade < param2.growthGrade)
         {
            return 1;
         }
         if(param1.growthGrade > param2.growthGrade)
         {
            return -1;
         }
         return 0;
      }
      
      public function getChildTypeList(param1:int) : Array
      {
         var _loc2_:Array = [];
         for each(var _loc3_:ChildData in childList)
         {
            if(_loc3_.job == param1)
            {
               _loc2_.push(_loc3_);
            }
         }
         _loc2_.sortOn("growthGrade",0x10 | 2);
         return _loc2_;
      }
      
      public function getChildCollecInfoByType(param1:int) : ChildCollectInfo
      {
         for each(var _loc2_:ChildCollectInfo in collectionInfoList)
         {
            if(_loc2_.childType == param1)
            {
               return _loc2_;
            }
         }
         return null;
      }
      
      public function get curGrowthGrade() : int
      {
         var _loc2_:int = 0;
         var _loc4_:int = 0;
         var _loc3_:int = totalGrowth;
         var _loc5_:Array = TempleteManager.instance.getTemplatesByType(120);
         if(!_loc5_)
         {
            return _loc2_;
         }
         _loc5_.sortOn("Grades",16);
         var _loc1_:int = int(_loc5_.length);
         _loc4_ = 0;
         while(_loc4_ < _loc1_)
         {
            if(_loc3_ < _loc5_[_loc4_].Data)
            {
               return _loc4_;
            }
            _loc3_ -= _loc5_[_loc4_].Data;
            _loc4_++;
         }
         return _loc1_;
      }
      
      public function get selectedChildTemp() : ChildTempInfo
      {
         return _selectedChildTemp;
      }
      
      public function set selectedChildTemp(param1:ChildTempInfo) : void
      {
         if(_selectedChildTemp == param1)
         {
            return;
         }
         _selectedChildTemp = param1;
         MsgMan.notifyObserver("ChildEvent.CHILD_HANDBOOK_SELECT");
      }
      
      public function get selectItemTemp() : ChildTempInfo
      {
         return _selectItemTemp;
      }
      
      public function set selectItemTemp(param1:ChildTempInfo) : void
      {
         if(_selectItemTemp == param1)
         {
            return;
         }
         _selectItemTemp = param1;
         MsgMan.notifyObserver("ChildEvent.CHILD_ITEMTEMP_SELECT");
      }
      
      public function getChildIsAwakeByType(param1:int) : Boolean
      {
         for each(var _loc2_:ChildCollectInfo in collectionInfoList)
         {
            if(_loc2_.childType == param1 && _loc2_.soulWakes > 0)
            {
               return true;
            }
         }
         return false;
      }
      
      public function getHasAwakeChildList() : Array
      {
         var _loc2_:Array = [];
         for each(var _loc1_:ChildData in childList)
         {
            if(VersionSwitch.CHILD_ASSIST && _loc1_.childAssistAwakeLevel > 0)
            {
               _loc2_.push(_loc1_);
            }
            else if(getChildIsAwakeByType(_loc1_.job))
            {
               _loc2_.push(_loc1_);
            }
         }
         _loc2_.sortOn("growthGrade",16);
         return _loc2_;
      }
      
      public function getInChildCollectByType(param1:int, param2:int) : Boolean
      {
         for each(var _loc3_:ChildData in childList)
         {
            if(_loc3_.job == param1)
            {
               if(param2 == 1 && _loc3_.fightUserId == playerModel.playerInfo.userId && getChildCollecInfoByType(param2))
               {
                  return true;
               }
               if(param2 == 2 && _loc3_.fightSlaveUserId == playerModel.playerInfo.userId && getChildCollecInfoByType(param2))
               {
                  return true;
               }
            }
         }
         return false;
      }
      
      public function getSwitchChildListByChildId(param1:ChildData, param2:ChildData) : Array
      {
         var _loc3_:ChildTempInfo = null;
         var _loc5_:Array = [];
         if(!param1)
         {
            return _loc5_;
         }
         for each(var _loc4_:ChildData in childList)
         {
            _loc3_ = TempleteManager.instance.childTemplateCate.getTemplateByJobAndGrades(_loc4_.job,_loc4_.growthGrade);
            if(_loc3_.MasterType == 0)
            {
               if(_loc4_.job != param1.job)
               {
                  if(!(param2 && param2.childId == _loc4_.childId))
                  {
                     _loc5_.push(_loc4_);
                  }
               }
            }
         }
         _loc5_.sort(sortSwitchShow);
         return _loc5_;
      }
      
      private function sortSwitchShow(param1:ChildData, param2:ChildData) : int
      {
         if(param1.job > param2.job)
         {
            return -1;
         }
         if(param1.job < param2.job)
         {
            return 1;
         }
         if(param1.growthGrade > param2.growthGrade)
         {
            return -1;
         }
         return 1;
      }
      
      public function getComposeChildListByNeedJob(param1:ChildComposeTempInfo) : Array
      {
         var _loc2_:Array = [];
         var _loc3_:Array = param1.NeedJobType.split(",");
         for each(var _loc4_:ChildData in childList)
         {
            if(_loc3_.indexOf(_loc4_.job + "") != -1 && _loc4_.growthGrade >= param1.NeedGrade)
            {
               _loc2_.push(_loc4_);
            }
         }
         _loc2_.sortOn(["job","growthGrade"],[16,2]);
         return _loc2_;
      }
      
      public function get noNsChildList() : Array
      {
         var _loc1_:ChildTempInfo = null;
         var _loc2_:Array = [];
         for each(var _loc3_:ChildData in childList)
         {
            _loc1_ = TempleteManager.instance.childTemplateCate.getTemplateByJobAndGrades(_loc3_.job,_loc3_.growthGrade);
            if(_loc1_.MasterType != 1)
            {
               _loc2_.push(_loc3_);
            }
         }
         _loc2_.sortOn("growthGrade",0x10 | 2);
         return _loc2_;
      }
      
      public function get nsList() : Array
      {
         var _loc1_:ChildTempInfo = null;
         var _loc2_:Array = [];
         for each(var _loc3_:ChildData in childList)
         {
            _loc1_ = TempleteManager.instance.childTemplateCate.getTemplateByJobAndGrades(_loc3_.job,_loc3_.growthGrade);
            if(_loc1_.MasterType == 1)
            {
               _loc2_.push(_loc3_);
            }
         }
         _loc2_.sortOn("growthGrade",0x10 | 2);
         return _loc2_;
      }
      
      public function get nsAndChildList() : Array
      {
         var _loc1_:ChildTempInfo = null;
         var _loc2_:Array = [];
         var _loc3_:Array = [];
         for each(var _loc4_:ChildData in childList)
         {
            _loc1_ = TempleteManager.instance.childTemplateCate.getTemplateByJobAndGrades(_loc4_.job,_loc4_.growthGrade);
            if(_loc1_.MasterType == 1)
            {
               _loc3_.push(_loc4_);
            }
            else
            {
               _loc2_.push(_loc4_);
            }
         }
         _loc2_.sortOn("growthGrade",0x10 | 2);
         _loc3_.sortOn("growthGrade",0x10 | 2);
         return _loc3_.concat(_loc2_);
      }
      
      public function newSortByTypeAndGrade(param1:ChildData, param2:ChildData) : int
      {
         var _loc3_:ChildTempInfo = TempleteManager.instance.childTemplateCate.getTemplateByJobAndGrades(param1.job,param1.growthGrade);
         var _loc4_:ChildTempInfo = TempleteManager.instance.childTemplateCate.getTemplateByJobAndGrades(param2.job,param2.growthGrade);
         if(_loc3_.MasterType == 1 && _loc4_.MasterType != 1)
         {
            return -1;
         }
         if(_loc4_.MasterType == 1 && _loc3_.MasterType != 1)
         {
            return 1;
         }
         if(_loc3_.JobType < _loc4_.JobType)
         {
            return -1;
         }
         if(_loc3_.JobType > _loc4_.JobType)
         {
            return 1;
         }
         if(param1.growthGrade > param2.growthGrade)
         {
            return -1;
         }
         return 1;
      }
      
      public function getChildMaxGradeByJob(param1:int) : int
      {
         var _loc2_:Array = jobDic[param1];
         return _loc2_.length;
      }
   }
}

