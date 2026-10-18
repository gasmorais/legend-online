package com.road.yishi.proto.children
{
   import com.netease.protobuf.Message;
   import com.netease.protobuf.ReadUtils;
   import com.netease.protobuf.WriteUtils;
   import com.netease.protobuf.WritingBuffer;
   import flash.errors.IOError;
   import flash.utils.IDataInput;
   import flash.utils.IExternalizable;
   
   public final class SpiritTrainInfoMsg extends Message implements IExternalizable
   {
      
      private var trainGrade$field:int;
      
      private var hasField$0:uint = 0;
      
      private var stageGrade$field:int;
      
      private var liveGrade$field:int;
      
      private var attackGrade$field:int;
      
      private var phyDefenceGrade$field:int;
      
      private var magDefenceGrade$field:int;
      
      private var trainPoint$field:int;
      
      private var skillEnchants$field:String;
      
      public function SpiritTrainInfoMsg()
      {
         super();
      }
      
      public function removeTrainGrade() : void
      {
         hasField$0 &= 4294967294;
         trainGrade$field = new int();
      }
      
      public function get hasTrainGrade() : Boolean
      {
         return (hasField$0 & 1) != 0;
      }
      
      public function set trainGrade(param1:int) : void
      {
         hasField$0 |= 1;
         trainGrade$field = param1;
      }
      
      public function get trainGrade() : int
      {
         return trainGrade$field;
      }
      
      public function removeStageGrade() : void
      {
         hasField$0 &= 4294967293;
         stageGrade$field = new int();
      }
      
      public function get hasStageGrade() : Boolean
      {
         return (hasField$0 & 2) != 0;
      }
      
      public function set stageGrade(param1:int) : void
      {
         hasField$0 |= 2;
         stageGrade$field = param1;
      }
      
      public function get stageGrade() : int
      {
         return stageGrade$field;
      }
      
      public function removeLiveGrade() : void
      {
         hasField$0 &= 4294967291;
         liveGrade$field = new int();
      }
      
      public function get hasLiveGrade() : Boolean
      {
         return (hasField$0 & 4) != 0;
      }
      
      public function set liveGrade(param1:int) : void
      {
         hasField$0 |= 4;
         liveGrade$field = param1;
      }
      
      public function get liveGrade() : int
      {
         return liveGrade$field;
      }
      
      public function removeAttackGrade() : void
      {
         hasField$0 &= 4294967287;
         attackGrade$field = new int();
      }
      
      public function get hasAttackGrade() : Boolean
      {
         return (hasField$0 & 8) != 0;
      }
      
      public function set attackGrade(param1:int) : void
      {
         hasField$0 |= 8;
         attackGrade$field = param1;
      }
      
      public function get attackGrade() : int
      {
         return attackGrade$field;
      }
      
      public function removePhyDefenceGrade() : void
      {
         hasField$0 &= 4294967279;
         phyDefenceGrade$field = new int();
      }
      
      public function get hasPhyDefenceGrade() : Boolean
      {
         return (hasField$0 & 0x10) != 0;
      }
      
      public function set phyDefenceGrade(param1:int) : void
      {
         hasField$0 |= 16;
         phyDefenceGrade$field = param1;
      }
      
      public function get phyDefenceGrade() : int
      {
         return phyDefenceGrade$field;
      }
      
      public function removeMagDefenceGrade() : void
      {
         hasField$0 &= 4294967263;
         magDefenceGrade$field = new int();
      }
      
      public function get hasMagDefenceGrade() : Boolean
      {
         return (hasField$0 & 0x20) != 0;
      }
      
      public function set magDefenceGrade(param1:int) : void
      {
         hasField$0 |= 32;
         magDefenceGrade$field = param1;
      }
      
      public function get magDefenceGrade() : int
      {
         return magDefenceGrade$field;
      }
      
      public function removeTrainPoint() : void
      {
         hasField$0 &= 4294967231;
         trainPoint$field = new int();
      }
      
      public function get hasTrainPoint() : Boolean
      {
         return (hasField$0 & 0x40) != 0;
      }
      
      public function set trainPoint(param1:int) : void
      {
         hasField$0 |= 64;
         trainPoint$field = param1;
      }
      
      public function get trainPoint() : int
      {
         return trainPoint$field;
      }
      
      public function removeSkillEnchants() : void
      {
         skillEnchants$field = null;
      }
      
      public function get hasSkillEnchants() : Boolean
      {
         return skillEnchants$field != null;
      }
      
      public function set skillEnchants(param1:String) : void
      {
         skillEnchants$field = param1;
      }
      
      public function get skillEnchants() : String
      {
         return skillEnchants$field;
      }
      
      final override public function writeToBuffer(param1:WritingBuffer) : void
      {
         if(hasTrainGrade)
         {
            WriteUtils.writeTag(param1,0,1);
            WriteUtils.write$TYPE_INT32(param1,trainGrade$field);
         }
         if(hasStageGrade)
         {
            WriteUtils.writeTag(param1,0,2);
            WriteUtils.write$TYPE_INT32(param1,stageGrade$field);
         }
         if(hasLiveGrade)
         {
            WriteUtils.writeTag(param1,0,3);
            WriteUtils.write$TYPE_INT32(param1,liveGrade$field);
         }
         if(hasAttackGrade)
         {
            WriteUtils.writeTag(param1,0,4);
            WriteUtils.write$TYPE_INT32(param1,attackGrade$field);
         }
         if(hasPhyDefenceGrade)
         {
            WriteUtils.writeTag(param1,0,5);
            WriteUtils.write$TYPE_INT32(param1,phyDefenceGrade$field);
         }
         if(hasMagDefenceGrade)
         {
            WriteUtils.writeTag(param1,0,6);
            WriteUtils.write$TYPE_INT32(param1,magDefenceGrade$field);
         }
         if(hasTrainPoint)
         {
            WriteUtils.writeTag(param1,0,7);
            WriteUtils.write$TYPE_INT32(param1,trainPoint$field);
         }
         if(hasSkillEnchants)
         {
            WriteUtils.writeTag(param1,2,8);
            WriteUtils.write$TYPE_STRING(param1,skillEnchants$field);
         }
      }
      
      final override public function readFromSlice(param1:IDataInput, param2:uint) : void
      {
         var _loc9_:* = 0;
         var _loc3_:uint = 0;
         var _loc11_:uint = 0;
         var _loc4_:uint = 0;
         var _loc10_:uint = 0;
         var _loc5_:uint = 0;
         var _loc6_:uint = 0;
         var _loc7_:uint = 0;
         var _loc8_:uint = 0;
         while(param1.bytesAvailable > param2)
         {
            switch(((_loc9_ = ReadUtils.read$TYPE_UINT32(param1)) >>> 3) - 1)
            {
               case 0:
                  if(_loc3_ != 0)
                  {
                     throw new IOError("Bad data format: SpiritTrainInfoMsg.trainGrade cannot be set twice.");
                  }
                  _loc3_++;
                  trainGrade = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 1:
                  if(_loc11_ != 0)
                  {
                     throw new IOError("Bad data format: SpiritTrainInfoMsg.stageGrade cannot be set twice.");
                  }
                  _loc11_++;
                  stageGrade = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 2:
                  if(_loc4_ != 0)
                  {
                     throw new IOError("Bad data format: SpiritTrainInfoMsg.liveGrade cannot be set twice.");
                  }
                  _loc4_++;
                  liveGrade = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 3:
                  if(_loc10_ != 0)
                  {
                     throw new IOError("Bad data format: SpiritTrainInfoMsg.attackGrade cannot be set twice.");
                  }
                  _loc10_++;
                  attackGrade = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 4:
                  if(_loc5_ != 0)
                  {
                     throw new IOError("Bad data format: SpiritTrainInfoMsg.phyDefenceGrade cannot be set twice.");
                  }
                  _loc5_++;
                  phyDefenceGrade = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 5:
                  if(_loc6_ != 0)
                  {
                     throw new IOError("Bad data format: SpiritTrainInfoMsg.magDefenceGrade cannot be set twice.");
                  }
                  _loc6_++;
                  magDefenceGrade = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 6:
                  if(_loc7_ != 0)
                  {
                     throw new IOError("Bad data format: SpiritTrainInfoMsg.trainPoint cannot be set twice.");
                  }
                  _loc7_++;
                  trainPoint = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 7:
                  if(_loc8_ != 0)
                  {
                     throw new IOError("Bad data format: SpiritTrainInfoMsg.skillEnchants cannot be set twice.");
                  }
                  _loc8_++;
                  skillEnchants = ReadUtils.read$TYPE_STRING(param1);
                  break;
               default:
                  ReadUtils.skip(param1,_loc9_ & 7);
            }
         }
      }
   }
}

