package com.road.yishi.proto.army
{
   import com.netease.protobuf.Message;
   import com.netease.protobuf.ReadUtils;
   import com.netease.protobuf.WriteUtils;
   import com.netease.protobuf.WritingBuffer;
   import flash.errors.IOError;
   import flash.utils.IDataInput;
   import flash.utils.IExternalizable;
   
   public final class RuneStoneUpReqMsg extends Message implements IExternalizable
   {
      
      private var pos$field:int;
      
      private var hasField$0:uint = 0;
      
      private var id$field:int;
      
      private var runeNum$field:int;
      
      private var bagType$field:int;
      
      private var runeId$field:int;
      
      public function RuneStoneUpReqMsg()
      {
         super();
      }
      
      public function removePos() : void
      {
         hasField$0 &= 4294967294;
         pos$field = new int();
      }
      
      public function get hasPos() : Boolean
      {
         return (hasField$0 & 1) != 0;
      }
      
      public function set pos(param1:int) : void
      {
         hasField$0 |= 1;
         pos$field = param1;
      }
      
      public function get pos() : int
      {
         return pos$field;
      }
      
      public function removeId() : void
      {
         hasField$0 &= 4294967293;
         id$field = new int();
      }
      
      public function get hasId() : Boolean
      {
         return (hasField$0 & 2) != 0;
      }
      
      public function set id(param1:int) : void
      {
         hasField$0 |= 2;
         id$field = param1;
      }
      
      public function get id() : int
      {
         return id$field;
      }
      
      public function removeRuneNum() : void
      {
         hasField$0 &= 4294967291;
         runeNum$field = new int();
      }
      
      public function get hasRuneNum() : Boolean
      {
         return (hasField$0 & 4) != 0;
      }
      
      public function set runeNum(param1:int) : void
      {
         hasField$0 |= 4;
         runeNum$field = param1;
      }
      
      public function get runeNum() : int
      {
         return runeNum$field;
      }
      
      public function removeBagType() : void
      {
         hasField$0 &= 4294967287;
         bagType$field = new int();
      }
      
      public function get hasBagType() : Boolean
      {
         return (hasField$0 & 8) != 0;
      }
      
      public function set bagType(param1:int) : void
      {
         hasField$0 |= 8;
         bagType$field = param1;
      }
      
      public function get bagType() : int
      {
         return bagType$field;
      }
      
      public function removeRuneId() : void
      {
         hasField$0 &= 4294967279;
         runeId$field = new int();
      }
      
      public function get hasRuneId() : Boolean
      {
         return (hasField$0 & 0x10) != 0;
      }
      
      public function set runeId(param1:int) : void
      {
         hasField$0 |= 16;
         runeId$field = param1;
      }
      
      public function get runeId() : int
      {
         return runeId$field;
      }
      
      final override public function writeToBuffer(param1:WritingBuffer) : void
      {
         if(hasPos)
         {
            WriteUtils.writeTag(param1,0,1);
            WriteUtils.write$TYPE_INT32(param1,pos$field);
         }
         if(hasId)
         {
            WriteUtils.writeTag(param1,0,2);
            WriteUtils.write$TYPE_INT32(param1,id$field);
         }
         if(hasRuneNum)
         {
            WriteUtils.writeTag(param1,0,3);
            WriteUtils.write$TYPE_INT32(param1,runeNum$field);
         }
         if(hasBagType)
         {
            WriteUtils.writeTag(param1,0,4);
            WriteUtils.write$TYPE_INT32(param1,bagType$field);
         }
         if(hasRuneId)
         {
            WriteUtils.writeTag(param1,0,5);
            WriteUtils.write$TYPE_INT32(param1,runeId$field);
         }
      }
      
      final override public function readFromSlice(param1:IDataInput, param2:uint) : void
      {
         var _loc7_:* = 0;
         var _loc5_:uint = 0;
         var _loc4_:uint = 0;
         var _loc8_:uint = 0;
         var _loc3_:uint = 0;
         var _loc6_:uint = 0;
         while(param1.bytesAvailable > param2)
         {
            switch(((_loc7_ = ReadUtils.read$TYPE_UINT32(param1)) >>> 3) - 1)
            {
               case 0:
                  if(_loc5_ != 0)
                  {
                     throw new IOError("Bad data format: RuneStoneUpReqMsg.pos cannot be set twice.");
                  }
                  _loc5_++;
                  pos = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 1:
                  if(_loc4_ != 0)
                  {
                     throw new IOError("Bad data format: RuneStoneUpReqMsg.id cannot be set twice.");
                  }
                  _loc4_++;
                  id = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 2:
                  if(_loc8_ != 0)
                  {
                     throw new IOError("Bad data format: RuneStoneUpReqMsg.runeNum cannot be set twice.");
                  }
                  _loc8_++;
                  runeNum = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 3:
                  if(_loc3_ != 0)
                  {
                     throw new IOError("Bad data format: RuneStoneUpReqMsg.bagType cannot be set twice.");
                  }
                  _loc3_++;
                  bagType = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 4:
                  if(_loc6_ != 0)
                  {
                     throw new IOError("Bad data format: RuneStoneUpReqMsg.runeId cannot be set twice.");
                  }
                  _loc6_++;
                  runeId = ReadUtils.read$TYPE_INT32(param1);
                  break;
               default:
                  ReadUtils.skip(param1,_loc7_ & 7);
            }
         }
      }
   }
}

