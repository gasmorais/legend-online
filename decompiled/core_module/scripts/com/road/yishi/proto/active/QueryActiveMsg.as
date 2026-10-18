package com.road.yishi.proto.active
{
   import com.netease.protobuf.*;
   import flash.errors.IOError;
   import flash.utils.IDataInput;
   import flash.utils.IExternalizable;
   
   public final class QueryActiveMsg extends Message implements IExternalizable
   {
      
      private var query_type$field:String;
      
      private var param1$field:String;
      
      private var param2$field:String;
      
      [ArrayElementType("com.road.yishi.proto.active.ActiveInfoMsg")]
      public var actives:Array = [];
      
      public function QueryActiveMsg()
      {
         super();
      }
      
      public function removeQueryType() : void
      {
         query_type$field = null;
      }
      
      public function get hasQueryType() : Boolean
      {
         return query_type$field != null;
      }
      
      public function set queryType(param1:String) : void
      {
         query_type$field = param1;
      }
      
      public function get queryType() : String
      {
         return query_type$field;
      }
      
      public function removeParam1() : void
      {
         param1$field = null;
      }
      
      public function get hasParam1() : Boolean
      {
         return param1$field != null;
      }
      
      public function set param1(param1:String) : void
      {
         param1$field = param1;
      }
      
      public function get param1() : String
      {
         return param1$field;
      }
      
      public function removeParam2() : void
      {
         param2$field = null;
      }
      
      public function get hasParam2() : Boolean
      {
         return param2$field != null;
      }
      
      public function set param2(param1:String) : void
      {
         param2$field = param1;
      }
      
      public function get param2() : String
      {
         return param2$field;
      }
      
      final override public function writeToBuffer(param1:WritingBuffer) : void
      {
         var _loc2_:* = 0;
         if(hasQueryType)
         {
            WriteUtils.writeTag(param1,2,1);
            WriteUtils.write$TYPE_STRING(param1,query_type$field);
         }
         if(hasParam1)
         {
            WriteUtils.writeTag(param1,2,2);
            WriteUtils.write$TYPE_STRING(param1,param1$field);
         }
         if(hasParam2)
         {
            WriteUtils.writeTag(param1,2,3);
            WriteUtils.write$TYPE_STRING(param1,param2$field);
         }
         _loc2_ = 0;
         while(_loc2_ < actives.length)
         {
            WriteUtils.writeTag(param1,2,4);
            WriteUtils.write$TYPE_MESSAGE(param1,actives[_loc2_]);
            _loc2_++;
         }
      }
      
      final override public function readFromSlice(param1:IDataInput, param2:uint) : void
      {
         var _loc6_:* = 0;
         var _loc4_:ActiveInfoMsg = null;
         var _loc5_:uint = 0;
         var _loc3_:uint = 0;
         var _loc7_:uint = 0;
         while(param1.bytesAvailable > param2)
         {
            switch(((_loc6_ = ReadUtils.read$TYPE_UINT32(param1)) >>> 3) - 1)
            {
               case 0:
                  if(_loc5_ != 0)
                  {
                     throw new IOError("Bad data format: QueryActiveMsg.queryType cannot be set twice.");
                  }
                  _loc5_++;
                  queryType = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 1:
                  if(_loc3_ != 0)
                  {
                     throw new IOError("Bad data format: QueryActiveMsg.param1 cannot be set twice.");
                  }
                  _loc3_++;
                  param1 = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 2:
                  if(_loc7_ != 0)
                  {
                     throw new IOError("Bad data format: QueryActiveMsg.param2 cannot be set twice.");
                  }
                  _loc7_++;
                  param2 = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 3:
                  _loc4_ = new ActiveInfoMsg();
                  ReadUtils.read$TYPE_MESSAGE(param1,_loc4_);
                  actives.push(_loc4_);
                  break;
               default:
                  ReadUtils.skip(param1,_loc6_ & 7);
            }
         }
      }
   }
}

