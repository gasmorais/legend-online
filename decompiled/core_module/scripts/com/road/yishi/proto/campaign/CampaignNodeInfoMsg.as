package com.road.yishi.proto.campaign
{
   import com.netease.protobuf.*;
   import flash.errors.IOError;
   import flash.utils.IDataInput;
   import flash.utils.IExternalizable;
   
   public final class CampaignNodeInfoMsg extends Message implements IExternalizable
   {
      
      private var type$field:int;
      
      private var hasField$0:uint = 0;
      
      private var normal_times$field:int;
      
      private var magic_times$field:int;
      
      private var slot_machine_times$field:int;
      
      private var is_mail$field:Boolean;
      
      [ArrayElementType("com.road.yishi.proto.campaign.TempMsg")]
      public var nodeInfo:Array = [];
      
      private var gameType$field:int;
      
      public function CampaignNodeInfoMsg()
      {
         super();
      }
      
      public function removeType() : void
      {
         hasField$0 &= 4294967294;
         type$field = new int();
      }
      
      public function get hasType() : Boolean
      {
         return (hasField$0 & 1) != 0;
      }
      
      public function set type(param1:int) : void
      {
         hasField$0 |= 1;
         type$field = param1;
      }
      
      public function get type() : int
      {
         return type$field;
      }
      
      public function removeNormalTimes() : void
      {
         hasField$0 &= 4294967293;
         normal_times$field = new int();
      }
      
      public function get hasNormalTimes() : Boolean
      {
         return (hasField$0 & 2) != 0;
      }
      
      public function set normalTimes(param1:int) : void
      {
         hasField$0 |= 2;
         normal_times$field = param1;
      }
      
      public function get normalTimes() : int
      {
         return normal_times$field;
      }
      
      public function removeMagicTimes() : void
      {
         hasField$0 &= 4294967291;
         magic_times$field = new int();
      }
      
      public function get hasMagicTimes() : Boolean
      {
         return (hasField$0 & 4) != 0;
      }
      
      public function set magicTimes(param1:int) : void
      {
         hasField$0 |= 4;
         magic_times$field = param1;
      }
      
      public function get magicTimes() : int
      {
         return magic_times$field;
      }
      
      public function removeSlotMachineTimes() : void
      {
         hasField$0 &= 4294967287;
         slot_machine_times$field = new int();
      }
      
      public function get hasSlotMachineTimes() : Boolean
      {
         return (hasField$0 & 8) != 0;
      }
      
      public function set slotMachineTimes(param1:int) : void
      {
         hasField$0 |= 8;
         slot_machine_times$field = param1;
      }
      
      public function get slotMachineTimes() : int
      {
         return slot_machine_times$field;
      }
      
      public function removeIsMail() : void
      {
         hasField$0 &= 4294967279;
         is_mail$field = new Boolean();
      }
      
      public function get hasIsMail() : Boolean
      {
         return (hasField$0 & 0x10) != 0;
      }
      
      public function set isMail(param1:Boolean) : void
      {
         hasField$0 |= 16;
         is_mail$field = param1;
      }
      
      public function get isMail() : Boolean
      {
         return is_mail$field;
      }
      
      public function removeGameType() : void
      {
         hasField$0 &= 4294967263;
         gameType$field = new int();
      }
      
      public function get hasGameType() : Boolean
      {
         return (hasField$0 & 0x20) != 0;
      }
      
      public function set gameType(param1:int) : void
      {
         hasField$0 |= 32;
         gameType$field = param1;
      }
      
      public function get gameType() : int
      {
         return gameType$field;
      }
      
      final override public function writeToBuffer(param1:WritingBuffer) : void
      {
         var _loc2_:* = 0;
         if(hasType)
         {
            WriteUtils.writeTag(param1,0,1);
            WriteUtils.write$TYPE_INT32(param1,type$field);
         }
         if(hasNormalTimes)
         {
            WriteUtils.writeTag(param1,0,2);
            WriteUtils.write$TYPE_INT32(param1,normal_times$field);
         }
         if(hasMagicTimes)
         {
            WriteUtils.writeTag(param1,0,3);
            WriteUtils.write$TYPE_INT32(param1,magic_times$field);
         }
         if(hasSlotMachineTimes)
         {
            WriteUtils.writeTag(param1,0,4);
            WriteUtils.write$TYPE_INT32(param1,slot_machine_times$field);
         }
         if(hasIsMail)
         {
            WriteUtils.writeTag(param1,0,5);
            WriteUtils.write$TYPE_BOOL(param1,is_mail$field);
         }
         _loc2_ = 0;
         while(_loc2_ < nodeInfo.length)
         {
            WriteUtils.writeTag(param1,2,6);
            WriteUtils.write$TYPE_MESSAGE(param1,nodeInfo[_loc2_]);
            _loc2_++;
         }
         if(hasGameType)
         {
            WriteUtils.writeTag(param1,0,7);
            WriteUtils.write$TYPE_INT32(param1,gameType$field);
         }
      }
      
      final override public function readFromSlice(param1:IDataInput, param2:uint) : void
      {
         var _loc9_:* = 0;
         var _loc4_:TempMsg = null;
         var _loc8_:uint = 0;
         var _loc6_:uint = 0;
         var _loc3_:uint = 0;
         var _loc10_:uint = 0;
         var _loc7_:uint = 0;
         var _loc5_:uint = 0;
         while(param1.bytesAvailable > param2)
         {
            switch(((_loc9_ = ReadUtils.read$TYPE_UINT32(param1)) >>> 3) - 1)
            {
               case 0:
                  if(_loc8_ != 0)
                  {
                     throw new IOError("Bad data format: CampaignNodeInfoMsg.type cannot be set twice.");
                  }
                  _loc8_++;
                  type = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 1:
                  if(_loc6_ != 0)
                  {
                     throw new IOError("Bad data format: CampaignNodeInfoMsg.normalTimes cannot be set twice.");
                  }
                  _loc6_++;
                  normalTimes = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 2:
                  if(_loc3_ != 0)
                  {
                     throw new IOError("Bad data format: CampaignNodeInfoMsg.magicTimes cannot be set twice.");
                  }
                  _loc3_++;
                  magicTimes = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 3:
                  if(_loc10_ != 0)
                  {
                     throw new IOError("Bad data format: CampaignNodeInfoMsg.slotMachineTimes cannot be set twice.");
                  }
                  _loc10_++;
                  slotMachineTimes = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 4:
                  if(_loc7_ != 0)
                  {
                     throw new IOError("Bad data format: CampaignNodeInfoMsg.isMail cannot be set twice.");
                  }
                  _loc7_++;
                  isMail = ReadUtils.read$TYPE_BOOL(param1);
                  break;
               case 5:
                  _loc4_ = new TempMsg();
                  ReadUtils.read$TYPE_MESSAGE(param1,_loc4_);
                  nodeInfo.push(_loc4_);
                  break;
               case 6:
                  if(_loc5_ != 0)
                  {
                     throw new IOError("Bad data format: CampaignNodeInfoMsg.gameType cannot be set twice.");
                  }
                  _loc5_++;
                  gameType = ReadUtils.read$TYPE_INT32(param1);
                  break;
               default:
                  ReadUtils.skip(param1,_loc9_ & 7);
            }
         }
      }
   }
}

