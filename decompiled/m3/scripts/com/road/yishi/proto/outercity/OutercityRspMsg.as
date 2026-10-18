package com.road.yishi.proto.outercity
{
   import com.netease.protobuf.Message;
   import com.netease.protobuf.ReadUtils;
   import com.netease.protobuf.WriteUtils;
   import com.netease.protobuf.WritingBuffer;
   import flash.errors.IOError;
   import flash.utils.IDataInput;
   import flash.utils.IExternalizable;
   
   public final class OutercityRspMsg extends Message implements IExternalizable
   {
      
      private var result$field:int;
      
      private var hasField$0:uint = 0;
      
      private var start_pos_x$field:int;
      
      private var start_pos_y$field:int;
      
      private var cur_pos_x$field:int;
      
      private var cur_pos_y$field:int;
      
      private var end_pos_x$field:int;
      
      private var end_pos_y$field:int;
      
      public function OutercityRspMsg()
      {
         super();
      }
      
      public function removeResult() : void
      {
         hasField$0 &= 4294967294;
         result$field = new int();
      }
      
      public function get hasResult() : Boolean
      {
         return (hasField$0 & 1) != 0;
      }
      
      public function set result(param1:int) : void
      {
         hasField$0 |= 1;
         result$field = param1;
      }
      
      public function get result() : int
      {
         return result$field;
      }
      
      public function removeStartPosX() : void
      {
         hasField$0 &= 4294967293;
         start_pos_x$field = new int();
      }
      
      public function get hasStartPosX() : Boolean
      {
         return (hasField$0 & 2) != 0;
      }
      
      public function set startPosX(param1:int) : void
      {
         hasField$0 |= 2;
         start_pos_x$field = param1;
      }
      
      public function get startPosX() : int
      {
         return start_pos_x$field;
      }
      
      public function removeStartPosY() : void
      {
         hasField$0 &= 4294967291;
         start_pos_y$field = new int();
      }
      
      public function get hasStartPosY() : Boolean
      {
         return (hasField$0 & 4) != 0;
      }
      
      public function set startPosY(param1:int) : void
      {
         hasField$0 |= 4;
         start_pos_y$field = param1;
      }
      
      public function get startPosY() : int
      {
         return start_pos_y$field;
      }
      
      public function removeCurPosX() : void
      {
         hasField$0 &= 4294967287;
         cur_pos_x$field = new int();
      }
      
      public function get hasCurPosX() : Boolean
      {
         return (hasField$0 & 8) != 0;
      }
      
      public function set curPosX(param1:int) : void
      {
         hasField$0 |= 8;
         cur_pos_x$field = param1;
      }
      
      public function get curPosX() : int
      {
         return cur_pos_x$field;
      }
      
      public function removeCurPosY() : void
      {
         hasField$0 &= 4294967279;
         cur_pos_y$field = new int();
      }
      
      public function get hasCurPosY() : Boolean
      {
         return (hasField$0 & 0x10) != 0;
      }
      
      public function set curPosY(param1:int) : void
      {
         hasField$0 |= 16;
         cur_pos_y$field = param1;
      }
      
      public function get curPosY() : int
      {
         return cur_pos_y$field;
      }
      
      public function removeEndPosX() : void
      {
         hasField$0 &= 4294967263;
         end_pos_x$field = new int();
      }
      
      public function get hasEndPosX() : Boolean
      {
         return (hasField$0 & 0x20) != 0;
      }
      
      public function set endPosX(param1:int) : void
      {
         hasField$0 |= 32;
         end_pos_x$field = param1;
      }
      
      public function get endPosX() : int
      {
         return end_pos_x$field;
      }
      
      public function removeEndPosY() : void
      {
         hasField$0 &= 4294967231;
         end_pos_y$field = new int();
      }
      
      public function get hasEndPosY() : Boolean
      {
         return (hasField$0 & 0x40) != 0;
      }
      
      public function set endPosY(param1:int) : void
      {
         hasField$0 |= 64;
         end_pos_y$field = param1;
      }
      
      public function get endPosY() : int
      {
         return end_pos_y$field;
      }
      
      final override public function writeToBuffer(param1:WritingBuffer) : void
      {
         if(hasResult)
         {
            WriteUtils.writeTag(param1,0,1);
            WriteUtils.write$TYPE_INT32(param1,result$field);
         }
         if(hasStartPosX)
         {
            WriteUtils.writeTag(param1,0,2);
            WriteUtils.write$TYPE_INT32(param1,start_pos_x$field);
         }
         if(hasStartPosY)
         {
            WriteUtils.writeTag(param1,0,3);
            WriteUtils.write$TYPE_INT32(param1,start_pos_y$field);
         }
         if(hasCurPosX)
         {
            WriteUtils.writeTag(param1,0,4);
            WriteUtils.write$TYPE_INT32(param1,cur_pos_x$field);
         }
         if(hasCurPosY)
         {
            WriteUtils.writeTag(param1,0,5);
            WriteUtils.write$TYPE_INT32(param1,cur_pos_y$field);
         }
         if(hasEndPosX)
         {
            WriteUtils.writeTag(param1,0,6);
            WriteUtils.write$TYPE_INT32(param1,end_pos_x$field);
         }
         if(hasEndPosY)
         {
            WriteUtils.writeTag(param1,0,7);
            WriteUtils.write$TYPE_INT32(param1,end_pos_y$field);
         }
      }
      
      final override public function readFromSlice(param1:IDataInput, param2:uint) : void
      {
         var _loc10_:* = 0;
         var _loc9_:uint = 0;
         var _loc5_:uint = 0;
         var _loc7_:uint = 0;
         var _loc6_:uint = 0;
         var _loc4_:uint = 0;
         var _loc8_:uint = 0;
         var _loc3_:uint = 0;
         while(param1.bytesAvailable > param2)
         {
            switch(((_loc10_ = uint(ReadUtils.read$TYPE_UINT32(param1))) >>> 3) - 1)
            {
               case 0:
                  if(_loc9_ != 0)
                  {
                     throw new IOError("Bad data format: OutercityRspMsg.result cannot be set twice.");
                  }
                  _loc9_++;
                  result = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 1:
                  if(_loc5_ != 0)
                  {
                     throw new IOError("Bad data format: OutercityRspMsg.startPosX cannot be set twice.");
                  }
                  _loc5_++;
                  startPosX = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 2:
                  if(_loc7_ != 0)
                  {
                     throw new IOError("Bad data format: OutercityRspMsg.startPosY cannot be set twice.");
                  }
                  _loc7_++;
                  startPosY = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 3:
                  if(_loc6_ != 0)
                  {
                     throw new IOError("Bad data format: OutercityRspMsg.curPosX cannot be set twice.");
                  }
                  _loc6_++;
                  curPosX = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 4:
                  if(_loc4_ != 0)
                  {
                     throw new IOError("Bad data format: OutercityRspMsg.curPosY cannot be set twice.");
                  }
                  _loc4_++;
                  curPosY = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 5:
                  if(_loc8_ != 0)
                  {
                     throw new IOError("Bad data format: OutercityRspMsg.endPosX cannot be set twice.");
                  }
                  _loc8_++;
                  endPosX = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 6:
                  if(_loc3_ != 0)
                  {
                     throw new IOError("Bad data format: OutercityRspMsg.endPosY cannot be set twice.");
                  }
                  _loc3_++;
                  endPosY = ReadUtils.read$TYPE_INT32(param1);
                  break;
               default:
                  ReadUtils.skip(param1,_loc10_ & 7);
            }
         }
      }
   }
}

