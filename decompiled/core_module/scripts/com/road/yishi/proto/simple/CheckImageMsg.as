package com.road.yishi.proto.simple
{
   import com.netease.protobuf.Message;
   import com.netease.protobuf.ReadUtils;
   import com.netease.protobuf.WriteUtils;
   import com.netease.protobuf.WritingBuffer;
   import flash.errors.IOError;
   import flash.utils.ByteArray;
   import flash.utils.IDataInput;
   import flash.utils.IExternalizable;
   
   public final class CheckImageMsg extends Message implements IExternalizable
   {
      
      private var left_count$field:int;
      
      private var hasField$0:uint = 0;
      
      private var left_time$field:int;
      
      private var images1$field:ByteArray;
      
      private var images2$field:ByteArray;
      
      private var images3$field:ByteArray;
      
      private var images4$field:ByteArray;
      
      private var result$field:String;
      
      private var property1$field:String;
      
      private var property2$field:String;
      
      public function CheckImageMsg()
      {
         super();
      }
      
      public function removeLeftCount() : void
      {
         hasField$0 &= 4294967294;
         left_count$field = new int();
      }
      
      public function get hasLeftCount() : Boolean
      {
         return (hasField$0 & 1) != 0;
      }
      
      public function set leftCount(param1:int) : void
      {
         hasField$0 |= 1;
         left_count$field = param1;
      }
      
      public function get leftCount() : int
      {
         return left_count$field;
      }
      
      public function removeLeftTime() : void
      {
         hasField$0 &= 4294967293;
         left_time$field = new int();
      }
      
      public function get hasLeftTime() : Boolean
      {
         return (hasField$0 & 2) != 0;
      }
      
      public function set leftTime(param1:int) : void
      {
         hasField$0 |= 2;
         left_time$field = param1;
      }
      
      public function get leftTime() : int
      {
         return left_time$field;
      }
      
      public function removeImages1() : void
      {
         images1$field = null;
      }
      
      public function get hasImages1() : Boolean
      {
         return images1$field != null;
      }
      
      public function set images1(param1:ByteArray) : void
      {
         images1$field = param1;
      }
      
      public function get images1() : ByteArray
      {
         return images1$field;
      }
      
      public function removeImages2() : void
      {
         images2$field = null;
      }
      
      public function get hasImages2() : Boolean
      {
         return images2$field != null;
      }
      
      public function set images2(param1:ByteArray) : void
      {
         images2$field = param1;
      }
      
      public function get images2() : ByteArray
      {
         return images2$field;
      }
      
      public function removeImages3() : void
      {
         images3$field = null;
      }
      
      public function get hasImages3() : Boolean
      {
         return images3$field != null;
      }
      
      public function set images3(param1:ByteArray) : void
      {
         images3$field = param1;
      }
      
      public function get images3() : ByteArray
      {
         return images3$field;
      }
      
      public function removeImages4() : void
      {
         images4$field = null;
      }
      
      public function get hasImages4() : Boolean
      {
         return images4$field != null;
      }
      
      public function set images4(param1:ByteArray) : void
      {
         images4$field = param1;
      }
      
      public function get images4() : ByteArray
      {
         return images4$field;
      }
      
      public function removeResult() : void
      {
         result$field = null;
      }
      
      public function get hasResult() : Boolean
      {
         return result$field != null;
      }
      
      public function set result(param1:String) : void
      {
         result$field = param1;
      }
      
      public function get result() : String
      {
         return result$field;
      }
      
      public function removeProperty1() : void
      {
         property1$field = null;
      }
      
      public function get hasProperty1() : Boolean
      {
         return property1$field != null;
      }
      
      public function set property1(param1:String) : void
      {
         property1$field = param1;
      }
      
      public function get property1() : String
      {
         return property1$field;
      }
      
      public function removeProperty2() : void
      {
         property2$field = null;
      }
      
      public function get hasProperty2() : Boolean
      {
         return property2$field != null;
      }
      
      public function set property2(param1:String) : void
      {
         property2$field = param1;
      }
      
      public function get property2() : String
      {
         return property2$field;
      }
      
      final override public function writeToBuffer(param1:WritingBuffer) : void
      {
         if(hasLeftCount)
         {
            WriteUtils.writeTag(param1,0,1);
            WriteUtils.write$TYPE_INT32(param1,left_count$field);
         }
         if(hasLeftTime)
         {
            WriteUtils.writeTag(param1,0,2);
            WriteUtils.write$TYPE_INT32(param1,left_time$field);
         }
         if(hasImages1)
         {
            WriteUtils.writeTag(param1,2,3);
            WriteUtils.write$TYPE_BYTES(param1,images1$field);
         }
         if(hasImages2)
         {
            WriteUtils.writeTag(param1,2,4);
            WriteUtils.write$TYPE_BYTES(param1,images2$field);
         }
         if(hasImages3)
         {
            WriteUtils.writeTag(param1,2,5);
            WriteUtils.write$TYPE_BYTES(param1,images3$field);
         }
         if(hasImages4)
         {
            WriteUtils.writeTag(param1,2,6);
            WriteUtils.write$TYPE_BYTES(param1,images4$field);
         }
         if(hasResult)
         {
            WriteUtils.writeTag(param1,2,7);
            WriteUtils.write$TYPE_STRING(param1,result$field);
         }
         if(hasProperty1)
         {
            WriteUtils.writeTag(param1,2,8);
            WriteUtils.write$TYPE_STRING(param1,property1$field);
         }
         if(hasProperty2)
         {
            WriteUtils.writeTag(param1,2,9);
            WriteUtils.write$TYPE_STRING(param1,property2$field);
         }
      }
      
      final override public function readFromSlice(param1:IDataInput, param2:uint) : void
      {
         var _loc9_:* = 0;
         var _loc11_:uint = 0;
         var _loc4_:uint = 0;
         var _loc5_:uint = 0;
         var _loc10_:uint = 0;
         var _loc7_:uint = 0;
         var _loc3_:uint = 0;
         var _loc8_:uint = 0;
         var _loc6_:uint = 0;
         var _loc12_:uint = 0;
         while(param1.bytesAvailable > param2)
         {
            switch(((_loc9_ = ReadUtils.read$TYPE_UINT32(param1)) >>> 3) - 1)
            {
               case 0:
                  if(_loc11_ != 0)
                  {
                     throw new IOError("Bad data format: CheckImageMsg.leftCount cannot be set twice.");
                  }
                  _loc11_++;
                  leftCount = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 1:
                  if(_loc4_ != 0)
                  {
                     throw new IOError("Bad data format: CheckImageMsg.leftTime cannot be set twice.");
                  }
                  _loc4_++;
                  leftTime = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 2:
                  if(_loc5_ != 0)
                  {
                     throw new IOError("Bad data format: CheckImageMsg.images1 cannot be set twice.");
                  }
                  _loc5_++;
                  images1 = ReadUtils.read$TYPE_BYTES(param1);
                  break;
               case 3:
                  if(_loc10_ != 0)
                  {
                     throw new IOError("Bad data format: CheckImageMsg.images2 cannot be set twice.");
                  }
                  _loc10_++;
                  images2 = ReadUtils.read$TYPE_BYTES(param1);
                  break;
               case 4:
                  if(_loc7_ != 0)
                  {
                     throw new IOError("Bad data format: CheckImageMsg.images3 cannot be set twice.");
                  }
                  _loc7_++;
                  images3 = ReadUtils.read$TYPE_BYTES(param1);
                  break;
               case 5:
                  if(_loc3_ != 0)
                  {
                     throw new IOError("Bad data format: CheckImageMsg.images4 cannot be set twice.");
                  }
                  _loc3_++;
                  images4 = ReadUtils.read$TYPE_BYTES(param1);
                  break;
               case 6:
                  if(_loc8_ != 0)
                  {
                     throw new IOError("Bad data format: CheckImageMsg.result cannot be set twice.");
                  }
                  _loc8_++;
                  result = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 7:
                  if(_loc6_ != 0)
                  {
                     throw new IOError("Bad data format: CheckImageMsg.property1 cannot be set twice.");
                  }
                  _loc6_++;
                  property1 = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 8:
                  if(_loc12_ != 0)
                  {
                     throw new IOError("Bad data format: CheckImageMsg.property2 cannot be set twice.");
                  }
                  _loc12_++;
                  property2 = ReadUtils.read$TYPE_STRING(param1);
                  break;
               default:
                  ReadUtils.skip(param1,_loc9_ & 7);
            }
         }
      }
   }
}

