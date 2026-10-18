package com.road.yishi.proto.battle
{
   import com.netease.protobuf.Message;
   import com.netease.protobuf.ReadUtils;
   import com.netease.protobuf.WriteUtils;
   import com.netease.protobuf.WritingBuffer;
   import flash.errors.IOError;
   import flash.utils.IDataInput;
   import flash.utils.IExternalizable;
   
   public final class SkillStateMsg extends Message implements IExternalizable
   {
      
      private var skillId$field:int;
      
      private var hasField$0:uint = 0;
      
      private var state$field:int;
      
      private var index$field:int;
      
      public function SkillStateMsg()
      {
         super();
      }
      
      public function removeSkillId() : void
      {
         hasField$0 &= 4294967294;
         skillId$field = new int();
      }
      
      public function get hasSkillId() : Boolean
      {
         return (hasField$0 & 1) != 0;
      }
      
      public function set skillId(param1:int) : void
      {
         hasField$0 |= 1;
         skillId$field = param1;
      }
      
      public function get skillId() : int
      {
         return skillId$field;
      }
      
      public function removeState() : void
      {
         hasField$0 &= 4294967293;
         state$field = new int();
      }
      
      public function get hasState() : Boolean
      {
         return (hasField$0 & 2) != 0;
      }
      
      public function set state(param1:int) : void
      {
         hasField$0 |= 2;
         state$field = param1;
      }
      
      public function get state() : int
      {
         return state$field;
      }
      
      public function removeIndex() : void
      {
         hasField$0 &= 4294967291;
         index$field = new int();
      }
      
      public function get hasIndex() : Boolean
      {
         return (hasField$0 & 4) != 0;
      }
      
      public function set index(param1:int) : void
      {
         hasField$0 |= 4;
         index$field = param1;
      }
      
      public function get index() : int
      {
         return index$field;
      }
      
      final override public function writeToBuffer(param1:WritingBuffer) : void
      {
         if(hasSkillId)
         {
            WriteUtils.writeTag(param1,0,1);
            WriteUtils.write$TYPE_INT32(param1,skillId$field);
         }
         if(hasState)
         {
            WriteUtils.writeTag(param1,0,2);
            WriteUtils.write$TYPE_INT32(param1,state$field);
         }
         if(hasIndex)
         {
            WriteUtils.writeTag(param1,0,3);
            WriteUtils.write$TYPE_INT32(param1,index$field);
         }
      }
      
      final override public function readFromSlice(param1:IDataInput, param2:uint) : void
      {
         var _loc6_:* = 0;
         var _loc4_:uint = 0;
         var _loc5_:uint = 0;
         var _loc3_:uint = 0;
         while(param1.bytesAvailable > param2)
         {
            switch(((_loc6_ = ReadUtils.read$TYPE_UINT32(param1)) >>> 3) - 1)
            {
               case 0:
                  if(_loc4_ != 0)
                  {
                     throw new IOError("Bad data format: SkillStateMsg.skillId cannot be set twice.");
                  }
                  _loc4_++;
                  skillId = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 1:
                  if(_loc5_ != 0)
                  {
                     throw new IOError("Bad data format: SkillStateMsg.state cannot be set twice.");
                  }
                  _loc5_++;
                  state = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 2:
                  if(_loc3_ != 0)
                  {
                     throw new IOError("Bad data format: SkillStateMsg.index cannot be set twice.");
                  }
                  _loc3_++;
                  index = ReadUtils.read$TYPE_INT32(param1);
                  break;
               default:
                  ReadUtils.skip(param1,_loc6_ & 7);
            }
         }
      }
   }
}

