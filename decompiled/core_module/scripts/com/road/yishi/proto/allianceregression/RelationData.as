package com.road.yishi.proto.allianceregression
{
   import com.netease.protobuf.Message;
   import com.netease.protobuf.ReadUtils;
   import com.netease.protobuf.WriteUtils;
   import com.netease.protobuf.WritingBuffer;
   import flash.errors.IOError;
   import flash.utils.IDataInput;
   import flash.utils.IExternalizable;
   
   public final class RelationData extends Message implements IExternalizable
   {
      
      private var playerId$field:int;
      
      private var hasField$0:uint = 0;
      
      private var nickName$field:String;
      
      private var fightingCapacity$field:int;
      
      private var allianceNum$field:int;
      
      private var status$field:int;
      
      public function RelationData()
      {
         super();
      }
      
      public function removePlayerId() : void
      {
         hasField$0 &= 4294967294;
         playerId$field = new int();
      }
      
      public function get hasPlayerId() : Boolean
      {
         return (hasField$0 & 1) != 0;
      }
      
      public function set playerId(param1:int) : void
      {
         hasField$0 |= 1;
         playerId$field = param1;
      }
      
      public function get playerId() : int
      {
         return playerId$field;
      }
      
      public function removeNickName() : void
      {
         nickName$field = null;
      }
      
      public function get hasNickName() : Boolean
      {
         return nickName$field != null;
      }
      
      public function set nickName(param1:String) : void
      {
         nickName$field = param1;
      }
      
      public function get nickName() : String
      {
         return nickName$field;
      }
      
      public function removeFightingCapacity() : void
      {
         hasField$0 &= 4294967293;
         fightingCapacity$field = new int();
      }
      
      public function get hasFightingCapacity() : Boolean
      {
         return (hasField$0 & 2) != 0;
      }
      
      public function set fightingCapacity(param1:int) : void
      {
         hasField$0 |= 2;
         fightingCapacity$field = param1;
      }
      
      public function get fightingCapacity() : int
      {
         return fightingCapacity$field;
      }
      
      public function removeAllianceNum() : void
      {
         hasField$0 &= 4294967291;
         allianceNum$field = new int();
      }
      
      public function get hasAllianceNum() : Boolean
      {
         return (hasField$0 & 4) != 0;
      }
      
      public function set allianceNum(param1:int) : void
      {
         hasField$0 |= 4;
         allianceNum$field = param1;
      }
      
      public function get allianceNum() : int
      {
         return allianceNum$field;
      }
      
      public function removeStatus() : void
      {
         hasField$0 &= 4294967287;
         status$field = new int();
      }
      
      public function get hasStatus() : Boolean
      {
         return (hasField$0 & 8) != 0;
      }
      
      public function set status(param1:int) : void
      {
         hasField$0 |= 8;
         status$field = param1;
      }
      
      public function get status() : int
      {
         return status$field;
      }
      
      final override public function writeToBuffer(param1:WritingBuffer) : void
      {
         if(hasPlayerId)
         {
            WriteUtils.writeTag(param1,0,1);
            WriteUtils.write$TYPE_INT32(param1,playerId$field);
         }
         if(hasNickName)
         {
            WriteUtils.writeTag(param1,2,2);
            WriteUtils.write$TYPE_STRING(param1,nickName$field);
         }
         if(hasFightingCapacity)
         {
            WriteUtils.writeTag(param1,0,3);
            WriteUtils.write$TYPE_INT32(param1,fightingCapacity$field);
         }
         if(hasAllianceNum)
         {
            WriteUtils.writeTag(param1,0,4);
            WriteUtils.write$TYPE_INT32(param1,allianceNum$field);
         }
         if(hasStatus)
         {
            WriteUtils.writeTag(param1,0,5);
            WriteUtils.write$TYPE_INT32(param1,status$field);
         }
      }
      
      final override public function readFromSlice(param1:IDataInput, param2:uint) : void
      {
         var _loc6_:* = 0;
         var _loc3_:uint = 0;
         var _loc4_:uint = 0;
         var _loc5_:uint = 0;
         var _loc8_:uint = 0;
         var _loc7_:uint = 0;
         while(param1.bytesAvailable > param2)
         {
            switch(((_loc6_ = ReadUtils.read$TYPE_UINT32(param1)) >>> 3) - 1)
            {
               case 0:
                  if(_loc3_ != 0)
                  {
                     throw new IOError("Bad data format: RelationData.playerId cannot be set twice.");
                  }
                  _loc3_++;
                  playerId = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 1:
                  if(_loc4_ != 0)
                  {
                     throw new IOError("Bad data format: RelationData.nickName cannot be set twice.");
                  }
                  _loc4_++;
                  nickName = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 2:
                  if(_loc5_ != 0)
                  {
                     throw new IOError("Bad data format: RelationData.fightingCapacity cannot be set twice.");
                  }
                  _loc5_++;
                  fightingCapacity = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 3:
                  if(_loc8_ != 0)
                  {
                     throw new IOError("Bad data format: RelationData.allianceNum cannot be set twice.");
                  }
                  _loc8_++;
                  allianceNum = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 4:
                  if(_loc7_ != 0)
                  {
                     throw new IOError("Bad data format: RelationData.status cannot be set twice.");
                  }
                  _loc7_++;
                  status = ReadUtils.read$TYPE_INT32(param1);
                  break;
               default:
                  ReadUtils.skip(param1,_loc6_ & 7);
            }
         }
      }
   }
}

