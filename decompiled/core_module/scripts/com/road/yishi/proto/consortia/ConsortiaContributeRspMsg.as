package com.road.yishi.proto.consortia
{
   import com.netease.protobuf.*;
   import flash.errors.IOError;
   import flash.utils.IDataInput;
   import flash.utils.IExternalizable;
   
   public final class ConsortiaContributeRspMsg extends Message implements IExternalizable
   {
      
      private var total_rows$field:int;
      
      private var hasField$0:uint = 0;
      
      [ArrayElementType("com.road.yishi.proto.consortia.ConsortiaContributeMsg")]
      public var contributeInfo:Array = [];
      
      private var self_info$field:ConsortiaContributeMsg;
      
      private var self_order$field:int;
      
      public function ConsortiaContributeRspMsg()
      {
         super();
      }
      
      public function removeTotalRows() : void
      {
         hasField$0 &= 4294967294;
         total_rows$field = new int();
      }
      
      public function get hasTotalRows() : Boolean
      {
         return (hasField$0 & 1) != 0;
      }
      
      public function set totalRows(param1:int) : void
      {
         hasField$0 |= 1;
         total_rows$field = param1;
      }
      
      public function get totalRows() : int
      {
         return total_rows$field;
      }
      
      public function removeSelfInfo() : void
      {
         self_info$field = null;
      }
      
      public function get hasSelfInfo() : Boolean
      {
         return self_info$field != null;
      }
      
      public function set selfInfo(param1:ConsortiaContributeMsg) : void
      {
         self_info$field = param1;
      }
      
      public function get selfInfo() : ConsortiaContributeMsg
      {
         return self_info$field;
      }
      
      public function removeSelfOrder() : void
      {
         hasField$0 &= 4294967293;
         self_order$field = new int();
      }
      
      public function get hasSelfOrder() : Boolean
      {
         return (hasField$0 & 2) != 0;
      }
      
      public function set selfOrder(param1:int) : void
      {
         hasField$0 |= 2;
         self_order$field = param1;
      }
      
      public function get selfOrder() : int
      {
         return self_order$field;
      }
      
      final override public function writeToBuffer(param1:WritingBuffer) : void
      {
         var _loc2_:* = 0;
         if(hasTotalRows)
         {
            WriteUtils.writeTag(param1,0,1);
            WriteUtils.write$TYPE_INT32(param1,total_rows$field);
         }
         _loc2_ = 0;
         while(_loc2_ < contributeInfo.length)
         {
            WriteUtils.writeTag(param1,2,2);
            WriteUtils.write$TYPE_MESSAGE(param1,contributeInfo[_loc2_]);
            _loc2_++;
         }
         if(hasSelfInfo)
         {
            WriteUtils.writeTag(param1,2,3);
            WriteUtils.write$TYPE_MESSAGE(param1,self_info$field);
         }
         if(hasSelfOrder)
         {
            WriteUtils.writeTag(param1,0,4);
            WriteUtils.write$TYPE_INT32(param1,self_order$field);
         }
      }
      
      final override public function readFromSlice(param1:IDataInput, param2:uint) : void
      {
         var _loc7_:* = 0;
         var _loc4_:ConsortiaContributeMsg = null;
         var _loc3_:uint = 0;
         var _loc6_:uint = 0;
         var _loc5_:uint = 0;
         while(param1.bytesAvailable > param2)
         {
            switch(((_loc7_ = ReadUtils.read$TYPE_UINT32(param1)) >>> 3) - 1)
            {
               case 0:
                  if(_loc3_ != 0)
                  {
                     throw new IOError("Bad data format: ConsortiaContributeRspMsg.totalRows cannot be set twice.");
                  }
                  _loc3_++;
                  totalRows = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 1:
                  _loc4_ = new ConsortiaContributeMsg();
                  ReadUtils.read$TYPE_MESSAGE(param1,_loc4_);
                  contributeInfo.push(_loc4_);
                  break;
               case 2:
                  if(_loc6_ != 0)
                  {
                     throw new IOError("Bad data format: ConsortiaContributeRspMsg.selfInfo cannot be set twice.");
                  }
                  _loc6_++;
                  selfInfo = new ConsortiaContributeMsg();
                  ReadUtils.read$TYPE_MESSAGE(param1,selfInfo);
                  break;
               case 3:
                  if(_loc5_ != 0)
                  {
                     throw new IOError("Bad data format: ConsortiaContributeRspMsg.selfOrder cannot be set twice.");
                  }
                  _loc5_++;
                  selfOrder = ReadUtils.read$TYPE_INT32(param1);
                  break;
               default:
                  ReadUtils.skip(param1,_loc7_ & 7);
            }
         }
      }
   }
}

