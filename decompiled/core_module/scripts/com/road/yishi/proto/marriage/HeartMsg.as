package com.road.yishi.proto.marriage
{
   import com.netease.protobuf.*;
   import flash.errors.IOError;
   import flash.utils.IDataInput;
   import flash.utils.IExternalizable;
   
   public final class HeartMsg extends Message implements IExternalizable
   {
      
      private var order$field:int;
      
      private var hasField$0:uint = 0;
      
      private var templateId$field:int;
      
      [ArrayElementType("int")]
      public var options:Array = [];
      
      private var result$field:int;
      
      private var option_a$field:int;
      
      private var option_b$field:int;
      
      private var remain_time$field:int;
      
      private var random$field:int;
      
      public function HeartMsg()
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
      
      public function removeTemplateId() : void
      {
         hasField$0 &= 4294967293;
         templateId$field = new int();
      }
      
      public function get hasTemplateId() : Boolean
      {
         return (hasField$0 & 2) != 0;
      }
      
      public function set templateId(param1:int) : void
      {
         hasField$0 |= 2;
         templateId$field = param1;
      }
      
      public function get templateId() : int
      {
         return templateId$field;
      }
      
      public function removeResult() : void
      {
         hasField$0 &= 4294967291;
         result$field = new int();
      }
      
      public function get hasResult() : Boolean
      {
         return (hasField$0 & 4) != 0;
      }
      
      public function set result(param1:int) : void
      {
         hasField$0 |= 4;
         result$field = param1;
      }
      
      public function get result() : int
      {
         return result$field;
      }
      
      public function removeOptionA() : void
      {
         hasField$0 &= 4294967287;
         option_a$field = new int();
      }
      
      public function get hasOptionA() : Boolean
      {
         return (hasField$0 & 8) != 0;
      }
      
      public function set optionA(param1:int) : void
      {
         hasField$0 |= 8;
         option_a$field = param1;
      }
      
      public function get optionA() : int
      {
         return option_a$field;
      }
      
      public function removeOptionB() : void
      {
         hasField$0 &= 4294967279;
         option_b$field = new int();
      }
      
      public function get hasOptionB() : Boolean
      {
         return (hasField$0 & 0x10) != 0;
      }
      
      public function set optionB(param1:int) : void
      {
         hasField$0 |= 16;
         option_b$field = param1;
      }
      
      public function get optionB() : int
      {
         return option_b$field;
      }
      
      public function removeRemainTime() : void
      {
         hasField$0 &= 4294967263;
         remain_time$field = new int();
      }
      
      public function get hasRemainTime() : Boolean
      {
         return (hasField$0 & 0x20) != 0;
      }
      
      public function set remainTime(param1:int) : void
      {
         hasField$0 |= 32;
         remain_time$field = param1;
      }
      
      public function get remainTime() : int
      {
         return remain_time$field;
      }
      
      public function removeRandom() : void
      {
         hasField$0 &= 4294967231;
         random$field = new int();
      }
      
      public function get hasRandom() : Boolean
      {
         return (hasField$0 & 0x40) != 0;
      }
      
      public function set random(param1:int) : void
      {
         hasField$0 |= 64;
         random$field = param1;
      }
      
      public function get random() : int
      {
         return random$field;
      }
      
      final override public function writeToBuffer(param1:WritingBuffer) : void
      {
         var _loc2_:* = 0;
         if(hasOrder)
         {
            WriteUtils.writeTag(param1,0,1);
            WriteUtils.write$TYPE_INT32(param1,order$field);
         }
         if(hasTemplateId)
         {
            WriteUtils.writeTag(param1,0,2);
            WriteUtils.write$TYPE_INT32(param1,templateId$field);
         }
         _loc2_ = 0;
         while(_loc2_ < options.length)
         {
            WriteUtils.writeTag(param1,0,3);
            WriteUtils.write$TYPE_INT32(param1,options[_loc2_]);
            _loc2_++;
         }
         if(hasResult)
         {
            WriteUtils.writeTag(param1,0,4);
            WriteUtils.write$TYPE_INT32(param1,result$field);
         }
         if(hasOptionA)
         {
            WriteUtils.writeTag(param1,0,5);
            WriteUtils.write$TYPE_INT32(param1,option_a$field);
         }
         if(hasOptionB)
         {
            WriteUtils.writeTag(param1,0,6);
            WriteUtils.write$TYPE_INT32(param1,option_b$field);
         }
         if(hasRemainTime)
         {
            WriteUtils.writeTag(param1,0,7);
            WriteUtils.write$TYPE_INT32(param1,remain_time$field);
         }
         if(hasRandom)
         {
            WriteUtils.writeTag(param1,0,8);
            WriteUtils.write$TYPE_INT32(param1,random$field);
         }
      }
      
      final override public function readFromSlice(param1:IDataInput, param2:uint) : void
      {
         var _loc10_:* = 0;
         var _loc5_:uint = 0;
         var _loc6_:uint = 0;
         var _loc9_:uint = 0;
         var _loc8_:uint = 0;
         var _loc3_:uint = 0;
         var _loc7_:uint = 0;
         var _loc4_:uint = 0;
         while(param1.bytesAvailable > param2)
         {
            switch(((_loc10_ = ReadUtils.read$TYPE_UINT32(param1)) >>> 3) - 1)
            {
               case 0:
                  if(_loc5_ != 0)
                  {
                     throw new IOError("Bad data format: HeartMsg.order cannot be set twice.");
                  }
                  _loc5_++;
                  order = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 1:
                  if(_loc6_ != 0)
                  {
                     throw new IOError("Bad data format: HeartMsg.templateId cannot be set twice.");
                  }
                  _loc6_++;
                  templateId = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 2:
                  if((_loc10_ & 7) == 2)
                  {
                     ReadUtils.readPackedRepeated(param1,ReadUtils.read$TYPE_INT32,options);
                  }
                  else
                  {
                     options.push(ReadUtils.read$TYPE_INT32(param1));
                  }
                  break;
               case 3:
                  if(_loc9_ != 0)
                  {
                     throw new IOError("Bad data format: HeartMsg.result cannot be set twice.");
                  }
                  _loc9_++;
                  result = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 4:
                  if(_loc8_ != 0)
                  {
                     throw new IOError("Bad data format: HeartMsg.optionA cannot be set twice.");
                  }
                  _loc8_++;
                  optionA = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 5:
                  if(_loc3_ != 0)
                  {
                     throw new IOError("Bad data format: HeartMsg.optionB cannot be set twice.");
                  }
                  _loc3_++;
                  optionB = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 6:
                  if(_loc7_ != 0)
                  {
                     throw new IOError("Bad data format: HeartMsg.remainTime cannot be set twice.");
                  }
                  _loc7_++;
                  remainTime = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 7:
                  if(_loc4_ != 0)
                  {
                     throw new IOError("Bad data format: HeartMsg.random cannot be set twice.");
                  }
                  _loc4_++;
                  random = ReadUtils.read$TYPE_INT32(param1);
                  break;
               default:
                  ReadUtils.skip(param1,_loc10_ & 7);
            }
         }
      }
   }
}

