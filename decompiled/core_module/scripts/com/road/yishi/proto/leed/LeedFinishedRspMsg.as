package com.road.yishi.proto.leed
{
   import com.netease.protobuf.Message;
   import com.netease.protobuf.ReadUtils;
   import com.netease.protobuf.WriteUtils;
   import com.netease.protobuf.WritingBuffer;
   import flash.errors.IOError;
   import flash.utils.IDataInput;
   import flash.utils.IExternalizable;
   
   public final class LeedFinishedRspMsg extends Message implements IExternalizable
   {
      
      private var result$field:Boolean;
      
      private var hasField$0:uint = 0;
      
      private var site$field:int;
      
      private var leedProcess$field:int;
      
      private var isWeek$field:Boolean;
      
      public function LeedFinishedRspMsg()
      {
         super();
      }
      
      public function removeResult() : void
      {
         hasField$0 &= 4294967294;
         result$field = new Boolean();
      }
      
      public function get hasResult() : Boolean
      {
         return (hasField$0 & 1) != 0;
      }
      
      public function set result(param1:Boolean) : void
      {
         hasField$0 |= 1;
         result$field = param1;
      }
      
      public function get result() : Boolean
      {
         return result$field;
      }
      
      public function removeSite() : void
      {
         hasField$0 &= 4294967293;
         site$field = new int();
      }
      
      public function get hasSite() : Boolean
      {
         return (hasField$0 & 2) != 0;
      }
      
      public function set site(param1:int) : void
      {
         hasField$0 |= 2;
         site$field = param1;
      }
      
      public function get site() : int
      {
         return site$field;
      }
      
      public function removeLeedProcess() : void
      {
         hasField$0 &= 4294967291;
         leedProcess$field = new int();
      }
      
      public function get hasLeedProcess() : Boolean
      {
         return (hasField$0 & 4) != 0;
      }
      
      public function set leedProcess(param1:int) : void
      {
         hasField$0 |= 4;
         leedProcess$field = param1;
      }
      
      public function get leedProcess() : int
      {
         return leedProcess$field;
      }
      
      public function removeIsWeek() : void
      {
         hasField$0 &= 4294967287;
         isWeek$field = new Boolean();
      }
      
      public function get hasIsWeek() : Boolean
      {
         return (hasField$0 & 8) != 0;
      }
      
      public function set isWeek(param1:Boolean) : void
      {
         hasField$0 |= 8;
         isWeek$field = param1;
      }
      
      public function get isWeek() : Boolean
      {
         return isWeek$field;
      }
      
      final override public function writeToBuffer(param1:WritingBuffer) : void
      {
         if(hasResult)
         {
            WriteUtils.writeTag(param1,0,1);
            WriteUtils.write$TYPE_BOOL(param1,result$field);
         }
         if(hasSite)
         {
            WriteUtils.writeTag(param1,0,2);
            WriteUtils.write$TYPE_INT32(param1,site$field);
         }
         if(hasLeedProcess)
         {
            WriteUtils.writeTag(param1,0,3);
            WriteUtils.write$TYPE_INT32(param1,leedProcess$field);
         }
         if(hasIsWeek)
         {
            WriteUtils.writeTag(param1,0,4);
            WriteUtils.write$TYPE_BOOL(param1,isWeek$field);
         }
      }
      
      final override public function readFromSlice(param1:IDataInput, param2:uint) : void
      {
         var _loc6_:* = 0;
         var _loc5_:uint = 0;
         var _loc3_:uint = 0;
         var _loc4_:uint = 0;
         var _loc7_:uint = 0;
         while(param1.bytesAvailable > param2)
         {
            switch(((_loc6_ = ReadUtils.read$TYPE_UINT32(param1)) >>> 3) - 1)
            {
               case 0:
                  if(_loc5_ != 0)
                  {
                     throw new IOError("Bad data format: LeedFinishedRspMsg.result cannot be set twice.");
                  }
                  _loc5_++;
                  result = ReadUtils.read$TYPE_BOOL(param1);
                  break;
               case 1:
                  if(_loc3_ != 0)
                  {
                     throw new IOError("Bad data format: LeedFinishedRspMsg.site cannot be set twice.");
                  }
                  _loc3_++;
                  site = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 2:
                  if(_loc4_ != 0)
                  {
                     throw new IOError("Bad data format: LeedFinishedRspMsg.leedProcess cannot be set twice.");
                  }
                  _loc4_++;
                  leedProcess = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 3:
                  if(_loc7_ != 0)
                  {
                     throw new IOError("Bad data format: LeedFinishedRspMsg.isWeek cannot be set twice.");
                  }
                  _loc7_++;
                  isWeek = ReadUtils.read$TYPE_BOOL(param1);
                  break;
               default:
                  ReadUtils.skip(param1,_loc6_ & 7);
            }
         }
      }
   }
}

