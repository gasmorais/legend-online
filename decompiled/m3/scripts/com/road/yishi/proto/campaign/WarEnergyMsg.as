package com.road.yishi.proto.campaign
{
   import com.netease.protobuf.Message;
   import com.netease.protobuf.ReadUtils;
   import com.netease.protobuf.WriteUtils;
   import com.netease.protobuf.WritingBuffer;
   import flash.errors.IOError;
   import flash.utils.IDataInput;
   import flash.utils.IExternalizable;
   
   public final class WarEnergyMsg extends Message implements IExternalizable
   {
      
      private var node_tempId$field:int;
      
      private var hasField$0:uint = 0;
      
      private var blueCount$field:int;
      
      private var redsCount$field:int;
      
      private var ownerTeamId$field:int;
      
      private var currentIndex$field:int;
      
      public function WarEnergyMsg()
      {
         super();
      }
      
      public function removeNodeTempId() : void
      {
         hasField$0 &= 4294967294;
         node_tempId$field = new int();
      }
      
      public function get hasNodeTempId() : Boolean
      {
         return (hasField$0 & 1) != 0;
      }
      
      public function set nodeTempId(param1:int) : void
      {
         hasField$0 |= 1;
         node_tempId$field = param1;
      }
      
      public function get nodeTempId() : int
      {
         return node_tempId$field;
      }
      
      public function removeBlueCount() : void
      {
         hasField$0 &= 4294967293;
         blueCount$field = new int();
      }
      
      public function get hasBlueCount() : Boolean
      {
         return (hasField$0 & 2) != 0;
      }
      
      public function set blueCount(param1:int) : void
      {
         hasField$0 |= 2;
         blueCount$field = param1;
      }
      
      public function get blueCount() : int
      {
         return blueCount$field;
      }
      
      public function removeRedsCount() : void
      {
         hasField$0 &= 4294967291;
         redsCount$field = new int();
      }
      
      public function get hasRedsCount() : Boolean
      {
         return (hasField$0 & 4) != 0;
      }
      
      public function set redsCount(param1:int) : void
      {
         hasField$0 |= 4;
         redsCount$field = param1;
      }
      
      public function get redsCount() : int
      {
         return redsCount$field;
      }
      
      public function removeOwnerTeamId() : void
      {
         hasField$0 &= 4294967287;
         ownerTeamId$field = new int();
      }
      
      public function get hasOwnerTeamId() : Boolean
      {
         return (hasField$0 & 8) != 0;
      }
      
      public function set ownerTeamId(param1:int) : void
      {
         hasField$0 |= 8;
         ownerTeamId$field = param1;
      }
      
      public function get ownerTeamId() : int
      {
         return ownerTeamId$field;
      }
      
      public function removeCurrentIndex() : void
      {
         hasField$0 &= 4294967279;
         currentIndex$field = new int();
      }
      
      public function get hasCurrentIndex() : Boolean
      {
         return (hasField$0 & 0x10) != 0;
      }
      
      public function set currentIndex(param1:int) : void
      {
         hasField$0 |= 16;
         currentIndex$field = param1;
      }
      
      public function get currentIndex() : int
      {
         return currentIndex$field;
      }
      
      final override public function writeToBuffer(param1:WritingBuffer) : void
      {
         if(hasNodeTempId)
         {
            WriteUtils.writeTag(param1,0,1);
            WriteUtils.write$TYPE_INT32(param1,node_tempId$field);
         }
         if(hasBlueCount)
         {
            WriteUtils.writeTag(param1,0,2);
            WriteUtils.write$TYPE_INT32(param1,blueCount$field);
         }
         if(hasRedsCount)
         {
            WriteUtils.writeTag(param1,0,3);
            WriteUtils.write$TYPE_INT32(param1,redsCount$field);
         }
         if(hasOwnerTeamId)
         {
            WriteUtils.writeTag(param1,0,4);
            WriteUtils.write$TYPE_INT32(param1,ownerTeamId$field);
         }
         if(hasCurrentIndex)
         {
            WriteUtils.writeTag(param1,0,5);
            WriteUtils.write$TYPE_INT32(param1,currentIndex$field);
         }
      }
      
      final override public function readFromSlice(param1:IDataInput, param2:uint) : void
      {
         var _loc6_:* = 0;
         var _loc7_:uint = 0;
         var _loc4_:uint = 0;
         var _loc8_:uint = 0;
         var _loc5_:uint = 0;
         var _loc3_:uint = 0;
         while(param1.bytesAvailable > param2)
         {
            switch(((_loc6_ = uint(ReadUtils.read$TYPE_UINT32(param1))) >>> 3) - 1)
            {
               case 0:
                  if(_loc7_ != 0)
                  {
                     throw new IOError("Bad data format: WarEnergyMsg.nodeTempId cannot be set twice.");
                  }
                  _loc7_++;
                  nodeTempId = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 1:
                  if(_loc4_ != 0)
                  {
                     throw new IOError("Bad data format: WarEnergyMsg.blueCount cannot be set twice.");
                  }
                  _loc4_++;
                  blueCount = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 2:
                  if(_loc8_ != 0)
                  {
                     throw new IOError("Bad data format: WarEnergyMsg.redsCount cannot be set twice.");
                  }
                  _loc8_++;
                  redsCount = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 3:
                  if(_loc5_ != 0)
                  {
                     throw new IOError("Bad data format: WarEnergyMsg.ownerTeamId cannot be set twice.");
                  }
                  _loc5_++;
                  ownerTeamId = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 4:
                  if(_loc3_ != 0)
                  {
                     throw new IOError("Bad data format: WarEnergyMsg.currentIndex cannot be set twice.");
                  }
                  _loc3_++;
                  currentIndex = ReadUtils.read$TYPE_INT32(param1);
                  break;
               default:
                  ReadUtils.skip(param1,_loc6_ & 7);
            }
         }
      }
   }
}

