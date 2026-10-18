package com.road.yishi.proto.outercity
{
   import com.netease.protobuf.*;
   import flash.errors.IOError;
   import flash.utils.IDataInput;
   import flash.utils.IExternalizable;
   
   public final class OutercityReqMsg extends Message implements IExternalizable
   {
      
      private var map_id$field:int;
      
      private var hasField$0:uint = 0;
      
      private var position$field:String;
      
      private var files$field:String;
      
      [ArrayElementType("String")]
      public var pathArray:Array = [];
      
      private var type$field:int;
      
      private var attack_count$field:int;
      
      public function OutercityReqMsg()
      {
         super();
      }
      
      public function removeMapId() : void
      {
         hasField$0 &= 4294967294;
         map_id$field = new int();
      }
      
      public function get hasMapId() : Boolean
      {
         return (hasField$0 & 1) != 0;
      }
      
      public function set mapId(param1:int) : void
      {
         hasField$0 |= 1;
         map_id$field = param1;
      }
      
      public function get mapId() : int
      {
         return map_id$field;
      }
      
      public function removePosition() : void
      {
         position$field = null;
      }
      
      public function get hasPosition() : Boolean
      {
         return position$field != null;
      }
      
      public function set position(param1:String) : void
      {
         position$field = param1;
      }
      
      public function get position() : String
      {
         return position$field;
      }
      
      public function removeFiles() : void
      {
         files$field = null;
      }
      
      public function get hasFiles() : Boolean
      {
         return files$field != null;
      }
      
      public function set files(param1:String) : void
      {
         files$field = param1;
      }
      
      public function get files() : String
      {
         return files$field;
      }
      
      public function removeType() : void
      {
         hasField$0 &= 4294967293;
         type$field = new int();
      }
      
      public function get hasType() : Boolean
      {
         return (hasField$0 & 2) != 0;
      }
      
      public function set type(param1:int) : void
      {
         hasField$0 |= 2;
         type$field = param1;
      }
      
      public function get type() : int
      {
         return type$field;
      }
      
      public function removeAttackCount() : void
      {
         hasField$0 &= 4294967291;
         attack_count$field = new int();
      }
      
      public function get hasAttackCount() : Boolean
      {
         return (hasField$0 & 4) != 0;
      }
      
      public function set attackCount(param1:int) : void
      {
         hasField$0 |= 4;
         attack_count$field = param1;
      }
      
      public function get attackCount() : int
      {
         return attack_count$field;
      }
      
      final override public function writeToBuffer(param1:WritingBuffer) : void
      {
         var _loc2_:* = 0;
         if(hasMapId)
         {
            WriteUtils.writeTag(param1,0,1);
            WriteUtils.write$TYPE_INT32(param1,map_id$field);
         }
         if(hasPosition)
         {
            WriteUtils.writeTag(param1,2,2);
            WriteUtils.write$TYPE_STRING(param1,position$field);
         }
         if(hasFiles)
         {
            WriteUtils.writeTag(param1,2,3);
            WriteUtils.write$TYPE_STRING(param1,files$field);
         }
         _loc2_ = 0;
         while(_loc2_ < pathArray.length)
         {
            WriteUtils.writeTag(param1,2,4);
            WriteUtils.write$TYPE_STRING(param1,pathArray[_loc2_]);
            _loc2_++;
         }
         if(hasType)
         {
            WriteUtils.writeTag(param1,0,5);
            WriteUtils.write$TYPE_INT32(param1,type$field);
         }
         if(hasAttackCount)
         {
            WriteUtils.writeTag(param1,0,6);
            WriteUtils.write$TYPE_INT32(param1,attack_count$field);
         }
      }
      
      final override public function readFromSlice(param1:IDataInput, param2:uint) : void
      {
         var _loc8_:* = 0;
         var _loc6_:uint = 0;
         var _loc4_:uint = 0;
         var _loc3_:uint = 0;
         var _loc7_:uint = 0;
         var _loc5_:uint = 0;
         while(param1.bytesAvailable > param2)
         {
            switch(((_loc8_ = uint(ReadUtils.read$TYPE_UINT32(param1))) >>> 3) - 1)
            {
               case 0:
                  if(_loc6_ != 0)
                  {
                     throw new IOError("Bad data format: OutercityReqMsg.mapId cannot be set twice.");
                  }
                  _loc6_++;
                  mapId = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 1:
                  if(_loc4_ != 0)
                  {
                     throw new IOError("Bad data format: OutercityReqMsg.position cannot be set twice.");
                  }
                  _loc4_++;
                  position = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 2:
                  if(_loc3_ != 0)
                  {
                     throw new IOError("Bad data format: OutercityReqMsg.files cannot be set twice.");
                  }
                  _loc3_++;
                  files = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 3:
                  pathArray.push(ReadUtils.read$TYPE_STRING(param1));
                  break;
               case 4:
                  if(_loc7_ != 0)
                  {
                     throw new IOError("Bad data format: OutercityReqMsg.type cannot be set twice.");
                  }
                  _loc7_++;
                  type = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 5:
                  if(_loc5_ != 0)
                  {
                     throw new IOError("Bad data format: OutercityReqMsg.attackCount cannot be set twice.");
                  }
                  _loc5_++;
                  attackCount = ReadUtils.read$TYPE_INT32(param1);
                  break;
               default:
                  ReadUtils.skip(param1,_loc8_ & 7);
            }
         }
      }
   }
}

