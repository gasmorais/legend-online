package com.road.yishi.proto.hugehead
{
   import com.netease.protobuf.Message;
   import com.netease.protobuf.ReadUtils;
   import com.netease.protobuf.WriteUtils;
   import com.netease.protobuf.WritingBuffer;
   import flash.errors.IOError;
   import flash.utils.IDataInput;
   import flash.utils.IExternalizable;
   
   public final class StackHeadSelfMsg extends Message implements IExternalizable
   {
      
      private var uid$field:String;
      
      private var action_point$field:int;
      
      private var hasField$0:uint = 0;
      
      private var ready_buff_count$field:int;
      
      public function StackHeadSelfMsg()
      {
         super();
      }
      
      public function removeUid() : void
      {
         uid$field = null;
      }
      
      public function get hasUid() : Boolean
      {
         return uid$field != null;
      }
      
      public function set uid(param1:String) : void
      {
         uid$field = param1;
      }
      
      public function get uid() : String
      {
         return uid$field;
      }
      
      public function removeActionPoint() : void
      {
         hasField$0 &= 4294967294;
         action_point$field = new int();
      }
      
      public function get hasActionPoint() : Boolean
      {
         return (hasField$0 & 1) != 0;
      }
      
      public function set actionPoint(param1:int) : void
      {
         hasField$0 |= 1;
         action_point$field = param1;
      }
      
      public function get actionPoint() : int
      {
         return action_point$field;
      }
      
      public function removeReadyBuffCount() : void
      {
         hasField$0 &= 4294967293;
         ready_buff_count$field = new int();
      }
      
      public function get hasReadyBuffCount() : Boolean
      {
         return (hasField$0 & 2) != 0;
      }
      
      public function set readyBuffCount(param1:int) : void
      {
         hasField$0 |= 2;
         ready_buff_count$field = param1;
      }
      
      public function get readyBuffCount() : int
      {
         return ready_buff_count$field;
      }
      
      final override public function writeToBuffer(param1:WritingBuffer) : void
      {
         if(hasUid)
         {
            WriteUtils.writeTag(param1,2,1);
            WriteUtils.write$TYPE_STRING(param1,uid$field);
         }
         if(hasActionPoint)
         {
            WriteUtils.writeTag(param1,0,2);
            WriteUtils.write$TYPE_INT32(param1,action_point$field);
         }
         if(hasReadyBuffCount)
         {
            WriteUtils.writeTag(param1,0,3);
            WriteUtils.write$TYPE_INT32(param1,ready_buff_count$field);
         }
      }
      
      final override public function readFromSlice(param1:IDataInput, param2:uint) : void
      {
         var _loc5_:* = 0;
         var _loc6_:uint = 0;
         var _loc3_:uint = 0;
         var _loc4_:uint = 0;
         while(param1.bytesAvailable > param2)
         {
            switch(((_loc5_ = ReadUtils.read$TYPE_UINT32(param1)) >>> 3) - 1)
            {
               case 0:
                  if(_loc6_ != 0)
                  {
                     throw new IOError("Bad data format: StackHeadSelfMsg.uid cannot be set twice.");
                  }
                  _loc6_++;
                  uid = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 1:
                  if(_loc3_ != 0)
                  {
                     throw new IOError("Bad data format: StackHeadSelfMsg.actionPoint cannot be set twice.");
                  }
                  _loc3_++;
                  actionPoint = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 2:
                  if(_loc4_ != 0)
                  {
                     throw new IOError("Bad data format: StackHeadSelfMsg.readyBuffCount cannot be set twice.");
                  }
                  _loc4_++;
                  readyBuffCount = ReadUtils.read$TYPE_INT32(param1);
                  break;
               default:
                  ReadUtils.skip(param1,_loc5_ & 7);
            }
         }
      }
   }
}

