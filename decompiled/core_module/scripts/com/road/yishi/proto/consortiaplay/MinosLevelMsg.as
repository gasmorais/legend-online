package com.road.yishi.proto.consortiaplay
{
   import com.netease.protobuf.Message;
   import com.netease.protobuf.ReadUtils;
   import com.netease.protobuf.WriteUtils;
   import com.netease.protobuf.WritingBuffer;
   import flash.errors.IOError;
   import flash.utils.IDataInput;
   import flash.utils.IExternalizable;
   
   public final class MinosLevelMsg extends Message implements IExternalizable
   {
      
      private var id$field:int;
      
      private var hasField$0:uint = 0;
      
      private var progress$field:int;
      
      private var progressMax$field:int;
      
      private var killNpc$field:int;
      
      private var npcMax$field:int;
      
      private var killBoss$field:int;
      
      private var bossMax$field:int;
      
      private var killInfo$field:String;
      
      public function MinosLevelMsg()
      {
         super();
      }
      
      public function removeId() : void
      {
         hasField$0 &= 4294967294;
         id$field = new int();
      }
      
      public function get hasId() : Boolean
      {
         return (hasField$0 & 1) != 0;
      }
      
      public function set id(param1:int) : void
      {
         hasField$0 |= 1;
         id$field = param1;
      }
      
      public function get id() : int
      {
         return id$field;
      }
      
      public function removeProgress() : void
      {
         hasField$0 &= 4294967293;
         progress$field = new int();
      }
      
      public function get hasProgress() : Boolean
      {
         return (hasField$0 & 2) != 0;
      }
      
      public function set progress(param1:int) : void
      {
         hasField$0 |= 2;
         progress$field = param1;
      }
      
      public function get progress() : int
      {
         return progress$field;
      }
      
      public function removeProgressMax() : void
      {
         hasField$0 &= 4294967291;
         progressMax$field = new int();
      }
      
      public function get hasProgressMax() : Boolean
      {
         return (hasField$0 & 4) != 0;
      }
      
      public function set progressMax(param1:int) : void
      {
         hasField$0 |= 4;
         progressMax$field = param1;
      }
      
      public function get progressMax() : int
      {
         return progressMax$field;
      }
      
      public function removeKillNpc() : void
      {
         hasField$0 &= 4294967287;
         killNpc$field = new int();
      }
      
      public function get hasKillNpc() : Boolean
      {
         return (hasField$0 & 8) != 0;
      }
      
      public function set killNpc(param1:int) : void
      {
         hasField$0 |= 8;
         killNpc$field = param1;
      }
      
      public function get killNpc() : int
      {
         return killNpc$field;
      }
      
      public function removeNpcMax() : void
      {
         hasField$0 &= 4294967279;
         npcMax$field = new int();
      }
      
      public function get hasNpcMax() : Boolean
      {
         return (hasField$0 & 0x10) != 0;
      }
      
      public function set npcMax(param1:int) : void
      {
         hasField$0 |= 16;
         npcMax$field = param1;
      }
      
      public function get npcMax() : int
      {
         return npcMax$field;
      }
      
      public function removeKillBoss() : void
      {
         hasField$0 &= 4294967263;
         killBoss$field = new int();
      }
      
      public function get hasKillBoss() : Boolean
      {
         return (hasField$0 & 0x20) != 0;
      }
      
      public function set killBoss(param1:int) : void
      {
         hasField$0 |= 32;
         killBoss$field = param1;
      }
      
      public function get killBoss() : int
      {
         return killBoss$field;
      }
      
      public function removeBossMax() : void
      {
         hasField$0 &= 4294967231;
         bossMax$field = new int();
      }
      
      public function get hasBossMax() : Boolean
      {
         return (hasField$0 & 0x40) != 0;
      }
      
      public function set bossMax(param1:int) : void
      {
         hasField$0 |= 64;
         bossMax$field = param1;
      }
      
      public function get bossMax() : int
      {
         return bossMax$field;
      }
      
      public function removeKillInfo() : void
      {
         killInfo$field = null;
      }
      
      public function get hasKillInfo() : Boolean
      {
         return killInfo$field != null;
      }
      
      public function set killInfo(param1:String) : void
      {
         killInfo$field = param1;
      }
      
      public function get killInfo() : String
      {
         return killInfo$field;
      }
      
      final override public function writeToBuffer(param1:WritingBuffer) : void
      {
         if(hasId)
         {
            WriteUtils.writeTag(param1,0,1);
            WriteUtils.write$TYPE_INT32(param1,id$field);
         }
         if(hasProgress)
         {
            WriteUtils.writeTag(param1,0,2);
            WriteUtils.write$TYPE_INT32(param1,progress$field);
         }
         if(hasProgressMax)
         {
            WriteUtils.writeTag(param1,0,3);
            WriteUtils.write$TYPE_INT32(param1,progressMax$field);
         }
         if(hasKillNpc)
         {
            WriteUtils.writeTag(param1,0,4);
            WriteUtils.write$TYPE_INT32(param1,killNpc$field);
         }
         if(hasNpcMax)
         {
            WriteUtils.writeTag(param1,0,5);
            WriteUtils.write$TYPE_INT32(param1,npcMax$field);
         }
         if(hasKillBoss)
         {
            WriteUtils.writeTag(param1,0,6);
            WriteUtils.write$TYPE_INT32(param1,killBoss$field);
         }
         if(hasBossMax)
         {
            WriteUtils.writeTag(param1,0,7);
            WriteUtils.write$TYPE_INT32(param1,bossMax$field);
         }
         if(hasKillInfo)
         {
            WriteUtils.writeTag(param1,2,8);
            WriteUtils.write$TYPE_STRING(param1,killInfo$field);
         }
      }
      
      final override public function readFromSlice(param1:IDataInput, param2:uint) : void
      {
         var _loc8_:* = 0;
         var _loc7_:uint = 0;
         var _loc4_:uint = 0;
         var _loc6_:uint = 0;
         var _loc10_:uint = 0;
         var _loc9_:uint = 0;
         var _loc5_:uint = 0;
         var _loc3_:uint = 0;
         var _loc11_:uint = 0;
         while(param1.bytesAvailable > param2)
         {
            switch(((_loc8_ = ReadUtils.read$TYPE_UINT32(param1)) >>> 3) - 1)
            {
               case 0:
                  if(_loc7_ != 0)
                  {
                     throw new IOError("Bad data format: MinosLevelMsg.id cannot be set twice.");
                  }
                  _loc7_++;
                  id = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 1:
                  if(_loc4_ != 0)
                  {
                     throw new IOError("Bad data format: MinosLevelMsg.progress cannot be set twice.");
                  }
                  _loc4_++;
                  progress = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 2:
                  if(_loc6_ != 0)
                  {
                     throw new IOError("Bad data format: MinosLevelMsg.progressMax cannot be set twice.");
                  }
                  _loc6_++;
                  progressMax = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 3:
                  if(_loc10_ != 0)
                  {
                     throw new IOError("Bad data format: MinosLevelMsg.killNpc cannot be set twice.");
                  }
                  _loc10_++;
                  killNpc = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 4:
                  if(_loc9_ != 0)
                  {
                     throw new IOError("Bad data format: MinosLevelMsg.npcMax cannot be set twice.");
                  }
                  _loc9_++;
                  npcMax = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 5:
                  if(_loc5_ != 0)
                  {
                     throw new IOError("Bad data format: MinosLevelMsg.killBoss cannot be set twice.");
                  }
                  _loc5_++;
                  killBoss = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 6:
                  if(_loc3_ != 0)
                  {
                     throw new IOError("Bad data format: MinosLevelMsg.bossMax cannot be set twice.");
                  }
                  _loc3_++;
                  bossMax = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 7:
                  if(_loc11_ != 0)
                  {
                     throw new IOError("Bad data format: MinosLevelMsg.killInfo cannot be set twice.");
                  }
                  _loc11_++;
                  killInfo = ReadUtils.read$TYPE_STRING(param1);
                  break;
               default:
                  ReadUtils.skip(param1,_loc8_ & 7);
            }
         }
      }
   }
}

