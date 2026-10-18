package com.road.yishi.proto.battle
{
   import com.netease.protobuf.Message;
   import com.netease.protobuf.ReadUtils;
   import com.netease.protobuf.WriteUtils;
   import com.netease.protobuf.WritingBuffer;
   import flash.errors.IOError;
   import flash.utils.IDataInput;
   import flash.utils.IExternalizable;
   
   public final class BattleStartMsg extends Message implements IExternalizable
   {
      
      private var frame$field:int;
      
      private var hasField$0:uint = 0;
      
      private var mainType$field:int;
      
      private var count_down$field:int;
      
      public function BattleStartMsg()
      {
         super();
      }
      
      public function removeFrame() : void
      {
         hasField$0 &= 4294967294;
         frame$field = new int();
      }
      
      public function get hasFrame() : Boolean
      {
         return (hasField$0 & 1) != 0;
      }
      
      public function set frame(param1:int) : void
      {
         hasField$0 |= 1;
         frame$field = param1;
      }
      
      public function get frame() : int
      {
         return frame$field;
      }
      
      public function removeMainType() : void
      {
         hasField$0 &= 4294967293;
         mainType$field = new int();
      }
      
      public function get hasMainType() : Boolean
      {
         return (hasField$0 & 2) != 0;
      }
      
      public function set mainType(param1:int) : void
      {
         hasField$0 |= 2;
         mainType$field = param1;
      }
      
      public function get mainType() : int
      {
         return mainType$field;
      }
      
      public function removeCountDown() : void
      {
         hasField$0 &= 4294967291;
         count_down$field = new int();
      }
      
      public function get hasCountDown() : Boolean
      {
         return (hasField$0 & 4) != 0;
      }
      
      public function set countDown(param1:int) : void
      {
         hasField$0 |= 4;
         count_down$field = param1;
      }
      
      public function get countDown() : int
      {
         return count_down$field;
      }
      
      final override public function writeToBuffer(param1:WritingBuffer) : void
      {
         if(hasFrame)
         {
            WriteUtils.writeTag(param1,0,1);
            WriteUtils.write$TYPE_INT32(param1,frame$field);
         }
         if(hasMainType)
         {
            WriteUtils.writeTag(param1,0,2);
            WriteUtils.write$TYPE_INT32(param1,mainType$field);
         }
         if(hasCountDown)
         {
            WriteUtils.writeTag(param1,0,3);
            WriteUtils.write$TYPE_INT32(param1,count_down$field);
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
                     throw new IOError("Bad data format: BattleStartMsg.frame cannot be set twice.");
                  }
                  _loc4_++;
                  frame = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 1:
                  if(_loc5_ != 0)
                  {
                     throw new IOError("Bad data format: BattleStartMsg.mainType cannot be set twice.");
                  }
                  _loc5_++;
                  mainType = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 2:
                  if(_loc3_ != 0)
                  {
                     throw new IOError("Bad data format: BattleStartMsg.countDown cannot be set twice.");
                  }
                  _loc3_++;
                  countDown = ReadUtils.read$TYPE_INT32(param1);
                  break;
               default:
                  ReadUtils.skip(param1,_loc6_ & 7);
            }
         }
      }
   }
}

