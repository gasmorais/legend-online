package com.road.yishi.proto.children
{
   import com.netease.protobuf.Message;
   import com.netease.protobuf.ReadUtils;
   import com.netease.protobuf.WriteUtils;
   import com.netease.protobuf.WritingBuffer;
   import flash.errors.IOError;
   import flash.utils.IDataInput;
   import flash.utils.IExternalizable;
   
   public final class SpiritArtifactInfoMsg extends Message implements IExternalizable
   {
      
      private var progress$field:int;
      
      private var hasField$0:uint = 0;
      
      private var isEquip$field:Boolean;
      
      private var resis$field:String;
      
      private var resiTypes$field:String;
      
      private var enchants$field:String;
      
      public function SpiritArtifactInfoMsg()
      {
         super();
      }
      
      public function removeProgress() : void
      {
         hasField$0 &= 4294967294;
         progress$field = new int();
      }
      
      public function get hasProgress() : Boolean
      {
         return (hasField$0 & 1) != 0;
      }
      
      public function set progress(param1:int) : void
      {
         hasField$0 |= 1;
         progress$field = param1;
      }
      
      public function get progress() : int
      {
         return progress$field;
      }
      
      public function removeIsEquip() : void
      {
         hasField$0 &= 4294967293;
         isEquip$field = new Boolean();
      }
      
      public function get hasIsEquip() : Boolean
      {
         return (hasField$0 & 2) != 0;
      }
      
      public function set isEquip(param1:Boolean) : void
      {
         hasField$0 |= 2;
         isEquip$field = param1;
      }
      
      public function get isEquip() : Boolean
      {
         return isEquip$field;
      }
      
      public function removeResis() : void
      {
         resis$field = null;
      }
      
      public function get hasResis() : Boolean
      {
         return resis$field != null;
      }
      
      public function set resis(param1:String) : void
      {
         resis$field = param1;
      }
      
      public function get resis() : String
      {
         return resis$field;
      }
      
      public function removeResiTypes() : void
      {
         resiTypes$field = null;
      }
      
      public function get hasResiTypes() : Boolean
      {
         return resiTypes$field != null;
      }
      
      public function set resiTypes(param1:String) : void
      {
         resiTypes$field = param1;
      }
      
      public function get resiTypes() : String
      {
         return resiTypes$field;
      }
      
      public function removeEnchants() : void
      {
         enchants$field = null;
      }
      
      public function get hasEnchants() : Boolean
      {
         return enchants$field != null;
      }
      
      public function set enchants(param1:String) : void
      {
         enchants$field = param1;
      }
      
      public function get enchants() : String
      {
         return enchants$field;
      }
      
      final override public function writeToBuffer(param1:WritingBuffer) : void
      {
         if(hasProgress)
         {
            WriteUtils.writeTag(param1,0,1);
            WriteUtils.write$TYPE_INT32(param1,progress$field);
         }
         if(hasIsEquip)
         {
            WriteUtils.writeTag(param1,0,2);
            WriteUtils.write$TYPE_BOOL(param1,isEquip$field);
         }
         if(hasResis)
         {
            WriteUtils.writeTag(param1,2,3);
            WriteUtils.write$TYPE_STRING(param1,resis$field);
         }
         if(hasResiTypes)
         {
            WriteUtils.writeTag(param1,2,4);
            WriteUtils.write$TYPE_STRING(param1,resiTypes$field);
         }
         if(hasEnchants)
         {
            WriteUtils.writeTag(param1,2,5);
            WriteUtils.write$TYPE_STRING(param1,enchants$field);
         }
      }
      
      final override public function readFromSlice(param1:IDataInput, param2:uint) : void
      {
         var _loc8_:* = 0;
         var _loc3_:uint = 0;
         var _loc6_:uint = 0;
         var _loc5_:uint = 0;
         var _loc4_:uint = 0;
         var _loc7_:uint = 0;
         while(param1.bytesAvailable > param2)
         {
            switch(((_loc8_ = ReadUtils.read$TYPE_UINT32(param1)) >>> 3) - 1)
            {
               case 0:
                  if(_loc3_ != 0)
                  {
                     throw new IOError("Bad data format: SpiritArtifactInfoMsg.progress cannot be set twice.");
                  }
                  _loc3_++;
                  progress = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 1:
                  if(_loc6_ != 0)
                  {
                     throw new IOError("Bad data format: SpiritArtifactInfoMsg.isEquip cannot be set twice.");
                  }
                  _loc6_++;
                  isEquip = ReadUtils.read$TYPE_BOOL(param1);
                  break;
               case 2:
                  if(_loc5_ != 0)
                  {
                     throw new IOError("Bad data format: SpiritArtifactInfoMsg.resis cannot be set twice.");
                  }
                  _loc5_++;
                  resis = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 3:
                  if(_loc4_ != 0)
                  {
                     throw new IOError("Bad data format: SpiritArtifactInfoMsg.resiTypes cannot be set twice.");
                  }
                  _loc4_++;
                  resiTypes = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 4:
                  if(_loc7_ != 0)
                  {
                     throw new IOError("Bad data format: SpiritArtifactInfoMsg.enchants cannot be set twice.");
                  }
                  _loc7_++;
                  enchants = ReadUtils.read$TYPE_STRING(param1);
                  break;
               default:
                  ReadUtils.skip(param1,_loc8_ & 7);
            }
         }
      }
   }
}

