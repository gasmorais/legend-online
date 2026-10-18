package com.road.yishi.proto.redemptionroad
{
   import com.netease.protobuf.*;
   import flash.errors.IOError;
   import flash.utils.IDataInput;
   import flash.utils.IExternalizable;
   
   public final class RedemptionRoadUserMsg extends Message implements IExternalizable
   {
      
      private var difficulty$field:int;
      
      private var hasField$0:uint = 0;
      
      private var layer$field:int;
      
      [ArrayElementType("int")]
      public var path:Array = [];
      
      private var cdTime$field:String;
      
      public function RedemptionRoadUserMsg()
      {
         super();
      }
      
      public function removeDifficulty() : void
      {
         hasField$0 &= 4294967294;
         difficulty$field = new int();
      }
      
      public function get hasDifficulty() : Boolean
      {
         return (hasField$0 & 1) != 0;
      }
      
      public function set difficulty(param1:int) : void
      {
         hasField$0 |= 1;
         difficulty$field = param1;
      }
      
      public function get difficulty() : int
      {
         return difficulty$field;
      }
      
      public function removeLayer() : void
      {
         hasField$0 &= 4294967293;
         layer$field = new int();
      }
      
      public function get hasLayer() : Boolean
      {
         return (hasField$0 & 2) != 0;
      }
      
      public function set layer(param1:int) : void
      {
         hasField$0 |= 2;
         layer$field = param1;
      }
      
      public function get layer() : int
      {
         return layer$field;
      }
      
      public function removeCdTime() : void
      {
         cdTime$field = null;
      }
      
      public function get hasCdTime() : Boolean
      {
         return cdTime$field != null;
      }
      
      public function set cdTime(param1:String) : void
      {
         cdTime$field = param1;
      }
      
      public function get cdTime() : String
      {
         return cdTime$field;
      }
      
      final override public function writeToBuffer(param1:WritingBuffer) : void
      {
         var _loc2_:* = 0;
         if(hasDifficulty)
         {
            WriteUtils.writeTag(param1,0,1);
            WriteUtils.write$TYPE_INT32(param1,difficulty$field);
         }
         if(hasLayer)
         {
            WriteUtils.writeTag(param1,0,2);
            WriteUtils.write$TYPE_INT32(param1,layer$field);
         }
         _loc2_ = 0;
         while(_loc2_ < path.length)
         {
            WriteUtils.writeTag(param1,0,3);
            WriteUtils.write$TYPE_INT32(param1,path[_loc2_]);
            _loc2_++;
         }
         if(hasCdTime)
         {
            WriteUtils.writeTag(param1,2,4);
            WriteUtils.write$TYPE_STRING(param1,cdTime$field);
         }
      }
      
      final override public function readFromSlice(param1:IDataInput, param2:uint) : void
      {
         var _loc5_:* = 0;
         var _loc6_:uint = 0;
         var _loc3_:uint = 0;
         var _loc4_:uint = 0;
         while(param1.bytesAvailable > param2)
         {
            switch(((_loc5_ = ReadUtils.read$TYPE_UINT32(param1)) >>> 3) - 1)
            {
               case 0:
                  if(_loc6_ != 0)
                  {
                     throw new IOError("Bad data format: RedemptionRoadUserMsg.difficulty cannot be set twice.");
                  }
                  _loc6_++;
                  difficulty = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 1:
                  if(_loc3_ != 0)
                  {
                     throw new IOError("Bad data format: RedemptionRoadUserMsg.layer cannot be set twice.");
                  }
                  _loc3_++;
                  layer = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 2:
                  if((_loc5_ & 7) == 2)
                  {
                     ReadUtils.readPackedRepeated(param1,ReadUtils.read$TYPE_INT32,path);
                  }
                  else
                  {
                     path.push(ReadUtils.read$TYPE_INT32(param1));
                  }
                  break;
               case 3:
                  if(_loc4_ != 0)
                  {
                     throw new IOError("Bad data format: RedemptionRoadUserMsg.cdTime cannot be set twice.");
                  }
                  _loc4_++;
                  cdTime = ReadUtils.read$TYPE_STRING(param1);
                  break;
               default:
                  ReadUtils.skip(param1,_loc5_ & 7);
            }
         }
      }
   }
}

