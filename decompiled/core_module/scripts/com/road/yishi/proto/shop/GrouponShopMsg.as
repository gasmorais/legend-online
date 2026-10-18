package com.road.yishi.proto.shop
{
   import com.netease.protobuf.Message;
   import com.netease.protobuf.ReadUtils;
   import com.netease.protobuf.WriteUtils;
   import com.netease.protobuf.WritingBuffer;
   import flash.errors.IOError;
   import flash.utils.IDataInput;
   import flash.utils.IExternalizable;
   
   public final class GrouponShopMsg extends Message implements IExternalizable
   {
      
      private var buy_count$field:int;
      
      private var hasField$0:uint = 0;
      
      private var total_point$field:int;
      
      private var cur_price$field:int;
      
      private var cur_count$field:int;
      
      private var good_id$field:int;
      
      private var param1$field:int;
      
      private var param2$field:String;
      
      private var count$field:int;
      
      private var is_reward$field:Boolean;
      
      private var frontMoney$field:int;
      
      public function GrouponShopMsg()
      {
         super();
      }
      
      public function removeBuyCount() : void
      {
         hasField$0 &= 4294967294;
         buy_count$field = new int();
      }
      
      public function get hasBuyCount() : Boolean
      {
         return (hasField$0 & 1) != 0;
      }
      
      public function set buyCount(param1:int) : void
      {
         hasField$0 |= 1;
         buy_count$field = param1;
      }
      
      public function get buyCount() : int
      {
         return buy_count$field;
      }
      
      public function removeTotalPoint() : void
      {
         hasField$0 &= 4294967293;
         total_point$field = new int();
      }
      
      public function get hasTotalPoint() : Boolean
      {
         return (hasField$0 & 2) != 0;
      }
      
      public function set totalPoint(param1:int) : void
      {
         hasField$0 |= 2;
         total_point$field = param1;
      }
      
      public function get totalPoint() : int
      {
         return total_point$field;
      }
      
      public function removeCurPrice() : void
      {
         hasField$0 &= 4294967291;
         cur_price$field = new int();
      }
      
      public function get hasCurPrice() : Boolean
      {
         return (hasField$0 & 4) != 0;
      }
      
      public function set curPrice(param1:int) : void
      {
         hasField$0 |= 4;
         cur_price$field = param1;
      }
      
      public function get curPrice() : int
      {
         return cur_price$field;
      }
      
      public function removeCurCount() : void
      {
         hasField$0 &= 4294967287;
         cur_count$field = new int();
      }
      
      public function get hasCurCount() : Boolean
      {
         return (hasField$0 & 8) != 0;
      }
      
      public function set curCount(param1:int) : void
      {
         hasField$0 |= 8;
         cur_count$field = param1;
      }
      
      public function get curCount() : int
      {
         return cur_count$field;
      }
      
      public function removeGoodId() : void
      {
         hasField$0 &= 4294967279;
         good_id$field = new int();
      }
      
      public function get hasGoodId() : Boolean
      {
         return (hasField$0 & 0x10) != 0;
      }
      
      public function set goodId(param1:int) : void
      {
         hasField$0 |= 16;
         good_id$field = param1;
      }
      
      public function get goodId() : int
      {
         return good_id$field;
      }
      
      public function removeParam1() : void
      {
         hasField$0 &= 4294967263;
         param1$field = new int();
      }
      
      public function get hasParam1() : Boolean
      {
         return (hasField$0 & 0x20) != 0;
      }
      
      public function set param1(param1:int) : void
      {
         hasField$0 |= 32;
         param1$field = param1;
      }
      
      public function get param1() : int
      {
         return param1$field;
      }
      
      public function removeParam2() : void
      {
         param2$field = null;
      }
      
      public function get hasParam2() : Boolean
      {
         return param2$field != null;
      }
      
      public function set param2(param1:String) : void
      {
         param2$field = param1;
      }
      
      public function get param2() : String
      {
         return param2$field;
      }
      
      public function removeCount() : void
      {
         hasField$0 &= 4294967231;
         count$field = new int();
      }
      
      public function get hasCount() : Boolean
      {
         return (hasField$0 & 0x40) != 0;
      }
      
      public function set count(param1:int) : void
      {
         hasField$0 |= 64;
         count$field = param1;
      }
      
      public function get count() : int
      {
         return count$field;
      }
      
      public function removeIsReward() : void
      {
         hasField$0 &= 4294967167;
         is_reward$field = new Boolean();
      }
      
      public function get hasIsReward() : Boolean
      {
         return (hasField$0 & 0x80) != 0;
      }
      
      public function set isReward(param1:Boolean) : void
      {
         hasField$0 |= 128;
         is_reward$field = param1;
      }
      
      public function get isReward() : Boolean
      {
         return is_reward$field;
      }
      
      public function removeFrontMoney() : void
      {
         hasField$0 &= 4294967039;
         frontMoney$field = new int();
      }
      
      public function get hasFrontMoney() : Boolean
      {
         return (hasField$0 & 0x0100) != 0;
      }
      
      public function set frontMoney(param1:int) : void
      {
         hasField$0 |= 256;
         frontMoney$field = param1;
      }
      
      public function get frontMoney() : int
      {
         return frontMoney$field;
      }
      
      final override public function writeToBuffer(param1:WritingBuffer) : void
      {
         if(hasBuyCount)
         {
            WriteUtils.writeTag(param1,0,1);
            WriteUtils.write$TYPE_INT32(param1,buy_count$field);
         }
         if(hasTotalPoint)
         {
            WriteUtils.writeTag(param1,0,2);
            WriteUtils.write$TYPE_INT32(param1,total_point$field);
         }
         if(hasCurPrice)
         {
            WriteUtils.writeTag(param1,0,3);
            WriteUtils.write$TYPE_INT32(param1,cur_price$field);
         }
         if(hasCurCount)
         {
            WriteUtils.writeTag(param1,0,4);
            WriteUtils.write$TYPE_INT32(param1,cur_count$field);
         }
         if(hasGoodId)
         {
            WriteUtils.writeTag(param1,0,5);
            WriteUtils.write$TYPE_INT32(param1,good_id$field);
         }
         if(hasParam1)
         {
            WriteUtils.writeTag(param1,0,6);
            WriteUtils.write$TYPE_INT32(param1,param1$field);
         }
         if(hasParam2)
         {
            WriteUtils.writeTag(param1,2,7);
            WriteUtils.write$TYPE_STRING(param1,param2$field);
         }
         if(hasCount)
         {
            WriteUtils.writeTag(param1,0,8);
            WriteUtils.write$TYPE_INT32(param1,count$field);
         }
         if(hasIsReward)
         {
            WriteUtils.writeTag(param1,0,9);
            WriteUtils.write$TYPE_BOOL(param1,is_reward$field);
         }
         if(hasFrontMoney)
         {
            WriteUtils.writeTag(param1,0,10);
            WriteUtils.write$TYPE_INT32(param1,frontMoney$field);
         }
      }
      
      final override public function readFromSlice(param1:IDataInput, param2:uint) : void
      {
         var _loc11_:* = 0;
         var _loc8_:uint = 0;
         var _loc3_:uint = 0;
         var _loc5_:uint = 0;
         var _loc7_:uint = 0;
         var _loc10_:uint = 0;
         var _loc6_:uint = 0;
         var _loc13_:uint = 0;
         var _loc4_:uint = 0;
         var _loc12_:uint = 0;
         var _loc9_:uint = 0;
         while(param1.bytesAvailable > param2)
         {
            switch(((_loc11_ = ReadUtils.read$TYPE_UINT32(param1)) >>> 3) - 1)
            {
               case 0:
                  if(_loc8_ != 0)
                  {
                     throw new IOError("Bad data format: GrouponShopMsg.buyCount cannot be set twice.");
                  }
                  _loc8_++;
                  buyCount = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 1:
                  if(_loc3_ != 0)
                  {
                     throw new IOError("Bad data format: GrouponShopMsg.totalPoint cannot be set twice.");
                  }
                  _loc3_++;
                  totalPoint = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 2:
                  if(_loc5_ != 0)
                  {
                     throw new IOError("Bad data format: GrouponShopMsg.curPrice cannot be set twice.");
                  }
                  _loc5_++;
                  curPrice = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 3:
                  if(_loc7_ != 0)
                  {
                     throw new IOError("Bad data format: GrouponShopMsg.curCount cannot be set twice.");
                  }
                  _loc7_++;
                  curCount = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 4:
                  if(_loc10_ != 0)
                  {
                     throw new IOError("Bad data format: GrouponShopMsg.goodId cannot be set twice.");
                  }
                  _loc10_++;
                  goodId = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 5:
                  if(_loc6_ != 0)
                  {
                     throw new IOError("Bad data format: GrouponShopMsg.param1 cannot be set twice.");
                  }
                  _loc6_++;
                  param1 = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 6:
                  if(_loc13_ != 0)
                  {
                     throw new IOError("Bad data format: GrouponShopMsg.param2 cannot be set twice.");
                  }
                  _loc13_++;
                  param2 = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 7:
                  if(_loc4_ != 0)
                  {
                     throw new IOError("Bad data format: GrouponShopMsg.count cannot be set twice.");
                  }
                  _loc4_++;
                  count = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 8:
                  if(_loc12_ != 0)
                  {
                     throw new IOError("Bad data format: GrouponShopMsg.isReward cannot be set twice.");
                  }
                  _loc12_++;
                  isReward = ReadUtils.read$TYPE_BOOL(param1);
                  break;
               case 9:
                  if(_loc9_ != 0)
                  {
                     throw new IOError("Bad data format: GrouponShopMsg.frontMoney cannot be set twice.");
                  }
                  _loc9_++;
                  frontMoney = ReadUtils.read$TYPE_INT32(param1);
                  break;
               default:
                  ReadUtils.skip(param1,_loc11_ & 7);
            }
         }
      }
   }
}

