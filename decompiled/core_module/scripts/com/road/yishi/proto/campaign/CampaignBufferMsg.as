package com.road.yishi.proto.campaign
{
   import com.netease.protobuf.*;
   import flash.errors.IOError;
   import flash.utils.IDataInput;
   import flash.utils.IExternalizable;
   
   public final class CampaignBufferMsg extends Message implements IExternalizable
   {
      
      private var army_id$field:int;
      
      private var hasField$0:uint = 0;
      
      [ArrayElementType("com.road.yishi.proto.campaign.BufferInfoMsg")]
      public var bufferInfo:Array = [];
      
      private var property1$field:int;
      
      private var property2$field:int;
      
      private var property3$field:int;
      
      public function CampaignBufferMsg()
      {
         super();
      }
      
      public function removeArmyId() : void
      {
         hasField$0 &= 4294967294;
         army_id$field = new int();
      }
      
      public function get hasArmyId() : Boolean
      {
         return (hasField$0 & 1) != 0;
      }
      
      public function set armyId(param1:int) : void
      {
         hasField$0 |= 1;
         army_id$field = param1;
      }
      
      public function get armyId() : int
      {
         return army_id$field;
      }
      
      public function removeProperty1() : void
      {
         hasField$0 &= 4294967293;
         property1$field = new int();
      }
      
      public function get hasProperty1() : Boolean
      {
         return (hasField$0 & 2) != 0;
      }
      
      public function set property1(param1:int) : void
      {
         hasField$0 |= 2;
         property1$field = param1;
      }
      
      public function get property1() : int
      {
         return property1$field;
      }
      
      public function removeProperty2() : void
      {
         hasField$0 &= 4294967291;
         property2$field = new int();
      }
      
      public function get hasProperty2() : Boolean
      {
         return (hasField$0 & 4) != 0;
      }
      
      public function set property2(param1:int) : void
      {
         hasField$0 |= 4;
         property2$field = param1;
      }
      
      public function get property2() : int
      {
         return property2$field;
      }
      
      public function removeProperty3() : void
      {
         hasField$0 &= 4294967287;
         property3$field = new int();
      }
      
      public function get hasProperty3() : Boolean
      {
         return (hasField$0 & 8) != 0;
      }
      
      public function set property3(param1:int) : void
      {
         hasField$0 |= 8;
         property3$field = param1;
      }
      
      public function get property3() : int
      {
         return property3$field;
      }
      
      final override public function writeToBuffer(param1:WritingBuffer) : void
      {
         var _loc2_:* = 0;
         if(hasArmyId)
         {
            WriteUtils.writeTag(param1,0,1);
            WriteUtils.write$TYPE_INT32(param1,army_id$field);
         }
         _loc2_ = 0;
         while(_loc2_ < bufferInfo.length)
         {
            WriteUtils.writeTag(param1,2,2);
            WriteUtils.write$TYPE_MESSAGE(param1,bufferInfo[_loc2_]);
            _loc2_++;
         }
         if(hasProperty1)
         {
            WriteUtils.writeTag(param1,0,3);
            WriteUtils.write$TYPE_INT32(param1,property1$field);
         }
         if(hasProperty2)
         {
            WriteUtils.writeTag(param1,0,4);
            WriteUtils.write$TYPE_INT32(param1,property2$field);
         }
         if(hasProperty3)
         {
            WriteUtils.writeTag(param1,0,5);
            WriteUtils.write$TYPE_INT32(param1,property3$field);
         }
      }
      
      final override public function readFromSlice(param1:IDataInput, param2:uint) : void
      {
         var _loc7_:* = 0;
         var _loc3_:BufferInfoMsg = null;
         var _loc5_:uint = 0;
         var _loc6_:uint = 0;
         var _loc8_:uint = 0;
         var _loc4_:uint = 0;
         while(param1.bytesAvailable > param2)
         {
            switch(((_loc7_ = ReadUtils.read$TYPE_UINT32(param1)) >>> 3) - 1)
            {
               case 0:
                  if(_loc5_ != 0)
                  {
                     throw new IOError("Bad data format: CampaignBufferMsg.armyId cannot be set twice.");
                  }
                  _loc5_++;
                  armyId = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 1:
                  _loc3_ = new BufferInfoMsg();
                  ReadUtils.read$TYPE_MESSAGE(param1,_loc3_);
                  bufferInfo.push(_loc3_);
                  break;
               case 2:
                  if(_loc6_ != 0)
                  {
                     throw new IOError("Bad data format: CampaignBufferMsg.property1 cannot be set twice.");
                  }
                  _loc6_++;
                  property1 = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 3:
                  if(_loc8_ != 0)
                  {
                     throw new IOError("Bad data format: CampaignBufferMsg.property2 cannot be set twice.");
                  }
                  _loc8_++;
                  property2 = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 4:
                  if(_loc4_ != 0)
                  {
                     throw new IOError("Bad data format: CampaignBufferMsg.property3 cannot be set twice.");
                  }
                  _loc4_++;
                  property3 = ReadUtils.read$TYPE_INT32(param1);
                  break;
               default:
                  ReadUtils.skip(param1,_loc7_ & 7);
            }
         }
      }
   }
}

