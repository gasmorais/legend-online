package com.road.yishi.proto.consortiawar
{
   import com.netease.protobuf.Message;
   import com.netease.protobuf.ReadUtils;
   import com.netease.protobuf.WriteUtils;
   import com.netease.protobuf.WritingBuffer;
   import flash.errors.IOError;
   import flash.utils.IDataInput;
   import flash.utils.IExternalizable;
   
   public final class ConsortiaWarSeasonMsg extends Message implements IExternalizable
   {
      
      private var opType$field:int;
      
      private var hasField$0:uint = 0;
      
      private var seasonId$field:int;
      
      private var seasonStartTime$field:String;
      
      private var seasonStopTime$field:String;
      
      private var signStartTime$field:String;
      
      private var signStopTime$field:String;
      
      private var state$field:int;
      
      private var startTime$field:String;
      
      private var stopTime$field:String;
      
      private var fightIndex$field:int;
      
      private var signType$field:int;
      
      private var first$field:ConsortiaWarScoreInfoMsg;
      
      private var buffEndTime$field:String;
      
      private var isBye$field:Boolean;
      
      private var isValid$field:Boolean;
      
      public function ConsortiaWarSeasonMsg()
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
      
      public function removeSeasonId() : void
      {
         hasField$0 &= 4294967293;
         seasonId$field = new int();
      }
      
      public function get hasSeasonId() : Boolean
      {
         return (hasField$0 & 2) != 0;
      }
      
      public function set seasonId(param1:int) : void
      {
         hasField$0 |= 2;
         seasonId$field = param1;
      }
      
      public function get seasonId() : int
      {
         return seasonId$field;
      }
      
      public function removeSeasonStartTime() : void
      {
         seasonStartTime$field = null;
      }
      
      public function get hasSeasonStartTime() : Boolean
      {
         return seasonStartTime$field != null;
      }
      
      public function set seasonStartTime(param1:String) : void
      {
         seasonStartTime$field = param1;
      }
      
      public function get seasonStartTime() : String
      {
         return seasonStartTime$field;
      }
      
      public function removeSeasonStopTime() : void
      {
         seasonStopTime$field = null;
      }
      
      public function get hasSeasonStopTime() : Boolean
      {
         return seasonStopTime$field != null;
      }
      
      public function set seasonStopTime(param1:String) : void
      {
         seasonStopTime$field = param1;
      }
      
      public function get seasonStopTime() : String
      {
         return seasonStopTime$field;
      }
      
      public function removeSignStartTime() : void
      {
         signStartTime$field = null;
      }
      
      public function get hasSignStartTime() : Boolean
      {
         return signStartTime$field != null;
      }
      
      public function set signStartTime(param1:String) : void
      {
         signStartTime$field = param1;
      }
      
      public function get signStartTime() : String
      {
         return signStartTime$field;
      }
      
      public function removeSignStopTime() : void
      {
         signStopTime$field = null;
      }
      
      public function get hasSignStopTime() : Boolean
      {
         return signStopTime$field != null;
      }
      
      public function set signStopTime(param1:String) : void
      {
         signStopTime$field = param1;
      }
      
      public function get signStopTime() : String
      {
         return signStopTime$field;
      }
      
      public function removeState() : void
      {
         hasField$0 &= 4294967291;
         state$field = new int();
      }
      
      public function get hasState() : Boolean
      {
         return (hasField$0 & 4) != 0;
      }
      
      public function set state(param1:int) : void
      {
         hasField$0 |= 4;
         state$field = param1;
      }
      
      public function get state() : int
      {
         return state$field;
      }
      
      public function removeStartTime() : void
      {
         startTime$field = null;
      }
      
      public function get hasStartTime() : Boolean
      {
         return startTime$field != null;
      }
      
      public function set startTime(param1:String) : void
      {
         startTime$field = param1;
      }
      
      public function get startTime() : String
      {
         return startTime$field;
      }
      
      public function removeStopTime() : void
      {
         stopTime$field = null;
      }
      
      public function get hasStopTime() : Boolean
      {
         return stopTime$field != null;
      }
      
      public function set stopTime(param1:String) : void
      {
         stopTime$field = param1;
      }
      
      public function get stopTime() : String
      {
         return stopTime$field;
      }
      
      public function removeFightIndex() : void
      {
         hasField$0 &= 4294967287;
         fightIndex$field = new int();
      }
      
      public function get hasFightIndex() : Boolean
      {
         return (hasField$0 & 8) != 0;
      }
      
      public function set fightIndex(param1:int) : void
      {
         hasField$0 |= 8;
         fightIndex$field = param1;
      }
      
      public function get fightIndex() : int
      {
         return fightIndex$field;
      }
      
      public function removeSignType() : void
      {
         hasField$0 &= 4294967279;
         signType$field = new int();
      }
      
      public function get hasSignType() : Boolean
      {
         return (hasField$0 & 0x10) != 0;
      }
      
      public function set signType(param1:int) : void
      {
         hasField$0 |= 16;
         signType$field = param1;
      }
      
      public function get signType() : int
      {
         return signType$field;
      }
      
      public function removeFirst() : void
      {
         first$field = null;
      }
      
      public function get hasFirst() : Boolean
      {
         return first$field != null;
      }
      
      public function set first(param1:ConsortiaWarScoreInfoMsg) : void
      {
         first$field = param1;
      }
      
      public function get first() : ConsortiaWarScoreInfoMsg
      {
         return first$field;
      }
      
      public function removeBuffEndTime() : void
      {
         buffEndTime$field = null;
      }
      
      public function get hasBuffEndTime() : Boolean
      {
         return buffEndTime$field != null;
      }
      
      public function set buffEndTime(param1:String) : void
      {
         buffEndTime$field = param1;
      }
      
      public function get buffEndTime() : String
      {
         return buffEndTime$field;
      }
      
      public function removeIsBye() : void
      {
         hasField$0 &= 4294967263;
         isBye$field = new Boolean();
      }
      
      public function get hasIsBye() : Boolean
      {
         return (hasField$0 & 0x20) != 0;
      }
      
      public function set isBye(param1:Boolean) : void
      {
         hasField$0 |= 32;
         isBye$field = param1;
      }
      
      public function get isBye() : Boolean
      {
         return isBye$field;
      }
      
      public function removeIsValid() : void
      {
         hasField$0 &= 4294967231;
         isValid$field = new Boolean();
      }
      
      public function get hasIsValid() : Boolean
      {
         return (hasField$0 & 0x40) != 0;
      }
      
      public function set isValid(param1:Boolean) : void
      {
         hasField$0 |= 64;
         isValid$field = param1;
      }
      
      public function get isValid() : Boolean
      {
         return isValid$field;
      }
      
      final override public function writeToBuffer(param1:WritingBuffer) : void
      {
         if(hasOpType)
         {
            WriteUtils.writeTag(param1,0,1);
            WriteUtils.write$TYPE_INT32(param1,opType$field);
         }
         if(hasSeasonId)
         {
            WriteUtils.writeTag(param1,0,2);
            WriteUtils.write$TYPE_INT32(param1,seasonId$field);
         }
         if(hasSeasonStartTime)
         {
            WriteUtils.writeTag(param1,2,3);
            WriteUtils.write$TYPE_STRING(param1,seasonStartTime$field);
         }
         if(hasSeasonStopTime)
         {
            WriteUtils.writeTag(param1,2,4);
            WriteUtils.write$TYPE_STRING(param1,seasonStopTime$field);
         }
         if(hasSignStartTime)
         {
            WriteUtils.writeTag(param1,2,5);
            WriteUtils.write$TYPE_STRING(param1,signStartTime$field);
         }
         if(hasSignStopTime)
         {
            WriteUtils.writeTag(param1,2,6);
            WriteUtils.write$TYPE_STRING(param1,signStopTime$field);
         }
         if(hasState)
         {
            WriteUtils.writeTag(param1,0,7);
            WriteUtils.write$TYPE_INT32(param1,state$field);
         }
         if(hasStartTime)
         {
            WriteUtils.writeTag(param1,2,8);
            WriteUtils.write$TYPE_STRING(param1,startTime$field);
         }
         if(hasStopTime)
         {
            WriteUtils.writeTag(param1,2,9);
            WriteUtils.write$TYPE_STRING(param1,stopTime$field);
         }
         if(hasFightIndex)
         {
            WriteUtils.writeTag(param1,0,10);
            WriteUtils.write$TYPE_INT32(param1,fightIndex$field);
         }
         if(hasSignType)
         {
            WriteUtils.writeTag(param1,0,11);
            WriteUtils.write$TYPE_INT32(param1,signType$field);
         }
         if(hasFirst)
         {
            WriteUtils.writeTag(param1,2,12);
            WriteUtils.write$TYPE_MESSAGE(param1,first$field);
         }
         if(hasBuffEndTime)
         {
            WriteUtils.writeTag(param1,2,13);
            WriteUtils.write$TYPE_STRING(param1,buffEndTime$field);
         }
         if(hasIsBye)
         {
            WriteUtils.writeTag(param1,0,14);
            WriteUtils.write$TYPE_BOOL(param1,isBye$field);
         }
         if(hasIsValid)
         {
            WriteUtils.writeTag(param1,0,15);
            WriteUtils.write$TYPE_BOOL(param1,isValid$field);
         }
      }
      
      final override public function readFromSlice(param1:IDataInput, param2:uint) : void
      {
         var _loc15_:* = 0;
         var _loc13_:uint = 0;
         var _loc10_:uint = 0;
         var _loc3_:uint = 0;
         var _loc6_:uint = 0;
         var _loc17_:uint = 0;
         var _loc7_:uint = 0;
         var _loc14_:uint = 0;
         var _loc12_:uint = 0;
         var _loc11_:uint = 0;
         var _loc4_:uint = 0;
         var _loc18_:uint = 0;
         var _loc16_:uint = 0;
         var _loc8_:uint = 0;
         var _loc5_:uint = 0;
         var _loc9_:uint = 0;
         while(param1.bytesAvailable > param2)
         {
            switch(((_loc15_ = ReadUtils.read$TYPE_UINT32(param1)) >>> 3) - 1)
            {
               case 0:
                  if(_loc13_ != 0)
                  {
                     throw new IOError("Bad data format: ConsortiaWarSeasonMsg.opType cannot be set twice.");
                  }
                  _loc13_++;
                  opType = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 1:
                  if(_loc10_ != 0)
                  {
                     throw new IOError("Bad data format: ConsortiaWarSeasonMsg.seasonId cannot be set twice.");
                  }
                  _loc10_++;
                  seasonId = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 2:
                  if(_loc3_ != 0)
                  {
                     throw new IOError("Bad data format: ConsortiaWarSeasonMsg.seasonStartTime cannot be set twice.");
                  }
                  _loc3_++;
                  seasonStartTime = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 3:
                  if(_loc6_ != 0)
                  {
                     throw new IOError("Bad data format: ConsortiaWarSeasonMsg.seasonStopTime cannot be set twice.");
                  }
                  _loc6_++;
                  seasonStopTime = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 4:
                  if(_loc17_ != 0)
                  {
                     throw new IOError("Bad data format: ConsortiaWarSeasonMsg.signStartTime cannot be set twice.");
                  }
                  _loc17_++;
                  signStartTime = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 5:
                  if(_loc7_ != 0)
                  {
                     throw new IOError("Bad data format: ConsortiaWarSeasonMsg.signStopTime cannot be set twice.");
                  }
                  _loc7_++;
                  signStopTime = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 6:
                  if(_loc14_ != 0)
                  {
                     throw new IOError("Bad data format: ConsortiaWarSeasonMsg.state cannot be set twice.");
                  }
                  _loc14_++;
                  state = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 7:
                  if(_loc12_ != 0)
                  {
                     throw new IOError("Bad data format: ConsortiaWarSeasonMsg.startTime cannot be set twice.");
                  }
                  _loc12_++;
                  startTime = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 8:
                  if(_loc11_ != 0)
                  {
                     throw new IOError("Bad data format: ConsortiaWarSeasonMsg.stopTime cannot be set twice.");
                  }
                  _loc11_++;
                  stopTime = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 9:
                  if(_loc4_ != 0)
                  {
                     throw new IOError("Bad data format: ConsortiaWarSeasonMsg.fightIndex cannot be set twice.");
                  }
                  _loc4_++;
                  fightIndex = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 10:
                  if(_loc18_ != 0)
                  {
                     throw new IOError("Bad data format: ConsortiaWarSeasonMsg.signType cannot be set twice.");
                  }
                  _loc18_++;
                  signType = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 11:
                  if(_loc16_ != 0)
                  {
                     throw new IOError("Bad data format: ConsortiaWarSeasonMsg.first cannot be set twice.");
                  }
                  _loc16_++;
                  first = new ConsortiaWarScoreInfoMsg();
                  ReadUtils.read$TYPE_MESSAGE(param1,first);
                  break;
               case 12:
                  if(_loc8_ != 0)
                  {
                     throw new IOError("Bad data format: ConsortiaWarSeasonMsg.buffEndTime cannot be set twice.");
                  }
                  _loc8_++;
                  buffEndTime = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 13:
                  if(_loc5_ != 0)
                  {
                     throw new IOError("Bad data format: ConsortiaWarSeasonMsg.isBye cannot be set twice.");
                  }
                  _loc5_++;
                  isBye = ReadUtils.read$TYPE_BOOL(param1);
                  break;
               case 14:
                  if(_loc9_ != 0)
                  {
                     throw new IOError("Bad data format: ConsortiaWarSeasonMsg.isValid cannot be set twice.");
                  }
                  _loc9_++;
                  isValid = ReadUtils.read$TYPE_BOOL(param1);
                  break;
               default:
                  ReadUtils.skip(param1,_loc15_ & 7);
            }
         }
      }
   }
}

