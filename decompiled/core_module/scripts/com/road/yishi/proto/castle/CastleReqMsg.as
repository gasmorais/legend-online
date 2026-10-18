package com.road.yishi.proto.castle
{
   import com.netease.protobuf.Message;
   import com.netease.protobuf.ReadUtils;
   import com.netease.protobuf.WriteUtils;
   import com.netease.protobuf.WritingBuffer;
   import flash.errors.IOError;
   import flash.utils.IDataInput;
   import flash.utils.IExternalizable;
   
   public final class CastleReqMsg extends Message implements IExternalizable
   {
      
      private var mag_id$field:int;
      
      private var hasField$0:uint = 0;
      
      private var pos_x$field:int;
      
      private var pos_y$field:int;
      
      private var left_time$field:int;
      
      private var left_energy$field:int;
      
      private var pay_type$field:int;
      
      public function CastleReqMsg()
      {
         super();
      }
      
      public function removeMagId() : void
      {
         hasField$0 &= 4294967294;
         mag_id$field = new int();
      }
      
      public function get hasMagId() : Boolean
      {
         return (hasField$0 & 1) != 0;
      }
      
      public function set magId(param1:int) : void
      {
         hasField$0 |= 1;
         mag_id$field = param1;
      }
      
      public function get magId() : int
      {
         return mag_id$field;
      }
      
      public function removePosX() : void
      {
         hasField$0 &= 4294967293;
         pos_x$field = new int();
      }
      
      public function get hasPosX() : Boolean
      {
         return (hasField$0 & 2) != 0;
      }
      
      public function set posX(param1:int) : void
      {
         hasField$0 |= 2;
         pos_x$field = param1;
      }
      
      public function get posX() : int
      {
         return pos_x$field;
      }
      
      public function removePosY() : void
      {
         hasField$0 &= 4294967291;
         pos_y$field = new int();
      }
      
      public function get hasPosY() : Boolean
      {
         return (hasField$0 & 4) != 0;
      }
      
      public function set posY(param1:int) : void
      {
         hasField$0 |= 4;
         pos_y$field = param1;
      }
      
      public function get posY() : int
      {
         return pos_y$field;
      }
      
      public function removeLeftTime() : void
      {
         hasField$0 &= 4294967287;
         left_time$field = new int();
      }
      
      public function get hasLeftTime() : Boolean
      {
         return (hasField$0 & 8) != 0;
      }
      
      public function set leftTime(param1:int) : void
      {
         hasField$0 |= 8;
         left_time$field = param1;
      }
      
      public function get leftTime() : int
      {
         return left_time$field;
      }
      
      public function removeLeftEnergy() : void
      {
         hasField$0 &= 4294967279;
         left_energy$field = new int();
      }
      
      public function get hasLeftEnergy() : Boolean
      {
         return (hasField$0 & 0x10) != 0;
      }
      
      public function set leftEnergy(param1:int) : void
      {
         hasField$0 |= 16;
         left_energy$field = param1;
      }
      
      public function get leftEnergy() : int
      {
         return left_energy$field;
      }
      
      public function removePayType() : void
      {
         hasField$0 &= 4294967263;
         pay_type$field = new int();
      }
      
      public function get hasPayType() : Boolean
      {
         return (hasField$0 & 0x20) != 0;
      }
      
      public function set payType(param1:int) : void
      {
         hasField$0 |= 32;
         pay_type$field = param1;
      }
      
      public function get payType() : int
      {
         return pay_type$field;
      }
      
      final override public function writeToBuffer(param1:WritingBuffer) : void
      {
         if(hasMagId)
         {
            WriteUtils.writeTag(param1,0,1);
            WriteUtils.write$TYPE_INT32(param1,mag_id$field);
         }
         if(hasPosX)
         {
            WriteUtils.writeTag(param1,0,2);
            WriteUtils.write$TYPE_INT32(param1,pos_x$field);
         }
         if(hasPosY)
         {
            WriteUtils.writeTag(param1,0,3);
            WriteUtils.write$TYPE_INT32(param1,pos_y$field);
         }
         if(hasLeftTime)
         {
            WriteUtils.writeTag(param1,0,4);
            WriteUtils.write$TYPE_INT32(param1,left_time$field);
         }
         if(hasLeftEnergy)
         {
            WriteUtils.writeTag(param1,0,5);
            WriteUtils.write$TYPE_INT32(param1,left_energy$field);
         }
         if(hasPayType)
         {
            WriteUtils.writeTag(param1,0,6);
            WriteUtils.write$TYPE_INT32(param1,pay_type$field);
         }
      }
      
      final override public function readFromSlice(param1:IDataInput, param2:uint) : void
      {
         var _loc6_:* = 0;
         var _loc9_:uint = 0;
         var _loc7_:uint = 0;
         var _loc3_:uint = 0;
         var _loc4_:uint = 0;
         var _loc5_:uint = 0;
         var _loc8_:uint = 0;
         while(param1.bytesAvailable > param2)
         {
            switch(((_loc6_ = ReadUtils.read$TYPE_UINT32(param1)) >>> 3) - 1)
            {
               case 0:
                  if(_loc9_ != 0)
                  {
                     throw new IOError("Bad data format: CastleReqMsg.magId cannot be set twice.");
                  }
                  _loc9_++;
                  magId = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 1:
                  if(_loc7_ != 0)
                  {
                     throw new IOError("Bad data format: CastleReqMsg.posX cannot be set twice.");
                  }
                  _loc7_++;
                  posX = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 2:
                  if(_loc3_ != 0)
                  {
                     throw new IOError("Bad data format: CastleReqMsg.posY cannot be set twice.");
                  }
                  _loc3_++;
                  posY = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 3:
                  if(_loc4_ != 0)
                  {
                     throw new IOError("Bad data format: CastleReqMsg.leftTime cannot be set twice.");
                  }
                  _loc4_++;
                  leftTime = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 4:
                  if(_loc5_ != 0)
                  {
                     throw new IOError("Bad data format: CastleReqMsg.leftEnergy cannot be set twice.");
                  }
                  _loc5_++;
                  leftEnergy = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 5:
                  if(_loc8_ != 0)
                  {
                     throw new IOError("Bad data format: CastleReqMsg.payType cannot be set twice.");
                  }
                  _loc8_++;
                  payType = ReadUtils.read$TYPE_INT32(param1);
                  break;
               default:
                  ReadUtils.skip(param1,_loc6_ & 7);
            }
         }
      }
   }
}

