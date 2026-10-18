package com.road.yishi.proto.children
{
   import com.netease.protobuf.Message;
   import com.netease.protobuf.ReadUtils;
   import com.netease.protobuf.WriteUtils;
   import com.netease.protobuf.WritingBuffer;
   import flash.errors.IOError;
   import flash.utils.IDataInput;
   import flash.utils.IExternalizable;
   
   public final class ChildrenApplyMsg extends Message implements IExternalizable
   {
      
      private var userId_a$field:int;
      
      private var hasField$0:uint = 0;
      
      private var userId_b$field:int;
      
      private var state$field:int;
      
      private var is_apply$field:Boolean;
      
      private var apply_time$field:String;
      
      public function ChildrenApplyMsg()
      {
         super();
      }
      
      public function removeUserIdA() : void
      {
         hasField$0 &= 4294967294;
         userId_a$field = new int();
      }
      
      public function get hasUserIdA() : Boolean
      {
         return (hasField$0 & 1) != 0;
      }
      
      public function set userIdA(param1:int) : void
      {
         hasField$0 |= 1;
         userId_a$field = param1;
      }
      
      public function get userIdA() : int
      {
         return userId_a$field;
      }
      
      public function removeUserIdB() : void
      {
         hasField$0 &= 4294967293;
         userId_b$field = new int();
      }
      
      public function get hasUserIdB() : Boolean
      {
         return (hasField$0 & 2) != 0;
      }
      
      public function set userIdB(param1:int) : void
      {
         hasField$0 |= 2;
         userId_b$field = param1;
      }
      
      public function get userIdB() : int
      {
         return userId_b$field;
      }
      
      public function removeState() : void
      {
         hasField$0 &= 4294967291;
         state$field = new int();
      }
      
      public function get hasState() : Boolean
      {
         return (hasField$0 & 4) != 0;
      }
      
      public function set state(param1:int) : void
      {
         hasField$0 |= 4;
         state$field = param1;
      }
      
      public function get state() : int
      {
         return state$field;
      }
      
      public function removeIsApply() : void
      {
         hasField$0 &= 4294967287;
         is_apply$field = new Boolean();
      }
      
      public function get hasIsApply() : Boolean
      {
         return (hasField$0 & 8) != 0;
      }
      
      public function set isApply(param1:Boolean) : void
      {
         hasField$0 |= 8;
         is_apply$field = param1;
      }
      
      public function get isApply() : Boolean
      {
         return is_apply$field;
      }
      
      public function removeApplyTime() : void
      {
         apply_time$field = null;
      }
      
      public function get hasApplyTime() : Boolean
      {
         return apply_time$field != null;
      }
      
      public function set applyTime(param1:String) : void
      {
         apply_time$field = param1;
      }
      
      public function get applyTime() : String
      {
         return apply_time$field;
      }
      
      final override public function writeToBuffer(param1:WritingBuffer) : void
      {
         if(hasUserIdA)
         {
            WriteUtils.writeTag(param1,0,1);
            WriteUtils.write$TYPE_INT32(param1,userId_a$field);
         }
         if(hasUserIdB)
         {
            WriteUtils.writeTag(param1,0,2);
            WriteUtils.write$TYPE_INT32(param1,userId_b$field);
         }
         if(hasState)
         {
            WriteUtils.writeTag(param1,0,3);
            WriteUtils.write$TYPE_INT32(param1,state$field);
         }
         if(hasIsApply)
         {
            WriteUtils.writeTag(param1,0,4);
            WriteUtils.write$TYPE_BOOL(param1,is_apply$field);
         }
         if(hasApplyTime)
         {
            WriteUtils.writeTag(param1,2,5);
            WriteUtils.write$TYPE_STRING(param1,apply_time$field);
         }
      }
      
      final override public function readFromSlice(param1:IDataInput, param2:uint) : void
      {
         var _loc7_:* = 0;
         var _loc5_:uint = 0;
         var _loc8_:uint = 0;
         var _loc6_:uint = 0;
         var _loc3_:uint = 0;
         var _loc4_:uint = 0;
         while(param1.bytesAvailable > param2)
         {
            switch(((_loc7_ = ReadUtils.read$TYPE_UINT32(param1)) >>> 3) - 1)
            {
               case 0:
                  if(_loc5_ != 0)
                  {
                     throw new IOError("Bad data format: ChildrenApplyMsg.userIdA cannot be set twice.");
                  }
                  _loc5_++;
                  userIdA = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 1:
                  if(_loc8_ != 0)
                  {
                     throw new IOError("Bad data format: ChildrenApplyMsg.userIdB cannot be set twice.");
                  }
                  _loc8_++;
                  userIdB = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 2:
                  if(_loc6_ != 0)
                  {
                     throw new IOError("Bad data format: ChildrenApplyMsg.state cannot be set twice.");
                  }
                  _loc6_++;
                  state = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 3:
                  if(_loc3_ != 0)
                  {
                     throw new IOError("Bad data format: ChildrenApplyMsg.isApply cannot be set twice.");
                  }
                  _loc3_++;
                  isApply = ReadUtils.read$TYPE_BOOL(param1);
                  break;
               case 4:
                  if(_loc4_ != 0)
                  {
                     throw new IOError("Bad data format: ChildrenApplyMsg.applyTime cannot be set twice.");
                  }
                  _loc4_++;
                  applyTime = ReadUtils.read$TYPE_STRING(param1);
                  break;
               default:
                  ReadUtils.skip(param1,_loc7_ & 7);
            }
         }
      }
   }
}

