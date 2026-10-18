package com.road.yishi.proto.active
{
   import com.netease.protobuf.Message;
   import com.netease.protobuf.ReadUtils;
   import com.netease.protobuf.WriteUtils;
   import com.netease.protobuf.WritingBuffer;
   import flash.errors.IOError;
   import flash.utils.IDataInput;
   import flash.utils.IExternalizable;
   
   public final class ChairsChargeMsg extends Message implements IExternalizable
   {
      
      private var userId$field:int;
      
      private var hasField$0:uint = 0;
      
      private var totalPoint$field:int;
      
      private var currentPoint$field:int;
      
      private var tokenCount$field:int;
      
      private var uuid$field:String;
      
      private var site$field:String;
      
      private var serverName$field:String;
      
      private var param1$field:int;
      
      private var param2$field:int;
      
      public function ChairsChargeMsg()
      {
         super();
      }
      
      public function removeUserId() : void
      {
         hasField$0 &= 4294967294;
         userId$field = new int();
      }
      
      public function get hasUserId() : Boolean
      {
         return (hasField$0 & 1) != 0;
      }
      
      public function set userId(param1:int) : void
      {
         hasField$0 |= 1;
         userId$field = param1;
      }
      
      public function get userId() : int
      {
         return userId$field;
      }
      
      public function removeTotalPoint() : void
      {
         hasField$0 &= 4294967293;
         totalPoint$field = new int();
      }
      
      public function get hasTotalPoint() : Boolean
      {
         return (hasField$0 & 2) != 0;
      }
      
      public function set totalPoint(param1:int) : void
      {
         hasField$0 |= 2;
         totalPoint$field = param1;
      }
      
      public function get totalPoint() : int
      {
         return totalPoint$field;
      }
      
      public function removeCurrentPoint() : void
      {
         hasField$0 &= 4294967291;
         currentPoint$field = new int();
      }
      
      public function get hasCurrentPoint() : Boolean
      {
         return (hasField$0 & 4) != 0;
      }
      
      public function set currentPoint(param1:int) : void
      {
         hasField$0 |= 4;
         currentPoint$field = param1;
      }
      
      public function get currentPoint() : int
      {
         return currentPoint$field;
      }
      
      public function removeTokenCount() : void
      {
         hasField$0 &= 4294967287;
         tokenCount$field = new int();
      }
      
      public function get hasTokenCount() : Boolean
      {
         return (hasField$0 & 8) != 0;
      }
      
      public function set tokenCount(param1:int) : void
      {
         hasField$0 |= 8;
         tokenCount$field = param1;
      }
      
      public function get tokenCount() : int
      {
         return tokenCount$field;
      }
      
      public function removeUuid() : void
      {
         uuid$field = null;
      }
      
      public function get hasUuid() : Boolean
      {
         return uuid$field != null;
      }
      
      public function set uuid(param1:String) : void
      {
         uuid$field = param1;
      }
      
      public function get uuid() : String
      {
         return uuid$field;
      }
      
      public function removeSite() : void
      {
         site$field = null;
      }
      
      public function get hasSite() : Boolean
      {
         return site$field != null;
      }
      
      public function set site(param1:String) : void
      {
         site$field = param1;
      }
      
      public function get site() : String
      {
         return site$field;
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
      
      public function removeParam1() : void
      {
         hasField$0 &= 4294967279;
         param1$field = new int();
      }
      
      public function get hasParam1() : Boolean
      {
         return (hasField$0 & 0x10) != 0;
      }
      
      public function set param1(param1:int) : void
      {
         hasField$0 |= 16;
         param1$field = param1;
      }
      
      public function get param1() : int
      {
         return param1$field;
      }
      
      public function removeParam2() : void
      {
         hasField$0 &= 4294967263;
         param2$field = new int();
      }
      
      public function get hasParam2() : Boolean
      {
         return (hasField$0 & 0x20) != 0;
      }
      
      public function set param2(param1:int) : void
      {
         hasField$0 |= 32;
         param2$field = param1;
      }
      
      public function get param2() : int
      {
         return param2$field;
      }
      
      final override public function writeToBuffer(param1:WritingBuffer) : void
      {
         if(hasUserId)
         {
            WriteUtils.writeTag(param1,0,1);
            WriteUtils.write$TYPE_INT32(param1,userId$field);
         }
         if(hasTotalPoint)
         {
            WriteUtils.writeTag(param1,0,2);
            WriteUtils.write$TYPE_INT32(param1,totalPoint$field);
         }
         if(hasCurrentPoint)
         {
            WriteUtils.writeTag(param1,0,3);
            WriteUtils.write$TYPE_INT32(param1,currentPoint$field);
         }
         if(hasTokenCount)
         {
            WriteUtils.writeTag(param1,0,4);
            WriteUtils.write$TYPE_INT32(param1,tokenCount$field);
         }
         if(hasUuid)
         {
            WriteUtils.writeTag(param1,2,5);
            WriteUtils.write$TYPE_STRING(param1,uuid$field);
         }
         if(hasSite)
         {
            WriteUtils.writeTag(param1,2,6);
            WriteUtils.write$TYPE_STRING(param1,site$field);
         }
         if(hasServerName)
         {
            WriteUtils.writeTag(param1,2,7);
            WriteUtils.write$TYPE_STRING(param1,serverName$field);
         }
         if(hasParam1)
         {
            WriteUtils.writeTag(param1,0,8);
            WriteUtils.write$TYPE_INT32(param1,param1$field);
         }
         if(hasParam2)
         {
            WriteUtils.writeTag(param1,0,9);
            WriteUtils.write$TYPE_INT32(param1,param2$field);
         }
      }
      
      final override public function readFromSlice(param1:IDataInput, param2:uint) : void
      {
         var _loc10_:* = 0;
         var _loc9_:uint = 0;
         var _loc8_:uint = 0;
         var _loc11_:uint = 0;
         var _loc7_:uint = 0;
         var _loc4_:uint = 0;
         var _loc3_:uint = 0;
         var _loc5_:uint = 0;
         var _loc6_:uint = 0;
         var _loc12_:uint = 0;
         while(param1.bytesAvailable > param2)
         {
            switch(((_loc10_ = ReadUtils.read$TYPE_UINT32(param1)) >>> 3) - 1)
            {
               case 0:
                  if(_loc9_ != 0)
                  {
                     throw new IOError("Bad data format: ChairsChargeMsg.userId cannot be set twice.");
                  }
                  _loc9_++;
                  userId = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 1:
                  if(_loc8_ != 0)
                  {
                     throw new IOError("Bad data format: ChairsChargeMsg.totalPoint cannot be set twice.");
                  }
                  _loc8_++;
                  totalPoint = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 2:
                  if(_loc11_ != 0)
                  {
                     throw new IOError("Bad data format: ChairsChargeMsg.currentPoint cannot be set twice.");
                  }
                  _loc11_++;
                  currentPoint = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 3:
                  if(_loc7_ != 0)
                  {
                     throw new IOError("Bad data format: ChairsChargeMsg.tokenCount cannot be set twice.");
                  }
                  _loc7_++;
                  tokenCount = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 4:
                  if(_loc4_ != 0)
                  {
                     throw new IOError("Bad data format: ChairsChargeMsg.uuid cannot be set twice.");
                  }
                  _loc4_++;
                  uuid = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 5:
                  if(_loc3_ != 0)
                  {
                     throw new IOError("Bad data format: ChairsChargeMsg.site cannot be set twice.");
                  }
                  _loc3_++;
                  site = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 6:
                  if(_loc5_ != 0)
                  {
                     throw new IOError("Bad data format: ChairsChargeMsg.serverName cannot be set twice.");
                  }
                  _loc5_++;
                  serverName = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 7:
                  if(_loc6_ != 0)
                  {
                     throw new IOError("Bad data format: ChairsChargeMsg.param1 cannot be set twice.");
                  }
                  _loc6_++;
                  param1 = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 8:
                  if(_loc12_ != 0)
                  {
                     throw new IOError("Bad data format: ChairsChargeMsg.param2 cannot be set twice.");
                  }
                  _loc12_++;
                  param2 = ReadUtils.read$TYPE_INT32(param1);
                  break;
               default:
                  ReadUtils.skip(param1,_loc10_ & 7);
            }
         }
      }
   }
}

