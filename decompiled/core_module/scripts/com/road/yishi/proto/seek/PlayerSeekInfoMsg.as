package com.road.yishi.proto.seek
{
   import com.netease.protobuf.Int64;
   import com.netease.protobuf.Message;
   import com.netease.protobuf.ReadUtils;
   import com.netease.protobuf.WriteUtils;
   import com.netease.protobuf.WritingBuffer;
   import flash.errors.IOError;
   import flash.utils.IDataInput;
   import flash.utils.IExternalizable;
   
   public final class PlayerSeekInfoMsg extends Message implements IExternalizable
   {
      
      private var seekCount$field:int;
      
      private var hasField$0:uint = 0;
      
      private var nextAddTime$field:Int64;
      
      private var state$field:int;
      
      private var eventDesc$field:String;
      
      private var curNodeId$field:int;
      
      private var op$field:int;
      
      private var seekNodeList$field:SeekNodeListMsg;
      
      public function PlayerSeekInfoMsg()
      {
         super();
      }
      
      public function removeSeekCount() : void
      {
         hasField$0 &= 4294967294;
         seekCount$field = new int();
      }
      
      public function get hasSeekCount() : Boolean
      {
         return (hasField$0 & 1) != 0;
      }
      
      public function set seekCount(param1:int) : void
      {
         hasField$0 |= 1;
         seekCount$field = param1;
      }
      
      public function get seekCount() : int
      {
         return seekCount$field;
      }
      
      public function removeNextAddTime() : void
      {
         nextAddTime$field = null;
      }
      
      public function get hasNextAddTime() : Boolean
      {
         return nextAddTime$field != null;
      }
      
      public function set nextAddTime(param1:Int64) : void
      {
         nextAddTime$field = param1;
      }
      
      public function get nextAddTime() : Int64
      {
         return nextAddTime$field;
      }
      
      public function removeState() : void
      {
         hasField$0 &= 4294967293;
         state$field = new int();
      }
      
      public function get hasState() : Boolean
      {
         return (hasField$0 & 2) != 0;
      }
      
      public function set state(param1:int) : void
      {
         hasField$0 |= 2;
         state$field = param1;
      }
      
      public function get state() : int
      {
         return state$field;
      }
      
      public function removeEventDesc() : void
      {
         eventDesc$field = null;
      }
      
      public function get hasEventDesc() : Boolean
      {
         return eventDesc$field != null;
      }
      
      public function set eventDesc(param1:String) : void
      {
         eventDesc$field = param1;
      }
      
      public function get eventDesc() : String
      {
         return eventDesc$field;
      }
      
      public function removeCurNodeId() : void
      {
         hasField$0 &= 4294967291;
         curNodeId$field = new int();
      }
      
      public function get hasCurNodeId() : Boolean
      {
         return (hasField$0 & 4) != 0;
      }
      
      public function set curNodeId(param1:int) : void
      {
         hasField$0 |= 4;
         curNodeId$field = param1;
      }
      
      public function get curNodeId() : int
      {
         return curNodeId$field;
      }
      
      public function removeOp() : void
      {
         hasField$0 &= 4294967287;
         op$field = new int();
      }
      
      public function get hasOp() : Boolean
      {
         return (hasField$0 & 8) != 0;
      }
      
      public function set op(param1:int) : void
      {
         hasField$0 |= 8;
         op$field = param1;
      }
      
      public function get op() : int
      {
         return op$field;
      }
      
      public function removeSeekNodeList() : void
      {
         seekNodeList$field = null;
      }
      
      public function get hasSeekNodeList() : Boolean
      {
         return seekNodeList$field != null;
      }
      
      public function set seekNodeList(param1:SeekNodeListMsg) : void
      {
         seekNodeList$field = param1;
      }
      
      public function get seekNodeList() : SeekNodeListMsg
      {
         return seekNodeList$field;
      }
      
      final override public function writeToBuffer(param1:WritingBuffer) : void
      {
         if(hasSeekCount)
         {
            WriteUtils.writeTag(param1,0,1);
            WriteUtils.write$TYPE_INT32(param1,seekCount$field);
         }
         if(hasNextAddTime)
         {
            WriteUtils.writeTag(param1,0,2);
            WriteUtils.write$TYPE_INT64(param1,nextAddTime$field);
         }
         if(hasState)
         {
            WriteUtils.writeTag(param1,0,3);
            WriteUtils.write$TYPE_INT32(param1,state$field);
         }
         if(hasEventDesc)
         {
            WriteUtils.writeTag(param1,2,4);
            WriteUtils.write$TYPE_STRING(param1,eventDesc$field);
         }
         if(hasCurNodeId)
         {
            WriteUtils.writeTag(param1,0,5);
            WriteUtils.write$TYPE_INT32(param1,curNodeId$field);
         }
         if(hasOp)
         {
            WriteUtils.writeTag(param1,0,6);
            WriteUtils.write$TYPE_INT32(param1,op$field);
         }
         if(hasSeekNodeList)
         {
            WriteUtils.writeTag(param1,2,7);
            WriteUtils.write$TYPE_MESSAGE(param1,seekNodeList$field);
         }
      }
      
      final override public function readFromSlice(param1:IDataInput, param2:uint) : void
      {
         var _loc6_:* = 0;
         var _loc4_:uint = 0;
         var _loc9_:uint = 0;
         var _loc5_:uint = 0;
         var _loc8_:uint = 0;
         var _loc7_:uint = 0;
         var _loc10_:uint = 0;
         var _loc3_:uint = 0;
         while(param1.bytesAvailable > param2)
         {
            switch(((_loc6_ = ReadUtils.read$TYPE_UINT32(param1)) >>> 3) - 1)
            {
               case 0:
                  if(_loc4_ != 0)
                  {
                     throw new IOError("Bad data format: PlayerSeekInfoMsg.seekCount cannot be set twice.");
                  }
                  _loc4_++;
                  seekCount = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 1:
                  if(_loc9_ != 0)
                  {
                     throw new IOError("Bad data format: PlayerSeekInfoMsg.nextAddTime cannot be set twice.");
                  }
                  _loc9_++;
                  nextAddTime = ReadUtils.read$TYPE_INT64(param1);
                  break;
               case 2:
                  if(_loc5_ != 0)
                  {
                     throw new IOError("Bad data format: PlayerSeekInfoMsg.state cannot be set twice.");
                  }
                  _loc5_++;
                  state = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 3:
                  if(_loc8_ != 0)
                  {
                     throw new IOError("Bad data format: PlayerSeekInfoMsg.eventDesc cannot be set twice.");
                  }
                  _loc8_++;
                  eventDesc = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 4:
                  if(_loc7_ != 0)
                  {
                     throw new IOError("Bad data format: PlayerSeekInfoMsg.curNodeId cannot be set twice.");
                  }
                  _loc7_++;
                  curNodeId = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 5:
                  if(_loc10_ != 0)
                  {
                     throw new IOError("Bad data format: PlayerSeekInfoMsg.op cannot be set twice.");
                  }
                  _loc10_++;
                  op = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 6:
                  if(_loc3_ != 0)
                  {
                     throw new IOError("Bad data format: PlayerSeekInfoMsg.seekNodeList cannot be set twice.");
                  }
                  _loc3_++;
                  seekNodeList = new SeekNodeListMsg();
                  ReadUtils.read$TYPE_MESSAGE(param1,seekNodeList);
                  break;
               default:
                  ReadUtils.skip(param1,_loc6_ & 7);
            }
         }
      }
   }
}

