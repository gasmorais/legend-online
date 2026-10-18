package com.road.yishi.proto.battle
{
   import com.netease.protobuf.Message;
   import com.netease.protobuf.ReadUtils;
   import com.netease.protobuf.WriteUtils;
   import com.netease.protobuf.WritingBuffer;
   import flash.errors.IOError;
   import flash.utils.IDataInput;
   import flash.utils.IExternalizable;
   
   public final class ControlBuffStateMsg extends Message implements IExternalizable
   {
      
      private var controled$field:Boolean;
      
      private var hasField$0:uint = 0;
      
      private var living_id$field:int;
      
      private var side$field:int;
      
      private var pos$field:int;
      
      private var controller_living_id$field:int;
      
      public function ControlBuffStateMsg()
      {
         super();
      }
      
      public function removeControled() : void
      {
         hasField$0 &= 4294967294;
         controled$field = new Boolean();
      }
      
      public function get hasControled() : Boolean
      {
         return (hasField$0 & 1) != 0;
      }
      
      public function set controled(param1:Boolean) : void
      {
         hasField$0 |= 1;
         controled$field = param1;
      }
      
      public function get controled() : Boolean
      {
         return controled$field;
      }
      
      public function removeLivingId() : void
      {
         hasField$0 &= 4294967293;
         living_id$field = new int();
      }
      
      public function get hasLivingId() : Boolean
      {
         return (hasField$0 & 2) != 0;
      }
      
      public function set livingId(param1:int) : void
      {
         hasField$0 |= 2;
         living_id$field = param1;
      }
      
      public function get livingId() : int
      {
         return living_id$field;
      }
      
      public function removeSide() : void
      {
         hasField$0 &= 4294967291;
         side$field = new int();
      }
      
      public function get hasSide() : Boolean
      {
         return (hasField$0 & 4) != 0;
      }
      
      public function set side(param1:int) : void
      {
         hasField$0 |= 4;
         side$field = param1;
      }
      
      public function get side() : int
      {
         return side$field;
      }
      
      public function removePos() : void
      {
         hasField$0 &= 4294967287;
         pos$field = new int();
      }
      
      public function get hasPos() : Boolean
      {
         return (hasField$0 & 8) != 0;
      }
      
      public function set pos(param1:int) : void
      {
         hasField$0 |= 8;
         pos$field = param1;
      }
      
      public function get pos() : int
      {
         return pos$field;
      }
      
      public function removeControllerLivingId() : void
      {
         hasField$0 &= 4294967279;
         controller_living_id$field = new int();
      }
      
      public function get hasControllerLivingId() : Boolean
      {
         return (hasField$0 & 0x10) != 0;
      }
      
      public function set controllerLivingId(param1:int) : void
      {
         hasField$0 |= 16;
         controller_living_id$field = param1;
      }
      
      public function get controllerLivingId() : int
      {
         return controller_living_id$field;
      }
      
      final override public function writeToBuffer(param1:WritingBuffer) : void
      {
         if(hasControled)
         {
            WriteUtils.writeTag(param1,0,1);
            WriteUtils.write$TYPE_BOOL(param1,controled$field);
         }
         if(hasLivingId)
         {
            WriteUtils.writeTag(param1,0,2);
            WriteUtils.write$TYPE_INT32(param1,living_id$field);
         }
         if(hasSide)
         {
            WriteUtils.writeTag(param1,0,3);
            WriteUtils.write$TYPE_INT32(param1,side$field);
         }
         if(hasPos)
         {
            WriteUtils.writeTag(param1,0,4);
            WriteUtils.write$TYPE_INT32(param1,pos$field);
         }
         if(hasControllerLivingId)
         {
            WriteUtils.writeTag(param1,0,5);
            WriteUtils.write$TYPE_INT32(param1,controller_living_id$field);
         }
      }
      
      final override public function readFromSlice(param1:IDataInput, param2:uint) : void
      {
         var _loc6_:* = 0;
         var _loc7_:uint = 0;
         var _loc8_:uint = 0;
         var _loc3_:uint = 0;
         var _loc5_:uint = 0;
         var _loc4_:uint = 0;
         while(param1.bytesAvailable > param2)
         {
            switch(((_loc6_ = ReadUtils.read$TYPE_UINT32(param1)) >>> 3) - 1)
            {
               case 0:
                  if(_loc7_ != 0)
                  {
                     throw new IOError("Bad data format: ControlBuffStateMsg.controled cannot be set twice.");
                  }
                  _loc7_++;
                  controled = ReadUtils.read$TYPE_BOOL(param1);
                  break;
               case 1:
                  if(_loc8_ != 0)
                  {
                     throw new IOError("Bad data format: ControlBuffStateMsg.livingId cannot be set twice.");
                  }
                  _loc8_++;
                  livingId = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 2:
                  if(_loc3_ != 0)
                  {
                     throw new IOError("Bad data format: ControlBuffStateMsg.side cannot be set twice.");
                  }
                  _loc3_++;
                  side = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 3:
                  if(_loc5_ != 0)
                  {
                     throw new IOError("Bad data format: ControlBuffStateMsg.pos cannot be set twice.");
                  }
                  _loc5_++;
                  pos = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 4:
                  if(_loc4_ != 0)
                  {
                     throw new IOError("Bad data format: ControlBuffStateMsg.controllerLivingId cannot be set twice.");
                  }
                  _loc4_++;
                  controllerLivingId = ReadUtils.read$TYPE_INT32(param1);
                  break;
               default:
                  ReadUtils.skip(param1,_loc6_ & 7);
            }
         }
      }
   }
}

