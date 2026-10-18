package com.road.yishi.proto.active
{
   import com.netease.protobuf.Message;
   import com.netease.protobuf.ReadUtils;
   import com.netease.protobuf.WriteUtils;
   import com.netease.protobuf.WritingBuffer;
   import flash.errors.IOError;
   import flash.utils.IDataInput;
   import flash.utils.IExternalizable;
   
   public final class SacrificeRspMsg extends Message implements IExternalizable
   {
      
      private var opType$field:int;
      
      private var hasField$0:uint = 0;
      
      private var godsFavor$field:int;
      
      private var godsReward$field:int;
      
      private var times$field:int;
      
      private var tempIds$field:String;
      
      private var count$field:int;
      
      public function SacrificeRspMsg()
      {
         super();
      }
      
      public function removeOpType() : void
      {
         hasField$0 &= 4294967294;
         opType$field = new int();
      }
      
      public function get hasOpType() : Boolean
      {
         return (hasField$0 & 1) != 0;
      }
      
      public function set opType(param1:int) : void
      {
         hasField$0 |= 1;
         opType$field = param1;
      }
      
      public function get opType() : int
      {
         return opType$field;
      }
      
      public function removeGodsFavor() : void
      {
         hasField$0 &= 4294967293;
         godsFavor$field = new int();
      }
      
      public function get hasGodsFavor() : Boolean
      {
         return (hasField$0 & 2) != 0;
      }
      
      public function set godsFavor(param1:int) : void
      {
         hasField$0 |= 2;
         godsFavor$field = param1;
      }
      
      public function get godsFavor() : int
      {
         return godsFavor$field;
      }
      
      public function removeGodsReward() : void
      {
         hasField$0 &= 4294967291;
         godsReward$field = new int();
      }
      
      public function get hasGodsReward() : Boolean
      {
         return (hasField$0 & 4) != 0;
      }
      
      public function set godsReward(param1:int) : void
      {
         hasField$0 |= 4;
         godsReward$field = param1;
      }
      
      public function get godsReward() : int
      {
         return godsReward$field;
      }
      
      public function removeTimes() : void
      {
         hasField$0 &= 4294967287;
         times$field = new int();
      }
      
      public function get hasTimes() : Boolean
      {
         return (hasField$0 & 8) != 0;
      }
      
      public function set times(param1:int) : void
      {
         hasField$0 |= 8;
         times$field = param1;
      }
      
      public function get times() : int
      {
         return times$field;
      }
      
      public function removeTempIds() : void
      {
         tempIds$field = null;
      }
      
      public function get hasTempIds() : Boolean
      {
         return tempIds$field != null;
      }
      
      public function set tempIds(param1:String) : void
      {
         tempIds$field = param1;
      }
      
      public function get tempIds() : String
      {
         return tempIds$field;
      }
      
      public function removeCount() : void
      {
         hasField$0 &= 4294967279;
         count$field = new int();
      }
      
      public function get hasCount() : Boolean
      {
         return (hasField$0 & 0x10) != 0;
      }
      
      public function set count(param1:int) : void
      {
         hasField$0 |= 16;
         count$field = param1;
      }
      
      public function get count() : int
      {
         return count$field;
      }
      
      final override public function writeToBuffer(param1:WritingBuffer) : void
      {
         if(hasOpType)
         {
            WriteUtils.writeTag(param1,0,1);
            WriteUtils.write$TYPE_INT32(param1,opType$field);
         }
         if(hasGodsFavor)
         {
            WriteUtils.writeTag(param1,0,2);
            WriteUtils.write$TYPE_INT32(param1,godsFavor$field);
         }
         if(hasGodsReward)
         {
            WriteUtils.writeTag(param1,0,3);
            WriteUtils.write$TYPE_INT32(param1,godsReward$field);
         }
         if(hasTimes)
         {
            WriteUtils.writeTag(param1,0,4);
            WriteUtils.write$TYPE_INT32(param1,times$field);
         }
         if(hasTempIds)
         {
            WriteUtils.writeTag(param1,2,5);
            WriteUtils.write$TYPE_STRING(param1,tempIds$field);
         }
         if(hasCount)
         {
            WriteUtils.writeTag(param1,0,6);
            WriteUtils.write$TYPE_INT32(param1,count$field);
         }
      }
      
      final override public function readFromSlice(param1:IDataInput, param2:uint) : void
      {
         var _loc7_:* = 0;
         var _loc4_:uint = 0;
         var _loc6_:uint = 0;
         var _loc3_:uint = 0;
         var _loc8_:uint = 0;
         var _loc9_:uint = 0;
         var _loc5_:uint = 0;
         while(param1.bytesAvailable > param2)
         {
            switch(((_loc7_ = ReadUtils.read$TYPE_UINT32(param1)) >>> 3) - 1)
            {
               case 0:
                  if(_loc4_ != 0)
                  {
                     throw new IOError("Bad data format: SacrificeRspMsg.opType cannot be set twice.");
                  }
                  _loc4_++;
                  opType = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 1:
                  if(_loc6_ != 0)
                  {
                     throw new IOError("Bad data format: SacrificeRspMsg.godsFavor cannot be set twice.");
                  }
                  _loc6_++;
                  godsFavor = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 2:
                  if(_loc3_ != 0)
                  {
                     throw new IOError("Bad data format: SacrificeRspMsg.godsReward cannot be set twice.");
                  }
                  _loc3_++;
                  godsReward = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 3:
                  if(_loc8_ != 0)
                  {
                     throw new IOError("Bad data format: SacrificeRspMsg.times cannot be set twice.");
                  }
                  _loc8_++;
                  times = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 4:
                  if(_loc9_ != 0)
                  {
                     throw new IOError("Bad data format: SacrificeRspMsg.tempIds cannot be set twice.");
                  }
                  _loc9_++;
                  tempIds = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 5:
                  if(_loc5_ != 0)
                  {
                     throw new IOError("Bad data format: SacrificeRspMsg.count cannot be set twice.");
                  }
                  _loc5_++;
                  count = ReadUtils.read$TYPE_INT32(param1);
                  break;
               default:
                  ReadUtils.skip(param1,_loc7_ & 7);
            }
         }
      }
   }
}

