package com.road.yishi.proto.monster
{
   import com.netease.protobuf.*;
   import flash.errors.IOError;
   import flash.utils.IDataInput;
   import flash.utils.IExternalizable;
   
   public final class MonsterExploreClientOpMsg extends Message implements IExternalizable
   {
      
      private var opType$field:int;
      
      private var hasField$0:uint = 0;
      
      private var monsterId$field:int;
      
      private var chapterId$field:int;
      
      private var nodeId$field:int;
      
      [ArrayElementType("com.road.yishi.proto.monster.MonsterExploreEditMsg")]
      public var edits:Array = [];
      
      private var quickNum$field:int;
      
      public function MonsterExploreClientOpMsg()
      {
         super();
      }
      
      public function removeOpType() : void
      {
         hasField$0 &= 4294967294;
         opType$field = new int();
      }
      
      public function get hasOpType() : Boolean
      {
         return (hasField$0 & 1) != 0;
      }
      
      public function set opType(param1:int) : void
      {
         hasField$0 |= 1;
         opType$field = param1;
      }
      
      public function get opType() : int
      {
         return opType$field;
      }
      
      public function removeMonsterId() : void
      {
         hasField$0 &= 4294967293;
         monsterId$field = new int();
      }
      
      public function get hasMonsterId() : Boolean
      {
         return (hasField$0 & 2) != 0;
      }
      
      public function set monsterId(param1:int) : void
      {
         hasField$0 |= 2;
         monsterId$field = param1;
      }
      
      public function get monsterId() : int
      {
         return monsterId$field;
      }
      
      public function removeChapterId() : void
      {
         hasField$0 &= 4294967291;
         chapterId$field = new int();
      }
      
      public function get hasChapterId() : Boolean
      {
         return (hasField$0 & 4) != 0;
      }
      
      public function set chapterId(param1:int) : void
      {
         hasField$0 |= 4;
         chapterId$field = param1;
      }
      
      public function get chapterId() : int
      {
         return chapterId$field;
      }
      
      public function removeNodeId() : void
      {
         hasField$0 &= 4294967287;
         nodeId$field = new int();
      }
      
      public function get hasNodeId() : Boolean
      {
         return (hasField$0 & 8) != 0;
      }
      
      public function set nodeId(param1:int) : void
      {
         hasField$0 |= 8;
         nodeId$field = param1;
      }
      
      public function get nodeId() : int
      {
         return nodeId$field;
      }
      
      public function removeQuickNum() : void
      {
         hasField$0 &= 4294967279;
         quickNum$field = new int();
      }
      
      public function get hasQuickNum() : Boolean
      {
         return (hasField$0 & 0x10) != 0;
      }
      
      public function set quickNum(param1:int) : void
      {
         hasField$0 |= 16;
         quickNum$field = param1;
      }
      
      public function get quickNum() : int
      {
         return quickNum$field;
      }
      
      final override public function writeToBuffer(param1:WritingBuffer) : void
      {
         var _loc2_:* = 0;
         if(hasOpType)
         {
            WriteUtils.writeTag(param1,0,1);
            WriteUtils.write$TYPE_INT32(param1,opType$field);
         }
         if(hasMonsterId)
         {
            WriteUtils.writeTag(param1,0,2);
            WriteUtils.write$TYPE_INT32(param1,monsterId$field);
         }
         if(hasChapterId)
         {
            WriteUtils.writeTag(param1,0,3);
            WriteUtils.write$TYPE_INT32(param1,chapterId$field);
         }
         if(hasNodeId)
         {
            WriteUtils.writeTag(param1,0,4);
            WriteUtils.write$TYPE_INT32(param1,nodeId$field);
         }
         _loc2_ = 0;
         while(_loc2_ < edits.length)
         {
            WriteUtils.writeTag(param1,2,5);
            WriteUtils.write$TYPE_MESSAGE(param1,edits[_loc2_]);
            _loc2_++;
         }
         if(hasQuickNum)
         {
            WriteUtils.writeTag(param1,0,6);
            WriteUtils.write$TYPE_INT32(param1,quickNum$field);
         }
      }
      
      final override public function readFromSlice(param1:IDataInput, param2:uint) : void
      {
         var _loc7_:* = 0;
         var _loc6_:MonsterExploreEditMsg = null;
         var _loc4_:uint = 0;
         var _loc9_:uint = 0;
         var _loc5_:uint = 0;
         var _loc3_:uint = 0;
         var _loc8_:uint = 0;
         while(param1.bytesAvailable > param2)
         {
            switch(((_loc7_ = ReadUtils.read$TYPE_UINT32(param1)) >>> 3) - 1)
            {
               case 0:
                  if(_loc4_ != 0)
                  {
                     throw new IOError("Bad data format: MonsterExploreClientOpMsg.opType cannot be set twice.");
                  }
                  _loc4_++;
                  opType = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 1:
                  if(_loc9_ != 0)
                  {
                     throw new IOError("Bad data format: MonsterExploreClientOpMsg.monsterId cannot be set twice.");
                  }
                  _loc9_++;
                  monsterId = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 2:
                  if(_loc5_ != 0)
                  {
                     throw new IOError("Bad data format: MonsterExploreClientOpMsg.chapterId cannot be set twice.");
                  }
                  _loc5_++;
                  chapterId = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 3:
                  if(_loc3_ != 0)
                  {
                     throw new IOError("Bad data format: MonsterExploreClientOpMsg.nodeId cannot be set twice.");
                  }
                  _loc3_++;
                  nodeId = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 4:
                  _loc6_ = new MonsterExploreEditMsg();
                  ReadUtils.read$TYPE_MESSAGE(param1,_loc6_);
                  edits.push(_loc6_);
                  break;
               case 5:
                  if(_loc8_ != 0)
                  {
                     throw new IOError("Bad data format: MonsterExploreClientOpMsg.quickNum cannot be set twice.");
                  }
                  _loc8_++;
                  quickNum = ReadUtils.read$TYPE_INT32(param1);
                  break;
               default:
                  ReadUtils.skip(param1,_loc7_ & 7);
            }
         }
      }
   }
}

