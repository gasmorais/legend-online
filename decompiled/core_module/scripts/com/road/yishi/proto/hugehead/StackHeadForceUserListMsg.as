package com.road.yishi.proto.hugehead
{
   import com.netease.protobuf.*;
   import flash.errors.IOError;
   import flash.utils.IDataInput;
   import flash.utils.IExternalizable;
   
   public final class StackHeadForceUserListMsg extends Message implements IExternalizable
   {
      
      private var op$field:int;
      
      private var hasField$0:uint = 0;
      
      private var current$field:int;
      
      private var total$field:int;
      
      private var guild$field:HugeHeadGuildMsg;
      
      [ArrayElementType("com.road.yishi.proto.hugehead.StackHeadSeniorGeneralMsg")]
      public var seniorGeneralUser:Array = [];
      
      public function StackHeadForceUserListMsg()
      {
         super();
      }
      
      public function removeOp() : void
      {
         hasField$0 &= 4294967294;
         op$field = new int();
      }
      
      public function get hasOp() : Boolean
      {
         return (hasField$0 & 1) != 0;
      }
      
      public function set op(param1:int) : void
      {
         hasField$0 |= 1;
         op$field = param1;
      }
      
      public function get op() : int
      {
         return op$field;
      }
      
      public function removeCurrent() : void
      {
         hasField$0 &= 4294967293;
         current$field = new int();
      }
      
      public function get hasCurrent() : Boolean
      {
         return (hasField$0 & 2) != 0;
      }
      
      public function set current(param1:int) : void
      {
         hasField$0 |= 2;
         current$field = param1;
      }
      
      public function get current() : int
      {
         return current$field;
      }
      
      public function removeTotal() : void
      {
         hasField$0 &= 4294967291;
         total$field = new int();
      }
      
      public function get hasTotal() : Boolean
      {
         return (hasField$0 & 4) != 0;
      }
      
      public function set total(param1:int) : void
      {
         hasField$0 |= 4;
         total$field = param1;
      }
      
      public function get total() : int
      {
         return total$field;
      }
      
      public function removeGuild() : void
      {
         guild$field = null;
      }
      
      public function get hasGuild() : Boolean
      {
         return guild$field != null;
      }
      
      public function set guild(param1:HugeHeadGuildMsg) : void
      {
         guild$field = param1;
      }
      
      public function get guild() : HugeHeadGuildMsg
      {
         return guild$field;
      }
      
      final override public function writeToBuffer(param1:WritingBuffer) : void
      {
         var _loc2_:* = 0;
         if(hasOp)
         {
            WriteUtils.writeTag(param1,0,1);
            WriteUtils.write$TYPE_INT32(param1,op$field);
         }
         if(hasCurrent)
         {
            WriteUtils.writeTag(param1,0,2);
            WriteUtils.write$TYPE_INT32(param1,current$field);
         }
         if(hasTotal)
         {
            WriteUtils.writeTag(param1,0,3);
            WriteUtils.write$TYPE_INT32(param1,total$field);
         }
         if(hasGuild)
         {
            WriteUtils.writeTag(param1,2,4);
            WriteUtils.write$TYPE_MESSAGE(param1,guild$field);
         }
         _loc2_ = 0;
         while(_loc2_ < seniorGeneralUser.length)
         {
            WriteUtils.writeTag(param1,2,5);
            WriteUtils.write$TYPE_MESSAGE(param1,seniorGeneralUser[_loc2_]);
            _loc2_++;
         }
      }
      
      final override public function readFromSlice(param1:IDataInput, param2:uint) : void
      {
         var _loc7_:* = 0;
         var _loc5_:StackHeadSeniorGeneralMsg = null;
         var _loc8_:uint = 0;
         var _loc4_:uint = 0;
         var _loc6_:uint = 0;
         var _loc3_:uint = 0;
         while(param1.bytesAvailable > param2)
         {
            switch(((_loc7_ = ReadUtils.read$TYPE_UINT32(param1)) >>> 3) - 1)
            {
               case 0:
                  if(_loc8_ != 0)
                  {
                     throw new IOError("Bad data format: StackHeadForceUserListMsg.op cannot be set twice.");
                  }
                  _loc8_++;
                  op = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 1:
                  if(_loc4_ != 0)
                  {
                     throw new IOError("Bad data format: StackHeadForceUserListMsg.current cannot be set twice.");
                  }
                  _loc4_++;
                  current = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 2:
                  if(_loc6_ != 0)
                  {
                     throw new IOError("Bad data format: StackHeadForceUserListMsg.total cannot be set twice.");
                  }
                  _loc6_++;
                  total = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 3:
                  if(_loc3_ != 0)
                  {
                     throw new IOError("Bad data format: StackHeadForceUserListMsg.guild cannot be set twice.");
                  }
                  _loc3_++;
                  guild = new HugeHeadGuildMsg();
                  ReadUtils.read$TYPE_MESSAGE(param1,guild);
                  break;
               case 4:
                  _loc5_ = new StackHeadSeniorGeneralMsg();
                  ReadUtils.read$TYPE_MESSAGE(param1,_loc5_);
                  seniorGeneralUser.push(_loc5_);
                  break;
               default:
                  ReadUtils.skip(param1,_loc7_ & 7);
            }
         }
      }
   }
}

