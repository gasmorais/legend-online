package com.road.yishi.proto.farm
{
   import com.netease.protobuf.Message;
   import com.netease.protobuf.ReadUtils;
   import com.netease.protobuf.WriteUtils;
   import com.netease.protobuf.WritingBuffer;
   import flash.errors.IOError;
   import flash.utils.IDataInput;
   import flash.utils.IExternalizable;
   
   public final class TreeInfoMsg extends Message implements IExternalizable
   {
      
      private var userId$field:int;
      
      private var hasField$0:uint = 0;
      
      private var nickName$field:String;
      
      private var waterCount$field:int;
      
      private var fruitCount$field:int;
      
      private var isFirstFruit$field:Boolean;
      
      private var nextPickTime$field:String;
      
      private var property1$field:int;
      
      private var property2$field:int;
      
      private var lastWaterTime$field:String;
      
      private var left_time$field:int;
      
      private var left_pickTime$field:int;
      
      public function TreeInfoMsg()
      {
         super();
      }
      
      public function removeUserId() : void
      {
         hasField$0 &= 4294967294;
         userId$field = new int();
      }
      
      public function get hasUserId() : Boolean
      {
         return (hasField$0 & 1) != 0;
      }
      
      public function set userId(param1:int) : void
      {
         hasField$0 |= 1;
         userId$field = param1;
      }
      
      public function get userId() : int
      {
         return userId$field;
      }
      
      public function removeNickName() : void
      {
         nickName$field = null;
      }
      
      public function get hasNickName() : Boolean
      {
         return nickName$field != null;
      }
      
      public function set nickName(param1:String) : void
      {
         nickName$field = param1;
      }
      
      public function get nickName() : String
      {
         return nickName$field;
      }
      
      public function removeWaterCount() : void
      {
         hasField$0 &= 4294967293;
         waterCount$field = new int();
      }
      
      public function get hasWaterCount() : Boolean
      {
         return (hasField$0 & 2) != 0;
      }
      
      public function set waterCount(param1:int) : void
      {
         hasField$0 |= 2;
         waterCount$field = param1;
      }
      
      public function get waterCount() : int
      {
         return waterCount$field;
      }
      
      public function removeFruitCount() : void
      {
         hasField$0 &= 4294967291;
         fruitCount$field = new int();
      }
      
      public function get hasFruitCount() : Boolean
      {
         return (hasField$0 & 4) != 0;
      }
      
      public function set fruitCount(param1:int) : void
      {
         hasField$0 |= 4;
         fruitCount$field = param1;
      }
      
      public function get fruitCount() : int
      {
         return fruitCount$field;
      }
      
      public function removeIsFirstFruit() : void
      {
         hasField$0 &= 4294967287;
         isFirstFruit$field = new Boolean();
      }
      
      public function get hasIsFirstFruit() : Boolean
      {
         return (hasField$0 & 8) != 0;
      }
      
      public function set isFirstFruit(param1:Boolean) : void
      {
         hasField$0 |= 8;
         isFirstFruit$field = param1;
      }
      
      public function get isFirstFruit() : Boolean
      {
         return isFirstFruit$field;
      }
      
      public function removeNextPickTime() : void
      {
         nextPickTime$field = null;
      }
      
      public function get hasNextPickTime() : Boolean
      {
         return nextPickTime$field != null;
      }
      
      public function set nextPickTime(param1:String) : void
      {
         nextPickTime$field = param1;
      }
      
      public function get nextPickTime() : String
      {
         return nextPickTime$field;
      }
      
      public function removeProperty1() : void
      {
         hasField$0 &= 4294967279;
         property1$field = new int();
      }
      
      public function get hasProperty1() : Boolean
      {
         return (hasField$0 & 0x10) != 0;
      }
      
      public function set property1(param1:int) : void
      {
         hasField$0 |= 16;
         property1$field = param1;
      }
      
      public function get property1() : int
      {
         return property1$field;
      }
      
      public function removeProperty2() : void
      {
         hasField$0 &= 4294967263;
         property2$field = new int();
      }
      
      public function get hasProperty2() : Boolean
      {
         return (hasField$0 & 0x20) != 0;
      }
      
      public function set property2(param1:int) : void
      {
         hasField$0 |= 32;
         property2$field = param1;
      }
      
      public function get property2() : int
      {
         return property2$field;
      }
      
      public function removeLastWaterTime() : void
      {
         lastWaterTime$field = null;
      }
      
      public function get hasLastWaterTime() : Boolean
      {
         return lastWaterTime$field != null;
      }
      
      public function set lastWaterTime(param1:String) : void
      {
         lastWaterTime$field = param1;
      }
      
      public function get lastWaterTime() : String
      {
         return lastWaterTime$field;
      }
      
      public function removeLeftTime() : void
      {
         hasField$0 &= 4294967231;
         left_time$field = new int();
      }
      
      public function get hasLeftTime() : Boolean
      {
         return (hasField$0 & 0x40) != 0;
      }
      
      public function set leftTime(param1:int) : void
      {
         hasField$0 |= 64;
         left_time$field = param1;
      }
      
      public function get leftTime() : int
      {
         return left_time$field;
      }
      
      public function removeLeftPickTime() : void
      {
         hasField$0 &= 4294967167;
         left_pickTime$field = new int();
      }
      
      public function get hasLeftPickTime() : Boolean
      {
         return (hasField$0 & 0x80) != 0;
      }
      
      public function set leftPickTime(param1:int) : void
      {
         hasField$0 |= 128;
         left_pickTime$field = param1;
      }
      
      public function get leftPickTime() : int
      {
         return left_pickTime$field;
      }
      
      final override public function writeToBuffer(param1:WritingBuffer) : void
      {
         if(hasUserId)
         {
            WriteUtils.writeTag(param1,0,1);
            WriteUtils.write$TYPE_INT32(param1,userId$field);
         }
         if(hasNickName)
         {
            WriteUtils.writeTag(param1,2,2);
            WriteUtils.write$TYPE_STRING(param1,nickName$field);
         }
         if(hasWaterCount)
         {
            WriteUtils.writeTag(param1,0,3);
            WriteUtils.write$TYPE_INT32(param1,waterCount$field);
         }
         if(hasFruitCount)
         {
            WriteUtils.writeTag(param1,0,4);
            WriteUtils.write$TYPE_INT32(param1,fruitCount$field);
         }
         if(hasIsFirstFruit)
         {
            WriteUtils.writeTag(param1,0,5);
            WriteUtils.write$TYPE_BOOL(param1,isFirstFruit$field);
         }
         if(hasNextPickTime)
         {
            WriteUtils.writeTag(param1,2,6);
            WriteUtils.write$TYPE_STRING(param1,nextPickTime$field);
         }
         if(hasProperty1)
         {
            WriteUtils.writeTag(param1,0,7);
            WriteUtils.write$TYPE_INT32(param1,property1$field);
         }
         if(hasProperty2)
         {
            WriteUtils.writeTag(param1,0,8);
            WriteUtils.write$TYPE_INT32(param1,property2$field);
         }
         if(hasLastWaterTime)
         {
            WriteUtils.writeTag(param1,2,9);
            WriteUtils.write$TYPE_STRING(param1,lastWaterTime$field);
         }
         if(hasLeftTime)
         {
            WriteUtils.writeTag(param1,0,10);
            WriteUtils.write$TYPE_INT32(param1,left_time$field);
         }
         if(hasLeftPickTime)
         {
            WriteUtils.writeTag(param1,0,11);
            WriteUtils.write$TYPE_INT32(param1,left_pickTime$field);
         }
      }
      
      final override public function readFromSlice(param1:IDataInput, param2:uint) : void
      {
         var _loc13_:* = 0;
         var _loc5_:uint = 0;
         var _loc6_:uint = 0;
         var _loc4_:uint = 0;
         var _loc9_:uint = 0;
         var _loc7_:uint = 0;
         var _loc3_:uint = 0;
         var _loc10_:uint = 0;
         var _loc14_:uint = 0;
         var _loc8_:uint = 0;
         var _loc11_:uint = 0;
         var _loc12_:uint = 0;
         while(param1.bytesAvailable > param2)
         {
            switch(((_loc13_ = ReadUtils.read$TYPE_UINT32(param1)) >>> 3) - 1)
            {
               case 0:
                  if(_loc5_ != 0)
                  {
                     throw new IOError("Bad data format: TreeInfoMsg.userId cannot be set twice.");
                  }
                  _loc5_++;
                  userId = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 1:
                  if(_loc6_ != 0)
                  {
                     throw new IOError("Bad data format: TreeInfoMsg.nickName cannot be set twice.");
                  }
                  _loc6_++;
                  nickName = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 2:
                  if(_loc4_ != 0)
                  {
                     throw new IOError("Bad data format: TreeInfoMsg.waterCount cannot be set twice.");
                  }
                  _loc4_++;
                  waterCount = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 3:
                  if(_loc9_ != 0)
                  {
                     throw new IOError("Bad data format: TreeInfoMsg.fruitCount cannot be set twice.");
                  }
                  _loc9_++;
                  fruitCount = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 4:
                  if(_loc7_ != 0)
                  {
                     throw new IOError("Bad data format: TreeInfoMsg.isFirstFruit cannot be set twice.");
                  }
                  _loc7_++;
                  isFirstFruit = ReadUtils.read$TYPE_BOOL(param1);
                  break;
               case 5:
                  if(_loc3_ != 0)
                  {
                     throw new IOError("Bad data format: TreeInfoMsg.nextPickTime cannot be set twice.");
                  }
                  _loc3_++;
                  nextPickTime = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 6:
                  if(_loc10_ != 0)
                  {
                     throw new IOError("Bad data format: TreeInfoMsg.property1 cannot be set twice.");
                  }
                  _loc10_++;
                  property1 = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 7:
                  if(_loc14_ != 0)
                  {
                     throw new IOError("Bad data format: TreeInfoMsg.property2 cannot be set twice.");
                  }
                  _loc14_++;
                  property2 = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 8:
                  if(_loc8_ != 0)
                  {
                     throw new IOError("Bad data format: TreeInfoMsg.lastWaterTime cannot be set twice.");
                  }
                  _loc8_++;
                  lastWaterTime = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 9:
                  if(_loc11_ != 0)
                  {
                     throw new IOError("Bad data format: TreeInfoMsg.leftTime cannot be set twice.");
                  }
                  _loc11_++;
                  leftTime = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 10:
                  if(_loc12_ != 0)
                  {
                     throw new IOError("Bad data format: TreeInfoMsg.leftPickTime cannot be set twice.");
                  }
                  _loc12_++;
                  leftPickTime = ReadUtils.read$TYPE_INT32(param1);
                  break;
               default:
                  ReadUtils.skip(param1,_loc13_ & 7);
            }
         }
      }
   }
}

