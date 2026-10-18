package com.road.yishi.proto.army
{
   import com.netease.protobuf.Message;
   import com.netease.protobuf.ReadUtils;
   import com.netease.protobuf.WriteUtils;
   import com.netease.protobuf.WritingBuffer;
   import flash.errors.IOError;
   import flash.utils.IDataInput;
   import flash.utils.IExternalizable;
   
   public final class BoxMsg extends Message implements IExternalizable
   {
      
      private var boxId$field:String;
      
      private var userId$field:int;
      
      private var hasField$0:uint = 0;
      
      private var grade$field:int;
      
      private var mapId$field:int;
      
      private var x$field:int;
      
      private var y$field:int;
      
      private var type$field:int;
      
      public function BoxMsg()
      {
         super();
      }
      
      public function removeBoxId() : void
      {
         boxId$field = null;
      }
      
      public function get hasBoxId() : Boolean
      {
         return boxId$field != null;
      }
      
      public function set boxId(param1:String) : void
      {
         boxId$field = param1;
      }
      
      public function get boxId() : String
      {
         return boxId$field;
      }
      
      public function removeUserId() : void
      {
         hasField$0 &= 4294967294;
         userId$field = new int();
      }
      
      public function get hasUserId() : Boolean
      {
         return (hasField$0 & 1) != 0;
      }
      
      public function set userId(param1:int) : void
      {
         hasField$0 |= 1;
         userId$field = param1;
      }
      
      public function get userId() : int
      {
         return userId$field;
      }
      
      public function removeGrade() : void
      {
         hasField$0 &= 4294967293;
         grade$field = new int();
      }
      
      public function get hasGrade() : Boolean
      {
         return (hasField$0 & 2) != 0;
      }
      
      public function set grade(param1:int) : void
      {
         hasField$0 |= 2;
         grade$field = param1;
      }
      
      public function get grade() : int
      {
         return grade$field;
      }
      
      public function removeMapId() : void
      {
         hasField$0 &= 4294967291;
         mapId$field = new int();
      }
      
      public function get hasMapId() : Boolean
      {
         return (hasField$0 & 4) != 0;
      }
      
      public function set mapId(param1:int) : void
      {
         hasField$0 |= 4;
         mapId$field = param1;
      }
      
      public function get mapId() : int
      {
         return mapId$field;
      }
      
      public function removeX() : void
      {
         hasField$0 &= 4294967287;
         x$field = new int();
      }
      
      public function get hasX() : Boolean
      {
         return (hasField$0 & 8) != 0;
      }
      
      public function set x(param1:int) : void
      {
         hasField$0 |= 8;
         x$field = param1;
      }
      
      public function get x() : int
      {
         return x$field;
      }
      
      public function removeY() : void
      {
         hasField$0 &= 4294967279;
         y$field = new int();
      }
      
      public function get hasY() : Boolean
      {
         return (hasField$0 & 0x10) != 0;
      }
      
      public function set y(param1:int) : void
      {
         hasField$0 |= 16;
         y$field = param1;
      }
      
      public function get y() : int
      {
         return y$field;
      }
      
      public function removeType() : void
      {
         hasField$0 &= 4294967263;
         type$field = new int();
      }
      
      public function get hasType() : Boolean
      {
         return (hasField$0 & 0x20) != 0;
      }
      
      public function set type(param1:int) : void
      {
         hasField$0 |= 32;
         type$field = param1;
      }
      
      public function get type() : int
      {
         return type$field;
      }
      
      final override public function writeToBuffer(param1:WritingBuffer) : void
      {
         if(hasBoxId)
         {
            WriteUtils.writeTag(param1,2,1);
            WriteUtils.write$TYPE_STRING(param1,boxId$field);
         }
         if(hasUserId)
         {
            WriteUtils.writeTag(param1,0,2);
            WriteUtils.write$TYPE_INT32(param1,userId$field);
         }
         if(hasGrade)
         {
            WriteUtils.writeTag(param1,0,3);
            WriteUtils.write$TYPE_INT32(param1,grade$field);
         }
         if(hasMapId)
         {
            WriteUtils.writeTag(param1,0,4);
            WriteUtils.write$TYPE_INT32(param1,mapId$field);
         }
         if(hasX)
         {
            WriteUtils.writeTag(param1,0,5);
            WriteUtils.write$TYPE_INT32(param1,x$field);
         }
         if(hasY)
         {
            WriteUtils.writeTag(param1,0,6);
            WriteUtils.write$TYPE_INT32(param1,y$field);
         }
         if(hasType)
         {
            WriteUtils.writeTag(param1,0,7);
            WriteUtils.write$TYPE_INT32(param1,type$field);
         }
      }
      
      final override public function readFromSlice(param1:IDataInput, param2:uint) : void
      {
         var _loc9_:* = 0;
         var _loc3_:uint = 0;
         var _loc7_:uint = 0;
         var _loc6_:uint = 0;
         var _loc10_:uint = 0;
         var _loc4_:uint = 0;
         var _loc5_:uint = 0;
         var _loc8_:uint = 0;
         while(param1.bytesAvailable > param2)
         {
            switch(((_loc9_ = ReadUtils.read$TYPE_UINT32(param1)) >>> 3) - 1)
            {
               case 0:
                  if(_loc3_ != 0)
                  {
                     throw new IOError("Bad data format: BoxMsg.boxId cannot be set twice.");
                  }
                  _loc3_++;
                  boxId = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 1:
                  if(_loc7_ != 0)
                  {
                     throw new IOError("Bad data format: BoxMsg.userId cannot be set twice.");
                  }
                  _loc7_++;
                  userId = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 2:
                  if(_loc6_ != 0)
                  {
                     throw new IOError("Bad data format: BoxMsg.grade cannot be set twice.");
                  }
                  _loc6_++;
                  grade = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 3:
                  if(_loc10_ != 0)
                  {
                     throw new IOError("Bad data format: BoxMsg.mapId cannot be set twice.");
                  }
                  _loc10_++;
                  mapId = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 4:
                  if(_loc4_ != 0)
                  {
                     throw new IOError("Bad data format: BoxMsg.x cannot be set twice.");
                  }
                  _loc4_++;
                  x = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 5:
                  if(_loc5_ != 0)
                  {
                     throw new IOError("Bad data format: BoxMsg.y cannot be set twice.");
                  }
                  _loc5_++;
                  y = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 6:
                  if(_loc8_ != 0)
                  {
                     throw new IOError("Bad data format: BoxMsg.type cannot be set twice.");
                  }
                  _loc8_++;
                  type = ReadUtils.read$TYPE_INT32(param1);
                  break;
               default:
                  ReadUtils.skip(param1,_loc9_ & 7);
            }
         }
      }
   }
}

