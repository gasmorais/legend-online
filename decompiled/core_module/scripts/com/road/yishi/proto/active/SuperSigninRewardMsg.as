package com.road.yishi.proto.active
{
   import com.netease.protobuf.*;
   import flash.errors.IOError;
   import flash.utils.IDataInput;
   import flash.utils.IExternalizable;
   
   public final class SuperSigninRewardMsg extends Message implements IExternalizable
   {
      
      private var CardPrice$field:int;
      
      private var hasField$0:uint = 0;
      
      private var ReSigninPrice$field:int;
      
      [ArrayElementType("com.road.yishi.proto.active.SuperSigninTempMsg")]
      public var temp:Array = [];
      
      public function SuperSigninRewardMsg()
      {
         super();
      }
      
      public function removeCardPrice() : void
      {
         hasField$0 &= 4294967294;
         CardPrice$field = new int();
      }
      
      public function get hasCardPrice() : Boolean
      {
         return (hasField$0 & 1) != 0;
      }
      
      public function set cardPrice(param1:int) : void
      {
         hasField$0 |= 1;
         CardPrice$field = param1;
      }
      
      public function get cardPrice() : int
      {
         return CardPrice$field;
      }
      
      public function removeReSigninPrice() : void
      {
         hasField$0 &= 4294967293;
         ReSigninPrice$field = new int();
      }
      
      public function get hasReSigninPrice() : Boolean
      {
         return (hasField$0 & 2) != 0;
      }
      
      public function set reSigninPrice(param1:int) : void
      {
         hasField$0 |= 2;
         ReSigninPrice$field = param1;
      }
      
      public function get reSigninPrice() : int
      {
         return ReSigninPrice$field;
      }
      
      final override public function writeToBuffer(param1:WritingBuffer) : void
      {
         var _loc2_:* = 0;
         if(hasCardPrice)
         {
            WriteUtils.writeTag(param1,0,1);
            WriteUtils.write$TYPE_INT32(param1,CardPrice$field);
         }
         if(hasReSigninPrice)
         {
            WriteUtils.writeTag(param1,0,2);
            WriteUtils.write$TYPE_INT32(param1,ReSigninPrice$field);
         }
         _loc2_ = 0;
         while(_loc2_ < temp.length)
         {
            WriteUtils.writeTag(param1,2,3);
            WriteUtils.write$TYPE_MESSAGE(param1,temp[_loc2_]);
            _loc2_++;
         }
      }
      
      final override public function readFromSlice(param1:IDataInput, param2:uint) : void
      {
         var _loc6_:* = 0;
         var _loc3_:SuperSigninTempMsg = null;
         var _loc5_:uint = 0;
         var _loc4_:uint = 0;
         while(param1.bytesAvailable > param2)
         {
            switch(((_loc6_ = ReadUtils.read$TYPE_UINT32(param1)) >>> 3) - 1)
            {
               case 0:
                  if(_loc5_ != 0)
                  {
                     throw new IOError("Bad data format: SuperSigninRewardMsg.cardPrice cannot be set twice.");
                  }
                  _loc5_++;
                  cardPrice = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 1:
                  if(_loc4_ != 0)
                  {
                     throw new IOError("Bad data format: SuperSigninRewardMsg.reSigninPrice cannot be set twice.");
                  }
                  _loc4_++;
                  reSigninPrice = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 2:
                  _loc3_ = new SuperSigninTempMsg();
                  ReadUtils.read$TYPE_MESSAGE(param1,_loc3_);
                  temp.push(_loc3_);
                  break;
               default:
                  ReadUtils.skip(param1,_loc6_ & 7);
            }
         }
      }
   }
}

