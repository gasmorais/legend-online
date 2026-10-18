package battle.data
{
   import flash.utils.Dictionary;
   import yishi.datas.templates.SkillTempInfo;
   import yishi.manager.TempleteManager;
   
   public class SkillData
   {
      
      public static const NEWBIE_BOSS_MORPH_RESPATH:String = "boss032a";
      
      public static const NEWBIE_BOSS_MORPH_SKILL:int = 650493;
      
      public static const NEWBIE_BOSS_TEMPID:int = 1008;
      
      public static const NEWBIE_BOSSII_TEMPID:int = 1009;
      
      public static const SKILL_ID_1:int = 1;
      
      public static const SKILL_ID_2:int = 2;
      
      public static const SKILL_ID_3:int = 3;
      
      public static const SKILL_ID_4:int = 4;
      
      public static const SKILL_ID_101:int = 101;
      
      public static const SKILL_ID_102:int = 102;
      
      public static const SKILL_ID_103:int = 103;
      
      public static const SKILL_ID_104:int = 104;
      
      public static const PET_MORPH_SKILL:int = 700001;
      
      public static const PET_UNMORPH_SKILL:int = 700002;
      
      public static const CHILD_MORPH_SKILL:int = 700003;
      
      public static const CHILD_UNMORPH_SKILL:int = 700004;
      
      private static var _globalIndexId:int;
      
      public static const SKILL_SONTYPE_TALENT_ARR:Array = [1001,2001,3001];
      
      public var battleId:String;
      
      public var skillId:int;
      
      public var fId:int;
      
      public var liftTime:int = 0;
      
      public var data:Array;
      
      public var processStrategy:int;
      
      public var sp:int;
      
      public var spAdded:int;
      
      public var hitPoint:int;
      
      public var hitPointAdded:int;
      
      public var passive:Boolean;
      
      public var buffers:Vector.<BufferDamageData>;
      
      public var skillBuffers:Vector.<BufferDamageData>;
      
      public var awakens:Array;
      
      public var river:int;
      
      public var attackMillis:Number;
      
      public var willKillSomeBody:Boolean;
      
      private var _hurtStats:Dictionary;
      
      private var _hurtRoleIds:Array;
      
      public var coexistType:int = 0;
      
      private var _indexId:int;
      
      public var reliveList:Vector.<ReliveInfo> = new Vector.<ReliveInfo>();
      
      public var hurtDataList:Array = [];
      
      public function SkillData()
      {
         super();
         _hurtStats = new Dictionary(true);
         _indexId = _globalIndexId++;
      }
      
      public static function resetIndexId() : void
      {
         _globalIndexId = 0;
      }
      
      public function get indexId() : int
      {
         return _indexId;
      }
      
      public function getHurtValue(param1:int) : int
      {
         if(_hurtStats[param1])
         {
            return _hurtStats[param1];
         }
         return 0;
      }
      
      public function recordHurtData(param1:int, param2:int) : void
      {
         if(_hurtStats[param1] == undefined)
         {
            _hurtStats[param1] = 0;
         }
         var _loc3_:int = param1;
         var _loc4_:Number = _hurtStats[_loc3_] + param2;
         _hurtStats[_loc3_] = _loc4_;
      }
      
      public function getHurtRoles() : Array
      {
         if(_hurtRoleIds)
         {
            return _hurtRoleIds;
         }
         _hurtRoleIds = [];
         for(var _loc1_ in _hurtStats)
         {
            _hurtRoleIds.push(_loc1_);
         }
         return _hurtRoleIds;
      }
      
      public function get skillTemp() : SkillTempInfo
      {
         return TempleteManager.instance.getSkillTemplateInfoById(skillId);
      }
   }
}

