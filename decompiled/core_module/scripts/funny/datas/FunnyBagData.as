package funny.datas
{
   import bag.datas.GoodsSonType;
   import manager.LanguageMgr;
   import managers.FunnyManager;
   import yishi.manager.TempleteManager;
   import yishi.utils.DateFormatter;
   import yishi.utils.StarHelper;
   
   public class FunnyBagData
   {
      
      public var id:String;
      
      public var order:int;
      
      public var rewardList:Vector.<FunnyRewardData>;
      
      public var conditionList:Vector.<FunnyConditionData>;
      
      public var status:int;
      
      public var remainTime:int;
      
      public var isShow:Boolean;
      
      public var param1:String;
      
      public var getWay:int;
      
      public var activeId:String;
      
      public var finshCount:int;
      
      public var getCount:int;
      
      public function FunnyBagData()
      {
         super();
         rewardList = new Vector.<FunnyRewardData>();
         conditionList = new Vector.<FunnyConditionData>();
      }
      
      public function get title() : String
      {
         var _loc8_:int = 0;
         var _loc3_:String = null;
         var _loc4_:int = 0;
         var _loc6_:int = 0;
         var _loc12_:int = 0;
         var _loc11_:int = 0;
         var _loc7_:String = null;
         var _loc9_:int = 0;
         var _loc2_:String = null;
         var _loc10_:Array = null;
         var _loc5_:String = null;
         if(!conditionList)
         {
            return "";
         }
         var _loc1_:String = "";
         _loc8_ = 0;
         while(_loc8_ < conditionList.length)
         {
            switch(conditionList[_loc8_].id)
            {
               case 1:
                  _loc1_ += LanguageMgr.GetTranslation("funny.datas.FunnyBagData.title1",conditionList[_loc8_].value);
                  break;
               case 2:
                  _loc1_ += LanguageMgr.GetTranslation("funny.datas.FunnyBagData.title2",conditionList[_loc8_].value);
                  break;
               case 4:
                  _loc1_ += LanguageMgr.GetTranslation("funny.datas.FunnyBagData.title4",conditionList[_loc8_].value);
                  break;
               case 5:
                  _loc1_ += LanguageMgr.GetTranslation("funny.datas.FunnyBagData.title5",conditionList[_loc8_].value,conditionList[_loc8_].bak);
                  break;
               case 6:
                  _loc1_ += LanguageMgr.GetTranslation("funny.datas.FunnyBagData.title6",conditionList[_loc8_].value,conditionList[_loc8_].bak);
                  break;
               case 7:
                  _loc1_ += LanguageMgr.GetTranslation("funny.datas.FunnyBagData.title7",conditionList[_loc8_].value);
                  break;
               case 8:
                  _loc1_ += LanguageMgr.GetTranslation("funny.datas.FunnyBagData.title8",conditionList[_loc8_].value,StarHelper.getProfileNameByProfile(conditionList[_loc8_].bak));
                  break;
               case 9:
                  _loc1_ += LanguageMgr.GetTranslation("funny.datas.FunnyBagData.title9",conditionList[_loc8_].value);
                  break;
               case 10:
                  _loc1_ += LanguageMgr.GetTranslation("funny.datas.FunnyBagData.title10",conditionList[_loc8_].value,conditionList[_loc8_].bak);
                  break;
               case 11:
                  if(_loc8_ > 0)
                  {
                     _loc1_ += getGoodsName(conditionList[_loc8_].bak) + " x " + conditionList[_loc8_].value + "，";
                  }
                  else
                  {
                     _loc1_ += LanguageMgr.GetTranslation("funny.datas.FunnyBagData.title11",getGoodsName(conditionList[_loc8_].bak),conditionList[_loc8_].value);
                  }
                  break;
               case 201:
                  if(_loc8_ > 0)
                  {
                     _loc1_ += getGoodsName(conditionList[_loc8_].bak) + " x " + conditionList[_loc8_].value + "，";
                  }
                  else
                  {
                     _loc1_ += LanguageMgr.GetTranslation("funny.datas.FunnyBagData.title201",getGoodsName(conditionList[_loc8_].bak),conditionList[_loc8_].value);
                  }
                  break;
               case 12:
                  _loc1_ += LanguageMgr.GetTranslation("funny.datas.FunnyBagData.title12",GoodsSonType.getSonTypeName(conditionList[_loc8_].bak),conditionList[_loc8_].value);
                  break;
               case 13:
                  _loc1_ += LanguageMgr.GetTranslation("funny.datas.FunnyBagData.title13",conditionList[_loc8_].value);
                  break;
               case 14:
                  if(conditionList[_loc8_].value == 1)
                  {
                     _loc1_ += LanguageMgr.GetTranslation("funny.datas.FunnyBagData.title14");
                  }
                  else if(conditionList[_loc8_].value == 2)
                  {
                     _loc1_ += LanguageMgr.GetTranslation("funny.datas.FunnyBagData.title15");
                  }
                  else if(conditionList[_loc8_].value == 3)
                  {
                     _loc1_ += LanguageMgr.GetTranslation("funny.datas.FunnyBagData.title14_3");
                  }
                  break;
               case 15:
                  _loc1_ += LanguageMgr.GetTranslation("funny.datas.FunnyBagData.title16",DateFormatter.getFullDateString(conditionList[_loc8_].value));
                  break;
               case 16:
                  _loc1_ += LanguageMgr.GetTranslation("funny.datas.FunnyBagData.title19");
                  break;
               case 17:
                  _loc1_ += LanguageMgr.GetTranslation("funny.datas.FunnyBagData.title20",conditionList[_loc8_].value,conditionList[_loc8_].bak);
                  break;
               case 18:
                  if(getWay == 3)
                  {
                     _loc1_ += LanguageMgr.GetTranslation("funny.datas.FunnyBagData.title21",conditionList[_loc8_].value);
                  }
                  else if(getWay == 2)
                  {
                     _loc1_ += LanguageMgr.GetTranslation("funny.datas.FunnyBagData.title55",conditionList[_loc8_].value);
                  }
                  break;
               case 19:
                  _loc1_ += LanguageMgr.GetTranslation("funny.datas.FunnyBagData.title22",getGoodsName(conditionList[_loc8_].bak),conditionList[_loc8_].value);
                  break;
               case 20:
                  _loc1_ += LanguageMgr.GetTranslation("funny.datas.FunnyBagData.title23",conditionList[_loc8_].value);
                  break;
               case 21:
                  _loc1_ += LanguageMgr.GetTranslation("funny.datas.FunnyBagData.title24",conditionList[_loc8_].value);
                  break;
               case 22:
                  _loc1_ += LanguageMgr.GetTranslation("funny.datas.FunnyBagData.title25",conditionList[_loc8_].value);
                  break;
               case 23:
                  _loc1_ += LanguageMgr.GetTranslation("funny.datas.FunnyBagData.title26",conditionList[_loc8_].value);
                  break;
               case 24:
                  _loc1_ += LanguageMgr.GetTranslation("funny.datas.FunnyBagData.title27",conditionList[_loc8_].value);
                  break;
               case 25:
                  _loc1_ += LanguageMgr.GetTranslation("funny.datas.FunnyBagData.title28",conditionList[_loc8_].value,getGoodsName(conditionList[_loc8_].bak));
                  break;
               case 26:
                  _loc1_ += LanguageMgr.GetTranslation("funny.datas.FunnyBagData.title29",conditionList[_loc8_].value);
                  break;
               case 27:
                  _loc1_ += LanguageMgr.GetTranslation("funny.datas.FunnyBagData.title30",conditionList[_loc8_].value);
                  break;
               case 28:
                  _loc1_ += LanguageMgr.GetTranslation("funny.datas.FunnyBagData.title31",conditionList[_loc8_].value);
                  break;
               case 30:
                  _loc1_ += LanguageMgr.GetTranslation("funny.datas.FunnyBagData.title32",conditionList[_loc8_].bak,getPetQualityName(conditionList[_loc8_].value));
                  break;
               case 31:
                  _loc1_ += LanguageMgr.GetTranslation("funny.datas.FunnyBagData.title33",conditionList[_loc8_].value);
                  break;
               case 32:
                  _loc1_ += LanguageMgr.GetTranslation("funny.datas.FunnyBagData.title34",conditionList[_loc8_].value);
                  break;
               case 34:
                  if(conditionList[_loc8_].value == conditionList[_loc8_].bak)
                  {
                     _loc1_ += LanguageMgr.GetTranslation("funny.datas.FunnyBagData.title35",conditionList[_loc8_].value);
                  }
                  else
                  {
                     _loc1_ += LanguageMgr.GetTranslation("funny.datas.FunnyBagData.title36",conditionList[_loc8_].value,conditionList[_loc8_].bak);
                  }
                  break;
               case 35:
                  if(conditionList[_loc8_].value == conditionList[_loc8_].bak)
                  {
                     _loc1_ += LanguageMgr.GetTranslation("funny.datas.FunnyBagData.title37",conditionList[_loc8_].value);
                  }
                  else
                  {
                     _loc1_ += LanguageMgr.GetTranslation("funny.datas.FunnyBagData.title38",conditionList[_loc8_].value,conditionList[_loc8_].bak);
                  }
                  break;
               case 36:
                  if(conditionList[_loc8_].value == conditionList[_loc8_].bak)
                  {
                     _loc1_ += LanguageMgr.GetTranslation("funny.datas.FunnyBagData.title39",conditionList[_loc8_].value);
                  }
                  else
                  {
                     _loc1_ += LanguageMgr.GetTranslation("funny.datas.FunnyBagData.title40",conditionList[_loc8_].value,conditionList[_loc8_].bak);
                  }
                  break;
               case 37:
                  if(conditionList[_loc8_].value == conditionList[_loc8_].bak)
                  {
                     _loc1_ += LanguageMgr.GetTranslation("funny.datas.FunnyBagData.title41",conditionList[_loc8_].value);
                  }
                  else
                  {
                     _loc1_ += LanguageMgr.GetTranslation("funny.datas.FunnyBagData.title42",conditionList[_loc8_].value,conditionList[_loc8_].bak);
                  }
                  break;
               case 38:
                  if(conditionList[_loc8_].value == conditionList[_loc8_].bak)
                  {
                     if(conditionList[_loc8_].bak2 == 1)
                     {
                        _loc1_ += LanguageMgr.GetTranslation("funny.datas.FunnyBagData.title43",conditionList[_loc8_].value);
                     }
                     else if(conditionList[_loc8_].bak2 == 2)
                     {
                        _loc1_ += LanguageMgr.GetTranslation("funny.datas.FunnyBagData.title44",conditionList[_loc8_].value);
                     }
                  }
                  else if(conditionList[_loc8_].bak2 == 1)
                  {
                     _loc1_ += LanguageMgr.GetTranslation("funny.datas.FunnyBagData.title45",conditionList[_loc8_].value,conditionList[_loc8_].bak);
                  }
                  else if(conditionList[_loc8_].bak2 == 2)
                  {
                     _loc1_ += LanguageMgr.GetTranslation("funny.datas.FunnyBagData.title46",conditionList[_loc8_].value,conditionList[_loc8_].bak);
                  }
                  break;
               case 39:
                  _loc1_ += LanguageMgr.GetTranslation("funny.datas.FunnyBagData.title47",conditionList[_loc8_].value);
                  break;
               case 40:
                  _loc1_ += LanguageMgr.GetTranslation("funny.datas.FunnyBagData.title48",conditionList[_loc8_].value,conditionList[_loc8_].bak);
                  break;
               case 41:
                  _loc1_ += LanguageMgr.GetTranslation("funny.datas.FunnyBagData.title49",getJob(conditionList[_loc8_].bak2),getMazeType(conditionList[_loc8_].bak),conditionList[_loc8_].value);
                  break;
               case 42:
               case 126:
                  _loc1_ += LanguageMgr.GetTranslation("funny.datas.FunnyBagData.title50",conditionList[_loc8_].value);
                  break;
               case 44:
                  _loc1_ += LanguageMgr.GetTranslation("funny.datas.FunnyBagData.title51",conditionList[_loc8_].bak,getPetQualityName(conditionList[_loc8_].value + 2));
                  break;
               case 46:
                  _loc1_ += LanguageMgr.GetTranslation("funny.datas.FunnyBagData.title52",conditionList[_loc8_].bak,conditionList[_loc8_].value);
                  break;
               case 45:
                  if(conditionList[_loc8_].bak == 80)
                  {
                     _loc1_ += LanguageMgr.GetTranslation("funny.datas.FunnyBagData.title54",conditionList[_loc8_].value);
                  }
                  else
                  {
                     _loc1_ += LanguageMgr.GetTranslation("funny.datas.FunnyBagData.title53",conditionList[_loc8_].value,conditionList[_loc8_].bak);
                  }
                  break;
               case 47:
                  _loc1_ += LanguageMgr.GetTranslation("funny.datas.FunnyBagData.title56",conditionList[_loc8_].value);
                  break;
               case 48:
                  _loc1_ += LanguageMgr.GetTranslation("funny.datas.FunnyBagData.title57",conditionList[_loc8_].value);
                  break;
               case 51:
                  _loc1_ += LanguageMgr.GetTranslation("funny.TiroFunnyItem.condition.title51_" + conditionList[_loc8_].value);
                  break;
               case 52:
                  _loc1_ += LanguageMgr.GetTranslation("funny.TiroFunnyItem.condition.title52");
                  break;
               case 53:
                  _loc1_ += LanguageMgr.GetTranslation("funny.TiroFunnyItem.condition.title53");
                  break;
               case 54:
                  _loc1_ += LanguageMgr.GetTranslation("funny.TiroFunnyItem.condition.title54");
                  break;
               case 55:
                  _loc1_ += LanguageMgr.GetTranslation("funny.datas.FunnyBagData.title59",conditionList[_loc8_].value);
                  break;
               case 56:
                  _loc1_ += LanguageMgr.GetTranslation("funny.datas.FunnyBagData.title60",conditionList[_loc8_].value);
                  break;
               case 100:
                  _loc1_ += LanguageMgr.GetTranslation("funny.datas.FunnyBagData.title100",conditionList[_loc8_].value);
                  break;
               case 101:
                  _loc1_ += LanguageMgr.GetTranslation("funny.datas.FunnyBagData.title101",conditionList[_loc8_].value);
                  break;
               case 102:
                  _loc1_ += LanguageMgr.GetTranslation("funny.datas.FunnyBagData.title102",conditionList[_loc8_].value);
                  break;
               case 103:
                  _loc1_ += LanguageMgr.GetTranslation("funny.datas.FunnyBagData.title103",conditionList[_loc8_].value);
                  break;
               case 104:
                  _loc1_ += LanguageMgr.GetTranslation("funny.datas.FunnyBagData.title104",getPetQualityName(conditionList[_loc8_].value));
                  break;
               case 105:
                  _loc1_ += LanguageMgr.GetTranslation("funny.datas.FunnyBagData.title105",conditionList[_loc8_].value);
                  break;
               case 106:
                  _loc1_ += LanguageMgr.GetTranslation("funny.datas.FunnyBagData.title106",conditionList[_loc8_].value);
                  break;
               case 107:
                  _loc1_ += LanguageMgr.GetTranslation("funny.datas.FunnyBagData.title107",conditionList[_loc8_].value);
                  break;
               case 108:
                  _loc1_ += LanguageMgr.GetTranslation("funny.datas.FunnyBagData.title108",conditionList[_loc8_].value);
                  break;
               case 109:
                  _loc1_ += LanguageMgr.GetTranslation("funny.datas.FunnyBagData.title109",conditionList[_loc8_].value);
                  break;
               case 110:
                  _loc1_ += LanguageMgr.GetTranslation("funny.datas.FunnyBagData.title110",conditionList[_loc8_].value);
                  break;
               case 111:
                  _loc1_ += LanguageMgr.GetTranslation("funny.datas.FunnyBagData.title111",conditionList[_loc8_].value);
                  break;
               case 112:
                  _loc1_ += LanguageMgr.GetTranslation("funny.datas.FunnyBagData.title112",conditionList[_loc8_].value);
                  break;
               case 113:
                  _loc1_ += LanguageMgr.GetTranslation("funny.datas.FunnyBagData.title113",conditionList[_loc8_].value);
                  break;
               case 114:
                  _loc1_ += LanguageMgr.GetTranslation("funny.datas.FunnyBagData.title114",getPetQualityName(conditionList[_loc8_].value));
                  break;
               case 115:
                  _loc1_ += LanguageMgr.GetTranslation("funny.datas.FunnyBagData.title115",GoodsSonType.getSonTypeName(conditionList[_loc8_].bak),conditionList[_loc8_].value);
                  break;
               case 116:
                  _loc1_ += LanguageMgr.GetTranslation("funny.datas.FunnyBagData.title116",conditionList[_loc8_].value);
                  break;
               case 117:
                  _loc1_ += LanguageMgr.GetTranslation("funny.datas.FunnyBagData.title117",conditionList[_loc8_].value);
                  break;
               case 118:
                  _loc1_ += LanguageMgr.GetTranslation("funny.datas.FunnyBagData.title118",conditionList[_loc8_].value);
                  break;
               case 119:
                  _loc1_ += LanguageMgr.GetTranslation("funny.datas.FunnyBagData.title119",conditionList[_loc8_].value);
                  break;
               case 120:
                  _loc1_ += LanguageMgr.GetTranslation("funny.datas.FunnyBagData.title58",conditionList[_loc8_].value);
                  break;
               case 122:
                  _loc1_ += LanguageMgr.GetTranslation("funny.datas.FunnyBagData.title122",getRewardTaskTypeStr(conditionList[_loc8_].bak),conditionList[_loc8_].value);
                  break;
               case 124:
                  _loc1_ += LanguageMgr.GetTranslation("funny.datas.FunnyBagData.title124",getMountsName(conditionList[_loc8_].value));
                  break;
               case 127:
                  _loc1_ += LanguageMgr.GetTranslation("funny.datas.FunnyBagData.title127",conditionList[_loc8_].value);
                  break;
               case 123:
                  _loc1_ += LanguageMgr.GetTranslation("funny.datas.FunnyBagData.title123",conditionList[_loc8_].value);
                  break;
               case 125:
                  _loc1_ += LanguageMgr.GetTranslation("funny.datas.FunnyBagData.title125",conditionList[_loc8_].value,conditionList[_loc8_].bak);
                  break;
               case 58:
                  _loc1_ += LanguageMgr.GetTranslation("funny.datas.FunnyBagData.title068",conditionList[_loc8_].value);
                  break;
               case 59:
                  _loc1_ += LanguageMgr.GetTranslation("funny.datas.FunnyBagData.title61",conditionList[_loc8_].value);
                  break;
               case 60:
                  _loc1_ += LanguageMgr.GetTranslation("funny.datas.FunnyBagData.title62",conditionList[_loc8_].bak,conditionList[_loc8_].value);
                  break;
               case 61:
                  _loc1_ += LanguageMgr.GetTranslation("funny.datas.FunnyBagData.title63",conditionList[_loc8_].value);
                  break;
               case 10066:
                  _loc1_ += LanguageMgr.GetTranslation("funny.datas.FunnyBagData.title67",conditionList[_loc8_].value);
                  break;
               case 66:
                  if(conditionList[_loc8_].bak == conditionList[_loc8_].bak2)
                  {
                     _loc1_ += LanguageMgr.GetTranslation("funny.datas.FunnyBagData.title68",conditionList[_loc8_].bak,conditionList[_loc8_].bak3);
                  }
                  else
                  {
                     _loc1_ += LanguageMgr.GetTranslation("funny.datas.FunnyBagData.title68",conditionList[_loc8_].bak + "~" + conditionList[_loc8_].bak2,conditionList[_loc8_].bak3);
                  }
                  break;
               case 67:
                  if(conditionList[_loc8_].bak == 1)
                  {
                     _loc1_ += LanguageMgr.GetTranslation("funny.datas.FunnyBagData.title69",conditionList[_loc8_].value);
                  }
                  else if(conditionList[_loc8_].bak == 2)
                  {
                     _loc1_ += LanguageMgr.GetTranslation("funny.datas.FunnyBagData.title69_2",conditionList[_loc8_].value);
                  }
                  break;
               case 73:
                  if(conditionList[_loc8_].bak == 1)
                  {
                     _loc1_ += LanguageMgr.GetTranslation("funny.datas.FunnyBagData.title82",conditionList[_loc8_].value);
                  }
                  else if(conditionList[_loc8_].bak == 2)
                  {
                     _loc1_ += LanguageMgr.GetTranslation("funny.datas.FunnyBagData.title82_2",conditionList[_loc8_].value);
                  }
                  break;
               case 196:
                  if(conditionList[_loc8_].bak == conditionList[_loc8_].bak2)
                  {
                     _loc1_ += LanguageMgr.GetTranslation("funny.datas.FunnyBagData.title90",conditionList[_loc8_].bak,conditionList[_loc8_].bak3);
                  }
                  else
                  {
                     _loc1_ += LanguageMgr.GetTranslation("funny.datas.FunnyBagData.title90",conditionList[_loc8_].bak + "~" + conditionList[_loc8_].bak2,conditionList[_loc8_].bak3);
                  }
                  break;
               case 197:
                  if(conditionList[_loc8_].bak == conditionList[_loc8_].bak2)
                  {
                     _loc1_ += LanguageMgr.GetTranslation("funny.datas.FunnyBagData.title81",conditionList[_loc8_].bak,conditionList[_loc8_].bak3);
                  }
                  else
                  {
                     _loc1_ += LanguageMgr.GetTranslation("funny.datas.FunnyBagData.title81",conditionList[_loc8_].bak + "~" + conditionList[_loc8_].bak2,conditionList[_loc8_].bak3);
                  }
                  break;
               case 129:
                  _loc1_ += LanguageMgr.GetTranslation("funny.datas.FunnyBagData.title129",conditionList[_loc8_].value,conditionList[_loc8_].bak,getEquipType(conditionList[_loc8_].bak2));
                  break;
               case 143:
                  _loc1_ += LanguageMgr.GetTranslation("funny.datas.FunnyBagData.title143",getGoodsName(conditionList[_loc8_].bak),conditionList[_loc8_].value);
                  break;
               case 159:
                  _loc1_ += LanguageMgr.GetTranslation("funny.datas.FunnyBagData.title159",conditionList[_loc8_].value);
                  break;
               case 160:
                  _loc1_ += LanguageMgr.GetTranslation("funny.datas.FunnyBagData.title160",conditionList[_loc8_].value);
                  break;
               case 161:
                  _loc1_ += LanguageMgr.GetTranslation("funny.datas.FunnyBagData.title161",conditionList[_loc8_].value);
                  break;
               case 249:
                  _loc1_ += LanguageMgr.GetTranslation("funny.datas.FunnyBagData.title249",conditionList[_loc8_].value);
                  break;
               case 250:
                  _loc1_ += LanguageMgr.GetTranslation("funny.datas.FunnyBagData.title250",conditionList[_loc8_].value);
                  break;
               case 162:
                  _loc1_ += LanguageMgr.GetTranslation("funny.datas.FunnyBagData.title162",conditionList[_loc8_].value);
                  break;
               case 163:
                  _loc1_ += LanguageMgr.GetTranslation("funny.datas.FunnyBagData.title163",conditionList[_loc8_].value);
                  break;
               case 164:
                  _loc1_ += LanguageMgr.GetTranslation("funny.datas.FunnyBagData.title164",conditionList[_loc8_].bak,conditionList[_loc8_].value);
                  break;
               case 166:
                  _loc1_ += LanguageMgr.GetTranslation("funny.datas.FunnyBagData.title166",conditionList[_loc8_].value,conditionList[_loc8_].bak);
                  break;
               case 167:
                  _loc1_ += LanguageMgr.GetTranslation("funny.datas.FunnyBagData.title167",conditionList[_loc8_].bak,conditionList[_loc8_].value);
                  break;
               case 168:
                  _loc1_ += LanguageMgr.GetTranslation("funny.datas.FunnyBagData.title168",conditionList[_loc8_].value);
                  break;
               case 169:
               case 170:
                  _loc1_ += LanguageMgr.GetTranslation("funny.datas.FunnyBagData.title169",conditionList[_loc8_].bak,conditionList[_loc8_].value);
                  break;
               case 152:
                  _loc1_ += LanguageMgr.GetTranslation("funny.datas.FunnyBagData.title152",conditionList[_loc8_].bak,conditionList[_loc8_].value);
                  break;
               case 153:
                  _loc1_ += LanguageMgr.GetTranslation("funny.datas.FunnyBagData.title153",conditionList[_loc8_].bak,getPetQualityName(conditionList[_loc8_].value));
                  break;
               case 154:
                  _loc1_ += LanguageMgr.GetTranslation("funny.datas.FunnyBagData.title154",conditionList[_loc8_].bak,conditionList[_loc8_].value);
                  break;
               case 157:
               case 158:
                  _loc1_ += LanguageMgr.GetTranslation("funny.datas.FunnyBagData.title157",conditionList[_loc8_].bak,conditionList[_loc8_].value);
                  break;
               case 155:
               case 156:
                  _loc1_ += LanguageMgr.GetTranslation("funny.datas.FunnyBagData.title155",conditionList[_loc8_].bak,conditionList[_loc8_].value);
                  break;
               case 171:
                  _loc1_ += LanguageMgr.GetTranslation("funny.datas.FunnyBagData.title167",conditionList[_loc8_].bak,conditionList[_loc8_].value);
                  break;
               case 165:
                  _loc1_ += LanguageMgr.GetTranslation("funny.datas.FunnyBagData.title165",conditionList[_loc8_].value);
                  break;
               case 176:
                  _loc1_ += LanguageMgr.GetTranslation("funny.datas.FunnyBagData.title176",conditionList[_loc8_].value);
                  break;
               case 177:
                  _loc1_ += LanguageMgr.GetTranslation("funny.datas.FunnyBagData.title177",conditionList[_loc8_].value);
                  break;
               case 138:
                  _loc1_ += LanguageMgr.GetTranslation("funny.datas.FunnyBagData.title138");
                  break;
               case 141:
                  _loc1_ += LanguageMgr.GetTranslation("funny.datas.FunnyBagData.title141",conditionList[_loc8_].value);
                  break;
               case 142:
                  _loc1_ += LanguageMgr.GetTranslation("funny.datas.FunnyBagData.title142",conditionList[_loc8_].value);
                  break;
               case 174:
                  _loc1_ += LanguageMgr.GetTranslation("funny.datas.FunnyBagData.title174",conditionList[_loc8_].bak,getPetQualityName(conditionList[_loc8_].value));
                  break;
               case 175:
                  _loc1_ += LanguageMgr.GetTranslation("funny.datas.FunnyBagData.title175",conditionList[_loc8_].bak,getGoodsName(conditionList[_loc8_].value));
                  break;
               case 178:
                  _loc1_ += LanguageMgr.GetTranslation("funny.datas.FunnyBagData.title178",getCastTextByGrade(conditionList[_loc8_].value),conditionList[_loc8_].bak);
                  break;
               case 179:
                  _loc1_ += LanguageMgr.GetTranslation("funny.datas.FunnyBagData.title57",conditionList[_loc8_].value);
                  break;
               case 180:
                  _loc1_ += LanguageMgr.GetTranslation("funny.datas.FunnyBagData.title180_" + conditionList[_loc8_].bak2,conditionList[_loc8_].bak,conditionList[_loc8_].value);
                  break;
               case 181:
                  _loc1_ += LanguageMgr.GetTranslation("funny.datas.FunnyBagData.title181_" + conditionList[_loc8_].value,conditionList[_loc8_].bak);
                  break;
               case 71:
                  _loc1_ += LanguageMgr.GetTranslation("funny.datas.FunnyBagData.title071",conditionList[_loc8_].value);
                  break;
               case 182:
                  _loc1_ += LanguageMgr.GetTranslation("funny.datas.FunnyBagData.title182",conditionList[_loc8_].value);
                  break;
               case 183:
                  _loc1_ += LanguageMgr.GetTranslation("funny.datas.FunnyBagData.title183",conditionList[_loc8_].value);
                  break;
               case 184:
                  _loc1_ += LanguageMgr.GetTranslation("funny.datas.FunnyBagData.title184",conditionList[_loc8_].value);
                  break;
               case 185:
                  _loc1_ += LanguageMgr.GetTranslation("funny.datas.FunnyBagData.title185",conditionList[_loc8_].value);
                  break;
               case 187:
                  _loc1_ += LanguageMgr.GetTranslation("funny.datas.FunnyBagData.title187",conditionList[_loc8_].value);
                  break;
               case 188:
                  _loc1_ += LanguageMgr.GetTranslation("funny.datas.FunnyBagData.title188",conditionList[_loc8_].value);
                  break;
               case 189:
                  _loc1_ += LanguageMgr.GetTranslation("funny.datas.FunnyBagData.title189",conditionList[_loc8_].value);
                  break;
               case 190:
                  _loc1_ += LanguageMgr.GetTranslation("funny.datas.FunnyBagData.title190",conditionList[_loc8_].value);
                  break;
               case 191:
                  _loc1_ += LanguageMgr.GetTranslation("funny.datas.FunnyBagData.title191",conditionList[_loc8_].value);
                  break;
               case 192:
                  _loc1_ += LanguageMgr.GetTranslation("funny.datas.FunnyBagData.title192",conditionList[_loc8_].value);
                  break;
               case 193:
                  _loc1_ += LanguageMgr.GetTranslation("funny.datas.FunnyBagData.title193",conditionList[_loc8_].value);
                  break;
               case 194:
                  _loc1_ += LanguageMgr.GetTranslation("funny.datas.FunnyBagData.title194",conditionList[_loc8_].value);
                  break;
               case 195:
                  _loc1_ += LanguageMgr.GetTranslation("funny.datas.FunnyBagData.title195",conditionList[_loc8_].value);
                  break;
               case 198:
                  _loc1_ += LanguageMgr.GetTranslation("funny.datas.FunnyBagData.title198",conditionList[_loc8_].value);
                  break;
               case 199:
                  _loc1_ += LanguageMgr.GetTranslation("funny.datas.FunnyBagData.title199",conditionList[_loc8_].value);
                  break;
               case 200:
                  _loc1_ += LanguageMgr.GetTranslation("funny.datas.FunnyBagData.title200",conditionList[_loc8_].value);
                  break;
               case 202:
                  _loc1_ += LanguageMgr.GetTranslation("funny.datas.FunnyBagData.title202",conditionList[_loc8_].value);
                  break;
               case 203:
                  _loc1_ += LanguageMgr.GetTranslation("funny.datas.FunnyBagData.title203",conditionList[_loc8_].value);
                  break;
               case 204:
                  _loc1_ += LanguageMgr.GetTranslation("funny.datas.FunnyBagData.title204",conditionList[_loc8_].value);
                  break;
               case 205:
                  _loc1_ += LanguageMgr.GetTranslation("funny.datas.FunnyBagData.title205",conditionList[_loc8_].value);
                  break;
               case 206:
                  if(conditionList[_loc8_].bak == 1)
                  {
                     _loc1_ += LanguageMgr.GetTranslation("funny.datas.FunnyBagData.title206_1",conditionList[_loc8_].value);
                  }
                  else
                  {
                     _loc1_ += LanguageMgr.GetTranslation("funny.datas.FunnyBagData.title206_2",conditionList[_loc8_].value);
                  }
                  break;
               case 207:
                  _loc1_ += LanguageMgr.GetTranslation("funny.datas.FunnyBagData.title207",conditionList[_loc8_].bak,conditionList[_loc8_].value);
                  break;
               case 208:
                  _loc1_ += LanguageMgr.GetTranslation("funny.datas.FunnyBagData.title208",conditionList[_loc8_].value);
                  break;
               case 209:
                  _loc1_ += LanguageMgr.GetTranslation("funny.datas.FunnyBagData.title209",conditionList[_loc8_].value);
                  break;
               case 210:
                  _loc1_ += LanguageMgr.GetTranslation("funny.datas.FunnyBagData.title210",conditionList[_loc8_].value);
                  break;
               case 211:
                  _loc1_ += LanguageMgr.GetTranslation("funny.datas.FunnyBagData.title211",conditionList[_loc8_].value);
                  break;
               case 212:
                  _loc1_ += LanguageMgr.GetTranslation("funny.datas.FunnyBagData.title212",conditionList[_loc8_].value);
                  break;
               case 213:
                  _loc1_ += LanguageMgr.GetTranslation("funny.datas.FunnyBagData.title213",conditionList[_loc8_].value);
                  break;
               case 214:
                  _loc1_ += LanguageMgr.GetTranslation("funny.datas.FunnyBagData.title214",conditionList[_loc8_].value);
                  break;
               case 215:
                  _loc1_ += LanguageMgr.GetTranslation("funny.datas.FunnyBagData.title215",conditionList[_loc8_].value);
                  break;
               case 216:
                  _loc1_ += LanguageMgr.GetTranslation("funny.datas.FunnyBagData.title216",conditionList[_loc8_].value);
                  break;
               case 217:
                  _loc1_ += LanguageMgr.GetTranslation("funny.datas.FunnyBagData.title217",conditionList[_loc8_].value);
                  break;
               case 218:
                  _loc1_ += LanguageMgr.GetTranslation("funny.datas.FunnyBagData.title218",conditionList[_loc8_].value);
                  break;
               case 219:
                  _loc1_ += LanguageMgr.GetTranslation("funny.datas.FunnyBagData.title219",conditionList[_loc8_].value);
                  break;
               case 220:
                  _loc1_ += LanguageMgr.GetTranslation("funny.datas.FunnyBagData.title220",conditionList[_loc8_].value);
                  break;
               case 223:
                  _loc1_ += LanguageMgr.GetTranslation("funny.datas.FunnyBagData.title223",conditionList[_loc8_].value);
                  break;
               case 224:
                  _loc1_ += LanguageMgr.GetTranslation("funny.datas.FunnyBagData.title224",conditionList[_loc8_].value);
                  break;
               case 225:
                  _loc1_ += LanguageMgr.GetTranslation("funny.datas.FunnyBagData.title225",conditionList[_loc8_].value);
                  break;
               case 226:
                  _loc1_ += LanguageMgr.GetTranslation("funny.datas.FunnyBagData.title226",conditionList[_loc8_].value);
                  break;
               case 227:
                  _loc3_ = "<font color=\'#FFFFFF\'><p>" + conditionList[_loc8_].value + "</p></font>";
                  _loc1_ += LanguageMgr.GetTranslation("funny.datas.FunnyBagData.title227",_loc3_,getArmoryTypeStr(conditionList[_loc8_].bak));
                  break;
               case 228:
                  _loc1_ += LanguageMgr.GetTranslation("funny.datas.FunnyBagData.title228",conditionList[_loc8_].value);
                  break;
               case 229:
                  _loc1_ += LanguageMgr.GetTranslation("funny.datas.FunnyBagData.title229",conditionList[_loc8_].value);
                  break;
               case 230:
                  _loc1_ += LanguageMgr.GetTranslation("funny.datas.FunnyBagData.title230",conditionList[_loc8_].value);
                  break;
               case 247:
                  _loc1_ += LanguageMgr.GetTranslation("funny.datas.FunnyBagData.title247",conditionList[_loc8_].value);
                  break;
               case 248:
                  _loc1_ += LanguageMgr.GetTranslation("funny.datas.FunnyBagData.title248",conditionList[_loc8_].value);
                  break;
               case 233:
               case 234:
               case 235:
               case 236:
               case 237:
               case 238:
               case 239:
               case 240:
               case 241:
               case 242:
               case 243:
               case 244:
                  _loc1_ += LanguageMgr.GetTranslation("funny.FunnyRightView.processItem" + conditionList[_loc8_].id,conditionList[_loc8_].value);
                  break;
               case 246:
                  _loc4_ = conditionList[_loc8_].value;
                  if(_loc4_ > 0)
                  {
                     _loc6_ = (_loc4_ - 1) / 10 + 1;
                     _loc12_ = _loc4_ % 10;
                     if(_loc12_ == 0)
                     {
                        _loc12_ = 10;
                     }
                  }
                  else
                  {
                     _loc6_ = 0;
                     _loc12_ = 0;
                  }
                  if(_loc6_ > 8 && _loc6_ <= 16)
                  {
                     _loc11_ = _loc6_ - 8;
                  }
                  else if(_loc6_ > 16)
                  {
                     _loc11_ = _loc6_ - 16;
                  }
                  else
                  {
                     _loc11_ = _loc6_;
                  }
                  if(_loc6_ > 16)
                  {
                     _loc7_ = LanguageMgr.GetTranslation("yishi.view.tips.goods.EquipTipsContent.castSelected.text4",_loc11_,_loc12_);
                  }
                  else if(_loc6_ > 8)
                  {
                     _loc7_ = LanguageMgr.GetTranslation("yishi.view.tips.goods.EquipTipsContent.castSelected.text3",_loc11_,_loc12_);
                  }
                  else
                  {
                     _loc7_ = LanguageMgr.GetTranslation("yishi.view.tips.goods.EquipTipsContent.castSelected.text2",_loc11_,_loc12_);
                  }
                  _loc1_ += LanguageMgr.GetTranslation("funny.FunnyRightView.processItem" + conditionList[_loc8_].id,_loc7_);
                  break;
               case 245:
                  _loc9_ = conditionList[_loc8_].bak;
                  _loc2_ = LanguageMgr.GetTranslation("funny.FunnyRightView.processItem245_1");
                  _loc10_ = _loc2_.split(",");
                  if(_loc9_ < 2)
                  {
                     _loc9_ = 2;
                  }
                  _loc5_ = _loc10_[_loc9_ - 2];
                  _loc1_ += LanguageMgr.GetTranslation("funny.FunnyRightView.processItem" + conditionList[_loc8_].id,_loc5_,conditionList[_loc8_].value);
                  break;
               case 98:
                  _loc1_ += LanguageMgr.GetTranslation("funny.FunnyRightView.processItem.active" + conditionList[_loc8_].bak,conditionList[_loc8_].value);
                  break;
               case 3:
                  if(conditionList[_loc8_].value <= 0)
                  {
                     _loc1_ += LanguageMgr.GetTranslation("funny.datas.FunnyBagData.title17");
                  }
                  else
                  {
                     _loc1_ += LanguageMgr.GetTranslation("funny.datas.FunnyBagData.title18",conditionList[_loc8_].value);
                  }
                  return _loc1_;
            }
            _loc8_++;
         }
         return LanguageMgr.GetTranslation("funny.datas.FunnyBagData.title0",_loc1_);
      }
      
      private function getCastTextByGrade(param1:int) : String
      {
         var _loc3_:int = 0;
         var _loc2_:int = 0;
         if(param1 > 0)
         {
            _loc3_ = (param1 - 1) / 10 + 1;
            _loc2_ = param1 % 10;
            if(_loc2_ == 0)
            {
               _loc2_ = 10;
            }
            if(_loc3_ > 8)
            {
               return LanguageMgr.GetTranslation("funny.datas.FunnyBagData.title178_1",_loc3_,_loc2_);
            }
            return LanguageMgr.GetTranslation("funny.datas.FunnyBagData.title178_2",_loc3_,_loc2_);
         }
         return "";
      }
      
      private function getEquipType(param1:int) : String
      {
         return LanguageMgr.GetTranslation("funny.datas.FunnyBagData.equipCollect" + param1);
      }
      
      private function getRewardTaskTypeStr(param1:int) : String
      {
         var _loc2_:String = null;
         switch(param1 - 1)
         {
            case 0:
               _loc2_ = "<font color=\'#FFFFFF\'><p>" + LanguageMgr.GetTranslation("funny.datas.FunnyBagData.RewardTaskType1") + "</p></font>";
               break;
            case 1:
               _loc2_ = "<font color=\'#59CD41\'><p>" + LanguageMgr.GetTranslation("funny.datas.FunnyBagData.RewardTaskType2") + "</p></font>";
               break;
            case 2:
               _loc2_ = "<font color=\'#32A2F8\'><p>" + LanguageMgr.GetTranslation("funny.datas.FunnyBagData.RewardTaskType3") + "</p></font>";
               break;
            case 3:
               _loc2_ = "<font color=\'#A838F7\'><p>" + LanguageMgr.GetTranslation("funny.datas.FunnyBagData.RewardTaskType4") + "</p></font>";
               break;
            case 4:
               _loc2_ = "<font color=\'#FF8000\'><p>" + LanguageMgr.GetTranslation("funny.datas.FunnyBagData.RewardTaskType5") + "</p></font>";
         }
         return _loc2_;
      }
      
      private function getArmoryTypeStr(param1:int) : String
      {
         var _loc2_:String = null;
         switch(param1 - 1)
         {
            case 0:
               _loc2_ = "<font color=\'#59CD41\'><p>" + LanguageMgr.GetTranslation("ancientartifact.AncientAdvanceFrame.armoryTips01") + "</p></font>";
               break;
            case 1:
               _loc2_ = "<font color=\'#32A2F8\'><p>" + LanguageMgr.GetTranslation("ancientartifact.AncientAdvanceFrame.armoryTips02") + "</p></font>";
               break;
            case 2:
               _loc2_ = "<font color=\'#A838F7\'><p>" + LanguageMgr.GetTranslation("ancientartifact.AncientAdvanceFrame.armoryTips03") + "</p></font>";
               break;
            case 3:
               _loc2_ = "<font color=\'#FF8000\'><p>" + LanguageMgr.GetTranslation("ancientartifact.AncientAdvanceFrame.armoryTips04") + "</p></font>";
               break;
            case 4:
               _loc2_ = "<font color=\'#FF0000\'><p>" + LanguageMgr.GetTranslation("ancientartifact.AncientAdvanceFrame.armoryTips05") + "</p></font>";
         }
         return _loc2_;
      }
      
      public function get tiroTitle() : String
      {
         var _loc2_:int = 0;
         if(!conditionList)
         {
            return "";
         }
         var _loc1_:String = "";
         _loc2_ = 0;
         while(_loc2_ < conditionList.length)
         {
            switch(conditionList[_loc2_].id)
            {
               case 6:
                  _loc1_ += LanguageMgr.GetTranslation("funny.TiroFunnyItem.condition.title6",conditionList[_loc2_].value,conditionList[_loc2_].bak);
                  break;
               case 12:
                  _loc1_ += LanguageMgr.GetTranslation("funny.TiroFunnyItem.condition.title12",GoodsSonType.getSonTypeName(conditionList[_loc2_].bak),conditionList[_loc2_].value);
                  break;
               case 19:
                  _loc1_ += LanguageMgr.GetTranslation("funny.TiroFunnyItem.condition.title19",conditionList[_loc2_].value,FunnyManager.instance.getTiroFunnyDataByActivityId().finishNum);
                  break;
               case 25:
                  _loc1_ += LanguageMgr.GetTranslation("funny.TiroFunnyItem.condition.title25",conditionList[_loc2_].value,getGoodsName(conditionList[_loc2_].bak),FunnyManager.instance.getTiroFunnyDataByActivityId().finishNum);
                  break;
               case 36:
                  if(conditionList[_loc2_].value == conditionList[_loc2_].bak)
                  {
                     _loc1_ += LanguageMgr.GetTranslation("funny.TiroFunnyItem.condition.title36_1",conditionList[_loc2_].value);
                  }
                  else
                  {
                     _loc1_ += LanguageMgr.GetTranslation("funny.TiroFunnyItem.condition.title36_2",conditionList[_loc2_].value,conditionList[_loc2_].bak);
                  }
                  break;
               case 37:
                  if(conditionList[_loc2_].value == conditionList[_loc2_].bak)
                  {
                     _loc1_ += LanguageMgr.GetTranslation("funny.TiroFunnyItem.condition.title37_1",conditionList[_loc2_].value);
                  }
                  else
                  {
                     _loc1_ += LanguageMgr.GetTranslation("funny.TiroFunnyItem.condition.title37_2",conditionList[_loc2_].value,conditionList[_loc2_].bak);
                  }
                  break;
               case 38:
                  if(conditionList[_loc2_].value == conditionList[_loc2_].bak)
                  {
                     if(conditionList[_loc2_].bak2 == 1)
                     {
                        _loc1_ += LanguageMgr.GetTranslation("funny.TiroFunnyItem.condition.title38_1",conditionList[_loc2_].value);
                     }
                     else if(conditionList[_loc2_].bak2 == 2)
                     {
                        _loc1_ += LanguageMgr.GetTranslation("funny.TiroFunnyItem.condition.title38_2",conditionList[_loc2_].value);
                     }
                  }
                  else if(conditionList[_loc2_].bak2 == 1)
                  {
                     _loc1_ += LanguageMgr.GetTranslation("funny.TiroFunnyItem.condition.title38_3",conditionList[_loc2_].value,conditionList[_loc2_].bak);
                  }
                  else if(conditionList[_loc2_].bak2 == 2)
                  {
                     _loc1_ += LanguageMgr.GetTranslation("funny.TiroFunnyItem.condition.title38_4",conditionList[_loc2_].value,conditionList[_loc2_].bak);
                  }
                  break;
               case 39:
                  _loc1_ += LanguageMgr.GetTranslation("funny.TiroFunnyItem.condition.title39",conditionList[_loc2_].value,FunnyManager.instance.getTiroFunnyDataByActivityId().finishNum);
                  break;
               case 41:
                  if(conditionList[_loc2_].bak3 == 0)
                  {
                     _loc1_ += LanguageMgr.GetTranslation("funny.TiroFunnyItem.condition.title41_1",getJob(conditionList[_loc2_].bak2),getMazeType(conditionList[_loc2_].bak),conditionList[_loc2_].value);
                  }
                  else
                  {
                     _loc1_ += LanguageMgr.GetTranslation("funny.TiroFunnyItem.condition.title41_2",getJob(conditionList[_loc2_].bak2),getMazeType(conditionList[_loc2_].bak),conditionList[_loc2_].value);
                  }
                  break;
               case 42:
               case 126:
                  _loc1_ += LanguageMgr.GetTranslation("funny.TiroFunnyItem.condition.title42",conditionList[_loc2_].value);
                  break;
               case 45:
                  if(conditionList[_loc2_].bak == 80)
                  {
                     _loc1_ += LanguageMgr.GetTranslation("funny.TiroFunnyItem.condition.title45_1",conditionList[_loc2_].value);
                  }
                  else
                  {
                     _loc1_ += LanguageMgr.GetTranslation("funny.TiroFunnyItem.condition.title45_2",conditionList[_loc2_].value,conditionList[_loc2_].bak);
                  }
            }
            _loc2_++;
         }
         return _loc1_;
      }
      
      private function getMazeType(param1:int) : String
      {
         return param1 == 1 ? LanguageMgr.GetTranslation("castle.view.CastleBuildingView.command11") : LanguageMgr.GetTranslation("maze.order.MazeOrderFrame.title2");
      }
      
      private function getJob(param1:int) : String
      {
         var _loc2_:String = "";
         switch(param1 - 1)
         {
            case 0:
               _loc2_ = LanguageMgr.GetTranslation("yishi.datas.consant.JobType.Name02");
               break;
            case 1:
               _loc2_ = LanguageMgr.GetTranslation("yishi.datas.consant.JobType.Name03");
               break;
            case 2:
               _loc2_ = LanguageMgr.GetTranslation("yishi.datas.consant.JobType.Name04");
         }
         return _loc2_;
      }
      
      private function getPetQualityName(param1:int) : String
      {
         var _loc2_:String = "";
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
      
      private function getGoodsName(param1:int) : String
      {
         return TempleteManager.instance.goodsTemplateCate.getTemplateByID(param1).TemplateName;
      }
      
      private function getMountsName(param1:int) : String
      {
         return TempleteManager.instance.mountTemplateDic[param1].TemplateName;
      }
   }
}

