package com.road.yishi.proto.goldenroad
{
   import com.netease.protobuf.Message;
   import com.netease.protobuf.ReadUtils;
   import com.netease.protobuf.WriteUtils;
   import com.netease.protobuf.WritingBuffer;
   import flash.errors.IOError;
   import flash.utils.IDataInput;
   import flash.utils.IExternalizable;
   
   public final class GoldenRoadClientRequestMsg extends Message implements IExternalizable
   {
      
      private var consumeType$field:int;
      
      private var hasField$0:uint = 0;
      
      private var diceType$field:int;
      
      private var refreshType$field:int;
      
      private var requestBroadcast$field:Boolean;
      
      private var bagOPType$field:int;
      
      private var isBatch$field:Boolean;
      
      public function GoldenRoadClientRequestMsg()
      {
         super();
      }
      
      public function removeConsumeType() : void
      {
         hasField$0 &= 4294967294;
         consumeType$field = new int();
      }
      
      public function get hasConsumeType() : Boolean
      {
         return (hasField$0 & 1) != 0;
      }
      
      public function set consumeType(param1:int) : void
      {
         hasField$0 |= 1;
         consumeType$field = param1;
      }
      
      public function get consumeType() : int
      {
         return consumeType$field;
      }
      
      public function removeDiceType() : void
      {
         hasField$0 &= 4294967293;
         diceType$field = new int();
      }
      
      public function get hasDiceType() : Boolean
      {
         return (hasField$0 & 2) != 0;
      }
      
      public function set diceType(param1:int) : void
      {
         hasField$0 |= 2;
         diceType$field = param1;
      }
      
      public function get diceType() : int
      {
         return diceType$field;
      }
      
      public function removeRefreshType() : void
      {
         hasField$0 &= 4294967291;
         refreshType$field = new int();
      }
      
      public function get hasRefreshType() : Boolean
      {
         return (hasField$0 & 4) != 0;
      }
      
      public function set refreshType(param1:int) : void
      {
         hasField$0 |= 4;
         refreshType$field = param1;
      }
      
      public function get refreshType() : int
      {
         return refreshType$field;
      }
      
      public function removeRequestBroadcast() : void
      {
         hasField$0 &= 4294967287;
         requestBroadcast$field = new Boolean();
      }
      
      public function get hasRequestBroadcast() : Boolean
      {
         return (hasField$0 & 8) != 0;
      }
      
      public function set requestBroadcast(param1:Boolean) : void
      {
         hasField$0 |= 8;
         requestBroadcast$field = param1;
      }
      
      public function get requestBroadcast() : Boolean
      {
         return requestBroadcast$field;
      }
      
      public function removeBagOPType() : void
      {
         hasField$0 &= 4294967279;
         bagOPType$field = new int();
      }
      
      public function get hasBagOPType() : Boolean
      {
         return (hasField$0 & 0x10) != 0;
      }
      
      public function set bagOPType(param1:int) : void
      {
         hasField$0 |= 16;
         bagOPType$field = param1;
      }
      
      public function get bagOPType() : int
      {
         return bagOPType$field;
      }
      
      public function removeIsBatch() : void
      {
         hasField$0 &= 4294967263;
         isBatch$field = new Boolean();
      }
      
      public function get hasIsBatch() : Boolean
      {
         return (hasField$0 & 0x20) != 0;
      }
      
      public function set isBatch(param1:Boolean) : void
      {
         hasField$0 |= 32;
         isBatch$field = param1;
      }
      
      public function get isBatch() : Boolean
      {
         return isBatch$field;
      }
      
      final override public function writeToBuffer(param1:WritingBuffer) : void
      {
         if(hasConsumeType)
         {
            WriteUtils.writeTag(param1,0,1);
            WriteUtils.write$TYPE_INT32(param1,consumeType$field);
         }
         if(hasDiceType)
         {
            WriteUtils.writeTag(param1,0,2);
            WriteUtils.write$TYPE_INT32(param1,diceType$field);
         }
         if(hasRefreshType)
         {
            WriteUtils.writeTag(param1,0,3);
            WriteUtils.write$TYPE_INT32(param1,refreshType$field);
         }
         if(hasRequestBroadcast)
         {
            WriteUtils.writeTag(param1,0,4);
            WriteUtils.write$TYPE_BOOL(param1,requestBroadcast$field);
         }
         if(hasBagOPType)
         {
            WriteUtils.writeTag(param1,0,5);
            WriteUtils.write$TYPE_INT32(param1,bagOPType$field);
         }
         if(hasIsBatch)
         {
            WriteUtils.writeTag(param1,0,6);
            WriteUtils.write$TYPE_BOOL(param1,isBatch$field);
         }
      }
      
      final override public function readFromSlice(param1:IDataInput, param2:uint) : void
      {
         var _loc9_:* = 0;
         var _loc7_:uint = 0;
         var _loc3_:uint = 0;
         var _loc8_:uint = 0;
         var _loc5_:uint = 0;
         var _loc6_:uint = 0;
         var _loc4_:uint = 0;
         while(param1.bytesAvailable > param2)
         {
            switch(((_loc9_ = ReadUtils.read$TYPE_UINT32(param1)) >>> 3) - 1)
            {
               case 0:
                  if(_loc7_ != 0)
                  {
                     throw new IOError("Bad data format: GoldenRoadClientRequestMsg.consumeType cannot be set twice.");
                  }
                  _loc7_++;
                  consumeType = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 1:
                  if(_loc3_ != 0)
                  {
                     throw new IOError("Bad data format: GoldenRoadClientRequestMsg.diceType cannot be set twice.");
                  }
                  _loc3_++;
                  diceType = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 2:
                  if(_loc8_ != 0)
                  {
                     throw new IOError("Bad data format: GoldenRoadClientRequestMsg.refreshType cannot be set twice.");
                  }
                  _loc8_++;
                  refreshType = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 3:
                  if(_loc5_ != 0)
                  {
                     throw new IOError("Bad data format: GoldenRoadClientRequestMsg.requestBroadcast cannot be set twice.");
                  }
                  _loc5_++;
                  requestBroadcast = ReadUtils.read$TYPE_BOOL(param1);
                  break;
               case 4:
                  if(_loc6_ != 0)
                  {
                     throw new IOError("Bad data format: GoldenRoadClientRequestMsg.bagOPType cannot be set twice.");
                  }
                  _loc6_++;
                  bagOPType = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 5:
                  if(_loc4_ != 0)
                  {
                     throw new IOError("Bad data format: GoldenRoadClientRequestMsg.isBatch cannot be set twice.");
                  }
                  _loc4_++;
                  isBatch = ReadUtils.read$TYPE_BOOL(param1);
                  break;
               default:
                  ReadUtils.skip(param1,_loc9_ & 7);
            }
         }
      }
   }
}

