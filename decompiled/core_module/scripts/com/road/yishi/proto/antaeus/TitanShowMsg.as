package com.road.yishi.proto.antaeus
{
   import com.netease.protobuf.Message;
   import com.netease.protobuf.ReadUtils;
   import com.netease.protobuf.WriteUtils;
   import com.netease.protobuf.WritingBuffer;
   import flash.errors.IOError;
   import flash.utils.IDataInput;
   import flash.utils.IExternalizable;
   
   public final class TitanShowMsg extends Message implements IExternalizable
   {
      
      private var templateId$field:int;
      
      private var hasField$0:uint = 0;
      
      private var starLevel$field:int;
      
      private var reduceResi$field:int;
      
      private var fireResi$field:int;
      
      private var waterResi$field:int;
      
      private var electResi$field:int;
      
      private var windResi$field:int;
      
      private var darkResi$field:int;
      
      private var lightResi$field:int;
      
      public function TitanShowMsg()
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
      
      public function removeStarLevel() : void
      {
         hasField$0 &= 4294967293;
         starLevel$field = new int();
      }
      
      public function get hasStarLevel() : Boolean
      {
         return (hasField$0 & 2) != 0;
      }
      
      public function set starLevel(param1:int) : void
      {
         hasField$0 |= 2;
         starLevel$field = param1;
      }
      
      public function get starLevel() : int
      {
         return starLevel$field;
      }
      
      public function removeReduceResi() : void
      {
         hasField$0 &= 4294967291;
         reduceResi$field = new int();
      }
      
      public function get hasReduceResi() : Boolean
      {
         return (hasField$0 & 4) != 0;
      }
      
      public function set reduceResi(param1:int) : void
      {
         hasField$0 |= 4;
         reduceResi$field = param1;
      }
      
      public function get reduceResi() : int
      {
         return reduceResi$field;
      }
      
      public function removeFireResi() : void
      {
         hasField$0 &= 4294967287;
         fireResi$field = new int();
      }
      
      public function get hasFireResi() : Boolean
      {
         return (hasField$0 & 8) != 0;
      }
      
      public function set fireResi(param1:int) : void
      {
         hasField$0 |= 8;
         fireResi$field = param1;
      }
      
      public function get fireResi() : int
      {
         return fireResi$field;
      }
      
      public function removeWaterResi() : void
      {
         hasField$0 &= 4294967279;
         waterResi$field = new int();
      }
      
      public function get hasWaterResi() : Boolean
      {
         return (hasField$0 & 0x10) != 0;
      }
      
      public function set waterResi(param1:int) : void
      {
         hasField$0 |= 16;
         waterResi$field = param1;
      }
      
      public function get waterResi() : int
      {
         return waterResi$field;
      }
      
      public function removeElectResi() : void
      {
         hasField$0 &= 4294967263;
         electResi$field = new int();
      }
      
      public function get hasElectResi() : Boolean
      {
         return (hasField$0 & 0x20) != 0;
      }
      
      public function set electResi(param1:int) : void
      {
         hasField$0 |= 32;
         electResi$field = param1;
      }
      
      public function get electResi() : int
      {
         return electResi$field;
      }
      
      public function removeWindResi() : void
      {
         hasField$0 &= 4294967231;
         windResi$field = new int();
      }
      
      public function get hasWindResi() : Boolean
      {
         return (hasField$0 & 0x40) != 0;
      }
      
      public function set windResi(param1:int) : void
      {
         hasField$0 |= 64;
         windResi$field = param1;
      }
      
      public function get windResi() : int
      {
         return windResi$field;
      }
      
      public function removeDarkResi() : void
      {
         hasField$0 &= 4294967167;
         darkResi$field = new int();
      }
      
      public function get hasDarkResi() : Boolean
      {
         return (hasField$0 & 0x80) != 0;
      }
      
      public function set darkResi(param1:int) : void
      {
         hasField$0 |= 128;
         darkResi$field = param1;
      }
      
      public function get darkResi() : int
      {
         return darkResi$field;
      }
      
      public function removeLightResi() : void
      {
         hasField$0 &= 4294967039;
         lightResi$field = new int();
      }
      
      public function get hasLightResi() : Boolean
      {
         return (hasField$0 & 0x0100) != 0;
      }
      
      public function set lightResi(param1:int) : void
      {
         hasField$0 |= 256;
         lightResi$field = param1;
      }
      
      public function get lightResi() : int
      {
         return lightResi$field;
      }
      
      final override public function writeToBuffer(param1:WritingBuffer) : void
      {
         if(hasTemplateId)
         {
            WriteUtils.writeTag(param1,0,1);
            WriteUtils.write$TYPE_INT32(param1,templateId$field);
         }
         if(hasStarLevel)
         {
            WriteUtils.writeTag(param1,0,2);
            WriteUtils.write$TYPE_INT32(param1,starLevel$field);
         }
         if(hasReduceResi)
         {
            WriteUtils.writeTag(param1,0,3);
            WriteUtils.write$TYPE_INT32(param1,reduceResi$field);
         }
         if(hasFireResi)
         {
            WriteUtils.writeTag(param1,0,4);
            WriteUtils.write$TYPE_INT32(param1,fireResi$field);
         }
         if(hasWaterResi)
         {
            WriteUtils.writeTag(param1,0,5);
            WriteUtils.write$TYPE_INT32(param1,waterResi$field);
         }
         if(hasElectResi)
         {
            WriteUtils.writeTag(param1,0,6);
            WriteUtils.write$TYPE_INT32(param1,electResi$field);
         }
         if(hasWindResi)
         {
            WriteUtils.writeTag(param1,0,7);
            WriteUtils.write$TYPE_INT32(param1,windResi$field);
         }
         if(hasDarkResi)
         {
            WriteUtils.writeTag(param1,0,8);
            WriteUtils.write$TYPE_INT32(param1,darkResi$field);
         }
         if(hasLightResi)
         {
            WriteUtils.writeTag(param1,0,9);
            WriteUtils.write$TYPE_INT32(param1,lightResi$field);
         }
      }
      
      final override public function readFromSlice(param1:IDataInput, param2:uint) : void
      {
         var _loc10_:* = 0;
         var _loc6_:uint = 0;
         var _loc5_:uint = 0;
         var _loc4_:uint = 0;
         var _loc8_:uint = 0;
         var _loc11_:uint = 0;
         var _loc9_:uint = 0;
         var _loc12_:uint = 0;
         var _loc3_:uint = 0;
         var _loc7_:uint = 0;
         while(param1.bytesAvailable > param2)
         {
            switch(((_loc10_ = ReadUtils.read$TYPE_UINT32(param1)) >>> 3) - 1)
            {
               case 0:
                  if(_loc6_ != 0)
                  {
                     throw new IOError("Bad data format: TitanShowMsg.templateId cannot be set twice.");
                  }
                  _loc6_++;
                  templateId = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 1:
                  if(_loc5_ != 0)
                  {
                     throw new IOError("Bad data format: TitanShowMsg.starLevel cannot be set twice.");
                  }
                  _loc5_++;
                  starLevel = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 2:
                  if(_loc4_ != 0)
                  {
                     throw new IOError("Bad data format: TitanShowMsg.reduceResi cannot be set twice.");
                  }
                  _loc4_++;
                  reduceResi = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 3:
                  if(_loc8_ != 0)
                  {
                     throw new IOError("Bad data format: TitanShowMsg.fireResi cannot be set twice.");
                  }
                  _loc8_++;
                  fireResi = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 4:
                  if(_loc11_ != 0)
                  {
                     throw new IOError("Bad data format: TitanShowMsg.waterResi cannot be set twice.");
                  }
                  _loc11_++;
                  waterResi = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 5:
                  if(_loc9_ != 0)
                  {
                     throw new IOError("Bad data format: TitanShowMsg.electResi cannot be set twice.");
                  }
                  _loc9_++;
                  electResi = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 6:
                  if(_loc12_ != 0)
                  {
                     throw new IOError("Bad data format: TitanShowMsg.windResi cannot be set twice.");
                  }
                  _loc12_++;
                  windResi = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 7:
                  if(_loc3_ != 0)
                  {
                     throw new IOError("Bad data format: TitanShowMsg.darkResi cannot be set twice.");
                  }
                  _loc3_++;
                  darkResi = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 8:
                  if(_loc7_ != 0)
                  {
                     throw new IOError("Bad data format: TitanShowMsg.lightResi cannot be set twice.");
                  }
                  _loc7_++;
                  lightResi = ReadUtils.read$TYPE_INT32(param1);
                  break;
               default:
                  ReadUtils.skip(param1,_loc10_ & 7);
            }
         }
      }
   }
}

