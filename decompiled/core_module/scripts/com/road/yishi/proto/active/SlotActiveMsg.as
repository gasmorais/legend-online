package com.road.yishi.proto.active
{
   import com.netease.protobuf.Message;
   import com.netease.protobuf.ReadUtils;
   import com.netease.protobuf.WriteUtils;
   import com.netease.protobuf.WritingBuffer;
   import flash.errors.IOError;
   import flash.utils.IDataInput;
   import flash.utils.IExternalizable;
   
   public final class SlotActiveMsg extends Message implements IExternalizable
   {
      
      public var open:Boolean;
      
      public var op:int;
      
      private var status$field:int;
      
      private var hasField$0:uint = 0;
      
      private var slot$field:String;
      
      private var type$field:int;
      
      private var rewarditemtemplateid$field:int;
      
      private var findcost$field:int;
      
      public function SlotActiveMsg()
      {
         super();
      }
      
      public function removeStatus() : void
      {
         hasField$0 &= 4294967294;
         status$field = new int();
      }
      
      public function get hasStatus() : Boolean
      {
         return (hasField$0 & 1) != 0;
      }
      
      public function set status(param1:int) : void
      {
         hasField$0 |= 1;
         status$field = param1;
      }
      
      public function get status() : int
      {
         return status$field;
      }
      
      public function removeSlot() : void
      {
         slot$field = null;
      }
      
      public function get hasSlot() : Boolean
      {
         return slot$field != null;
      }
      
      public function set slot(param1:String) : void
      {
         slot$field = param1;
      }
      
      public function get slot() : String
      {
         return slot$field;
      }
      
      public function removeType() : void
      {
         hasField$0 &= 4294967293;
         type$field = new int();
      }
      
      public function get hasType() : Boolean
      {
         return (hasField$0 & 2) != 0;
      }
      
      public function set type(param1:int) : void
      {
         hasField$0 |= 2;
         type$field = param1;
      }
      
      public function get type() : int
      {
         return type$field;
      }
      
      public function removeRewarditemtemplateid() : void
      {
         hasField$0 &= 4294967291;
         rewarditemtemplateid$field = new int();
      }
      
      public function get hasRewarditemtemplateid() : Boolean
      {
         return (hasField$0 & 4) != 0;
      }
      
      public function set rewarditemtemplateid(param1:int) : void
      {
         hasField$0 |= 4;
         rewarditemtemplateid$field = param1;
      }
      
      public function get rewarditemtemplateid() : int
      {
         return rewarditemtemplateid$field;
      }
      
      public function removeFindcost() : void
      {
         hasField$0 &= 4294967287;
         findcost$field = new int();
      }
      
      public function get hasFindcost() : Boolean
      {
         return (hasField$0 & 8) != 0;
      }
      
      public function set findcost(param1:int) : void
      {
         hasField$0 |= 8;
         findcost$field = param1;
      }
      
      public function get findcost() : int
      {
         return findcost$field;
      }
      
      final override public function writeToBuffer(param1:WritingBuffer) : void
      {
         WriteUtils.writeTag(param1,0,1);
         WriteUtils.write$TYPE_BOOL(param1,open);
         WriteUtils.writeTag(param1,0,2);
         WriteUtils.write$TYPE_INT32(param1,op);
         if(hasStatus)
         {
            WriteUtils.writeTag(param1,0,3);
            WriteUtils.write$TYPE_INT32(param1,status$field);
         }
         if(hasSlot)
         {
            WriteUtils.writeTag(param1,2,4);
            WriteUtils.write$TYPE_STRING(param1,slot$field);
         }
         if(hasType)
         {
            WriteUtils.writeTag(param1,0,5);
            WriteUtils.write$TYPE_INT32(param1,type$field);
         }
         if(hasRewarditemtemplateid)
         {
            WriteUtils.writeTag(param1,0,6);
            WriteUtils.write$TYPE_INT32(param1,rewarditemtemplateid$field);
         }
         if(hasFindcost)
         {
            WriteUtils.writeTag(param1,0,7);
            WriteUtils.write$TYPE_INT32(param1,findcost$field);
         }
      }
      
      final override public function readFromSlice(param1:IDataInput, param2:uint) : void
      {
         var _loc7_:* = 0;
         var _loc3_:uint = 0;
         var _loc9_:uint = 0;
         var _loc8_:uint = 0;
         var _loc10_:uint = 0;
         var _loc5_:uint = 0;
         var _loc6_:uint = 0;
         var _loc4_:uint = 0;
         while(param1.bytesAvailable > param2)
         {
            switch(((_loc7_ = ReadUtils.read$TYPE_UINT32(param1)) >>> 3) - 1)
            {
               case 0:
                  if(_loc3_ != 0)
                  {
                     throw new IOError("Bad data format: SlotActiveMsg.open cannot be set twice.");
                  }
                  _loc3_++;
                  open = ReadUtils.read$TYPE_BOOL(param1);
                  break;
               case 1:
                  if(_loc9_ != 0)
                  {
                     throw new IOError("Bad data format: SlotActiveMsg.op cannot be set twice.");
                  }
                  _loc9_++;
                  op = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 2:
                  if(_loc8_ != 0)
                  {
                     throw new IOError("Bad data format: SlotActiveMsg.status cannot be set twice.");
                  }
                  _loc8_++;
                  status = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 3:
                  if(_loc10_ != 0)
                  {
                     throw new IOError("Bad data format: SlotActiveMsg.slot cannot be set twice.");
                  }
                  _loc10_++;
                  slot = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 4:
                  if(_loc5_ != 0)
                  {
                     throw new IOError("Bad data format: SlotActiveMsg.type cannot be set twice.");
                  }
                  _loc5_++;
                  type = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 5:
                  if(_loc6_ != 0)
                  {
                     throw new IOError("Bad data format: SlotActiveMsg.rewarditemtemplateid cannot be set twice.");
                  }
                  _loc6_++;
                  rewarditemtemplateid = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 6:
                  if(_loc4_ != 0)
                  {
                     throw new IOError("Bad data format: SlotActiveMsg.findcost cannot be set twice.");
                  }
                  _loc4_++;
                  findcost = ReadUtils.read$TYPE_INT32(param1);
                  break;
               default:
                  ReadUtils.skip(param1,_loc7_ & 7);
            }
         }
         if(_loc3_ != 1)
         {
            throw new IOError("Bad data format: SlotActiveMsg.open must be set.");
         }
         if(_loc9_ != 1)
         {
            throw new IOError("Bad data format: SlotActiveMsg.op must be set.");
         }
      }
   }
}

