package mvc.module.theseus
{
   import manager.LanguageMgr;
   
   public class TreasurePropertys
   {
      
      public var power:int;
      
      public var agility:int;
      
      public var intellect:int;
      
      public var captain:int;
      
      public var physique:int;
      
      public var attack:int;
      
      public var defence:int;
      
      public var magicAttack:int;
      
      public var magicDefence:int;
      
      public var forceHit:int;
      
      public var parry:int;
      
      public var live:int;
      
      public var conat:int;
      
      public var reduceResi:int;
      
      public var fireResi:int;
      
      public var waterResi:int;
      
      public var electResi:int;
      
      public var windResi:int;
      
      public var darkResi:int;
      
      public var lightResi:int;
      
      public var strength:int;
      
      public var tenacity:int;
      
      public var penetrate:int;
      
      public var stunAttr:int;
      
      public var reduceResiAgainst:int;
      
      public var resiPenetrate:int;
      
      private var _attValues:Array = [];
      
      private var _attNames:Array = [];
      
      public function TreasurePropertys()
      {
         super();
      }
      
      public function get isShow() : Boolean
      {
         return power > 0 || agility > 0 || intellect > 0 || captain > 0 || physique > 0 || attack > 0 || defence > 0 || magicAttack > 0 || magicDefence > 0 || forceHit > 0 || parry > 0 || live > 0 || conat > 0 || reduceResi > 0 || fireResi > 0 || waterResi > 0 || electResi > 0 || windResi > 0 || darkResi > 0 || lightResi > 0 || strength > 0 || tenacity > 0 || penetrate > 0 || stunAttr > 0 || reduceResiAgainst > 0 || resiPenetrate > 0;
      }
      
      public function get attNames() : Array
      {
         _attValues.length = 0;
         _attNames.length = 0;
         if(attack > 0)
         {
            _attValues.push(attack);
            _attNames.push(LanguageMgr.GetTranslation("TheseusTreasureGrowupInfo.typeText01"));
         }
         if(defence > 0)
         {
            _attValues.push(defence);
            _attNames.push(LanguageMgr.GetTranslation("TheseusTreasureGrowupInfo.typeText02"));
         }
         if(magicAttack > 0)
         {
            _attValues.push(magicAttack);
            _attNames.push(LanguageMgr.GetTranslation("TheseusTreasureGrowupInfo.typeText03"));
         }
         if(magicDefence > 0)
         {
            _attValues.push(magicDefence);
            _attNames.push(LanguageMgr.GetTranslation("TheseusTreasureGrowupInfo.typeText04"));
         }
         if(forceHit > 0)
         {
            _attValues.push(forceHit);
            _attNames.push(LanguageMgr.GetTranslation("TheseusTreasureGrowupInfo.typeText05"));
         }
         if(live > 0)
         {
            _attValues.push(live);
            _attNames.push(LanguageMgr.GetTranslation("TheseusTreasureGrowupInfo.typeText06"));
         }
         if(parry > 0)
         {
            _attValues.push(parry);
            _attNames.push(LanguageMgr.GetTranslation("TheseusTreasureGrowupInfo.typeText07"));
         }
         if(penetrate > 0)
         {
            _attValues.push(penetrate);
            _attNames.push(LanguageMgr.GetTranslation("TheseusTreasureGrowupInfo.typeText08"));
         }
         if(reduceResi > 0)
         {
            _attValues.push(reduceResi);
            _attNames.push(LanguageMgr.GetTranslation("TheseusTreasureGrowupInfo.typeText09"));
         }
         if(fireResi > 0)
         {
            _attValues.push(fireResi);
            _attNames.push(LanguageMgr.GetTranslation("TheseusTreasureGrowupInfo.typeText10"));
         }
         if(waterResi > 0)
         {
            _attValues.push(waterResi);
            _attNames.push(LanguageMgr.GetTranslation("TheseusTreasureGrowupInfo.typeText11"));
         }
         if(electResi > 0)
         {
            _attValues.push(electResi);
            _attNames.push(LanguageMgr.GetTranslation("TheseusTreasureGrowupInfo.typeText12"));
         }
         if(windResi > 0)
         {
            _attValues.push(windResi);
            _attNames.push(LanguageMgr.GetTranslation("TheseusTreasureGrowupInfo.typeText13"));
         }
         if(darkResi > 0)
         {
            _attValues.push(darkResi);
            _attNames.push(LanguageMgr.GetTranslation("TheseusTreasureGrowupInfo.typeText14"));
         }
         if(lightResi > 0)
         {
            _attValues.push(lightResi);
            _attNames.push(LanguageMgr.GetTranslation("TheseusTreasureGrowupInfo.typeText15"));
         }
         if(reduceResiAgainst > 0)
         {
            _attValues.push(reduceResiAgainst);
            _attNames.push(LanguageMgr.GetTranslation("TheseusTreasureGrowupInfo.typeText16"));
         }
         if(resiPenetrate > 0)
         {
            _attValues.push(resiPenetrate);
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

