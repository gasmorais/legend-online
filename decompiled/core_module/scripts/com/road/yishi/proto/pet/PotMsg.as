package com.road.yishi.proto.pet
{
   import com.netease.protobuf.*;
   import flash.errors.IOError;
   import flash.utils.IDataInput;
   import flash.utils.IExternalizable;
   
   public final class PotMsg extends Message implements IExternalizable
   {
      
      private var bet$field:int;
      
      private var hasField$0:uint = 0;
      
      [ArrayElementType("com.road.yishi.proto.pet.TablePlayerMsg")]
      public var contributor:Array = [];
      
      public function PotMsg()
      {
         super();
      }
      
      public function removeBet() : void
      {
         hasField$0 &= 4294967294;
         bet$field = new int();
      }
      
      public function get hasBet() : Boolean
      {
         return (hasField$0 & 1) != 0;
      }
      
      public function set bet(param1:int) : void
      {
         hasField$0 |= 1;
         bet$field = param1;
      }
      
      public function get bet() : int
      {
         return bet$field;
      }
      
      final override public function writeToBuffer(param1:WritingBuffer) : void
      {
         var _loc2_:* = 0;
         if(hasBet)
         {
            WriteUtils.writeTag(param1,0,1);
            WriteUtils.write$TYPE_INT32(param1,bet$field);
         }
         _loc2_ = 0;
         while(_loc2_ < contributor.length)
         {
            WriteUtils.writeTag(param1,2,2);
            WriteUtils.write$TYPE_MESSAGE(param1,contributor[_loc2_]);
            _loc2_++;
         }
      }
      
      final override public function readFromSlice(param1:IDataInput, param2:uint) : void
      {
         var _loc4_:* = 0;
         var _loc3_:TablePlayerMsg = null;
         var _loc5_:uint = 0;
         while(param1.bytesAvailable > param2)
         {
            switch(((_loc4_ = ReadUtils.read$TYPE_UINT32(param1)) >>> 3) - 1)
            {
               case 0:
                  if(_loc5_ != 0)
                  {
                     throw new IOError("Bad data format: PotMsg.bet cannot be set twice.");
                  }
                  _loc5_++;
                  bet = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 1:
                  _loc3_ = new TablePlayerMsg();
                  ReadUtils.read$TYPE_MESSAGE(param1,_loc3_);
                  contributor.push(_loc3_);
                  break;
               default:
                  ReadUtils.skip(param1,_loc4_ & 7);
            }
         }
      }
   }
}

