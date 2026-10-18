package yishi.datas.templates
{
   public class PetTemplate
   {
      
      public var TemplateId:int;
      
      public var TemplateName:String;
      
      public var SonType:int;
      
      public var PetAvatar:String;
      
      public var PetType:int;
      
      public var Quality:int;
      
      public var Power:int;
      
      public var Intel:int;
      
      public var Physi:int;
      
      public var Armor:int;
      
      private var _PowerApt:String;
      
      private var _IntelApt:String;
      
      private var _PhysiApt:String;
      
      private var _ArmorApt:String;
      
      public var InitPowerCoeLimit:int = 0;
      
      public var InitIntelCoeLimit:int = 0;
      
      public var InitPhysiCoeLimit:int = 0;
      
      public var InitArmorCoeLimit:int = 0;
      
      public var InitPowerCoeLimitMin:int = 0;
      
      public var InitIntelCoeLimitMin:int = 0;
      
      public var InitPhysiCoeLimitMin:int = 0;
      
      public var InitArmorCoeLimitMin:int = 0;
      
      public var MaxHp:int;
      
      public var FireResi:int;
      
      public var WaterResi:int;
      
      public var ElectResi:int;
      
      public var WindResi:int;
      
      public var DarkResi:int;
      
      public var LightResi:int;
      
      public var FollowSkills:String;
      
      public var ChangeSkills:String;
      
      public var NeedGrade:int;
      
      public var Description:String;
      
      public var GrowthRate:int;
      
      public var Property1:int;
      
      public var Property2:int;
      
      public var Property3:int;
      
      public var Property4:String;
      
      public var Property5:String;
      
      public var Property6:String;
      
      public var DefaultSkills:String;
      
      public function PetTemplate()
      {
         super();
      }
      
      public function get PowerApt() : String
      {
         return _PowerApt;
      }
      
      public function set PowerApt(param1:String) : void
      {
         _PowerApt = param1;
         if(!_PowerApt)
         {
            return;
         }
         var _loc2_:Array = _PowerApt.split(",");
         if(_loc2_.length == 2)
         {
            InitPowerCoeLimitMin = parseInt(_loc2_[0]);
            InitPowerCoeLimit = parseInt(_loc2_[1]);
         }
      }
      
      public function get IntelApt() : String
      {
         return _IntelApt;
      }
      
      public function set IntelApt(param1:String) : void
      {
         _IntelApt = param1;
         if(!_IntelApt)
         {
            return;
         }
         var _loc2_:Array = _IntelApt.split(",");
         if(_loc2_.length == 2)
         {
            InitIntelCoeLimitMin = parseInt(_loc2_[0]);
            InitIntelCoeLimit = parseInt(_loc2_[1]);
         }
      }
      
      public function get PhysiApt() : String
      {
         return _PhysiApt;
      }
      
      public function set PhysiApt(param1:String) : void
      {
         _PhysiApt = param1;
         if(!_PhysiApt)
         {
            return;
         }
         var _loc2_:Array = _PhysiApt.split(",");
         if(_loc2_.length == 2)
         {
            InitPhysiCoeLimitMin = parseInt(_loc2_[0]);
            InitPhysiCoeLimit = parseInt(_loc2_[1]);
         }
      }
      
      public function get ArmorApt() : String
      {
         return _ArmorApt;
      }
      
      public function set ArmorApt(param1:String) : void
      {
         _ArmorApt = param1;
         if(!_ArmorApt)
         {
            return;
         }
         var _loc2_:Array = _ArmorApt.split(",");
         if(_loc2_.length == 2)
         {
            InitArmorCoeLimitMin = parseInt(_loc2_[0]);
            InitArmorCoeLimit = parseInt(_loc2_[1]);
         }
      }
   }
}

