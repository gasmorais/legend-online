package com.road.yishi.proto.shop
{
   import com.netease.protobuf.Message;
   import com.netease.protobuf.ReadUtils;
   import com.netease.protobuf.WriteUtils;
   import com.netease.protobuf.WritingBuffer;
   import flash.errors.IOError;
   import flash.utils.IDataInput;
   import flash.utils.IExternalizable;
   
   public final class ShopTempInfoMsg extends Message implements IExternalizable
   {
      
      private var id$field:int;
      
      private var hasField$0:uint = 0;
      
      private var shopType$field:int;
      
      private var area$field:int;
      
      private var itemId$field:int;
      
      private var point$field:int;
      
      private var giftToken$field:int;
      
      private var gold$field:int;
      
      private var crystal$field:int;
      
      private var consortiaOffer$field:int;
      
      private var honor$field:int;
      
      private var mazeCoin$field:int;
      
      private var mazeLayers$field:int;
      
      private var mazeLayers2$field:int;
      
      private var needGrades$field:int;
      
      private var needConsortiaLevels$field:int;
      
      private var needMinVip$field:int;
      
      private var vIP0Count$field:int;
      
      private var vIP1Count$field:int;
      
      private var vIP2Count$field:int;
      
      private var vIP3Count$field:int;
      
      private var vIP4Count$field:int;
      
      private var vIP5Count$field:int;
      
      private var vIP6Count$field:int;
      
      private var vIP7Count$field:int;
      
      private var vIP8Count$field:int;
      
      private var vIP9Count$field:int;
      
      private var firstPrice$field:int;
      
      private var discount$field:int;
      
      private var price$field:int;
      
      private var sort$field:int;
      
      private var isHot$field:Boolean;
      
      private var labels$field:int;
      
      private var needGeste$field:int;
      
      private var hasField$1:uint = 0;
      
      private var validDate$field:int;
      
      private var rands$field:int;
      
      private var needScore$field:int;
      
      private var needMinGrade$field:int;
      
      private var needMaxGrade$field:int;
      
      private var isNeedPoint$field:Boolean;
      
      private var lordsScore$field:int;
      
      private var needItem$field:int;
      
      private var mineScore$field:int;
      
      private var crossGuildScore$field:int;
      
      private var leagueMedal$field:int;
      
      private var pokerScore$field:int;
      
      public function ShopTempInfoMsg()
      {
         super();
      }
      
      public function removeId() : void
      {
         hasField$0 &= 4294967294;
         id$field = new int();
      }
      
      public function get hasId() : Boolean
      {
         return (hasField$0 & 1) != 0;
      }
      
      public function set id(param1:int) : void
      {
         hasField$0 |= 1;
         id$field = param1;
      }
      
      public function get id() : int
      {
         return id$field;
      }
      
      public function removeShopType() : void
      {
         hasField$0 &= 4294967293;
         shopType$field = new int();
      }
      
      public function get hasShopType() : Boolean
      {
         return (hasField$0 & 2) != 0;
      }
      
      public function set shopType(param1:int) : void
      {
         hasField$0 |= 2;
         shopType$field = param1;
      }
      
      public function get shopType() : int
      {
         return shopType$field;
      }
      
      public function removeArea() : void
      {
         hasField$0 &= 4294967291;
         area$field = new int();
      }
      
      public function get hasArea() : Boolean
      {
         return (hasField$0 & 4) != 0;
      }
      
      public function set area(param1:int) : void
      {
         hasField$0 |= 4;
         area$field = param1;
      }
      
      public function get area() : int
      {
         return area$field;
      }
      
      public function removeItemId() : void
      {
         hasField$0 &= 4294967287;
         itemId$field = new int();
      }
      
      public function get hasItemId() : Boolean
      {
         return (hasField$0 & 8) != 0;
      }
      
      public function set itemId(param1:int) : void
      {
         hasField$0 |= 8;
         itemId$field = param1;
      }
      
      public function get itemId() : int
      {
         return itemId$field;
      }
      
      public function removePoint() : void
      {
         hasField$0 &= 4294967279;
         point$field = new int();
      }
      
      public function get hasPoint() : Boolean
      {
         return (hasField$0 & 0x10) != 0;
      }
      
      public function set point(param1:int) : void
      {
         hasField$0 |= 16;
         point$field = param1;
      }
      
      public function get point() : int
      {
         return point$field;
      }
      
      public function removeGiftToken() : void
      {
         hasField$0 &= 4294967263;
         giftToken$field = new int();
      }
      
      public function get hasGiftToken() : Boolean
      {
         return (hasField$0 & 0x20) != 0;
      }
      
      public function set giftToken(param1:int) : void
      {
         hasField$0 |= 32;
         giftToken$field = param1;
      }
      
      public function get giftToken() : int
      {
         return giftToken$field;
      }
      
      public function removeGold() : void
      {
         hasField$0 &= 4294967231;
         gold$field = new int();
      }
      
      public function get hasGold() : Boolean
      {
         return (hasField$0 & 0x40) != 0;
      }
      
      public function set gold(param1:int) : void
      {
         hasField$0 |= 64;
         gold$field = param1;
      }
      
      public function get gold() : int
      {
         return gold$field;
      }
      
      public function removeCrystal() : void
      {
         hasField$0 &= 4294967167;
         crystal$field = new int();
      }
      
      public function get hasCrystal() : Boolean
      {
         return (hasField$0 & 0x80) != 0;
      }
      
      public function set crystal(param1:int) : void
      {
         hasField$0 |= 128;
         crystal$field = param1;
      }
      
      public function get crystal() : int
      {
         return crystal$field;
      }
      
      public function removeConsortiaOffer() : void
      {
         hasField$0 &= 4294967039;
         consortiaOffer$field = new int();
      }
      
      public function get hasConsortiaOffer() : Boolean
      {
         return (hasField$0 & 0x0100) != 0;
      }
      
      public function set consortiaOffer(param1:int) : void
      {
         hasField$0 |= 256;
         consortiaOffer$field = param1;
      }
      
      public function get consortiaOffer() : int
      {
         return consortiaOffer$field;
      }
      
      public function removeHonor() : void
      {
         hasField$0 &= 4294966783;
         honor$field = new int();
      }
      
      public function get hasHonor() : Boolean
      {
         return (hasField$0 & 0x0200) != 0;
      }
      
      public function set honor(param1:int) : void
      {
         hasField$0 |= 512;
         honor$field = param1;
      }
      
      public function get honor() : int
      {
         return honor$field;
      }
      
      public function removeMazeCoin() : void
      {
         hasField$0 &= 4294966271;
         mazeCoin$field = new int();
      }
      
      public function get hasMazeCoin() : Boolean
      {
         return (hasField$0 & 0x0400) != 0;
      }
      
      public function set mazeCoin(param1:int) : void
      {
         hasField$0 |= 1024;
         mazeCoin$field = param1;
      }
      
      public function get mazeCoin() : int
      {
         return mazeCoin$field;
      }
      
      public function removeMazeLayers() : void
      {
         hasField$0 &= 4294965247;
         mazeLayers$field = new int();
      }
      
      public function get hasMazeLayers() : Boolean
      {
         return (hasField$0 & 0x0800) != 0;
      }
      
      public function set mazeLayers(param1:int) : void
      {
         hasField$0 |= 2048;
         mazeLayers$field = param1;
      }
      
      public function get mazeLayers() : int
      {
         return mazeLayers$field;
      }
      
      public function removeMazeLayers2() : void
      {
         hasField$0 &= 4294963199;
         mazeLayers2$field = new int();
      }
      
      public function get hasMazeLayers2() : Boolean
      {
         return (hasField$0 & 0x1000) != 0;
      }
      
      public function set mazeLayers2(param1:int) : void
      {
         hasField$0 |= 4096;
         mazeLayers2$field = param1;
      }
      
      public function get mazeLayers2() : int
      {
         return mazeLayers2$field;
      }
      
      public function removeNeedGrades() : void
      {
         hasField$0 &= 4294959103;
         needGrades$field = new int();
      }
      
      public function get hasNeedGrades() : Boolean
      {
         return (hasField$0 & 0x2000) != 0;
      }
      
      public function set needGrades(param1:int) : void
      {
         hasField$0 |= 8192;
         needGrades$field = param1;
      }
      
      public function get needGrades() : int
      {
         return needGrades$field;
      }
      
      public function removeNeedConsortiaLevels() : void
      {
         hasField$0 &= 4294950911;
         needConsortiaLevels$field = new int();
      }
      
      public function get hasNeedConsortiaLevels() : Boolean
      {
         return (hasField$0 & 0x4000) != 0;
      }
      
      public function set needConsortiaLevels(param1:int) : void
      {
         hasField$0 |= 16384;
         needConsortiaLevels$field = param1;
      }
      
      public function get needConsortiaLevels() : int
      {
         return needConsortiaLevels$field;
      }
      
      public function removeNeedMinVip() : void
      {
         hasField$0 &= 4294934527;
         needMinVip$field = new int();
      }
      
      public function get hasNeedMinVip() : Boolean
      {
         return (hasField$0 & 0x8000) != 0;
      }
      
      public function set needMinVip(param1:int) : void
      {
         hasField$0 |= 32768;
         needMinVip$field = param1;
      }
      
      public function get needMinVip() : int
      {
         return needMinVip$field;
      }
      
      public function removeVIP0Count() : void
      {
         hasField$0 &= 4294901759;
         vIP0Count$field = new int();
      }
      
      public function get hasVIP0Count() : Boolean
      {
         return (hasField$0 & 0x010000) != 0;
      }
      
      public function set vIP0Count(param1:int) : void
      {
         hasField$0 |= 65536;
         vIP0Count$field = param1;
      }
      
      public function get vIP0Count() : int
      {
         return vIP0Count$field;
      }
      
      public function removeVIP1Count() : void
      {
         hasField$0 &= 4294836223;
         vIP1Count$field = new int();
      }
      
      public function get hasVIP1Count() : Boolean
      {
         return (hasField$0 & 0x020000) != 0;
      }
      
      public function set vIP1Count(param1:int) : void
      {
         hasField$0 |= 131072;
         vIP1Count$field = param1;
      }
      
      public function get vIP1Count() : int
      {
         return vIP1Count$field;
      }
      
      public function removeVIP2Count() : void
      {
         hasField$0 &= 4294705151;
         vIP2Count$field = new int();
      }
      
      public function get hasVIP2Count() : Boolean
      {
         return (hasField$0 & 0x040000) != 0;
      }
      
      public function set vIP2Count(param1:int) : void
      {
         hasField$0 |= 262144;
         vIP2Count$field = param1;
      }
      
      public function get vIP2Count() : int
      {
         return vIP2Count$field;
      }
      
      public function removeVIP3Count() : void
      {
         hasField$0 &= 4294443007;
         vIP3Count$field = new int();
      }
      
      public function get hasVIP3Count() : Boolean
      {
         return (hasField$0 & 0x080000) != 0;
      }
      
      public function set vIP3Count(param1:int) : void
      {
         hasField$0 |= 524288;
         vIP3Count$field = param1;
      }
      
      public function get vIP3Count() : int
      {
         return vIP3Count$field;
      }
      
      public function removeVIP4Count() : void
      {
         hasField$0 &= 4293918719;
         vIP4Count$field = new int();
      }
      
      public function get hasVIP4Count() : Boolean
      {
         return (hasField$0 & 0x100000) != 0;
      }
      
      public function set vIP4Count(param1:int) : void
      {
         hasField$0 |= 1048576;
         vIP4Count$field = param1;
      }
      
      public function get vIP4Count() : int
      {
         return vIP4Count$field;
      }
      
      public function removeVIP5Count() : void
      {
         hasField$0 &= 4292870143;
         vIP5Count$field = new int();
      }
      
      public function get hasVIP5Count() : Boolean
      {
         return (hasField$0 & 0x200000) != 0;
      }
      
      public function set vIP5Count(param1:int) : void
      {
         hasField$0 |= 2097152;
         vIP5Count$field = param1;
      }
      
      public function get vIP5Count() : int
      {
         return vIP5Count$field;
      }
      
      public function removeVIP6Count() : void
      {
         hasField$0 &= 4290772991;
         vIP6Count$field = new int();
      }
      
      public function get hasVIP6Count() : Boolean
      {
         return (hasField$0 & 0x400000) != 0;
      }
      
      public function set vIP6Count(param1:int) : void
      {
         hasField$0 |= 4194304;
         vIP6Count$field = param1;
      }
      
      public function get vIP6Count() : int
      {
         return vIP6Count$field;
      }
      
      public function removeVIP7Count() : void
      {
         hasField$0 &= 4286578687;
         vIP7Count$field = new int();
      }
      
      public function get hasVIP7Count() : Boolean
      {
         return (hasField$0 & 0x800000) != 0;
      }
      
      public function set vIP7Count(param1:int) : void
      {
         hasField$0 |= 8388608;
         vIP7Count$field = param1;
      }
      
      public function get vIP7Count() : int
      {
         return vIP7Count$field;
      }
      
      public function removeVIP8Count() : void
      {
         hasField$0 &= 4278190079;
         vIP8Count$field = new int();
      }
      
      public function get hasVIP8Count() : Boolean
      {
         return (hasField$0 & 0x01000000) != 0;
      }
      
      public function set vIP8Count(param1:int) : void
      {
         hasField$0 |= 16777216;
         vIP8Count$field = param1;
      }
      
      public function get vIP8Count() : int
      {
         return vIP8Count$field;
      }
      
      public function removeVIP9Count() : void
      {
         hasField$0 &= 4261412863;
         vIP9Count$field = new int();
      }
      
      public function get hasVIP9Count() : Boolean
      {
         return (hasField$0 & 0x02000000) != 0;
      }
      
      public function set vIP9Count(param1:int) : void
      {
         hasField$0 |= 33554432;
         vIP9Count$field = param1;
      }
      
      public function get vIP9Count() : int
      {
         return vIP9Count$field;
      }
      
      public function removeFirstPrice() : void
      {
         hasField$0 &= 4227858431;
         firstPrice$field = new int();
      }
      
      public function get hasFirstPrice() : Boolean
      {
         return (hasField$0 & 0x04000000) != 0;
      }
      
      public function set firstPrice(param1:int) : void
      {
         hasField$0 |= 67108864;
         firstPrice$field = param1;
      }
      
      public function get firstPrice() : int
      {
         return firstPrice$field;
      }
      
      public function removeDiscount() : void
      {
         hasField$0 &= 4160749567;
         discount$field = new int();
      }
      
      public function get hasDiscount() : Boolean
      {
         return (hasField$0 & 0x08000000) != 0;
      }
      
      public function set discount(param1:int) : void
      {
         hasField$0 |= 134217728;
         discount$field = param1;
      }
      
      public function get discount() : int
      {
         return discount$field;
      }
      
      public function removePrice() : void
      {
         hasField$0 &= 4026531839;
         price$field = new int();
      }
      
      public function get hasPrice() : Boolean
      {
         return (hasField$0 & 0x10000000) != 0;
      }
      
      public function set price(param1:int) : void
      {
         hasField$0 |= 268435456;
         price$field = param1;
      }
      
      public function get price() : int
      {
         return price$field;
      }
      
      public function removeSort() : void
      {
         hasField$0 &= 3758096383;
         sort$field = new int();
      }
      
      public function get hasSort() : Boolean
      {
         return (hasField$0 & 0x20000000) != 0;
      }
      
      public function set sort(param1:int) : void
      {
         hasField$0 |= 536870912;
         sort$field = param1;
      }
      
      public function get sort() : int
      {
         return sort$field;
      }
      
      public function removeIsHot() : void
      {
         hasField$0 &= 3221225471;
         isHot$field = new Boolean();
      }
      
      public function get hasIsHot() : Boolean
      {
         return (hasField$0 & 0x40000000) != 0;
      }
      
      public function set isHot(param1:Boolean) : void
      {
         hasField$0 |= 1073741824;
         isHot$field = param1;
      }
      
      public function get isHot() : Boolean
      {
         return isHot$field;
      }
      
      public function removeLabels() : void
      {
         hasField$0 &= 2147483647;
         labels$field = new int();
      }
      
      public function get hasLabels() : Boolean
      {
         return (hasField$0 & 0x80000000) != 0;
      }
      
      public function set labels(param1:int) : void
      {
         hasField$0 |= 2147483648;
         labels$field = param1;
      }
      
      public function get labels() : int
      {
         return labels$field;
      }
      
      public function removeNeedGeste() : void
      {
         hasField$1 &= 4294967294;
         needGeste$field = new int();
      }
      
      public function get hasNeedGeste() : Boolean
      {
         return (hasField$1 & 1) != 0;
      }
      
      public function set needGeste(param1:int) : void
      {
         hasField$1 |= 1;
         needGeste$field = param1;
      }
      
      public function get needGeste() : int
      {
         return needGeste$field;
      }
      
      public function removeValidDate() : void
      {
         hasField$1 &= 4294967293;
         validDate$field = new int();
      }
      
      public function get hasValidDate() : Boolean
      {
         return (hasField$1 & 2) != 0;
      }
      
      public function set validDate(param1:int) : void
      {
         hasField$1 |= 2;
         validDate$field = param1;
      }
      
      public function get validDate() : int
      {
         return validDate$field;
      }
      
      public function removeRands() : void
      {
         hasField$1 &= 4294967291;
         rands$field = new int();
      }
      
      public function get hasRands() : Boolean
      {
         return (hasField$1 & 4) != 0;
      }
      
      public function set rands(param1:int) : void
      {
         hasField$1 |= 4;
         rands$field = param1;
      }
      
      public function get rands() : int
      {
         return rands$field;
      }
      
      public function removeNeedScore() : void
      {
         hasField$1 &= 4294967287;
         needScore$field = new int();
      }
      
      public function get hasNeedScore() : Boolean
      {
         return (hasField$1 & 8) != 0;
      }
      
      public function set needScore(param1:int) : void
      {
         hasField$1 |= 8;
         needScore$field = param1;
      }
      
      public function get needScore() : int
      {
         return needScore$field;
      }
      
      public function removeNeedMinGrade() : void
      {
         hasField$1 &= 4294967279;
         needMinGrade$field = new int();
      }
      
      public function get hasNeedMinGrade() : Boolean
      {
         return (hasField$1 & 0x10) != 0;
      }
      
      public function set needMinGrade(param1:int) : void
      {
         hasField$1 |= 16;
         needMinGrade$field = param1;
      }
      
      public function get needMinGrade() : int
      {
         return needMinGrade$field;
      }
      
      public function removeNeedMaxGrade() : void
      {
         hasField$1 &= 4294967263;
         needMaxGrade$field = new int();
      }
      
      public function get hasNeedMaxGrade() : Boolean
      {
         return (hasField$1 & 0x20) != 0;
      }
      
      public function set needMaxGrade(param1:int) : void
      {
         hasField$1 |= 32;
         needMaxGrade$field = param1;
      }
      
      public function get needMaxGrade() : int
      {
         return needMaxGrade$field;
      }
      
      public function removeIsNeedPoint() : void
      {
         hasField$1 &= 4294967231;
         isNeedPoint$field = new Boolean();
      }
      
      public function get hasIsNeedPoint() : Boolean
      {
         return (hasField$1 & 0x40) != 0;
      }
      
      public function set isNeedPoint(param1:Boolean) : void
      {
         hasField$1 |= 64;
         isNeedPoint$field = param1;
      }
      
      public function get isNeedPoint() : Boolean
      {
         return isNeedPoint$field;
      }
      
      public function removeLordsScore() : void
      {
         hasField$1 &= 4294967167;
         lordsScore$field = new int();
      }
      
      public function get hasLordsScore() : Boolean
      {
         return (hasField$1 & 0x80) != 0;
      }
      
      public function set lordsScore(param1:int) : void
      {
         hasField$1 |= 128;
         lordsScore$field = param1;
      }
      
      public function get lordsScore() : int
      {
         return lordsScore$field;
      }
      
      public function removeNeedItem() : void
      {
         hasField$1 &= 4294967039;
         needItem$field = new int();
      }
      
      public function get hasNeedItem() : Boolean
      {
         return (hasField$1 & 0x0100) != 0;
      }
      
      public function set needItem(param1:int) : void
      {
         hasField$1 |= 256;
         needItem$field = param1;
      }
      
      public function get needItem() : int
      {
         return needItem$field;
      }
      
      public function removeMineScore() : void
      {
         hasField$1 &= 4294966783;
         mineScore$field = new int();
      }
      
      public function get hasMineScore() : Boolean
      {
         return (hasField$1 & 0x0200) != 0;
      }
      
      public function set mineScore(param1:int) : void
      {
         hasField$1 |= 512;
         mineScore$field = param1;
      }
      
      public function get mineScore() : int
      {
         return mineScore$field;
      }
      
      public function removeCrossGuildScore() : void
      {
         hasField$1 &= 4294966271;
         crossGuildScore$field = new int();
      }
      
      public function get hasCrossGuildScore() : Boolean
      {
         return (hasField$1 & 0x0400) != 0;
      }
      
      public function set crossGuildScore(param1:int) : void
      {
         hasField$1 |= 1024;
         crossGuildScore$field = param1;
      }
      
      public function get crossGuildScore() : int
      {
         return crossGuildScore$field;
      }
      
      public function removeLeagueMedal() : void
      {
         hasField$1 &= 4294965247;
         leagueMedal$field = new int();
      }
      
      public function get hasLeagueMedal() : Boolean
      {
         return (hasField$1 & 0x0800) != 0;
      }
      
      public function set leagueMedal(param1:int) : void
      {
         hasField$1 |= 2048;
         leagueMedal$field = param1;
      }
      
      public function get leagueMedal() : int
      {
         return leagueMedal$field;
      }
      
      public function removePokerScore() : void
      {
         hasField$1 &= 4294963199;
         pokerScore$field = new int();
      }
      
      public function get hasPokerScore() : Boolean
      {
         return (hasField$1 & 0x1000) != 0;
      }
      
      public function set pokerScore(param1:int) : void
      {
         hasField$1 |= 4096;
         pokerScore$field = param1;
      }
      
      public function get pokerScore() : int
      {
         return pokerScore$field;
      }
      
      final override public function writeToBuffer(param1:WritingBuffer) : void
      {
         if(hasId)
         {
            WriteUtils.writeTag(param1,0,1);
            WriteUtils.write$TYPE_INT32(param1,id$field);
         }
         if(hasShopType)
         {
            WriteUtils.writeTag(param1,0,2);
            WriteUtils.write$TYPE_INT32(param1,shopType$field);
         }
         if(hasArea)
         {
            WriteUtils.writeTag(param1,0,3);
            WriteUtils.write$TYPE_INT32(param1,area$field);
         }
         if(hasItemId)
         {
            WriteUtils.writeTag(param1,0,4);
            WriteUtils.write$TYPE_INT32(param1,itemId$field);
         }
         if(hasPoint)
         {
            WriteUtils.writeTag(param1,0,5);
            WriteUtils.write$TYPE_INT32(param1,point$field);
         }
         if(hasGiftToken)
         {
            WriteUtils.writeTag(param1,0,6);
            WriteUtils.write$TYPE_INT32(param1,giftToken$field);
         }
         if(hasGold)
         {
            WriteUtils.writeTag(param1,0,7);
            WriteUtils.write$TYPE_INT32(param1,gold$field);
         }
         if(hasCrystal)
         {
            WriteUtils.writeTag(param1,0,8);
            WriteUtils.write$TYPE_INT32(param1,crystal$field);
         }
         if(hasConsortiaOffer)
         {
            WriteUtils.writeTag(param1,0,9);
            WriteUtils.write$TYPE_INT32(param1,consortiaOffer$field);
         }
         if(hasHonor)
         {
            WriteUtils.writeTag(param1,0,10);
            WriteUtils.write$TYPE_INT32(param1,honor$field);
         }
         if(hasMazeCoin)
         {
            WriteUtils.writeTag(param1,0,11);
            WriteUtils.write$TYPE_INT32(param1,mazeCoin$field);
         }
         if(hasMazeLayers)
         {
            WriteUtils.writeTag(param1,0,12);
            WriteUtils.write$TYPE_INT32(param1,mazeLayers$field);
         }
         if(hasMazeLayers2)
         {
            WriteUtils.writeTag(param1,0,13);
            WriteUtils.write$TYPE_INT32(param1,mazeLayers2$field);
         }
         if(hasNeedGrades)
         {
            WriteUtils.writeTag(param1,0,14);
            WriteUtils.write$TYPE_INT32(param1,needGrades$field);
         }
         if(hasNeedConsortiaLevels)
         {
            WriteUtils.writeTag(param1,0,15);
            WriteUtils.write$TYPE_INT32(param1,needConsortiaLevels$field);
         }
         if(hasNeedMinVip)
         {
            WriteUtils.writeTag(param1,0,16);
            WriteUtils.write$TYPE_INT32(param1,needMinVip$field);
         }
         if(hasVIP0Count)
         {
            WriteUtils.writeTag(param1,0,17);
            WriteUtils.write$TYPE_INT32(param1,vIP0Count$field);
         }
         if(hasVIP1Count)
         {
            WriteUtils.writeTag(param1,0,18);
            WriteUtils.write$TYPE_INT32(param1,vIP1Count$field);
         }
         if(hasVIP2Count)
         {
            WriteUtils.writeTag(param1,0,19);
            WriteUtils.write$TYPE_INT32(param1,vIP2Count$field);
         }
         if(hasVIP3Count)
         {
            WriteUtils.writeTag(param1,0,20);
            WriteUtils.write$TYPE_INT32(param1,vIP3Count$field);
         }
         if(hasVIP4Count)
         {
            WriteUtils.writeTag(param1,0,21);
            WriteUtils.write$TYPE_INT32(param1,vIP4Count$field);
         }
         if(hasVIP5Count)
         {
            WriteUtils.writeTag(param1,0,22);
            WriteUtils.write$TYPE_INT32(param1,vIP5Count$field);
         }
         if(hasVIP6Count)
         {
            WriteUtils.writeTag(param1,0,23);
            WriteUtils.write$TYPE_INT32(param1,vIP6Count$field);
         }
         if(hasVIP7Count)
         {
            WriteUtils.writeTag(param1,0,24);
            WriteUtils.write$TYPE_INT32(param1,vIP7Count$field);
         }
         if(hasVIP8Count)
         {
            WriteUtils.writeTag(param1,0,25);
            WriteUtils.write$TYPE_INT32(param1,vIP8Count$field);
         }
         if(hasVIP9Count)
         {
            WriteUtils.writeTag(param1,0,26);
            WriteUtils.write$TYPE_INT32(param1,vIP9Count$field);
         }
         if(hasFirstPrice)
         {
            WriteUtils.writeTag(param1,0,27);
            WriteUtils.write$TYPE_INT32(param1,firstPrice$field);
         }
         if(hasDiscount)
         {
            WriteUtils.writeTag(param1,0,28);
            WriteUtils.write$TYPE_INT32(param1,discount$field);
         }
         if(hasPrice)
         {
            WriteUtils.writeTag(param1,0,29);
            WriteUtils.write$TYPE_INT32(param1,price$field);
         }
         if(hasSort)
         {
            WriteUtils.writeTag(param1,0,30);
            WriteUtils.write$TYPE_INT32(param1,sort$field);
         }
         if(hasIsHot)
         {
            WriteUtils.writeTag(param1,0,31);
            WriteUtils.write$TYPE_BOOL(param1,isHot$field);
         }
         if(hasLabels)
         {
            WriteUtils.writeTag(param1,0,32);
            WriteUtils.write$TYPE_INT32(param1,labels$field);
         }
         if(hasNeedGeste)
         {
            WriteUtils.writeTag(param1,0,33);
            WriteUtils.write$TYPE_INT32(param1,needGeste$field);
         }
         if(hasValidDate)
         {
            WriteUtils.writeTag(param1,0,34);
            WriteUtils.write$TYPE_INT32(param1,validDate$field);
         }
         if(hasRands)
         {
            WriteUtils.writeTag(param1,0,35);
            WriteUtils.write$TYPE_INT32(param1,rands$field);
         }
         if(hasNeedScore)
         {
            WriteUtils.writeTag(param1,0,36);
            WriteUtils.write$TYPE_INT32(param1,needScore$field);
         }
         if(hasNeedMinGrade)
         {
            WriteUtils.writeTag(param1,0,37);
            WriteUtils.write$TYPE_INT32(param1,needMinGrade$field);
         }
         if(hasNeedMaxGrade)
         {
            WriteUtils.writeTag(param1,0,38);
            WriteUtils.write$TYPE_INT32(param1,needMaxGrade$field);
         }
         if(hasIsNeedPoint)
         {
            WriteUtils.writeTag(param1,0,39);
            WriteUtils.write$TYPE_BOOL(param1,isNeedPoint$field);
         }
         if(hasLordsScore)
         {
            WriteUtils.writeTag(param1,0,40);
            WriteUtils.write$TYPE_INT32(param1,lordsScore$field);
         }
         if(hasNeedItem)
         {
            WriteUtils.writeTag(param1,0,41);
            WriteUtils.write$TYPE_INT32(param1,needItem$field);
         }
         if(hasMineScore)
         {
            WriteUtils.writeTag(param1,0,42);
            WriteUtils.write$TYPE_INT32(param1,mineScore$field);
         }
         if(hasCrossGuildScore)
         {
            WriteUtils.writeTag(param1,0,43);
            WriteUtils.write$TYPE_INT32(param1,crossGuildScore$field);
         }
         if(hasLeagueMedal)
         {
            WriteUtils.writeTag(param1,0,44);
            WriteUtils.write$TYPE_INT32(param1,leagueMedal$field);
         }
         if(hasPokerScore)
         {
            WriteUtils.writeTag(param1,0,45);
            WriteUtils.write$TYPE_INT32(param1,pokerScore$field);
         }
      }
      
      final override public function readFromSlice(param1:IDataInput, param2:uint) : void
      {
         var _loc22_:* = 0;
         var _loc29_:uint = 0;
         var _loc34_:uint = 0;
         var _loc10_:uint = 0;
         var _loc36_:uint = 0;
         var _loc18_:uint = 0;
         var _loc26_:uint = 0;
         var _loc45_:uint = 0;
         var _loc6_:uint = 0;
         var _loc40_:uint = 0;
         var _loc43_:uint = 0;
         var _loc27_:uint = 0;
         var _loc7_:uint = 0;
         var _loc5_:uint = 0;
         var _loc42_:uint = 0;
         var _loc35_:uint = 0;
         var _loc37_:uint = 0;
         var _loc4_:uint = 0;
         var _loc13_:uint = 0;
         var _loc38_:uint = 0;
         var _loc48_:uint = 0;
         var _loc11_:uint = 0;
         var _loc23_:uint = 0;
         var _loc41_:uint = 0;
         var _loc3_:uint = 0;
         var _loc39_:uint = 0;
         var _loc19_:uint = 0;
         var _loc24_:uint = 0;
         var _loc8_:uint = 0;
         var _loc31_:uint = 0;
         var _loc14_:uint = 0;
         var _loc46_:uint = 0;
         var _loc25_:uint = 0;
         var _loc9_:uint = 0;
         var _loc47_:uint = 0;
         var _loc15_:uint = 0;
         var _loc12_:uint = 0;
         var _loc32_:uint = 0;
         var _loc44_:uint = 0;
         var _loc17_:uint = 0;
         var _loc33_:uint = 0;
         var _loc28_:uint = 0;
         var _loc20_:uint = 0;
         var _loc16_:uint = 0;
         var _loc30_:uint = 0;
         var _loc21_:uint = 0;
         while(param1.bytesAvailable > param2)
         {
            switch((_loc22_ = ReadUtils.read$TYPE_UINT32(param1)) >>> 3)
            {
               case 1:
                  if(_loc29_ != 0)
                  {
                     throw new IOError("Bad data format: ShopTempInfoMsg.id cannot be set twice.");
                  }
                  _loc29_++;
                  id = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 2:
                  if(_loc34_ != 0)
                  {
                     throw new IOError("Bad data format: ShopTempInfoMsg.shopType cannot be set twice.");
                  }
                  _loc34_++;
                  shopType = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 3:
                  if(_loc10_ != 0)
                  {
                     throw new IOError("Bad data format: ShopTempInfoMsg.area cannot be set twice.");
                  }
                  _loc10_++;
                  area = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 4:
                  if(_loc36_ != 0)
                  {
                     throw new IOError("Bad data format: ShopTempInfoMsg.itemId cannot be set twice.");
                  }
                  _loc36_++;
                  itemId = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 5:
                  if(_loc18_ != 0)
                  {
                     throw new IOError("Bad data format: ShopTempInfoMsg.point cannot be set twice.");
                  }
                  _loc18_++;
                  point = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 6:
                  if(_loc26_ != 0)
                  {
                     throw new IOError("Bad data format: ShopTempInfoMsg.giftToken cannot be set twice.");
                  }
                  _loc26_++;
                  giftToken = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 7:
                  if(_loc45_ != 0)
                  {
                     throw new IOError("Bad data format: ShopTempInfoMsg.gold cannot be set twice.");
                  }
                  _loc45_++;
                  gold = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 8:
                  if(_loc6_ != 0)
                  {
                     throw new IOError("Bad data format: ShopTempInfoMsg.crystal cannot be set twice.");
                  }
                  _loc6_++;
                  crystal = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 9:
                  if(_loc40_ != 0)
                  {
                     throw new IOError("Bad data format: ShopTempInfoMsg.consortiaOffer cannot be set twice.");
                  }
                  _loc40_++;
                  consortiaOffer = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 10:
                  if(_loc43_ != 0)
                  {
                     throw new IOError("Bad data format: ShopTempInfoMsg.honor cannot be set twice.");
                  }
                  _loc43_++;
                  honor = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 11:
                  if(_loc27_ != 0)
                  {
                     throw new IOError("Bad data format: ShopTempInfoMsg.mazeCoin cannot be set twice.");
                  }
                  _loc27_++;
                  mazeCoin = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 12:
                  if(_loc7_ != 0)
                  {
                     throw new IOError("Bad data format: ShopTempInfoMsg.mazeLayers cannot be set twice.");
                  }
                  _loc7_++;
                  mazeLayers = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 13:
                  if(_loc5_ != 0)
                  {
                     throw new IOError("Bad data format: ShopTempInfoMsg.mazeLayers2 cannot be set twice.");
                  }
                  _loc5_++;
                  mazeLayers2 = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 14:
                  if(_loc42_ != 0)
                  {
                     throw new IOError("Bad data format: ShopTempInfoMsg.needGrades cannot be set twice.");
                  }
                  _loc42_++;
                  needGrades = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 15:
                  if(_loc35_ != 0)
                  {
                     throw new IOError("Bad data format: ShopTempInfoMsg.needConsortiaLevels cannot be set twice.");
                  }
                  _loc35_++;
                  needConsortiaLevels = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 16:
                  if(_loc37_ != 0)
                  {
                     throw new IOError("Bad data format: ShopTempInfoMsg.needMinVip cannot be set twice.");
                  }
                  _loc37_++;
                  needMinVip = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 17:
                  if(_loc4_ != 0)
                  {
                     throw new IOError("Bad data format: ShopTempInfoMsg.vIP0Count cannot be set twice.");
                  }
                  _loc4_++;
                  vIP0Count = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 18:
                  if(_loc13_ != 0)
                  {
                     throw new IOError("Bad data format: ShopTempInfoMsg.vIP1Count cannot be set twice.");
                  }
                  _loc13_++;
                  vIP1Count = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 19:
                  if(_loc38_ != 0)
                  {
                     throw new IOError("Bad data format: ShopTempInfoMsg.vIP2Count cannot be set twice.");
                  }
                  _loc38_++;
                  vIP2Count = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 20:
                  if(_loc48_ != 0)
                  {
                     throw new IOError("Bad data format: ShopTempInfoMsg.vIP3Count cannot be set twice.");
                  }
                  _loc48_++;
                  vIP3Count = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 21:
                  if(_loc11_ != 0)
                  {
                     throw new IOError("Bad data format: ShopTempInfoMsg.vIP4Count cannot be set twice.");
                  }
                  _loc11_++;
                  vIP4Count = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 22:
                  if(_loc23_ != 0)
                  {
                     throw new IOError("Bad data format: ShopTempInfoMsg.vIP5Count cannot be set twice.");
                  }
                  _loc23_++;
                  vIP5Count = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 23:
                  if(_loc41_ != 0)
                  {
                     throw new IOError("Bad data format: ShopTempInfoMsg.vIP6Count cannot be set twice.");
                  }
                  _loc41_++;
                  vIP6Count = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 24:
                  if(_loc3_ != 0)
                  {
                     throw new IOError("Bad data format: ShopTempInfoMsg.vIP7Count cannot be set twice.");
                  }
                  _loc3_++;
                  vIP7Count = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 25:
                  if(_loc39_ != 0)
                  {
                     throw new IOError("Bad data format: ShopTempInfoMsg.vIP8Count cannot be set twice.");
                  }
                  _loc39_++;
                  vIP8Count = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 26:
                  if(_loc19_ != 0)
                  {
                     throw new IOError("Bad data format: ShopTempInfoMsg.vIP9Count cannot be set twice.");
                  }
                  _loc19_++;
                  vIP9Count = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 27:
                  if(_loc24_ != 0)
                  {
                     throw new IOError("Bad data format: ShopTempInfoMsg.firstPrice cannot be set twice.");
                  }
                  _loc24_++;
                  firstPrice = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 28:
                  if(_loc8_ != 0)
                  {
                     throw new IOError("Bad data format: ShopTempInfoMsg.discount cannot be set twice.");
                  }
                  _loc8_++;
                  discount = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 29:
                  if(_loc31_ != 0)
                  {
                     throw new IOError("Bad data format: ShopTempInfoMsg.price cannot be set twice.");
                  }
                  _loc31_++;
                  price = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 30:
                  if(_loc14_ != 0)
                  {
                     throw new IOError("Bad data format: ShopTempInfoMsg.sort cannot be set twice.");
                  }
                  _loc14_++;
                  sort = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 31:
                  if(_loc46_ != 0)
                  {
                     throw new IOError("Bad data format: ShopTempInfoMsg.isHot cannot be set twice.");
                  }
                  _loc46_++;
                  isHot = ReadUtils.read$TYPE_BOOL(param1);
                  break;
               case 32:
                  if(_loc25_ != 0)
                  {
                     throw new IOError("Bad data format: ShopTempInfoMsg.labels cannot be set twice.");
                  }
                  _loc25_++;
                  labels = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 33:
                  if(_loc9_ != 0)
                  {
                     throw new IOError("Bad data format: ShopTempInfoMsg.needGeste cannot be set twice.");
                  }
                  _loc9_++;
                  needGeste = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 34:
                  if(_loc47_ != 0)
                  {
                     throw new IOError("Bad data format: ShopTempInfoMsg.validDate cannot be set twice.");
                  }
                  _loc47_++;
                  validDate = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 35:
                  if(_loc15_ != 0)
                  {
                     throw new IOError("Bad data format: ShopTempInfoMsg.rands cannot be set twice.");
                  }
                  _loc15_++;
                  rands = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 36:
                  if(_loc12_ != 0)
                  {
                     throw new IOError("Bad data format: ShopTempInfoMsg.needScore cannot be set twice.");
                  }
                  _loc12_++;
                  needScore = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 37:
                  if(_loc32_ != 0)
                  {
                     throw new IOError("Bad data format: ShopTempInfoMsg.needMinGrade cannot be set twice.");
                  }
                  _loc32_++;
                  needMinGrade = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 38:
                  if(_loc44_ != 0)
                  {
                     throw new IOError("Bad data format: ShopTempInfoMsg.needMaxGrade cannot be set twice.");
                  }
                  _loc44_++;
                  needMaxGrade = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 39:
                  if(_loc17_ != 0)
                  {
                     throw new IOError("Bad data format: ShopTempInfoMsg.isNeedPoint cannot be set twice.");
                  }
                  _loc17_++;
                  isNeedPoint = ReadUtils.read$TYPE_BOOL(param1);
                  break;
               case 40:
                  if(_loc33_ != 0)
                  {
                     throw new IOError("Bad data format: ShopTempInfoMsg.lordsScore cannot be set twice.");
                  }
                  _loc33_++;
                  lordsScore = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 41:
                  if(_loc28_ != 0)
                  {
                     throw new IOError("Bad data format: ShopTempInfoMsg.needItem cannot be set twice.");
                  }
                  _loc28_++;
                  needItem = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 42:
                  if(_loc20_ != 0)
                  {
                     throw new IOError("Bad data format: ShopTempInfoMsg.mineScore cannot be set twice.");
                  }
                  _loc20_++;
                  mineScore = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 43:
                  if(_loc16_ != 0)
                  {
                     throw new IOError("Bad data format: ShopTempInfoMsg.crossGuildScore cannot be set twice.");
                  }
                  _loc16_++;
                  crossGuildScore = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 44:
                  if(_loc30_ != 0)
                  {
                     throw new IOError("Bad data format: ShopTempInfoMsg.leagueMedal cannot be set twice.");
                  }
                  _loc30_++;
                  leagueMedal = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 45:
                  if(_loc21_ != 0)
                  {
                     throw new IOError("Bad data format: ShopTempInfoMsg.pokerScore cannot be set twice.");
                  }
                  _loc21_++;
                  pokerScore = ReadUtils.read$TYPE_INT32(param1);
                  break;
               default:
                  ReadUtils.skip(param1,_loc22_ & 7);
            }
         }
      }
   }
}

