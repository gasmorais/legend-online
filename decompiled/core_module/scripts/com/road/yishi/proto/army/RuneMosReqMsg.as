package com.road.yishi.proto.army
{
   import com.netease.protobuf.Message;
   import com.netease.protobuf.ReadUtils;
   import com.netease.protobuf.WriteUtils;
   import com.netease.protobuf.WritingBuffer;
   import flash.errors.IOError;
   import flash.utils.IDataInput;
   import flash.utils.IExternalizable;
   
   public final class RuneMosReqMsg extends Message implements IExternalizable
   {
      
      private var runeId$field:int;
      
      private var hasField$0:uint = 0;
      
      private var runeIndex$field:int;
      
      private var runeStoneId$field:int;
      
      private var beginPos$field:int;
      
      public function RuneMosReqMsg()
      {
         super();
      }
      
      public function removeRuneId() : void
      {
         hasField$0 &= 4294967294;
         runeId$field = new int();
      }
      
      public function get hasRuneId() : Boolean
      {
         return (hasField$0 & 1) != 0;
      }
      
      public function set runeId(param1:int) : void
      {
         hasField$0 |= 1;
         runeId$field = param1;
      }
      
      public function get runeId() : int
      {
         return runeId$field;
      }
      
      public function removeRuneIndex() : void
      {
         hasField$0 &= 4294967293;
         runeIndex$field = new int();
      }
      
      public function get hasRuneIndex() : Boolean
      {
         return (hasField$0 & 2) != 0;
      }
      
      public function set runeIndex(param1:int) : void
      {
         hasField$0 |= 2;
         runeIndex$field = param1;
      }
      
      public function get runeIndex() : int
      {
         return runeIndex$field;
      }
      
      public function removeRuneStoneId() : void
      {
         hasField$0 &= 4294967291;
         runeStoneId$field = new int();
      }
      
      public function get hasRuneStoneId() : Boolean
      {
         return (hasField$0 & 4) != 0;
      }
      
      public function set runeStoneId(param1:int) : void
      {
         hasField$0 |= 4;
         runeStoneId$field = param1;
      }
      
      public function get runeStoneId() : int
      {
         return runeStoneId$field;
      }
      
      public function removeBeginPos() : void
      {
         hasField$0 &= 4294967287;
         beginPos$field = new int();
      }
      
      public function get hasBeginPos() : Boolean
      {
         return (hasField$0 & 8) != 0;
      }
      
      public function set beginPos(param1:int) : void
      {
         hasField$0 |= 8;
         beginPos$field = param1;
      }
      
      public function get beginPos() : int
      {
         return beginPos$field;
      }
      
      final override public function writeToBuffer(param1:WritingBuffer) : void
      {
         if(hasRuneId)
         {
            WriteUtils.writeTag(param1,0,1);
            WriteUtils.write$TYPE_INT32(param1,runeId$field);
         }
         if(hasRuneIndex)
         {
            WriteUtils.writeTag(param1,0,2);
            WriteUtils.write$TYPE_INT32(param1,runeIndex$field);
         }
         if(hasRuneStoneId)
         {
            WriteUtils.writeTag(param1,0,3);
            WriteUtils.write$TYPE_INT32(param1,runeStoneId$field);
         }
         if(hasBeginPos)
         {
            WriteUtils.writeTag(param1,0,4);
            WriteUtils.write$TYPE_INT32(param1,beginPos$field);
         }
      }
      
      final override public function readFromSlice(param1:IDataInput, param2:uint) : void
      {
         var _loc6_:* = 0;
         var _loc5_:uint = 0;
         var _loc7_:uint = 0;
         var _loc4_:uint = 0;
         var _loc3_:uint = 0;
         while(param1.bytesAvailable > param2)
         {
            switch(((_loc6_ = ReadUtils.read$TYPE_UINT32(param1)) >>> 3) - 1)
            {
               case 0:
                  if(_loc5_ != 0)
                  {
                     throw new IOError("Bad data format: RuneMosReqMsg.runeId cannot be set twice.");
                  }
                  _loc5_++;
                  runeId = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 1:
                  if(_loc7_ != 0)
                  {
                     throw new IOError("Bad data format: RuneMosReqMsg.runeIndex cannot be set twice.");
                  }
                  _loc7_++;
                  runeIndex = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 2:
                  if(_loc4_ != 0)
                  {
                     throw new IOError("Bad data format: RuneMosReqMsg.runeStoneId cannot be set twice.");
                  }
                  _loc4_++;
                  runeStoneId = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 3:
                  if(_loc3_ != 0)
                  {
                     throw new IOError("Bad data format: RuneMosReqMsg.beginPos cannot be set twice.");
                  }
                  _loc3_++;
                  beginPos = ReadUtils.read$TYPE_INT32(param1);
                  break;
               default:
                  ReadUtils.skip(param1,_loc6_ & 7);
            }
         }
      }
   }
}

