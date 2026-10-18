package mvc.module.monsterexplore
{
   import flash.utils.Dictionary;
   import mvc.module.monster.MonsterInfo;
   import mvc.module.monster.MonsterModel;
   import yishi.datas.templates.MonsterExploreTempInfo;
   import yishi.manager.MonsterManager;
   import yishi.manager.TempleteManager;
   import yishi.utils.SimpleDictionary;
   
   public class MonsterExploreModel
   {
      
      public static const WALK_TOTAL_TIME:int = 10;
      
      public var keepWalk:Boolean;
      
      public var exploreMonsterDic:SimpleDictionary;
      
      public var formationDic:SimpleDictionary;
      
      public var curChapterId:int;
      
      public var maxChapterId:int;
      
      public var curNodeId:int;
      
      public var maxNodeId:int;
      
      public var isNodeSwitch:Boolean;
      
      public var isEditSwitch:Boolean;
      
      public var nodeSwitchMcState:Boolean;
      
      public var fastTotalCount:int;
      
      public var fastUserCount:int;
      
      public var bossHasCount:int;
      
      private var hasInitTemp:Boolean = false;
      
      public var exploreNodeTempDic:Dictionary;
      
      public var chapterTempDic:SimpleDictionary;
      
      public var selfBattleList:Array;
      
      public var vsBattleList:Array;
      
      public var levelIdAry:Array;
      
      public var exploreState:int;
      
      public var stateTime:int;
      
      public var bossWinReward:String = null;
      
      public function MonsterExploreModel()
      {
         super();
         exploreMonsterDic = new SimpleDictionary(true);
         formationDic = new SimpleDictionary(true);
         exploreNodeTempDic = new Dictionary();
         chapterTempDic = new SimpleDictionary();
         selfBattleList = [];
         vsBattleList = [];
         levelIdAry = [];
      }
      
      public function initChatpterTempInfo() : void
      {
         if(hasInitTemp)
         {
            return;
         }
         for each(var _loc1_:MonsterExploreTempInfo in TempleteManager.instance.monsterExploreTemplateCate.getTemplates())
         {
            if(!exploreNodeTempDic[_loc1_.ChapterId])
            {
               exploreNodeTempDic[_loc1_.ChapterId] = [];
            }
            exploreNodeTempDic[_loc1_.ChapterId].push(_loc1_);
            if(_loc1_.NodeId == 1 && !chapterTempDic[_loc1_.ChapterId])
            {
               chapterTempDic.add(_loc1_.ChapterId,_loc1_);
            }
         }
         hasInitTemp = true;
      }
      
      public function get selectViewList() : Array
      {
         var _loc1_:Array = [];
         for each(var _loc2_:MonsterInfo in monsterModel.showMonsterList)
         {
            if(!formationDic[_loc2_.monsterId])
            {
               _loc1_.push(_loc2_);
            }
         }
         _loc1_.sortOn("firstValue",0x10 | 2);
         return _loc1_;
      }
      
      public function getFormationInfoByIndex(param1:int) : MonsterExploreFormationInfo
      {
         for each(var _loc2_:MonsterExploreFormationInfo in formationDic)
         {
            if(_loc2_.index == param1)
            {
               return _loc2_;
            }
         }
         return null;
      }
      
      public function getHeadFormationInfoByIndex(param1:int) : MonsterExploreFormationInfo
      {
         for each(var _loc2_:MonsterExploreFormationInfo in exploreMonsterDic)
         {
            if(_loc2_.index == param1)
            {
               return _loc2_;
            }
         }
         return null;
      }
      
      public function getFormationInfoByFightPos(param1:int) : MonsterExploreFormationInfo
      {
         for each(var _loc2_:MonsterExploreFormationInfo in formationDic)
         {
            if(_loc2_.fightPos == param1)
            {
               return _loc2_;
            }
         }
         return null;
      }
      
      public function canChallengeBoss() : Boolean
      {
         for each(var _loc1_:MonsterExploreFormationInfo in exploreMonsterDic)
         {
            if(_loc1_.isCaptain)
            {
               return true;
            }
         }
         return false;
      }
      
      public function copyFormationDicData() : void
      {
         var _loc1_:MonsterExploreFormationInfo = null;
         formationDic.clear();
         for each(var _loc2_:MonsterExploreFormationInfo in exploreMonsterDic)
         {
            _loc1_ = new MonsterExploreFormationInfo();
            _loc1_.index = _loc2_.index;
            _loc1_.monsterId = _loc2_.monsterId;
            _loc1_.fightPos = _loc2_.fightPos;
            _loc1_.isCaptain = _loc2_.isCaptain;
            formationDic.add(_loc1_.monsterId,_loc1_);
         }
      }
      
      public function checkFormationDicIsSame() : Boolean
      {
         var _loc1_:MonsterExploreFormationInfo = null;
         if(exploreMonsterDic.getList().length != formationDic.getList().length)
         {
            return false;
         }
         for each(var _loc2_:MonsterExploreFormationInfo in exploreMonsterDic)
         {
            _loc1_ = formationDic[_loc2_.monsterId];
            if(!_loc1_)
            {
               return false;
            }
            if(_loc1_.fightPos != _loc2_.fightPos)
            {
               return false;
            }
            if(_loc1_.index != _loc2_.index)
            {
               return false;
            }
            if(_loc1_.isCaptain != _loc2_.isCaptain)
            {
               return false;
            }
         }
         return true;
      }
      
      public function get moveSpeed() : Number
      {
         return 0.0475;
      }
      
      private function get monsterModel() : MonsterModel
      {
         return MonsterManager.instance.model;
      }
      
      public function getBattleInfoByIndex(param1:int, param2:int) : MonsterExploreBattleInfo
      {
         var _loc3_:Array = param1 == 1 ? selfBattleList : vsBattleList;
         for each(var _loc4_:MonsterExploreBattleInfo in _loc3_)
         {
            if(_loc4_.index == param2)
            {
               return _loc4_;
            }
         }
         return null;
      }
   }
}

