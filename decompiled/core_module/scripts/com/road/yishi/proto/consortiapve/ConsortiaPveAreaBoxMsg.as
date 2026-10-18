package com.road.yishi.proto.consortiapve
{
   import com.netease.protobuf.Message;
   import com.netease.protobuf.ReadUtils;
   import com.netease.protobuf.WriteUtils;
   import com.netease.protobuf.WritingBuffer;
   import flash.errors.IOError;
   import flash.utils.IDataInput;
   import flash.utils.IExternalizable;
   
   public final class ConsortiaPveAreaBoxMsg extends Message implements IExternalizable
   {
      
      private var areaId$field:int;
      
      private var hasField$0:uint = 0;
      
      private var difficulty$field:int;
      
      private var awardState$field:int;
      
      private var leader$field:ConsortiaPvePlayerMsg;
      
      public function ConsortiaPveAreaBoxMsg()
      {
         super();
      }
      
      public function removeAreaId() : void
      {
         hasField$0 &= 4294967294;
         areaId$field = new int();
      }
      
      public function get hasAreaId() : Boolean
      {
         return (hasField$0 & 1) != 0;
      }
      
      public function set areaId(param1:int) : void
      {
         hasField$0 |= 1;
         areaId$field = param1;
      }
      
      public function get areaId() : int
      {
         return areaId$field;
      }
      
      public function removeDifficulty() : void
      {
         hasField$0 &= 4294967293;
         difficulty$field = new int();
      }
      
      public function get hasDifficulty() : Boolean
      {
         return (hasField$0 & 2) != 0;
      }
      
      public function set difficulty(param1:int) : void
      {
         hasField$0 |= 2;
         difficulty$field = param1;
      }
      
      public function get difficulty() : int
      {
         return difficulty$field;
      }
      
      public function removeAwardState() : void
      {
         hasField$0 &= 4294967291;
         awardState$field = new int();
      }
      
      public function get hasAwardState() : Boolean
      {
         return (hasField$0 & 4) != 0;
      }
      
      public function set awardState(param1:int) : void
      {
         hasField$0 |= 4;
         awardState$field = param1;
      }
      
      public function get awardState() : int
      {
         return awardState$field;
      }
      
      public function removeLeader() : void
      {
         leader$field = null;
      }
      
      public function get hasLeader() : Boolean
      {
         return leader$field != null;
      }
      
      public function set leader(param1:ConsortiaPvePlayerMsg) : void
      {
         leader$field = param1;
      }
      
      public function get leader() : ConsortiaPvePlayerMsg
      {
         return leader$field;
      }
      
      final override public function writeToBuffer(param1:WritingBuffer) : void
      {
         if(hasAreaId)
         {
            WriteUtils.writeTag(param1,0,1);
            WriteUtils.write$TYPE_INT32(param1,areaId$field);
         }
         if(hasDifficulty)
         {
            WriteUtils.writeTag(param1,0,2);
            WriteUtils.write$TYPE_INT32(param1,difficulty$field);
         }
         if(hasAwardState)
         {
            WriteUtils.writeTag(param1,0,3);
            WriteUtils.write$TYPE_INT32(param1,awardState$field);
         }
         if(hasLeader)
         {
            WriteUtils.writeTag(param1,2,4);
            WriteUtils.write$TYPE_MESSAGE(param1,leader$field);
         }
      }
      
      final override public function readFromSlice(param1:IDataInput, param2:uint) : void
      {
         var _loc6_:* = 0;
         var _loc4_:uint = 0;
         var _loc7_:uint = 0;
         var _loc3_:uint = 0;
         var _loc5_:uint = 0;
         while(param1.bytesAvailable > param2)
         {
            switch(((_loc6_ = ReadUtils.read$TYPE_UINT32(param1)) >>> 3) - 1)
            {
               case 0:
                  if(_loc4_ != 0)
                  {
                     throw new IOError("Bad data format: ConsortiaPveAreaBoxMsg.areaId cannot be set twice.");
                  }
                  _loc4_++;
                  areaId = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 1:
                  if(_loc7_ != 0)
                  {
                     throw new IOError("Bad data format: ConsortiaPveAreaBoxMsg.difficulty cannot be set twice.");
                  }
                  _loc7_++;
                  difficulty = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 2:
                  if(_loc3_ != 0)
                  {
                     throw new IOError("Bad data format: ConsortiaPveAreaBoxMsg.awardState cannot be set twice.");
                  }
                  _loc3_++;
                  awardState = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 3:
                  if(_loc5_ != 0)
                  {
                     throw new IOError("Bad data format: ConsortiaPveAreaBoxMsg.leader cannot be set twice.");
                  }
                  _loc5_++;
                  leader = new ConsortiaPvePlayerMsg();
                  ReadUtils.read$TYPE_MESSAGE(param1,leader);
                  break;
               default:
                  ReadUtils.skip(param1,_loc6_ & 7);
            }
         }
      }
   }
}

