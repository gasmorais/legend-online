package mvc.module.theseus
{
   import manager.LanguageMgr;
   
   public class AttributeUtils
   {
      
      public function AttributeUtils()
      {
         super();
      }
      
      public static function getColorStr(param1:String, param2:String, param3:Boolean = true) : String
      {
         var _loc4_:String = null;
         if(param3)
         {
            _loc4_ = "<font color=\'" + param2 + "\'>" + param1 + "</font>";
         }
         else
         {
            _loc4_ = "<font color=" + param2 + ">" + param1 + "</font>";
         }
         return _loc4_;
      }
      
      public static function getZjAttributeName(param1:String, param2:int = 1) : String
      {
         var _loc3_:String = null;
         switch(param1)
         {
            case "1":
               _loc3_ = LanguageMgr.GetTranslation("tips.ChildrenFigureTip.typeText08");
               break;
            case "2":
               _loc3_ = LanguageMgr.GetTranslation("tips.ChildrenFigureTip.typeText09");
               break;
            case "3":
               _loc3_ = LanguageMgr.GetTranslation("tips.ChildrenFigureTip.typeText10");
               break;
            case "4":
               _loc3_ = LanguageMgr.GetTranslation("tips.ChildrenFigureTip.typeText11");
               break;
            case "5":
               _loc3_ = LanguageMgr.GetTranslation("tips.warFrame.typeText17");
         }
         return _loc3_;
      }
      
      public static function getzjAttribute(param1:String, param2:int = 1) : String
      {
         var _loc3_:String = null;
         switch(param1)
         {
            case "1":
               _loc3_ = "Attack";
               break;
            case "2":
               _loc3_ = "Defence";
               break;
            case "3":
               _loc3_ = "MagicAttack";
               break;
            case "4":
               _loc3_ = "MagicDefence";
               break;
            case "5":
               _loc3_ = "Live";
         }
         return _loc3_;
      }
      
      public static function getAtrributeByKey(param1:String, param2:int, param3:String, param4:String = "") : String
      {
         var _loc7_:String = LanguageMgr.GetTranslation("TheseusCollenedBigItemUI." + param1);
         var _loc5_:String = param2 > 0 ? "+" + param2 : "" + param2;
         var _loc6_:String = getColorStr(_loc5_ + param4,param3);
         return _loc7_ + _loc6_;
      }
      
      public static function getAttributeName(param1:String, param2:int = 1) : String
      {
         var _loc3_:String = null;
         switch(param1)
         {
            case "PhyAttack":
            case "Attack":
               if(param2 == 1)
               {
                  _loc3_ = LanguageMgr.GetTranslation("tips.ChildrenFigureTip.typeText08");
               }
               else
               {
                  _loc3_ = LanguageMgr.GetTranslation("armyII.ThaneAttributeView.Tip13");
               }
               break;
            case "PhyDefence":
            case "Defence":
               if(param2 == 1)
               {
                  _loc3_ = LanguageMgr.GetTranslation("tips.ChildrenFigureTip.typeText09");
               }
               else
               {
                  _loc3_ = LanguageMgr.GetTranslation("armyII.ThaneAttributeView.Tip14");
               }
               break;
            case "MagicAttack":
               if(param2 == 1)
               {
                  _loc3_ = LanguageMgr.GetTranslation("tips.ChildrenFigureTip.typeText10");
               }
               else
               {
                  _loc3_ = LanguageMgr.GetTranslation("armyII.ThaneAttributeView.Tip15");
               }
               break;
            case "MagicDefence":
               if(param2 == 1)
               {
                  _loc3_ = LanguageMgr.GetTranslation("tips.ChildrenFigureTip.typeText11");
               }
               else
               {
                  _loc3_ = LanguageMgr.GetTranslation("armyII.ThaneAttributeView.Tip16");
               }
               break;
            case "ForceHit":
               if(param2 == 1)
               {
                  _loc3_ = LanguageMgr.GetTranslation("tips.ChildrenFigureTip.typeText12");
               }
               else
               {
                  _loc3_ = LanguageMgr.GetTranslation("armyII.ThaneAttributeView.Tip10");
               }
               break;
            case "Live":
               if(param2 == 1)
               {
                  _loc3_ = LanguageMgr.GetTranslation("tips.ChildrenFigureTip.typeText15");
               }
               else
               {
                  _loc3_ = LanguageMgr.GetTranslation("armyII.ThaneAttributeView.Tip11");
               }
               break;
            case "Parry":
               if(param2 == 1)
               {
                  _loc3_ = LanguageMgr.GetTranslation("tips.ChildrenFigureTip.typeText14");
               }
               else
               {
                  _loc3_ = LanguageMgr.GetTranslation("armyII.ThaneAttributeView.Tip19");
               }
               break;
            case "Penetrate":
               _loc3_ = LanguageMgr.GetTranslation("PropertyName.Penetrate");
               break;
            case "ReduceResi":
               _loc3_ = LanguageMgr.GetTranslation("tips.ChildrenFigureTip.typeText01");
               break;
            case "FireResi":
               _loc3_ = LanguageMgr.GetTranslation("tips.ChildrenFigureTip.typeText02");
               break;
            case "WaterResi":
               _loc3_ = LanguageMgr.GetTranslation("tips.ChildrenFigureTip.typeText03");
               break;
            case "ElectResi":
               _loc3_ = LanguageMgr.GetTranslation("tips.ChildrenFigureTip.typeText04");
               break;
            case "WindResi":
               _loc3_ = LanguageMgr.GetTranslation("tips.ChildrenFigureTip.typeText05");
               break;
            case "DarkResi":
               _loc3_ = LanguageMgr.GetTranslation("tips.ChildrenFigureTip.typeText06");
               break;
            case "LightResi":
               _loc3_ = LanguageMgr.GetTranslation("tips.ChildrenFigureTip.typeText07");
               break;
            case "ReduceResiAgainst":
               _loc3_ = LanguageMgr.GetTranslation("tips.ChildrenFigureTip.typeText18");
               break;
            case "ResiPenetrate":
               _loc3_ = LanguageMgr.GetTranslation("tips.ChildrenFigureTip.typeText17");
         }
         return _loc3_;
      }
   }
}

