package com.road.yishi.proto.goddess
{
   import com.netease.protobuf.Message;
   import com.netease.protobuf.ReadUtils;
   import com.netease.protobuf.WriteUtils;
   import com.netease.protobuf.WritingBuffer;
   import flash.errors.IOError;
   import flash.utils.IDataInput;
   import flash.utils.IExternalizable;
   
   public final class GoddessEquipInfoMsg extends Message implements IExternalizable
   {
      
      private var equipType$field:int;
      
      private var hasField$0:uint = 0;
      
      private var equipStrengthenLevel$field:int;
      
      private var equipAdvanceLevel$field:int;
      
      private var equipCurBlessing$field:int;
      
      public function GoddessEquipInfoMsg()
      {
         super();
      }
      
      public function removeEquipType() : void
      {
         hasField$0 &= 4294967294;
         equipType$field = new int();
      }
      
      public function get hasEquipType() : Boolean
      {
         return (hasField$0 & 1) != 0;
      }
      
      public function set equipType(param1:int) : void
      {
         hasField$0 |= 1;
         equipType$field = param1;
      }
      
      public function get equipType() : int
      {
         return equipType$field;
      }
      
      public function removeEquipStrengthenLevel() : void
      {
         hasField$0 &= 4294967293;
         equipStrengthenLevel$field = new int();
      }
      
      public function get hasEquipStrengthenLevel() : Boolean
      {
         return (hasField$0 & 2) != 0;
      }
      
      public function set equipStrengthenLevel(param1:int) : void
      {
         hasField$0 |= 2;
         equipStrengthenLevel$field = param1;
      }
      
      public function get equipStrengthenLevel() : int
      {
         return equipStrengthenLevel$field;
      }
      
      public function removeEquipAdvanceLevel() : void
      {
         hasField$0 &= 4294967291;
         equipAdvanceLevel$field = new int();
      }
      
      public function get hasEquipAdvanceLevel() : Boolean
      {
         return (hasField$0 & 4) != 0;
      }
      
      public function set equipAdvanceLevel(param1:int) : void
      {
         hasField$0 |= 4;
         equipAdvanceLevel$field = param1;
      }
      
      public function get equipAdvanceLevel() : int
      {
         return equipAdvanceLevel$field;
      }
      
      public function removeEquipCurBlessing() : void
      {
         hasField$0 &= 4294967287;
         equipCurBlessing$field = new int();
      }
      
      public function get hasEquipCurBlessing() : Boolean
      {
         return (hasField$0 & 8) != 0;
      }
      
      public function set equipCurBlessing(param1:int) : void
      {
         hasField$0 |= 8;
         equipCurBlessing$field = param1;
      }
      
      public function get equipCurBlessing() : int
      {
         return equipCurBlessing$field;
      }
      
      final override public function writeToBuffer(param1:WritingBuffer) : void
      {
         if(hasEquipType)
         {
            WriteUtils.writeTag(param1,0,1);
            WriteUtils.write$TYPE_INT32(param1,equipType$field);
         }
         if(hasEquipStrengthenLevel)
         {
            WriteUtils.writeTag(param1,0,2);
            WriteUtils.write$TYPE_INT32(param1,equipStrengthenLevel$field);
         }
         if(hasEquipAdvanceLevel)
         {
            WriteUtils.writeTag(param1,0,3);
            WriteUtils.write$TYPE_INT32(param1,equipAdvanceLevel$field);
         }
         if(hasEquipCurBlessing)
         {
            WriteUtils.writeTag(param1,0,4);
            WriteUtils.write$TYPE_INT32(param1,equipCurBlessing$field);
         }
      }
      
      final override public function readFromSlice(param1:IDataInput, param2:uint) : void
      {
         var _loc6_:* = 0;
         var _loc3_:uint = 0;
         var _loc7_:uint = 0;
         var _loc5_:uint = 0;
         var _loc4_:uint = 0;
         while(param1.bytesAvailable > param2)
         {
            switch(((_loc6_ = ReadUtils.read$TYPE_UINT32(param1)) >>> 3) - 1)
            {
               case 0:
                  if(_loc3_ != 0)
                  {
                     throw new IOError("Bad data format: GoddessEquipInfoMsg.equipType cannot be set twice.");
                  }
                  _loc3_++;
                  equipType = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 1:
                  if(_loc7_ != 0)
                  {
                     throw new IOError("Bad data format: GoddessEquipInfoMsg.equipStrengthenLevel cannot be set twice.");
                  }
                  _loc7_++;
                  equipStrengthenLevel = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 2:
                  if(_loc5_ != 0)
                  {
                     throw new IOError("Bad data format: GoddessEquipInfoMsg.equipAdvanceLevel cannot be set twice.");
                  }
                  _loc5_++;
                  equipAdvanceLevel = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 3:
                  if(_loc4_ != 0)
                  {
                     throw new IOError("Bad data format: GoddessEquipInfoMsg.equipCurBlessing cannot be set twice.");
                  }
                  _loc4_++;
                  equipCurBlessing = ReadUtils.read$TYPE_INT32(param1);
                  break;
               default:
                  ReadUtils.skip(param1,_loc6_ & 7);
            }
         }
      }
   }
}

