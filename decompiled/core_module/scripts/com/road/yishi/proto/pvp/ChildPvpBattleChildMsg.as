package com.road.yishi.proto.pvp
{
   import com.netease.protobuf.Message;
   import com.netease.protobuf.ReadUtils;
   import com.netease.protobuf.WriteUtils;
   import com.netease.protobuf.WritingBuffer;
   import flash.errors.IOError;
   import flash.utils.IDataInput;
   import flash.utils.IExternalizable;
   
   public final class ChildPvpBattleChildMsg extends Message implements IExternalizable
   {
      
      private var side$field:int;
      
      private var hasField$0:uint = 0;
      
      private var pos$field:int;
      
      private var jobType$field:int;
      
      private var state$field:int;
      
      private var grade$field:int;
      
      public function ChildPvpBattleChildMsg()
      {
         super();
      }
      
      public function removeSide() : void
      {
         hasField$0 &= 4294967294;
         side$field = new int();
      }
      
      public function get hasSide() : Boolean
      {
         return (hasField$0 & 1) != 0;
      }
      
      public function set side(param1:int) : void
      {
         hasField$0 |= 1;
         side$field = param1;
      }
      
      public function get side() : int
      {
         return side$field;
      }
      
      public function removePos() : void
      {
         hasField$0 &= 4294967293;
         pos$field = new int();
      }
      
      public function get hasPos() : Boolean
      {
         return (hasField$0 & 2) != 0;
      }
      
      public function set pos(param1:int) : void
      {
         hasField$0 |= 2;
         pos$field = param1;
      }
      
      public function get pos() : int
      {
         return pos$field;
      }
      
      public function removeJobType() : void
      {
         hasField$0 &= 4294967291;
         jobType$field = new int();
      }
      
      public function get hasJobType() : Boolean
      {
         return (hasField$0 & 4) != 0;
      }
      
      public function set jobType(param1:int) : void
      {
         hasField$0 |= 4;
         jobType$field = param1;
      }
      
      public function get jobType() : int
      {
         return jobType$field;
      }
      
      public function removeState() : void
      {
         hasField$0 &= 4294967287;
         state$field = new int();
      }
      
      public function get hasState() : Boolean
      {
         return (hasField$0 & 8) != 0;
      }
      
      public function set state(param1:int) : void
      {
         hasField$0 |= 8;
         state$field = param1;
      }
      
      public function get state() : int
      {
         return state$field;
      }
      
      public function removeGrade() : void
      {
         hasField$0 &= 4294967279;
         grade$field = new int();
      }
      
      public function get hasGrade() : Boolean
      {
         return (hasField$0 & 0x10) != 0;
      }
      
      public function set grade(param1:int) : void
      {
         hasField$0 |= 16;
         grade$field = param1;
      }
      
      public function get grade() : int
      {
         return grade$field;
      }
      
      final override public function writeToBuffer(param1:WritingBuffer) : void
      {
         if(hasSide)
         {
            WriteUtils.writeTag(param1,0,1);
            WriteUtils.write$TYPE_INT32(param1,side$field);
         }
         if(hasPos)
         {
            WriteUtils.writeTag(param1,0,2);
            WriteUtils.write$TYPE_INT32(param1,pos$field);
         }
         if(hasJobType)
         {
            WriteUtils.writeTag(param1,0,3);
            WriteUtils.write$TYPE_INT32(param1,jobType$field);
         }
         if(hasState)
         {
            WriteUtils.writeTag(param1,0,4);
            WriteUtils.write$TYPE_INT32(param1,state$field);
         }
         if(hasGrade)
         {
            WriteUtils.writeTag(param1,0,5);
            WriteUtils.write$TYPE_INT32(param1,grade$field);
         }
      }
      
      final override public function readFromSlice(param1:IDataInput, param2:uint) : void
      {
         var _loc8_:* = 0;
         var _loc3_:uint = 0;
         var _loc7_:uint = 0;
         var _loc5_:uint = 0;
         var _loc6_:uint = 0;
         var _loc4_:uint = 0;
         while(param1.bytesAvailable > param2)
         {
            switch(((_loc8_ = ReadUtils.read$TYPE_UINT32(param1)) >>> 3) - 1)
            {
               case 0:
                  if(_loc3_ != 0)
                  {
                     throw new IOError("Bad data format: ChildPvpBattleChildMsg.side cannot be set twice.");
                  }
                  _loc3_++;
                  side = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 1:
                  if(_loc7_ != 0)
                  {
                     throw new IOError("Bad data format: ChildPvpBattleChildMsg.pos cannot be set twice.");
                  }
                  _loc7_++;
                  pos = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 2:
                  if(_loc5_ != 0)
                  {
                     throw new IOError("Bad data format: ChildPvpBattleChildMsg.jobType cannot be set twice.");
                  }
                  _loc5_++;
                  jobType = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 3:
                  if(_loc6_ != 0)
                  {
                     throw new IOError("Bad data format: ChildPvpBattleChildMsg.state cannot be set twice.");
                  }
                  _loc6_++;
                  state = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 4:
                  if(_loc4_ != 0)
                  {
                     throw new IOError("Bad data format: ChildPvpBattleChildMsg.grade cannot be set twice.");
                  }
                  _loc4_++;
                  grade = ReadUtils.read$TYPE_INT32(param1);
                  break;
               default:
                  ReadUtils.skip(param1,_loc8_ & 7);
            }
         }
      }
   }
}

