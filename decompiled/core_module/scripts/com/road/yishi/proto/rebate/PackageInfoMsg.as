package com.road.yishi.proto.rebate
{
   import com.netease.protobuf.Message;
   import com.netease.protobuf.ReadUtils;
   import com.netease.protobuf.WriteUtils;
   import com.netease.protobuf.WritingBuffer;
   import flash.errors.IOError;
   import flash.utils.IDataInput;
   import flash.utils.IExternalizable;
   
   public final class PackageInfoMsg extends Message implements IExternalizable
   {
      
      private var packageId$field:String;
      
      private var order$field:int;
      
      private var hasField$0:uint = 0;
      
      private var point$field:int;
      
      private var price$field:int;
      
      private var itemid1$field:int;
      
      private var count1$field:int;
      
      private var itemid2$field:int;
      
      private var count2$field:int;
      
      private var itemid3$field:int;
      
      private var count3$field:int;
      
      private var itemid4$field:int;
      
      private var count4$field:int;
      
      private var itemid5$field:int;
      
      private var count5$field:int;
      
      private var itemid6$field:int;
      
      private var count6$field:int;
      
      private var itemid7$field:int;
      
      private var count7$field:int;
      
      private var itemid8$field:int;
      
      private var count8$field:int;
      
      public function PackageInfoMsg()
      {
         super();
      }
      
      public function removePackageId() : void
      {
         packageId$field = null;
      }
      
      public function get hasPackageId() : Boolean
      {
         return packageId$field != null;
      }
      
      public function set packageId(param1:String) : void
      {
         packageId$field = param1;
      }
      
      public function get packageId() : String
      {
         return packageId$field;
      }
      
      public function removeOrder() : void
      {
         hasField$0 &= 4294967294;
         order$field = new int();
      }
      
      public function get hasOrder() : Boolean
      {
         return (hasField$0 & 1) != 0;
      }
      
      public function set order(param1:int) : void
      {
         hasField$0 |= 1;
         order$field = param1;
      }
      
      public function get order() : int
      {
         return order$field;
      }
      
      public function removePoint() : void
      {
         hasField$0 &= 4294967293;
         point$field = new int();
      }
      
      public function get hasPoint() : Boolean
      {
         return (hasField$0 & 2) != 0;
      }
      
      public function set point(param1:int) : void
      {
         hasField$0 |= 2;
         point$field = param1;
      }
      
      public function get point() : int
      {
         return point$field;
      }
      
      public function removePrice() : void
      {
         hasField$0 &= 4294967291;
         price$field = new int();
      }
      
      public function get hasPrice() : Boolean
      {
         return (hasField$0 & 4) != 0;
      }
      
      public function set price(param1:int) : void
      {
         hasField$0 |= 4;
         price$field = param1;
      }
      
      public function get price() : int
      {
         return price$field;
      }
      
      public function removeItemid1() : void
      {
         hasField$0 &= 4294967287;
         itemid1$field = new int();
      }
      
      public function get hasItemid1() : Boolean
      {
         return (hasField$0 & 8) != 0;
      }
      
      public function set itemid1(param1:int) : void
      {
         hasField$0 |= 8;
         itemid1$field = param1;
      }
      
      public function get itemid1() : int
      {
         return itemid1$field;
      }
      
      public function removeCount1() : void
      {
         hasField$0 &= 4294967279;
         count1$field = new int();
      }
      
      public function get hasCount1() : Boolean
      {
         return (hasField$0 & 0x10) != 0;
      }
      
      public function set count1(param1:int) : void
      {
         hasField$0 |= 16;
         count1$field = param1;
      }
      
      public function get count1() : int
      {
         return count1$field;
      }
      
      public function removeItemid2() : void
      {
         hasField$0 &= 4294967263;
         itemid2$field = new int();
      }
      
      public function get hasItemid2() : Boolean
      {
         return (hasField$0 & 0x20) != 0;
      }
      
      public function set itemid2(param1:int) : void
      {
         hasField$0 |= 32;
         itemid2$field = param1;
      }
      
      public function get itemid2() : int
      {
         return itemid2$field;
      }
      
      public function removeCount2() : void
      {
         hasField$0 &= 4294967231;
         count2$field = new int();
      }
      
      public function get hasCount2() : Boolean
      {
         return (hasField$0 & 0x40) != 0;
      }
      
      public function set count2(param1:int) : void
      {
         hasField$0 |= 64;
         count2$field = param1;
      }
      
      public function get count2() : int
      {
         return count2$field;
      }
      
      public function removeItemid3() : void
      {
         hasField$0 &= 4294967167;
         itemid3$field = new int();
      }
      
      public function get hasItemid3() : Boolean
      {
         return (hasField$0 & 0x80) != 0;
      }
      
      public function set itemid3(param1:int) : void
      {
         hasField$0 |= 128;
         itemid3$field = param1;
      }
      
      public function get itemid3() : int
      {
         return itemid3$field;
      }
      
      public function removeCount3() : void
      {
         hasField$0 &= 4294967039;
         count3$field = new int();
      }
      
      public function get hasCount3() : Boolean
      {
         return (hasField$0 & 0x0100) != 0;
      }
      
      public function set count3(param1:int) : void
      {
         hasField$0 |= 256;
         count3$field = param1;
      }
      
      public function get count3() : int
      {
         return count3$field;
      }
      
      public function removeItemid4() : void
      {
         hasField$0 &= 4294966783;
         itemid4$field = new int();
      }
      
      public function get hasItemid4() : Boolean
      {
         return (hasField$0 & 0x0200) != 0;
      }
      
      public function set itemid4(param1:int) : void
      {
         hasField$0 |= 512;
         itemid4$field = param1;
      }
      
      public function get itemid4() : int
      {
         return itemid4$field;
      }
      
      public function removeCount4() : void
      {
         hasField$0 &= 4294966271;
         count4$field = new int();
      }
      
      public function get hasCount4() : Boolean
      {
         return (hasField$0 & 0x0400) != 0;
      }
      
      public function set count4(param1:int) : void
      {
         hasField$0 |= 1024;
         count4$field = param1;
      }
      
      public function get count4() : int
      {
         return count4$field;
      }
      
      public function removeItemid5() : void
      {
         hasField$0 &= 4294965247;
         itemid5$field = new int();
      }
      
      public function get hasItemid5() : Boolean
      {
         return (hasField$0 & 0x0800) != 0;
      }
      
      public function set itemid5(param1:int) : void
      {
         hasField$0 |= 2048;
         itemid5$field = param1;
      }
      
      public function get itemid5() : int
      {
         return itemid5$field;
      }
      
      public function removeCount5() : void
      {
         hasField$0 &= 4294963199;
         count5$field = new int();
      }
      
      public function get hasCount5() : Boolean
      {
         return (hasField$0 & 0x1000) != 0;
      }
      
      public function set count5(param1:int) : void
      {
         hasField$0 |= 4096;
         count5$field = param1;
      }
      
      public function get count5() : int
      {
         return count5$field;
      }
      
      public function removeItemid6() : void
      {
         hasField$0 &= 4294959103;
         itemid6$field = new int();
      }
      
      public function get hasItemid6() : Boolean
      {
         return (hasField$0 & 0x2000) != 0;
      }
      
      public function set itemid6(param1:int) : void
      {
         hasField$0 |= 8192;
         itemid6$field = param1;
      }
      
      public function get itemid6() : int
      {
         return itemid6$field;
      }
      
      public function removeCount6() : void
      {
         hasField$0 &= 4294950911;
         count6$field = new int();
      }
      
      public function get hasCount6() : Boolean
      {
         return (hasField$0 & 0x4000) != 0;
      }
      
      public function set count6(param1:int) : void
      {
         hasField$0 |= 16384;
         count6$field = param1;
      }
      
      public function get count6() : int
      {
         return count6$field;
      }
      
      public function removeItemid7() : void
      {
         hasField$0 &= 4294934527;
         itemid7$field = new int();
      }
      
      public function get hasItemid7() : Boolean
      {
         return (hasField$0 & 0x8000) != 0;
      }
      
      public function set itemid7(param1:int) : void
      {
         hasField$0 |= 32768;
         itemid7$field = param1;
      }
      
      public function get itemid7() : int
      {
         return itemid7$field;
      }
      
      public function removeCount7() : void
      {
         hasField$0 &= 4294901759;
         count7$field = new int();
      }
      
      public function get hasCount7() : Boolean
      {
         return (hasField$0 & 0x010000) != 0;
      }
      
      public function set count7(param1:int) : void
      {
         hasField$0 |= 65536;
         count7$field = param1;
      }
      
      public function get count7() : int
      {
         return count7$field;
      }
      
      public function removeItemid8() : void
      {
         hasField$0 &= 4294836223;
         itemid8$field = new int();
      }
      
      public function get hasItemid8() : Boolean
      {
         return (hasField$0 & 0x020000) != 0;
      }
      
      public function set itemid8(param1:int) : void
      {
         hasField$0 |= 131072;
         itemid8$field = param1;
      }
      
      public function get itemid8() : int
      {
         return itemid8$field;
      }
      
      public function removeCount8() : void
      {
         hasField$0 &= 4294705151;
         count8$field = new int();
      }
      
      public function get hasCount8() : Boolean
      {
         return (hasField$0 & 0x040000) != 0;
      }
      
      public function set count8(param1:int) : void
      {
         hasField$0 |= 262144;
         count8$field = param1;
      }
      
      public function get count8() : int
      {
         return count8$field;
      }
      
      final override public function writeToBuffer(param1:WritingBuffer) : void
      {
         if(hasPackageId)
         {
            WriteUtils.writeTag(param1,2,1);
            WriteUtils.write$TYPE_STRING(param1,packageId$field);
         }
         if(hasOrder)
         {
            WriteUtils.writeTag(param1,0,2);
            WriteUtils.write$TYPE_INT32(param1,order$field);
         }
         if(hasPoint)
         {
            WriteUtils.writeTag(param1,0,3);
            WriteUtils.write$TYPE_INT32(param1,point$field);
         }
         if(hasPrice)
         {
            WriteUtils.writeTag(param1,0,4);
            WriteUtils.write$TYPE_INT32(param1,price$field);
         }
         if(hasItemid1)
         {
            WriteUtils.writeTag(param1,0,5);
            WriteUtils.write$TYPE_INT32(param1,itemid1$field);
         }
         if(hasCount1)
         {
            WriteUtils.writeTag(param1,0,6);
            WriteUtils.write$TYPE_INT32(param1,count1$field);
         }
         if(hasItemid2)
         {
            WriteUtils.writeTag(param1,0,7);
            WriteUtils.write$TYPE_INT32(param1,itemid2$field);
         }
         if(hasCount2)
         {
            WriteUtils.writeTag(param1,0,8);
            WriteUtils.write$TYPE_INT32(param1,count2$field);
         }
         if(hasItemid3)
         {
            WriteUtils.writeTag(param1,0,9);
            WriteUtils.write$TYPE_INT32(param1,itemid3$field);
         }
         if(hasCount3)
         {
            WriteUtils.writeTag(param1,0,10);
            WriteUtils.write$TYPE_INT32(param1,count3$field);
         }
         if(hasItemid4)
         {
            WriteUtils.writeTag(param1,0,11);
            WriteUtils.write$TYPE_INT32(param1,itemid4$field);
         }
         if(hasCount4)
         {
            WriteUtils.writeTag(param1,0,12);
            WriteUtils.write$TYPE_INT32(param1,count4$field);
         }
         if(hasItemid5)
         {
            WriteUtils.writeTag(param1,0,13);
            WriteUtils.write$TYPE_INT32(param1,itemid5$field);
         }
         if(hasCount5)
         {
            WriteUtils.writeTag(param1,0,14);
            WriteUtils.write$TYPE_INT32(param1,count5$field);
         }
         if(hasItemid6)
         {
            WriteUtils.writeTag(param1,0,15);
            WriteUtils.write$TYPE_INT32(param1,itemid6$field);
         }
         if(hasCount6)
         {
            WriteUtils.writeTag(param1,0,16);
            WriteUtils.write$TYPE_INT32(param1,count6$field);
         }
         if(hasItemid7)
         {
            WriteUtils.writeTag(param1,0,17);
            WriteUtils.write$TYPE_INT32(param1,itemid7$field);
         }
         if(hasCount7)
         {
            WriteUtils.writeTag(param1,0,18);
            WriteUtils.write$TYPE_INT32(param1,count7$field);
         }
         if(hasItemid8)
         {
            WriteUtils.writeTag(param1,0,29);
            WriteUtils.write$TYPE_INT32(param1,itemid8$field);
         }
         if(hasCount8)
         {
            WriteUtils.writeTag(param1,0,20);
            WriteUtils.write$TYPE_INT32(param1,count8$field);
         }
      }
      
      final override public function readFromSlice(param1:IDataInput, param2:uint) : void
      {
         var _loc21_:* = 0;
         var _loc12_:uint = 0;
         var _loc15_:uint = 0;
         var _loc16_:uint = 0;
         var _loc7_:uint = 0;
         var _loc4_:uint = 0;
         var _loc9_:uint = 0;
         var _loc22_:uint = 0;
         var _loc5_:uint = 0;
         var _loc6_:uint = 0;
         var _loc23_:uint = 0;
         var _loc10_:uint = 0;
         var _loc8_:uint = 0;
         var _loc13_:uint = 0;
         var _loc11_:uint = 0;
         var _loc17_:uint = 0;
         var _loc14_:uint = 0;
         var _loc19_:uint = 0;
         var _loc18_:uint = 0;
         var _loc3_:uint = 0;
         var _loc20_:uint = 0;
         while(param1.bytesAvailable > param2)
         {
            switch((_loc21_ = ReadUtils.read$TYPE_UINT32(param1)) >>> 3)
            {
               case 1:
                  if(_loc12_ != 0)
                  {
                     throw new IOError("Bad data format: PackageInfoMsg.packageId cannot be set twice.");
                  }
                  _loc12_++;
                  packageId = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 2:
                  if(_loc15_ != 0)
                  {
                     throw new IOError("Bad data format: PackageInfoMsg.order cannot be set twice.");
                  }
                  _loc15_++;
                  order = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 3:
                  if(_loc16_ != 0)
                  {
                     throw new IOError("Bad data format: PackageInfoMsg.point cannot be set twice.");
                  }
                  _loc16_++;
                  point = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 4:
                  if(_loc7_ != 0)
                  {
                     throw new IOError("Bad data format: PackageInfoMsg.price cannot be set twice.");
                  }
                  _loc7_++;
                  price = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 5:
                  if(_loc4_ != 0)
                  {
                     throw new IOError("Bad data format: PackageInfoMsg.itemid1 cannot be set twice.");
                  }
                  _loc4_++;
                  itemid1 = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 6:
                  if(_loc9_ != 0)
                  {
                     throw new IOError("Bad data format: PackageInfoMsg.count1 cannot be set twice.");
                  }
                  _loc9_++;
                  count1 = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 7:
                  if(_loc22_ != 0)
                  {
                     throw new IOError("Bad data format: PackageInfoMsg.itemid2 cannot be set twice.");
                  }
                  _loc22_++;
                  itemid2 = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 8:
                  if(_loc5_ != 0)
                  {
                     throw new IOError("Bad data format: PackageInfoMsg.count2 cannot be set twice.");
                  }
                  _loc5_++;
                  count2 = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 9:
                  if(_loc6_ != 0)
                  {
                     throw new IOError("Bad data format: PackageInfoMsg.itemid3 cannot be set twice.");
                  }
                  _loc6_++;
                  itemid3 = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 10:
                  if(_loc23_ != 0)
                  {
                     throw new IOError("Bad data format: PackageInfoMsg.count3 cannot be set twice.");
                  }
                  _loc23_++;
                  count3 = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 11:
                  if(_loc10_ != 0)
                  {
                     throw new IOError("Bad data format: PackageInfoMsg.itemid4 cannot be set twice.");
                  }
                  _loc10_++;
                  itemid4 = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 12:
                  if(_loc8_ != 0)
                  {
                     throw new IOError("Bad data format: PackageInfoMsg.count4 cannot be set twice.");
                  }
                  _loc8_++;
                  count4 = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 13:
                  if(_loc13_ != 0)
                  {
                     throw new IOError("Bad data format: PackageInfoMsg.itemid5 cannot be set twice.");
                  }
                  _loc13_++;
                  itemid5 = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 14:
                  if(_loc11_ != 0)
                  {
                     throw new IOError("Bad data format: PackageInfoMsg.count5 cannot be set twice.");
                  }
                  _loc11_++;
                  count5 = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 15:
                  if(_loc17_ != 0)
                  {
                     throw new IOError("Bad data format: PackageInfoMsg.itemid6 cannot be set twice.");
                  }
                  _loc17_++;
                  itemid6 = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 16:
                  if(_loc14_ != 0)
                  {
                     throw new IOError("Bad data format: PackageInfoMsg.count6 cannot be set twice.");
                  }
                  _loc14_++;
                  count6 = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 17:
                  if(_loc19_ != 0)
                  {
                     throw new IOError("Bad data format: PackageInfoMsg.itemid7 cannot be set twice.");
                  }
                  _loc19_++;
                  itemid7 = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 18:
                  if(_loc18_ != 0)
                  {
                     throw new IOError("Bad data format: PackageInfoMsg.count7 cannot be set twice.");
                  }
                  _loc18_++;
                  count7 = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 29:
                  if(_loc3_ != 0)
                  {
                     throw new IOError("Bad data format: PackageInfoMsg.itemid8 cannot be set twice.");
                  }
                  _loc3_++;
                  itemid8 = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 20:
                  if(_loc20_ != 0)
                  {
                     throw new IOError("Bad data format: PackageInfoMsg.count8 cannot be set twice.");
                  }
                  _loc20_++;
                  count8 = ReadUtils.read$TYPE_INT32(param1);
                  break;
               default:
                  ReadUtils.skip(param1,_loc21_ & 7);
            }
         }
      }
   }
}

