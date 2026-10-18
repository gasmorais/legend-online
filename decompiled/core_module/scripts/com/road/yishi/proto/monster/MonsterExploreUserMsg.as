package com.road.yishi.proto.monster
{
   import com.netease.protobuf.Message;
   import com.netease.protobuf.ReadUtils;
   import com.netease.protobuf.WriteUtils;
   import com.netease.protobuf.WritingBuffer;
   import flash.errors.IOError;
   import flash.utils.IDataInput;
   import flash.utils.IExternalizable;
   
   public final class MonsterExploreUserMsg extends Message implements IExternalizable
   {
      
      private var curChapterId$field:int;
      
      private var hasField$0:uint = 0;
      
      private var curNodeId$field:int;
      
      private var passChapterId$field:int;
      
      private var passNodeId$field:int;
      
      private var isNodeSwitch$field:Boolean;
      
      private var isEditSwitch$field:Boolean;
      
      private var fastTotalCount$field:int;
      
      private var fastUseCount$field:int;
      
      private var bossCount$field:int;
      
      public function MonsterExploreUserMsg()
      {
         super();
      }
      
      public function removeCurChapterId() : void
      {
         hasField$0 &= 4294967294;
         curChapterId$field = new int();
      }
      
      public function get hasCurChapterId() : Boolean
      {
         return (hasField$0 & 1) != 0;
      }
      
      public function set curChapterId(param1:int) : void
      {
         hasField$0 |= 1;
         curChapterId$field = param1;
      }
      
      public function get curChapterId() : int
      {
         return curChapterId$field;
      }
      
      public function removeCurNodeId() : void
      {
         hasField$0 &= 4294967293;
         curNodeId$field = new int();
      }
      
      public function get hasCurNodeId() : Boolean
      {
         return (hasField$0 & 2) != 0;
      }
      
      public function set curNodeId(param1:int) : void
      {
         hasField$0 |= 2;
         curNodeId$field = param1;
      }
      
      public function get curNodeId() : int
      {
         return curNodeId$field;
      }
      
      public function removePassChapterId() : void
      {
         hasField$0 &= 4294967291;
         passChapterId$field = new int();
      }
      
      public function get hasPassChapterId() : Boolean
      {
         return (hasField$0 & 4) != 0;
      }
      
      public function set passChapterId(param1:int) : void
      {
         hasField$0 |= 4;
         passChapterId$field = param1;
      }
      
      public function get passChapterId() : int
      {
         return passChapterId$field;
      }
      
      public function removePassNodeId() : void
      {
         hasField$0 &= 4294967287;
         passNodeId$field = new int();
      }
      
      public function get hasPassNodeId() : Boolean
      {
         return (hasField$0 & 8) != 0;
      }
      
      public function set passNodeId(param1:int) : void
      {
         hasField$0 |= 8;
         passNodeId$field = param1;
      }
      
      public function get passNodeId() : int
      {
         return passNodeId$field;
      }
      
      public function removeIsNodeSwitch() : void
      {
         hasField$0 &= 4294967279;
         isNodeSwitch$field = new Boolean();
      }
      
      public function get hasIsNodeSwitch() : Boolean
      {
         return (hasField$0 & 0x10) != 0;
      }
      
      public function set isNodeSwitch(param1:Boolean) : void
      {
         hasField$0 |= 16;
         isNodeSwitch$field = param1;
      }
      
      public function get isNodeSwitch() : Boolean
      {
         return isNodeSwitch$field;
      }
      
      public function removeIsEditSwitch() : void
      {
         hasField$0 &= 4294967263;
         isEditSwitch$field = new Boolean();
      }
      
      public function get hasIsEditSwitch() : Boolean
      {
         return (hasField$0 & 0x20) != 0;
      }
      
      public function set isEditSwitch(param1:Boolean) : void
      {
         hasField$0 |= 32;
         isEditSwitch$field = param1;
      }
      
      public function get isEditSwitch() : Boolean
      {
         return isEditSwitch$field;
      }
      
      public function removeFastTotalCount() : void
      {
         hasField$0 &= 4294967231;
         fastTotalCount$field = new int();
      }
      
      public function get hasFastTotalCount() : Boolean
      {
         return (hasField$0 & 0x40) != 0;
      }
      
      public function set fastTotalCount(param1:int) : void
      {
         hasField$0 |= 64;
         fastTotalCount$field = param1;
      }
      
      public function get fastTotalCount() : int
      {
         return fastTotalCount$field;
      }
      
      public function removeFastUseCount() : void
      {
         hasField$0 &= 4294967167;
         fastUseCount$field = new int();
      }
      
      public function get hasFastUseCount() : Boolean
      {
         return (hasField$0 & 0x80) != 0;
      }
      
      public function set fastUseCount(param1:int) : void
      {
         hasField$0 |= 128;
         fastUseCount$field = param1;
      }
      
      public function get fastUseCount() : int
      {
         return fastUseCount$field;
      }
      
      public function removeBossCount() : void
      {
         hasField$0 &= 4294967039;
         bossCount$field = new int();
      }
      
      public function get hasBossCount() : Boolean
      {
         return (hasField$0 & 0x0100) != 0;
      }
      
      public function set bossCount(param1:int) : void
      {
         hasField$0 |= 256;
         bossCount$field = param1;
      }
      
      public function get bossCount() : int
      {
         return bossCount$field;
      }
      
      final override public function writeToBuffer(param1:WritingBuffer) : void
      {
         if(hasCurChapterId)
         {
            WriteUtils.writeTag(param1,0,1);
            WriteUtils.write$TYPE_INT32(param1,curChapterId$field);
         }
         if(hasCurNodeId)
         {
            WriteUtils.writeTag(param1,0,2);
            WriteUtils.write$TYPE_INT32(param1,curNodeId$field);
         }
         if(hasPassChapterId)
         {
            WriteUtils.writeTag(param1,0,3);
            WriteUtils.write$TYPE_INT32(param1,passChapterId$field);
         }
         if(hasPassNodeId)
         {
            WriteUtils.writeTag(param1,0,4);
            WriteUtils.write$TYPE_INT32(param1,passNodeId$field);
         }
         if(hasIsNodeSwitch)
         {
            WriteUtils.writeTag(param1,0,5);
            WriteUtils.write$TYPE_BOOL(param1,isNodeSwitch$field);
         }
         if(hasIsEditSwitch)
         {
            WriteUtils.writeTag(param1,0,6);
            WriteUtils.write$TYPE_BOOL(param1,isEditSwitch$field);
         }
         if(hasFastTotalCount)
         {
            WriteUtils.writeTag(param1,0,7);
            WriteUtils.write$TYPE_INT32(param1,fastTotalCount$field);
         }
         if(hasFastUseCount)
         {
            WriteUtils.writeTag(param1,0,8);
            WriteUtils.write$TYPE_INT32(param1,fastUseCount$field);
         }
         if(hasBossCount)
         {
            WriteUtils.writeTag(param1,0,9);
            WriteUtils.write$TYPE_INT32(param1,bossCount$field);
         }
      }
      
      final override public function readFromSlice(param1:IDataInput, param2:uint) : void
      {
         var _loc9_:* = 0;
         var _loc4_:uint = 0;
         var _loc10_:uint = 0;
         var _loc7_:uint = 0;
         var _loc12_:uint = 0;
         var _loc3_:uint = 0;
         var _loc11_:uint = 0;
         var _loc6_:uint = 0;
         var _loc5_:uint = 0;
         var _loc8_:uint = 0;
         while(param1.bytesAvailable > param2)
         {
            switch(((_loc9_ = ReadUtils.read$TYPE_UINT32(param1)) >>> 3) - 1)
            {
               case 0:
                  if(_loc4_ != 0)
                  {
                     throw new IOError("Bad data format: MonsterExploreUserMsg.curChapterId cannot be set twice.");
                  }
                  _loc4_++;
                  curChapterId = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 1:
                  if(_loc10_ != 0)
                  {
                     throw new IOError("Bad data format: MonsterExploreUserMsg.curNodeId cannot be set twice.");
                  }
                  _loc10_++;
                  curNodeId = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 2:
                  if(_loc7_ != 0)
                  {
                     throw new IOError("Bad data format: MonsterExploreUserMsg.passChapterId cannot be set twice.");
                  }
                  _loc7_++;
                  passChapterId = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 3:
                  if(_loc12_ != 0)
                  {
                     throw new IOError("Bad data format: MonsterExploreUserMsg.passNodeId cannot be set twice.");
                  }
                  _loc12_++;
                  passNodeId = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 4:
                  if(_loc3_ != 0)
                  {
                     throw new IOError("Bad data format: MonsterExploreUserMsg.isNodeSwitch cannot be set twice.");
                  }
                  _loc3_++;
                  isNodeSwitch = ReadUtils.read$TYPE_BOOL(param1);
                  break;
               case 5:
                  if(_loc11_ != 0)
                  {
                     throw new IOError("Bad data format: MonsterExploreUserMsg.isEditSwitch cannot be set twice.");
                  }
                  _loc11_++;
                  isEditSwitch = ReadUtils.read$TYPE_BOOL(param1);
                  break;
               case 6:
                  if(_loc6_ != 0)
                  {
                     throw new IOError("Bad data format: MonsterExploreUserMsg.fastTotalCount cannot be set twice.");
                  }
                  _loc6_++;
                  fastTotalCount = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 7:
                  if(_loc5_ != 0)
                  {
                     throw new IOError("Bad data format: MonsterExploreUserMsg.fastUseCount cannot be set twice.");
                  }
                  _loc5_++;
                  fastUseCount = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 8:
                  if(_loc8_ != 0)
                  {
                     throw new IOError("Bad data format: MonsterExploreUserMsg.bossCount cannot be set twice.");
                  }
                  _loc8_++;
                  bossCount = ReadUtils.read$TYPE_INT32(param1);
                  break;
               default:
                  ReadUtils.skip(param1,_loc9_ & 7);
            }
         }
      }
   }
}

