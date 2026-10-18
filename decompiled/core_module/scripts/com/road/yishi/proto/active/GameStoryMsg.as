package com.road.yishi.proto.active
{
   import com.netease.protobuf.Message;
   import com.netease.protobuf.ReadUtils;
   import com.netease.protobuf.WriteUtils;
   import com.netease.protobuf.WritingBuffer;
   import flash.errors.IOError;
   import flash.utils.IDataInput;
   import flash.utils.IExternalizable;
   
   public final class GameStoryMsg extends Message implements IExternalizable
   {
      
      private var is_access$field:Boolean;
      
      private var hasField$0:uint = 0;
      
      private var index$field:int;
      
      private var is_drop$field:Boolean;
      
      public function GameStoryMsg()
      {
         super();
      }
      
      public function removeIsAccess() : void
      {
         hasField$0 &= 4294967294;
         is_access$field = new Boolean();
      }
      
      public function get hasIsAccess() : Boolean
      {
         return (hasField$0 & 1) != 0;
      }
      
      public function set isAccess(param1:Boolean) : void
      {
         hasField$0 |= 1;
         is_access$field = param1;
      }
      
      public function get isAccess() : Boolean
      {
         return is_access$field;
      }
      
      public function removeIndex() : void
      {
         hasField$0 &= 4294967293;
         index$field = new int();
      }
      
      public function get hasIndex() : Boolean
      {
         return (hasField$0 & 2) != 0;
      }
      
      public function set index(param1:int) : void
      {
         hasField$0 |= 2;
         index$field = param1;
      }
      
      public function get index() : int
      {
         return index$field;
      }
      
      public function removeIsDrop() : void
      {
         hasField$0 &= 4294967291;
         is_drop$field = new Boolean();
      }
      
      public function get hasIsDrop() : Boolean
      {
         return (hasField$0 & 4) != 0;
      }
      
      public function set isDrop(param1:Boolean) : void
      {
         hasField$0 |= 4;
         is_drop$field = param1;
      }
      
      public function get isDrop() : Boolean
      {
         return is_drop$field;
      }
      
      final override public function writeToBuffer(param1:WritingBuffer) : void
      {
         if(hasIsAccess)
         {
            WriteUtils.writeTag(param1,0,1);
            WriteUtils.write$TYPE_BOOL(param1,is_access$field);
         }
         if(hasIndex)
         {
            WriteUtils.writeTag(param1,0,2);
            WriteUtils.write$TYPE_INT32(param1,index$field);
         }
         if(hasIsDrop)
         {
            WriteUtils.writeTag(param1,0,3);
            WriteUtils.write$TYPE_BOOL(param1,is_drop$field);
         }
      }
      
      final override public function readFromSlice(param1:IDataInput, param2:uint) : void
      {
         var _loc6_:* = 0;
         var _loc4_:uint = 0;
         var _loc3_:uint = 0;
         var _loc5_:uint = 0;
         while(param1.bytesAvailable > param2)
         {
            switch(((_loc6_ = ReadUtils.read$TYPE_UINT32(param1)) >>> 3) - 1)
            {
               case 0:
                  if(_loc4_ != 0)
                  {
                     throw new IOError("Bad data format: GameStoryMsg.isAccess cannot be set twice.");
                  }
                  _loc4_++;
                  isAccess = ReadUtils.read$TYPE_BOOL(param1);
                  break;
               case 1:
                  if(_loc3_ != 0)
                  {
                     throw new IOError("Bad data format: GameStoryMsg.index cannot be set twice.");
                  }
                  _loc3_++;
                  index = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 2:
                  if(_loc5_ != 0)
                  {
                     throw new IOError("Bad data format: GameStoryMsg.isDrop cannot be set twice.");
                  }
                  _loc5_++;
                  isDrop = ReadUtils.read$TYPE_BOOL(param1);
                  break;
               default:
                  ReadUtils.skip(param1,_loc6_ & 7);
            }
         }
      }
   }
}

