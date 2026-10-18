package com.road.yishi.proto.antaeus
{
   import com.netease.protobuf.Message;
   import com.netease.protobuf.ReadUtils;
   import com.netease.protobuf.WriteUtils;
   import com.netease.protobuf.WritingBuffer;
   import flash.errors.IOError;
   import flash.utils.IDataInput;
   import flash.utils.IExternalizable;
   
   public final class GoddessShowMsg extends Message implements IExternalizable
   {
      
      private var templateId$field:int;
      
      private var hasField$0:uint = 0;
      
      private var attack$field:int;
      
      private var defance$field:int;
      
      private var magicAttack$field:int;
      
      private var magicDefance$field:int;
      
      private var live$field:int;
      
      public function GoddessShowMsg()
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
      
      public function removeDefance() : void
      {
         hasField$0 &= 4294967291;
         defance$field = new int();
      }
      
      public function get hasDefance() : Boolean
      {
         return (hasField$0 & 4) != 0;
      }
      
      public function set defance(param1:int) : void
      {
         hasField$0 |= 4;
         defance$field = param1;
      }
      
      public function get defance() : int
      {
         return defance$field;
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
      
      public function removeMagicDefance() : void
      {
         hasField$0 &= 4294967279;
         magicDefance$field = new int();
      }
      
      public function get hasMagicDefance() : Boolean
      {
         return (hasField$0 & 0x10) != 0;
      }
      
      public function set magicDefance(param1:int) : void
      {
         hasField$0 |= 16;
         magicDefance$field = param1;
      }
      
      public function get magicDefance() : int
      {
         return magicDefance$field;
      }
      
      public function removeLive() : void
      {
         hasField$0 &= 4294967263;
         live$field = new int();
      }
      
      public function get hasLive() : Boolean
      {
         return (hasField$0 & 0x20) != 0;
      }
      
      public function set live(param1:int) : void
      {
         hasField$0 |= 32;
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
         if(hasDefance)
         {
            WriteUtils.writeTag(param1,0,3);
            WriteUtils.write$TYPE_INT32(param1,defance$field);
         }
         if(hasMagicAttack)
         {
            WriteUtils.writeTag(param1,0,4);
            WriteUtils.write$TYPE_INT32(param1,magicAttack$field);
         }
         if(hasMagicDefance)
         {
            WriteUtils.writeTag(param1,0,5);
            WriteUtils.write$TYPE_INT32(param1,magicDefance$field);
         }
         if(hasLive)
         {
            WriteUtils.writeTag(param1,0,6);
            WriteUtils.write$TYPE_INT32(param1,live$field);
         }
      }
      
      final override public function readFromSlice(param1:IDataInput, param2:uint) : void
      {
         var _loc8_:* = 0;
         var _loc5_:uint = 0;
         var _loc6_:uint = 0;
         var _loc3_:uint = 0;
         var _loc7_:uint = 0;
         var _loc9_:uint = 0;
         var _loc4_:uint = 0;
         while(param1.bytesAvailable > param2)
         {
            switch(((_loc8_ = ReadUtils.read$TYPE_UINT32(param1)) >>> 3) - 1)
            {
               case 0:
                  if(_loc5_ != 0)
                  {
                     throw new IOError("Bad data format: GoddessShowMsg.templateId cannot be set twice.");
                  }
                  _loc5_++;
                  templateId = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 1:
                  if(_loc6_ != 0)
                  {
                     throw new IOError("Bad data format: GoddessShowMsg.attack cannot be set twice.");
                  }
                  _loc6_++;
                  attack = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 2:
                  if(_loc3_ != 0)
                  {
                     throw new IOError("Bad data format: GoddessShowMsg.defance cannot be set twice.");
                  }
                  _loc3_++;
                  defance = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 3:
                  if(_loc7_ != 0)
                  {
                     throw new IOError("Bad data format: GoddessShowMsg.magicAttack cannot be set twice.");
                  }
                  _loc7_++;
                  magicAttack = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 4:
                  if(_loc9_ != 0)
                  {
                     throw new IOError("Bad data format: GoddessShowMsg.magicDefance cannot be set twice.");
                  }
                  _loc9_++;
                  magicDefance = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 5:
                  if(_loc4_ != 0)
                  {
                     throw new IOError("Bad data format: GoddessShowMsg.live cannot be set twice.");
                  }
                  _loc4_++;
                  live = ReadUtils.read$TYPE_INT32(param1);
                  break;
               default:
                  ReadUtils.skip(param1,_loc8_ & 7);
            }
         }
      }
   }
}

