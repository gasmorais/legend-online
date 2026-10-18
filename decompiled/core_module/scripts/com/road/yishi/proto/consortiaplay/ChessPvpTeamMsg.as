package com.road.yishi.proto.consortiaplay
{
   import com.netease.protobuf.Message;
   import com.netease.protobuf.ReadUtils;
   import com.netease.protobuf.WriteUtils;
   import com.netease.protobuf.WritingBuffer;
   import flash.errors.IOError;
   import flash.utils.IDataInput;
   import flash.utils.IExternalizable;
   
   public final class ChessPvpTeamMsg extends Message implements IExternalizable
   {
      
      private var team$field:int;
      
      private var hasField$0:uint = 0;
      
      private var name$field:String;
      
      private var serverName$field:String;
      
      private var score$field:int;
      
      private var group$field:int;
      
      private var addScore$field:int;
      
      public function ChessPvpTeamMsg()
      {
         super();
      }
      
      public function removeTeam() : void
      {
         hasField$0 &= 4294967294;
         team$field = new int();
      }
      
      public function get hasTeam() : Boolean
      {
         return (hasField$0 & 1) != 0;
      }
      
      public function set team(param1:int) : void
      {
         hasField$0 |= 1;
         team$field = param1;
      }
      
      public function get team() : int
      {
         return team$field;
      }
      
      public function removeName() : void
      {
         name$field = null;
      }
      
      public function get hasName() : Boolean
      {
         return name$field != null;
      }
      
      public function set name(param1:String) : void
      {
         name$field = param1;
      }
      
      public function get name() : String
      {
         return name$field;
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
      
      public function removeScore() : void
      {
         hasField$0 &= 4294967293;
         score$field = new int();
      }
      
      public function get hasScore() : Boolean
      {
         return (hasField$0 & 2) != 0;
      }
      
      public function set score(param1:int) : void
      {
         hasField$0 |= 2;
         score$field = param1;
      }
      
      public function get score() : int
      {
         return score$field;
      }
      
      public function removeGroup() : void
      {
         hasField$0 &= 4294967291;
         group$field = new int();
      }
      
      public function get hasGroup() : Boolean
      {
         return (hasField$0 & 4) != 0;
      }
      
      public function set group(param1:int) : void
      {
         hasField$0 |= 4;
         group$field = param1;
      }
      
      public function get group() : int
      {
         return group$field;
      }
      
      public function removeAddScore() : void
      {
         hasField$0 &= 4294967287;
         addScore$field = new int();
      }
      
      public function get hasAddScore() : Boolean
      {
         return (hasField$0 & 8) != 0;
      }
      
      public function set addScore(param1:int) : void
      {
         hasField$0 |= 8;
         addScore$field = param1;
      }
      
      public function get addScore() : int
      {
         return addScore$field;
      }
      
      final override public function writeToBuffer(param1:WritingBuffer) : void
      {
         if(hasTeam)
         {
            WriteUtils.writeTag(param1,0,1);
            WriteUtils.write$TYPE_INT32(param1,team$field);
         }
         if(hasName)
         {
            WriteUtils.writeTag(param1,2,2);
            WriteUtils.write$TYPE_STRING(param1,name$field);
         }
         if(hasServerName)
         {
            WriteUtils.writeTag(param1,2,3);
            WriteUtils.write$TYPE_STRING(param1,serverName$field);
         }
         if(hasScore)
         {
            WriteUtils.writeTag(param1,0,4);
            WriteUtils.write$TYPE_INT32(param1,score$field);
         }
         if(hasGroup)
         {
            WriteUtils.writeTag(param1,0,5);
            WriteUtils.write$TYPE_INT32(param1,group$field);
         }
         if(hasAddScore)
         {
            WriteUtils.writeTag(param1,0,6);
            WriteUtils.write$TYPE_INT32(param1,addScore$field);
         }
      }
      
      final override public function readFromSlice(param1:IDataInput, param2:uint) : void
      {
         var _loc7_:* = 0;
         var _loc9_:uint = 0;
         var _loc3_:uint = 0;
         var _loc4_:uint = 0;
         var _loc8_:uint = 0;
         var _loc5_:uint = 0;
         var _loc6_:uint = 0;
         while(param1.bytesAvailable > param2)
         {
            switch(((_loc7_ = ReadUtils.read$TYPE_UINT32(param1)) >>> 3) - 1)
            {
               case 0:
                  if(_loc9_ != 0)
                  {
                     throw new IOError("Bad data format: ChessPvpTeamMsg.team cannot be set twice.");
                  }
                  _loc9_++;
                  team = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 1:
                  if(_loc3_ != 0)
                  {
                     throw new IOError("Bad data format: ChessPvpTeamMsg.name cannot be set twice.");
                  }
                  _loc3_++;
                  name = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 2:
                  if(_loc4_ != 0)
                  {
                     throw new IOError("Bad data format: ChessPvpTeamMsg.serverName cannot be set twice.");
                  }
                  _loc4_++;
                  serverName = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 3:
                  if(_loc8_ != 0)
                  {
                     throw new IOError("Bad data format: ChessPvpTeamMsg.score cannot be set twice.");
                  }
                  _loc8_++;
                  score = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 4:
                  if(_loc5_ != 0)
                  {
                     throw new IOError("Bad data format: ChessPvpTeamMsg.group cannot be set twice.");
                  }
                  _loc5_++;
                  group = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 5:
                  if(_loc6_ != 0)
                  {
                     throw new IOError("Bad data format: ChessPvpTeamMsg.addScore cannot be set twice.");
                  }
                  _loc6_++;
                  addScore = ReadUtils.read$TYPE_INT32(param1);
                  break;
               default:
                  ReadUtils.skip(param1,_loc7_ & 7);
            }
         }
      }
   }
}

