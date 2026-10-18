package com.road.yishi.proto.consortiapve
{
   import com.netease.protobuf.*;
   import flash.errors.IOError;
   import flash.utils.IDataInput;
   import flash.utils.IExternalizable;
   
   public final class ConsortiaPveCurNodeMsg extends Message implements IExternalizable
   {
      
      private var curNodeId$field:int;
      
      private var hasField$0:uint = 0;
      
      private var bossHp$field:Int64;
      
      private var bossMaxHp$field:Int64;
      
      private var attackCount$field:int;
      
      [ArrayElementType("int")]
      public var buffers:Array = [];
      
      [ArrayElementType("com.road.yishi.proto.consortiapve.ConsortiaPvePlayerMsg")]
      public var players:Array = [];
      
      public function ConsortiaPveCurNodeMsg()
      {
         super();
      }
      
      public function removeCurNodeId() : void
      {
         hasField$0 &= 4294967294;
         curNodeId$field = new int();
      }
      
      public function get hasCurNodeId() : Boolean
      {
         return (hasField$0 & 1) != 0;
      }
      
      public function set curNodeId(param1:int) : void
      {
         hasField$0 |= 1;
         curNodeId$field = param1;
      }
      
      public function get curNodeId() : int
      {
         return curNodeId$field;
      }
      
      public function removeBossHp() : void
      {
         bossHp$field = null;
      }
      
      public function get hasBossHp() : Boolean
      {
         return bossHp$field != null;
      }
      
      public function set bossHp(param1:Int64) : void
      {
         bossHp$field = param1;
      }
      
      public function get bossHp() : Int64
      {
         return bossHp$field;
      }
      
      public function removeBossMaxHp() : void
      {
         bossMaxHp$field = null;
      }
      
      public function get hasBossMaxHp() : Boolean
      {
         return bossMaxHp$field != null;
      }
      
      public function set bossMaxHp(param1:Int64) : void
      {
         bossMaxHp$field = param1;
      }
      
      public function get bossMaxHp() : Int64
      {
         return bossMaxHp$field;
      }
      
      public function removeAttackCount() : void
      {
         hasField$0 &= 4294967293;
         attackCount$field = new int();
      }
      
      public function get hasAttackCount() : Boolean
      {
         return (hasField$0 & 2) != 0;
      }
      
      public function set attackCount(param1:int) : void
      {
         hasField$0 |= 2;
         attackCount$field = param1;
      }
      
      public function get attackCount() : int
      {
         return attackCount$field;
      }
      
      final override public function writeToBuffer(param1:WritingBuffer) : void
      {
         var _loc3_:* = 0;
         var _loc2_:* = 0;
         if(hasCurNodeId)
         {
            WriteUtils.writeTag(param1,0,1);
            WriteUtils.write$TYPE_INT32(param1,curNodeId$field);
         }
         if(hasBossHp)
         {
            WriteUtils.writeTag(param1,0,2);
            WriteUtils.write$TYPE_INT64(param1,bossHp$field);
         }
         if(hasBossMaxHp)
         {
            WriteUtils.writeTag(param1,0,3);
            WriteUtils.write$TYPE_INT64(param1,bossMaxHp$field);
         }
         if(hasAttackCount)
         {
            WriteUtils.writeTag(param1,0,4);
            WriteUtils.write$TYPE_INT32(param1,attackCount$field);
         }
         _loc3_ = 0;
         while(_loc3_ < buffers.length)
         {
            WriteUtils.writeTag(param1,0,5);
            WriteUtils.write$TYPE_INT32(param1,buffers[_loc3_]);
            _loc3_++;
         }
         _loc2_ = 0;
         while(_loc2_ < players.length)
         {
            WriteUtils.writeTag(param1,2,6);
            WriteUtils.write$TYPE_MESSAGE(param1,players[_loc2_]);
            _loc2_++;
         }
      }
      
      final override public function readFromSlice(param1:IDataInput, param2:uint) : void
      {
         var _loc6_:* = 0;
         var _loc8_:ConsortiaPvePlayerMsg = null;
         var _loc7_:uint = 0;
         var _loc5_:uint = 0;
         var _loc3_:uint = 0;
         var _loc4_:uint = 0;
         while(param1.bytesAvailable > param2)
         {
            switch(((_loc6_ = ReadUtils.read$TYPE_UINT32(param1)) >>> 3) - 1)
            {
               case 0:
                  if(_loc7_ != 0)
                  {
                     throw new IOError("Bad data format: ConsortiaPveCurNodeMsg.curNodeId cannot be set twice.");
                  }
                  _loc7_++;
                  curNodeId = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 1:
                  if(_loc5_ != 0)
                  {
                     throw new IOError("Bad data format: ConsortiaPveCurNodeMsg.bossHp cannot be set twice.");
                  }
                  _loc5_++;
                  bossHp = ReadUtils.read$TYPE_INT64(param1);
                  break;
               case 2:
                  if(_loc3_ != 0)
                  {
                     throw new IOError("Bad data format: ConsortiaPveCurNodeMsg.bossMaxHp cannot be set twice.");
                  }
                  _loc3_++;
                  bossMaxHp = ReadUtils.read$TYPE_INT64(param1);
                  break;
               case 3:
                  if(_loc4_ != 0)
                  {
                     throw new IOError("Bad data format: ConsortiaPveCurNodeMsg.attackCount cannot be set twice.");
                  }
                  _loc4_++;
                  attackCount = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 4:
                  if((_loc6_ & 7) == 2)
                  {
                     ReadUtils.readPackedRepeated(param1,ReadUtils.read$TYPE_INT32,buffers);
                  }
                  else
                  {
                     buffers.push(ReadUtils.read$TYPE_INT32(param1));
                  }
                  break;
               case 5:
                  _loc8_ = new ConsortiaPvePlayerMsg();
                  ReadUtils.read$TYPE_MESSAGE(param1,_loc8_);
                  players.push(_loc8_);
                  break;
               default:
                  ReadUtils.skip(param1,_loc6_ & 7);
            }
         }
      }
   }
}

