package com.road.yishi.proto.perkinlab
{
   import com.netease.protobuf.Int64;
   import com.netease.protobuf.Message;
   import com.netease.protobuf.ReadUtils;
   import com.netease.protobuf.WriteUtils;
   import com.netease.protobuf.WritingBuffer;
   import flash.errors.IOError;
   import flash.utils.IDataInput;
   import flash.utils.IExternalizable;
   
   public final class PerkinLabRobMsg extends Message implements IExternalizable
   {
      
      private var op$field:int;
      
      private var hasField$0:uint = 0;
      
      private var success$field:Boolean;
      
      private var keng$field:PerkinLabKengMsg;
      
      private var rob_count$field:int;
      
      private var refresh_cost$field:int;
      
      private var next_refresh_time$field:Int64;
      
      private var rob_cd_time$field:Int64;
      
      public function PerkinLabRobMsg()
      {
         super();
      }
      
      public function removeOp() : void
      {
         hasField$0 &= 4294967294;
         op$field = new int();
      }
      
      public function get hasOp() : Boolean
      {
         return (hasField$0 & 1) != 0;
      }
      
      public function set op(param1:int) : void
      {
         hasField$0 |= 1;
         op$field = param1;
      }
      
      public function get op() : int
      {
         return op$field;
      }
      
      public function removeSuccess() : void
      {
         hasField$0 &= 4294967293;
         success$field = new Boolean();
      }
      
      public function get hasSuccess() : Boolean
      {
         return (hasField$0 & 2) != 0;
      }
      
      public function set success(param1:Boolean) : void
      {
         hasField$0 |= 2;
         success$field = param1;
      }
      
      public function get success() : Boolean
      {
         return success$field;
      }
      
      public function removeKeng() : void
      {
         keng$field = null;
      }
      
      public function get hasKeng() : Boolean
      {
         return keng$field != null;
      }
      
      public function set keng(param1:PerkinLabKengMsg) : void
      {
         keng$field = param1;
      }
      
      public function get keng() : PerkinLabKengMsg
      {
         return keng$field;
      }
      
      public function removeRobCount() : void
      {
         hasField$0 &= 4294967291;
         rob_count$field = new int();
      }
      
      public function get hasRobCount() : Boolean
      {
         return (hasField$0 & 4) != 0;
      }
      
      public function set robCount(param1:int) : void
      {
         hasField$0 |= 4;
         rob_count$field = param1;
      }
      
      public function get robCount() : int
      {
         return rob_count$field;
      }
      
      public function removeRefreshCost() : void
      {
         hasField$0 &= 4294967287;
         refresh_cost$field = new int();
      }
      
      public function get hasRefreshCost() : Boolean
      {
         return (hasField$0 & 8) != 0;
      }
      
      public function set refreshCost(param1:int) : void
      {
         hasField$0 |= 8;
         refresh_cost$field = param1;
      }
      
      public function get refreshCost() : int
      {
         return refresh_cost$field;
      }
      
      public function removeNextRefreshTime() : void
      {
         next_refresh_time$field = null;
      }
      
      public function get hasNextRefreshTime() : Boolean
      {
         return next_refresh_time$field != null;
      }
      
      public function set nextRefreshTime(param1:Int64) : void
      {
         next_refresh_time$field = param1;
      }
      
      public function get nextRefreshTime() : Int64
      {
         return next_refresh_time$field;
      }
      
      public function removeRobCdTime() : void
      {
         rob_cd_time$field = null;
      }
      
      public function get hasRobCdTime() : Boolean
      {
         return rob_cd_time$field != null;
      }
      
      public function set robCdTime(param1:Int64) : void
      {
         rob_cd_time$field = param1;
      }
      
      public function get robCdTime() : Int64
      {
         return rob_cd_time$field;
      }
      
      final override public function writeToBuffer(param1:WritingBuffer) : void
      {
         if(hasOp)
         {
            WriteUtils.writeTag(param1,0,1);
            WriteUtils.write$TYPE_INT32(param1,op$field);
         }
         if(hasSuccess)
         {
            WriteUtils.writeTag(param1,0,2);
            WriteUtils.write$TYPE_BOOL(param1,success$field);
         }
         if(hasKeng)
         {
            WriteUtils.writeTag(param1,2,3);
            WriteUtils.write$TYPE_MESSAGE(param1,keng$field);
         }
         if(hasRobCount)
         {
            WriteUtils.writeTag(param1,0,4);
            WriteUtils.write$TYPE_INT32(param1,rob_count$field);
         }
         if(hasRefreshCost)
         {
            WriteUtils.writeTag(param1,0,5);
            WriteUtils.write$TYPE_INT32(param1,refresh_cost$field);
         }
         if(hasNextRefreshTime)
         {
            WriteUtils.writeTag(param1,0,6);
            WriteUtils.write$TYPE_INT64(param1,next_refresh_time$field);
         }
         if(hasRobCdTime)
         {
            WriteUtils.writeTag(param1,0,7);
            WriteUtils.write$TYPE_INT64(param1,rob_cd_time$field);
         }
      }
      
      final override public function readFromSlice(param1:IDataInput, param2:uint) : void
      {
         var _loc7_:* = 0;
         var _loc8_:uint = 0;
         var _loc3_:uint = 0;
         var _loc4_:uint = 0;
         var _loc9_:uint = 0;
         var _loc6_:uint = 0;
         var _loc5_:uint = 0;
         var _loc10_:uint = 0;
         while(param1.bytesAvailable > param2)
         {
            switch(((_loc7_ = ReadUtils.read$TYPE_UINT32(param1)) >>> 3) - 1)
            {
               case 0:
                  if(_loc8_ != 0)
                  {
                     throw new IOError("Bad data format: PerkinLabRobMsg.op cannot be set twice.");
                  }
                  _loc8_++;
                  op = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 1:
                  if(_loc3_ != 0)
                  {
                     throw new IOError("Bad data format: PerkinLabRobMsg.success cannot be set twice.");
                  }
                  _loc3_++;
                  success = ReadUtils.read$TYPE_BOOL(param1);
                  break;
               case 2:
                  if(_loc4_ != 0)
                  {
                     throw new IOError("Bad data format: PerkinLabRobMsg.keng cannot be set twice.");
                  }
                  _loc4_++;
                  keng = new PerkinLabKengMsg();
                  ReadUtils.read$TYPE_MESSAGE(param1,keng);
                  break;
               case 3:
                  if(_loc9_ != 0)
                  {
                     throw new IOError("Bad data format: PerkinLabRobMsg.robCount cannot be set twice.");
                  }
                  _loc9_++;
                  robCount = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 4:
                  if(_loc6_ != 0)
                  {
                     throw new IOError("Bad data format: PerkinLabRobMsg.refreshCost cannot be set twice.");
                  }
                  _loc6_++;
                  refreshCost = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 5:
                  if(_loc5_ != 0)
                  {
                     throw new IOError("Bad data format: PerkinLabRobMsg.nextRefreshTime cannot be set twice.");
                  }
                  _loc5_++;
                  nextRefreshTime = ReadUtils.read$TYPE_INT64(param1);
                  break;
               case 6:
                  if(_loc10_ != 0)
                  {
                     throw new IOError("Bad data format: PerkinLabRobMsg.robCdTime cannot be set twice.");
                  }
                  _loc10_++;
                  robCdTime = ReadUtils.read$TYPE_INT64(param1);
                  break;
               default:
                  ReadUtils.skip(param1,_loc7_ & 7);
            }
         }
      }
   }
}

