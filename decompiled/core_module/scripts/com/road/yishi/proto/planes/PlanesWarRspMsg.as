package com.road.yishi.proto.planes
{
   import com.netease.protobuf.Message;
   import com.netease.protobuf.ReadUtils;
   import com.netease.protobuf.WriteUtils;
   import com.netease.protobuf.WritingBuffer;
   import flash.errors.IOError;
   import flash.utils.IDataInput;
   import flash.utils.IExternalizable;
   
   public final class PlanesWarRspMsg extends Message implements IExternalizable
   {
      
      public var op:int;
      
      private var energy_left$field:int;
      
      private var hasField$0:uint = 0;
      
      private var buy_energy_count$field:int;
      
      private var revive_left$field:int;
      
      private var planes_temp_id$field:int;
      
      private var layer_temp_id$field:int;
      
      private var layer_id$field:int;
      
      private var dead$field:Boolean;
      
      private var pos_x$field:int;
      
      private var pos_y$field:int;
      
      private var gold_key_count$field:int;
      
      private var silver_key_count$field:int;
      
      private var event_info$field:PlanesWarEventMsg;
      
      public function PlanesWarRspMsg()
      {
         super();
      }
      
      public function removeEnergyLeft() : void
      {
         hasField$0 &= 4294967294;
         energy_left$field = new int();
      }
      
      public function get hasEnergyLeft() : Boolean
      {
         return (hasField$0 & 1) != 0;
      }
      
      public function set energyLeft(param1:int) : void
      {
         hasField$0 |= 1;
         energy_left$field = param1;
      }
      
      public function get energyLeft() : int
      {
         return energy_left$field;
      }
      
      public function removeBuyEnergyCount() : void
      {
         hasField$0 &= 4294967293;
         buy_energy_count$field = new int();
      }
      
      public function get hasBuyEnergyCount() : Boolean
      {
         return (hasField$0 & 2) != 0;
      }
      
      public function set buyEnergyCount(param1:int) : void
      {
         hasField$0 |= 2;
         buy_energy_count$field = param1;
      }
      
      public function get buyEnergyCount() : int
      {
         return buy_energy_count$field;
      }
      
      public function removeReviveLeft() : void
      {
         hasField$0 &= 4294967291;
         revive_left$field = new int();
      }
      
      public function get hasReviveLeft() : Boolean
      {
         return (hasField$0 & 4) != 0;
      }
      
      public function set reviveLeft(param1:int) : void
      {
         hasField$0 |= 4;
         revive_left$field = param1;
      }
      
      public function get reviveLeft() : int
      {
         return revive_left$field;
      }
      
      public function removePlanesTempId() : void
      {
         hasField$0 &= 4294967287;
         planes_temp_id$field = new int();
      }
      
      public function get hasPlanesTempId() : Boolean
      {
         return (hasField$0 & 8) != 0;
      }
      
      public function set planesTempId(param1:int) : void
      {
         hasField$0 |= 8;
         planes_temp_id$field = param1;
      }
      
      public function get planesTempId() : int
      {
         return planes_temp_id$field;
      }
      
      public function removeLayerTempId() : void
      {
         hasField$0 &= 4294967279;
         layer_temp_id$field = new int();
      }
      
      public function get hasLayerTempId() : Boolean
      {
         return (hasField$0 & 0x10) != 0;
      }
      
      public function set layerTempId(param1:int) : void
      {
         hasField$0 |= 16;
         layer_temp_id$field = param1;
      }
      
      public function get layerTempId() : int
      {
         return layer_temp_id$field;
      }
      
      public function removeLayerId() : void
      {
         hasField$0 &= 4294967263;
         layer_id$field = new int();
      }
      
      public function get hasLayerId() : Boolean
      {
         return (hasField$0 & 0x20) != 0;
      }
      
      public function set layerId(param1:int) : void
      {
         hasField$0 |= 32;
         layer_id$field = param1;
      }
      
      public function get layerId() : int
      {
         return layer_id$field;
      }
      
      public function removeDead() : void
      {
         hasField$0 &= 4294967231;
         dead$field = new Boolean();
      }
      
      public function get hasDead() : Boolean
      {
         return (hasField$0 & 0x40) != 0;
      }
      
      public function set dead(param1:Boolean) : void
      {
         hasField$0 |= 64;
         dead$field = param1;
      }
      
      public function get dead() : Boolean
      {
         return dead$field;
      }
      
      public function removePosX() : void
      {
         hasField$0 &= 4294967167;
         pos_x$field = new int();
      }
      
      public function get hasPosX() : Boolean
      {
         return (hasField$0 & 0x80) != 0;
      }
      
      public function set posX(param1:int) : void
      {
         hasField$0 |= 128;
         pos_x$field = param1;
      }
      
      public function get posX() : int
      {
         return pos_x$field;
      }
      
      public function removePosY() : void
      {
         hasField$0 &= 4294967039;
         pos_y$field = new int();
      }
      
      public function get hasPosY() : Boolean
      {
         return (hasField$0 & 0x0100) != 0;
      }
      
      public function set posY(param1:int) : void
      {
         hasField$0 |= 256;
         pos_y$field = param1;
      }
      
      public function get posY() : int
      {
         return pos_y$field;
      }
      
      public function removeGoldKeyCount() : void
      {
         hasField$0 &= 4294966783;
         gold_key_count$field = new int();
      }
      
      public function get hasGoldKeyCount() : Boolean
      {
         return (hasField$0 & 0x0200) != 0;
      }
      
      public function set goldKeyCount(param1:int) : void
      {
         hasField$0 |= 512;
         gold_key_count$field = param1;
      }
      
      public function get goldKeyCount() : int
      {
         return gold_key_count$field;
      }
      
      public function removeSilverKeyCount() : void
      {
         hasField$0 &= 4294966271;
         silver_key_count$field = new int();
      }
      
      public function get hasSilverKeyCount() : Boolean
      {
         return (hasField$0 & 0x0400) != 0;
      }
      
      public function set silverKeyCount(param1:int) : void
      {
         hasField$0 |= 1024;
         silver_key_count$field = param1;
      }
      
      public function get silverKeyCount() : int
      {
         return silver_key_count$field;
      }
      
      public function removeEventInfo() : void
      {
         event_info$field = null;
      }
      
      public function get hasEventInfo() : Boolean
      {
         return event_info$field != null;
      }
      
      public function set eventInfo(param1:PlanesWarEventMsg) : void
      {
         event_info$field = param1;
      }
      
      public function get eventInfo() : PlanesWarEventMsg
      {
         return event_info$field;
      }
      
      final override public function writeToBuffer(param1:WritingBuffer) : void
      {
         WriteUtils.writeTag(param1,0,1);
         WriteUtils.write$TYPE_INT32(param1,op);
         if(hasEnergyLeft)
         {
            WriteUtils.writeTag(param1,0,2);
            WriteUtils.write$TYPE_INT32(param1,energy_left$field);
         }
         if(hasBuyEnergyCount)
         {
            WriteUtils.writeTag(param1,0,3);
            WriteUtils.write$TYPE_INT32(param1,buy_energy_count$field);
         }
         if(hasReviveLeft)
         {
            WriteUtils.writeTag(param1,0,4);
            WriteUtils.write$TYPE_INT32(param1,revive_left$field);
         }
         if(hasPlanesTempId)
         {
            WriteUtils.writeTag(param1,0,5);
            WriteUtils.write$TYPE_INT32(param1,planes_temp_id$field);
         }
         if(hasLayerTempId)
         {
            WriteUtils.writeTag(param1,0,6);
            WriteUtils.write$TYPE_INT32(param1,layer_temp_id$field);
         }
         if(hasLayerId)
         {
            WriteUtils.writeTag(param1,0,7);
            WriteUtils.write$TYPE_INT32(param1,layer_id$field);
         }
         if(hasDead)
         {
            WriteUtils.writeTag(param1,0,8);
            WriteUtils.write$TYPE_BOOL(param1,dead$field);
         }
         if(hasPosX)
         {
            WriteUtils.writeTag(param1,0,9);
            WriteUtils.write$TYPE_INT32(param1,pos_x$field);
         }
         if(hasPosY)
         {
            WriteUtils.writeTag(param1,0,10);
            WriteUtils.write$TYPE_INT32(param1,pos_y$field);
         }
         if(hasGoldKeyCount)
         {
            WriteUtils.writeTag(param1,0,11);
            WriteUtils.write$TYPE_INT32(param1,gold_key_count$field);
         }
         if(hasSilverKeyCount)
         {
            WriteUtils.writeTag(param1,0,12);
            WriteUtils.write$TYPE_INT32(param1,silver_key_count$field);
         }
         if(hasEventInfo)
         {
            WriteUtils.writeTag(param1,2,13);
            WriteUtils.write$TYPE_MESSAGE(param1,event_info$field);
         }
      }
      
      final override public function readFromSlice(param1:IDataInput, param2:uint) : void
      {
         var _loc12_:* = 0;
         var _loc15_:uint = 0;
         var _loc4_:uint = 0;
         var _loc6_:uint = 0;
         var _loc14_:uint = 0;
         var _loc8_:uint = 0;
         var _loc16_:uint = 0;
         var _loc11_:uint = 0;
         var _loc5_:uint = 0;
         var _loc7_:uint = 0;
         var _loc3_:uint = 0;
         var _loc9_:uint = 0;
         var _loc10_:uint = 0;
         var _loc13_:uint = 0;
         while(param1.bytesAvailable > param2)
         {
            switch(((_loc12_ = ReadUtils.read$TYPE_UINT32(param1)) >>> 3) - 1)
            {
               case 0:
                  if(_loc15_ != 0)
                  {
                     throw new IOError("Bad data format: PlanesWarRspMsg.op cannot be set twice.");
                  }
                  _loc15_++;
                  op = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 1:
                  if(_loc4_ != 0)
                  {
                     throw new IOError("Bad data format: PlanesWarRspMsg.energyLeft cannot be set twice.");
                  }
                  _loc4_++;
                  energyLeft = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 2:
                  if(_loc6_ != 0)
                  {
                     throw new IOError("Bad data format: PlanesWarRspMsg.buyEnergyCount cannot be set twice.");
                  }
                  _loc6_++;
                  buyEnergyCount = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 3:
                  if(_loc14_ != 0)
                  {
                     throw new IOError("Bad data format: PlanesWarRspMsg.reviveLeft cannot be set twice.");
                  }
                  _loc14_++;
                  reviveLeft = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 4:
                  if(_loc8_ != 0)
                  {
                     throw new IOError("Bad data format: PlanesWarRspMsg.planesTempId cannot be set twice.");
                  }
                  _loc8_++;
                  planesTempId = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 5:
                  if(_loc16_ != 0)
                  {
                     throw new IOError("Bad data format: PlanesWarRspMsg.layerTempId cannot be set twice.");
                  }
                  _loc16_++;
                  layerTempId = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 6:
                  if(_loc11_ != 0)
                  {
                     throw new IOError("Bad data format: PlanesWarRspMsg.layerId cannot be set twice.");
                  }
                  _loc11_++;
                  layerId = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 7:
                  if(_loc5_ != 0)
                  {
                     throw new IOError("Bad data format: PlanesWarRspMsg.dead cannot be set twice.");
                  }
                  _loc5_++;
                  dead = ReadUtils.read$TYPE_BOOL(param1);
                  break;
               case 8:
                  if(_loc7_ != 0)
                  {
                     throw new IOError("Bad data format: PlanesWarRspMsg.posX cannot be set twice.");
                  }
                  _loc7_++;
                  posX = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 9:
                  if(_loc3_ != 0)
                  {
                     throw new IOError("Bad data format: PlanesWarRspMsg.posY cannot be set twice.");
                  }
                  _loc3_++;
                  posY = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 10:
                  if(_loc9_ != 0)
                  {
                     throw new IOError("Bad data format: PlanesWarRspMsg.goldKeyCount cannot be set twice.");
                  }
                  _loc9_++;
                  goldKeyCount = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 11:
                  if(_loc10_ != 0)
                  {
                     throw new IOError("Bad data format: PlanesWarRspMsg.silverKeyCount cannot be set twice.");
                  }
                  _loc10_++;
                  silverKeyCount = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 12:
                  if(_loc13_ != 0)
                  {
                     throw new IOError("Bad data format: PlanesWarRspMsg.eventInfo cannot be set twice.");
                  }
                  _loc13_++;
                  eventInfo = new PlanesWarEventMsg();
                  ReadUtils.read$TYPE_MESSAGE(param1,eventInfo);
                  break;
               default:
                  ReadUtils.skip(param1,_loc12_ & 7);
            }
         }
         if(_loc15_ != 1)
         {
            throw new IOError("Bad data format: PlanesWarRspMsg.op must be set.");
         }
      }
   }
}

