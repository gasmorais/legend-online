package com.road.yishi.proto.consortia
{
   import com.netease.protobuf.Message;
   import com.netease.protobuf.ReadUtils;
   import com.netease.protobuf.WriteUtils;
   import com.netease.protobuf.WritingBuffer;
   import flash.errors.IOError;
   import flash.utils.IDataInput;
   import flash.utils.IExternalizable;
   
   public final class ConsortiaBossPlayerMsg extends Message implements IExternalizable
   {
      
      private var userid$field:int;
      
      private var hasField$0:uint = 0;
      
      private var collect_count$field:int;
      
      private var mission_item_count$field:int;
      
      public function ConsortiaBossPlayerMsg()
      {
         super();
      }
      
      public function removeUserid() : void
      {
         hasField$0 &= 4294967294;
         userid$field = new int();
      }
      
      public function get hasUserid() : Boolean
      {
         return (hasField$0 & 1) != 0;
      }
      
      public function set userid(param1:int) : void
      {
         hasField$0 |= 1;
         userid$field = param1;
      }
      
      public function get userid() : int
      {
         return userid$field;
      }
      
      public function removeCollectCount() : void
      {
         hasField$0 &= 4294967293;
         collect_count$field = new int();
      }
      
      public function get hasCollectCount() : Boolean
      {
         return (hasField$0 & 2) != 0;
      }
      
      public function set collectCount(param1:int) : void
      {
         hasField$0 |= 2;
         collect_count$field = param1;
      }
      
      public function get collectCount() : int
      {
         return collect_count$field;
      }
      
      public function removeMissionItemCount() : void
      {
         hasField$0 &= 4294967291;
         mission_item_count$field = new int();
      }
      
      public function get hasMissionItemCount() : Boolean
      {
         return (hasField$0 & 4) != 0;
      }
      
      public function set missionItemCount(param1:int) : void
      {
         hasField$0 |= 4;
         mission_item_count$field = param1;
      }
      
      public function get missionItemCount() : int
      {
         return mission_item_count$field;
      }
      
      final override public function writeToBuffer(param1:WritingBuffer) : void
      {
         if(hasUserid)
         {
            WriteUtils.writeTag(param1,0,1);
            WriteUtils.write$TYPE_INT32(param1,userid$field);
         }
         if(hasCollectCount)
         {
            WriteUtils.writeTag(param1,0,2);
            WriteUtils.write$TYPE_INT32(param1,collect_count$field);
         }
         if(hasMissionItemCount)
         {
            WriteUtils.writeTag(param1,0,3);
            WriteUtils.write$TYPE_INT32(param1,mission_item_count$field);
         }
      }
      
      final override public function readFromSlice(param1:IDataInput, param2:uint) : void
      {
         var _loc6_:* = 0;
         var _loc3_:uint = 0;
         var _loc5_:uint = 0;
         var _loc4_:uint = 0;
         while(param1.bytesAvailable > param2)
         {
            switch(((_loc6_ = ReadUtils.read$TYPE_UINT32(param1)) >>> 3) - 1)
            {
               case 0:
                  if(_loc3_ != 0)
                  {
                     throw new IOError("Bad data format: ConsortiaBossPlayerMsg.userid cannot be set twice.");
                  }
                  _loc3_++;
                  userid = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 1:
                  if(_loc5_ != 0)
                  {
                     throw new IOError("Bad data format: ConsortiaBossPlayerMsg.collectCount cannot be set twice.");
                  }
                  _loc5_++;
                  collectCount = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 2:
                  if(_loc4_ != 0)
                  {
                     throw new IOError("Bad data format: ConsortiaBossPlayerMsg.missionItemCount cannot be set twice.");
                  }
                  _loc4_++;
                  missionItemCount = ReadUtils.read$TYPE_INT32(param1);
                  break;
               default:
                  ReadUtils.skip(param1,_loc6_ & 7);
            }
         }
      }
   }
}

