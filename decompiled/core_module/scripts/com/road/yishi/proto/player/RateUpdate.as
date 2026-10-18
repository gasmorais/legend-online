package com.road.yishi.proto.player
{
   import com.netease.protobuf.Message;
   import com.netease.protobuf.ReadUtils;
   import com.netease.protobuf.WriteUtils;
   import com.netease.protobuf.WritingBuffer;
   import flash.errors.IOError;
   import flash.utils.IDataInput;
   import flash.utils.IExternalizable;
   
   public final class RateUpdate extends Message implements IExternalizable
   {
      
      private var rate$field:int;
      
      private var hasField$0:uint = 0;
      
      private var begin_time$field:int;
      
      private var end_time$field:int;
      
      private var beginDay$field:String;
      
      private var endDay$field:String;
      
      private var buffer_type$field:int;
      
      private var param1$field:String;
      
      private var param2$field:String;
      
      private var rate_name$field:String;
      
      private var rate_desc$field:String;
      
      public function RateUpdate()
      {
         super();
      }
      
      public function removeRate() : void
      {
         hasField$0 &= 4294967294;
         rate$field = new int();
      }
      
      public function get hasRate() : Boolean
      {
         return (hasField$0 & 1) != 0;
      }
      
      public function set rate(param1:int) : void
      {
         hasField$0 |= 1;
         rate$field = param1;
      }
      
      public function get rate() : int
      {
         return rate$field;
      }
      
      public function removeBeginTime() : void
      {
         hasField$0 &= 4294967293;
         begin_time$field = new int();
      }
      
      public function get hasBeginTime() : Boolean
      {
         return (hasField$0 & 2) != 0;
      }
      
      public function set beginTime(param1:int) : void
      {
         hasField$0 |= 2;
         begin_time$field = param1;
      }
      
      public function get beginTime() : int
      {
         return begin_time$field;
      }
      
      public function removeEndTime() : void
      {
         hasField$0 &= 4294967291;
         end_time$field = new int();
      }
      
      public function get hasEndTime() : Boolean
      {
         return (hasField$0 & 4) != 0;
      }
      
      public function set endTime(param1:int) : void
      {
         hasField$0 |= 4;
         end_time$field = param1;
      }
      
      public function get endTime() : int
      {
         return end_time$field;
      }
      
      public function removeBeginDay() : void
      {
         beginDay$field = null;
      }
      
      public function get hasBeginDay() : Boolean
      {
         return beginDay$field != null;
      }
      
      public function set beginDay(param1:String) : void
      {
         beginDay$field = param1;
      }
      
      public function get beginDay() : String
      {
         return beginDay$field;
      }
      
      public function removeEndDay() : void
      {
         endDay$field = null;
      }
      
      public function get hasEndDay() : Boolean
      {
         return endDay$field != null;
      }
      
      public function set endDay(param1:String) : void
      {
         endDay$field = param1;
      }
      
      public function get endDay() : String
      {
         return endDay$field;
      }
      
      public function removeBufferType() : void
      {
         hasField$0 &= 4294967287;
         buffer_type$field = new int();
      }
      
      public function get hasBufferType() : Boolean
      {
         return (hasField$0 & 8) != 0;
      }
      
      public function set bufferType(param1:int) : void
      {
         hasField$0 |= 8;
         buffer_type$field = param1;
      }
      
      public function get bufferType() : int
      {
         return buffer_type$field;
      }
      
      public function removeParam1() : void
      {
         param1$field = null;
      }
      
      public function get hasParam1() : Boolean
      {
         return param1$field != null;
      }
      
      public function set param1(param1:String) : void
      {
         param1$field = param1;
      }
      
      public function get param1() : String
      {
         return param1$field;
      }
      
      public function removeParam2() : void
      {
         param2$field = null;
      }
      
      public function get hasParam2() : Boolean
      {
         return param2$field != null;
      }
      
      public function set param2(param1:String) : void
      {
         param2$field = param1;
      }
      
      public function get param2() : String
      {
         return param2$field;
      }
      
      public function removeRateName() : void
      {
         rate_name$field = null;
      }
      
      public function get hasRateName() : Boolean
      {
         return rate_name$field != null;
      }
      
      public function set rateName(param1:String) : void
      {
         rate_name$field = param1;
      }
      
      public function get rateName() : String
      {
         return rate_name$field;
      }
      
      public function removeRateDesc() : void
      {
         rate_desc$field = null;
      }
      
      public function get hasRateDesc() : Boolean
      {
         return rate_desc$field != null;
      }
      
      public function set rateDesc(param1:String) : void
      {
         rate_desc$field = param1;
      }
      
      public function get rateDesc() : String
      {
         return rate_desc$field;
      }
      
      final override public function writeToBuffer(param1:WritingBuffer) : void
      {
         if(hasRate)
         {
            WriteUtils.writeTag(param1,0,1);
            WriteUtils.write$TYPE_INT32(param1,rate$field);
         }
         if(hasBeginTime)
         {
            WriteUtils.writeTag(param1,0,2);
            WriteUtils.write$TYPE_INT32(param1,begin_time$field);
         }
         if(hasEndTime)
         {
            WriteUtils.writeTag(param1,0,3);
            WriteUtils.write$TYPE_INT32(param1,end_time$field);
         }
         if(hasBeginDay)
         {
            WriteUtils.writeTag(param1,2,4);
            WriteUtils.write$TYPE_STRING(param1,beginDay$field);
         }
         if(hasEndDay)
         {
            WriteUtils.writeTag(param1,2,5);
            WriteUtils.write$TYPE_STRING(param1,endDay$field);
         }
         if(hasBufferType)
         {
            WriteUtils.writeTag(param1,0,6);
            WriteUtils.write$TYPE_INT32(param1,buffer_type$field);
         }
         if(hasParam1)
         {
            WriteUtils.writeTag(param1,2,7);
            WriteUtils.write$TYPE_STRING(param1,param1$field);
         }
         if(hasParam2)
         {
            WriteUtils.writeTag(param1,2,8);
            WriteUtils.write$TYPE_STRING(param1,param2$field);
         }
         if(hasRateName)
         {
            WriteUtils.writeTag(param1,2,9);
            WriteUtils.write$TYPE_STRING(param1,rate_name$field);
         }
         if(hasRateDesc)
         {
            WriteUtils.writeTag(param1,2,10);
            WriteUtils.write$TYPE_STRING(param1,rate_desc$field);
         }
      }
      
      final override public function readFromSlice(param1:IDataInput, param2:uint) : void
      {
         var _loc10_:* = 0;
         var _loc11_:uint = 0;
         var _loc9_:uint = 0;
         var _loc4_:uint = 0;
         var _loc5_:uint = 0;
         var _loc12_:uint = 0;
         var _loc7_:uint = 0;
         var _loc3_:uint = 0;
         var _loc13_:uint = 0;
         var _loc6_:uint = 0;
         var _loc8_:uint = 0;
         while(param1.bytesAvailable > param2)
         {
            switch(((_loc10_ = ReadUtils.read$TYPE_UINT32(param1)) >>> 3) - 1)
            {
               case 0:
                  if(_loc11_ != 0)
                  {
                     throw new IOError("Bad data format: RateUpdate.rate cannot be set twice.");
                  }
                  _loc11_++;
                  rate = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 1:
                  if(_loc9_ != 0)
                  {
                     throw new IOError("Bad data format: RateUpdate.beginTime cannot be set twice.");
                  }
                  _loc9_++;
                  beginTime = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 2:
                  if(_loc4_ != 0)
                  {
                     throw new IOError("Bad data format: RateUpdate.endTime cannot be set twice.");
                  }
                  _loc4_++;
                  endTime = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 3:
                  if(_loc5_ != 0)
                  {
                     throw new IOError("Bad data format: RateUpdate.beginDay cannot be set twice.");
                  }
                  _loc5_++;
                  beginDay = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 4:
                  if(_loc12_ != 0)
                  {
                     throw new IOError("Bad data format: RateUpdate.endDay cannot be set twice.");
                  }
                  _loc12_++;
                  endDay = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 5:
                  if(_loc7_ != 0)
                  {
                     throw new IOError("Bad data format: RateUpdate.bufferType cannot be set twice.");
                  }
                  _loc7_++;
                  bufferType = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 6:
                  if(_loc3_ != 0)
                  {
                     throw new IOError("Bad data format: RateUpdate.param1 cannot be set twice.");
                  }
                  _loc3_++;
                  param1 = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 7:
                  if(_loc13_ != 0)
                  {
                     throw new IOError("Bad data format: RateUpdate.param2 cannot be set twice.");
                  }
                  _loc13_++;
                  param2 = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 8:
                  if(_loc6_ != 0)
                  {
                     throw new IOError("Bad data format: RateUpdate.rateName cannot be set twice.");
                  }
                  _loc6_++;
                  rateName = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 9:
                  if(_loc8_ != 0)
                  {
                     throw new IOError("Bad data format: RateUpdate.rateDesc cannot be set twice.");
                  }
                  _loc8_++;
                  rateDesc = ReadUtils.read$TYPE_STRING(param1);
                  break;
               default:
                  ReadUtils.skip(param1,_loc10_ & 7);
            }
         }
      }
   }
}

