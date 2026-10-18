package com.road.yishi.proto.pvp
{
   import com.netease.protobuf.Message;
   import com.netease.protobuf.ReadUtils;
   import com.netease.protobuf.WriteUtils;
   import com.netease.protobuf.WritingBuffer;
   import flash.errors.IOError;
   import flash.utils.IDataInput;
   import flash.utils.IExternalizable;
   
   public final class TheseusPvpReportMsg extends Message implements IExternalizable
   {
      
      private var integral$field:int;
      
      private var hasField$0:uint = 0;
      
      private var isWin$field:Boolean;
      
      private var mode$field:int;
      
      private var nickName$field:String;
      
      private var serverName$field:String;
      
      private var job$field:int;
      
      private var fightCapacity$field:int;
      
      private var fightDate$field:String;
      
      public function TheseusPvpReportMsg()
      {
         super();
      }
      
      public function removeIntegral() : void
      {
         hasField$0 &= 4294967294;
         integral$field = new int();
      }
      
      public function get hasIntegral() : Boolean
      {
         return (hasField$0 & 1) != 0;
      }
      
      public function set integral(param1:int) : void
      {
         hasField$0 |= 1;
         integral$field = param1;
      }
      
      public function get integral() : int
      {
         return integral$field;
      }
      
      public function removeIsWin() : void
      {
         hasField$0 &= 4294967293;
         isWin$field = new Boolean();
      }
      
      public function get hasIsWin() : Boolean
      {
         return (hasField$0 & 2) != 0;
      }
      
      public function set isWin(param1:Boolean) : void
      {
         hasField$0 |= 2;
         isWin$field = param1;
      }
      
      public function get isWin() : Boolean
      {
         return isWin$field;
      }
      
      public function removeMode() : void
      {
         hasField$0 &= 4294967291;
         mode$field = new int();
      }
      
      public function get hasMode() : Boolean
      {
         return (hasField$0 & 4) != 0;
      }
      
      public function set mode(param1:int) : void
      {
         hasField$0 |= 4;
         mode$field = param1;
      }
      
      public function get mode() : int
      {
         return mode$field;
      }
      
      public function removeNickName() : void
      {
         nickName$field = null;
      }
      
      public function get hasNickName() : Boolean
      {
         return nickName$field != null;
      }
      
      public function set nickName(param1:String) : void
      {
         nickName$field = param1;
      }
      
      public function get nickName() : String
      {
         return nickName$field;
      }
      
      public function removeServerName() : void
      {
         serverName$field = null;
      }
      
      public function get hasServerName() : Boolean
      {
         return serverName$field != null;
      }
      
      public function set serverName(param1:String) : void
      {
         serverName$field = param1;
      }
      
      public function get serverName() : String
      {
         return serverName$field;
      }
      
      public function removeJob() : void
      {
         hasField$0 &= 4294967287;
         job$field = new int();
      }
      
      public function get hasJob() : Boolean
      {
         return (hasField$0 & 8) != 0;
      }
      
      public function set job(param1:int) : void
      {
         hasField$0 |= 8;
         job$field = param1;
      }
      
      public function get job() : int
      {
         return job$field;
      }
      
      public function removeFightCapacity() : void
      {
         hasField$0 &= 4294967279;
         fightCapacity$field = new int();
      }
      
      public function get hasFightCapacity() : Boolean
      {
         return (hasField$0 & 0x10) != 0;
      }
      
      public function set fightCapacity(param1:int) : void
      {
         hasField$0 |= 16;
         fightCapacity$field = param1;
      }
      
      public function get fightCapacity() : int
      {
         return fightCapacity$field;
      }
      
      public function removeFightDate() : void
      {
         fightDate$field = null;
      }
      
      public function get hasFightDate() : Boolean
      {
         return fightDate$field != null;
      }
      
      public function set fightDate(param1:String) : void
      {
         fightDate$field = param1;
      }
      
      public function get fightDate() : String
      {
         return fightDate$field;
      }
      
      final override public function writeToBuffer(param1:WritingBuffer) : void
      {
         if(hasIntegral)
         {
            WriteUtils.writeTag(param1,0,1);
            WriteUtils.write$TYPE_INT32(param1,integral$field);
         }
         if(hasIsWin)
         {
            WriteUtils.writeTag(param1,0,2);
            WriteUtils.write$TYPE_BOOL(param1,isWin$field);
         }
         if(hasMode)
         {
            WriteUtils.writeTag(param1,0,3);
            WriteUtils.write$TYPE_INT32(param1,mode$field);
         }
         if(hasNickName)
         {
            WriteUtils.writeTag(param1,2,4);
            WriteUtils.write$TYPE_STRING(param1,nickName$field);
         }
         if(hasServerName)
         {
            WriteUtils.writeTag(param1,2,5);
            WriteUtils.write$TYPE_STRING(param1,serverName$field);
         }
         if(hasJob)
         {
            WriteUtils.writeTag(param1,0,6);
            WriteUtils.write$TYPE_INT32(param1,job$field);
         }
         if(hasFightCapacity)
         {
            WriteUtils.writeTag(param1,0,7);
            WriteUtils.write$TYPE_INT32(param1,fightCapacity$field);
         }
         if(hasFightDate)
         {
            WriteUtils.writeTag(param1,2,8);
            WriteUtils.write$TYPE_STRING(param1,fightDate$field);
         }
      }
      
      final override public function readFromSlice(param1:IDataInput, param2:uint) : void
      {
         var _loc9_:* = 0;
         var _loc8_:uint = 0;
         var _loc6_:uint = 0;
         var _loc11_:uint = 0;
         var _loc5_:uint = 0;
         var _loc3_:uint = 0;
         var _loc7_:uint = 0;
         var _loc10_:uint = 0;
         var _loc4_:uint = 0;
         while(param1.bytesAvailable > param2)
         {
            switch(((_loc9_ = ReadUtils.read$TYPE_UINT32(param1)) >>> 3) - 1)
            {
               case 0:
                  if(_loc8_ != 0)
                  {
                     throw new IOError("Bad data format: TheseusPvpReportMsg.integral cannot be set twice.");
                  }
                  _loc8_++;
                  integral = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 1:
                  if(_loc6_ != 0)
                  {
                     throw new IOError("Bad data format: TheseusPvpReportMsg.isWin cannot be set twice.");
                  }
                  _loc6_++;
                  isWin = ReadUtils.read$TYPE_BOOL(param1);
                  break;
               case 2:
                  if(_loc11_ != 0)
                  {
                     throw new IOError("Bad data format: TheseusPvpReportMsg.mode cannot be set twice.");
                  }
                  _loc11_++;
                  mode = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 3:
                  if(_loc5_ != 0)
                  {
                     throw new IOError("Bad data format: TheseusPvpReportMsg.nickName cannot be set twice.");
                  }
                  _loc5_++;
                  nickName = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 4:
                  if(_loc3_ != 0)
                  {
                     throw new IOError("Bad data format: TheseusPvpReportMsg.serverName cannot be set twice.");
                  }
                  _loc3_++;
                  serverName = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 5:
                  if(_loc7_ != 0)
                  {
                     throw new IOError("Bad data format: TheseusPvpReportMsg.job cannot be set twice.");
                  }
                  _loc7_++;
                  job = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 6:
                  if(_loc10_ != 0)
                  {
                     throw new IOError("Bad data format: TheseusPvpReportMsg.fightCapacity cannot be set twice.");
                  }
                  _loc10_++;
                  fightCapacity = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 7:
                  if(_loc4_ != 0)
                  {
                     throw new IOError("Bad data format: TheseusPvpReportMsg.fightDate cannot be set twice.");
                  }
                  _loc4_++;
                  fightDate = ReadUtils.read$TYPE_STRING(param1);
                  break;
               default:
                  ReadUtils.skip(param1,_loc9_ & 7);
            }
         }
      }
   }
}

