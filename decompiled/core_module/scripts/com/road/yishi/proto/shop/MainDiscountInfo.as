package com.road.yishi.proto.shop
{
   import com.netease.protobuf.Message;
   import com.netease.protobuf.ReadUtils;
   import com.netease.protobuf.WriteUtils;
   import com.netease.protobuf.WritingBuffer;
   import flash.errors.IOError;
   import flash.utils.IDataInput;
   import flash.utils.IExternalizable;
   
   public final class MainDiscountInfo extends Message implements IExternalizable
   {
      
      private var id$field:int;
      
      private var hasField$0:uint = 0;
      
      private var site$field:int;
      
      private var shopId$field:int;
      
      private var templateId$field:int;
      
      private var counts$field:int;
      
      private var shopId1$field:int;
      
      private var templateId1$field:int;
      
      private var count1$field:int;
      
      private var shopId2$field:int;
      
      private var templateId2$field:int;
      
      private var count2$field:int;
      
      private var shopId3$field:int;
      
      private var templateId3$field:int;
      
      private var count3$field:int;
      
      private var shopId4$field:int;
      
      private var templateId4$field:int;
      
      private var count4$field:int;
      
      private var shopId5$field:int;
      
      private var templateId5$field:int;
      
      private var count5$field:int;
      
      private var shopId6$field:int;
      
      private var templateId6$field:int;
      
      private var count6$field:int;
      
      private var shopId7$field:int;
      
      private var templateId7$field:int;
      
      private var count7$field:int;
      
      private var shopId8$field:int;
      
      private var templateId8$field:int;
      
      private var count8$field:int;
      
      private var sortId$field:int;
      
      private var discount$field:int;
      
      private var beginDate$field:String;
      
      private var endDate$field:String;
      
      private var oneDayCount$field:int;
      
      private var maxCount$field:int;
      
      private var hasField$1:uint = 0;
      
      private var currentCount$field:int;
      
      private var maxCurrentDate$field:String;
      
      private var isGift$field:Boolean;
      
      private var url$field:String;
      
      private var names$field:String;
      
      private var price$field:int;
      
      private var type$field:int;
      
      private var limitCount$field:int;
      
      private var vip$field:int;
      
      private var level1$field:int;
      
      private var price1$field:int;
      
      private var level2$field:int;
      
      private var price2$field:int;
      
      private var level3$field:int;
      
      private var price3$field:int;
      
      private var sendDate$field:String;
      
      private var refreshInterval$field:int;
      
      private var frontMoney$field:int;
      
      public function MainDiscountInfo()
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
      
      public function removeSite() : void
      {
         hasField$0 &= 4294967293;
         site$field = new int();
      }
      
      public function get hasSite() : Boolean
      {
         return (hasField$0 & 2) != 0;
      }
      
      public function set site(param1:int) : void
      {
         hasField$0 |= 2;
         site$field = param1;
      }
      
      public function get site() : int
      {
         return site$field;
      }
      
      public function removeShopId() : void
      {
         hasField$0 &= 4294967291;
         shopId$field = new int();
      }
      
      public function get hasShopId() : Boolean
      {
         return (hasField$0 & 4) != 0;
      }
      
      public function set shopId(param1:int) : void
      {
         hasField$0 |= 4;
         shopId$field = param1;
      }
      
      public function get shopId() : int
      {
         return shopId$field;
      }
      
      public function removeTemplateId() : void
      {
         hasField$0 &= 4294967287;
         templateId$field = new int();
      }
      
      public function get hasTemplateId() : Boolean
      {
         return (hasField$0 & 8) != 0;
      }
      
      public function set templateId(param1:int) : void
      {
         hasField$0 |= 8;
         templateId$field = param1;
      }
      
      public function get templateId() : int
      {
         return templateId$field;
      }
      
      public function removeCounts() : void
      {
         hasField$0 &= 4294967279;
         counts$field = new int();
      }
      
      public function get hasCounts() : Boolean
      {
         return (hasField$0 & 0x10) != 0;
      }
      
      public function set counts(param1:int) : void
      {
         hasField$0 |= 16;
         counts$field = param1;
      }
      
      public function get counts() : int
      {
         return counts$field;
      }
      
      public function removeShopId1() : void
      {
         hasField$0 &= 4294967263;
         shopId1$field = new int();
      }
      
      public function get hasShopId1() : Boolean
      {
         return (hasField$0 & 0x20) != 0;
      }
      
      public function set shopId1(param1:int) : void
      {
         hasField$0 |= 32;
         shopId1$field = param1;
      }
      
      public function get shopId1() : int
      {
         return shopId1$field;
      }
      
      public function removeTemplateId1() : void
      {
         hasField$0 &= 4294967231;
         templateId1$field = new int();
      }
      
      public function get hasTemplateId1() : Boolean
      {
         return (hasField$0 & 0x40) != 0;
      }
      
      public function set templateId1(param1:int) : void
      {
         hasField$0 |= 64;
         templateId1$field = param1;
      }
      
      public function get templateId1() : int
      {
         return templateId1$field;
      }
      
      public function removeCount1() : void
      {
         hasField$0 &= 4294967167;
         count1$field = new int();
      }
      
      public function get hasCount1() : Boolean
      {
         return (hasField$0 & 0x80) != 0;
      }
      
      public function set count1(param1:int) : void
      {
         hasField$0 |= 128;
         count1$field = param1;
      }
      
      public function get count1() : int
      {
         return count1$field;
      }
      
      public function removeShopId2() : void
      {
         hasField$0 &= 4294967039;
         shopId2$field = new int();
      }
      
      public function get hasShopId2() : Boolean
      {
         return (hasField$0 & 0x0100) != 0;
      }
      
      public function set shopId2(param1:int) : void
      {
         hasField$0 |= 256;
         shopId2$field = param1;
      }
      
      public function get shopId2() : int
      {
         return shopId2$field;
      }
      
      public function removeTemplateId2() : void
      {
         hasField$0 &= 4294966783;
         templateId2$field = new int();
      }
      
      public function get hasTemplateId2() : Boolean
      {
         return (hasField$0 & 0x0200) != 0;
      }
      
      public function set templateId2(param1:int) : void
      {
         hasField$0 |= 512;
         templateId2$field = param1;
      }
      
      public function get templateId2() : int
      {
         return templateId2$field;
      }
      
      public function removeCount2() : void
      {
         hasField$0 &= 4294966271;
         count2$field = new int();
      }
      
      public function get hasCount2() : Boolean
      {
         return (hasField$0 & 0x0400) != 0;
      }
      
      public function set count2(param1:int) : void
      {
         hasField$0 |= 1024;
         count2$field = param1;
      }
      
      public function get count2() : int
      {
         return count2$field;
      }
      
      public function removeShopId3() : void
      {
         hasField$0 &= 4294965247;
         shopId3$field = new int();
      }
      
      public function get hasShopId3() : Boolean
      {
         return (hasField$0 & 0x0800) != 0;
      }
      
      public function set shopId3(param1:int) : void
      {
         hasField$0 |= 2048;
         shopId3$field = param1;
      }
      
      public function get shopId3() : int
      {
         return shopId3$field;
      }
      
      public function removeTemplateId3() : void
      {
         hasField$0 &= 4294963199;
         templateId3$field = new int();
      }
      
      public function get hasTemplateId3() : Boolean
      {
         return (hasField$0 & 0x1000) != 0;
      }
      
      public function set templateId3(param1:int) : void
      {
         hasField$0 |= 4096;
         templateId3$field = param1;
      }
      
      public function get templateId3() : int
      {
         return templateId3$field;
      }
      
      public function removeCount3() : void
      {
         hasField$0 &= 4294959103;
         count3$field = new int();
      }
      
      public function get hasCount3() : Boolean
      {
         return (hasField$0 & 0x2000) != 0;
      }
      
      public function set count3(param1:int) : void
      {
         hasField$0 |= 8192;
         count3$field = param1;
      }
      
      public function get count3() : int
      {
         return count3$field;
      }
      
      public function removeShopId4() : void
      {
         hasField$0 &= 4294950911;
         shopId4$field = new int();
      }
      
      public function get hasShopId4() : Boolean
      {
         return (hasField$0 & 0x4000) != 0;
      }
      
      public function set shopId4(param1:int) : void
      {
         hasField$0 |= 16384;
         shopId4$field = param1;
      }
      
      public function get shopId4() : int
      {
         return shopId4$field;
      }
      
      public function removeTemplateId4() : void
      {
         hasField$0 &= 4294934527;
         templateId4$field = new int();
      }
      
      public function get hasTemplateId4() : Boolean
      {
         return (hasField$0 & 0x8000) != 0;
      }
      
      public function set templateId4(param1:int) : void
      {
         hasField$0 |= 32768;
         templateId4$field = param1;
      }
      
      public function get templateId4() : int
      {
         return templateId4$field;
      }
      
      public function removeCount4() : void
      {
         hasField$0 &= 4294901759;
         count4$field = new int();
      }
      
      public function get hasCount4() : Boolean
      {
         return (hasField$0 & 0x010000) != 0;
      }
      
      public function set count4(param1:int) : void
      {
         hasField$0 |= 65536;
         count4$field = param1;
      }
      
      public function get count4() : int
      {
         return count4$field;
      }
      
      public function removeShopId5() : void
      {
         hasField$0 &= 4294836223;
         shopId5$field = new int();
      }
      
      public function get hasShopId5() : Boolean
      {
         return (hasField$0 & 0x020000) != 0;
      }
      
      public function set shopId5(param1:int) : void
      {
         hasField$0 |= 131072;
         shopId5$field = param1;
      }
      
      public function get shopId5() : int
      {
         return shopId5$field;
      }
      
      public function removeTemplateId5() : void
      {
         hasField$0 &= 4294705151;
         templateId5$field = new int();
      }
      
      public function get hasTemplateId5() : Boolean
      {
         return (hasField$0 & 0x040000) != 0;
      }
      
      public function set templateId5(param1:int) : void
      {
         hasField$0 |= 262144;
         templateId5$field = param1;
      }
      
      public function get templateId5() : int
      {
         return templateId5$field;
      }
      
      public function removeCount5() : void
      {
         hasField$0 &= 4294443007;
         count5$field = new int();
      }
      
      public function get hasCount5() : Boolean
      {
         return (hasField$0 & 0x080000) != 0;
      }
      
      public function set count5(param1:int) : void
      {
         hasField$0 |= 524288;
         count5$field = param1;
      }
      
      public function get count5() : int
      {
         return count5$field;
      }
      
      public function removeShopId6() : void
      {
         hasField$0 &= 4293918719;
         shopId6$field = new int();
      }
      
      public function get hasShopId6() : Boolean
      {
         return (hasField$0 & 0x100000) != 0;
      }
      
      public function set shopId6(param1:int) : void
      {
         hasField$0 |= 1048576;
         shopId6$field = param1;
      }
      
      public function get shopId6() : int
      {
         return shopId6$field;
      }
      
      public function removeTemplateId6() : void
      {
         hasField$0 &= 4292870143;
         templateId6$field = new int();
      }
      
      public function get hasTemplateId6() : Boolean
      {
         return (hasField$0 & 0x200000) != 0;
      }
      
      public function set templateId6(param1:int) : void
      {
         hasField$0 |= 2097152;
         templateId6$field = param1;
      }
      
      public function get templateId6() : int
      {
         return templateId6$field;
      }
      
      public function removeCount6() : void
      {
         hasField$0 &= 4290772991;
         count6$field = new int();
      }
      
      public function get hasCount6() : Boolean
      {
         return (hasField$0 & 0x400000) != 0;
      }
      
      public function set count6(param1:int) : void
      {
         hasField$0 |= 4194304;
         count6$field = param1;
      }
      
      public function get count6() : int
      {
         return count6$field;
      }
      
      public function removeShopId7() : void
      {
         hasField$0 &= 4286578687;
         shopId7$field = new int();
      }
      
      public function get hasShopId7() : Boolean
      {
         return (hasField$0 & 0x800000) != 0;
      }
      
      public function set shopId7(param1:int) : void
      {
         hasField$0 |= 8388608;
         shopId7$field = param1;
      }
      
      public function get shopId7() : int
      {
         return shopId7$field;
      }
      
      public function removeTemplateId7() : void
      {
         hasField$0 &= 4278190079;
         templateId7$field = new int();
      }
      
      public function get hasTemplateId7() : Boolean
      {
         return (hasField$0 & 0x01000000) != 0;
      }
      
      public function set templateId7(param1:int) : void
      {
         hasField$0 |= 16777216;
         templateId7$field = param1;
      }
      
      public function get templateId7() : int
      {
         return templateId7$field;
      }
      
      public function removeCount7() : void
      {
         hasField$0 &= 4261412863;
         count7$field = new int();
      }
      
      public function get hasCount7() : Boolean
      {
         return (hasField$0 & 0x02000000) != 0;
      }
      
      public function set count7(param1:int) : void
      {
         hasField$0 |= 33554432;
         count7$field = param1;
      }
      
      public function get count7() : int
      {
         return count7$field;
      }
      
      public function removeShopId8() : void
      {
         hasField$0 &= 4227858431;
         shopId8$field = new int();
      }
      
      public function get hasShopId8() : Boolean
      {
         return (hasField$0 & 0x04000000) != 0;
      }
      
      public function set shopId8(param1:int) : void
      {
         hasField$0 |= 67108864;
         shopId8$field = param1;
      }
      
      public function get shopId8() : int
      {
         return shopId8$field;
      }
      
      public function removeTemplateId8() : void
      {
         hasField$0 &= 4160749567;
         templateId8$field = new int();
      }
      
      public function get hasTemplateId8() : Boolean
      {
         return (hasField$0 & 0x08000000) != 0;
      }
      
      public function set templateId8(param1:int) : void
      {
         hasField$0 |= 134217728;
         templateId8$field = param1;
      }
      
      public function get templateId8() : int
      {
         return templateId8$field;
      }
      
      public function removeCount8() : void
      {
         hasField$0 &= 4026531839;
         count8$field = new int();
      }
      
      public function get hasCount8() : Boolean
      {
         return (hasField$0 & 0x10000000) != 0;
      }
      
      public function set count8(param1:int) : void
      {
         hasField$0 |= 268435456;
         count8$field = param1;
      }
      
      public function get count8() : int
      {
         return count8$field;
      }
      
      public function removeSortId() : void
      {
         hasField$0 &= 3758096383;
         sortId$field = new int();
      }
      
      public function get hasSortId() : Boolean
      {
         return (hasField$0 & 0x20000000) != 0;
      }
      
      public function set sortId(param1:int) : void
      {
         hasField$0 |= 536870912;
         sortId$field = param1;
      }
      
      public function get sortId() : int
      {
         return sortId$field;
      }
      
      public function removeDiscount() : void
      {
         hasField$0 &= 3221225471;
         discount$field = new int();
      }
      
      public function get hasDiscount() : Boolean
      {
         return (hasField$0 & 0x40000000) != 0;
      }
      
      public function set discount(param1:int) : void
      {
         hasField$0 |= 1073741824;
         discount$field = param1;
      }
      
      public function get discount() : int
      {
         return discount$field;
      }
      
      public function removeBeginDate() : void
      {
         beginDate$field = null;
      }
      
      public function get hasBeginDate() : Boolean
      {
         return beginDate$field != null;
      }
      
      public function set beginDate(param1:String) : void
      {
         beginDate$field = param1;
      }
      
      public function get beginDate() : String
      {
         return beginDate$field;
      }
      
      public function removeEndDate() : void
      {
         endDate$field = null;
      }
      
      public function get hasEndDate() : Boolean
      {
         return endDate$field != null;
      }
      
      public function set endDate(param1:String) : void
      {
         endDate$field = param1;
      }
      
      public function get endDate() : String
      {
         return endDate$field;
      }
      
      public function removeOneDayCount() : void
      {
         hasField$0 &= 2147483647;
         oneDayCount$field = new int();
      }
      
      public function get hasOneDayCount() : Boolean
      {
         return (hasField$0 & 0x80000000) != 0;
      }
      
      public function set oneDayCount(param1:int) : void
      {
         hasField$0 |= 2147483648;
         oneDayCount$field = param1;
      }
      
      public function get oneDayCount() : int
      {
         return oneDayCount$field;
      }
      
      public function removeMaxCount() : void
      {
         hasField$1 &= 4294967294;
         maxCount$field = new int();
      }
      
      public function get hasMaxCount() : Boolean
      {
         return (hasField$1 & 1) != 0;
      }
      
      public function set maxCount(param1:int) : void
      {
         hasField$1 |= 1;
         maxCount$field = param1;
      }
      
      public function get maxCount() : int
      {
         return maxCount$field;
      }
      
      public function removeCurrentCount() : void
      {
         hasField$1 &= 4294967293;
         currentCount$field = new int();
      }
      
      public function get hasCurrentCount() : Boolean
      {
         return (hasField$1 & 2) != 0;
      }
      
      public function set currentCount(param1:int) : void
      {
         hasField$1 |= 2;
         currentCount$field = param1;
      }
      
      public function get currentCount() : int
      {
         return currentCount$field;
      }
      
      public function removeMaxCurrentDate() : void
      {
         maxCurrentDate$field = null;
      }
      
      public function get hasMaxCurrentDate() : Boolean
      {
         return maxCurrentDate$field != null;
      }
      
      public function set maxCurrentDate(param1:String) : void
      {
         maxCurrentDate$field = param1;
      }
      
      public function get maxCurrentDate() : String
      {
         return maxCurrentDate$field;
      }
      
      public function removeIsGift() : void
      {
         hasField$1 &= 4294967291;
         isGift$field = new Boolean();
      }
      
      public function get hasIsGift() : Boolean
      {
         return (hasField$1 & 4) != 0;
      }
      
      public function set isGift(param1:Boolean) : void
      {
         hasField$1 |= 4;
         isGift$field = param1;
      }
      
      public function get isGift() : Boolean
      {
         return isGift$field;
      }
      
      public function removeUrl() : void
      {
         url$field = null;
      }
      
      public function get hasUrl() : Boolean
      {
         return url$field != null;
      }
      
      public function set url(param1:String) : void
      {
         url$field = param1;
      }
      
      public function get url() : String
      {
         return url$field;
      }
      
      public function removeNames() : void
      {
         names$field = null;
      }
      
      public function get hasNames() : Boolean
      {
         return names$field != null;
      }
      
      public function set names(param1:String) : void
      {
         names$field = param1;
      }
      
      public function get names() : String
      {
         return names$field;
      }
      
      public function removePrice() : void
      {
         hasField$1 &= 4294967287;
         price$field = new int();
      }
      
      public function get hasPrice() : Boolean
      {
         return (hasField$1 & 8) != 0;
      }
      
      public function set price(param1:int) : void
      {
         hasField$1 |= 8;
         price$field = param1;
      }
      
      public function get price() : int
      {
         return price$field;
      }
      
      public function removeType() : void
      {
         hasField$1 &= 4294967279;
         type$field = new int();
      }
      
      public function get hasType() : Boolean
      {
         return (hasField$1 & 0x10) != 0;
      }
      
      public function set type(param1:int) : void
      {
         hasField$1 |= 16;
         type$field = param1;
      }
      
      public function get type() : int
      {
         return type$field;
      }
      
      public function removeLimitCount() : void
      {
         hasField$1 &= 4294967263;
         limitCount$field = new int();
      }
      
      public function get hasLimitCount() : Boolean
      {
         return (hasField$1 & 0x20) != 0;
      }
      
      public function set limitCount(param1:int) : void
      {
         hasField$1 |= 32;
         limitCount$field = param1;
      }
      
      public function get limitCount() : int
      {
         return limitCount$field;
      }
      
      public function removeVip() : void
      {
         hasField$1 &= 4294967231;
         vip$field = new int();
      }
      
      public function get hasVip() : Boolean
      {
         return (hasField$1 & 0x40) != 0;
      }
      
      public function set vip(param1:int) : void
      {
         hasField$1 |= 64;
         vip$field = param1;
      }
      
      public function get vip() : int
      {
         return vip$field;
      }
      
      public function removeLevel1() : void
      {
         hasField$1 &= 4294967167;
         level1$field = new int();
      }
      
      public function get hasLevel1() : Boolean
      {
         return (hasField$1 & 0x80) != 0;
      }
      
      public function set level1(param1:int) : void
      {
         hasField$1 |= 128;
         level1$field = param1;
      }
      
      public function get level1() : int
      {
         return level1$field;
      }
      
      public function removePrice1() : void
      {
         hasField$1 &= 4294967039;
         price1$field = new int();
      }
      
      public function get hasPrice1() : Boolean
      {
         return (hasField$1 & 0x0100) != 0;
      }
      
      public function set price1(param1:int) : void
      {
         hasField$1 |= 256;
         price1$field = param1;
      }
      
      public function get price1() : int
      {
         return price1$field;
      }
      
      public function removeLevel2() : void
      {
         hasField$1 &= 4294966783;
         level2$field = new int();
      }
      
      public function get hasLevel2() : Boolean
      {
         return (hasField$1 & 0x0200) != 0;
      }
      
      public function set level2(param1:int) : void
      {
         hasField$1 |= 512;
         level2$field = param1;
      }
      
      public function get level2() : int
      {
         return level2$field;
      }
      
      public function removePrice2() : void
      {
         hasField$1 &= 4294966271;
         price2$field = new int();
      }
      
      public function get hasPrice2() : Boolean
      {
         return (hasField$1 & 0x0400) != 0;
      }
      
      public function set price2(param1:int) : void
      {
         hasField$1 |= 1024;
         price2$field = param1;
      }
      
      public function get price2() : int
      {
         return price2$field;
      }
      
      public function removeLevel3() : void
      {
         hasField$1 &= 4294965247;
         level3$field = new int();
      }
      
      public function get hasLevel3() : Boolean
      {
         return (hasField$1 & 0x0800) != 0;
      }
      
      public function set level3(param1:int) : void
      {
         hasField$1 |= 2048;
         level3$field = param1;
      }
      
      public function get level3() : int
      {
         return level3$field;
      }
      
      public function removePrice3() : void
      {
         hasField$1 &= 4294963199;
         price3$field = new int();
      }
      
      public function get hasPrice3() : Boolean
      {
         return (hasField$1 & 0x1000) != 0;
      }
      
      public function set price3(param1:int) : void
      {
         hasField$1 |= 4096;
         price3$field = param1;
      }
      
      public function get price3() : int
      {
         return price3$field;
      }
      
      public function removeSendDate() : void
      {
         sendDate$field = null;
      }
      
      public function get hasSendDate() : Boolean
      {
         return sendDate$field != null;
      }
      
      public function set sendDate(param1:String) : void
      {
         sendDate$field = param1;
      }
      
      public function get sendDate() : String
      {
         return sendDate$field;
      }
      
      public function removeRefreshInterval() : void
      {
         hasField$1 &= 4294959103;
         refreshInterval$field = new int();
      }
      
      public function get hasRefreshInterval() : Boolean
      {
         return (hasField$1 & 0x2000) != 0;
      }
      
      public function set refreshInterval(param1:int) : void
      {
         hasField$1 |= 8192;
         refreshInterval$field = param1;
      }
      
      public function get refreshInterval() : int
      {
         return refreshInterval$field;
      }
      
      public function removeFrontMoney() : void
      {
         hasField$1 &= 4294950911;
         frontMoney$field = new int();
      }
      
      public function get hasFrontMoney() : Boolean
      {
         return (hasField$1 & 0x4000) != 0;
      }
      
      public function set frontMoney(param1:int) : void
      {
         hasField$1 |= 16384;
         frontMoney$field = param1;
      }
      
      public function get frontMoney() : int
      {
         return frontMoney$field;
      }
      
      final override public function writeToBuffer(param1:WritingBuffer) : void
      {
         if(hasId)
         {
            WriteUtils.writeTag(param1,0,1);
            WriteUtils.write$TYPE_INT32(param1,id$field);
         }
         if(hasSite)
         {
            WriteUtils.writeTag(param1,0,2);
            WriteUtils.write$TYPE_INT32(param1,site$field);
         }
         if(hasShopId)
         {
            WriteUtils.writeTag(param1,0,3);
            WriteUtils.write$TYPE_INT32(param1,shopId$field);
         }
         if(hasTemplateId)
         {
            WriteUtils.writeTag(param1,0,4);
            WriteUtils.write$TYPE_INT32(param1,templateId$field);
         }
         if(hasCounts)
         {
            WriteUtils.writeTag(param1,0,5);
            WriteUtils.write$TYPE_INT32(param1,counts$field);
         }
         if(hasShopId1)
         {
            WriteUtils.writeTag(param1,0,6);
            WriteUtils.write$TYPE_INT32(param1,shopId1$field);
         }
         if(hasTemplateId1)
         {
            WriteUtils.writeTag(param1,0,7);
            WriteUtils.write$TYPE_INT32(param1,templateId1$field);
         }
         if(hasCount1)
         {
            WriteUtils.writeTag(param1,0,8);
            WriteUtils.write$TYPE_INT32(param1,count1$field);
         }
         if(hasShopId2)
         {
            WriteUtils.writeTag(param1,0,9);
            WriteUtils.write$TYPE_INT32(param1,shopId2$field);
         }
         if(hasTemplateId2)
         {
            WriteUtils.writeTag(param1,0,10);
            WriteUtils.write$TYPE_INT32(param1,templateId2$field);
         }
         if(hasCount2)
         {
            WriteUtils.writeTag(param1,0,11);
            WriteUtils.write$TYPE_INT32(param1,count2$field);
         }
         if(hasShopId3)
         {
            WriteUtils.writeTag(param1,0,12);
            WriteUtils.write$TYPE_INT32(param1,shopId3$field);
         }
         if(hasTemplateId3)
         {
            WriteUtils.writeTag(param1,0,13);
            WriteUtils.write$TYPE_INT32(param1,templateId3$field);
         }
         if(hasCount3)
         {
            WriteUtils.writeTag(param1,0,14);
            WriteUtils.write$TYPE_INT32(param1,count3$field);
         }
         if(hasShopId4)
         {
            WriteUtils.writeTag(param1,0,15);
            WriteUtils.write$TYPE_INT32(param1,shopId4$field);
         }
         if(hasTemplateId4)
         {
            WriteUtils.writeTag(param1,0,16);
            WriteUtils.write$TYPE_INT32(param1,templateId4$field);
         }
         if(hasCount4)
         {
            WriteUtils.writeTag(param1,0,17);
            WriteUtils.write$TYPE_INT32(param1,count4$field);
         }
         if(hasShopId5)
         {
            WriteUtils.writeTag(param1,0,18);
            WriteUtils.write$TYPE_INT32(param1,shopId5$field);
         }
         if(hasTemplateId5)
         {
            WriteUtils.writeTag(param1,0,19);
            WriteUtils.write$TYPE_INT32(param1,templateId5$field);
         }
         if(hasCount5)
         {
            WriteUtils.writeTag(param1,0,20);
            WriteUtils.write$TYPE_INT32(param1,count5$field);
         }
         if(hasShopId6)
         {
            WriteUtils.writeTag(param1,0,21);
            WriteUtils.write$TYPE_INT32(param1,shopId6$field);
         }
         if(hasTemplateId6)
         {
            WriteUtils.writeTag(param1,0,22);
            WriteUtils.write$TYPE_INT32(param1,templateId6$field);
         }
         if(hasCount6)
         {
            WriteUtils.writeTag(param1,0,23);
            WriteUtils.write$TYPE_INT32(param1,count6$field);
         }
         if(hasShopId7)
         {
            WriteUtils.writeTag(param1,0,24);
            WriteUtils.write$TYPE_INT32(param1,shopId7$field);
         }
         if(hasTemplateId7)
         {
            WriteUtils.writeTag(param1,0,25);
            WriteUtils.write$TYPE_INT32(param1,templateId7$field);
         }
         if(hasCount7)
         {
            WriteUtils.writeTag(param1,0,26);
            WriteUtils.write$TYPE_INT32(param1,count7$field);
         }
         if(hasShopId8)
         {
            WriteUtils.writeTag(param1,0,27);
            WriteUtils.write$TYPE_INT32(param1,shopId8$field);
         }
         if(hasTemplateId8)
         {
            WriteUtils.writeTag(param1,0,28);
            WriteUtils.write$TYPE_INT32(param1,templateId8$field);
         }
         if(hasCount8)
         {
            WriteUtils.writeTag(param1,0,29);
            WriteUtils.write$TYPE_INT32(param1,count8$field);
         }
         if(hasSortId)
         {
            WriteUtils.writeTag(param1,0,30);
            WriteUtils.write$TYPE_INT32(param1,sortId$field);
         }
         if(hasDiscount)
         {
            WriteUtils.writeTag(param1,0,31);
            WriteUtils.write$TYPE_INT32(param1,discount$field);
         }
         if(hasBeginDate)
         {
            WriteUtils.writeTag(param1,2,32);
            WriteUtils.write$TYPE_STRING(param1,beginDate$field);
         }
         if(hasEndDate)
         {
            WriteUtils.writeTag(param1,2,33);
            WriteUtils.write$TYPE_STRING(param1,endDate$field);
         }
         if(hasOneDayCount)
         {
            WriteUtils.writeTag(param1,0,34);
            WriteUtils.write$TYPE_INT32(param1,oneDayCount$field);
         }
         if(hasMaxCount)
         {
            WriteUtils.writeTag(param1,0,35);
            WriteUtils.write$TYPE_INT32(param1,maxCount$field);
         }
         if(hasCurrentCount)
         {
            WriteUtils.writeTag(param1,0,36);
            WriteUtils.write$TYPE_INT32(param1,currentCount$field);
         }
         if(hasMaxCurrentDate)
         {
            WriteUtils.writeTag(param1,2,37);
            WriteUtils.write$TYPE_STRING(param1,maxCurrentDate$field);
         }
         if(hasIsGift)
         {
            WriteUtils.writeTag(param1,0,38);
            WriteUtils.write$TYPE_BOOL(param1,isGift$field);
         }
         if(hasUrl)
         {
            WriteUtils.writeTag(param1,2,39);
            WriteUtils.write$TYPE_STRING(param1,url$field);
         }
         if(hasNames)
         {
            WriteUtils.writeTag(param1,2,40);
            WriteUtils.write$TYPE_STRING(param1,names$field);
         }
         if(hasPrice)
         {
            WriteUtils.writeTag(param1,0,41);
            WriteUtils.write$TYPE_INT32(param1,price$field);
         }
         if(hasType)
         {
            WriteUtils.writeTag(param1,0,42);
            WriteUtils.write$TYPE_INT32(param1,type$field);
         }
         if(hasLimitCount)
         {
            WriteUtils.writeTag(param1,0,43);
            WriteUtils.write$TYPE_INT32(param1,limitCount$field);
         }
         if(hasVip)
         {
            WriteUtils.writeTag(param1,0,44);
            WriteUtils.write$TYPE_INT32(param1,vip$field);
         }
         if(hasLevel1)
         {
            WriteUtils.writeTag(param1,0,45);
            WriteUtils.write$TYPE_INT32(param1,level1$field);
         }
         if(hasPrice1)
         {
            WriteUtils.writeTag(param1,0,46);
            WriteUtils.write$TYPE_INT32(param1,price1$field);
         }
         if(hasLevel2)
         {
            WriteUtils.writeTag(param1,0,47);
            WriteUtils.write$TYPE_INT32(param1,level2$field);
         }
         if(hasPrice2)
         {
            WriteUtils.writeTag(param1,0,48);
            WriteUtils.write$TYPE_INT32(param1,price2$field);
         }
         if(hasLevel3)
         {
            WriteUtils.writeTag(param1,0,49);
            WriteUtils.write$TYPE_INT32(param1,level3$field);
         }
         if(hasPrice3)
         {
            WriteUtils.writeTag(param1,0,50);
            WriteUtils.write$TYPE_INT32(param1,price3$field);
         }
         if(hasSendDate)
         {
            WriteUtils.writeTag(param1,2,51);
            WriteUtils.write$TYPE_STRING(param1,sendDate$field);
         }
         if(hasRefreshInterval)
         {
            WriteUtils.writeTag(param1,0,52);
            WriteUtils.write$TYPE_INT32(param1,refreshInterval$field);
         }
         if(hasFrontMoney)
         {
            WriteUtils.writeTag(param1,0,53);
            WriteUtils.write$TYPE_INT32(param1,frontMoney$field);
         }
      }
      
      final override public function readFromSlice(param1:IDataInput, param2:uint) : void
      {
         var _loc14_:* = 0;
         var _loc20_:uint = 0;
         var _loc50_:uint = 0;
         var _loc42_:uint = 0;
         var _loc43_:uint = 0;
         var _loc51_:uint = 0;
         var _loc53_:uint = 0;
         var _loc37_:uint = 0;
         var _loc45_:uint = 0;
         var _loc11_:uint = 0;
         var _loc54_:uint = 0;
         var _loc33_:uint = 0;
         var _loc28_:uint = 0;
         var _loc15_:uint = 0;
         var _loc32_:uint = 0;
         var _loc46_:uint = 0;
         var _loc29_:uint = 0;
         var _loc6_:uint = 0;
         var _loc3_:uint = 0;
         var _loc44_:uint = 0;
         var _loc47_:uint = 0;
         var _loc18_:uint = 0;
         var _loc5_:uint = 0;
         var _loc27_:uint = 0;
         var _loc34_:uint = 0;
         var _loc30_:uint = 0;
         var _loc13_:uint = 0;
         var _loc48_:uint = 0;
         var _loc40_:uint = 0;
         var _loc55_:uint = 0;
         var _loc49_:uint = 0;
         var _loc7_:uint = 0;
         var _loc16_:uint = 0;
         var _loc12_:uint = 0;
         var _loc8_:uint = 0;
         var _loc35_:uint = 0;
         var _loc22_:uint = 0;
         var _loc10_:uint = 0;
         var _loc36_:uint = 0;
         var _loc41_:uint = 0;
         var _loc21_:uint = 0;
         var _loc23_:uint = 0;
         var _loc26_:uint = 0;
         var _loc25_:uint = 0;
         var _loc56_:uint = 0;
         var _loc52_:uint = 0;
         var _loc39_:uint = 0;
         var _loc9_:uint = 0;
         var _loc31_:uint = 0;
         var _loc19_:uint = 0;
         var _loc4_:uint = 0;
         var _loc17_:uint = 0;
         var _loc24_:uint = 0;
         var _loc38_:uint = 0;
         while(param1.bytesAvailable > param2)
         {
            switch((_loc14_ = ReadUtils.read$TYPE_UINT32(param1)) >>> 3)
            {
               case 1:
                  if(_loc20_ != 0)
                  {
                     throw new IOError("Bad data format: MainDiscountInfo.id cannot be set twice.");
                  }
                  _loc20_++;
                  id = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 2:
                  if(_loc50_ != 0)
                  {
                     throw new IOError("Bad data format: MainDiscountInfo.site cannot be set twice.");
                  }
                  _loc50_++;
                  site = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 3:
                  if(_loc42_ != 0)
                  {
                     throw new IOError("Bad data format: MainDiscountInfo.shopId cannot be set twice.");
                  }
                  _loc42_++;
                  shopId = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 4:
                  if(_loc43_ != 0)
                  {
                     throw new IOError("Bad data format: MainDiscountInfo.templateId cannot be set twice.");
                  }
                  _loc43_++;
                  templateId = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 5:
                  if(_loc51_ != 0)
                  {
                     throw new IOError("Bad data format: MainDiscountInfo.counts cannot be set twice.");
                  }
                  _loc51_++;
                  counts = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 6:
                  if(_loc53_ != 0)
                  {
                     throw new IOError("Bad data format: MainDiscountInfo.shopId1 cannot be set twice.");
                  }
                  _loc53_++;
                  shopId1 = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 7:
                  if(_loc37_ != 0)
                  {
                     throw new IOError("Bad data format: MainDiscountInfo.templateId1 cannot be set twice.");
                  }
                  _loc37_++;
                  templateId1 = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 8:
                  if(_loc45_ != 0)
                  {
                     throw new IOError("Bad data format: MainDiscountInfo.count1 cannot be set twice.");
                  }
                  _loc45_++;
                  count1 = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 9:
                  if(_loc11_ != 0)
                  {
                     throw new IOError("Bad data format: MainDiscountInfo.shopId2 cannot be set twice.");
                  }
                  _loc11_++;
                  shopId2 = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 10:
                  if(_loc54_ != 0)
                  {
                     throw new IOError("Bad data format: MainDiscountInfo.templateId2 cannot be set twice.");
                  }
                  _loc54_++;
                  templateId2 = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 11:
                  if(_loc33_ != 0)
                  {
                     throw new IOError("Bad data format: MainDiscountInfo.count2 cannot be set twice.");
                  }
                  _loc33_++;
                  count2 = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 12:
                  if(_loc28_ != 0)
                  {
                     throw new IOError("Bad data format: MainDiscountInfo.shopId3 cannot be set twice.");
                  }
                  _loc28_++;
                  shopId3 = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 13:
                  if(_loc15_ != 0)
                  {
                     throw new IOError("Bad data format: MainDiscountInfo.templateId3 cannot be set twice.");
                  }
                  _loc15_++;
                  templateId3 = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 14:
                  if(_loc32_ != 0)
                  {
                     throw new IOError("Bad data format: MainDiscountInfo.count3 cannot be set twice.");
                  }
                  _loc32_++;
                  count3 = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 15:
                  if(_loc46_ != 0)
                  {
                     throw new IOError("Bad data format: MainDiscountInfo.shopId4 cannot be set twice.");
                  }
                  _loc46_++;
                  shopId4 = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 16:
                  if(_loc29_ != 0)
                  {
                     throw new IOError("Bad data format: MainDiscountInfo.templateId4 cannot be set twice.");
                  }
                  _loc29_++;
                  templateId4 = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 17:
                  if(_loc6_ != 0)
                  {
                     throw new IOError("Bad data format: MainDiscountInfo.count4 cannot be set twice.");
                  }
                  _loc6_++;
                  count4 = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 18:
                  if(_loc3_ != 0)
                  {
                     throw new IOError("Bad data format: MainDiscountInfo.shopId5 cannot be set twice.");
                  }
                  _loc3_++;
                  shopId5 = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 19:
                  if(_loc44_ != 0)
                  {
                     throw new IOError("Bad data format: MainDiscountInfo.templateId5 cannot be set twice.");
                  }
                  _loc44_++;
                  templateId5 = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 20:
                  if(_loc47_ != 0)
                  {
                     throw new IOError("Bad data format: MainDiscountInfo.count5 cannot be set twice.");
                  }
                  _loc47_++;
                  count5 = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 21:
                  if(_loc18_ != 0)
                  {
                     throw new IOError("Bad data format: MainDiscountInfo.shopId6 cannot be set twice.");
                  }
                  _loc18_++;
                  shopId6 = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 22:
                  if(_loc5_ != 0)
                  {
                     throw new IOError("Bad data format: MainDiscountInfo.templateId6 cannot be set twice.");
                  }
                  _loc5_++;
                  templateId6 = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 23:
                  if(_loc27_ != 0)
                  {
                     throw new IOError("Bad data format: MainDiscountInfo.count6 cannot be set twice.");
                  }
                  _loc27_++;
                  count6 = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 24:
                  if(_loc34_ != 0)
                  {
                     throw new IOError("Bad data format: MainDiscountInfo.shopId7 cannot be set twice.");
                  }
                  _loc34_++;
                  shopId7 = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 25:
                  if(_loc30_ != 0)
                  {
                     throw new IOError("Bad data format: MainDiscountInfo.templateId7 cannot be set twice.");
                  }
                  _loc30_++;
                  templateId7 = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 26:
                  if(_loc13_ != 0)
                  {
                     throw new IOError("Bad data format: MainDiscountInfo.count7 cannot be set twice.");
                  }
                  _loc13_++;
                  count7 = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 27:
                  if(_loc48_ != 0)
                  {
                     throw new IOError("Bad data format: MainDiscountInfo.shopId8 cannot be set twice.");
                  }
                  _loc48_++;
                  shopId8 = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 28:
                  if(_loc40_ != 0)
                  {
                     throw new IOError("Bad data format: MainDiscountInfo.templateId8 cannot be set twice.");
                  }
                  _loc40_++;
                  templateId8 = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 29:
                  if(_loc55_ != 0)
                  {
                     throw new IOError("Bad data format: MainDiscountInfo.count8 cannot be set twice.");
                  }
                  _loc55_++;
                  count8 = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 30:
                  if(_loc49_ != 0)
                  {
                     throw new IOError("Bad data format: MainDiscountInfo.sortId cannot be set twice.");
                  }
                  _loc49_++;
                  sortId = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 31:
                  if(_loc7_ != 0)
                  {
                     throw new IOError("Bad data format: MainDiscountInfo.discount cannot be set twice.");
                  }
                  _loc7_++;
                  discount = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 32:
                  if(_loc16_ != 0)
                  {
                     throw new IOError("Bad data format: MainDiscountInfo.beginDate cannot be set twice.");
                  }
                  _loc16_++;
                  beginDate = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 33:
                  if(_loc12_ != 0)
                  {
                     throw new IOError("Bad data format: MainDiscountInfo.endDate cannot be set twice.");
                  }
                  _loc12_++;
                  endDate = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 34:
                  if(_loc8_ != 0)
                  {
                     throw new IOError("Bad data format: MainDiscountInfo.oneDayCount cannot be set twice.");
                  }
                  _loc8_++;
                  oneDayCount = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 35:
                  if(_loc35_ != 0)
                  {
                     throw new IOError("Bad data format: MainDiscountInfo.maxCount cannot be set twice.");
                  }
                  _loc35_++;
                  maxCount = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 36:
                  if(_loc22_ != 0)
                  {
                     throw new IOError("Bad data format: MainDiscountInfo.currentCount cannot be set twice.");
                  }
                  _loc22_++;
                  currentCount = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 37:
                  if(_loc10_ != 0)
                  {
                     throw new IOError("Bad data format: MainDiscountInfo.maxCurrentDate cannot be set twice.");
                  }
                  _loc10_++;
                  maxCurrentDate = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 38:
                  if(_loc36_ != 0)
                  {
                     throw new IOError("Bad data format: MainDiscountInfo.isGift cannot be set twice.");
                  }
                  _loc36_++;
                  isGift = ReadUtils.read$TYPE_BOOL(param1);
                  break;
               case 39:
                  if(_loc41_ != 0)
                  {
                     throw new IOError("Bad data format: MainDiscountInfo.url cannot be set twice.");
                  }
                  _loc41_++;
                  url = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 40:
                  if(_loc21_ != 0)
                  {
                     throw new IOError("Bad data format: MainDiscountInfo.names cannot be set twice.");
                  }
                  _loc21_++;
                  names = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 41:
                  if(_loc23_ != 0)
                  {
                     throw new IOError("Bad data format: MainDiscountInfo.price cannot be set twice.");
                  }
                  _loc23_++;
                  price = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 42:
                  if(_loc26_ != 0)
                  {
                     throw new IOError("Bad data format: MainDiscountInfo.type cannot be set twice.");
                  }
                  _loc26_++;
                  type = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 43:
                  if(_loc25_ != 0)
                  {
                     throw new IOError("Bad data format: MainDiscountInfo.limitCount cannot be set twice.");
                  }
                  _loc25_++;
                  limitCount = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 44:
                  if(_loc56_ != 0)
                  {
                     throw new IOError("Bad data format: MainDiscountInfo.vip cannot be set twice.");
                  }
                  _loc56_++;
                  vip = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 45:
                  if(_loc52_ != 0)
                  {
                     throw new IOError("Bad data format: MainDiscountInfo.level1 cannot be set twice.");
                  }
                  _loc52_++;
                  level1 = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 46:
                  if(_loc39_ != 0)
                  {
                     throw new IOError("Bad data format: MainDiscountInfo.price1 cannot be set twice.");
                  }
                  _loc39_++;
                  price1 = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 47:
                  if(_loc9_ != 0)
                  {
                     throw new IOError("Bad data format: MainDiscountInfo.level2 cannot be set twice.");
                  }
                  _loc9_++;
                  level2 = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 48:
                  if(_loc31_ != 0)
                  {
                     throw new IOError("Bad data format: MainDiscountInfo.price2 cannot be set twice.");
                  }
                  _loc31_++;
                  price2 = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 49:
                  if(_loc19_ != 0)
                  {
                     throw new IOError("Bad data format: MainDiscountInfo.level3 cannot be set twice.");
                  }
                  _loc19_++;
                  level3 = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 50:
                  if(_loc4_ != 0)
                  {
                     throw new IOError("Bad data format: MainDiscountInfo.price3 cannot be set twice.");
                  }
                  _loc4_++;
                  price3 = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 51:
                  if(_loc17_ != 0)
                  {
                     throw new IOError("Bad data format: MainDiscountInfo.sendDate cannot be set twice.");
                  }
                  _loc17_++;
                  sendDate = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 52:
                  if(_loc24_ != 0)
                  {
                     throw new IOError("Bad data format: MainDiscountInfo.refreshInterval cannot be set twice.");
                  }
                  _loc24_++;
                  refreshInterval = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 53:
                  if(_loc38_ != 0)
                  {
                     throw new IOError("Bad data format: MainDiscountInfo.frontMoney cannot be set twice.");
                  }
                  _loc38_++;
                  frontMoney = ReadUtils.read$TYPE_INT32(param1);
                  break;
               default:
                  ReadUtils.skip(param1,_loc14_ & 7);
            }
         }
      }
   }
}

