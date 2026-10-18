package mvc.module.stele
{
   import yishi.datas.templates.SkillPropertyTempInfo;
   import yishi.datas.templates.StelaPropertyTemplateInfo;
   import yishi.datas.templates.StelaResistTemplateInfo;
   import yishi.datas.templates.StelaStepTemplateInfo;
   import yishi.datas.templates.StelaTemplateInfo;
   import yishi.manager.TempleteManager;
   import yishi.utils.GoodsHelp;
   import yishi.utils.StringHelper;
   
   public class StelesysInfo
   {
      
      public var id:int;
      
      public var pos:int;
      
      public var exp:int;
      
      public var totalExp:int;
      
      public var skill1:int;
      
      public var skill2:int;
      
      public var skill3:int;
      
      public var skill4:int;
      
      public var skill5:int;
      
      public var isExist:Boolean;
      
      public var isChoose:Boolean;
      
      public var tempUse:int;
      
      private var _templateId:int;
      
      private var _tempInfo:StelaTemplateInfo;
      
      private var _star:int;
      
      private var _resistTempList:Array;
      
      private var _step:int = -2;
      
      private var _stepTempInfo:StelaStepTemplateInfo;
      
      private var _stepColor:int;
      
      private var _nextStepTempInfo:StelaStepTemplateInfo;
      
      private var _level:int = -1;
      
      private var _strengTempInfo:StelaPropertyTemplateInfo;
      
      private var _preStrengtempInfo:StelaPropertyTemplateInfo;
      
      private var _nextStrengTempInfo:StelaPropertyTemplateInfo;
      
      private var _stelaAttInfo:StelaAttInfo;
      
      private var _skillAttInfo:StelaAttInfo;
      
      public function StelesysInfo()
      {
         super();
         _stelaAttInfo = new StelaAttInfo();
         _skillAttInfo = new StelaAttInfo();
      }
      
      public function get templateId() : int
      {
         return _templateId;
      }
      
      public function set templateId(param1:int) : void
      {
         if(_templateId == param1)
         {
            return;
         }
         _templateId = param1;
         _tempInfo = TempleteManager.instance.stelaTempCate.getTemplateById(_templateId);
         _resistTempList = TempleteManager.instance.stelaResistTempCate.getListById(_templateId);
         if(_tempInfo)
         {
            _star = _tempInfo.Rarity;
         }
      }
      
      public function get resistTempList() : Array
      {
         return _resistTempList;
      }
      
      public function get resistAttObj() : Array
      {
         var _loc5_:int = 0;
         var _loc4_:int = 0;
         var _loc6_:StelaResistTemplateInfo = null;
         var _loc3_:int = 0;
         var _loc1_:Array = [_loc5_,_loc4_];
         var _loc2_:int = int(_resistTempList ? _resistTempList.length : 0);
         _loc3_ = 0;
         while(_loc3_ < _loc2_)
         {
            _loc6_ = _resistTempList[_loc3_];
            if(_level >= _loc6_.StrengthLevel)
            {
               _loc5_ += _loc6_.skillProTempInfo.ResiPenetrate;
               _loc4_ += _loc6_.skillProTempInfo.ReduceResiAgainst;
            }
            _loc3_++;
         }
         _loc1_[0] = _loc5_;
         _loc1_[1] = _loc4_;
         return _loc1_;
      }
      
      public function get isOnEquip() : Boolean
      {
         var _loc1_:Boolean = false;
         if(pos >= 1 && pos <= 10)
         {
            _loc1_ = true;
         }
         return _loc1_;
      }
      
      public function get isCurrMaxLv() : Boolean
      {
         var _loc1_:Boolean = false;
         if(level == _stepTempInfo.StrengthLimit)
         {
            _loc1_ = true;
         }
         return _loc1_;
      }
      
      public function get tempInfo() : StelaTemplateInfo
      {
         return _tempInfo;
      }
      
      public function get step() : int
      {
         return _step;
      }
      
      public function set step(param1:int) : void
      {
         if(param1 == -1)
         {
            _step = param1;
            return;
         }
         if(_step == param1)
         {
            return;
         }
         _step = param1;
         _stepTempInfo = TempleteManager.instance.stelaStepTempCate.getTemplateById(_templateId,_step);
         _nextStepTempInfo = TempleteManager.instance.stelaStepTempCate.getTemplateById(_templateId,_step + 1);
         if(_stepTempInfo)
         {
            _stepColor = _stepTempInfo.Profile;
         }
      }
      
      public function get stepTempInfo() : StelaStepTemplateInfo
      {
         return _stepTempInfo;
      }
      
      public function get nextStepTempInfo() : StelaStepTemplateInfo
      {
         return _nextStepTempInfo;
      }
      
      public function get level() : int
      {
         return _level;
      }
      
      public function set level(param1:int) : void
      {
         if(_level == param1)
         {
            return;
         }
         _level = param1;
         _preStrengtempInfo = TempleteManager.instance.stelaPropertyTempCate.getTemplateById(_templateId,_level - 1);
         _strengTempInfo = TempleteManager.instance.stelaPropertyTempCate.getTemplateById(_templateId,_level);
         _nextStrengTempInfo = TempleteManager.instance.stelaPropertyTempCate.getTemplateById(_templateId,_level + 1);
      }
      
      public function get strengTempInfo() : StelaPropertyTemplateInfo
      {
         return _strengTempInfo;
      }
      
      public function get nextStrengTempInfo() : StelaPropertyTemplateInfo
      {
         return _nextStrengTempInfo;
      }
      
      public function get currStrengthLvExp() : int
      {
         if(_nextStrengTempInfo == null)
         {
            return _strengTempInfo.Exp;
         }
         var _loc1_:int = _nextStrengTempInfo.Exp;
         if(_strengTempInfo != null)
         {
            _loc1_ -= _strengTempInfo.Exp;
         }
         return _loc1_;
      }
      
      public function get stelaAttInfo() : StelaAttInfo
      {
         return _stelaAttInfo;
      }
      
      public function get skillAttInfo() : StelaAttInfo
      {
         return _skillAttInfo;
      }
      
      public function get nextIntensifyAttInfo() : StelaAttInfo
      {
         var _loc1_:StelaAttInfo = new StelaAttInfo();
         if(_nextStrengTempInfo)
         {
            _loc1_.Attack += _nextStrengTempInfo.Attack;
            _loc1_.Defence += _nextStrengTempInfo.Defence;
            _loc1_.MagicAttack += _nextStrengTempInfo.MagicAttack;
            _loc1_.MagicDefence += _nextStrengTempInfo.MagicDefence;
            _loc1_.Live += _nextStrengTempInfo.Live;
            _loc1_.ForceHit += _nextStrengTempInfo.ForceHit;
            _loc1_.Parry += _nextStrengTempInfo.Parry;
            _loc1_.Penetrate += _nextStrengTempInfo.Penetrate;
            _loc1_.ReduceResiAgainst += _nextStrengTempInfo.ReduceResiAgainst;
            _loc1_.ResiPenetrate += _nextStrengTempInfo.ResiPenetrate;
         }
         if(_stepTempInfo)
         {
            _loc1_.Attack += _stepTempInfo.Attack;
            _loc1_.Defence += _stepTempInfo.Defence;
            _loc1_.MagicAttack += _stepTempInfo.MagicAttack;
            _loc1_.MagicDefence += _stepTempInfo.MagicDefence;
            _loc1_.Live += _stepTempInfo.Live;
            _loc1_.ForceHit += _stepTempInfo.ForceHit;
            _loc1_.Parry += _stepTempInfo.Parry;
            _loc1_.Penetrate += _stepTempInfo.Penetrate;
            _loc1_.ReduceResiAgainst += _stepTempInfo.ReduceResiAgainst;
            _loc1_.ResiPenetrate += _stepTempInfo.ResiPenetrate;
         }
         return _loc1_;
      }
      
      public function updateStelaAttInfo() : void
      {
         _stelaAttInfo.reset();
         if(_strengTempInfo)
         {
            _stelaAttInfo.Attack += _strengTempInfo.Attack;
            _stelaAttInfo.Defence += _strengTempInfo.Defence;
            _stelaAttInfo.MagicAttack += _strengTempInfo.MagicAttack;
            _stelaAttInfo.MagicDefence += _strengTempInfo.MagicDefence;
            _stelaAttInfo.Live += _strengTempInfo.Live;
            _stelaAttInfo.ForceHit += _strengTempInfo.ForceHit;
            _stelaAttInfo.Parry += _strengTempInfo.Parry;
            _stelaAttInfo.Penetrate += _strengTempInfo.Penetrate;
            _stelaAttInfo.ReduceResiAgainst += _strengTempInfo.ReduceResiAgainst;
            _stelaAttInfo.ResiPenetrate += _strengTempInfo.ResiPenetrate;
         }
         if(_stepTempInfo)
         {
            _stelaAttInfo.Attack += _stepTempInfo.Attack;
            _stelaAttInfo.Defence += _stepTempInfo.Defence;
            _stelaAttInfo.MagicAttack += _stepTempInfo.MagicAttack;
            _stelaAttInfo.MagicDefence += _stepTempInfo.MagicDefence;
            _stelaAttInfo.Live += _stepTempInfo.Live;
            _stelaAttInfo.ForceHit += _stepTempInfo.ForceHit;
            _stelaAttInfo.Parry += _stepTempInfo.Parry;
            _stelaAttInfo.Penetrate += _stepTempInfo.Penetrate;
            _stelaAttInfo.ReduceResiAgainst += _stepTempInfo.ReduceResiAgainst;
            _stelaAttInfo.ResiPenetrate += _stepTempInfo.ResiPenetrate;
         }
         var _loc1_:Array = this.resistAttObj;
         _stelaAttInfo.ResiPenetrate += _loc1_[0];
         _stelaAttInfo.ReduceResiAgainst += _loc1_[1];
         _skillAttInfo.reset();
         addSkillProperty(skill1);
         addSkillProperty(skill2);
         addSkillProperty(skill3);
         addSkillProperty(skill4);
         addSkillProperty(skill5);
      }
      
      private function addSkillProperty(param1:int) : void
      {
         var _loc2_:SkillPropertyTempInfo = null;
         if(param1 > 0)
         {
            _loc2_ = TempleteManager.instance.skillPropertyTemplateCate.getTemplateByID(param1);
            if(_loc2_)
            {
               _skillAttInfo.Attack += _loc2_.Attack;
               _skillAttInfo.Defence += _loc2_.Defence;
               _skillAttInfo.MagicAttack += _loc2_.MagicAttack;
               _skillAttInfo.MagicDefence += _loc2_.MagicDefence;
               _skillAttInfo.Live += _loc2_.Live;
               _skillAttInfo.ForceHit += _loc2_.ForceHit;
               _skillAttInfo.Parry += _loc2_.Parry;
               _skillAttInfo.Penetrate += _loc2_.Penetrate;
               _skillAttInfo.ReduceResiAgainst += _loc2_.ReduceResiAgainst;
               _skillAttInfo.ResiPenetrate += _loc2_.ResiPenetrate;
            }
         }
      }
      
      public function get nameStep() : String
      {
         var _loc1_:String = "";
         var _loc2_:String = "";
         if(_tempInfo)
         {
            _loc1_ = _tempInfo.TemplateName + " +" + _step;
            _loc2_ = StringHelper.format("<font color={0}>{1}</font>",GoodsHelp.getGoodColorString(_stepColor > 0 ? _stepColor : 1),_loc1_);
         }
         return _loc2_;
      }
      
      public function get star() : int
      {
         return _star;
      }
      
      public function get stepColor() : int
      {
         return _stepColor;
      }
   }
}

