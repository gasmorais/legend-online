package com.road.yishi.proto.planes
{
   import com.netease.protobuf.*;
   import flash.errors.IOError;
   import flash.utils.IDataInput;
   import flash.utils.IExternalizable;
   
   public final class PlanesLayerInfoMsg extends Message implements IExternalizable
   {
      
      private var layer_id$field:int;
      
      private var hasField$0:uint = 0;
      
      private var layer_temp_id$field:int;
      
      private var occupy_userid$field:int;
      
      private var isActivated$field:Boolean;
      
      private var icon_state$field:int;
      
      [ArrayElementType("int")]
      public var buyList:Array = [];
      
      public function PlanesLayerInfoMsg()
      {
         super();
      }
      
      public function removeLayerId() : void
      {
         hasField$0 &= 4294967294;
         layer_id$field = new int();
      }
      
      public function get hasLayerId() : Boolean
      {
         return (hasField$0 & 1) != 0;
      }
      
      public function set layerId(param1:int) : void
      {
         hasField$0 |= 1;
         layer_id$field = param1;
      }
      
      public function get layerId() : int
      {
         return layer_id$field;
      }
      
      public function removeLayerTempId() : void
      {
         hasField$0 &= 4294967293;
         layer_temp_id$field = new int();
      }
      
      public function get hasLayerTempId() : Boolean
      {
         return (hasField$0 & 2) != 0;
      }
      
      public function set layerTempId(param1:int) : void
      {
         hasField$0 |= 2;
         layer_temp_id$field = param1;
      }
      
      public function get layerTempId() : int
      {
         return layer_temp_id$field;
      }
      
      public function removeOccupyUserid() : void
      {
         hasField$0 &= 4294967291;
         occupy_userid$field = new int();
      }
      
      public function get hasOccupyUserid() : Boolean
      {
         return (hasField$0 & 4) != 0;
      }
      
      public function set occupyUserid(param1:int) : void
      {
         hasField$0 |= 4;
         occupy_userid$field = param1;
      }
      
      public function get occupyUserid() : int
      {
         return occupy_userid$field;
      }
      
      public function removeIsActivated() : void
      {
         hasField$0 &= 4294967287;
         isActivated$field = new Boolean();
      }
      
      public function get hasIsActivated() : Boolean
      {
         return (hasField$0 & 8) != 0;
      }
      
      public function set isActivated(param1:Boolean) : void
      {
         hasField$0 |= 8;
         isActivated$field = param1;
      }
      
      public function get isActivated() : Boolean
      {
         return isActivated$field;
      }
      
      public function removeIconState() : void
      {
         hasField$0 &= 4294967279;
         icon_state$field = new int();
      }
      
      public function get hasIconState() : Boolean
      {
         return (hasField$0 & 0x10) != 0;
      }
      
      public function set iconState(param1:int) : void
      {
         hasField$0 |= 16;
         icon_state$field = param1;
      }
      
      public function get iconState() : int
      {
         return icon_state$field;
      }
      
      final override public function writeToBuffer(param1:WritingBuffer) : void
      {
         var _loc2_:* = 0;
         if(hasLayerId)
         {
            WriteUtils.writeTag(param1,0,1);
            WriteUtils.write$TYPE_INT32(param1,layer_id$field);
         }
         if(hasLayerTempId)
         {
            WriteUtils.writeTag(param1,0,2);
            WriteUtils.write$TYPE_INT32(param1,layer_temp_id$field);
         }
         if(hasOccupyUserid)
         {
            WriteUtils.writeTag(param1,0,3);
            WriteUtils.write$TYPE_INT32(param1,occupy_userid$field);
         }
         if(hasIsActivated)
         {
            WriteUtils.writeTag(param1,0,4);
            WriteUtils.write$TYPE_BOOL(param1,isActivated$field);
         }
         if(hasIconState)
         {
            WriteUtils.writeTag(param1,0,5);
            WriteUtils.write$TYPE_INT32(param1,icon_state$field);
         }
         _loc2_ = 0;
         while(_loc2_ < buyList.length)
         {
            WriteUtils.writeTag(param1,0,6);
            WriteUtils.write$TYPE_INT32(param1,buyList[_loc2_]);
            _loc2_++;
         }
      }
      
      final override public function readFromSlice(param1:IDataInput, param2:uint) : void
      {
         var _loc7_:* = 0;
         var _loc4_:uint = 0;
         var _loc8_:uint = 0;
         var _loc6_:uint = 0;
         var _loc5_:uint = 0;
         var _loc3_:uint = 0;
         while(param1.bytesAvailable > param2)
         {
            switch(((_loc7_ = ReadUtils.read$TYPE_UINT32(param1)) >>> 3) - 1)
            {
               case 0:
                  if(_loc4_ != 0)
                  {
                     throw new IOError("Bad data format: PlanesLayerInfoMsg.layerId cannot be set twice.");
                  }
                  _loc4_++;
                  layerId = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 1:
                  if(_loc8_ != 0)
                  {
                     throw new IOError("Bad data format: PlanesLayerInfoMsg.layerTempId cannot be set twice.");
                  }
                  _loc8_++;
                  layerTempId = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 2:
                  if(_loc6_ != 0)
                  {
                     throw new IOError("Bad data format: PlanesLayerInfoMsg.occupyUserid cannot be set twice.");
                  }
                  _loc6_++;
                  occupyUserid = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 3:
                  if(_loc5_ != 0)
                  {
                     throw new IOError("Bad data format: PlanesLayerInfoMsg.isActivated cannot be set twice.");
                  }
                  _loc5_++;
                  isActivated = ReadUtils.read$TYPE_BOOL(param1);
                  break;
               case 4:
                  if(_loc3_ != 0)
                  {
                     throw new IOError("Bad data format: PlanesLayerInfoMsg.iconState cannot be set twice.");
                  }
                  _loc3_++;
                  iconState = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 5:
                  if((_loc7_ & 7) == 2)
                  {
                     ReadUtils.readPackedRepeated(param1,ReadUtils.read$TYPE_INT32,buyList);
                  }
                  else
                  {
                     buyList.push(ReadUtils.read$TYPE_INT32(param1));
                  }
                  break;
               default:
                  ReadUtils.skip(param1,_loc7_ & 7);
            }
         }
      }
   }
}

