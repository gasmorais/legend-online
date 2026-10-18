package com.road.yishi.proto.airgarden
{
   import com.netease.protobuf.Message;
   import com.netease.protobuf.ReadUtils;
   import com.netease.protobuf.WriteUtils;
   import com.netease.protobuf.WritingBuffer;
   import flash.errors.IOError;
   import flash.utils.IDataInput;
   import flash.utils.IExternalizable;
   
   public final class AirGardenSelfMsg extends Message implements IExternalizable
   {
      
      private var gameRemain$field:int;
      
      private var hasField$0:uint = 0;
      
      private var extraGameCount$field:int;
      
      private var selfScore$field:int;
      
      private var thisUpCount$field:int;
      
      public function AirGardenSelfMsg()
      {
         super();
      }
      
      public function removeGameRemain() : void
      {
         hasField$0 &= 4294967294;
         gameRemain$field = new int();
      }
      
      public function get hasGameRemain() : Boolean
      {
         return (hasField$0 & 1) != 0;
      }
      
      public function set gameRemain(param1:int) : void
      {
         hasField$0 |= 1;
         gameRemain$field = param1;
      }
      
      public function get gameRemain() : int
      {
         return gameRemain$field;
      }
      
      public function removeExtraGameCount() : void
      {
         hasField$0 &= 4294967293;
         extraGameCount$field = new int();
      }
      
      public function get hasExtraGameCount() : Boolean
      {
         return (hasField$0 & 2) != 0;
      }
      
      public function set extraGameCount(param1:int) : void
      {
         hasField$0 |= 2;
         extraGameCount$field = param1;
      }
      
      public function get extraGameCount() : int
      {
         return extraGameCount$field;
      }
      
      public function removeSelfScore() : void
      {
         hasField$0 &= 4294967291;
         selfScore$field = new int();
      }
      
      public function get hasSelfScore() : Boolean
      {
         return (hasField$0 & 4) != 0;
      }
      
      public function set selfScore(param1:int) : void
      {
         hasField$0 |= 4;
         selfScore$field = param1;
      }
      
      public function get selfScore() : int
      {
         return selfScore$field;
      }
      
      public function removeThisUpCount() : void
      {
         hasField$0 &= 4294967287;
         thisUpCount$field = new int();
      }
      
      public function get hasThisUpCount() : Boolean
      {
         return (hasField$0 & 8) != 0;
      }
      
      public function set thisUpCount(param1:int) : void
      {
         hasField$0 |= 8;
         thisUpCount$field = param1;
      }
      
      public function get thisUpCount() : int
      {
         return thisUpCount$field;
      }
      
      final override public function writeToBuffer(param1:WritingBuffer) : void
      {
         if(hasGameRemain)
         {
            WriteUtils.writeTag(param1,0,2);
            WriteUtils.write$TYPE_INT32(param1,gameRemain$field);
         }
         if(hasExtraGameCount)
         {
            WriteUtils.writeTag(param1,0,3);
            WriteUtils.write$TYPE_INT32(param1,extraGameCount$field);
         }
         if(hasSelfScore)
         {
            WriteUtils.writeTag(param1,0,4);
            WriteUtils.write$TYPE_INT32(param1,selfScore$field);
         }
         if(hasThisUpCount)
         {
            WriteUtils.writeTag(param1,0,5);
            WriteUtils.write$TYPE_INT32(param1,thisUpCount$field);
         }
      }
      
      final override public function readFromSlice(param1:IDataInput, param2:uint) : void
      {
         var _loc6_:* = 0;
         var _loc7_:uint = 0;
         var _loc5_:uint = 0;
         var _loc4_:uint = 0;
         var _loc3_:uint = 0;
         while(param1.bytesAvailable > param2)
         {
            switch(((_loc6_ = ReadUtils.read$TYPE_UINT32(param1)) >>> 3) - 2)
            {
               case 0:
                  if(_loc7_ != 0)
                  {
                     throw new IOError("Bad data format: AirGardenSelfMsg.gameRemain cannot be set twice.");
                  }
                  _loc7_++;
                  gameRemain = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 1:
                  if(_loc5_ != 0)
                  {
                     throw new IOError("Bad data format: AirGardenSelfMsg.extraGameCount cannot be set twice.");
                  }
                  _loc5_++;
                  extraGameCount = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 2:
                  if(_loc4_ != 0)
                  {
                     throw new IOError("Bad data format: AirGardenSelfMsg.selfScore cannot be set twice.");
                  }
                  _loc4_++;
                  selfScore = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 3:
                  if(_loc3_ != 0)
                  {
                     throw new IOError("Bad data format: AirGardenSelfMsg.thisUpCount cannot be set twice.");
                  }
                  _loc3_++;
                  thisUpCount = ReadUtils.read$TYPE_INT32(param1);
                  break;
               default:
                  ReadUtils.skip(param1,_loc6_ & 7);
            }
         }
      }
   }
}

