package com.road.yishi.proto.campaign
{
   import com.netease.protobuf.*;
   import flash.errors.IOError;
   import flash.utils.IDataInput;
   import flash.utils.IExternalizable;
   
   public final class CampaignNodeUpdateMsg extends Message implements IExternalizable
   {
      
      private var node_id$field:int;
      
      private var hasField$0:uint = 0;
      
      private var node_state$field:int;
      
      private var user_id$field:int;
      
      [ArrayElementType("int")]
      public var visitUserIds:Array = [];
      
      [ArrayElementType("int")]
      public var userIds:Array = [];
      
      private var uu_id$field:String;
      
      private var param1$field:int;
      
      private var sonType$field:int;
      
      private var pos_x$field:int;
      
      private var pos_y$field:int;
      
      private var node_name$field:String;
      
      private var currentCount$field:int;
      
      private var param2$field:int;
      
      private var param3$field:int;
      
      public function CampaignNodeUpdateMsg()
      {
         super();
      }
      
      public function removeNodeId() : void
      {
         hasField$0 &= 4294967294;
         node_id$field = new int();
      }
      
      public function get hasNodeId() : Boolean
      {
         return (hasField$0 & 1) != 0;
      }
      
      public function set nodeId(param1:int) : void
      {
         hasField$0 |= 1;
         node_id$field = param1;
      }
      
      public function get nodeId() : int
      {
         return node_id$field;
      }
      
      public function removeNodeState() : void
      {
         hasField$0 &= 4294967293;
         node_state$field = new int();
      }
      
      public function get hasNodeState() : Boolean
      {
         return (hasField$0 & 2) != 0;
      }
      
      public function set nodeState(param1:int) : void
      {
         hasField$0 |= 2;
         node_state$field = param1;
      }
      
      public function get nodeState() : int
      {
         return node_state$field;
      }
      
      public function removeUserId() : void
      {
         hasField$0 &= 4294967291;
         user_id$field = new int();
      }
      
      public function get hasUserId() : Boolean
      {
         return (hasField$0 & 4) != 0;
      }
      
      public function set userId(param1:int) : void
      {
         hasField$0 |= 4;
         user_id$field = param1;
      }
      
      public function get userId() : int
      {
         return user_id$field;
      }
      
      public function removeUuId() : void
      {
         uu_id$field = null;
      }
      
      public function get hasUuId() : Boolean
      {
         return uu_id$field != null;
      }
      
      public function set uuId(param1:String) : void
      {
         uu_id$field = param1;
      }
      
      public function get uuId() : String
      {
         return uu_id$field;
      }
      
      public function removeParam1() : void
      {
         hasField$0 &= 4294967287;
         param1$field = new int();
      }
      
      public function get hasParam1() : Boolean
      {
         return (hasField$0 & 8) != 0;
      }
      
      public function set param1(param1:int) : void
      {
         hasField$0 |= 8;
         param1$field = param1;
      }
      
      public function get param1() : int
      {
         return param1$field;
      }
      
      public function removeSonType() : void
      {
         hasField$0 &= 4294967279;
         sonType$field = new int();
      }
      
      public function get hasSonType() : Boolean
      {
         return (hasField$0 & 0x10) != 0;
      }
      
      public function set sonType(param1:int) : void
      {
         hasField$0 |= 16;
         sonType$field = param1;
      }
      
      public function get sonType() : int
      {
         return sonType$field;
      }
      
      public function removePosX() : void
      {
         hasField$0 &= 4294967263;
         pos_x$field = new int();
      }
      
      public function get hasPosX() : Boolean
      {
         return (hasField$0 & 0x20) != 0;
      }
      
      public function set posX(param1:int) : void
      {
         hasField$0 |= 32;
         pos_x$field = param1;
      }
      
      public function get posX() : int
      {
         return pos_x$field;
      }
      
      public function removePosY() : void
      {
         hasField$0 &= 4294967231;
         pos_y$field = new int();
      }
      
      public function get hasPosY() : Boolean
      {
         return (hasField$0 & 0x40) != 0;
      }
      
      public function set posY(param1:int) : void
      {
         hasField$0 |= 64;
         pos_y$field = param1;
      }
      
      public function get posY() : int
      {
         return pos_y$field;
      }
      
      public function removeNodeName() : void
      {
         node_name$field = null;
      }
      
      public function get hasNodeName() : Boolean
      {
         return node_name$field != null;
      }
      
      public function set nodeName(param1:String) : void
      {
         node_name$field = param1;
      }
      
      public function get nodeName() : String
      {
         return node_name$field;
      }
      
      public function removeCurrentCount() : void
      {
         hasField$0 &= 4294967167;
         currentCount$field = new int();
      }
      
      public function get hasCurrentCount() : Boolean
      {
         return (hasField$0 & 0x80) != 0;
      }
      
      public function set currentCount(param1:int) : void
      {
         hasField$0 |= 128;
         currentCount$field = param1;
      }
      
      public function get currentCount() : int
      {
         return currentCount$field;
      }
      
      public function removeParam2() : void
      {
         hasField$0 &= 4294967039;
         param2$field = new int();
      }
      
      public function get hasParam2() : Boolean
      {
         return (hasField$0 & 0x0100) != 0;
      }
      
      public function set param2(param1:int) : void
      {
         hasField$0 |= 256;
         param2$field = param1;
      }
      
      public function get param2() : int
      {
         return param2$field;
      }
      
      public function removeParam3() : void
      {
         hasField$0 &= 4294966783;
         param3$field = new int();
      }
      
      public function get hasParam3() : Boolean
      {
         return (hasField$0 & 0x0200) != 0;
      }
      
      public function set param3(param1:int) : void
      {
         hasField$0 |= 512;
         param3$field = param1;
      }
      
      public function get param3() : int
      {
         return param3$field;
      }
      
      final override public function writeToBuffer(param1:WritingBuffer) : void
      {
         var _loc2_:* = 0;
         var _loc3_:* = 0;
         if(hasNodeId)
         {
            WriteUtils.writeTag(param1,0,1);
            WriteUtils.write$TYPE_INT32(param1,node_id$field);
         }
         if(hasNodeState)
         {
            WriteUtils.writeTag(param1,0,2);
            WriteUtils.write$TYPE_INT32(param1,node_state$field);
         }
         if(hasUserId)
         {
            WriteUtils.writeTag(param1,0,3);
            WriteUtils.write$TYPE_INT32(param1,user_id$field);
         }
         _loc2_ = 0;
         while(_loc2_ < visitUserIds.length)
         {
            WriteUtils.writeTag(param1,0,4);
            WriteUtils.write$TYPE_INT32(param1,visitUserIds[_loc2_]);
            _loc2_++;
         }
         _loc3_ = 0;
         while(_loc3_ < userIds.length)
         {
            WriteUtils.writeTag(param1,0,5);
            WriteUtils.write$TYPE_INT32(param1,userIds[_loc3_]);
            _loc3_++;
         }
         if(hasUuId)
         {
            WriteUtils.writeTag(param1,2,6);
            WriteUtils.write$TYPE_STRING(param1,uu_id$field);
         }
         if(hasParam1)
         {
            WriteUtils.writeTag(param1,0,7);
            WriteUtils.write$TYPE_INT32(param1,param1$field);
         }
         if(hasSonType)
         {
            WriteUtils.writeTag(param1,0,8);
            WriteUtils.write$TYPE_INT32(param1,sonType$field);
         }
         if(hasPosX)
         {
            WriteUtils.writeTag(param1,0,9);
            WriteUtils.write$TYPE_INT32(param1,pos_x$field);
         }
         if(hasPosY)
         {
            WriteUtils.writeTag(param1,0,10);
            WriteUtils.write$TYPE_INT32(param1,pos_y$field);
         }
         if(hasNodeName)
         {
            WriteUtils.writeTag(param1,2,11);
            WriteUtils.write$TYPE_STRING(param1,node_name$field);
         }
         if(hasCurrentCount)
         {
            WriteUtils.writeTag(param1,0,12);
            WriteUtils.write$TYPE_INT32(param1,currentCount$field);
         }
         if(hasParam2)
         {
            WriteUtils.writeTag(param1,0,13);
            WriteUtils.write$TYPE_INT32(param1,param2$field);
         }
         if(hasParam3)
         {
            WriteUtils.writeTag(param1,0,14);
            WriteUtils.write$TYPE_INT32(param1,param3$field);
         }
      }
      
      final override public function readFromSlice(param1:IDataInput, param2:uint) : void
      {
         var _loc13_:* = 0;
         var _loc8_:uint = 0;
         var _loc7_:uint = 0;
         var _loc12_:uint = 0;
         var _loc14_:uint = 0;
         var _loc4_:uint = 0;
         var _loc11_:uint = 0;
         var _loc9_:uint = 0;
         var _loc3_:uint = 0;
         var _loc10_:uint = 0;
         var _loc5_:uint = 0;
         var _loc15_:uint = 0;
         var _loc6_:uint = 0;
         while(param1.bytesAvailable > param2)
         {
            switch(((_loc13_ = uint(ReadUtils.read$TYPE_UINT32(param1))) >>> 3) - 1)
            {
               case 0:
                  if(_loc8_ != 0)
                  {
                     throw new IOError("Bad data format: CampaignNodeUpdateMsg.nodeId cannot be set twice.");
                  }
                  _loc8_++;
                  nodeId = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 1:
                  if(_loc7_ != 0)
                  {
                     throw new IOError("Bad data format: CampaignNodeUpdateMsg.nodeState cannot be set twice.");
                  }
                  _loc7_++;
                  nodeState = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 2:
                  if(_loc12_ != 0)
                  {
                     throw new IOError("Bad data format: CampaignNodeUpdateMsg.userId cannot be set twice.");
                  }
                  _loc12_++;
                  userId = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 3:
                  if((_loc13_ & 7) == 2)
                  {
                     ReadUtils.readPackedRepeated(param1,ReadUtils.read$TYPE_INT32,visitUserIds);
                  }
                  else
                  {
                     visitUserIds.push(ReadUtils.read$TYPE_INT32(param1));
                  }
                  break;
               case 4:
                  if((_loc13_ & 7) == 2)
                  {
                     ReadUtils.readPackedRepeated(param1,ReadUtils.read$TYPE_INT32,userIds);
                  }
                  else
                  {
                     userIds.push(ReadUtils.read$TYPE_INT32(param1));
                  }
                  break;
               case 5:
                  if(_loc14_ != 0)
                  {
                     throw new IOError("Bad data format: CampaignNodeUpdateMsg.uuId cannot be set twice.");
                  }
                  _loc14_++;
                  uuId = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 6:
                  if(_loc4_ != 0)
                  {
                     throw new IOError("Bad data format: CampaignNodeUpdateMsg.param1 cannot be set twice.");
                  }
                  _loc4_++;
                  param1 = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 7:
                  if(_loc11_ != 0)
                  {
                     throw new IOError("Bad data format: CampaignNodeUpdateMsg.sonType cannot be set twice.");
                  }
                  _loc11_++;
                  sonType = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 8:
                  if(_loc9_ != 0)
                  {
                     throw new IOError("Bad data format: CampaignNodeUpdateMsg.posX cannot be set twice.");
                  }
                  _loc9_++;
                  posX = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 9:
                  if(_loc3_ != 0)
                  {
                     throw new IOError("Bad data format: CampaignNodeUpdateMsg.posY cannot be set twice.");
                  }
                  _loc3_++;
                  posY = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 10:
                  if(_loc10_ != 0)
                  {
                     throw new IOError("Bad data format: CampaignNodeUpdateMsg.nodeName cannot be set twice.");
                  }
                  _loc10_++;
                  nodeName = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 11:
                  if(_loc5_ != 0)
                  {
                     throw new IOError("Bad data format: CampaignNodeUpdateMsg.currentCount cannot be set twice.");
                  }
                  _loc5_++;
                  currentCount = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 12:
                  if(_loc15_ != 0)
                  {
                     throw new IOError("Bad data format: CampaignNodeUpdateMsg.param2 cannot be set twice.");
                  }
                  _loc15_++;
                  param2 = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 13:
                  if(_loc6_ != 0)
                  {
                     throw new IOError("Bad data format: CampaignNodeUpdateMsg.param3 cannot be set twice.");
                  }
                  _loc6_++;
                  param3 = ReadUtils.read$TYPE_INT32(param1);
                  break;
               default:
                  ReadUtils.skip(param1,_loc13_ & 7);
            }
         }
      }
   }
}

