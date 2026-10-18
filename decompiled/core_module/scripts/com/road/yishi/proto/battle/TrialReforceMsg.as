package com.road.yishi.proto.battle
{
   import com.netease.protobuf.Message;
   import com.netease.protobuf.ReadUtils;
   import com.netease.protobuf.WriteUtils;
   import com.netease.protobuf.WritingBuffer;
   import flash.errors.IOError;
   import flash.utils.IDataInput;
   import flash.utils.IExternalizable;
   
   public final class TrialReforceMsg extends Message implements IExternalizable
   {
      
      private var proxy_id$field:String;
      
      private var cur_wave$field:int;
      
      private var hasField$0:uint = 0;
      
      private var type$field:int;
      
      public function TrialReforceMsg()
      {
         super();
      }
      
      public function removeProxyId() : void
      {
         proxy_id$field = null;
      }
      
      public function get hasProxyId() : Boolean
      {
         return proxy_id$field != null;
      }
      
      public function set proxyId(param1:String) : void
      {
         proxy_id$field = param1;
      }
      
      public function get proxyId() : String
      {
         return proxy_id$field;
      }
      
      public function removeCurWave() : void
      {
         hasField$0 &= 4294967294;
         cur_wave$field = new int();
      }
      
      public function get hasCurWave() : Boolean
      {
         return (hasField$0 & 1) != 0;
      }
      
      public function set curWave(param1:int) : void
      {
         hasField$0 |= 1;
         cur_wave$field = param1;
      }
      
      public function get curWave() : int
      {
         return cur_wave$field;
      }
      
      public function removeType() : void
      {
         hasField$0 &= 4294967293;
         type$field = new int();
      }
      
      public function get hasType() : Boolean
      {
         return (hasField$0 & 2) != 0;
      }
      
      public function set type(param1:int) : void
      {
         hasField$0 |= 2;
         type$field = param1;
      }
      
      public function get type() : int
      {
         return type$field;
      }
      
      final override public function writeToBuffer(param1:WritingBuffer) : void
      {
         if(hasProxyId)
         {
            WriteUtils.writeTag(param1,2,1);
            WriteUtils.write$TYPE_STRING(param1,proxy_id$field);
         }
         if(hasCurWave)
         {
            WriteUtils.writeTag(param1,0,2);
            WriteUtils.write$TYPE_INT32(param1,cur_wave$field);
         }
         if(hasType)
         {
            WriteUtils.writeTag(param1,0,3);
            WriteUtils.write$TYPE_INT32(param1,type$field);
         }
      }
      
      final override public function readFromSlice(param1:IDataInput, param2:uint) : void
      {
         var _loc6_:* = 0;
         var _loc3_:uint = 0;
         var _loc4_:uint = 0;
         var _loc5_:uint = 0;
         while(param1.bytesAvailable > param2)
         {
            switch(((_loc6_ = ReadUtils.read$TYPE_UINT32(param1)) >>> 3) - 1)
            {
               case 0:
                  if(_loc3_ != 0)
                  {
                     throw new IOError("Bad data format: TrialReforceMsg.proxyId cannot be set twice.");
                  }
                  _loc3_++;
                  proxyId = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 1:
                  if(_loc4_ != 0)
                  {
                     throw new IOError("Bad data format: TrialReforceMsg.curWave cannot be set twice.");
                  }
                  _loc4_++;
                  curWave = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 2:
                  if(_loc5_ != 0)
                  {
                     throw new IOError("Bad data format: TrialReforceMsg.type cannot be set twice.");
                  }
                  _loc5_++;
                  type = ReadUtils.read$TYPE_INT32(param1);
                  break;
               default:
                  ReadUtils.skip(param1,_loc6_ & 7);
            }
         }
      }
   }
}

