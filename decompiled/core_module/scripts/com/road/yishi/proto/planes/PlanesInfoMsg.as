package com.road.yishi.proto.planes
{
   import com.netease.protobuf.*;
   import flash.errors.IOError;
   import flash.utils.IDataInput;
   import flash.utils.IExternalizable;
   
   public final class PlanesInfoMsg extends Message implements IExternalizable
   {
      
      private var planes_id$field:int;
      
      private var hasField$0:uint = 0;
      
      private var planes_temp_id$field:int;
      
      private var planes_process$field:int;
      
      private var life_point$field:int;
      
      [ArrayElementType("com.road.yishi.proto.planes.PlanesLayerInfoMsg")]
      public var layerList:Array = [];
      
      private var life_reduce$field:int;
      
      public function PlanesInfoMsg()
      {
         super();
      }
      
      public function removePlanesId() : void
      {
         hasField$0 &= 4294967294;
         planes_id$field = new int();
      }
      
      public function get hasPlanesId() : Boolean
      {
         return (hasField$0 & 1) != 0;
      }
      
      public function set planesId(param1:int) : void
      {
         hasField$0 |= 1;
         planes_id$field = param1;
      }
      
      public function get planesId() : int
      {
         return planes_id$field;
      }
      
      public function removePlanesTempId() : void
      {
         hasField$0 &= 4294967293;
         planes_temp_id$field = new int();
      }
      
      public function get hasPlanesTempId() : Boolean
      {
         return (hasField$0 & 2) != 0;
      }
      
      public function set planesTempId(param1:int) : void
      {
         hasField$0 |= 2;
         planes_temp_id$field = param1;
      }
      
      public function get planesTempId() : int
      {
         return planes_temp_id$field;
      }
      
      public function removePlanesProcess() : void
      {
         hasField$0 &= 4294967291;
         planes_process$field = new int();
      }
      
      public function get hasPlanesProcess() : Boolean
      {
         return (hasField$0 & 4) != 0;
      }
      
      public function set planesProcess(param1:int) : void
      {
         hasField$0 |= 4;
         planes_process$field = param1;
      }
      
      public function get planesProcess() : int
      {
         return planes_process$field;
      }
      
      public function removeLifePoint() : void
      {
         hasField$0 &= 4294967287;
         life_point$field = new int();
      }
      
      public function get hasLifePoint() : Boolean
      {
         return (hasField$0 & 8) != 0;
      }
      
      public function set lifePoint(param1:int) : void
      {
         hasField$0 |= 8;
         life_point$field = param1;
      }
      
      public function get lifePoint() : int
      {
         return life_point$field;
      }
      
      public function removeLifeReduce() : void
      {
         hasField$0 &= 4294967279;
         life_reduce$field = new int();
      }
      
      public function get hasLifeReduce() : Boolean
      {
         return (hasField$0 & 0x10) != 0;
      }
      
      public function set lifeReduce(param1:int) : void
      {
         hasField$0 |= 16;
         life_reduce$field = param1;
      }
      
      public function get lifeReduce() : int
      {
         return life_reduce$field;
      }
      
      final override public function writeToBuffer(param1:WritingBuffer) : void
      {
         var _loc2_:* = 0;
         if(hasPlanesId)
         {
            WriteUtils.writeTag(param1,0,1);
            WriteUtils.write$TYPE_INT32(param1,planes_id$field);
         }
         if(hasPlanesTempId)
         {
            WriteUtils.writeTag(param1,0,2);
            WriteUtils.write$TYPE_INT32(param1,planes_temp_id$field);
         }
         if(hasPlanesProcess)
         {
            WriteUtils.writeTag(param1,0,3);
            WriteUtils.write$TYPE_INT32(param1,planes_process$field);
         }
         if(hasLifePoint)
         {
            WriteUtils.writeTag(param1,0,4);
            WriteUtils.write$TYPE_INT32(param1,life_point$field);
         }
         _loc2_ = 0;
         while(_loc2_ < layerList.length)
         {
            WriteUtils.writeTag(param1,2,5);
            WriteUtils.write$TYPE_MESSAGE(param1,layerList[_loc2_]);
            _loc2_++;
         }
         if(hasLifeReduce)
         {
            WriteUtils.writeTag(param1,0,6);
            WriteUtils.write$TYPE_INT32(param1,life_reduce$field);
         }
      }
      
      final override public function readFromSlice(param1:IDataInput, param2:uint) : void
      {
         var _loc7_:* = 0;
         var _loc9_:PlanesLayerInfoMsg = null;
         var _loc6_:uint = 0;
         var _loc4_:uint = 0;
         var _loc5_:uint = 0;
         var _loc8_:uint = 0;
         var _loc3_:uint = 0;
         while(param1.bytesAvailable > param2)
         {
            switch(((_loc7_ = ReadUtils.read$TYPE_UINT32(param1)) >>> 3) - 1)
            {
               case 0:
                  if(_loc6_ != 0)
                  {
                     throw new IOError("Bad data format: PlanesInfoMsg.planesId cannot be set twice.");
                  }
                  _loc6_++;
                  planesId = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 1:
                  if(_loc4_ != 0)
                  {
                     throw new IOError("Bad data format: PlanesInfoMsg.planesTempId cannot be set twice.");
                  }
                  _loc4_++;
                  planesTempId = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 2:
                  if(_loc5_ != 0)
                  {
                     throw new IOError("Bad data format: PlanesInfoMsg.planesProcess cannot be set twice.");
                  }
                  _loc5_++;
                  planesProcess = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 3:
                  if(_loc8_ != 0)
                  {
                     throw new IOError("Bad data format: PlanesInfoMsg.lifePoint cannot be set twice.");
                  }
                  _loc8_++;
                  lifePoint = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 4:
                  _loc9_ = new PlanesLayerInfoMsg();
                  ReadUtils.read$TYPE_MESSAGE(param1,_loc9_);
                  layerList.push(_loc9_);
                  break;
               case 5:
                  if(_loc3_ != 0)
                  {
                     throw new IOError("Bad data format: PlanesInfoMsg.lifeReduce cannot be set twice.");
                  }
                  _loc3_++;
                  lifeReduce = ReadUtils.read$TYPE_INT32(param1);
                  break;
               default:
                  ReadUtils.skip(param1,_loc7_ & 7);
            }
         }
      }
   }
}

