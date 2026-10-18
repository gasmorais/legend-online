package com.road.yishi.proto.airgarden
{
   import com.netease.protobuf.Int64;
   import com.netease.protobuf.Message;
   import com.netease.protobuf.ReadUtils;
   import com.netease.protobuf.WriteUtils;
   import com.netease.protobuf.WritingBuffer;
   import flash.errors.IOError;
   import flash.utils.IDataInput;
   import flash.utils.IExternalizable;
   
   public final class AirGardenStateMsg extends Message implements IExternalizable
   {
      
      private var canCreateParty$field:Boolean;
      
      private var hasField$0:uint = 0;
      
      private var createBeginTime$field:Int64;
      
      private var createEndTime$field:Int64;
      
      private var isParty$field:Boolean;
      
      private var partyBeginTime$field:Int64;
      
      private var partyEndTime$field:Int64;
      
      private var selfCreatedParty$field:Boolean;
      
      private var selfUpCount$field:int;
      
      private var upCdEndTime$field:Int64;
      
      public function AirGardenStateMsg()
      {
         super();
      }
      
      public function removeCanCreateParty() : void
      {
         hasField$0 &= 4294967294;
         canCreateParty$field = new Boolean();
      }
      
      public function get hasCanCreateParty() : Boolean
      {
         return (hasField$0 & 1) != 0;
      }
      
      public function set canCreateParty(param1:Boolean) : void
      {
         hasField$0 |= 1;
         canCreateParty$field = param1;
      }
      
      public function get canCreateParty() : Boolean
      {
         return canCreateParty$field;
      }
      
      public function removeCreateBeginTime() : void
      {
         createBeginTime$field = null;
      }
      
      public function get hasCreateBeginTime() : Boolean
      {
         return createBeginTime$field != null;
      }
      
      public function set createBeginTime(param1:Int64) : void
      {
         createBeginTime$field = param1;
      }
      
      public function get createBeginTime() : Int64
      {
         return createBeginTime$field;
      }
      
      public function removeCreateEndTime() : void
      {
         createEndTime$field = null;
      }
      
      public function get hasCreateEndTime() : Boolean
      {
         return createEndTime$field != null;
      }
      
      public function set createEndTime(param1:Int64) : void
      {
         createEndTime$field = param1;
      }
      
      public function get createEndTime() : Int64
      {
         return createEndTime$field;
      }
      
      public function removeIsParty() : void
      {
         hasField$0 &= 4294967293;
         isParty$field = new Boolean();
      }
      
      public function get hasIsParty() : Boolean
      {
         return (hasField$0 & 2) != 0;
      }
      
      public function set isParty(param1:Boolean) : void
      {
         hasField$0 |= 2;
         isParty$field = param1;
      }
      
      public function get isParty() : Boolean
      {
         return isParty$field;
      }
      
      public function removePartyBeginTime() : void
      {
         partyBeginTime$field = null;
      }
      
      public function get hasPartyBeginTime() : Boolean
      {
         return partyBeginTime$field != null;
      }
      
      public function set partyBeginTime(param1:Int64) : void
      {
         partyBeginTime$field = param1;
      }
      
      public function get partyBeginTime() : Int64
      {
         return partyBeginTime$field;
      }
      
      public function removePartyEndTime() : void
      {
         partyEndTime$field = null;
      }
      
      public function get hasPartyEndTime() : Boolean
      {
         return partyEndTime$field != null;
      }
      
      public function set partyEndTime(param1:Int64) : void
      {
         partyEndTime$field = param1;
      }
      
      public function get partyEndTime() : Int64
      {
         return partyEndTime$field;
      }
      
      public function removeSelfCreatedParty() : void
      {
         hasField$0 &= 4294967291;
         selfCreatedParty$field = new Boolean();
      }
      
      public function get hasSelfCreatedParty() : Boolean
      {
         return (hasField$0 & 4) != 0;
      }
      
      public function set selfCreatedParty(param1:Boolean) : void
      {
         hasField$0 |= 4;
         selfCreatedParty$field = param1;
      }
      
      public function get selfCreatedParty() : Boolean
      {
         return selfCreatedParty$field;
      }
      
      public function removeSelfUpCount() : void
      {
         hasField$0 &= 4294967287;
         selfUpCount$field = new int();
      }
      
      public function get hasSelfUpCount() : Boolean
      {
         return (hasField$0 & 8) != 0;
      }
      
      public function set selfUpCount(param1:int) : void
      {
         hasField$0 |= 8;
         selfUpCount$field = param1;
      }
      
      public function get selfUpCount() : int
      {
         return selfUpCount$field;
      }
      
      public function removeUpCdEndTime() : void
      {
         upCdEndTime$field = null;
      }
      
      public function get hasUpCdEndTime() : Boolean
      {
         return upCdEndTime$field != null;
      }
      
      public function set upCdEndTime(param1:Int64) : void
      {
         upCdEndTime$field = param1;
      }
      
      public function get upCdEndTime() : Int64
      {
         return upCdEndTime$field;
      }
      
      final override public function writeToBuffer(param1:WritingBuffer) : void
      {
         if(hasCanCreateParty)
         {
            WriteUtils.writeTag(param1,0,1);
            WriteUtils.write$TYPE_BOOL(param1,canCreateParty$field);
         }
         if(hasCreateBeginTime)
         {
            WriteUtils.writeTag(param1,0,2);
            WriteUtils.write$TYPE_INT64(param1,createBeginTime$field);
         }
         if(hasCreateEndTime)
         {
            WriteUtils.writeTag(param1,0,3);
            WriteUtils.write$TYPE_INT64(param1,createEndTime$field);
         }
         if(hasIsParty)
         {
            WriteUtils.writeTag(param1,0,4);
            WriteUtils.write$TYPE_BOOL(param1,isParty$field);
         }
         if(hasPartyBeginTime)
         {
            WriteUtils.writeTag(param1,0,5);
            WriteUtils.write$TYPE_INT64(param1,partyBeginTime$field);
         }
         if(hasPartyEndTime)
         {
            WriteUtils.writeTag(param1,0,6);
            WriteUtils.write$TYPE_INT64(param1,partyEndTime$field);
         }
         if(hasSelfCreatedParty)
         {
            WriteUtils.writeTag(param1,0,7);
            WriteUtils.write$TYPE_BOOL(param1,selfCreatedParty$field);
         }
         if(hasSelfUpCount)
         {
            WriteUtils.writeTag(param1,0,8);
            WriteUtils.write$TYPE_INT32(param1,selfUpCount$field);
         }
         if(hasUpCdEndTime)
         {
            WriteUtils.writeTag(param1,0,9);
            WriteUtils.write$TYPE_INT64(param1,upCdEndTime$field);
         }
      }
      
      final override public function readFromSlice(param1:IDataInput, param2:uint) : void
      {
         var _loc12_:* = 0;
         var _loc7_:uint = 0;
         var _loc10_:uint = 0;
         var _loc6_:uint = 0;
         var _loc8_:uint = 0;
         var _loc4_:uint = 0;
         var _loc11_:uint = 0;
         var _loc9_:uint = 0;
         var _loc5_:uint = 0;
         var _loc3_:uint = 0;
         while(param1.bytesAvailable > param2)
         {
            switch(((_loc12_ = ReadUtils.read$TYPE_UINT32(param1)) >>> 3) - 1)
            {
               case 0:
                  if(_loc7_ != 0)
                  {
                     throw new IOError("Bad data format: AirGardenStateMsg.canCreateParty cannot be set twice.");
                  }
                  _loc7_++;
                  canCreateParty = ReadUtils.read$TYPE_BOOL(param1);
                  break;
               case 1:
                  if(_loc10_ != 0)
                  {
                     throw new IOError("Bad data format: AirGardenStateMsg.createBeginTime cannot be set twice.");
                  }
                  _loc10_++;
                  createBeginTime = ReadUtils.read$TYPE_INT64(param1);
                  break;
               case 2:
                  if(_loc6_ != 0)
                  {
                     throw new IOError("Bad data format: AirGardenStateMsg.createEndTime cannot be set twice.");
                  }
                  _loc6_++;
                  createEndTime = ReadUtils.read$TYPE_INT64(param1);
                  break;
               case 3:
                  if(_loc8_ != 0)
                  {
                     throw new IOError("Bad data format: AirGardenStateMsg.isParty cannot be set twice.");
                  }
                  _loc8_++;
                  isParty = ReadUtils.read$TYPE_BOOL(param1);
                  break;
               case 4:
                  if(_loc4_ != 0)
                  {
                     throw new IOError("Bad data format: AirGardenStateMsg.partyBeginTime cannot be set twice.");
                  }
                  _loc4_++;
                  partyBeginTime = ReadUtils.read$TYPE_INT64(param1);
                  break;
               case 5:
                  if(_loc11_ != 0)
                  {
                     throw new IOError("Bad data format: AirGardenStateMsg.partyEndTime cannot be set twice.");
                  }
                  _loc11_++;
                  partyEndTime = ReadUtils.read$TYPE_INT64(param1);
                  break;
               case 6:
                  if(_loc9_ != 0)
                  {
                     throw new IOError("Bad data format: AirGardenStateMsg.selfCreatedParty cannot be set twice.");
                  }
                  _loc9_++;
                  selfCreatedParty = ReadUtils.read$TYPE_BOOL(param1);
                  break;
               case 7:
                  if(_loc5_ != 0)
                  {
                     throw new IOError("Bad data format: AirGardenStateMsg.selfUpCount cannot be set twice.");
                  }
                  _loc5_++;
                  selfUpCount = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 8:
                  if(_loc3_ != 0)
                  {
                     throw new IOError("Bad data format: AirGardenStateMsg.upCdEndTime cannot be set twice.");
                  }
                  _loc3_++;
                  upCdEndTime = ReadUtils.read$TYPE_INT64(param1);
                  break;
               default:
                  ReadUtils.skip(param1,_loc12_ & 7);
            }
         }
      }
   }
}

