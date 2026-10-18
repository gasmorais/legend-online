package com.road.yishi.proto.battle
{
   import com.netease.protobuf.Message;
   import com.netease.protobuf.ReadUtils;
   import com.netease.protobuf.WriteUtils;
   import com.netease.protobuf.WritingBuffer;
   import flash.errors.IOError;
   import flash.utils.IDataInput;
   import flash.utils.IExternalizable;
   
   public final class CoolDownMsg extends Message implements IExternalizable
   {
      
      private var templated_id$field:int;
      
      private var hasField$0:uint = 0;
      
      private var cool_down$field:int;
      
      private var cool_type$field:int;
      
      private var appear_cool_down$field:int;
      
      public function CoolDownMsg()
      {
         super();
      }
      
      public function removeTemplatedId() : void
      {
         hasField$0 &= 4294967294;
         templated_id$field = new int();
      }
      
      public function get hasTemplatedId() : Boolean
      {
         return (hasField$0 & 1) != 0;
      }
      
      public function set templatedId(param1:int) : void
      {
         hasField$0 |= 1;
         templated_id$field = param1;
      }
      
      public function get templatedId() : int
      {
         return templated_id$field;
      }
      
      public function removeCoolDown() : void
      {
         hasField$0 &= 4294967293;
         cool_down$field = new int();
      }
      
      public function get hasCoolDown() : Boolean
      {
         return (hasField$0 & 2) != 0;
      }
      
      public function set coolDown(param1:int) : void
      {
         hasField$0 |= 2;
         cool_down$field = param1;
      }
      
      public function get coolDown() : int
      {
         return cool_down$field;
      }
      
      public function removeCoolType() : void
      {
         hasField$0 &= 4294967291;
         cool_type$field = new int();
      }
      
      public function get hasCoolType() : Boolean
      {
         return (hasField$0 & 4) != 0;
      }
      
      public function set coolType(param1:int) : void
      {
         hasField$0 |= 4;
         cool_type$field = param1;
      }
      
      public function get coolType() : int
      {
         return cool_type$field;
      }
      
      public function removeAppearCoolDown() : void
      {
         hasField$0 &= 4294967287;
         appear_cool_down$field = new int();
      }
      
      public function get hasAppearCoolDown() : Boolean
      {
         return (hasField$0 & 8) != 0;
      }
      
      public function set appearCoolDown(param1:int) : void
      {
         hasField$0 |= 8;
         appear_cool_down$field = param1;
      }
      
      public function get appearCoolDown() : int
      {
         return appear_cool_down$field;
      }
      
      final override public function writeToBuffer(param1:WritingBuffer) : void
      {
         if(hasTemplatedId)
         {
            WriteUtils.writeTag(param1,0,1);
            WriteUtils.write$TYPE_INT32(param1,templated_id$field);
         }
         if(hasCoolDown)
         {
            WriteUtils.writeTag(param1,0,2);
            WriteUtils.write$TYPE_INT32(param1,cool_down$field);
         }
         if(hasCoolType)
         {
            WriteUtils.writeTag(param1,0,3);
            WriteUtils.write$TYPE_INT32(param1,cool_type$field);
         }
         if(hasAppearCoolDown)
         {
            WriteUtils.writeTag(param1,0,4);
            WriteUtils.write$TYPE_INT32(param1,appear_cool_down$field);
         }
      }
      
      final override public function readFromSlice(param1:IDataInput, param2:uint) : void
      {
         var _loc6_:* = 0;
         var _loc4_:uint = 0;
         var _loc7_:uint = 0;
         var _loc5_:uint = 0;
         var _loc3_:uint = 0;
         while(param1.bytesAvailable > param2)
         {
            switch(((_loc6_ = ReadUtils.read$TYPE_UINT32(param1)) >>> 3) - 1)
            {
               case 0:
                  if(_loc4_ != 0)
                  {
                     throw new IOError("Bad data format: CoolDownMsg.templatedId cannot be set twice.");
                  }
                  _loc4_++;
                  templatedId = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 1:
                  if(_loc7_ != 0)
                  {
                     throw new IOError("Bad data format: CoolDownMsg.coolDown cannot be set twice.");
                  }
                  _loc7_++;
                  coolDown = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 2:
                  if(_loc5_ != 0)
                  {
                     throw new IOError("Bad data format: CoolDownMsg.coolType cannot be set twice.");
                  }
                  _loc5_++;
                  coolType = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 3:
                  if(_loc3_ != 0)
                  {
                     throw new IOError("Bad data format: CoolDownMsg.appearCoolDown cannot be set twice.");
                  }
                  _loc3_++;
                  appearCoolDown = ReadUtils.read$TYPE_INT32(param1);
                  break;
               default:
                  ReadUtils.skip(param1,_loc6_ & 7);
            }
         }
      }
   }
}

