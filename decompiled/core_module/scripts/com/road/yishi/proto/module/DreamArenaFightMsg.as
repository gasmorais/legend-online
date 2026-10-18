package com.road.yishi.proto.module
{
   import com.netease.protobuf.Message;
   import com.netease.protobuf.ReadUtils;
   import com.netease.protobuf.WriteUtils;
   import com.netease.protobuf.WritingBuffer;
   import flash.errors.IOError;
   import flash.utils.IDataInput;
   import flash.utils.IExternalizable;
   
   public final class DreamArenaFightMsg extends Message implements IExternalizable
   {
      
      private var isOpen$field:Boolean;
      
      private var hasField$0:uint = 0;
      
      private var winCount$field:int;
      
      private var lostCount$field:int;
      
      private var isReport$field:Boolean;
      
      public function DreamArenaFightMsg()
      {
         super();
      }
      
      public function removeIsOpen() : void
      {
         hasField$0 &= 4294967294;
         isOpen$field = new Boolean();
      }
      
      public function get hasIsOpen() : Boolean
      {
         return (hasField$0 & 1) != 0;
      }
      
      public function set isOpen(param1:Boolean) : void
      {
         hasField$0 |= 1;
         isOpen$field = param1;
      }
      
      public function get isOpen() : Boolean
      {
         return isOpen$field;
      }
      
      public function removeWinCount() : void
      {
         hasField$0 &= 4294967293;
         winCount$field = new int();
      }
      
      public function get hasWinCount() : Boolean
      {
         return (hasField$0 & 2) != 0;
      }
      
      public function set winCount(param1:int) : void
      {
         hasField$0 |= 2;
         winCount$field = param1;
      }
      
      public function get winCount() : int
      {
         return winCount$field;
      }
      
      public function removeLostCount() : void
      {
         hasField$0 &= 4294967291;
         lostCount$field = new int();
      }
      
      public function get hasLostCount() : Boolean
      {
         return (hasField$0 & 4) != 0;
      }
      
      public function set lostCount(param1:int) : void
      {
         hasField$0 |= 4;
         lostCount$field = param1;
      }
      
      public function get lostCount() : int
      {
         return lostCount$field;
      }
      
      public function removeIsReport() : void
      {
         hasField$0 &= 4294967287;
         isReport$field = new Boolean();
      }
      
      public function get hasIsReport() : Boolean
      {
         return (hasField$0 & 8) != 0;
      }
      
      public function set isReport(param1:Boolean) : void
      {
         hasField$0 |= 8;
         isReport$field = param1;
      }
      
      public function get isReport() : Boolean
      {
         return isReport$field;
      }
      
      final override public function writeToBuffer(param1:WritingBuffer) : void
      {
         if(hasIsOpen)
         {
            WriteUtils.writeTag(param1,0,1);
            WriteUtils.write$TYPE_BOOL(param1,isOpen$field);
         }
         if(hasWinCount)
         {
            WriteUtils.writeTag(param1,0,2);
            WriteUtils.write$TYPE_INT32(param1,winCount$field);
         }
         if(hasLostCount)
         {
            WriteUtils.writeTag(param1,0,3);
            WriteUtils.write$TYPE_INT32(param1,lostCount$field);
         }
         if(hasIsReport)
         {
            WriteUtils.writeTag(param1,0,4);
            WriteUtils.write$TYPE_BOOL(param1,isReport$field);
         }
      }
      
      final override public function readFromSlice(param1:IDataInput, param2:uint) : void
      {
         var _loc6_:* = 0;
         var _loc4_:uint = 0;
         var _loc3_:uint = 0;
         var _loc7_:uint = 0;
         var _loc5_:uint = 0;
         while(param1.bytesAvailable > param2)
         {
            switch(((_loc6_ = ReadUtils.read$TYPE_UINT32(param1)) >>> 3) - 1)
            {
               case 0:
                  if(_loc4_ != 0)
                  {
                     throw new IOError("Bad data format: DreamArenaFightMsg.isOpen cannot be set twice.");
                  }
                  _loc4_++;
                  isOpen = ReadUtils.read$TYPE_BOOL(param1);
                  break;
               case 1:
                  if(_loc3_ != 0)
                  {
                     throw new IOError("Bad data format: DreamArenaFightMsg.winCount cannot be set twice.");
                  }
                  _loc3_++;
                  winCount = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 2:
                  if(_loc7_ != 0)
                  {
                     throw new IOError("Bad data format: DreamArenaFightMsg.lostCount cannot be set twice.");
                  }
                  _loc7_++;
                  lostCount = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 3:
                  if(_loc5_ != 0)
                  {
                     throw new IOError("Bad data format: DreamArenaFightMsg.isReport cannot be set twice.");
                  }
                  _loc5_++;
                  isReport = ReadUtils.read$TYPE_BOOL(param1);
                  break;
               default:
                  ReadUtils.skip(param1,_loc6_ & 7);
            }
         }
      }
   }
}

