package mvc.module.childpatrol
{
   import mvc.module.children.ChildData;
   import yishi.datas.goods.GoodsInfo;
   import yishi.datas.templates.ChildPatrolMissionTemplateInfo;
   import yishi.datas.templates.GoodsTemplateInfo;
   import yishi.datas.templates.SkillTempInfo;
   import yishi.manager.GoodsManager;
   import yishi.manager.TempleteManager;
   
   public class ChildPatrolCheckCondictionHelper
   {
      
      public function ChildPatrolCheckCondictionHelper()
      {
         super();
      }
      
      public static function checkCondictionIsReached(param1:ChildPatrolMissionTemplateInfo, param2:Array) : Boolean
      {
         var _loc5_:int = 0;
         var _loc6_:int = 0;
         var _loc4_:int = param1.NeedJob.length;
         var _loc8_:Array = param1.NeedJob.split(",");
         var _loc7_:Function = checkCondictionByType(param1);
         var _loc3_:int = 0;
         for each(var _loc9_:ChildData in param2)
         {
            if(!(_loc4_ != 0 && _loc8_.indexOf(_loc9_.job.toString()) == -1))
            {
               _loc3_++;
               if(_loc7_ == null)
               {
                  return true;
               }
               if(_loc7_(_loc9_) > _loc5_)
               {
                  _loc5_ = _loc7_(_loc9_);
               }
               _loc6_ += _loc7_(_loc9_);
            }
         }
         if(_loc3_ <= 0)
         {
            return false;
         }
         if(param1.CalcType == 1)
         {
            return param1.TargetValue <= _loc5_;
         }
         if(param1.CalcType == 2)
         {
            return param1.TargetValue <= _loc6_;
         }
         return false;
      }
      
      public static function checkCondictionByType(param1:ChildPatrolMissionTemplateInfo) : Function
      {
         switch(param1.MissionType)
         {
            case 0:
               return null;
            case 1:
               return getChildSkillGradesData;
            case 2:
               return getChildGradesData;
            case 3:
               return getChildEmbleLvData;
            case 4:
               return getChildReduceResiData;
            case 5:
               return getChildFireResiData;
            case 6:
               return getChildWaterResiData;
            case 7:
               return getChildElectResiData;
            case 8:
               return getChildWindResiData;
            case 9:
               return getChildDarkResiData;
            case 10:
               return getChildLightResiData;
            case 11:
               return getChildEquipQualityData;
            default:
               return null;
         }
      }
      
      public static function getChildSkillGradesData(param1:ChildData) : int
      {
         var _loc2_:int = 0;
         var _loc5_:int = 0;
         var _loc7_:int = 0;
         var _loc3_:int = 0;
         var _loc6_:SkillTempInfo = null;
         var _loc4_:Array = param1.skill.split(",");
         if(param1.skill == "")
         {
            _loc5_ = 0;
         }
         else
         {
            _loc5_ = int(_loc4_.length);
         }
         _loc7_ = 0;
         while(_loc7_ < _loc5_)
         {
            _loc3_ = int(_loc4_[_loc7_]);
            _loc6_ = TempleteManager.instance.getSkillById(_loc3_);
            if(_loc6_.Grades > _loc2_)
            {
               _loc2_ = _loc6_.Grades;
            }
            _loc7_++;
         }
         return _loc2_;
      }
      
      public static function getChildGradesData(param1:ChildData) : int
      {
         return param1.growthGrade;
      }
      
      public static function getChildEmbleLvData(param1:ChildData) : int
      {
         return param1.emblemLv;
      }
      
      public static function getChildReduceResiData(param1:ChildData) : int
      {
         return param1.ResiValueArr[0];
      }
      
      public static function getChildFireResiData(param1:ChildData) : int
      {
         return param1.ResiValueArr[1];
      }
      
      public static function getChildWaterResiData(param1:ChildData) : int
      {
         return param1.ResiValueArr[2];
      }
      
      public static function getChildElectResiData(param1:ChildData) : int
      {
         return param1.ResiValueArr[3];
      }
      
      public static function getChildWindResiData(param1:ChildData) : int
      {
         return param1.ResiValueArr[4];
      }
      
      public static function getChildDarkResiData(param1:ChildData) : int
      {
         return param1.ResiValueArr[5];
      }
      
      public static function getChildLightResiData(param1:ChildData) : int
      {
         return param1.ResiValueArr[6];
      }
      
      public static function getChildEquipQualityData(param1:ChildData) : int
      {
         var _loc2_:int = 0;
         var _loc5_:GoodsInfo = null;
         var _loc3_:GoodsTemplateInfo = null;
         var _loc4_:int = 0;
         _loc4_ = 0;
         while(_loc4_ < 8)
         {
            _loc5_ = GoodsManager.instance.getItemByPOB(_loc4_,param1.childId,30);
            if(_loc5_)
            {
               _loc3_ = TempleteManager.instance.goodsTemplateCate.getTemplateByID(_loc5_.templateId);
               if(_loc3_)
               {
                  if(_loc3_.Profile > _loc2_)
                  {
                     _loc2_ = _loc3_.Profile;
                  }
               }
            }
            _loc4_++;
         }
         return _loc2_;
      }
   }
}

