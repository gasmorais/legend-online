package com.road.yishi.proto.player
{
   import com.netease.protobuf.Message;
   import com.netease.protobuf.ReadUtils;
   import com.netease.protobuf.WriteUtils;
   import com.netease.protobuf.WritingBuffer;
   import flash.errors.IOError;
   import flash.utils.IDataInput;
   import flash.utils.IExternalizable;
   
   public final class PlayerSignRspMsg extends Message implements IExternalizable
   {
      
      private var signDate$field:String;
      
      private var signTimes$field:int;
      
      private var hasField$0:uint = 0;
      
      private var signSite$field:int;
      
      public function PlayerSignRspMsg()
      {
         super();
      }
      
      public function removeSignDate() : void
      {
         signDate$field = null;
      }
      
      public function get hasSignDate() : Boolean
      {
         return signDate$field != null;
      }
      
      public function set signDate(param1:String) : void
      {
         signDate$field = param1;
      }
      
      public function get signDate() : String
      {
         return signDate$field;
      }
      
      public function removeSignTimes() : void
      {
         hasField$0 &= 4294967294;
         signTimes$field = new int();
      }
      
      public function get hasSignTimes() : Boolean
      {
         return (hasField$0 & 1) != 0;
      }
      
      public function set signTimes(param1:int) : void
      {
         hasField$0 |= 1;
         signTimes$field = param1;
      }
      
      public function get signTimes() : int
      {
         return signTimes$field;
      }
      
      public function removeSignSite() : void
      {
         hasField$0 &= 4294967293;
         signSite$field = new int();
      }
      
      public function get hasSignSite() : Boolean
      {
         return (hasField$0 & 2) != 0;
      }
      
      public function set signSite(param1:int) : void
      {
         hasField$0 |= 2;
         signSite$field = param1;
      }
      
      public function get signSite() : int
      {
         return signSite$field;
      }
      
      final override public function writeToBuffer(param1:WritingBuffer) : void
      {
         if(hasSignDate)
         {
            WriteUtils.writeTag(param1,2,1);
            WriteUtils.write$TYPE_STRING(param1,signDate$field);
         }
         if(hasSignTimes)
         {
            WriteUtils.writeTag(param1,0,2);
            WriteUtils.write$TYPE_INT32(param1,signTimes$field);
         }
         if(hasSignSite)
         {
            WriteUtils.writeTag(param1,0,4);
            WriteUtils.write$TYPE_INT32(param1,signSite$field);
         }
      }
      
      final override public function readFromSlice(param1:IDataInput, param2:uint) : void
      {
         var _loc4_:* = 0;
         var _loc3_:uint = 0;
         var _loc6_:uint = 0;
         var _loc5_:uint = 0;
         while(param1.bytesAvailable > param2)
         {
            switch(((_loc4_ = ReadUtils.read$TYPE_UINT32(param1)) >>> 3) - 1)
            {
               case 0:
                  if(_loc3_ != 0)
                  {
                     throw new IOError("Bad data format: PlayerSignRspMsg.signDate cannot be set twice.");
                  }
                  _loc3_++;
                  signDate = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 1:
                  if(_loc6_ != 0)
                  {
                     throw new IOError("Bad data format: PlayerSignRspMsg.signTimes cannot be set twice.");
                  }
                  _loc6_++;
                  signTimes = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 3:
                  if(_loc5_ != 0)
                  {
                     throw new IOError("Bad data format: PlayerSignRspMsg.signSite cannot be set twice.");
                  }
                  _loc5_++;
                  signSite = ReadUtils.read$TYPE_INT32(param1);
                  break;
               default:
                  ReadUtils.skip(param1,_loc4_ & 7);
            }
         }
      }
   }
}

