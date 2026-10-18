package yishi.datas.templates
{
   import manager.LanguageMgr;
   
   public class TheseusTreasureCoreInfo
   {
      
      public var TemplateId:int;
      
      public var Level:int;
      
      public var Profile:int;
      
      public var Description:String;
      
      public var StrengthenItem:int;
      
      public var StrengthenItemNum:int;
      
      public var BreachItem:int;
      
      public var BreachItemNum:int;
      
      public var CoreSkills:String;
      
      public var Icon:String;
      
      public var SecretLevel:int;
      
      public var Property1:int;
      
      public var PhyAttack:int;
      
      public var PhyDefence:int;
      
      public var MagicAttack:int;
      
      public var MagicDefence:int;
      
      public var ForceHit:int;
      
      public var Live:int;
      
      public var Parry:int;
      
      public var Penetrate:int;
      
      public var ReduceResi:int;
      
      public var FireResi:int;
      
      public var WaterResi:int;
      
      public var ElectResi:int;
      
      public var WindResi:int;
      
      public var DarkResi:int;
      
      public var LightResi:int;
      
      public var ReduceResiAgainst:int;
      
      public var ResiPenetrate:int;
      
      private var _attValues:Array = [];
      
      private var _attNames:Array = [];
      
      public function TheseusTreasureCoreInfo()
      {
         super();
      }
      
      public function get attNames() : Array
      {
         _attValues.length = 0;
         _attNames.length = 0;
         if(PhyAttack > 0)
         {
            _attValues.push(PhyAttack);
            _attNames.push(LanguageMgr.GetTranslation("TheseusTreasureGrowupInfo.typeText01"));
         }
         if(PhyDefence > 0)
         {
            _attValues.push(PhyDefence);
            _attNames.push(LanguageMgr.GetTranslation("TheseusTreasureGrowupInfo.typeText02"));
         }
         if(MagicAttack > 0)
         {
            _attValues.push(MagicAttack);
            _attNames.push(LanguageMgr.GetTranslation("TheseusTreasureGrowupInfo.typeText03"));
         }
         if(MagicDefence > 0)
         {
            _attValues.push(MagicDefence);
            _attNames.push(LanguageMgr.GetTranslation("TheseusTreasureGrowupInfo.typeText04"));
         }
         if(ForceHit > 0)
         {
            _attValues.push(ForceHit);
            _attNames.push(LanguageMgr.GetTranslation("TheseusTreasureGrowupInfo.typeText05"));
         }
         if(Live > 0)
         {
            _attValues.push(Live);
            _attNames.push(LanguageMgr.GetTranslation("TheseusTreasureGrowupInfo.typeText06"));
         }
         if(Parry > 0)
         {
            _attValues.push(Parry);
            _attNames.push(LanguageMgr.GetTranslation("TheseusTreasureGrowupInfo.typeText07"));
         }
         if(Penetrate > 0)
         {
            _attValues.push(Penetrate);
            _attNames.push(LanguageMgr.GetTranslation("TheseusTreasureGrowupInfo.typeText08"));
         }
         if(ReduceResi > 0)
         {
            _attValues.push(ReduceResi);
            _attNames.push(LanguageMgr.GetTranslation("TheseusTreasureGrowupInfo.typeText09"));
         }
         if(FireResi > 0)
         {
            _attValues.push(FireResi);
            _attNames.push(LanguageMgr.GetTranslation("TheseusTreasureGrowupInfo.typeText10"));
         }
         if(WaterResi > 0)
         {
            _attValues.push(WaterResi);
            _attNames.push(LanguageMgr.GetTranslation("TheseusTreasureGrowupInfo.typeText11"));
         }
         if(ElectResi > 0)
         {
            _attValues.push(ElectResi);
            _attNames.push(LanguageMgr.GetTranslation("TheseusTreasureGrowupInfo.typeText12"));
         }
         if(WindResi > 0)
         {
            _attValues.push(WindResi);
            _attNames.push(LanguageMgr.GetTranslation("TheseusTreasureGrowupInfo.typeText13"));
         }
         if(DarkResi > 0)
         {
            _attValues.push(DarkResi);
            _attNames.push(LanguageMgr.GetTranslation("TheseusTreasureGrowupInfo.typeText14"));
         }
         if(LightResi > 0)
         {
            _attValues.push(LightResi);
            _attNames.push(LanguageMgr.GetTranslation("TheseusTreasureGrowupInfo.typeText15"));
         }
         if(ReduceResiAgainst > 0)
         {
            _attValues.push(ReduceResiAgainst);
            _attNames.push(LanguageMgr.GetTranslation("TheseusTreasureGrowupInfo.typeText16"));
         }
         if(ResiPenetrate > 0)
         {
            _attValues.push(ResiPenetrate);
            _attNames.push(LanguageMgr.GetTranslation("TheseusTreasureGrowupInfo.typeText17"));
         }
         return _attNames;
      }
      
      public function get attValues() : Array
      {
         return _attValues;
      }
   }
}

