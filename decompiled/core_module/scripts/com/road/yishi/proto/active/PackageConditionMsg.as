package com.road.yishi.proto.active
{
   import com.netease.protobuf.Message;
   import com.netease.protobuf.ReadUtils;
   import com.netease.protobuf.WriteUtils;
   import com.netease.protobuf.WritingBuffer;
   import flash.errors.IOError;
   import flash.utils.IDataInput;
   import flash.utils.IExternalizable;
   
   public final class PackageConditionMsg extends Message implements IExternalizable
   {
      
      private var condition_id$field:int;
      
      private var hasField$0:uint = 0;
      
      private var condition_value$field:int;
      
      private var condition_bak$field:int;
      
      private var condition_bak2$field:int;
      
      private var condition_bak3$field:int;
      
      private var condition_bak4$field:int;
      
      public function PackageConditionMsg()
      {
         super();
      }
      
      public function removeConditionId() : void
      {
         hasField$0 &= 4294967294;
         condition_id$field = new int();
      }
      
      public function get hasConditionId() : Boolean
      {
         return (hasField$0 & 1) != 0;
      }
      
      public function set conditionId(param1:int) : void
      {
         hasField$0 |= 1;
         condition_id$field = param1;
      }
      
      public function get conditionId() : int
      {
         return condition_id$field;
      }
      
      public function removeConditionValue() : void
      {
         hasField$0 &= 4294967293;
         condition_value$field = new int();
      }
      
      public function get hasConditionValue() : Boolean
      {
         return (hasField$0 & 2) != 0;
      }
      
      public function set conditionValue(param1:int) : void
      {
         hasField$0 |= 2;
         condition_value$field = param1;
      }
      
      public function get conditionValue() : int
      {
         return condition_value$field;
      }
      
      public function removeConditionBak() : void
      {
         hasField$0 &= 4294967291;
         condition_bak$field = new int();
      }
      
      public function get hasConditionBak() : Boolean
      {
         return (hasField$0 & 4) != 0;
      }
      
      public function set conditionBak(param1:int) : void
      {
         hasField$0 |= 4;
         condition_bak$field = param1;
      }
      
      public function get conditionBak() : int
      {
         return condition_bak$field;
      }
      
      public function removeConditionBak2() : void
      {
         hasField$0 &= 4294967287;
         condition_bak2$field = new int();
      }
      
      public function get hasConditionBak2() : Boolean
      {
         return (hasField$0 & 8) != 0;
      }
      
      public function set conditionBak2(param1:int) : void
      {
         hasField$0 |= 8;
         condition_bak2$field = param1;
      }
      
      public function get conditionBak2() : int
      {
         return condition_bak2$field;
      }
      
      public function removeConditionBak3() : void
      {
         hasField$0 &= 4294967279;
         condition_bak3$field = new int();
      }
      
      public function get hasConditionBak3() : Boolean
      {
         return (hasField$0 & 0x10) != 0;
      }
      
      public function set conditionBak3(param1:int) : void
      {
         hasField$0 |= 16;
         condition_bak3$field = param1;
      }
      
      public function get conditionBak3() : int
      {
         return condition_bak3$field;
      }
      
      public function removeConditionBak4() : void
      {
         hasField$0 &= 4294967263;
         condition_bak4$field = new int();
      }
      
      public function get hasConditionBak4() : Boolean
      {
         return (hasField$0 & 0x20) != 0;
      }
      
      public function set conditionBak4(param1:int) : void
      {
         hasField$0 |= 32;
         condition_bak4$field = param1;
      }
      
      public function get conditionBak4() : int
      {
         return condition_bak4$field;
      }
      
      final override public function writeToBuffer(param1:WritingBuffer) : void
      {
         if(hasConditionId)
         {
            WriteUtils.writeTag(param1,0,1);
            WriteUtils.write$TYPE_INT32(param1,condition_id$field);
         }
         if(hasConditionValue)
         {
            WriteUtils.writeTag(param1,0,2);
            WriteUtils.write$TYPE_INT32(param1,condition_value$field);
         }
         if(hasConditionBak)
         {
            WriteUtils.writeTag(param1,0,3);
            WriteUtils.write$TYPE_INT32(param1,condition_bak$field);
         }
         if(hasConditionBak2)
         {
            WriteUtils.writeTag(param1,0,4);
            WriteUtils.write$TYPE_INT32(param1,condition_bak2$field);
         }
         if(hasConditionBak3)
         {
            WriteUtils.writeTag(param1,0,5);
            WriteUtils.write$TYPE_INT32(param1,condition_bak3$field);
         }
         if(hasConditionBak4)
         {
            WriteUtils.writeTag(param1,0,6);
            WriteUtils.write$TYPE_INT32(param1,condition_bak4$field);
         }
      }
      
      final override public function readFromSlice(param1:IDataInput, param2:uint) : void
      {
         var _loc8_:* = 0;
         var _loc9_:uint = 0;
         var _loc5_:uint = 0;
         var _loc6_:uint = 0;
         var _loc4_:uint = 0;
         var _loc3_:uint = 0;
         var _loc7_:uint = 0;
         while(param1.bytesAvailable > param2)
         {
            switch(((_loc8_ = ReadUtils.read$TYPE_UINT32(param1)) >>> 3) - 1)
            {
               case 0:
                  if(_loc9_ != 0)
                  {
                     throw new IOError("Bad data format: PackageConditionMsg.conditionId cannot be set twice.");
                  }
                  _loc9_++;
                  conditionId = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 1:
                  if(_loc5_ != 0)
                  {
                     throw new IOError("Bad data format: PackageConditionMsg.conditionValue cannot be set twice.");
                  }
                  _loc5_++;
                  conditionValue = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 2:
                  if(_loc6_ != 0)
                  {
                     throw new IOError("Bad data format: PackageConditionMsg.conditionBak cannot be set twice.");
                  }
                  _loc6_++;
                  conditionBak = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 3:
                  if(_loc4_ != 0)
                  {
                     throw new IOError("Bad data format: PackageConditionMsg.conditionBak2 cannot be set twice.");
                  }
                  _loc4_++;
                  conditionBak2 = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 4:
                  if(_loc3_ != 0)
                  {
                     throw new IOError("Bad data format: PackageConditionMsg.conditionBak3 cannot be set twice.");
                  }
                  _loc3_++;
                  conditionBak3 = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 5:
                  if(_loc7_ != 0)
                  {
                     throw new IOError("Bad data format: PackageConditionMsg.conditionBak4 cannot be set twice.");
                  }
                  _loc7_++;
                  conditionBak4 = ReadUtils.read$TYPE_INT32(param1);
                  break;
               default:
                  ReadUtils.skip(param1,_loc8_ & 7);
            }
         }
      }
   }
}

