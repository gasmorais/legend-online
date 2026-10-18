package yishi.datas.templates
{
   import bag.datas.GoodsSonType;
   import bag.helper.GoodsCheck;
   import yishi.datas.consant.JobType;
   import yishi.datas.consant.SexType;
   import yishi.datas.goods.GoodsProfile;
   import yishi.manager.PathManager;
   import yishi.manager.TempleteManager;
   
   public class GoodsTemplateInfo
   {
      
      public var TemplateId:int;
      
      public var MasterType:int;
      
      public var SonType:int;
      
      public var Sexs:int;
      
      public var NeedGrades:int;
      
      public var MaxCount:int;
      
      public var TemplateName:String;
      
      public var Job:String;
      
      public var Power:int;
      
      public var Agility:int;
      
      public var Intellect:int;
      
      public var Physique:int;
      
      public var Captain:int;
      
      public var Attack:int;
      
      public var Defence:int;
      
      public var MagicAttack:int;
      
      public var MagicDefence:int;
      
      public var ForceHit:int;
      
      public var StunAttr:int;
      
      public var Parry:int;
      
      public var Penetrate:int;
      
      public var Live:int;
      
      public var Conat:int;
      
      public var Property1:int;
      
      public var Property2:int;
      
      public var Property3:int;
      
      public var Property4:int;
      
      public var Property5:int;
      
      public var Property6:int;
      
      public var Property7:int;
      
      public var Icon:String;
      
      public var Description:String;
      
      public var Profile:int;
      
      public var SellGold:int;
      
      public var DefaultSkill:String;
      
      public var Avata:String;
      
      public var StrengthenMax:int;
      
      public var RandomSkillCount:int;
      
      public var SuiteId:int;
      
      public var Refresh:int;
      
      public var Feed:int;
      
      public var StartingPrice:int;
      
      public var TransformId:int;
      
      public var IsCanBatch:Boolean;
      
      public var Strength:int;
      
      public var Tenacity:int;
      
      public var ReduceResi:int;
      
      public var FireResi:int;
      
      public var WaterResi:int;
      
      public var ElectResi:int;
      
      public var WindResi:int;
      
      public var DarkResi:int;
      
      public var LightResi:int;
      
      public var NeedChangeJob:int;
      
      public var ReduceResiAgainst:int;
      
      public var ResiPenetrate:int;
      
      private var _isCanbeUpgrade:Boolean;
      
      private var _upGradeComposeTemId:int = 0;
      
      public function GoodsTemplateInfo()
      {
         super();
      }
      
      public function get iconPath() : String
      {
         return PathManager.resourcePath + "icon" + Icon;
      }
      
      public function get sonTypeName() : String
      {
         return GoodsSonType.getSonTypeName(SonType);
      }
      
      public function get profileColor() : uint
      {
         return GoodsProfile.getGoodsProfileColor(Profile);
      }
      
      public function get profileLetter() : String
      {
         return GoodsProfile.getGoodsProfileLetter(Profile);
      }
      
      public function get profileDescript() : String
      {
         return GoodsProfile.getGoodsProfileDescript(Profile);
      }
      
      public function get sexName() : String
      {
         return SexType.getSexDescript(Sexs);
      }
      
      public function get jobName() : String
      {
         if(GoodsCheck.isFashion(this))
         {
            return JobType.getJobName(0);
         }
         var _loc1_:String = "";
         var _loc2_:Array = Job.split(",");
         for each(var _loc3_:int in _loc2_)
         {
            _loc1_ += JobType.getJobName(_loc3_) + "，";
         }
         return _loc1_.slice(0,_loc1_.length - 1);
      }
      
      public function get totalAttribute() : Number
      {
         return Attack + Defence + MagicAttack + MagicDefence + ForceHit + Live + Captain + Parry;
      }
      
      public function get isCanbeUpgrade() : Boolean
      {
         if(MasterType == 1 && SuiteId > 0 && NeedGrades >= 40 && Profile == 4 && NeedGrades % 10 == 0)
         {
            return true;
         }
         if(MasterType == 1 && GoodsSonType.checkNewEquip(this) && Profile <= 5)
         {
            return true;
         }
         return false;
      }
      
      public function get upGradeComposeTemId() : int
      {
         var _loc1_:ComposeGoodsTemplete = TempleteManager.instance.getEquipUpdateComposeTempleteByMainMaterialId(TemplateId);
         if(_loc1_)
         {
            _upGradeComposeTemId = _loc1_.Id;
         }
         return _upGradeComposeTemId;
      }
      
      public function get isUnrestrictedEquip() : Boolean
      {
         if(MasterType == 1)
         {
            if(GoodsCheck.isBasicEquip(this))
            {
               if(Job == "0")
               {
                  return true;
               }
            }
         }
         return false;
      }
      
      public function get isThreeEquip() : Boolean
      {
         if(MasterType == 1 && !GoodsCheck.isFashion(this))
         {
            if(Profile == 7)
            {
               return true;
            }
         }
         return false;
      }
      
      public function get isSeniorEquip() : Boolean
      {
         if(MasterType == 1 && !GoodsCheck.isFashion(this))
         {
            if(Profile == 6)
            {
               return true;
            }
         }
         return false;
      }
      
      public function get isViceEquip() : Boolean
      {
         if(MasterType == 1)
         {
            if(GoodsCheck.isFashion(this))
            {
               if(Job == "99")
               {
                  return true;
               }
            }
            else if(Job == "99")
            {
               return true;
            }
         }
         return false;
      }
      
      public function get hasValueAtt() : Array
      {
         var _loc1_:Array = [];
         if(Power != 0)
         {
            _loc1_.push("Power");
         }
         if(Agility != 0)
         {
            _loc1_.push("Agility");
         }
         if(Intellect != 0)
         {
            _loc1_.push("Intellect");
         }
         if(Physique != 0)
         {
            _loc1_.push("Physique");
         }
         if(Captain != 0)
         {
            _loc1_.push("Captain");
         }
         if(Attack != 0)
         {
            _loc1_.push("Attack");
         }
         if(Defence != 0)
         {
            _loc1_.push("Defence");
         }
         if(MagicAttack != 0)
         {
            _loc1_.push("MagicAttack");
         }
         if(MagicDefence != 0)
         {
            _loc1_.push("MagicDefence");
         }
         if(ForceHit != 0)
         {
            _loc1_.push("ForceHit");
         }
         if(StunAttr != 0)
         {
            _loc1_.push("StunAttr");
         }
         if(Parry != 0)
         {
            _loc1_.push("Parry");
         }
         if(Penetrate != 0)
         {
            _loc1_.push("Penetrate");
         }
         if(Live != 0)
         {
            _loc1_.push("Live");
         }
         if(Conat != 0)
         {
            _loc1_.push("Conat");
         }
         return _loc1_;
      }
      
      public function get hasValueAttResi() : Array
      {
         var _loc1_:Array = [];
         if(ReduceResi != 0)
         {
            _loc1_.push("ReduceResi");
         }
         if(FireResi != 0)
         {
            _loc1_.push("FireResi");
         }
         if(WaterResi != 0)
         {
            _loc1_.push("WaterResi");
         }
         if(ElectResi != 0)
         {
            _loc1_.push("ElectResi");
         }
         if(WindResi != 0)
         {
            _loc1_.push("WindResi");
         }
         if(DarkResi != 0)
         {
            _loc1_.push("DarkResi");
         }
         if(LightResi != 0)
         {
            _loc1_.push("LightResi");
         }
         return _loc1_;
      }
   }
}

