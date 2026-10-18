package com.road.yishi.proto.pet
{
   import com.netease.protobuf.Message;
   import com.netease.protobuf.ReadUtils;
   import com.netease.protobuf.WriteUtils;
   import com.netease.protobuf.WritingBuffer;
   import flash.errors.IOError;
   import flash.utils.IDataInput;
   import flash.utils.IExternalizable;
   
   public final class TableChannelMessage extends Message implements IExternalizable
   {
      
      private var source$field:PokerPlayerMsg;
      
      private var target$field:PokerPlayerMsg;
      
      private var type$field:int;
      
      private var hasField$0:uint = 0;
      
      private var msg$field:String;
      
      public function TableChannelMessage()
      {
         super();
      }
      
      public function removeSource() : void
      {
         source$field = null;
      }
      
      public function get hasSource() : Boolean
      {
         return source$field != null;
      }
      
      public function set source(param1:PokerPlayerMsg) : void
      {
         source$field = param1;
      }
      
      public function get source() : PokerPlayerMsg
      {
         return source$field;
      }
      
      public function removeTarget() : void
      {
         target$field = null;
      }
      
      public function get hasTarget() : Boolean
      {
         return target$field != null;
      }
      
      public function set target(param1:PokerPlayerMsg) : void
      {
         target$field = param1;
      }
      
      public function get target() : PokerPlayerMsg
      {
         return target$field;
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
      
      public function removeMsg() : void
      {
         msg$field = null;
      }
      
      public function get hasMsg() : Boolean
      {
         return msg$field != null;
      }
      
      public function set msg(param1:String) : void
      {
         msg$field = param1;
      }
      
      public function get msg() : String
      {
         return msg$field;
      }
      
      final override public function writeToBuffer(param1:WritingBuffer) : void
      {
         if(hasSource)
         {
            WriteUtils.writeTag(param1,2,1);
            WriteUtils.write$TYPE_MESSAGE(param1,source$field);
         }
         if(hasTarget)
         {
            WriteUtils.writeTag(param1,2,2);
            WriteUtils.write$TYPE_MESSAGE(param1,target$field);
         }
         if(hasType)
         {
            WriteUtils.writeTag(param1,0,3);
            WriteUtils.write$TYPE_INT32(param1,type$field);
         }
         if(hasMsg)
         {
            WriteUtils.writeTag(param1,2,4);
            WriteUtils.write$TYPE_STRING(param1,msg$field);
         }
      }
      
      final override public function readFromSlice(param1:IDataInput, param2:uint) : void
      {
         var _loc5_:* = 0;
         var _loc3_:uint = 0;
         var _loc7_:uint = 0;
         var _loc4_:uint = 0;
         var _loc6_:uint = 0;
         while(param1.bytesAvailable > param2)
         {
            switch(((_loc5_ = ReadUtils.read$TYPE_UINT32(param1)) >>> 3) - 1)
            {
               case 0:
                  if(_loc3_ != 0)
                  {
                     throw new IOError("Bad data format: TableChannelMessage.source cannot be set twice.");
                  }
                  _loc3_++;
                  source = new PokerPlayerMsg();
                  ReadUtils.read$TYPE_MESSAGE(param1,source);
                  break;
               case 1:
                  if(_loc7_ != 0)
                  {
                     throw new IOError("Bad data format: TableChannelMessage.target cannot be set twice.");
                  }
                  _loc7_++;
                  target = new PokerPlayerMsg();
                  ReadUtils.read$TYPE_MESSAGE(param1,target);
                  break;
               case 2:
                  if(_loc4_ != 0)
                  {
                     throw new IOError("Bad data format: TableChannelMessage.type cannot be set twice.");
                  }
                  _loc4_++;
                  type = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 3:
                  if(_loc6_ != 0)
                  {
                     throw new IOError("Bad data format: TableChannelMessage.msg cannot be set twice.");
                  }
                  _loc6_++;
                  msg = ReadUtils.read$TYPE_STRING(param1);
                  break;
               default:
                  ReadUtils.skip(param1,_loc5_ & 7);
            }
         }
      }
   }
}

