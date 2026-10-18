package com.road.yishi.proto.campaign
{
   import com.netease.protobuf.Message;
   import com.netease.protobuf.ReadUtils;
   import com.netease.protobuf.WriteUtils;
   import com.netease.protobuf.WritingBuffer;
   import flash.errors.IOError;
   import flash.utils.IDataInput;
   import flash.utils.IExternalizable;
   
   public final class RankInfoMsg extends Message implements IExternalizable
   {
      
      private var order$field:int;
      
      private var hasField$0:uint = 0;
      
      private var nickName$field:String;
      
      private var passTime$field:int;
      
      private var job$field:int;
      
      public function RankInfoMsg()
      {
         super();
      }
      
      public function removeOrder() : void
      {
         hasField$0 &= 4294967294;
         order$field = new int();
      }
      
      public function get hasOrder() : Boolean
      {
         return (hasField$0 & 1) != 0;
      }
      
      public function set order(param1:int) : void
      {
         hasField$0 |= 1;
         order$field = param1;
      }
      
      public function get order() : int
      {
         return order$field;
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
      
      public function removePassTime() : void
      {
         hasField$0 &= 4294967293;
         passTime$field = new int();
      }
      
      public function get hasPassTime() : Boolean
      {
         return (hasField$0 & 2) != 0;
      }
      
      public function set passTime(param1:int) : void
      {
         hasField$0 |= 2;
         passTime$field = param1;
      }
      
      public function get passTime() : int
      {
         return passTime$field;
      }
      
      public function removeJob() : void
      {
         hasField$0 &= 4294967291;
         job$field = new int();
      }
      
      public function get hasJob() : Boolean
      {
         return (hasField$0 & 4) != 0;
      }
      
      public function set job(param1:int) : void
      {
         hasField$0 |= 4;
         job$field = param1;
      }
      
      public function get job() : int
      {
         return job$field;
      }
      
      final override public function writeToBuffer(param1:WritingBuffer) : void
      {
         if(hasOrder)
         {
            WriteUtils.writeTag(param1,0,1);
            WriteUtils.write$TYPE_INT32(param1,order$field);
         }
         if(hasNickName)
         {
            WriteUtils.writeTag(param1,2,2);
            WriteUtils.write$TYPE_STRING(param1,nickName$field);
         }
         if(hasPassTime)
         {
            WriteUtils.writeTag(param1,0,3);
            WriteUtils.write$TYPE_INT32(param1,passTime$field);
         }
         if(hasJob)
         {
            WriteUtils.writeTag(param1,0,4);
            WriteUtils.write$TYPE_INT32(param1,job$field);
         }
      }
      
      final override public function readFromSlice(param1:IDataInput, param2:uint) : void
      {
         var _loc7_:* = 0;
         var _loc5_:uint = 0;
         var _loc3_:uint = 0;
         var _loc4_:uint = 0;
         var _loc6_:uint = 0;
         while(param1.bytesAvailable > param2)
         {
            switch(((_loc7_ = ReadUtils.read$TYPE_UINT32(param1)) >>> 3) - 1)
            {
               case 0:
                  if(_loc5_ != 0)
                  {
                     throw new IOError("Bad data format: RankInfoMsg.order cannot be set twice.");
                  }
                  _loc5_++;
                  order = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 1:
                  if(_loc3_ != 0)
                  {
                     throw new IOError("Bad data format: RankInfoMsg.nickName cannot be set twice.");
                  }
                  _loc3_++;
                  nickName = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 2:
                  if(_loc4_ != 0)
                  {
                     throw new IOError("Bad data format: RankInfoMsg.passTime cannot be set twice.");
                  }
                  _loc4_++;
                  passTime = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 3:
                  if(_loc6_ != 0)
                  {
                     throw new IOError("Bad data format: RankInfoMsg.job cannot be set twice.");
                  }
                  _loc6_++;
                  job = ReadUtils.read$TYPE_INT32(param1);
                  break;
               default:
                  ReadUtils.skip(param1,_loc7_ & 7);
            }
         }
      }
   }
}

