package com.road.yishi.proto.simple
{
   import com.netease.protobuf.Message;
   import com.netease.protobuf.ReadUtils;
   import com.netease.protobuf.WriteUtils;
   import com.netease.protobuf.WritingBuffer;
   import flash.errors.IOError;
   import flash.utils.IDataInput;
   import flash.utils.IExternalizable;
   
   public final class SimpleWatchMsg extends Message implements IExternalizable
   {
      
      private var grid_type$field:int;
      
      private var hasField$0:uint = 0;
      
      private var grid_pos$field:int;
      
      private var jion1$field:int;
      
      private var jion2$field:int;
      
      private var jion3$field:int;
      
      private var jion4$field:int;
      
      public function SimpleWatchMsg()
      {
         super();
      }
      
      public function removeGridType() : void
      {
         hasField$0 &= 4294967294;
         grid_type$field = new int();
      }
      
      public function get hasGridType() : Boolean
      {
         return (hasField$0 & 1) != 0;
      }
      
      public function set gridType(param1:int) : void
      {
         hasField$0 |= 1;
         grid_type$field = param1;
      }
      
      public function get gridType() : int
      {
         return grid_type$field;
      }
      
      public function removeGridPos() : void
      {
         hasField$0 &= 4294967293;
         grid_pos$field = new int();
      }
      
      public function get hasGridPos() : Boolean
      {
         return (hasField$0 & 2) != 0;
      }
      
      public function set gridPos(param1:int) : void
      {
         hasField$0 |= 2;
         grid_pos$field = param1;
      }
      
      public function get gridPos() : int
      {
         return grid_pos$field;
      }
      
      public function removeJion1() : void
      {
         hasField$0 &= 4294967291;
         jion1$field = new int();
      }
      
      public function get hasJion1() : Boolean
      {
         return (hasField$0 & 4) != 0;
      }
      
      public function set jion1(param1:int) : void
      {
         hasField$0 |= 4;
         jion1$field = param1;
      }
      
      public function get jion1() : int
      {
         return jion1$field;
      }
      
      public function removeJion2() : void
      {
         hasField$0 &= 4294967287;
         jion2$field = new int();
      }
      
      public function get hasJion2() : Boolean
      {
         return (hasField$0 & 8) != 0;
      }
      
      public function set jion2(param1:int) : void
      {
         hasField$0 |= 8;
         jion2$field = param1;
      }
      
      public function get jion2() : int
      {
         return jion2$field;
      }
      
      public function removeJion3() : void
      {
         hasField$0 &= 4294967279;
         jion3$field = new int();
      }
      
      public function get hasJion3() : Boolean
      {
         return (hasField$0 & 0x10) != 0;
      }
      
      public function set jion3(param1:int) : void
      {
         hasField$0 |= 16;
         jion3$field = param1;
      }
      
      public function get jion3() : int
      {
         return jion3$field;
      }
      
      public function removeJion4() : void
      {
         hasField$0 &= 4294967263;
         jion4$field = new int();
      }
      
      public function get hasJion4() : Boolean
      {
         return (hasField$0 & 0x20) != 0;
      }
      
      public function set jion4(param1:int) : void
      {
         hasField$0 |= 32;
         jion4$field = param1;
      }
      
      public function get jion4() : int
      {
         return jion4$field;
      }
      
      final override public function writeToBuffer(param1:WritingBuffer) : void
      {
         if(hasGridType)
         {
            WriteUtils.writeTag(param1,0,1);
            WriteUtils.write$TYPE_INT32(param1,grid_type$field);
         }
         if(hasGridPos)
         {
            WriteUtils.writeTag(param1,0,2);
            WriteUtils.write$TYPE_INT32(param1,grid_pos$field);
         }
         if(hasJion1)
         {
            WriteUtils.writeTag(param1,0,3);
            WriteUtils.write$TYPE_INT32(param1,jion1$field);
         }
         if(hasJion2)
         {
            WriteUtils.writeTag(param1,0,4);
            WriteUtils.write$TYPE_INT32(param1,jion2$field);
         }
         if(hasJion3)
         {
            WriteUtils.writeTag(param1,0,5);
            WriteUtils.write$TYPE_INT32(param1,jion3$field);
         }
         if(hasJion4)
         {
            WriteUtils.writeTag(param1,0,6);
            WriteUtils.write$TYPE_INT32(param1,jion4$field);
         }
      }
      
      final override public function readFromSlice(param1:IDataInput, param2:uint) : void
      {
         var _loc9_:* = 0;
         var _loc5_:uint = 0;
         var _loc6_:uint = 0;
         var _loc8_:uint = 0;
         var _loc4_:uint = 0;
         var _loc3_:uint = 0;
         var _loc7_:uint = 0;
         while(param1.bytesAvailable > param2)
         {
            switch(((_loc9_ = ReadUtils.read$TYPE_UINT32(param1)) >>> 3) - 1)
            {
               case 0:
                  if(_loc5_ != 0)
                  {
                     throw new IOError("Bad data format: SimpleWatchMsg.gridType cannot be set twice.");
                  }
                  _loc5_++;
                  gridType = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 1:
                  if(_loc6_ != 0)
                  {
                     throw new IOError("Bad data format: SimpleWatchMsg.gridPos cannot be set twice.");
                  }
                  _loc6_++;
                  gridPos = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 2:
                  if(_loc8_ != 0)
                  {
                     throw new IOError("Bad data format: SimpleWatchMsg.jion1 cannot be set twice.");
                  }
                  _loc8_++;
                  jion1 = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 3:
                  if(_loc4_ != 0)
                  {
                     throw new IOError("Bad data format: SimpleWatchMsg.jion2 cannot be set twice.");
                  }
                  _loc4_++;
                  jion2 = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 4:
                  if(_loc3_ != 0)
                  {
                     throw new IOError("Bad data format: SimpleWatchMsg.jion3 cannot be set twice.");
                  }
                  _loc3_++;
                  jion3 = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 5:
                  if(_loc7_ != 0)
                  {
                     throw new IOError("Bad data format: SimpleWatchMsg.jion4 cannot be set twice.");
                  }
                  _loc7_++;
                  jion4 = ReadUtils.read$TYPE_INT32(param1);
                  break;
               default:
                  ReadUtils.skip(param1,_loc9_ & 7);
            }
         }
      }
   }
}

