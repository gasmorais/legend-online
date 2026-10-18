package com.road.yishi.proto.active
{
   import com.netease.protobuf.Message;
   import com.netease.protobuf.ReadUtils;
   import com.netease.protobuf.WriteUtils;
   import com.netease.protobuf.WritingBuffer;
   import flash.errors.IOError;
   import flash.utils.IDataInput;
   import flash.utils.IExternalizable;
   
   public final class NewMountFeedMsg extends Message implements IExternalizable
   {
      
      private var begin_tm$field:String;
      
      private var end_tm$field:String;
      
      private var mount_level$field:int;
      
      private var hasField$0:uint = 0;
      
      private var rebate$field:int;
      
      private var toal_cost$field:int;
      
      private var rebate_point$field:int;
      
      private var complete$field:Boolean;
      
      public function NewMountFeedMsg()
      {
         super();
      }
      
      public function removeBeginTm() : void
      {
         begin_tm$field = null;
      }
      
      public function get hasBeginTm() : Boolean
      {
         return begin_tm$field != null;
      }
      
      public function set beginTm(param1:String) : void
      {
         begin_tm$field = param1;
      }
      
      public function get beginTm() : String
      {
         return begin_tm$field;
      }
      
      public function removeEndTm() : void
      {
         end_tm$field = null;
      }
      
      public function get hasEndTm() : Boolean
      {
         return end_tm$field != null;
      }
      
      public function set endTm(param1:String) : void
      {
         end_tm$field = param1;
      }
      
      public function get endTm() : String
      {
         return end_tm$field;
      }
      
      public function removeMountLevel() : void
      {
         hasField$0 &= 4294967294;
         mount_level$field = new int();
      }
      
      public function get hasMountLevel() : Boolean
      {
         return (hasField$0 & 1) != 0;
      }
      
      public function set mountLevel(param1:int) : void
      {
         hasField$0 |= 1;
         mount_level$field = param1;
      }
      
      public function get mountLevel() : int
      {
         return mount_level$field;
      }
      
      public function removeRebate() : void
      {
         hasField$0 &= 4294967293;
         rebate$field = new int();
      }
      
      public function get hasRebate() : Boolean
      {
         return (hasField$0 & 2) != 0;
      }
      
      public function set rebate(param1:int) : void
      {
         hasField$0 |= 2;
         rebate$field = param1;
      }
      
      public function get rebate() : int
      {
         return rebate$field;
      }
      
      public function removeToalCost() : void
      {
         hasField$0 &= 4294967291;
         toal_cost$field = new int();
      }
      
      public function get hasToalCost() : Boolean
      {
         return (hasField$0 & 4) != 0;
      }
      
      public function set toalCost(param1:int) : void
      {
         hasField$0 |= 4;
         toal_cost$field = param1;
      }
      
      public function get toalCost() : int
      {
         return toal_cost$field;
      }
      
      public function removeRebatePoint() : void
      {
         hasField$0 &= 4294967287;
         rebate_point$field = new int();
      }
      
      public function get hasRebatePoint() : Boolean
      {
         return (hasField$0 & 8) != 0;
      }
      
      public function set rebatePoint(param1:int) : void
      {
         hasField$0 |= 8;
         rebate_point$field = param1;
      }
      
      public function get rebatePoint() : int
      {
         return rebate_point$field;
      }
      
      public function removeComplete() : void
      {
         hasField$0 &= 4294967279;
         complete$field = new Boolean();
      }
      
      public function get hasComplete() : Boolean
      {
         return (hasField$0 & 0x10) != 0;
      }
      
      public function set complete(param1:Boolean) : void
      {
         hasField$0 |= 16;
         complete$field = param1;
      }
      
      public function get complete() : Boolean
      {
         return complete$field;
      }
      
      final override public function writeToBuffer(param1:WritingBuffer) : void
      {
         if(hasBeginTm)
         {
            WriteUtils.writeTag(param1,2,1);
            WriteUtils.write$TYPE_STRING(param1,begin_tm$field);
         }
         if(hasEndTm)
         {
            WriteUtils.writeTag(param1,2,2);
            WriteUtils.write$TYPE_STRING(param1,end_tm$field);
         }
         if(hasMountLevel)
         {
            WriteUtils.writeTag(param1,0,3);
            WriteUtils.write$TYPE_INT32(param1,mount_level$field);
         }
         if(hasRebate)
         {
            WriteUtils.writeTag(param1,0,4);
            WriteUtils.write$TYPE_INT32(param1,rebate$field);
         }
         if(hasToalCost)
         {
            WriteUtils.writeTag(param1,0,5);
            WriteUtils.write$TYPE_INT32(param1,toal_cost$field);
         }
         if(hasRebatePoint)
         {
            WriteUtils.writeTag(param1,0,6);
            WriteUtils.write$TYPE_INT32(param1,rebate_point$field);
         }
         if(hasComplete)
         {
            WriteUtils.writeTag(param1,0,7);
            WriteUtils.write$TYPE_BOOL(param1,complete$field);
         }
      }
      
      final override public function readFromSlice(param1:IDataInput, param2:uint) : void
      {
         var _loc8_:* = 0;
         var _loc4_:uint = 0;
         var _loc9_:uint = 0;
         var _loc5_:uint = 0;
         var _loc6_:uint = 0;
         var _loc10_:uint = 0;
         var _loc7_:uint = 0;
         var _loc3_:uint = 0;
         while(param1.bytesAvailable > param2)
         {
            switch(((_loc8_ = ReadUtils.read$TYPE_UINT32(param1)) >>> 3) - 1)
            {
               case 0:
                  if(_loc4_ != 0)
                  {
                     throw new IOError("Bad data format: NewMountFeedMsg.beginTm cannot be set twice.");
                  }
                  _loc4_++;
                  beginTm = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 1:
                  if(_loc9_ != 0)
                  {
                     throw new IOError("Bad data format: NewMountFeedMsg.endTm cannot be set twice.");
                  }
                  _loc9_++;
                  endTm = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 2:
                  if(_loc5_ != 0)
                  {
                     throw new IOError("Bad data format: NewMountFeedMsg.mountLevel cannot be set twice.");
                  }
                  _loc5_++;
                  mountLevel = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 3:
                  if(_loc6_ != 0)
                  {
                     throw new IOError("Bad data format: NewMountFeedMsg.rebate cannot be set twice.");
                  }
                  _loc6_++;
                  rebate = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 4:
                  if(_loc10_ != 0)
                  {
                     throw new IOError("Bad data format: NewMountFeedMsg.toalCost cannot be set twice.");
                  }
                  _loc10_++;
                  toalCost = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 5:
                  if(_loc7_ != 0)
                  {
                     throw new IOError("Bad data format: NewMountFeedMsg.rebatePoint cannot be set twice.");
                  }
                  _loc7_++;
                  rebatePoint = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 6:
                  if(_loc3_ != 0)
                  {
                     throw new IOError("Bad data format: NewMountFeedMsg.complete cannot be set twice.");
                  }
                  _loc3_++;
                  complete = ReadUtils.read$TYPE_BOOL(param1);
                  break;
               default:
                  ReadUtils.skip(param1,_loc8_ & 7);
            }
         }
      }
   }
}

