package managers
{
   import com.road.yishi.proto.player.PlayerTokenInfoMsg;
   import com.road.yishi.proto.player.TokenInfoMsg;
   import flash.events.EventDispatcher;
   import flash.events.IEventDispatcher;
   import mvc.module.consortia.ConsortiaModel;
   import mvc.module.currency.CurrencyInfo;
   import mvc.module.currency.CurrencyType;
   import mvc.module.currency.PlayerCurrencyInfo;
   import yishi.comm.PackageIn;
   import yishi.datas.VersionSwitch;
   import yishi.datas.playerinfo.PlayerInfo;
   import yishi.datas.playerinfo.PlayerModel;
   import yishi.datas.playerinfo.ThaneInfo;
   import yishi.events.SLGSocketEvent;
   import yishi.manager.ArmyManager;
   import yishi.manager.FrameControllerManager;
   import yishi.manager.NotificationManager;
   import yishi.manager.PlayerManager;
   import yishi.manager.PokerManager;
   import yishi.manager.ResourceManager;
   import yishi.manager.RoyaltyBossManager;
   import yishi.service.managers.SocketManager;
   
   public class PlayerCurrencyManager extends EventDispatcher
   {
      
      private static var _instance:PlayerCurrencyManager;
      
      private var _currencyInfo:PlayerCurrencyInfo;
      
      private var _mazeGoldNumber:int;
      
      public function PlayerCurrencyManager(param1:IEventDispatcher = null)
      {
         super(param1);
      }
      
      public static function get instance() : PlayerCurrencyManager
      {
         if(!_instance)
         {
            _instance = new PlayerCurrencyManager();
         }
         return _instance;
      }
      
      public function get mazeGoldNumber() : int
      {
         return _mazeGoldNumber;
      }
      
      public function set mazeGoldNumber(param1:int) : void
      {
         if(_mazeGoldNumber == param1)
         {
            return;
         }
         _mazeGoldNumber = param1;
      }
      
      public function setup() : void
      {
         _currencyInfo = new PlayerCurrencyInfo();
         initEvent();
      }
      
      private function initEvent() : void
      {
         SocketManager.instance.addEventListener("SLGSocketEvent" + 4725,__currencyRefreshHandler);
      }
      
      private function __currencyRefreshHandler(param1:SLGSocketEvent) : void
      {
         var _loc51_:int = 0;
         var _loc23_:TokenInfoMsg = null;
         var _loc52_:CurrencyInfo = null;
         var _loc41_:CurrencyInfo = null;
         var _loc13_:CurrencyInfo = null;
         var _loc57_:CurrencyInfo = null;
         var _loc14_:CurrencyInfo = null;
         var _loc16_:CurrencyInfo = null;
         var _loc22_:CurrencyInfo = null;
         var _loc21_:CurrencyInfo = null;
         var _loc20_:CurrencyInfo = null;
         var _loc47_:CurrencyInfo = null;
         var _loc32_:CurrencyInfo = null;
         var _loc28_:CurrencyInfo = null;
         var _loc37_:CurrencyInfo = null;
         var _loc38_:CurrencyInfo = null;
         var _loc33_:CurrencyInfo = null;
         var _loc4_:CurrencyInfo = null;
         var _loc44_:CurrencyInfo = null;
         var _loc55_:CurrencyInfo = null;
         var _loc56_:CurrencyInfo = null;
         var _loc27_:CurrencyInfo = null;
         var _loc39_:CurrencyInfo = null;
         var _loc34_:CurrencyInfo = null;
         var _loc17_:CurrencyInfo = null;
         var _loc59_:CurrencyInfo = null;
         var _loc11_:CurrencyInfo = null;
         var _loc5_:CurrencyInfo = null;
         var _loc42_:CurrencyInfo = null;
         var _loc45_:CurrencyInfo = null;
         var _loc49_:CurrencyInfo = null;
         var _loc6_:CurrencyInfo = null;
         var _loc8_:CurrencyInfo = null;
         var _loc15_:CurrencyInfo = null;
         var _loc61_:CurrencyInfo = null;
         var _loc10_:CurrencyInfo = null;
         var _loc40_:CurrencyInfo = null;
         var _loc24_:CurrencyInfo = null;
         var _loc29_:CurrencyInfo = null;
         var _loc54_:CurrencyInfo = null;
         var _loc48_:CurrencyInfo = null;
         var _loc26_:CurrencyInfo = null;
         var _loc35_:CurrencyInfo = null;
         var _loc46_:CurrencyInfo = null;
         var _loc31_:CurrencyInfo = null;
         var _loc58_:CurrencyInfo = null;
         var _loc36_:CurrencyInfo = null;
         var _loc25_:CurrencyInfo = null;
         var _loc60_:CurrencyInfo = null;
         var _loc30_:CurrencyInfo = null;
         var _loc53_:CurrencyInfo = null;
         var _loc19_:CurrencyInfo = null;
         var _loc9_:CurrencyInfo = null;
         var _loc3_:CurrencyInfo = null;
         var _loc7_:CurrencyInfo = null;
         var _loc18_:CurrencyInfo = null;
         var _loc12_:CurrencyInfo = null;
         var _loc43_:PackageIn = param1.data as PackageIn;
         var _loc2_:PlayerTokenInfoMsg = new PlayerTokenInfoMsg();
         _loc2_ = _loc43_.readBody(_loc2_) as PlayerTokenInfoMsg;
         var _loc50_:Array = _loc2_.tokenInfos;
         currencyInfo.petCrystal = new CurrencyInfo();
         currencyInfo.petSpirit = new CurrencyInfo();
         currencyInfo.petBreath = new CurrencyInfo();
         currencyInfo.petFireCream = new CurrencyInfo();
         currencyInfo.petWaterCream = new CurrencyInfo();
         currencyInfo.petElectricCream = new CurrencyInfo();
         currencyInfo.petWindCream = new CurrencyInfo();
         currencyInfo.guildSkill = new CurrencyInfo();
         currencyInfo.yellowCoin = new CurrencyInfo();
         currencyInfo.copyConsortia = new CurrencyInfo();
         currencyInfo.arenaMedal = new CurrencyInfo();
         currencyInfo.mazeGold = new CurrencyInfo();
         currencyInfo.eternalCrystal = new CurrencyInfo();
         currencyInfo.mountCoin = new CurrencyInfo();
         currencyInfo.outyardCoin = new CurrencyInfo();
         _loc51_ = 0;
         while(_loc51_ < _loc50_.length)
         {
            switch((_loc23_ = _loc50_[_loc51_] as TokenInfoMsg).masterType)
            {
               case 1:
                  _loc52_ = new CurrencyInfo();
                  _loc52_.amount = _loc23_.amount;
                  _loc52_.expiredDate = _loc23_.expiredDate;
                  _loc52_.masterType = _loc23_.masterType;
                  currencyInfo.petCrystal = _loc52_;
                  break;
               case 100:
                  _loc41_ = new CurrencyInfo();
                  _loc41_.amount = _loc23_.amount;
                  _loc41_.expiredDate = _loc23_.expiredDate;
                  _loc41_.masterType = _loc23_.masterType;
                  currencyInfo.petSpirit = _loc41_;
                  break;
               case 99:
                  _loc13_ = new CurrencyInfo();
                  _loc13_.amount = _loc23_.amount;
                  _loc13_.expiredDate = _loc23_.expiredDate;
                  _loc13_.masterType = _loc23_.masterType;
                  currencyInfo.petBreath = _loc13_;
                  break;
               case 2:
                  _loc57_ = new CurrencyInfo();
                  _loc57_.amount = _loc23_.amount;
                  _loc57_.expiredDate = _loc23_.expiredDate;
                  _loc57_.masterType = _loc23_.masterType;
                  currencyInfo.petFireCream = _loc57_;
                  break;
               case 3:
                  _loc14_ = new CurrencyInfo();
                  _loc14_.amount = _loc23_.amount;
                  _loc14_.expiredDate = _loc23_.expiredDate;
                  _loc14_.masterType = _loc23_.masterType;
                  currencyInfo.petWaterCream = _loc14_;
                  break;
               case 4:
                  _loc16_ = new CurrencyInfo();
                  _loc16_.amount = _loc23_.amount;
                  _loc16_.expiredDate = _loc23_.expiredDate;
                  _loc16_.masterType = _loc23_.masterType;
                  currencyInfo.petElectricCream = _loc16_;
                  break;
               case 5:
                  _loc22_ = new CurrencyInfo();
                  _loc22_.amount = _loc23_.amount;
                  _loc22_.expiredDate = _loc23_.expiredDate;
                  _loc22_.masterType = _loc23_.masterType;
                  currencyInfo.petWindCream = _loc22_;
                  break;
               case 6:
                  _loc21_ = new CurrencyInfo();
                  _loc21_.amount = _loc23_.amount;
                  _loc21_.expiredDate = _loc23_.expiredDate;
                  _loc21_.masterType = _loc23_.masterType;
                  currencyInfo.guildSkill = _loc21_;
                  break;
               case 23:
                  _loc20_ = new CurrencyInfo();
                  _loc20_.amount = _loc23_.amount;
                  _loc20_.expiredDate = _loc23_.expiredDate;
                  _loc20_.masterType = _loc23_.masterType;
                  currencyInfo.yellowCoin = _loc20_;
                  break;
               case 8:
                  _loc47_ = new CurrencyInfo();
                  _loc47_.amount = _loc23_.amount;
                  _loc47_.expiredDate = _loc23_.expiredDate;
                  _loc47_.masterType = _loc23_.masterType;
                  currencyInfo.arenaMedal = _loc47_;
                  break;
               case 11:
                  _loc32_ = new CurrencyInfo();
                  _loc32_.amount = _loc23_.amount;
                  mazeGoldNumber = _loc23_.amount;
                  _loc32_.expiredDate = _loc23_.expiredDate;
                  _loc32_.masterType = _loc23_.masterType;
                  currencyInfo.mazeGold = _loc32_;
                  break;
               case 12:
                  _loc28_ = new CurrencyInfo();
                  _loc28_.amount = _loc23_.amount;
                  _loc28_.expiredDate = _loc23_.expiredDate;
                  _loc28_.masterType = _loc23_.masterType;
                  currencyInfo.eternalCrystal = _loc28_;
                  break;
               case 13:
                  _loc37_ = new CurrencyInfo();
                  _loc37_.amount = _loc23_.amount;
                  _loc37_.masterType = _loc23_.masterType;
                  currencyInfo.magicDust = _loc37_;
                  break;
               case 14:
                  _loc38_ = new CurrencyInfo();
                  _loc38_.amount = _loc23_.amount;
                  _loc38_.expiredDate = _loc23_.expiredDate;
                  _loc38_.masterType = _loc23_.masterType;
                  currencyInfo.mountCoin = _loc38_;
                  break;
               case 17:
                  _loc33_ = new CurrencyInfo();
                  _loc33_.amount = _loc23_.amount;
                  _loc33_.expiredDate = _loc23_.expiredDate;
                  _loc33_.masterType = _loc23_.masterType;
                  currencyInfo.outyardCoin = _loc33_;
                  break;
               case 41:
                  _loc4_ = new CurrencyInfo();
                  _loc4_.amount = _loc23_.amount;
                  _loc4_.expiredDate = _loc23_.expiredDate;
                  _loc4_.masterType = _loc23_.masterType;
                  currencyInfo.gemDust = _loc4_;
                  break;
               case 21:
                  _loc44_ = new CurrencyInfo();
                  _loc44_.amount = _loc23_.amount;
                  _loc44_.expiredDate = _loc23_.expiredDate;
                  _loc44_.masterType = _loc23_.masterType;
                  currencyInfo.bingoCoin = _loc44_;
                  break;
               case 15:
                  _loc55_ = new CurrencyInfo();
                  _loc55_.amount = _loc23_.amount;
                  _loc55_.expiredDate = _loc23_.expiredDate;
                  _loc55_.masterType = _loc23_.masterType;
                  currencyInfo.gameBoxCoin = _loc55_;
                  break;
               case 18:
                  _loc56_ = new CurrencyInfo();
                  _loc56_.amount = _loc23_.amount;
                  _loc56_.expiredDate = _loc23_.expiredDate;
                  _loc56_.masterType = _loc23_.masterType;
                  currencyInfo.aresHeart = _loc56_;
                  break;
               case 20:
                  _loc27_ = new CurrencyInfo();
                  _loc27_.amount = _loc23_.amount;
                  _loc27_.expiredDate = _loc23_.expiredDate;
                  _loc27_.masterType = _loc23_.masterType;
                  currencyInfo.athenaTear = _loc27_;
                  break;
               case 19:
                  _loc39_ = new CurrencyInfo();
                  _loc39_.amount = _loc23_.amount;
                  _loc39_.expiredDate = _loc23_.expiredDate;
                  _loc39_.masterType = _loc23_.masterType;
                  currencyInfo.yarramanCoin = _loc39_;
                  break;
               case 27:
                  _loc34_ = new CurrencyInfo();
                  _loc34_.amount = _loc23_.amount;
                  _loc34_.expiredDate = _loc23_.expiredDate;
                  _loc34_.masterType = _loc23_.masterType;
                  currencyInfo.newMagicDust = _loc34_;
                  break;
               case 22:
                  _loc17_ = new CurrencyInfo();
                  _loc17_.amount = _loc23_.amount;
                  _loc17_.expiredDate = _loc23_.expiredDate;
                  _loc17_.masterType = _loc23_.masterType;
                  currencyInfo.gloryCoin = _loc17_;
                  break;
               case 24:
                  _loc59_ = new CurrencyInfo();
                  _loc59_.amount = _loc23_.amount;
                  _loc59_.expiredDate = _loc23_.expiredDate;
                  _loc59_.masterType = _loc23_.masterType;
                  currencyInfo.exploreMedal = _loc59_;
                  break;
               case 28:
                  _loc11_ = new CurrencyInfo();
                  _loc11_.amount = _loc23_.amount;
                  _loc11_.expiredDate = _loc23_.expiredDate;
                  _loc11_.masterType = _loc23_.masterType;
                  currencyInfo.assaultwarMedal = _loc11_;
                  break;
               case 46:
                  _loc5_ = new CurrencyInfo();
                  _loc5_.amount = _loc23_.amount;
                  _loc5_.expiredDate = _loc23_.expiredDate;
                  _loc5_.masterType = _loc23_.masterType;
                  currencyInfo.godsMarking = _loc5_;
                  break;
               case 26:
                  _loc42_ = new CurrencyInfo();
                  _loc42_.amount = _loc23_.amount;
                  _loc42_.expiredDate = _loc23_.expiredDate;
                  _loc42_.masterType = _loc23_.masterType;
                  currencyInfo.petExchangeCoin = _loc42_;
                  break;
               case 29:
                  _loc45_ = new CurrencyInfo();
                  _loc45_.amount = _loc23_.amount;
                  _loc45_.expiredDate = _loc23_.expiredDate;
                  _loc45_.masterType = _loc23_.masterType;
                  currencyInfo.copyConsortia = _loc45_;
                  break;
               case 31:
                  _loc49_ = new CurrencyInfo();
                  _loc49_.amount = _loc23_.amount;
                  _loc49_.expiredDate = _loc23_.expiredDate;
                  _loc49_.masterType = _loc23_.masterType;
                  currencyInfo.crossGuildCoin = _loc49_;
                  break;
               case 30:
                  _loc6_ = new CurrencyInfo();
                  _loc6_.amount = _loc23_.amount;
                  _loc6_.expiredDate = _loc23_.expiredDate;
                  _loc6_.masterType = _loc23_.masterType;
                  currencyInfo.apexCoin = _loc6_;
                  break;
               case 32:
                  _loc8_ = new CurrencyInfo();
                  _loc8_.amount = _loc23_.amount;
                  _loc8_.expiredDate = _loc23_.expiredDate;
                  _loc8_.masterType = _loc23_.masterType;
                  currencyInfo.antaeusCoin = _loc8_;
                  break;
               case 33:
                  _loc15_ = new CurrencyInfo();
                  _loc15_.amount = _loc23_.amount;
                  _loc15_.expiredDate = _loc23_.expiredDate;
                  _loc15_.masterType = _loc23_.masterType;
                  currencyInfo.airGardenPropCoin = _loc15_;
                  break;
               case 34:
                  _loc61_ = new CurrencyInfo();
                  _loc61_.amount = _loc23_.amount;
                  _loc61_.expiredDate = _loc23_.expiredDate;
                  _loc61_.masterType = _loc23_.masterType;
                  currencyInfo.airGardenBedCoin = _loc61_;
                  break;
               case 35:
                  _loc10_ = new CurrencyInfo();
                  _loc10_.amount = _loc23_.amount;
                  _loc10_.expiredDate = _loc23_.expiredDate;
                  _loc10_.masterType = _loc23_.masterType;
                  currencyInfo.eastEggCoin = _loc10_;
                  break;
               case 36:
                  _loc40_ = new CurrencyInfo();
                  _loc40_.amount = _loc23_.amount;
                  _loc40_.expiredDate = _loc23_.expiredDate;
                  _loc40_.masterType = _loc23_.masterType;
                  currencyInfo.eastTickesCoin = _loc40_;
                  break;
               case 37:
                  _loc24_ = new CurrencyInfo();
                  _loc24_.amount = _loc23_.amount;
                  _loc24_.expiredDate = _loc23_.expiredDate;
                  _loc24_.masterType = _loc23_.masterType;
                  currencyInfo.flameTempleCoin = _loc24_;
                  break;
               case 38:
                  _loc29_ = new CurrencyInfo();
                  _loc29_.amount = _loc23_.amount;
                  _loc29_.expiredDate = _loc23_.expiredDate;
                  _loc29_.masterType = _loc23_.masterType;
                  currencyInfo.duskAreaCoin = _loc29_;
                  break;
               case 56:
                  _loc54_ = new CurrencyInfo();
                  _loc54_.amount = _loc23_.amount;
                  _loc54_.expiredDate = _loc23_.expiredDate;
                  _loc54_.masterType = _loc23_.masterType;
                  currencyInfo.demonroadCoin = _loc54_;
                  break;
               case 39:
                  _loc48_ = new CurrencyInfo();
                  _loc48_.amount = _loc23_.amount;
                  _loc48_.expiredDate = _loc23_.expiredDate;
                  _loc48_.masterType = _loc23_.masterType;
                  currencyInfo.darkmazeSoulCoin = _loc48_;
                  break;
               case 57:
                  _loc26_ = new CurrencyInfo();
                  _loc26_.amount = _loc23_.amount;
                  _loc26_.expiredDate = _loc23_.expiredDate;
                  _loc26_.masterType = _loc23_.masterType;
                  currencyInfo.consortiaNewBossCoin = _loc26_;
                  break;
               case 58:
                  _loc35_ = new CurrencyInfo();
                  _loc35_.amount = _loc23_.amount;
                  _loc35_.expiredDate = _loc23_.expiredDate;
                  _loc35_.masterType = _loc23_.masterType;
                  currencyInfo.poseidonCoin = _loc35_;
                  break;
               case 59:
                  _loc46_ = new CurrencyInfo();
                  _loc46_.amount = _loc23_.amount;
                  _loc46_.expiredDate = _loc23_.expiredDate;
                  _loc46_.masterType = _loc23_.masterType;
                  currencyInfo.thesepvpMedal = _loc46_;
                  break;
               case 60:
                  _loc31_ = new CurrencyInfo();
                  _loc31_.amount = _loc23_.amount;
                  _loc31_.expiredDate = _loc23_.expiredDate;
                  _loc31_.masterType = _loc23_.masterType;
                  currencyInfo.thesepvpHoner = _loc31_;
                  break;
               case 69:
                  _loc58_ = new CurrencyInfo();
                  _loc58_.amount = _loc23_.amount;
                  _loc58_.expiredDate = _loc23_.expiredDate;
                  _loc58_.masterType = _loc23_.masterType;
                  currencyInfo.theseDoublepvpHoner = _loc58_;
                  break;
               case 70:
                  _loc36_ = new CurrencyInfo();
                  _loc36_.amount = _loc23_.amount;
                  _loc36_.expiredDate = _loc23_.expiredDate;
                  _loc36_.masterType = _loc23_.masterType;
                  currencyInfo.theseuscollectionBox = _loc36_;
                  break;
               case 71:
                  _loc25_ = new CurrencyInfo();
                  _loc25_.amount = _loc23_.amount;
                  _loc25_.expiredDate = _loc23_.expiredDate;
                  _loc25_.masterType = _loc23_.masterType;
                  currencyInfo.theseusshuijing = _loc25_;
                  break;
               case 61:
                  _loc60_ = new CurrencyInfo();
                  _loc60_.amount = _loc23_.amount;
                  _loc60_.expiredDate = _loc23_.expiredDate;
                  _loc60_.masterType = _loc23_.masterType;
                  currencyInfo.secretwarShopCoin = _loc60_;
                  break;
               case 62:
                  _loc30_ = new CurrencyInfo();
                  _loc30_.amount = _loc23_.amount;
                  _loc30_.expiredDate = _loc23_.expiredDate;
                  _loc30_.masterType = _loc23_.masterType;
                  currencyInfo.yearBoxKey = _loc30_;
                  break;
               case 63:
                  _loc53_ = new CurrencyInfo();
                  _loc53_.amount = _loc23_.amount;
                  _loc53_.expiredDate = _loc23_.expiredDate;
                  _loc53_.masterType = _loc23_.masterType;
                  currencyInfo.yearEggTicket = _loc53_;
                  break;
               case 64:
                  _loc19_ = new CurrencyInfo();
                  _loc19_.amount = _loc23_.amount;
                  _loc19_.expiredDate = _loc23_.expiredDate;
                  _loc19_.masterType = _loc23_.masterType;
                  currencyInfo.yearGold = _loc19_;
                  break;
               case 65:
                  _loc9_ = new CurrencyInfo();
                  _loc9_.amount = _loc23_.amount;
                  _loc9_.expiredDate = _loc23_.expiredDate;
                  _loc9_.masterType = _loc23_.masterType;
                  currencyInfo.minosCoin = _loc9_;
                  break;
               case 66:
                  _loc3_ = new CurrencyInfo();
                  _loc3_.amount = _loc23_.amount;
                  _loc3_.expiredDate = _loc23_.expiredDate;
                  _loc3_.masterType = _loc23_.masterType;
                  currencyInfo.chessPvpCoin = _loc3_;
                  break;
               case 67:
                  _loc7_ = new CurrencyInfo();
                  _loc7_.amount = _loc23_.amount;
                  _loc7_.expiredDate = _loc23_.expiredDate;
                  _loc7_.masterType = _loc23_.masterType;
                  currencyInfo.childNsWarCoin = _loc7_;
                  break;
               default:
                  if(CurrencyType.CAT_TOY_TYPE_LIST.indexOf(_loc23_.masterType) >= 0)
                  {
                     _loc18_ = currencyInfo.getCatToyCurrencyInfoByType(_loc23_.masterType);
                     if(_loc18_ == null)
                     {
                        _loc18_ = new CurrencyInfo();
                     }
                     _loc18_.amount = _loc23_.amount;
                     _loc18_.expiredDate = _loc23_.expiredDate;
                     _loc18_.masterType = _loc23_.masterType;
                     currencyInfo.setCatToyCurrencyInfo(_loc18_);
                  }
                  if(CurrencyType.MAGIC_PUB_TYPE_LIST.indexOf(_loc23_.masterType) >= 0)
                  {
                     _loc12_ = currencyInfo.getMagicPubCurrencyInfoByType(_loc23_.masterType);
                     if(_loc12_ == null)
                     {
                        _loc12_ = new CurrencyInfo();
                     }
                     _loc12_.amount = _loc23_.amount;
                     _loc12_.expiredDate = _loc23_.expiredDate;
                     _loc12_.masterType = _loc23_.masterType;
                     currencyInfo.setMagicPubCurrencyInfo(_loc12_);
                  }
            }
            _loc51_++;
         }
         NotificationManager.instance.sendNotification("CURRENCYREFRESH");
      }
      
      public function getShowArr() : Array
      {
         var _loc1_:Array = [];
         var _loc9_:CurrencyInfo = new CurrencyInfo();
         _loc9_.masterType = -1;
         _loc9_.amount = playerInfo.starPoint;
         _loc9_.expiredDate = "2000-01-01 00:00:00";
         _loc9_.sort = 10;
         var _loc8_:CurrencyInfo = new CurrencyInfo();
         _loc8_.masterType = -2;
         _loc8_.amount = ResourceManager.instance.waterCrystal.count;
         _loc8_.expiredDate = "2000-01-01 00:00:00";
         _loc8_.sort = 20;
         var _loc3_:CurrencyInfo = new CurrencyInfo();
         _loc3_.masterType = -3;
         _loc3_.amount = playerInfo.mineral;
         _loc3_.expiredDate = "2000-01-01 00:00:00";
         _loc3_.sort = 30;
         var _loc5_:CurrencyInfo = new CurrencyInfo();
         _loc5_.masterType = -4;
         _loc5_.amount = MysteryShopManager.instance.model.consumePoints;
         _loc5_.expiredDate = "2000-01-01 00:00:00";
         _loc5_.sort = 40;
         var _loc7_:CurrencyInfo = new CurrencyInfo();
         _loc7_.masterType = -5;
         _loc7_.amount = playerInfo.crossLeagueMedal;
         _loc7_.expiredDate = getOutTime();
         _loc7_.sort = 130;
         var _loc6_:CurrencyInfo = new CurrencyInfo();
         _loc6_.masterType = 102;
         _loc6_.amount = PokerManager.instance.palyerInfo.pokerScore;
         _loc6_.expiredDate = "2000-01-01 00:00:00";
         _loc6_.sort = 200;
         var _loc4_:CurrencyInfo = new CurrencyInfo();
         _loc4_.masterType = 103;
         _loc4_.amount = PokerManager.instance.palyerInfo.pokerCorn;
         _loc4_.expiredDate = "2000-01-01 00:00:00";
         _loc4_.sort = 210;
         var _loc2_:CurrencyInfo = new CurrencyInfo();
         _loc2_.masterType = 101;
         _loc2_.amount = NavigationManager.instance.model.currency;
         _loc2_.expiredDate = "2000-01-01 00:00:00";
         _loc2_.sort = 220;
         if(thane.grades >= 18)
         {
            _loc1_.push(_loc9_);
         }
         if(thane.grades >= 18)
         {
            _loc1_.push(_loc8_);
         }
         if(thane.grades >= 26)
         {
            _loc1_.push(_loc5_);
         }
         if(thane.grades >= 16)
         {
            _loc1_.push(_loc7_);
         }
         if(thane.grades >= 50)
         {
            _loc1_.push(currencyInfo.petCrystal);
            _loc1_.push(currencyInfo.petSpirit);
            _loc1_.push(currencyInfo.petBreath);
         }
         if(thane.grades >= 30)
         {
            _loc1_.push(currencyInfo.petExchangeCoin);
         }
         if(thane.grades >= 13)
         {
            _loc1_.push(currencyInfo.guildSkill);
         }
         if(thane.grades >= 13)
         {
            _loc1_.push(currencyInfo.yellowCoin);
         }
         if(thane.grades >= 16)
         {
            _loc1_.push(currencyInfo.arenaMedal);
         }
         if(thane.grades >= 12)
         {
            _loc1_.push(currencyInfo.mazeGold);
         }
         if(thane.grades >= 36)
         {
            _loc1_.push(currencyInfo.eternalCrystal);
         }
         if(thane.grades >= 16)
         {
            _loc1_.push(currencyInfo.mountCoin);
         }
         if(thane.grades >= 13)
         {
            _loc1_.push(currencyInfo.outyardCoin);
         }
         if(thane.grades >= 80)
         {
            _loc1_.push(_loc2_);
         }
         if(thane.grades >= 36)
         {
            _loc1_.push(currencyInfo.aresHeart);
         }
         if(thane.grades >= 13)
         {
            if(VersionSwitch.CROSS_GUILD)
            {
               _loc1_.push(currencyInfo.crossGuildCoin);
            }
         }
         if(thane.grades >= 40)
         {
            _loc1_.push(currencyInfo.athenaTear);
         }
         if(thane.grades >= 15)
         {
            _loc1_.push(currencyInfo.gloryCoin);
         }
         if(thane.grades >= 18)
         {
            _loc1_.push(currencyInfo.newMagicDust);
         }
         if(thane.grades >= 11)
         {
            _loc1_.push(currencyInfo.bingoCoin);
         }
         if(thane.grades >= 10)
         {
         }
         if(thane.grades >= 1 && VersionSwitch.GODS_EVENING)
         {
            _loc1_.push(currencyInfo.godsMarking);
         }
         if(thane.grades >= 80)
         {
         }
         if(thane.grades >= 13)
         {
            _loc1_.push(currencyInfo.copyConsortia);
         }
         if(thane.grades >= 1 && VersionSwitch.ANTAEUS)
         {
            if(VersionSwitch.ANTAEUS)
            {
               _loc1_.push(currencyInfo.antaeusCoin);
            }
         }
         if(thane.grades >= 80)
         {
            if(VersionSwitch.APEX)
            {
               if(currencyInfo.apexCoin.expiredDate != "2000-01-01 00:00:00")
               {
                  _loc1_.push(currencyInfo.apexCoin);
               }
            }
         }
         if(thane.vocationGrades > 0 && VersionSwitch.AIR_GARDEN)
         {
         }
         if(thane.isAvenger)
         {
            _loc1_.push(currencyInfo.duskAreaCoin);
         }
         if(thane.isChangeJob)
         {
            _loc1_.push(currencyInfo.flameTempleCoin);
         }
         if(thane.isChangeJob && VersionSwitch.DARK_MAZE)
         {
            _loc1_.push(currencyInfo.darkmazeSoulCoin);
         }
         if(RoyaltyBossManager.instance.model.royaltyLevel > 0)
         {
            _loc1_.push(currencyInfo.poseidonCoin);
         }
         if(thane.grades >= 30 && VersionSwitch.SECRET_WAR)
         {
            _loc1_.push(currencyInfo.secretwarShopCoin);
         }
         _loc1_.sortOn(["sort"],16);
         return _loc1_;
      }
      
      private function getOutTime() : String
      {
         var _loc1_:Date = playerModel.sysCurtime;
         _loc1_.month += 1;
         var _loc2_:String = _loc1_.month + 1 < 10 ? "0" + (_loc1_.month + 1) : _loc1_.month + 1 + "";
         _loc1_.date + 1;
         return _loc1_.fullYear + "-" + _loc2_ + "01 00:00:00";
      }
      
      private function get playerInfo() : PlayerInfo
      {
         return PlayerManager.instance.currentPlayerModel.playerInfo;
      }
      
      private function get playerModel() : PlayerModel
      {
         return PlayerManager.instance.currentPlayerModel;
      }
      
      private function get thane() : ThaneInfo
      {
         return ArmyManager.instance.thane;
      }
      
      private function get consortiaMoele() : ConsortiaModel
      {
         return FrameControllerManager.instance.consortiaController.model;
      }
      
      public function get currencyInfo() : PlayerCurrencyInfo
      {
         return _currencyInfo;
      }
   }
}

