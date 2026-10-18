package com.road.yishi.proto.antaeus
{
   import com.netease.protobuf.Message;
   import com.netease.protobuf.ReadUtils;
   import com.netease.protobuf.WriteUtils;
   import com.netease.protobuf.WritingBuffer;
   import flash.errors.IOError;
   import flash.utils.IDataInput;
   import flash.utils.IExternalizable;
   
   public final class ArtifactShowMsg extends Message implements IExternalizable
   {
      
      private var templateId$field:int;
      
      private var hasField$0:uint = 0;
      
      private var attack$field:int;
      
      private var defences$field:int;
      
      private var magicAttack$field:int;
      
      private var magicDefences$field:int;
      
      private var penetrate$field:int;
      
      private var parry$field:int;
      
      private var live$field:int;
      
      public function ArtifactShowMsg()
      {
         super();
      }
      
      public function removeTemplateId() : void
      {
         hasField$0 &= 4294967294;
         templateId$field = new int();
      }
      
      public function get hasTemplateId() : Boolean
      {
         return (hasField$0 & 1) != 0;
      }
      
      public function set templateId(param1:int) : void
      {
         hasField$0 |= 1;
         templateId$field = param1;
      }
      
      public function get templateId() : int
      {
         return templateId$field;
      }
      
      public function removeAttack() : void
      {
         hasField$0 &= 4294967293;
         attack$field = new int();
      }
      
      public function get hasAttack() : Boolean
      {
         return (hasField$0 & 2) != 0;
      }
      
      public function set attack(param1:int) : void
      {
         hasField$0 |= 2;
         attack$field = param1;
      }
      
      public function get attack() : int
      {
         return attack$field;
      }
      
      public function removeDefences() : void
      {
         hasField$0 &= 4294967291;
         defences$field = new int();
      }
      
      public function get hasDefences() : Boolean
      {
         return (hasField$0 & 4) != 0;
      }
      
      public function set defences(param1:int) : void
      {
         hasField$0 |= 4;
         defences$field = param1;
      }
      
      public function get defences() : int
      {
         return defences$field;
      }
      
      public function removeMagicAttack() : void
      {
         hasField$0 &= 4294967287;
         magicAttack$field = new int();
      }
      
      public function get hasMagicAttack() : Boolean
      {
         return (hasField$0 & 8) != 0;
      }
      
      public function set magicAttack(param1:int) : void
      {
         hasField$0 |= 8;
         magicAttack$field = param1;
      }
      
      public function get magicAttack() : int
      {
         return magicAttack$field;
      }
      
      public function removeMagicDefences() : void
      {
         hasField$0 &= 4294967279;
         magicDefences$field = new int();
      }
      
      public function get hasMagicDefences() : Boolean
      {
         return (hasField$0 & 0x10) != 0;
      }
      
      public function set magicDefences(param1:int) : void
      {
         hasField$0 |= 16;
         magicDefences$field = param1;
      }
      
      public function get magicDefences() : int
      {
         return magicDefences$field;
      }
      
      public function removePenetrate() : void
      {
         hasField$0 &= 4294967263;
         penetrate$field = new int();
      }
      
      public function get hasPenetrate() : Boolean
      {
         return (hasField$0 & 0x20) != 0;
      }
      
      public function set penetrate(param1:int) : void
      {
         hasField$0 |= 32;
         penetrate$field = param1;
      }
      
      public function get penetrate() : int
      {
         return penetrate$field;
      }
      
      public function removeParry() : void
      {
         hasField$0 &= 4294967231;
         parry$field = new int();
      }
      
      public function get hasParry() : Boolean
      {
         return (hasField$0 & 0x40) != 0;
      }
      
      public function set parry(param1:int) : void
      {
         hasField$0 |= 64;
         parry$field = param1;
      }
      
      public function get parry() : int
      {
         return parry$field;
      }
      
      public function removeLive() : void
      {
         hasField$0 &= 4294967167;
         live$field = new int();
      }
      
      public function get hasLive() : Boolean
      {
         return (hasField$0 & 0x80) != 0;
      }
      
      public function set live(param1:int) : void
      {
         hasField$0 |= 128;
         live$field = param1;
      }
      
      public function get live() : int
      {
         return live$field;
      }
      
      final override public function writeToBuffer(param1:WritingBuffer) : void
      {
         if(hasTemplateId)
         {
            WriteUtils.writeTag(param1,0,1);
            WriteUtils.write$TYPE_INT32(param1,templateId$field);
         }
         if(hasAttack)
         {
            WriteUtils.writeTag(param1,0,2);
            WriteUtils.write$TYPE_INT32(param1,attack$field);
         }
         if(hasDefences)
         {
            WriteUtils.writeTag(param1,0,3);
            WriteUtils.write$TYPE_INT32(param1,defences$field);
         }
         if(hasMagicAttack)
         {
            WriteUtils.writeTag(param1,0,4);
            WriteUtils.write$TYPE_INT32(param1,magicAttack$field);
         }
         if(hasMagicDefences)
         {
            WriteUtils.writeTag(param1,0,5);
            WriteUtils.write$TYPE_INT32(param1,magicDefences$field);
         }
         if(hasPenetrate)
         {
            WriteUtils.writeTag(param1,0,6);
            WriteUtils.write$TYPE_INT32(param1,penetrate$field);
         }
         if(hasParry)
         {
            WriteUtils.writeTag(param1,0,7);
            WriteUtils.write$TYPE_INT32(param1,parry$field);
         }
         if(hasLive)
         {
            WriteUtils.writeTag(param1,0,8);
            WriteUtils.write$TYPE_INT32(param1,live$field);
         }
      }
      
      final override public function readFromSlice(param1:IDataInput, param2:uint) : void
      {
         var _loc10_:* = 0;
         var _loc4_:uint = 0;
         var _loc5_:uint = 0;
         var _loc8_:uint = 0;
         var _loc6_:uint = 0;
         var _loc11_:uint = 0;
         var _loc9_:uint = 0;
         var _loc7_:uint = 0;
         var _loc3_:uint = 0;
         while(param1.bytesAvailable > param2)
         {
            switch(((_loc10_ = ReadUtils.read$TYPE_UINT32(param1)) >>> 3) - 1)
            {
               case 0:
                  if(_loc4_ != 0)
                  {
                     throw new IOError("Bad data format: ArtifactShowMsg.templateId cannot be set twice.");
                  }
                  _loc4_++;
                  templateId = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 1:
                  if(_loc5_ != 0)
                  {
                     throw new IOError("Bad data format: ArtifactShowMsg.attack cannot be set twice.");
                  }
                  _loc5_++;
                  attack = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 2:
                  if(_loc8_ != 0)
                  {
                     throw new IOError("Bad data format: ArtifactShowMsg.defences cannot be set twice.");
                  }
                  _loc8_++;
                  defences = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 3:
                  if(_loc6_ != 0)
                  {
                     throw new IOError("Bad data format: ArtifactShowMsg.magicAttack cannot be set twice.");
                  }
                  _loc6_++;
                  magicAttack = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 4:
                  if(_loc11_ != 0)
                  {
                     throw new IOError("Bad data format: ArtifactShowMsg.magicDefences cannot be set twice.");
                  }
                  _loc11_++;
                  magicDefences = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 5:
                  if(_loc9_ != 0)
                  {
                     throw new IOError("Bad data format: ArtifactShowMsg.penetrate cannot be set twice.");
                  }
                  _loc9_++;
                  penetrate = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 6:
                  if(_loc7_ != 0)
                  {
                     throw new IOError("Bad data format: ArtifactShowMsg.parry cannot be set twice.");
                  }
                  _loc7_++;
                  parry = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 7:
                  if(_loc3_ != 0)
                  {
                     throw new IOError("Bad data format: ArtifactShowMsg.live cannot be set twice.");
                  }
                  _loc3_++;
                  live = ReadUtils.read$TYPE_INT32(param1);
                  break;
               default:
                  ReadUtils.skip(param1,_loc10_ & 7);
            }
         }
      }
   }
}

