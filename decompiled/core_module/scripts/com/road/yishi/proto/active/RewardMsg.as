package com.road.yishi.proto.active
{
   import com.netease.protobuf.*;
   import flash.errors.IOError;
   import flash.utils.IDataInput;
   import flash.utils.IExternalizable;
   
   public final class RewardMsg extends Message implements IExternalizable
   {
      
      private var type$field:int;
      
      private var hasField$0:uint = 0;
      
      private var number$field:int;
      
      private var returnerId$field:int;
      
      private var returnerName$field:String;
      
      private var getStatu$field:int;
      
      private var param1$field:int;
      
      [ArrayElementType("com.road.yishi.proto.active.ReturnedItemMsg")]
      public var items:Array = [];
      
      public function RewardMsg()
      {
         super();
      }
      
      public function removeType() : void
      {
         hasField$0 &= 4294967294;
         type$field = new int();
      }
      
      public function get hasType() : Boolean
      {
         return (hasField$0 & 1) != 0;
      }
      
      public function set type(param1:int) : void
      {
         hasField$0 |= 1;
         type$field = param1;
      }
      
      public function get type() : int
      {
         return type$field;
      }
      
      public function removeNumber() : void
      {
         hasField$0 &= 4294967293;
         number$field = new int();
      }
      
      public function get hasNumber() : Boolean
      {
         return (hasField$0 & 2) != 0;
      }
      
      public function set number(param1:int) : void
      {
         hasField$0 |= 2;
         number$field = param1;
      }
      
      public function get number() : int
      {
         return number$field;
      }
      
      public function removeReturnerId() : void
      {
         hasField$0 &= 4294967291;
         returnerId$field = new int();
      }
      
      public function get hasReturnerId() : Boolean
      {
         return (hasField$0 & 4) != 0;
      }
      
      public function set returnerId(param1:int) : void
      {
         hasField$0 |= 4;
         returnerId$field = param1;
      }
      
      public function get returnerId() : int
      {
         return returnerId$field;
      }
      
      public function removeReturnerName() : void
      {
         returnerName$field = null;
      }
      
      public function get hasReturnerName() : Boolean
      {
         return returnerName$field != null;
      }
      
      public function set returnerName(param1:String) : void
      {
         returnerName$field = param1;
      }
      
      public function get returnerName() : String
      {
         return returnerName$field;
      }
      
      public function removeGetStatu() : void
      {
         hasField$0 &= 4294967287;
         getStatu$field = new int();
      }
      
      public function get hasGetStatu() : Boolean
      {
         return (hasField$0 & 8) != 0;
      }
      
      public function set getStatu(param1:int) : void
      {
         hasField$0 |= 8;
         getStatu$field = param1;
      }
      
      public function get getStatu() : int
      {
         return getStatu$field;
      }
      
      public function removeParam1() : void
      {
         hasField$0 &= 4294967279;
         param1$field = new int();
      }
      
      public function get hasParam1() : Boolean
      {
         return (hasField$0 & 0x10) != 0;
      }
      
      public function set param1(param1:int) : void
      {
         hasField$0 |= 16;
         param1$field = param1;
      }
      
      public function get param1() : int
      {
         return param1$field;
      }
      
      final override public function writeToBuffer(param1:WritingBuffer) : void
      {
         var _loc2_:* = 0;
         if(hasType)
         {
            WriteUtils.writeTag(param1,0,1);
            WriteUtils.write$TYPE_INT32(param1,type$field);
         }
         if(hasNumber)
         {
            WriteUtils.writeTag(param1,0,2);
            WriteUtils.write$TYPE_INT32(param1,number$field);
         }
         if(hasReturnerId)
         {
            WriteUtils.writeTag(param1,0,3);
            WriteUtils.write$TYPE_INT32(param1,returnerId$field);
         }
         if(hasReturnerName)
         {
            WriteUtils.writeTag(param1,2,4);
            WriteUtils.write$TYPE_STRING(param1,returnerName$field);
         }
         if(hasGetStatu)
         {
            WriteUtils.writeTag(param1,0,5);
            WriteUtils.write$TYPE_INT32(param1,getStatu$field);
         }
         if(hasParam1)
         {
            WriteUtils.writeTag(param1,0,6);
            WriteUtils.write$TYPE_INT32(param1,param1$field);
         }
         _loc2_ = 0;
         while(_loc2_ < items.length)
         {
            WriteUtils.writeTag(param1,2,7);
            WriteUtils.write$TYPE_MESSAGE(param1,items[_loc2_]);
            _loc2_++;
         }
      }
      
      final override public function readFromSlice(param1:IDataInput, param2:uint) : void
      {
         var _loc9_:* = 0;
         var _loc10_:ReturnedItemMsg = null;
         var _loc8_:uint = 0;
         var _loc4_:uint = 0;
         var _loc5_:uint = 0;
         var _loc3_:uint = 0;
         var _loc7_:uint = 0;
         var _loc6_:uint = 0;
         while(param1.bytesAvailable > param2)
         {
            switch(((_loc9_ = ReadUtils.read$TYPE_UINT32(param1)) >>> 3) - 1)
            {
               case 0:
                  if(_loc8_ != 0)
                  {
                     throw new IOError("Bad data format: RewardMsg.type cannot be set twice.");
                  }
                  _loc8_++;
                  type = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 1:
                  if(_loc4_ != 0)
                  {
                     throw new IOError("Bad data format: RewardMsg.number cannot be set twice.");
                  }
                  _loc4_++;
                  number = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 2:
                  if(_loc5_ != 0)
                  {
                     throw new IOError("Bad data format: RewardMsg.returnerId cannot be set twice.");
                  }
                  _loc5_++;
                  returnerId = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 3:
                  if(_loc3_ != 0)
                  {
                     throw new IOError("Bad data format: RewardMsg.returnerName cannot be set twice.");
                  }
                  _loc3_++;
                  returnerName = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 4:
                  if(_loc7_ != 0)
                  {
                     throw new IOError("Bad data format: RewardMsg.getStatu cannot be set twice.");
                  }
                  _loc7_++;
                  getStatu = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 5:
                  if(_loc6_ != 0)
                  {
                     throw new IOError("Bad data format: RewardMsg.param1 cannot be set twice.");
                  }
                  _loc6_++;
                  param1 = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 6:
                  _loc10_ = new ReturnedItemMsg();
                  ReadUtils.read$TYPE_MESSAGE(param1,_loc10_);
                  items.push(_loc10_);
                  break;
               default:
                  ReadUtils.skip(param1,_loc9_ & 7);
            }
         }
      }
   }
}

