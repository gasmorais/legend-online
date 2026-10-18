package com.road.yishi.proto.player
{
   import com.netease.protobuf.Int64;
   import com.netease.protobuf.Message;
   import com.netease.protobuf.ReadUtils;
   import com.netease.protobuf.WriteUtils;
   import com.netease.protobuf.WritingBuffer;
   import flash.errors.IOError;
   import flash.utils.IDataInput;
   import flash.utils.IExternalizable;
   
   public final class SystemPropertyMsg extends Message implements IExternalizable
   {
      
      private var sys_curtime$field:String;
      
      private var sys_starTime$field:String;
      
      private var sys_millisecond$field:Int64;
      
      public function SystemPropertyMsg()
      {
         super();
      }
      
      public function removeSysCurtime() : void
      {
         sys_curtime$field = null;
      }
      
      public function get hasSysCurtime() : Boolean
      {
         return sys_curtime$field != null;
      }
      
      public function set sysCurtime(param1:String) : void
      {
         sys_curtime$field = param1;
      }
      
      public function get sysCurtime() : String
      {
         return sys_curtime$field;
      }
      
      public function removeSysStarTime() : void
      {
         sys_starTime$field = null;
      }
      
      public function get hasSysStarTime() : Boolean
      {
         return sys_starTime$field != null;
      }
      
      public function set sysStarTime(param1:String) : void
      {
         sys_starTime$field = param1;
      }
      
      public function get sysStarTime() : String
      {
         return sys_starTime$field;
      }
      
      public function removeSysMillisecond() : void
      {
         sys_millisecond$field = null;
      }
      
      public function get hasSysMillisecond() : Boolean
      {
         return sys_millisecond$field != null;
      }
      
      public function set sysMillisecond(param1:Int64) : void
      {
         sys_millisecond$field = param1;
      }
      
      public function get sysMillisecond() : Int64
      {
         return sys_millisecond$field;
      }
      
      final override public function writeToBuffer(param1:WritingBuffer) : void
      {
         if(hasSysCurtime)
         {
            WriteUtils.writeTag(param1,2,1);
            WriteUtils.write$TYPE_STRING(param1,sys_curtime$field);
         }
         if(hasSysStarTime)
         {
            WriteUtils.writeTag(param1,2,2);
            WriteUtils.write$TYPE_STRING(param1,sys_starTime$field);
         }
         if(hasSysMillisecond)
         {
            WriteUtils.writeTag(param1,0,3);
            WriteUtils.write$TYPE_INT64(param1,sys_millisecond$field);
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
                     throw new IOError("Bad data format: SystemPropertyMsg.sysCurtime cannot be set twice.");
                  }
                  _loc3_++;
                  sysCurtime = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 1:
                  if(_loc6_ != 0)
                  {
                     throw new IOError("Bad data format: SystemPropertyMsg.sysStarTime cannot be set twice.");
                  }
                  _loc6_++;
                  sysStarTime = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 2:
                  if(_loc4_ != 0)
                  {
                     throw new IOError("Bad data format: SystemPropertyMsg.sysMillisecond cannot be set twice.");
                  }
                  _loc4_++;
                  sysMillisecond = ReadUtils.read$TYPE_INT64(param1);
                  break;
               default:
                  ReadUtils.skip(param1,_loc5_ & 7);
            }
         }
      }
   }
}

