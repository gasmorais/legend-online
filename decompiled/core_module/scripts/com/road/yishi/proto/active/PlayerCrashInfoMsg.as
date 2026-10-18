package com.road.yishi.proto.active
{
   import com.netease.protobuf.Message;
   import com.netease.protobuf.ReadUtils;
   import com.netease.protobuf.WriteUtils;
   import com.netease.protobuf.WritingBuffer;
   import flash.errors.IOError;
   import flash.utils.IDataInput;
   import flash.utils.IExternalizable;
   
   public final class PlayerCrashInfoMsg extends Message implements IExternalizable
   {
      
      private var height$field:int;
      
      private var hasField$0:uint = 0;
      
      private var crashScore$field:int;
      
      private var param$field:int;
      
      public function PlayerCrashInfoMsg()
      {
         super();
      }
      
      public function removeHeight() : void
      {
         hasField$0 &= 4294967294;
         height$field = new int();
      }
      
      public function get hasHeight() : Boolean
      {
         return (hasField$0 & 1) != 0;
      }
      
      public function set height(param1:int) : void
      {
         hasField$0 |= 1;
         height$field = param1;
      }
      
      public function get height() : int
      {
         return height$field;
      }
      
      public function removeCrashScore() : void
      {
         hasField$0 &= 4294967293;
         crashScore$field = new int();
      }
      
      public function get hasCrashScore() : Boolean
      {
         return (hasField$0 & 2) != 0;
      }
      
      public function set crashScore(param1:int) : void
      {
         hasField$0 |= 2;
         crashScore$field = param1;
      }
      
      public function get crashScore() : int
      {
         return crashScore$field;
      }
      
      public function removeParam() : void
      {
         hasField$0 &= 4294967291;
         param$field = new int();
      }
      
      public function get hasParam() : Boolean
      {
         return (hasField$0 & 4) != 0;
      }
      
      public function set param(param1:int) : void
      {
         hasField$0 |= 4;
         param$field = param1;
      }
      
      public function get param() : int
      {
         return param$field;
      }
      
      final override public function writeToBuffer(param1:WritingBuffer) : void
      {
         if(hasHeight)
         {
            WriteUtils.writeTag(param1,0,1);
            WriteUtils.write$TYPE_INT32(param1,height$field);
         }
         if(hasCrashScore)
         {
            WriteUtils.writeTag(param1,0,2);
            WriteUtils.write$TYPE_INT32(param1,crashScore$field);
         }
         if(hasParam)
         {
            WriteUtils.writeTag(param1,0,3);
            WriteUtils.write$TYPE_INT32(param1,param$field);
         }
      }
      
      final override public function readFromSlice(param1:IDataInput, param2:uint) : void
      {
         var _loc5_:* = 0;
         var _loc3_:uint = 0;
         var _loc6_:uint = 0;
         var _loc4_:uint = 0;
         while(param1.bytesAvailable > param2)
         {
            switch(((_loc5_ = ReadUtils.read$TYPE_UINT32(param1)) >>> 3) - 1)
            {
               case 0:
                  if(_loc3_ != 0)
                  {
                     throw new IOError("Bad data format: PlayerCrashInfoMsg.height cannot be set twice.");
                  }
                  _loc3_++;
                  height = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 1:
                  if(_loc6_ != 0)
                  {
                     throw new IOError("Bad data format: PlayerCrashInfoMsg.crashScore cannot be set twice.");
                  }
                  _loc6_++;
                  crashScore = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 2:
                  if(_loc4_ != 0)
                  {
                     throw new IOError("Bad data format: PlayerCrashInfoMsg.param cannot be set twice.");
                  }
                  _loc4_++;
                  param = ReadUtils.read$TYPE_INT32(param1);
                  break;
               default:
                  ReadUtils.skip(param1,_loc5_ & 7);
            }
         }
      }
   }
}

