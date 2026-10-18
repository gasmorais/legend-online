package yishi.utils
{
   import manager.LanguageMgr;
   import yishi.datas.goods.GoodsInfo;
   import yishi.datas.templates.CommonDropTempInfo;
   import yishi.manager.TempleteManager;
   
   public class GoodsHelp
   {
      
      public static const GRAY:int = 0;
      
      public static const WHITE:int = 1;
      
      public static const GREEN:int = 2;
      
      public static const BLUE:int = 3;
      
      public static const PURPLE:int = 4;
      
      public static const ORANGE:int = 5;
      
      public static const RED:int = 6;
      
      public function GoodsHelp()
      {
         super();
      }
      
      public static function getGoodQualityName(param1:int) : String
      {
         var _loc2_:String = null;
         switch(param1 - 1)
         {
            case 0:
               _loc2_ = LanguageMgr.GetTranslation("yishi.utils.GoodsHelp.getGoodQualityName01");
               break;
            case 1:
               _loc2_ = LanguageMgr.GetTranslation("yishi.utils.GoodsHelp.getGoodQualityName02");
               break;
            case 2:
               _loc2_ = LanguageMgr.GetTranslation("yishi.utils.GoodsHelp.getGoodQualityName03");
               break;
            case 3:
               _loc2_ = LanguageMgr.GetTranslation("yishi.utils.GoodsHelp.getGoodQualityName04");
               break;
            case 4:
               _loc2_ = LanguageMgr.GetTranslation("yishi.utils.GoodsHelp.getGoodQualityName05");
               break;
            case 5:
               _loc2_ = LanguageMgr.GetTranslation("yishi.utils.GoodsHelp.getGoodQualityName06");
         }
         return _loc2_;
      }
      
      public static function getGoodColorString(param1:int) : String
      {
         var _loc2_:String = null;
         switch(param1)
         {
            case 0:
               _loc2_ = "\'#B3B3B3\'";
               break;
            case 1:
               _loc2_ = "\'#ffffff\'";
               break;
            case 2:
               _loc2_ = "\'#59cd41\'";
               break;
            case 3:
               _loc2_ = "\'#32a2f8\'";
               break;
            case 4:
               _loc2_ = "\'#a838f7\'";
               break;
            case 5:
               _loc2_ = "\'#eb9504\'";
               break;
            case 6:
               _loc2_ = "\'#ce0f0f\'";
         }
         return _loc2_;
      }
      
      public static function getJewelEffecyByGrade(param1:int) : Number
      {
         if(param1 <= 50)
         {
            return param1 * 2;
         }
         if(param1 <= 70)
         {
            return (param1 - 50) * 3 + 100;
         }
         if(param1 <= 80)
         {
            return (param1 - 70) * 4 + 160;
         }
         return 0;
      }
      
      public static function getSeniorJewelEffecyByGrade(param1:int) : Number
      {
         if(param1 <= 50)
         {
            return param1 * 2 + 200;
         }
         if(param1 <= 70)
         {
            return (param1 - 50) * 3 + 300;
         }
         if(param1 <= 80)
         {
            return (param1 - 70) * 4 + 360;
         }
         return 0;
      }
      
      public static function getConciseEffecyByGrade(param1:int) : int
      {
         return param1 * 5;
      }
      
      public static function getConciseValue(param1:int, param2:int) : int
      {
         return Math.ceil(param1 * param2 * 5 / 100);
      }
      
      public static function getStrengthenAddition(param1:int, param2:int) : int
      {
         if(param1 == 0)
         {
            return 0;
         }
         return int(param1 * param2 * 0.1) + param2 * 5;
      }
      
      public static function getMouldAddition(param1:int, param2:int) : int
      {
         if(param1 == 0)
         {
            return 0;
         }
         if(param2 <= 80)
         {
            return int(param1 * param2 * 0.3);
         }
         if(param2 > 80 && param2 <= 160)
         {
            return int(param1 * 80 * 0.3) + int(param1 * (param2 - 80) * 0.4);
         }
         return int(param1 * 80 * 0.3) + int(param1 * 80 * 0.4) + int(param1 * (param2 - 160) * 0.25);
      }
      
      public static function getPetEquipStrengAddition(param1:int, param2:int) : int
      {
         if(param2 <= 0)
         {
            return 0;
         }
         return param1 > 0 ? Math.pow(1.08,param2) * param1 - param1 : 0;
      }
      
      public static function getChildEquipStrengAddition(param1:int, param2:int) : int
      {
         if(param1 <= 0)
         {
            return 0;
         }
         return int(param1 * param2 * 0.05);
      }
      
      public static function getRewardDesc(param1:Array) : String
      {
         var _loc2_:int = 0;
         var _loc3_:String = "";
         if(param1 != null)
         {
            _loc2_ = 0;
            while(_loc2_ < param1.length)
            {
               _loc3_ += getGoodsName(param1[_loc2_].tempId) + "x" + param1[_loc2_].count + "\n";
               _loc2_++;
            }
         }
         return _loc3_.substring(0,_loc3_.lastIndexOf("\n"));
      }
      
      public static function getRewardDesc2(param1:Array) : String
      {
         var _loc2_:int = 0;
         var _loc3_:String = "";
         if(param1 != null)
         {
            _loc2_ = 0;
            while(_loc2_ < param1.length)
            {
               _loc3_ += getGoodsName(param1[_loc2_].itemId) + "x" + param1[_loc2_].count + "\n";
               _loc2_++;
            }
         }
         return _loc3_.substring(0,_loc3_.lastIndexOf("\n"));
      }
      
      public static function getRewardDesc3(param1:Array) : String
      {
         var _loc2_:int = 0;
         var _loc4_:CommonDropTempInfo = null;
         var _loc3_:String = "";
         if(param1 != null)
         {
            _loc2_ = 0;
            while(_loc2_ < param1.length)
            {
               _loc4_ = param1[_loc2_];
               _loc3_ += getGoodsName(_loc4_.itemId) + "x" + _loc4_.count + "\n";
               _loc2_++;
            }
         }
         return _loc3_.substring(0,_loc3_.lastIndexOf("\n"));
      }
      
      public static function getGoodsName(param1:int) : String
      {
         return TempleteManager.instance.goodsTemplateCate.getTemplateByID(param1).TemplateName;
      }
      
      public static function getCommonRewardAry(param1:String) : Array
      {
         var _loc5_:GoodsInfo = null;
         var _loc3_:int = 0;
         var _loc2_:Array = [];
         if(StringHelper.isNullOrEmpty(param1))
         {
            return _loc2_;
         }
         var _loc4_:Array = param1.split("|");
         _loc3_ = 0;
         while(_loc3_ < _loc4_.length)
         {
            _loc5_ = new GoodsInfo();
            _loc5_.templateId = _loc4_[_loc3_].split(",")[0];
            _loc5_.count = _loc4_[_loc3_].split(",")[1];
            _loc2_.push(_loc5_);
            _loc3_++;
         }
         return _loc2_;
      }
   }
}

