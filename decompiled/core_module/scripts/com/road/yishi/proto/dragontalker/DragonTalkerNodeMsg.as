package com.road.yishi.proto.dragontalker
{
   import com.netease.protobuf.Message;
   import com.netease.protobuf.ReadUtils;
   import com.netease.protobuf.WriteUtils;
   import com.netease.protobuf.WritingBuffer;
   import flash.errors.IOError;
   import flash.utils.IDataInput;
   import flash.utils.IExternalizable;
   
   public final class DragonTalkerNodeMsg extends Message implements IExternalizable
   {
      
      private var dragontalker1$field:int;
      
      private var hasField$0:uint = 0;
      
      private var dragontalker2$field:int;
      
      private var dragontalker3$field:int;
      
      private var dragontalker4$field:int;
      
      private var dragontalker5$field:int;
      
      private var op$field:int;
      
      private var param1$field:int;
      
      public function DragonTalkerNodeMsg()
      {
         super();
      }
      
      public function removeDragontalker1() : void
      {
         hasField$0 &= 4294967294;
         dragontalker1$field = new int();
      }
      
      public function get hasDragontalker1() : Boolean
      {
         return (hasField$0 & 1) != 0;
      }
      
      public function set dragontalker1(param1:int) : void
      {
         hasField$0 |= 1;
         dragontalker1$field = param1;
      }
      
      public function get dragontalker1() : int
      {
         return dragontalker1$field;
      }
      
      public function removeDragontalker2() : void
      {
         hasField$0 &= 4294967293;
         dragontalker2$field = new int();
      }
      
      public function get hasDragontalker2() : Boolean
      {
         return (hasField$0 & 2) != 0;
      }
      
      public function set dragontalker2(param1:int) : void
      {
         hasField$0 |= 2;
         dragontalker2$field = param1;
      }
      
      public function get dragontalker2() : int
      {
         return dragontalker2$field;
      }
      
      public function removeDragontalker3() : void
      {
         hasField$0 &= 4294967291;
         dragontalker3$field = new int();
      }
      
      public function get hasDragontalker3() : Boolean
      {
         return (hasField$0 & 4) != 0;
      }
      
      public function set dragontalker3(param1:int) : void
      {
         hasField$0 |= 4;
         dragontalker3$field = param1;
      }
      
      public function get dragontalker3() : int
      {
         return dragontalker3$field;
      }
      
      public function removeDragontalker4() : void
      {
         hasField$0 &= 4294967287;
         dragontalker4$field = new int();
      }
      
      public function get hasDragontalker4() : Boolean
      {
         return (hasField$0 & 8) != 0;
      }
      
      public function set dragontalker4(param1:int) : void
      {
         hasField$0 |= 8;
         dragontalker4$field = param1;
      }
      
      public function get dragontalker4() : int
      {
         return dragontalker4$field;
      }
      
      public function removeDragontalker5() : void
      {
         hasField$0 &= 4294967279;
         dragontalker5$field = new int();
      }
      
      public function get hasDragontalker5() : Boolean
      {
         return (hasField$0 & 0x10) != 0;
      }
      
      public function set dragontalker5(param1:int) : void
      {
         hasField$0 |= 16;
         dragontalker5$field = param1;
      }
      
      public function get dragontalker5() : int
      {
         return dragontalker5$field;
      }
      
      public function removeOp() : void
      {
         hasField$0 &= 4294967263;
         op$field = new int();
      }
      
      public function get hasOp() : Boolean
      {
         return (hasField$0 & 0x20) != 0;
      }
      
      public function set op(param1:int) : void
      {
         hasField$0 |= 32;
         op$field = param1;
      }
      
      public function get op() : int
      {
         return op$field;
      }
      
      public function removeParam1() : void
      {
         hasField$0 &= 4294967231;
         param1$field = new int();
      }
      
      public function get hasParam1() : Boolean
      {
         return (hasField$0 & 0x40) != 0;
      }
      
      public function set param1(param1:int) : void
      {
         hasField$0 |= 64;
         param1$field = param1;
      }
      
      public function get param1() : int
      {
         return param1$field;
      }
      
      final override public function writeToBuffer(param1:WritingBuffer) : void
      {
         if(hasDragontalker1)
         {
            WriteUtils.writeTag(param1,0,1);
            WriteUtils.write$TYPE_INT32(param1,dragontalker1$field);
         }
         if(hasDragontalker2)
         {
            WriteUtils.writeTag(param1,0,2);
            WriteUtils.write$TYPE_INT32(param1,dragontalker2$field);
         }
         if(hasDragontalker3)
         {
            WriteUtils.writeTag(param1,0,3);
            WriteUtils.write$TYPE_INT32(param1,dragontalker3$field);
         }
         if(hasDragontalker4)
         {
            WriteUtils.writeTag(param1,0,4);
            WriteUtils.write$TYPE_INT32(param1,dragontalker4$field);
         }
         if(hasDragontalker5)
         {
            WriteUtils.writeTag(param1,0,5);
            WriteUtils.write$TYPE_INT32(param1,dragontalker5$field);
         }
         if(hasOp)
         {
            WriteUtils.writeTag(param1,0,6);
            WriteUtils.write$TYPE_INT32(param1,op$field);
         }
         if(hasParam1)
         {
            WriteUtils.writeTag(param1,0,7);
            WriteUtils.write$TYPE_INT32(param1,param1$field);
         }
      }
      
      final override public function readFromSlice(param1:IDataInput, param2:uint) : void
      {
         var _loc8_:* = 0;
         var _loc7_:uint = 0;
         var _loc3_:uint = 0;
         var _loc5_:uint = 0;
         var _loc9_:uint = 0;
         var _loc4_:uint = 0;
         var _loc10_:uint = 0;
         var _loc6_:uint = 0;
         while(param1.bytesAvailable > param2)
         {
            switch(((_loc8_ = ReadUtils.read$TYPE_UINT32(param1)) >>> 3) - 1)
            {
               case 0:
                  if(_loc7_ != 0)
                  {
                     throw new IOError("Bad data format: DragonTalkerNodeMsg.dragontalker1 cannot be set twice.");
                  }
                  _loc7_++;
                  dragontalker1 = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 1:
                  if(_loc3_ != 0)
                  {
                     throw new IOError("Bad data format: DragonTalkerNodeMsg.dragontalker2 cannot be set twice.");
                  }
                  _loc3_++;
                  dragontalker2 = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 2:
                  if(_loc5_ != 0)
                  {
                     throw new IOError("Bad data format: DragonTalkerNodeMsg.dragontalker3 cannot be set twice.");
                  }
                  _loc5_++;
                  dragontalker3 = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 3:
                  if(_loc9_ != 0)
                  {
                     throw new IOError("Bad data format: DragonTalkerNodeMsg.dragontalker4 cannot be set twice.");
                  }
                  _loc9_++;
                  dragontalker4 = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 4:
                  if(_loc4_ != 0)
                  {
                     throw new IOError("Bad data format: DragonTalkerNodeMsg.dragontalker5 cannot be set twice.");
                  }
                  _loc4_++;
                  dragontalker5 = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 5:
                  if(_loc10_ != 0)
                  {
                     throw new IOError("Bad data format: DragonTalkerNodeMsg.op cannot be set twice.");
                  }
                  _loc10_++;
                  op = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 6:
                  if(_loc6_ != 0)
                  {
                     throw new IOError("Bad data format: DragonTalkerNodeMsg.param1 cannot be set twice.");
                  }
                  _loc6_++;
                  param1 = ReadUtils.read$TYPE_INT32(param1);
                  break;
               default:
                  ReadUtils.skip(param1,_loc8_ & 7);
            }
         }
      }
   }
}

