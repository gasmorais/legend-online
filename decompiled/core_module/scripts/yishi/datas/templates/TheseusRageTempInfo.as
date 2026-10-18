package yishi.datas.templates
{
   import manager.LanguageMgr;
   import yishi.utils.SimpleDictionary;
   
   public class TheseusRageTempInfo
   {
      
      public var TemplateId:int;
      
      public var Type:int;
      
      public var Level:int;
      
      public var NeedItem:int;
      
      public var NeedItemNum:int;
      
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
      
      public var MasterType:int;
      
      private var _attValues:Array = [];
      
      private var _attNames:Array = [];
      
      private var _attDic:SimpleDictionary = new SimpleDictionary();
      
      public function TheseusRageTempInfo()
      {
         super();
      }
      
      public function add(param1:TheseusRageTempInfo) : void
      {
         this.PhyAttack += param1.PhyAttack;
         this.PhyDefence += param1.PhyDefence;
         this.MagicAttack += param1.MagicAttack;
         this.MagicDefence += param1.MagicDefence;
         this.ForceHit += param1.ForceHit;
         this.Live += param1.Live;
         this.Parry += param1.Parry;
         this.Penetrate += param1.Penetrate;
         this.ReduceResi += param1.ReduceResi;
         this.FireResi += param1.FireResi;
         this.WaterResi += param1.WaterResi;
         this.ElectResi += param1.ElectResi;
         this.WindResi += param1.WindResi;
         this.DarkResi += param1.DarkResi;
         this.LightResi += param1.LightResi;
         this.ReduceResiAgainst += param1.ReduceResiAgainst;
         this.ResiPenetrate += param1.ResiPenetrate;
      }
      
      public function get attDic() : SimpleDictionary
      {
         var _loc1_:String = null;
         _attDic.clear();
         if(PhyAttack > 0)
         {
            _loc1_ = LanguageMgr.GetTranslation("tips.ChildrenFigureTip.typeText08");
            _attDic.add(_loc1_,PhyAttack);
         }
         if(PhyDefence > 0)
         {
            _loc1_ = LanguageMgr.GetTranslation("tips.ChildrenFigureTip.typeText09");
            _attDic.add(_loc1_,PhyDefence);
         }
         if(MagicAttack > 0)
         {
            _loc1_ = LanguageMgr.GetTranslation("tips.ChildrenFigureTip.typeText10");
            _attDic.add(_loc1_,MagicAttack);
         }
         if(MagicDefence > 0)
         {
            _loc1_ = LanguageMgr.GetTranslation("tips.ChildrenFigureTip.typeText11");
            _attDic.add(_loc1_,MagicDefence);
         }
         if(ForceHit > 0)
         {
            _loc1_ = LanguageMgr.GetTranslation("tips.ChildrenFigureTip.typeText12");
            _attDic.add(_loc1_,ForceHit);
         }
         if(Live > 0)
         {
            _loc1_ = LanguageMgr.GetTranslation("tips.ChildrenFigureTip.typeText15");
            _attDic.add(_loc1_,Live);
         }
         if(Parry > 0)
         {
            _loc1_ = LanguageMgr.GetTranslation("tips.ChildrenFigureTip.typeText14");
            _attDic.add(_loc1_,Parry);
         }
         if(Penetrate > 0)
         {
            _loc1_ = LanguageMgr.GetTranslation("PropertyName.Penetrate");
            _attDic.add(_loc1_,Penetrate);
         }
         if(ReduceResi > 0)
         {
            _loc1_ = LanguageMgr.GetTranslation("tips.ChildrenFigureTip.typeText01");
            _attDic.add(_loc1_,ReduceResi);
         }
         if(FireResi > 0)
         {
            _loc1_ = LanguageMgr.GetTranslation("tips.ChildrenFigureTip.typeText02");
            _attDic.add(_loc1_,FireResi);
         }
         if(WaterResi > 0)
         {
            _attValues.push(WaterResi);
            _loc1_ = LanguageMgr.GetTranslation("tips.ChildrenFigureTip.typeText03");
            _attDic.add(_loc1_,ReduceResi);
         }
         if(ElectResi > 0)
         {
            _loc1_ = LanguageMgr.GetTranslation("tips.ChildrenFigureTip.typeText04");
            _attDic.add(_loc1_,ElectResi);
         }
         if(WindResi > 0)
         {
            _attValues.push(WindResi);
            _loc1_ = LanguageMgr.GetTranslation("tips.ChildrenFigureTip.typeText05");
            _attDic.add(_loc1_,ReduceResi);
         }
         if(DarkResi > 0)
         {
            _loc1_ = LanguageMgr.GetTranslation("tips.ChildrenFigureTip.typeText06");
            _attDic.add(_loc1_,DarkResi);
         }
         if(LightResi > 0)
         {
            _loc1_ = LanguageMgr.GetTranslation("tips.ChildrenFigureTip.typeText07");
            _attDic.add(_loc1_,LightResi);
         }
         if(ReduceResiAgainst > 0)
         {
            _loc1_ = LanguageMgr.GetTranslation("tips.ChildrenFigureTip.typeText18");
            _attDic.add(_loc1_,ReduceResiAgainst);
         }
         if(ResiPenetrate > 0)
         {
            _loc1_ = LanguageMgr.GetTranslation("tips.ChildrenFigureTip.typeText17");
            _attDic.add(_loc1_,ResiPenetrate);
         }
         return _attDic;
      }
      
      public function get attNames() : Array
      {
         _attValues.length = 0;
         _attNames.length = 0;
         if(PhyAttack > 0)
         {
            _attValues.push(PhyAttack);
            _attNames.push(LanguageMgr.GetTranslation("tips.ChildrenFigureTip.typeText08"));
         }
         if(PhyDefence > 0)
         {
            _attValues.push(PhyDefence);
            _attNames.push(LanguageMgr.GetTranslation("tips.ChildrenFigureTip.typeText09"));
         }
         if(MagicAttack > 0)
         {
            _attValues.push(MagicAttack);
            _attNames.push(LanguageMgr.GetTranslation("tips.ChildrenFigureTip.typeText10"));
         }
         if(MagicDefence > 0)
         {
            _attValues.push(MagicDefence);
            _attNames.push(LanguageMgr.GetTranslation("tips.ChildrenFigureTip.typeText11"));
         }
         if(ForceHit > 0)
         {
            _attValues.push(ForceHit);
            _attNames.push(LanguageMgr.GetTranslation("tips.ChildrenFigureTip.typeText12"));
         }
         if(Live > 0)
         {
            _attValues.push(Live);
            _attNames.push(LanguageMgr.GetTranslation("tips.ChildrenFigureTip.typeText15"));
         }
         if(Parry > 0)
         {
            _attValues.push(Parry);
            _attNames.push(LanguageMgr.GetTranslation("tips.ChildrenFigureTip.typeText14"));
         }
         if(Penetrate > 0)
         {
            _attValues.push(Penetrate);
            _attNames.push(LanguageMgr.GetTranslation("PropertyName.Penetrate"));
         }
         if(ReduceResi > 0)
         {
            _attValues.push(ReduceResi);
            _attNames.push(LanguageMgr.GetTranslation("tips.ChildrenFigureTip.typeText01"));
         }
         if(FireResi > 0)
         {
            _attValues.push(FireResi);
            _attNames.push(LanguageMgr.GetTranslation("tips.ChildrenFigureTip.typeText02"));
         }
         if(WaterResi > 0)
         {
            _attValues.push(WaterResi);
            _attNames.push(LanguageMgr.GetTranslation("tips.ChildrenFigureTip.typeText03"));
         }
         if(ElectResi > 0)
         {
            _attValues.push(ElectResi);
            _attNames.push(LanguageMgr.GetTranslation("tips.ChildrenFigureTip.typeText04"));
         }
         if(WindResi > 0)
         {
            _attValues.push(WindResi);
            _attNames.push(LanguageMgr.GetTranslation("tips.ChildrenFigureTip.typeText05"));
         }
         if(DarkResi > 0)
         {
            _attValues.push(DarkResi);
            _attNames.push(LanguageMgr.GetTranslation("tips.ChildrenFigureTip.typeText06"));
         }
         if(LightResi > 0)
         {
            _attValues.push(LightResi);
            _attNames.push(LanguageMgr.GetTranslation("tips.ChildrenFigureTip.typeText07"));
         }
         if(ReduceResiAgainst > 0)
         {
            _attValues.push(ReduceResiAgainst);
            _attNames.push(LanguageMgr.GetTranslation("tips.ChildrenFigureTip.typeText18"));
         }
         if(ResiPenetrate > 0)
         {
            _attValues.push(ResiPenetrate);
            _attNames.push(LanguageMgr.GetTranslation("tips.ChildrenFigureTip.typeText17"));
         }
         return _attNames;
      }
      
      public function get attValues() : Array
      {
         return _attValues;
      }
   }
}

