package mvc.module.dragonTitan
{
   import com.road.yishi.proto.titan.TitanInjectMsg;
   import flash.utils.Dictionary;
   import yishi.datas.ConfigInfoManager;
   import yishi.datas.templates.DragonTitanTempInfo;
   import yishi.datas.templates.SkillTempInfo;
   import yishi.manager.TempleteManager;
   
   public class DragonTitanModel
   {
      
      public static const UPGRADE_TYPE:int = 116;
      
      public static const TITAN_STONE_ID:int = 208054;
      
      public static const TITAN_INJECT_ID:int = 208059;
      
      public static const TITAN_CHARGE_ID:int = 208060;
      
      public static const TITAN_DATA_CHECK:String = "TITAN_DATA_CHECK";
      
      public var userId:int;
      
      public var templateId:int = 0;
      
      public var starExp:int = 0;
      
      public var starLevel:int = 0;
      
      public var devourTitan:Array = [];
      
      public var skillId0:Array = [];
      
      public var skillId1:Array = [];
      
      public var skillId2:Array = [];
      
      public var curUseSkillIndex:int = 0;
      
      private var _comboxIndex:int;
      
      public var attack:int = 0;
      
      public var defence:int = 0;
      
      public var magicAttack:int = 0;
      
      public var magicDefence:int = 0;
      
      public var live:int = 0;
      
      public var forceHit:int = 0;
      
      public var parry:int = 0;
      
      public var strength:int = 0;
      
      public var tenacity:int = 0;
      
      public var reduceResi:int = 0;
      
      public var fireResi:int = 0;
      
      public var waterResi:int = 0;
      
      public var electResi:int = 0;
      
      public var windResi:int = 0;
      
      public var darkResi:int = 0;
      
      public var lightResi:int = 0;
      
      public var penetrate:int = 0;
      
      public var stunAttr:int = 0;
      
      private var _injectData:Array;
      
      public var injectGrade:int = 0;
      
      public var injectCount:int = 0;
      
      private var _chargeGrade:int = 0;
      
      public var reduceResiGp:int = 0;
      
      public var fireResiGp:int = 0;
      
      public var waterResiGp:int = 0;
      
      public var electResiGp:int = 0;
      
      public var windResiGp:int = 0;
      
      public var darkResiGp:int = 0;
      
      public var lightResiGp:int = 0;
      
      public var chargeInfo:DragonTitanChargeInfo = new DragonTitanChargeInfo();
      
      private var _titanIds:Array;
      
      private var _titanInfoDic:Dictionary = new Dictionary();
      
      private var _viewTitanId:int = -1;
      
      private var _currentViewIndex:int = 0;
      
      public function DragonTitanModel()
      {
         super();
      }
      
      public function get currentViewIndex() : int
      {
         return _currentViewIndex;
      }
      
      public function set currentViewIndex(param1:int) : void
      {
         _titanIds = null;
         _currentViewIndex = param1;
      }
      
      public function get chargeGrade() : int
      {
         return _chargeGrade;
      }
      
      public function set chargeGrade(param1:int) : void
      {
         _chargeGrade = param1 + ConfigInfoManager.instance.getKeyToInt("titan_charge_grade_base_Grade");
      }
      
      public function set viewTitanId(param1:int) : void
      {
         _viewTitanId = param1;
      }
      
      public function get viewTitanId() : int
      {
         if(_viewTitanId == -1)
         {
            _viewTitanId = titanAllIds[0];
         }
         return _viewTitanId;
      }
      
      public function getTitanIdMaxStar() : int
      {
         var _loc3_:int = 0;
         var _loc2_:DragonTitanTempInfo = null;
         var _loc1_:int = 0;
         _loc3_ = 0;
         while(_loc3_ < devourTitan.length)
         {
            _loc2_ = TempleteManager.instance.titanTemplateCate.getTemplateById(devourTitan[_loc3_]);
            _loc1_ += _loc2_.QualiLimit;
            _loc3_++;
         }
         return _loc1_;
      }
      
      public function set injectData(param1:Array) : void
      {
         var _loc3_:DragonTitanInjectInfo = null;
         if(param1 && param1.length > 0)
         {
            for each(var _loc2_:TitanInjectMsg in param1)
            {
               _loc3_ = getTaitanInjectInfo(_loc2_.titanId);
               if(_loc3_)
               {
                  _loc3_.thisTitanInjectGrade = _loc2_.grade;
               }
            }
         }
      }
      
      public function updateViewInfo() : void
      {
         var _loc3_:int = 0;
         var _loc2_:int = 0;
         var _loc4_:DragonTitanTempInfo = null;
         var _loc1_:DragonTitanInjectInfo = null;
         var _loc5_:Array = getTitanList();
         _loc3_ = 0;
         _loc2_ = int(_loc5_.length);
         while(_loc3_ < _loc2_)
         {
            _loc4_ = _loc5_[_loc3_];
            _loc1_ = getTaitanInjectInfo(_loc4_.TemplateId);
            _loc1_.update(this,_loc4_.TemplateId);
            _loc3_++;
         }
         chargeInfo.update(this);
         _titanIds = null;
      }
      
      public function get titanAllIds() : Array
      {
         var _loc1_:Array = null;
         var _loc4_:Array = null;
         var _loc5_:Array = null;
         var _loc2_:int = 0;
         var _loc3_:DragonTitanTempInfo = null;
         if(!_titanIds)
         {
            _loc1_ = [];
            _loc4_ = [];
            _loc5_ = getTitanList();
            _loc2_ = 0;
            while(_loc2_ < _loc5_.length)
            {
               _loc3_ = DragonTitanTempInfo(_loc5_[_loc2_]);
               _loc3_.isActive ? _loc4_.push(_loc3_.TemplateId) : _loc1_.push(_loc3_.TemplateId);
               _loc2_++;
            }
            if(_currentViewIndex == 2)
            {
               _titanIds = _loc1_.length > 0 ? _loc1_ : _loc4_;
            }
            else
            {
               _titanIds = _loc4_;
            }
            if(_titanIds == _loc1_ && _loc1_.indexOf(viewTitanId) == -1)
            {
               viewTitanId = _loc1_[0];
            }
         }
         return _titanIds;
      }
      
      public function getSteps() : int
      {
         return starLevel / 10;
      }
      
      public function getStars() : int
      {
         return starLevel % 10;
      }
      
      public function getSkillTempInfoByTitanId(param1:int) : SkillTempInfo
      {
         if(param1 <= 0)
         {
            return null;
         }
         var _loc3_:DragonTitanTempInfo = TempleteManager.instance.titanTemplateCate.getTemplateById(param1);
         return TempleteManager.instance.getSkillById(parseInt(_loc3_.SkillIds));
      }
      
      public function getTitanIdBySkillId(param1:int) : int
      {
         var _loc3_:int = 0;
         var _loc2_:DragonTitanTempInfo = null;
         _loc3_ = 0;
         while(_loc3_ < devourTitan.length)
         {
            _loc2_ = TempleteManager.instance.titanTemplateCate.getTemplateById(devourTitan[_loc3_]);
            if(_loc2_.SkillIds == param1 + "")
            {
               return _loc2_.TemplateId;
            }
            _loc3_++;
         }
         return 0;
      }
      
      public function getTaitanInjectInfo(param1:int) : DragonTitanInjectInfo
      {
         var _loc2_:DragonTitanInjectInfo = null;
         if(!getTitanDic()[param1])
         {
            return null;
         }
         if(!_titanInfoDic[param1])
         {
            _loc2_ = new DragonTitanInjectInfo();
            _loc2_.titianId = param1;
            _titanInfoDic[param1] = _loc2_;
         }
         return _titanInfoDic[param1];
      }
      
      public function updateTitanActiveState() : void
      {
         var _loc4_:DragonTitanTempInfo = null;
         var _loc1_:DragonTitanInjectInfo = null;
         var _loc3_:Dictionary = getTitanDic();
         for each(var _loc2_:int in devourTitan)
         {
            _loc4_ = _loc3_[_loc2_];
            if(_loc4_)
            {
               _loc4_.isActive = true;
            }
            _loc1_ = getTaitanInjectInfo(_loc2_);
            if(_loc1_)
            {
               _loc1_.isActive = true;
            }
         }
      }
      
      public function getTitanList() : Array
      {
         return TempleteManager.instance.titanTemplateCate.getTitanList();
      }
      
      public function getTitanDic() : Dictionary
      {
         getTitanList();
         return TempleteManager.instance.titanTemplateCate.dic;
      }
      
      public function getIsSkillGroupActive(param1:Array) : Boolean
      {
         var _loc2_:int = 0;
         _loc2_ = 0;
         while(_loc2_ < param1.length)
         {
            if(param1[_loc2_] != -1)
            {
               return true;
            }
            _loc2_++;
         }
         return false;
      }
      
      public function get skillGroupArr() : Array
      {
         return [skillId0,skillId1,skillId2];
      }
      
      public function get comboxIndex() : int
      {
         return _comboxIndex;
      }
      
      public function set comboxIndex(param1:int) : void
      {
         _comboxIndex = param1;
      }
   }
}

