package mvc.module.shop
{
   import events.ShopEvent;
   import flash.events.EventDispatcher;
   import flash.events.IEventDispatcher;
   import managers.VIPManager;
   import yishi.datas.templates.GoodsTemplateInfo;
   import yishi.manager.TempleteManager;
   
   public class ShopGoodsInfo extends EventDispatcher
   {
      
      public static const PAY_BY_POINT:int = 1;
      
      public static const PAY_BY_GIFT:int = 2;
      
      public static const PAY_BY_GOLD:int = 3;
      
      public static const PAY_BY_OFFER:int = 4;
      
      public static const PAY_BY_HONOR:int = 5;
      
      public static const PAY_BY_MAZE:int = 6;
      
      public static const PAY_BY_BACKPLAYER:int = 8;
      
      public static const PAY_BY_FASHIONPIECE:int = 9;
      
      public static const PAY_BY_YARRAMANCOIN:int = 10;
      
      public static const PAY_BY_LEAGUE:int = 11;
      
      public static const PAY_BY_GUILD:int = 12;
      
      public static const PAY_BY_ATHENA_TEAR:int = 13;
      
      public static const PAY_BY_MOUNT:int = 14;
      
      public static const PAY_BY_CHAOS:int = 15;
      
      public static const PAY_BY_ETERNALCRYSTAL:int = 16;
      
      public static const PAY_BY_POKER_SCORE:int = 17;
      
      public static const PAY_BY_OUTYARD_SCORE:int = 18;
      
      public static const PAY_BY_ARES_HEART:int = 7;
      
      public static const PAY_BY_BINGO_SCORE:int = 19;
      
      public static const PAY_BY_GLORY_SCORE:int = 20;
      
      public static const PAY_BY_YELLOW_SCORE:int = 21;
      
      public static const PAY_BY_EXPLORE_MEDAL:int = 22;
      
      public static const PAY_BY_GODS_MARKING:int = 25;
      
      public static const PAY_BY_ASSAULTWAR_SCORE:int = 28;
      
      public static const PAY_BY_PUMPINGJOY_SCORE:int = 2001;
      
      public static const PAY_BY_COPY_CONSORTIA_SHOP:int = 29;
      
      public static const PAY_BY_APEX_HEART:int = 30;
      
      public static const PAY_BY_NEW_CROSS_GUILD_SHOP:int = 31;
      
      public static const PAY_BY_ANTAEUS_SCORE:int = 32;
      
      public static const PAY_BY_AIRGARDEN_PROP:int = 33;
      
      public static const PAY_BY_AIRGARDEN_BED:int = 34;
      
      public static const PAY_BY_FLAME_TEMPLE:int = 37;
      
      public static const PAY_BY_DUSK_AREA:int = 38;
      
      public static const PAY_BY_DARK_MAZE_AREA:int = 39;
      
      public static const PAY_BY_CONSORTIA_NEW_BOSS_AREA:int = 40;
      
      public static const PAY_BY_THESE_PVP:int = 41;
      
      public static const PAY_BY_YEARACTIVE_GOLD:int = 42;
      
      public static const PAY_BY_YEARACTIVE_KEY:int = 43;
      
      public static const PAY_BY_MINOS_KEY:int = 44;
      
      public static const PAY_BY_CHESSPVP_KEY:int = 45;
      
      public static const PAY_BY_CHILD_NSWAR_KEY:int = 46;
      
      public static const PAY_BY_FRAGMENT_1001:int = 1001;
      
      public static const PAY_BY_FRAGMENT_1002:int = 1002;
      
      public static const PAY_BY_FRAGMENT_1003:int = 1003;
      
      public static const PAY_BY_FRAGMENT_1004:int = 1004;
      
      public static const PAY_BY_FRAGMENT_1005:int = 1005;
      
      public static const PAY_BY_FRAGMENT_1006:int = 1006;
      
      public static const PAY_BY_FRAGMENT_1007:int = 1007;
      
      public static const PAY_BY_FRAGMENT_1009:int = 1009;
      
      public static const PAY_BY_FRAGMENT_1010:int = 1010;
      
      public static const PAY_BY_FRAGMENT_1011:int = 1011;
      
      public static const PROP_GOODS:int = 2;
      
      public static const ELSE_GOODS:int = 4;
      
      public static const HERO_GOODS:int = 16;
      
      public static const PET_GOODS:int = 18;
      
      public static const CHILD_GOODS:int = 12;
      
      public static const FILTER_GOODS:int = 10;
      
      public static const FASHION_ALL_BUY:int = 8;
      
      public static const FASHION_LOOK:int = 9;
      
      public static const STAR_SHOP:int = 101;
      
      public static const HIDE_SHOP:int = 99;
      
      public static const BLOOD_SHOP:int = 100;
      
      public static const SHOP:int = 1;
      
      public static const CONSORTIA_SHOP:int = 2;
      
      public static const ATHLETICS_SHOP:int = 3;
      
      public static const MAZE_SHOP:int = 4;
      
      public static const MYSTERY_SHOP:int = 5;
      
      public static const FARM_SHOP:int = 6;
      
      public static const MYSTERY_EXCHANGE_SHOP:int = 7;
      
      public static const PET_EXCHANGE_SHOP:int = 8;
      
      public static const ARESLORDS_SHOP:int = 10;
      
      public static const MINERAL_SHOP:int = 11;
      
      public static const CROSSPVP_SHOP:int = 13;
      
      public static const LEAGUE_SHOP:int = 14;
      
      public static const PETBOSS_SHOP:int = 15;
      
      public static const BRAVELEG_SHOP:int = 16;
      
      public static const ADVCONSORTIA_SHOP:int = 17;
      
      public static const SVS_SHOP:int = 19;
      
      public static const MATELORDS_SHOP:int = 20;
      
      public static const GODSEVENING_SHOP:int = 35;
      
      public static const MOUNTS_SHOP:int = 1002;
      
      public static const POKER_SHOP:int = 1003;
      
      public static const OUTYARD_SHOP:int = 1004;
      
      public static const BINGO_SHOP:int = 1005;
      
      public static const GLORY_SHOP:int = 1008;
      
      public static const TREASURE_SHOP:int = 1009;
      
      public static const EXPLORE_SHOP:int = 1010;
      
      public static const ASSAULTWAR_SHOP:int = 1011;
      
      public static const PUMPING_JOY_SHOP:int = 1012;
      
      public static const SEVEN_YEAR_SHOP:int = 36;
      
      public static const NAVIGATION_SHOP:int = 9001;
      
      public static const UPGRADE_PRESENT_SHOP:int = 1013;
      
      public static const COPY_CONSORTIA_SHOP:int = 1014;
      
      public static const APEX_SHOP:int = 1015;
      
      public static const NEW_CROSS_GUILD_SHOP:int = 1016;
      
      public static const ANTAEUS_SHOP:int = 1017;
      
      public static const AIR_GARDEN_PROP_SHOP:int = 1018;
      
      public static const WISH_POOL_SHOP:int = 1019;
      
      public static const FLAME_TEMPLE_SHOP:int = 1020;
      
      public static const DUSK_AREA_SHOP:int = 1021;
      
      public static const DEMON_ROAD_SHOP:int = 1022;
      
      public static const DARK_MAZE_SHOP:int = 1023;
      
      public static const CONSORTIA_NEW_BOSS_SHOP:int = 1024;
      
      public static const THESEUS_PVP_SHOP:int = 1027;
      
      public static const THESEUS_DOUBLEPVP_SHOP:int = 1027;
      
      public static const CONSORTIA_NEW_BUFF_SHOP:int = 99999;
      
      public static const SHOP_CART:int = 200;
      
      public static const PET_EXCHANGE_SHOPTYPE:int = 888;
      
      public static const CONSORTIA_MINOS_SHOP:int = 1029;
      
      public static const CHESS_PVP_SHOP:int = 1030;
      
      public static const CHILD_NS_WAR_SHOP:int = 1031;
      
      public static const VIPSHOP:int = 1033;
      
      public static const NEW_GOODS:int = 1;
      
      public static const RECOMMENDED_GOODS:int = 2;
      
      public static const HOT_GOODS_FLAG:int = 3;
      
      public static const CROSS_BUGLE_TEMP_ID2:int = 208025;
      
      public static const CROSS_BUGLE_TEMP_ID:int = 2170005;
      
      public static const BIG_BUGLE_TEMP_ID:int = 208002;
      
      public static const SMALL_BUGLE_TEMP_ID:int = 208003;
      
      public static const MAZE_KEY:int = 208008;
      
      public static const MEDAL_TEMPID:int = 208001;
      
      public static const BACKPLAYER_TEMPID:int = 2125048;
      
      public static const FASHIONPIECE_TEMPID:int = 2125061;
      
      public static const FASHIONPIECE_TEMPID2:int = 2125062;
      
      public static const MYSTERY_STONE:int = 2131057;
      
      public static const MOUNTCONVERSION:int = 2125073;
      
      public static const CD_Time:int = 2031701;
      
      public static const INSIGNIA_MATERIALS:int = 31;
      
      public static const INSIGNIA_EQUIPMENTS:int = 32;
      
      public static const INSIGNIA_CONSUMABLES:int = 33;
      
      public static const LOSTGIFT:int = 2131117;
      
      public static const REMOTEPET_TEMPID:int = 2131200;
      
      public static const REMOTEPET_TEMPID2:int = 2131201;
      
      public static const APPLY_ITEM_TEMPLATE_ID:int = 2131121;
      
      public static const APPLY_ITEM_TEMPLATE_ID2:int = 2131140;
      
      public static const CONCISE_STONE:int = 208055;
      
      public static const TATTOO_IMPRINT_STONE:int = 208056;
      
      public static const PET_CONTRAC_FEEDTEMPID:int = 208062;
      
      public static const PET_HALLOWS_FEEDTEMPID:int = 208063;
      
      public static const PET_HALLOWS_BREAKTEMPID:int = 208064;
      
      public static const CHILD_SKILL_ACTIVE:int = 2269000;
      
      public static const CHILD_SKILL_PASSIVE:int = 2269001;
      
      public static const CHILD_SKILL_COMMON:int = 2269002;
      
      public static const CHILD_SKILL_ADVANCE:int = 2260001;
      
      public static const CHILD_NS_SKILL_ACTIVE:int = 212005;
      
      public static const CHILD_NS_SKILL_PROFOUND:int = 212006;
      
      public static const CHILD_NS_SKILL_PASSIVE:int = 212007;
      
      public static const CHILD_NS_SKILL_COMMON:int = 212008;
      
      public static const CHILD_NS_TALENT_MATERIAL:int = 212011;
      
      public static const CHILD_NS_LIFEWHEEL_MATERIAL:int = 212009;
      
      public static const CHILD_NS_LIFEWHEEL_KEY:int = 212010;
      
      public static const TALENT_STONE_TEMPID:int = 208053;
      
      public static const PUMP_COUPON_TEMPID:int = 208068;
      
      public static const STAR_PIECE_TEMPID:int = 8001000;
      
      public static const STAR_NORMAL_COUPON_TEMPID:int = 8001001;
      
      public static const STAR_ADVANCE_COUPON_TEMPID:int = 8001002;
      
      public static const STAR_CHART_PIECE_TEMPID:int = 8001015;
      
      public static const STAR_FIRE_TEMPID:int = 8001016;
      
      public static const STAR_FIRE_PUSH_TEMPID:int = 8001017;
      
      public static const AIR_GARDEN_PROP_TEMPID:int = -5000;
      
      public static const AIR_GARDEN_BED_TEMPID:int = -5100;
      
      public static const FLAME_TEMPLE_COIN_TEMPID:int = 208080;
      
      public static const DUSK_AREA_COIN_TEMPID:int = 208081;
      
      public static const AVENGER_CHILDNS_UPGRADE_TEMPID:int = 208526;
      
      public static const AVENGER_CHILDNS_STAGE_TEMPID:int = 208527;
      
      public static const CHILDNS_PASSIVE_BOOKID:int = 208528;
      
      public static const CHILDNS_ACTIVE_BOOKID:int = 208529;
      
      public static const DRAON_ROAD_SHOP_TEMPID:int = -16000;
      
      public static const DARK_MAZE_COIN_TEMPID:int = -17000;
      
      public static const CONSORTIA_NEW_BOSS_COIN_TEMPID:int = -18000;
      
      public static const THESE_PVP_FIGHT_MEDIA:int = 7640001;
      
      public static const NO_SEARCH_SHOP:int = 52;
      
      public static const CHILDNSWAR_MEDIA:int = 7640001;
      
      public static const THESEUSBOX:int = 1035;
      
      public static const DUNGENEXPLORE:int = 1034;
      
      public static const DUNGENEXPLORE_COIN:int = -5000;
      
      public static const CONSORTIA_USE_ITEM:Array = [8,22];
      
      public var Id:int;
      
      public var ShopType:int;
      
      public var Area:int;
      
      public var ItemId:int;
      
      public var Score:int;
      
      public var Point:int;
      
      public var GiftToken:int;
      
      public var Gold:int;
      
      public var NeedGrades:int;
      
      public var NeedMinGrade:int;
      
      public var NeedMaxGrade:int;
      
      public var MineScore:int;
      
      public var NeedGeste:int;
      
      public var Honor:int;
      
      public var LordsScore:int;
      
      public var PokerScore:int;
      
      public var NeedMinVip:int;
      
      public var ConsortiaOffer:int;
      
      public var NeedConsortiaLevels:int;
      
      public var MazeCoin:int;
      
      public var CrossGuildScore:int;
      
      public var CrossLeagueMedal:int;
      
      public var MazeLayers:int;
      
      public var MazeLayers2:int;
      
      public var ValidDate:int;
      
      public var VIP0Count:int;
      
      public var VIP1Count:int;
      
      public var VIP2Count:int;
      
      public var VIP3Count:int;
      
      public var VIP4Count:int;
      
      public var VIP5Count:int;
      
      public var VIP6Count:int;
      
      public var VIP7Count:int;
      
      public var VIP8Count:int;
      
      public var VIP9Count:int;
      
      public var Discount:int;
      
      public var Sort:int;
      
      public var IsHot:Boolean;
      
      public var Labels:int;
      
      public var Rands:int;
      
      private var _payType:int;
      
      private var _price:int;
      
      private var _oneCurrentCount:int;
      
      public var SellMaxCount:int;
      
      private var _type:int = 1;
      
      public var NeedItem:int = 0;
      
      public function ShopGoodsInfo(param1:IEventDispatcher = null)
      {
         super(param1);
      }
      
      public function get price() : int
      {
         return _price;
      }
      
      private function setPrice() : void
      {
         var _loc1_:GoodsTemplateInfo = null;
         if(ShopType == 8)
         {
            _loc1_ = TempleteManager.instance.goodsTemplateCate.getTemplateByID(NeedItem);
            _price = Score;
            _payType = 1001;
            if(_loc1_)
            {
               switch(_loc1_.Property1 - 101)
               {
                  case 0:
                     _payType = 1001;
                     break;
                  case 1:
                     _payType = 1002;
                     break;
                  case 2:
                     _payType = 1003;
                     break;
                  case 3:
                     _payType = 1004;
                     break;
                  case 4:
                     _payType = 1005;
                     break;
                  case 5:
                     _payType = 1006;
                     break;
                  case 8:
                     _payType = 1009;
                     break;
                  case 9:
                     _payType = 1010;
                     break;
                  case 10:
                     _payType = 1011;
                     break;
                  default:
                     _payType = 1001;
               }
            }
         }
         else if(ShopType == 15)
         {
            _payType = 1007;
            _price = Score;
         }
         else if(ShopType == 1033)
         {
            _payType = 1033;
            _price = Score;
         }
         else if(ShopType == 1035)
         {
            _payType = 1035;
            _price = Score;
         }
         else if(Point > 0)
         {
            _payType = 1;
            _price = Point;
         }
         else if(GiftToken > 0)
         {
            _payType = 2;
            _price = GiftToken;
         }
         else if(Gold > 0)
         {
            _payType = 3;
            _price = Gold;
         }
         else if(Honor > 0)
         {
            _payType = 5;
            _price = Honor;
         }
         else if(ShopType == 17)
         {
            _payType = 12;
            _price = Score;
         }
         else if(ConsortiaOffer > 0)
         {
            _payType = 4;
            _price = ConsortiaOffer;
         }
         else if(MazeCoin > 0)
         {
            _payType = 6;
            _price = MazeCoin;
         }
         else if(LordsScore > 0)
         {
            _payType = 7;
            _price = LordsScore;
         }
         else if(ShopType == 16)
         {
            _payType = 13;
            _price = Score;
         }
         else if(CrossGuildScore > 0)
         {
            _payType = 10;
            _price = CrossGuildScore;
         }
         else if(NeedItem == 2125048)
         {
            _payType = 8;
            _price = Score;
         }
         else if(ShopType == 14)
         {
            _payType = 11;
            _price = CrossLeagueMedal;
         }
         else if(ShopType == 19)
         {
            _payType = 15;
            _price = Score;
         }
         else if(ShopType == 20)
         {
            _payType = 16;
            _price = Score;
         }
         else if(ShopType == 1003)
         {
            _payType = 17;
            _price = PokerScore;
         }
         else if(ShopType == 1004)
         {
            _payType = 18;
            _price = Score;
         }
         else if(ShopType == 1005)
         {
            _payType = 19;
            _price = Score;
         }
         else if(ShopType == 10)
         {
            _payType = 7;
            _price = Score;
         }
         else if(ShopType == 1015)
         {
            _payType = 30;
            _price = Score;
         }
         else if(ShopType == 1008)
         {
            _payType = 20;
            _price = Score;
         }
         else if(ShopType == 1009)
         {
            _payType = 21;
            _price = Score;
         }
         else if(ShopType == 1010)
         {
            _payType = 22;
            _price = Score;
         }
         else if(ShopType == 1011)
         {
            _payType = 28;
            _price = Score;
         }
         else if(ShopType == 35)
         {
            _payType = 25;
            _price = Score;
         }
         else if(ShopType == 1012)
         {
            _payType = 2001;
            _price = Score;
         }
         else if(ShopType == 1014)
         {
            _payType = 29;
            _price = Score;
         }
         else if(ShopType == 1016)
         {
            _payType = 31;
            _price = Score;
         }
         else if(ShopType == 1017)
         {
            _payType = 32;
            _price = Score;
         }
         else if(ShopType == 1018)
         {
            _payType = 33;
            _price = Score;
         }
         else if(ShopType == 1020)
         {
            _payType = 37;
            _price = Score;
         }
         else if(ShopType == 1021)
         {
            _payType = 38;
            _price = Score;
         }
         else if(ShopType == 1022)
         {
            _payType = 1022;
            _price = Score;
         }
         else if(ShopType == 1023)
         {
            _payType = 39;
            _price = Score;
         }
         else if(ShopType == 1024)
         {
            _payType = 40;
            _price = Score;
         }
         else if(ShopType == 1027)
         {
            _payType = 41;
            _price = Score;
         }
         else if(ShopType == 37)
         {
            _payType = 42;
            _price = Score;
         }
         else if(ShopType == 38)
         {
            _payType = 43;
            _price = Score;
         }
         else if(ShopType == 1029)
         {
            _payType = 44;
            _price = Score;
         }
         else if(ShopType == 1030)
         {
            _payType = 45;
            _price = Score;
         }
         else if(ShopType == 1031)
         {
            _payType = 46;
            _price = Score;
         }
         else if(ShopType == 1034)
         {
            _payType = 1034;
            _price = Score;
         }
         else
         {
            _payType = 1;
            _price = 1;
         }
      }
      
      public function setSpecialPrice(param1:int) : void
      {
         _price = param1;
      }
      
      private function getDiscountByLevel() : Number
      {
         var _loc1_:Number = NaN;
         var _loc2_:int = 0;
         var _loc3_:Array = TempleteManager.instance.vipPrerogativeTemplateCate.getTemplatesByType(208);
         _loc2_ = 0;
         while(_loc2_ < _loc3_.length)
         {
            if(_loc3_[_loc2_].grade == VIPManager.Instance.model.vipInfo.VipGrade)
            {
               _loc1_ = Number(_loc3_[_loc2_].para1);
            }
            _loc2_++;
         }
         return _loc1_ / 10;
      }
      
      public function setSpecialPayType(param1:int) : void
      {
         _payType = param1;
      }
      
      public function get canBuyNum() : int
      {
         if(canTotalCount == -1 && canOneCount == -1)
         {
            return -1;
         }
         if(canTotalCount == -1)
         {
            return canOneCount;
         }
         if(canOneCount == -1)
         {
            return canOneCount;
         }
         return Math.min(canTotalCount,canOneCount);
      }
      
      public function get canOneCount() : int
      {
         if(OneDayCount != -1)
         {
            return OneDayCount - _oneCurrentCount;
         }
         return -1;
      }
      
      public function get canTotalCount() : int
      {
         return -1;
      }
      
      public function set oneTotalCount(param1:int) : void
      {
      }
      
      public function get OneCurrentCount() : int
      {
         return _oneCurrentCount;
      }
      
      public function set OneCurrentCount(param1:int) : void
      {
         _oneCurrentCount = param1;
         dispatchEvent(new ShopEvent("GOODS_INFO_UPDATE"));
      }
      
      public function get OneDayCount() : int
      {
         return this["VIP0Count"];
      }
      
      public function get PayType() : int
      {
         return _payType;
      }
      
      public function init() : void
      {
         setPrice();
      }
      
      public function get type() : int
      {
         return _type;
      }
      
      public function get template() : GoodsTemplateInfo
      {
         return TempleteManager.instance.goodsTemplateCate.getTemplateByID(ItemId);
      }
   }
}

