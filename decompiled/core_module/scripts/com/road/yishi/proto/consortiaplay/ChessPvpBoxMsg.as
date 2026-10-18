package com.road.yishi.proto.consortiaplay
{
   import com.netease.protobuf.*;
   import flash.errors.IOError;
   import flash.utils.IDataInput;
   import flash.utils.IExternalizable;
   
   public final class ChessPvpBoxMsg extends Message implements IExternalizable
   {
      
      private var pos$field:int;
      
      private var hasField$0:uint = 0;
      
      private var buffId$field:int;
      
      private var team$field:int;
      
      [ArrayElementType("int")]
      public var blackList:Array = [];
      
      [ArrayElementType("int")]
      public var whiteList:Array = [];
      
      public function ChessPvpBoxMsg()
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
      
      public function removeBuffId() : void
      {
         hasField$0 &= 4294967293;
         buffId$field = new int();
      }
      
      public function get hasBuffId() : Boolean
      {
         return (hasField$0 & 2) != 0;
      }
      
      public function set buffId(param1:int) : void
      {
         hasField$0 |= 2;
         buffId$field = param1;
      }
      
      public function get buffId() : int
      {
         return buffId$field;
      }
      
      public function removeTeam() : void
      {
         hasField$0 &= 4294967291;
         team$field = new int();
      }
      
      public function get hasTeam() : Boolean
      {
         return (hasField$0 & 4) != 0;
      }
      
      public function set team(param1:int) : void
      {
         hasField$0 |= 4;
         team$field = param1;
      }
      
      public function get team() : int
      {
         return team$field;
      }
      
      final override public function writeToBuffer(param1:WritingBuffer) : void
      {
         var _loc2_:* = 0;
         var _loc3_:* = 0;
         if(hasPos)
         {
            WriteUtils.writeTag(param1,0,1);
            WriteUtils.write$TYPE_INT32(param1,pos$field);
         }
         if(hasBuffId)
         {
            WriteUtils.writeTag(param1,0,2);
            WriteUtils.write$TYPE_INT32(param1,buffId$field);
         }
         if(hasTeam)
         {
            WriteUtils.writeTag(param1,0,3);
            WriteUtils.write$TYPE_INT32(param1,team$field);
         }
         _loc2_ = 0;
         while(_loc2_ < blackList.length)
         {
            WriteUtils.writeTag(param1,0,4);
            WriteUtils.write$TYPE_INT32(param1,blackList[_loc2_]);
            _loc2_++;
         }
         _loc3_ = 0;
         while(_loc3_ < whiteList.length)
         {
            WriteUtils.writeTag(param1,0,5);
            WriteUtils.write$TYPE_INT32(param1,whiteList[_loc3_]);
            _loc3_++;
         }
      }
      
      final override public function readFromSlice(param1:IDataInput, param2:uint) : void
      {
         var _loc5_:* = 0;
         var _loc4_:uint = 0;
         var _loc3_:uint = 0;
         var _loc6_:uint = 0;
         while(param1.bytesAvailable > param2)
         {
            switch(((_loc5_ = ReadUtils.read$TYPE_UINT32(param1)) >>> 3) - 1)
            {
               case 0:
                  if(_loc4_ != 0)
                  {
                     throw new IOError("Bad data format: ChessPvpBoxMsg.pos cannot be set twice.");
                  }
                  _loc4_++;
                  pos = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 1:
                  if(_loc3_ != 0)
                  {
                     throw new IOError("Bad data format: ChessPvpBoxMsg.buffId cannot be set twice.");
                  }
                  _loc3_++;
                  buffId = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 2:
                  if(_loc6_ != 0)
                  {
                     throw new IOError("Bad data format: ChessPvpBoxMsg.team cannot be set twice.");
                  }
                  _loc6_++;
                  team = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 3:
                  if((_loc5_ & 7) == 2)
                  {
                     ReadUtils.readPackedRepeated(param1,ReadUtils.read$TYPE_INT32,blackList);
                  }
                  else
                  {
                     blackList.push(ReadUtils.read$TYPE_INT32(param1));
                  }
                  break;
               case 4:
                  if((_loc5_ & 7) == 2)
                  {
                     ReadUtils.readPackedRepeated(param1,ReadUtils.read$TYPE_INT32,whiteList);
                  }
                  else
                  {
                     whiteList.push(ReadUtils.read$TYPE_INT32(param1));
                  }
                  break;
               default:
                  ReadUtils.skip(param1,_loc5_ & 7);
            }
         }
      }
   }
}

