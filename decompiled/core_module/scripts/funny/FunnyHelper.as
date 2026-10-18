package funny
{
   import flash.utils.Dictionary;
   import funny.datas.FunnyBagData;
   import funny.datas.FunnyData;
   import manager.LanguageMgr;
   import managers.ActivityManager;
   import managers.DayGuideManager;
   import managers.FunnyManager;
   import managers.ShopManager;
   import mvc.module.dayGuide.DayGuideCatecory;
   import yishi.datas.playerinfo.PlayerInfo;
   import yishi.datas.playerinfo.PlayerModel;
   import yishi.manager.GoodsManager;
   import yishi.manager.PlayerManager;
   import yishi.manager.SharedManager;
   import yishi.manager.TempleteManager;
   
   public class FunnyHelper
   {
      
      public function FunnyHelper()
      {
         super();
      }
      
      public static function get showNumer() : int
      {
         var _loc2_:int = 0;
         var _loc1_:int = 0;
         _loc2_ = 0;
         while(_loc2_ < activityList.length)
         {
            if(!oldDic[activityList[_loc2_].activeId])
            {
               _loc1_++;
            }
            _loc2_++;
         }
         if(ShopManager.Instance.model.getTimeBuyList(0).length > 0)
         {
            if(!oldDic["HOT_BUY_ID"])
            {
               _loc1_++;
            }
         }
         if(ShopManager.Instance.model.getTimeBuyList(1).length > 0)
         {
            if(!oldDic["VIP_BUY_ID"])
            {
               _loc1_++;
            }
         }
         _loc2_ = 0;
         while(_loc2_ < FunnyManager.instance.model.data.length)
         {
            if(FunnyManager.instance.model.data[_loc2_])
            {
               if(!(FunnyManager.instance.model.data[_loc2_].showEnd < playerModel.nowDate || FunnyManager.instance.model.data[_loc2_].showStart > playerModel.nowDate))
               {
                  if(!(FunnyManager.instance.model.data[_loc2_].type == 4 && !playerInfo.isBackPlayer))
                  {
                     if(FunnyManager.instance.model.data[_loc2_].type != 2500)
                     {
                        if(FunnyManager.instance.model.data[_loc2_].type != 2501)
                        {
                           if(!oldDic[FunnyManager.instance.model.data[_loc2_].id])
                           {
                              _loc1_++;
                           }
                        }
                     }
                  }
               }
            }
            _loc2_++;
         }
         return _loc1_;
      }
      
      public static function processText(param1:FunnyData) : String
      {
         var _loc3_:FunnyBagData = null;
         var _loc10_:String = null;
         var _loc2_:int = 0;
         var _loc13_:Array = null;
         var _loc4_:int = 0;
         var _loc12_:int = 0;
         var _loc6_:int = 0;
         var _loc11_:int = 0;
         var _loc7_:Array = null;
         var _loc8_:int = 0;
         var _loc15_:int = 0;
         var _loc9_:int = 0;
         var _loc14_:String = null;
         var _loc5_:int = 0;
         if(param1 == null)
         {
            return "";
         }
         if(param1.bagList.length <= 0 || param1.bagList[0].conditionList.length <= 0)
         {
            return "";
         }
         switch(param1.type)
         {
            case 1:
               _loc10_ = LanguageMgr.GetTranslation("funny.FunnyRightView.process01",param1.finishNum);
               break;
            case 2:
               _loc10_ = LanguageMgr.GetTranslation("funny.FunnyRightView.process02",param1.finishNum);
               break;
            case 5:
               _loc10_ = LanguageMgr.GetTranslation("funny.FunnyRightView.process03",param1.finishNum);
               break;
            case 7:
               _loc10_ = LanguageMgr.GetTranslation("funny.FunnyRightView.process04",param1.finishNum);
               break;
            case 10:
               _loc2_ = int(param1.bagList.length);
               _loc13_ = [];
               _loc4_ = 0;
               while(_loc4_ < _loc2_)
               {
                  _loc12_ = int(param1.bagList[_loc4_].conditionList.length);
                  _loc6_ = 0;
                  while(_loc6_ < _loc12_)
                  {
                     if(_loc4_ == 0 && _loc6_ == 0)
                     {
                        _loc10_ = LanguageMgr.GetTranslation("funny.view.FunnyRightView.currentNum",getGoodsName(param1.bagList[0].conditionList[0].bak),getBagCount(param1.bagList[0].conditionList[0].bak));
                        _loc13_.push(param1.bagList[0].conditionList[0].bak);
                     }
                     else if(_loc13_.indexOf(param1.bagList[_loc4_].conditionList[_loc6_].bak) < 0)
                     {
                        _loc10_ += "," + getGoodsName(param1.bagList[_loc4_].conditionList[_loc6_].bak) + " x " + getBagCount(param1.bagList[_loc4_].conditionList[_loc6_].bak);
                        _loc13_.push(param1.bagList[_loc4_].conditionList[_loc6_].bak);
                     }
                     _loc6_++;
                  }
                  _loc4_++;
               }
               break;
            case 201:
               _loc11_ = int(param1.bagList.length);
               _loc7_ = [];
               _loc8_ = 0;
               while(_loc8_ < _loc11_)
               {
                  _loc15_ = int(param1.bagList[_loc8_].conditionList.length);
                  _loc9_ = 0;
                  while(_loc9_ < _loc15_)
                  {
                     if(_loc8_ == 0 && _loc9_ == 0)
                     {
                        _loc10_ = LanguageMgr.GetTranslation("funny.view.FunnyRightView.currentNum",getGoodsName(param1.bagList[0].conditionList[0].bak),getBagCount(param1.bagList[0].conditionList[0].bak));
                        _loc7_.push(param1.bagList[0].conditionList[0].bak);
                     }
                     else if(_loc7_.indexOf(param1.bagList[_loc8_].conditionList[_loc9_].bak) < 0)
                     {
                        _loc10_ += "," + getGoodsName(param1.bagList[_loc8_].conditionList[_loc9_].bak) + " x " + getBagCount(param1.bagList[_loc8_].conditionList[_loc9_].bak);
                        _loc7_.push(param1.bagList[_loc8_].conditionList[_loc9_].bak);
                     }
                     _loc9_++;
                  }
                  _loc8_++;
               }
               break;
            case 18:
               if(param1.getWay == 2)
               {
                  _loc10_ = LanguageMgr.GetTranslation("funny.FunnyRightView.process05",param1.finishNum) + LanguageMgr.GetTranslation("funny.FunnyRightView.process.canGet",param1.canGet);
               }
               else
               {
                  _loc10_ = LanguageMgr.GetTranslation("funny.FunnyRightView.process05",param1.finishNum);
               }
               break;
            case 19:
               if(param1.getWay == 2)
               {
                  _loc10_ = LanguageMgr.GetTranslation("funny.FunnyRightView.process12_1");
                  _loc4_ = 0;
                  while(_loc4_ < param1.bagList.length)
                  {
                     _loc3_ = param1.bagList[_loc4_];
                     _loc10_ += "\n";
                     _loc10_ = _loc10_ + LanguageMgr.GetTranslation("funny.FunnyRightView.process12_2",getGoodsName(_loc3_.conditionList[0].bak),_loc3_.finshCount,_loc3_.getCount);
                     _loc4_++;
                  }
               }
               else
               {
                  _loc14_ = getGoodsName(param1.bagList[0].conditionList[0].bak);
                  _loc10_ = LanguageMgr.GetTranslation("funny.FunnyRightView.process06",_loc14_,param1.finishNum);
               }
               break;
            case 20:
               if(param1.getWay == 2)
               {
                  _loc10_ = LanguageMgr.GetTranslation("funny.FunnyRightView.process07",param1.finishNum) + LanguageMgr.GetTranslation("funny.FunnyRightView.process.canGet",param1.canGet);
               }
               else
               {
                  _loc10_ = LanguageMgr.GetTranslation("funny.FunnyRightView.process07",param1.finishNum);
               }
               break;
            case 21:
               if(param1.getWay == 2)
               {
                  _loc10_ = LanguageMgr.GetTranslation("funny.FunnyRightView.process08",param1.finishNum) + LanguageMgr.GetTranslation("funny.FunnyRightView.process.canGet",param1.canGet);
               }
               else
               {
                  _loc10_ = LanguageMgr.GetTranslation("funny.FunnyRightView.process08",param1.finishNum);
               }
               break;
            case 22:
               if(param1.getWay == 2)
               {
                  _loc10_ = LanguageMgr.GetTranslation("funny.FunnyRightView.process09",param1.finishNum) + LanguageMgr.GetTranslation("funny.FunnyRightView.process.canGet",param1.canGet);
               }
               else
               {
                  _loc10_ = LanguageMgr.GetTranslation("funny.FunnyRightView.process09",param1.finishNum);
               }
               break;
            case 23:
               if(param1.getWay == 2)
               {
                  _loc10_ = LanguageMgr.GetTranslation("funny.FunnyRightView.process10",param1.finishNum) + LanguageMgr.GetTranslation("funny.FunnyRightView.process.canGet",param1.canGet);
               }
               else
               {
                  _loc10_ = LanguageMgr.GetTranslation("funny.FunnyRightView.process10",param1.finishNum);
               }
               break;
            case 24:
               if(param1.getWay == 2)
               {
                  _loc10_ = LanguageMgr.GetTranslation("funny.FunnyRightView.process11",param1.finishNum) + LanguageMgr.GetTranslation("funny.FunnyRightView.process.canGet",param1.canGet);
               }
               else
               {
                  _loc10_ = LanguageMgr.GetTranslation("funny.FunnyRightView.process11",param1.finishNum);
               }
               break;
            case 25:
               if(param1.getWay == 2)
               {
                  _loc10_ = LanguageMgr.GetTranslation("funny.FunnyRightView.process12_1");
                  _loc4_ = 0;
                  while(_loc4_ < param1.bagList.length)
                  {
                     _loc3_ = param1.bagList[_loc4_];
                     _loc10_ += "\n";
                     _loc10_ = _loc10_ + LanguageMgr.GetTranslation("funny.FunnyRightView.process12_2",getGoodsName(_loc3_.conditionList[0].bak),_loc3_.finshCount,_loc3_.getCount);
                     _loc4_++;
                  }
               }
               else
               {
                  _loc10_ = LanguageMgr.GetTranslation("funny.FunnyRightView.process12",param1.finishNum);
               }
               break;
            case 26:
               if(param1.getWay == 2)
               {
                  _loc10_ = LanguageMgr.GetTranslation("funny.FunnyRightView.process13",param1.finishNum) + LanguageMgr.GetTranslation("funny.FunnyRightView.process.canGet",param1.canGet);
               }
               else
               {
                  _loc10_ = LanguageMgr.GetTranslation("funny.FunnyRightView.process13",param1.finishNum);
               }
               break;
            case 27:
               if(param1.getWay == 2)
               {
                  _loc10_ = LanguageMgr.GetTranslation("funny.FunnyRightView.process14",param1.finishNum) + LanguageMgr.GetTranslation("funny.FunnyRightView.process.canGet",param1.canGet);
               }
               else
               {
                  _loc10_ = LanguageMgr.GetTranslation("funny.FunnyRightView.process14",param1.finishNum);
               }
               break;
            case 28:
               if(param1.getWay == 2)
               {
                  _loc10_ = LanguageMgr.GetTranslation("funny.FunnyRightView.process15",param1.finishNum) + LanguageMgr.GetTranslation("funny.FunnyRightView.process.canGet",param1.canGet);
               }
               else
               {
                  _loc10_ = LanguageMgr.GetTranslation("funny.FunnyRightView.process15",param1.finishNum);
               }
               break;
            case 12:
               _loc10_ = LanguageMgr.GetTranslation("funny.FunnyRightView.process16",dayGuideCate.active);
               break;
            case 39:
               _loc10_ = LanguageMgr.GetTranslation("funny.FunnyRightView.process17",param1.finishNum);
               break;
            case 47:
               if(param1.getWay == 2)
               {
                  _loc10_ = LanguageMgr.GetTranslation("funny.FunnyRightView.process18",param1.finishNum) + LanguageMgr.GetTranslation("funny.FunnyRightView.process.canGet",param1.canGet);
               }
               else
               {
                  _loc10_ = LanguageMgr.GetTranslation("funny.FunnyRightView.process18",param1.finishNum);
               }
               break;
            case 48:
               if(param1.getWay == 2)
               {
                  _loc10_ = LanguageMgr.GetTranslation("funny.FunnyRightView.process19",param1.finishNum) + LanguageMgr.GetTranslation("funny.FunnyRightView.process.canGet",param1.canGet);
               }
               else
               {
                  _loc10_ = LanguageMgr.GetTranslation("funny.FunnyRightView.process19",param1.finishNum);
               }
               break;
            case 55:
               if(param1.getWay == 2)
               {
                  _loc10_ = LanguageMgr.GetTranslation("funny.FunnyRightView.process20",param1.finishNum) + LanguageMgr.GetTranslation("funny.FunnyRightView.process.canGet",param1.canGet);
               }
               else
               {
                  _loc10_ = LanguageMgr.GetTranslation("funny.FunnyRightView.process20",param1.finishNum);
               }
               break;
            case 56:
               _loc10_ = LanguageMgr.GetTranslation("funny.FunnyRightView.process21",param1.finishNum) + LanguageMgr.GetTranslation("funny.FunnyRightView.process.canGet",param1.canGet);
               break;
            case 58:
               if(param1.getWay == 2)
               {
                  _loc10_ = LanguageMgr.GetTranslation("funny.FunnyRightView.process22_1");
                  _loc3_ = param1.bagList[0];
                  _loc10_ += LanguageMgr.GetTranslation("funny.FunnyRightView.process22_2",_loc3_.finshCount,_loc3_.getCount);
               }
               else
               {
                  _loc10_ = LanguageMgr.GetTranslation("funny.FunnyRightView.process22",param1.finishNum);
               }
               break;
            case 59:
               if(param1.getWay == 2)
               {
                  _loc10_ = LanguageMgr.GetTranslation("funny.FunnyRightView.process23_1");
                  _loc3_ = param1.bagList[0];
                  _loc10_ += LanguageMgr.GetTranslation("funny.FunnyRightView.process23_2",_loc3_.finshCount,_loc3_.getCount);
               }
               else
               {
                  _loc10_ = LanguageMgr.GetTranslation("funny.FunnyRightView.process23",param1.finishNum);
               }
               break;
            case 61:
               if(param1.getWay == 2)
               {
                  _loc10_ = LanguageMgr.GetTranslation("funny.FunnyRightView.process25_1");
                  _loc3_ = param1.bagList[0];
                  _loc10_ += LanguageMgr.GetTranslation("funny.FunnyRightView.process25_2",_loc3_.finshCount,_loc3_.getCount);
               }
               else
               {
                  _loc10_ = LanguageMgr.GetTranslation("funny.FunnyRightView.process25",param1.finishNum);
               }
               break;
            case 100:
               _loc5_ = param1.bagList.length - 1;
               if(param1.bagList[_loc5_].status != 3)
               {
                  param1.finishNum = param1.bagList[_loc5_].conditionList[0].value;
               }
               if(param1.getWay == 2)
               {
                  _loc10_ = LanguageMgr.GetTranslation("funny.FunnyRightView.process100",param1.finishNum) + LanguageMgr.GetTranslation("funny.FunnyRightView.process.canGet",param1.canGet);
               }
               else
               {
                  _loc10_ = LanguageMgr.GetTranslation("funny.FunnyRightView.process100",param1.finishNum);
               }
               break;
            case 101:
               _loc5_ = param1.bagList.length - 1;
               if(param1.bagList[_loc5_].status != 3)
               {
                  param1.finishNum = param1.bagList[_loc5_].conditionList[0].value;
               }
               if(param1.getWay == 2)
               {
                  _loc10_ = LanguageMgr.GetTranslation("funny.FunnyRightView.process101",param1.finishNum) + LanguageMgr.GetTranslation("funny.FunnyRightView.process.canGet",param1.canGet);
               }
               else
               {
                  _loc10_ = LanguageMgr.GetTranslation("funny.FunnyRightView.process101",param1.finishNum);
               }
               break;
            case 102:
               _loc5_ = param1.bagList.length - 1;
               if(param1.bagList[_loc5_].status != 3)
               {
                  param1.finishNum = param1.bagList[_loc5_].conditionList[0].value;
               }
               if(param1.getWay == 2)
               {
                  _loc10_ = LanguageMgr.GetTranslation("funny.FunnyRightView.process102",param1.finishNum) + LanguageMgr.GetTranslation("funny.FunnyRightView.process.canGet",param1.canGet);
               }
               else
               {
                  _loc10_ = LanguageMgr.GetTranslation("funny.FunnyRightView.process102",param1.finishNum);
               }
               break;
            case 105:
               _loc5_ = param1.bagList.length - 1;
               if(param1.bagList[_loc5_].status != 3)
               {
                  param1.finishNum = param1.bagList[_loc5_].conditionList[0].value;
               }
               if(param1.getWay == 2)
               {
                  _loc10_ = LanguageMgr.GetTranslation("funny.FunnyRightView.process105",param1.finishNum) + LanguageMgr.GetTranslation("funny.FunnyRightView.process.canGet",param1.canGet);
               }
               else
               {
                  _loc10_ = LanguageMgr.GetTranslation("funny.FunnyRightView.process105",param1.finishNum);
               }
               break;
            case 106:
               _loc5_ = param1.bagList.length - 1;
               if(param1.bagList[_loc5_].status != 3)
               {
                  param1.finishNum = param1.bagList[_loc5_].conditionList[0].value;
               }
               if(param1.getWay == 2)
               {
                  _loc10_ = LanguageMgr.GetTranslation("funny.FunnyRightView.process106",param1.finishNum) + LanguageMgr.GetTranslation("funny.FunnyRightView.process.canGet",param1.canGet);
               }
               else
               {
                  _loc10_ = LanguageMgr.GetTranslation("funny.FunnyRightView.process106",param1.finishNum);
               }
               break;
            case 107:
               _loc5_ = param1.bagList.length - 1;
               if(param1.bagList[_loc5_].status != 3)
               {
                  param1.finishNum = param1.bagList[_loc5_].conditionList[0].value;
               }
               if(param1.getWay == 2)
               {
                  _loc10_ = LanguageMgr.GetTranslation("funny.FunnyRightView.process107",param1.finishNum) + LanguageMgr.GetTranslation("funny.FunnyRightView.process.canGet",param1.canGet);
               }
               else
               {
                  _loc10_ = LanguageMgr.GetTranslation("funny.FunnyRightView.process107",param1.finishNum);
               }
               break;
            case 108:
               _loc5_ = param1.bagList.length - 1;
               if(param1.bagList[_loc5_].status != 3)
               {
                  param1.finishNum = param1.bagList[_loc5_].conditionList[0].value;
               }
               if(param1.getWay == 2)
               {
                  _loc10_ = LanguageMgr.GetTranslation("funny.FunnyRightView.process108",param1.finishNum) + LanguageMgr.GetTranslation("funny.FunnyRightView.process.canGet",param1.canGet);
               }
               else
               {
                  _loc10_ = LanguageMgr.GetTranslation("funny.FunnyRightView.process108",param1.finishNum);
               }
               break;
            case 109:
               _loc5_ = param1.bagList.length - 1;
               if(param1.bagList[_loc5_].status != 3)
               {
                  param1.finishNum = param1.bagList[_loc5_].conditionList[0].value;
               }
               if(param1.getWay == 2)
               {
                  _loc10_ = LanguageMgr.GetTranslation("funny.FunnyRightView.process109",param1.finishNum) + LanguageMgr.GetTranslation("funny.FunnyRightView.process.canGet",param1.canGet);
               }
               else
               {
                  _loc10_ = LanguageMgr.GetTranslation("funny.FunnyRightView.process109",param1.finishNum);
               }
               break;
            case 110:
               _loc5_ = param1.bagList.length - 1;
               if(param1.bagList[_loc5_].status != 3)
               {
                  param1.finishNum = param1.bagList[_loc5_].conditionList[0].value;
               }
               if(param1.getWay == 2)
               {
                  _loc10_ = LanguageMgr.GetTranslation("funny.FunnyRightView.process110",param1.finishNum) + LanguageMgr.GetTranslation("funny.FunnyRightView.process.canGet",param1.canGet);
               }
               else
               {
                  _loc10_ = LanguageMgr.GetTranslation("funny.FunnyRightView.process110",param1.finishNum);
               }
               break;
            case 111:
               _loc5_ = param1.bagList.length - 1;
               if(param1.bagList[_loc5_].status != 3)
               {
                  param1.finishNum = param1.bagList[_loc5_].conditionList[0].value;
               }
               if(param1.getWay == 2)
               {
                  _loc10_ = LanguageMgr.GetTranslation("funny.FunnyRightView.process111",param1.finishNum) + LanguageMgr.GetTranslation("funny.FunnyRightView.process.canGet",param1.canGet);
               }
               else
               {
                  _loc10_ = LanguageMgr.GetTranslation("funny.FunnyRightView.process111",param1.finishNum);
               }
               break;
            case 112:
               _loc5_ = param1.bagList.length - 1;
               if(param1.bagList[_loc5_].status != 3)
               {
                  param1.finishNum = param1.bagList[_loc5_].conditionList[0].value;
               }
               if(param1.getWay == 2)
               {
                  _loc10_ = LanguageMgr.GetTranslation("funny.FunnyRightView.process112",param1.finishNum) + LanguageMgr.GetTranslation("funny.FunnyRightView.process.canGet",param1.canGet);
               }
               else
               {
                  _loc10_ = LanguageMgr.GetTranslation("funny.FunnyRightView.process112",param1.finishNum);
               }
               break;
            case 113:
               _loc5_ = param1.bagList.length - 1;
               if(param1.bagList[_loc5_].status != 3)
               {
                  param1.finishNum = param1.bagList[_loc5_].conditionList[0].value;
               }
               if(param1.getWay == 2)
               {
                  _loc10_ = LanguageMgr.GetTranslation("funny.FunnyRightView.process113",param1.finishNum) + LanguageMgr.GetTranslation("funny.FunnyRightView.process.canGet",param1.canGet);
               }
               else
               {
                  _loc10_ = LanguageMgr.GetTranslation("funny.FunnyRightView.process113",param1.finishNum);
               }
               break;
            case 117:
               _loc5_ = param1.bagList.length - 1;
               if(param1.bagList[_loc5_].status != 3)
               {
                  param1.finishNum = param1.bagList[_loc5_].conditionList[0].value;
               }
               if(param1.getWay == 2)
               {
                  _loc10_ = LanguageMgr.GetTranslation("funny.FunnyRightView.process117",param1.finishNum) + LanguageMgr.GetTranslation("funny.FunnyRightView.process.canGet",param1.canGet);
               }
               else
               {
                  _loc10_ = LanguageMgr.GetTranslation("funny.FunnyRightView.process117",param1.finishNum);
               }
               break;
            case 118:
               _loc5_ = param1.bagList.length - 1;
               if(param1.bagList[_loc5_].status != 3)
               {
                  param1.finishNum = param1.bagList[_loc5_].conditionList[0].value;
               }
               if(param1.getWay == 2)
               {
                  _loc10_ = LanguageMgr.GetTranslation("funny.FunnyRightView.process118") + LanguageMgr.GetTranslation("funny.FunnyRightView.process.canGet",param1.canGet);
               }
               else
               {
                  _loc10_ = LanguageMgr.GetTranslation("funny.FunnyRightView.process118");
               }
               break;
            case 119:
               _loc5_ = param1.bagList.length - 1;
               if(param1.bagList[_loc5_].status != 3)
               {
                  param1.finishNum = param1.bagList[_loc5_].conditionList[0].value;
               }
               if(param1.getWay == 2)
               {
                  _loc10_ = LanguageMgr.GetTranslation("funny.FunnyRightView.process119") + LanguageMgr.GetTranslation("funny.FunnyRightView.process.canGet",param1.canGet);
               }
               else
               {
                  _loc10_ = LanguageMgr.GetTranslation("funny.FunnyRightView.process119");
               }
               break;
            case 120:
               if(param1.getWay == 2)
               {
                  _loc10_ = LanguageMgr.GetTranslation("funny.FunnyRightView.process120",param1.finishNum) + LanguageMgr.GetTranslation("funny.FunnyRightView.process.canGet",param1.canGet);
               }
               else
               {
                  _loc10_ = LanguageMgr.GetTranslation("funny.FunnyRightView.process120",param1.finishNum);
               }
               break;
            case 127:
               _loc5_ = param1.bagList.length - 1;
               if(param1.bagList[_loc5_].status != 3)
               {
                  param1.finishNum = param1.bagList[_loc5_].conditionList[0].value;
               }
               if(param1.getWay == 2)
               {
                  _loc10_ = LanguageMgr.GetTranslation("funny.FunnyRightView.process127",param1.finishNum) + LanguageMgr.GetTranslation("funny.FunnyRightView.process.canGet",param1.canGet);
               }
               else
               {
                  _loc10_ = LanguageMgr.GetTranslation("funny.FunnyRightView.process127",param1.finishNum);
               }
               break;
            case 143:
               _loc3_ = param1.bagList[0];
               if(param1.getWay == 2)
               {
                  _loc3_ = param1.bagList[0];
                  _loc10_ = LanguageMgr.GetTranslation("funny.FunnyRightView.process143",getGoodsName(_loc3_.conditionList[0].bak),_loc3_.finshCount,_loc3_.getCount) + LanguageMgr.GetTranslation("funny.FunnyRightView.process.canGet",param1.canGet);
               }
               else
               {
                  _loc10_ = LanguageMgr.GetTranslation("funny.FunnyRightView.process143",getGoodsName(_loc3_.conditionList[0].bak),_loc3_.finshCount,_loc3_.getCount);
               }
               break;
            case 159:
               if(param1.getWay == 2)
               {
                  _loc10_ = LanguageMgr.GetTranslation("funny.FunnyRightView.process159",param1.finishNum) + LanguageMgr.GetTranslation("funny.FunnyRightView.process.canGet",param1.canGet);
               }
               else
               {
                  _loc10_ = LanguageMgr.GetTranslation("funny.FunnyRightView.process159",param1.finishNum);
               }
               break;
            case 161:
               if(param1.getWay == 2)
               {
                  _loc10_ = LanguageMgr.GetTranslation("funny.FunnyRightView.process161",param1.finishNum) + LanguageMgr.GetTranslation("funny.FunnyRightView.process.canGet",param1.canGet);
               }
               else
               {
                  _loc10_ = LanguageMgr.GetTranslation("funny.FunnyRightView.process161",param1.finishNum);
               }
               break;
            case 163:
               if(param1.getWay == 2)
               {
                  _loc10_ = LanguageMgr.GetTranslation("funny.FunnyRightView.process163",param1.finishNum) + LanguageMgr.GetTranslation("funny.FunnyRightView.process.canGet",param1.canGet);
               }
               else
               {
                  _loc10_ = LanguageMgr.GetTranslation("funny.FunnyRightView.process163",param1.finishNum);
               }
               break;
            case 167:
               _loc3_ = param1.bagList[0];
               if(param1.getWay == 2)
               {
                  _loc3_ = param1.bagList[0];
                  _loc10_ = LanguageMgr.GetTranslation("funny.FunnyRightView.process167",param1.finishNum,_loc3_.conditionList[0].value) + LanguageMgr.GetTranslation("funny.FunnyRightView.process.canGet",param1.canGet);
               }
               else
               {
                  _loc10_ = LanguageMgr.GetTranslation("funny.FunnyRightView.process167",param1.finishNum,_loc3_.conditionList[0].value);
               }
               break;
            case 168:
               if(param1.getWay == 2)
               {
                  _loc10_ = LanguageMgr.GetTranslation("funny.FunnyRightView.process168",param1.finishNum) + LanguageMgr.GetTranslation("funny.FunnyRightView.process.canGet",param1.canGet);
               }
               else
               {
                  _loc10_ = LanguageMgr.GetTranslation("funny.FunnyRightView.process168",param1.finishNum);
               }
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
            case 247:
            case 248:
               if(param1.getWay == 2)
               {
                  _loc10_ = LanguageMgr.GetTranslation("funny.FunnyRightView.process" + param1.type,param1.finishNum) + LanguageMgr.GetTranslation("funny.FunnyRightView.process.canGet",param1.canGet);
               }
               else
               {
                  _loc10_ = LanguageMgr.GetTranslation("funny.FunnyRightView.process" + param1.type,param1.finishNum);
               }
               break;
            case 152:
               _loc3_ = param1.bagList[0];
               if(param1.getWay == 2)
               {
                  _loc10_ = LanguageMgr.GetTranslation("funny.FunnyRightView.process152",_loc3_.finshCount,_loc3_.conditionList[0].value) + LanguageMgr.GetTranslation("funny.FunnyRightView.process.canGet",param1.canGet);
               }
               else
               {
                  _loc10_ = LanguageMgr.GetTranslation("funny.FunnyRightView.process152",param1.finishNum);
               }
               break;
            case 165:
               _loc10_ = LanguageMgr.GetTranslation("funny.FunnyRightView.process165",param1.finishNum);
               break;
            case 176:
               _loc10_ = LanguageMgr.GetTranslation("funny.FunnyRightView.process176",param1.finishNum);
               break;
            case 177:
               _loc10_ = LanguageMgr.GetTranslation("funny.FunnyRightView.process177",param1.finishNum);
               break;
            case 141:
               if(param1.getWay == 2)
               {
                  _loc10_ = LanguageMgr.GetTranslation("funny.FunnyRightView.process141",param1.finishNum) + LanguageMgr.GetTranslation("funny.FunnyRightView.process.canGet",param1.canGet);
               }
               else
               {
                  _loc10_ = LanguageMgr.GetTranslation("funny.FunnyRightView.process141",param1.finishNum);
               }
               break;
            case 142:
               if(param1.getWay == 2)
               {
                  _loc10_ = LanguageMgr.GetTranslation("funny.FunnyRightView.process142",param1.finishNum) + LanguageMgr.GetTranslation("funny.FunnyRightView.process.canGet",param1.canGet);
               }
               else
               {
                  _loc10_ = LanguageMgr.GetTranslation("funny.FunnyRightView.process142",param1.finishNum);
               }
               break;
            case 175:
               _loc3_ = param1.bagList[0];
               if(param1.getWay == 2)
               {
                  _loc10_ = LanguageMgr.GetTranslation("funny.FunnyRightView.process175",_loc3_.conditionList[0].bak,getGoodsName(_loc3_.conditionList[0].value)) + LanguageMgr.GetTranslation("funny.FunnyRightView.process.canGet",param1.canGet);
               }
               else
               {
                  _loc10_ = LanguageMgr.GetTranslation("funny.FunnyRightView.process175",_loc3_.conditionList[0].bak,getGoodsName(_loc3_.conditionList[0].value));
               }
               break;
            case 179:
               if(param1.getWay == 2)
               {
                  _loc10_ = LanguageMgr.GetTranslation("funny.FunnyRightView.process179",param1.finishNum) + LanguageMgr.GetTranslation("funny.FunnyRightView.process.canGet",param1.canGet);
               }
               else
               {
                  _loc10_ = LanguageMgr.GetTranslation("funny.FunnyRightView.process179",param1.finishNum);
               }
               break;
            case 71:
               param1.finishNum = param1.finishNum < 0 ? 0 : param1.finishNum;
               if(param1.getWay == 2)
               {
                  _loc10_ = LanguageMgr.GetTranslation("funny.FunnyRightView.process71",param1.finishNum) + LanguageMgr.GetTranslation("funny.FunnyRightView.process.canGet",param1.bagList[0].getCount);
               }
               else
               {
                  _loc10_ = LanguageMgr.GetTranslation("funny.FunnyRightView.process71",param1.finishNum);
               }
               break;
            case 181:
               _loc3_ = param1.bagList[0];
               _loc10_ = LanguageMgr.GetTranslation("funny.FunnyRightView.process181_" + _loc3_.conditionList[0].value,param1.finishNum);
               break;
            case 182:
               _loc3_ = param1.bagList[0];
               if(param1.getWay == 2)
               {
                  _loc10_ = LanguageMgr.GetTranslation("funny.FunnyRightView.process182",param1.finishNum) + LanguageMgr.GetTranslation("funny.FunnyRightView.process.canGet",param1.canGet);
               }
               else
               {
                  _loc10_ = LanguageMgr.GetTranslation("funny.FunnyRightView.process182",param1.finishNum);
               }
               break;
            case 183:
               _loc3_ = param1.bagList[0];
               if(param1.getWay == 2)
               {
                  _loc10_ = LanguageMgr.GetTranslation("funny.FunnyRightView.process183",param1.finishNum) + LanguageMgr.GetTranslation("funny.FunnyRightView.process.canGet",param1.canGet);
               }
               else
               {
                  _loc10_ = LanguageMgr.GetTranslation("funny.FunnyRightView.process183",param1.finishNum);
               }
               break;
            case 184:
               _loc10_ = LanguageMgr.GetTranslation("funny.FunnyRightView.process184",param1.finishNum);
               break;
            case 185:
               if(param1.getWay == 2)
               {
                  _loc10_ = LanguageMgr.GetTranslation("funny.FunnyRightView.process185",param1.finishNum) + LanguageMgr.GetTranslation("funny.FunnyRightView.process.canGet",param1.canGet);
               }
               else
               {
                  _loc10_ = LanguageMgr.GetTranslation("funny.FunnyRightView.process185",param1.finishNum);
               }
               break;
            case 187:
               _loc3_ = param1.bagList[0];
               _loc10_ = LanguageMgr.GetTranslation("funny.FunnyRightView.process187",param1.finishNum);
               break;
            case 188:
               _loc3_ = param1.bagList[0];
               _loc10_ = LanguageMgr.GetTranslation("funny.FunnyRightView.process188",param1.finishNum);
               break;
            case 189:
               _loc3_ = param1.bagList[0];
               _loc10_ = LanguageMgr.GetTranslation("funny.FunnyRightView.process189",param1.finishNum);
               break;
            case 190:
               _loc3_ = param1.bagList[0];
               _loc10_ = LanguageMgr.GetTranslation("funny.FunnyRightView.process190",param1.finishNum);
               break;
            case 191:
               _loc3_ = param1.bagList[0];
               _loc10_ = LanguageMgr.GetTranslation("funny.FunnyRightView.process191",param1.finishNum);
               break;
            case 192:
               _loc3_ = param1.bagList[0];
               _loc10_ = LanguageMgr.GetTranslation("funny.FunnyRightView.process192",param1.finishNum);
               break;
            case 193:
               _loc3_ = param1.bagList[0];
               _loc10_ = LanguageMgr.GetTranslation("funny.FunnyRightView.process193",param1.finishNum);
               break;
            case 194:
               _loc3_ = param1.bagList[0];
               _loc10_ = LanguageMgr.GetTranslation("funny.FunnyRightView.process194",param1.finishNum);
               break;
            case 195:
               _loc3_ = param1.bagList[0];
               _loc10_ = LanguageMgr.GetTranslation("funny.FunnyRightView.process195",param1.finishNum);
               break;
            case 198:
               _loc3_ = param1.bagList[0];
               _loc10_ = LanguageMgr.GetTranslation("funny.FunnyRightView.process198",param1.finishNum);
               break;
            case 199:
               _loc3_ = param1.bagList[0];
               _loc10_ = LanguageMgr.GetTranslation("funny.FunnyRightView.process199",param1.finishNum);
               break;
            case 200:
               _loc3_ = param1.bagList[0];
               _loc10_ = LanguageMgr.GetTranslation("funny.FunnyRightView.process200",param1.finishNum);
               break;
            case 202:
               _loc3_ = param1.bagList[0];
               _loc10_ = LanguageMgr.GetTranslation("funny.FunnyRightView.process202",param1.finishNum);
               break;
            case 203:
               _loc3_ = param1.bagList[0];
               _loc10_ = LanguageMgr.GetTranslation("funny.FunnyRightView.process203",param1.finishNum);
               break;
            case 204:
               _loc3_ = param1.bagList[0];
               _loc10_ = LanguageMgr.GetTranslation("funny.FunnyRightView.process204",param1.finishNum);
               break;
            case 205:
               _loc3_ = param1.bagList[0];
               _loc10_ = LanguageMgr.GetTranslation("funny.FunnyRightView.process205",param1.finishNum);
               break;
            case 206:
               _loc3_ = param1.bagList[0];
               if(_loc3_.conditionList[0].bak == 1)
               {
                  _loc10_ = LanguageMgr.GetTranslation("funny.FunnyRightView.process206_1",param1.finishNum);
               }
               else
               {
                  _loc10_ = LanguageMgr.GetTranslation("funny.FunnyRightView.process206_2",param1.finishNum);
               }
               break;
            case 208:
               _loc3_ = param1.bagList[0];
               _loc10_ = LanguageMgr.GetTranslation("funny.FunnyRightView.process208",param1.finishNum);
               break;
            case 211:
               _loc3_ = param1.bagList[0];
               _loc10_ = LanguageMgr.GetTranslation("funny.FunnyRightView.process211",param1.finishNum);
               break;
            case 212:
               _loc3_ = param1.bagList[0];
               _loc10_ = LanguageMgr.GetTranslation("funny.FunnyRightView.process212",param1.finishNum);
               break;
            case 213:
               _loc3_ = param1.bagList[0];
               _loc10_ = LanguageMgr.GetTranslation("funny.FunnyRightView.process213",param1.finishNum);
               break;
            case 214:
               _loc3_ = param1.bagList[0];
               _loc10_ = LanguageMgr.GetTranslation("funny.FunnyRightView.process214",param1.finishNum);
               break;
            case 215:
               _loc3_ = param1.bagList[0];
               _loc10_ = LanguageMgr.GetTranslation("funny.FunnyRightView.process215",param1.finishNum);
               break;
            case 216:
               _loc3_ = param1.bagList[0];
               _loc10_ = LanguageMgr.GetTranslation("funny.FunnyRightView.process216",param1.finishNum);
               break;
            case 217:
               _loc3_ = param1.bagList[0];
               _loc10_ = LanguageMgr.GetTranslation("funny.FunnyRightView.process217",param1.finishNum);
               break;
            case 218:
               _loc3_ = param1.bagList[0];
               _loc10_ = LanguageMgr.GetTranslation("funny.FunnyRightView.process218",param1.finishNum);
               break;
            case 219:
               _loc3_ = param1.bagList[0];
               _loc10_ = LanguageMgr.GetTranslation("funny.FunnyRightView.process219",param1.finishNum);
               break;
            case 220:
               _loc3_ = param1.bagList[0];
               _loc10_ = LanguageMgr.GetTranslation("funny.FunnyRightView.process220",param1.finishNum);
               break;
            case 223:
               _loc3_ = param1.bagList[0];
               _loc10_ = LanguageMgr.GetTranslation("funny.FunnyRightView.process223",param1.finishNum);
               break;
            case 224:
               _loc3_ = param1.bagList[0];
               _loc10_ = LanguageMgr.GetTranslation("funny.FunnyRightView.process224",param1.finishNum);
               break;
            case 225:
               _loc3_ = param1.bagList[0];
               _loc10_ = LanguageMgr.GetTranslation("funny.FunnyRightView.process225",param1.finishNum);
               break;
            case 226:
               _loc3_ = param1.bagList[0];
               _loc10_ = LanguageMgr.GetTranslation("funny.FunnyRightView.process226",param1.finishNum);
               break;
            case 228:
               _loc3_ = param1.bagList[0];
               _loc10_ = LanguageMgr.GetTranslation("funny.FunnyRightView.process228",param1.finishNum);
               break;
            case 229:
               _loc3_ = param1.bagList[0];
               _loc10_ = LanguageMgr.GetTranslation("funny.FunnyRightView.process229",param1.finishNum);
               break;
            case 230:
               _loc3_ = param1.bagList[0];
               _loc10_ = LanguageMgr.GetTranslation("funny.FunnyRightView.process230",param1.finishNum);
               break;
            default:
               _loc10_ = "";
         }
         return _loc10_;
      }
      
      public static function isMutConditionType(param1:FunnyBagData) : Boolean
      {
         if(param1 == null || param1.getWay != 2)
         {
            return false;
         }
         return true;
      }
      
      public static function mutiMaxNum(param1:FunnyBagData) : int
      {
         if(isMutConditionType(param1) == false || FunnyManager.instance.selectedFunnyData == null || !FunnyManager.instance.selectedFunnyData.bagList || FunnyManager.instance.selectedFunnyData.bagList.indexOf(param1) < 0)
         {
            return 1;
         }
         var _loc4_:int = param1.getCount;
         if(_loc4_ > 0)
         {
            return _loc4_;
         }
         var _loc2_:int = 1;
         var _loc3_:int = param1.conditionList[0].value;
         _loc3_ = int(_loc3_ > 1 ? _loc3_ : 1);
         switch(param1.conditionList[0].id - 11)
         {
            case 0:
               _loc2_ = getBagCount(param1.conditionList[0].bak);
         }
         _loc3_ = _loc3_ < _loc2_ ? _loc3_ : _loc2_;
         return Math.floor(_loc2_ / _loc3_);
      }
      
      private static function get activityList() : Array
      {
         return ActivityManager.Instance.activityList;
      }
      
      private static function get oldDic() : Dictionary
      {
         return SharedManager.instance.funnyOldDic;
      }
      
      private static function get playerInfo() : PlayerInfo
      {
         return PlayerManager.instance.currentPlayerModel.playerInfo;
      }
      
      private static function get playerModel() : PlayerModel
      {
         return PlayerManager.instance.currentPlayerModel;
      }
      
      public static function getGoodsName(param1:int) : String
      {
         return TempleteManager.instance.goodsTemplateCate.getTemplateByID(param1).TemplateName;
      }
      
      public static function getBagCount(param1:int) : int
      {
         return GoodsManager.instance.getBagCountByTempId(1,param1);
      }
      
      public static function get dayGuideCate() : DayGuideCatecory
      {
         return DayGuideManager.instance.cate;
      }
   }
}

