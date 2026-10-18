package com.road.yishi.proto.slate
{
   import com.netease.protobuf.Message;
   import com.netease.protobuf.ReadUtils;
   import com.netease.protobuf.WriteUtils;
   import com.netease.protobuf.WritingBuffer;
   import flash.errors.IOError;
   import flash.utils.IDataInput;
   import flash.utils.IExternalizable;
   
   public final class SlatePropertyMsg extends Message implements IExternalizable
   {
      
      private var attack$field:int;
      
      private var hasField$0:uint = 0;
      
      private var defence$field:int;
      
      private var magicAttack$field:int;
      
      private var magicDefence$field:int;
      
      private var forceHit$field:int;
      
      private var parry$field:int;
      
      private var live$field:int;
      
      private var penetrate$field:int;
      
      public function SlatePropertyMsg()
      {
         super();
      }
      
      public function removeAttack() : void
      {
         hasField$0 &= 4294967294;
         attack$field = new int();
      }
      
      public function get hasAttack() : Boolean
      {
         return (hasField$0 & 1) != 0;
      }
      
      public function set attack(param1:int) : void
      {
         hasField$0 |= 1;
         attack$field = param1;
      }
      
      public function get attack() : int
      {
         return attack$field;
      }
      
      public function removeDefence() : void
      {
         hasField$0 &= 4294967293;
         defence$field = new int();
      }
      
      public function get hasDefence() : Boolean
      {
         return (hasField$0 & 2) != 0;
      }
      
      public function set defence(param1:int) : void
      {
         hasField$0 |= 2;
         defence$field = param1;
      }
      
      public function get defence() : int
      {
         return defence$field;
      }
      
      public function removeMagicAttack() : void
      {
         hasField$0 &= 4294967291;
         magicAttack$field = new int();
      }
      
      public function get hasMagicAttack() : Boolean
      {
         return (hasField$0 & 4) != 0;
      }
      
      public function set magicAttack(param1:int) : void
      {
         hasField$0 |= 4;
         magicAttack$field = param1;
      }
      
      public function get magicAttack() : int
      {
         return magicAttack$field;
      }
      
      public function removeMagicDefence() : void
      {
         hasField$0 &= 4294967287;
         magicDefence$field = new int();
      }
      
      public function get hasMagicDefence() : Boolean
      {
         return (hasField$0 & 8) != 0;
      }
      
      public function set magicDefence(param1:int) : void
      {
         hasField$0 |= 8;
         magicDefence$field = param1;
      }
      
      public function get magicDefence() : int
      {
         return magicDefence$field;
      }
      
      public function removeForceHit() : void
      {
         hasField$0 &= 4294967279;
         forceHit$field = new int();
      }
      
      public function get hasForceHit() : Boolean
      {
         return (hasField$0 & 0x10) != 0;
      }
      
      public function set forceHit(param1:int) : void
      {
         hasField$0 |= 16;
         forceHit$field = param1;
      }
      
      public function get forceHit() : int
      {
         return forceHit$field;
      }
      
      public function removeParry() : void
      {
         hasField$0 &= 4294967263;
         parry$field = new int();
      }
      
      public function get hasParry() : Boolean
      {
         return (hasField$0 & 0x20) != 0;
      }
      
      public function set parry(param1:int) : void
      {
         hasField$0 |= 32;
         parry$field = param1;
      }
      
      public function get parry() : int
      {
         return parry$field;
      }
      
      public function removeLive() : void
      {
         hasField$0 &= 4294967231;
         live$field = new int();
      }
      
      public function get hasLive() : Boolean
      {
         return (hasField$0 & 0x40) != 0;
      }
      
      public function set live(param1:int) : void
      {
         hasField$0 |= 64;
         live$field = param1;
      }
      
      public function get live() : int
      {
         return live$field;
      }
      
      public function removePenetrate() : void
      {
         hasField$0 &= 4294967167;
         penetrate$field = new int();
      }
      
      public function get hasPenetrate() : Boolean
      {
         return (hasField$0 & 0x80) != 0;
      }
      
      public function set penetrate(param1:int) : void
      {
         hasField$0 |= 128;
         penetrate$field = param1;
      }
      
      public function get penetrate() : int
      {
         return penetrate$field;
      }
      
      final override public function writeToBuffer(param1:WritingBuffer) : void
      {
         if(hasAttack)
         {
            WriteUtils.writeTag(param1,0,1);
            WriteUtils.write$TYPE_INT32(param1,attack$field);
         }
         if(hasDefence)
         {
            WriteUtils.writeTag(param1,0,2);
            WriteUtils.write$TYPE_INT32(param1,defence$field);
         }
         if(hasMagicAttack)
         {
            WriteUtils.writeTag(param1,0,3);
            WriteUtils.write$TYPE_INT32(param1,magicAttack$field);
         }
         if(hasMagicDefence)
         {
            WriteUtils.writeTag(param1,0,4);
            WriteUtils.write$TYPE_INT32(param1,magicDefence$field);
         }
         if(hasForceHit)
         {
            WriteUtils.writeTag(param1,0,5);
            WriteUtils.write$TYPE_INT32(param1,forceHit$field);
         }
         if(hasParry)
         {
            WriteUtils.writeTag(param1,0,6);
            WriteUtils.write$TYPE_INT32(param1,parry$field);
         }
         if(hasLive)
         {
            WriteUtils.writeTag(param1,0,7);
            WriteUtils.write$TYPE_INT32(param1,live$field);
         }
         if(hasPenetrate)
         {
            WriteUtils.writeTag(param1,0,8);
            WriteUtils.write$TYPE_INT32(param1,penetrate$field);
         }
      }
      
      final override public function readFromSlice(param1:IDataInput, param2:uint) : void
      {
         var _loc9_:* = 0;
         var _loc5_:uint = 0;
         var _loc11_:uint = 0;
         var _loc6_:uint = 0;
         var _loc10_:uint = 0;
         var _loc3_:uint = 0;
         var _loc7_:uint = 0;
         var _loc4_:uint = 0;
         var _loc8_:uint = 0;
         while(param1.bytesAvailable > param2)
         {
            switch(((_loc9_ = ReadUtils.read$TYPE_UINT32(param1)) >>> 3) - 1)
            {
               case 0:
                  if(_loc5_ != 0)
                  {
                     throw new IOError("Bad data format: SlatePropertyMsg.attack cannot be set twice.");
                  }
                  _loc5_++;
                  attack = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 1:
                  if(_loc11_ != 0)
                  {
                     throw new IOError("Bad data format: SlatePropertyMsg.defence cannot be set twice.");
                  }
                  _loc11_++;
                  defence = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 2:
                  if(_loc6_ != 0)
                  {
                     throw new IOError("Bad data format: SlatePropertyMsg.magicAttack cannot be set twice.");
                  }
                  _loc6_++;
                  magicAttack = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 3:
                  if(_loc10_ != 0)
                  {
                     throw new IOError("Bad data format: SlatePropertyMsg.magicDefence cannot be set twice.");
                  }
                  _loc10_++;
                  magicDefence = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 4:
                  if(_loc3_ != 0)
                  {
                     throw new IOError("Bad data format: SlatePropertyMsg.forceHit cannot be set twice.");
                  }
                  _loc3_++;
                  forceHit = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 5:
                  if(_loc7_ != 0)
                  {
                     throw new IOError("Bad data format: SlatePropertyMsg.parry cannot be set twice.");
                  }
                  _loc7_++;
                  parry = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 6:
                  if(_loc4_ != 0)
                  {
                     throw new IOError("Bad data format: SlatePropertyMsg.live cannot be set twice.");
                  }
                  _loc4_++;
                  live = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 7:
                  if(_loc8_ != 0)
                  {
                     throw new IOError("Bad data format: SlatePropertyMsg.penetrate cannot be set twice.");
                  }
                  _loc8_++;
                  penetrate = ReadUtils.read$TYPE_INT32(param1);
                  break;
               default:
                  ReadUtils.skip(param1,_loc9_ & 7);
            }
         }
      }
   }
}

