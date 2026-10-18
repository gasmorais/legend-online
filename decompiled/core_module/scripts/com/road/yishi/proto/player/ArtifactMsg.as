package com.road.yishi.proto.player
{
   import com.netease.protobuf.*;
   import flash.errors.IOError;
   import flash.utils.IDataInput;
   import flash.utils.IExternalizable;
   
   public final class ArtifactMsg extends Message implements IExternalizable
   {
      
      private var op$field:int;
      
      private var hasField$0:uint = 0;
      
      private var templateId$field:int;
      
      private var count$field:int;
      
      private var isEquip$field:Boolean;
      
      [ArrayElementType("com.road.yishi.proto.player.ArtifactInfoMsg")]
      public var infos:Array = [];
      
      private var armoryId$field:int;
      
      private var pos$field:int;
      
      [ArrayElementType("com.road.yishi.proto.player.ArmoryInfoMsg")]
      public var armoryInfo:Array = [];
      
      [ArrayElementType("int")]
      public var consumeArmoryIds:Array = [];
      
      [ArrayElementType("com.road.yishi.proto.player.ResonatePosMsg")]
      public var resonatePos:Array = [];
      
      public function ArtifactMsg()
      {
         super();
      }
      
      public function removeOp() : void
      {
         hasField$0 &= 4294967294;
         op$field = new int();
      }
      
      public function get hasOp() : Boolean
      {
         return (hasField$0 & 1) != 0;
      }
      
      public function set op(param1:int) : void
      {
         hasField$0 |= 1;
         op$field = param1;
      }
      
      public function get op() : int
      {
         return op$field;
      }
      
      public function removeTemplateId() : void
      {
         hasField$0 &= 4294967293;
         templateId$field = new int();
      }
      
      public function get hasTemplateId() : Boolean
      {
         return (hasField$0 & 2) != 0;
      }
      
      public function set templateId(param1:int) : void
      {
         hasField$0 |= 2;
         templateId$field = param1;
      }
      
      public function get templateId() : int
      {
         return templateId$field;
      }
      
      public function removeCount() : void
      {
         hasField$0 &= 4294967291;
         count$field = new int();
      }
      
      public function get hasCount() : Boolean
      {
         return (hasField$0 & 4) != 0;
      }
      
      public function set count(param1:int) : void
      {
         hasField$0 |= 4;
         count$field = param1;
      }
      
      public function get count() : int
      {
         return count$field;
      }
      
      public function removeIsEquip() : void
      {
         hasField$0 &= 4294967287;
         isEquip$field = new Boolean();
      }
      
      public function get hasIsEquip() : Boolean
      {
         return (hasField$0 & 8) != 0;
      }
      
      public function set isEquip(param1:Boolean) : void
      {
         hasField$0 |= 8;
         isEquip$field = param1;
      }
      
      public function get isEquip() : Boolean
      {
         return isEquip$field;
      }
      
      public function removeArmoryId() : void
      {
         hasField$0 &= 4294967279;
         armoryId$field = new int();
      }
      
      public function get hasArmoryId() : Boolean
      {
         return (hasField$0 & 0x10) != 0;
      }
      
      public function set armoryId(param1:int) : void
      {
         hasField$0 |= 16;
         armoryId$field = param1;
      }
      
      public function get armoryId() : int
      {
         return armoryId$field;
      }
      
      public function removePos() : void
      {
         hasField$0 &= 4294967263;
         pos$field = new int();
      }
      
      public function get hasPos() : Boolean
      {
         return (hasField$0 & 0x20) != 0;
      }
      
      public function set pos(param1:int) : void
      {
         hasField$0 |= 32;
         pos$field = param1;
      }
      
      public function get pos() : int
      {
         return pos$field;
      }
      
      final override public function writeToBuffer(param1:WritingBuffer) : void
      {
         var _loc4_:* = 0;
         var _loc2_:* = 0;
         var _loc5_:* = 0;
         var _loc3_:* = 0;
         if(hasOp)
         {
            WriteUtils.writeTag(param1,0,1);
            WriteUtils.write$TYPE_INT32(param1,op$field);
         }
         if(hasTemplateId)
         {
            WriteUtils.writeTag(param1,0,2);
            WriteUtils.write$TYPE_INT32(param1,templateId$field);
         }
         if(hasCount)
         {
            WriteUtils.writeTag(param1,0,3);
            WriteUtils.write$TYPE_INT32(param1,count$field);
         }
         if(hasIsEquip)
         {
            WriteUtils.writeTag(param1,0,4);
            WriteUtils.write$TYPE_BOOL(param1,isEquip$field);
         }
         _loc4_ = 0;
         while(_loc4_ < infos.length)
         {
            WriteUtils.writeTag(param1,2,5);
            WriteUtils.write$TYPE_MESSAGE(param1,infos[_loc4_]);
            _loc4_++;
         }
         if(hasArmoryId)
         {
            WriteUtils.writeTag(param1,0,6);
            WriteUtils.write$TYPE_INT32(param1,armoryId$field);
         }
         if(hasPos)
         {
            WriteUtils.writeTag(param1,0,7);
            WriteUtils.write$TYPE_INT32(param1,pos$field);
         }
         _loc2_ = 0;
         while(_loc2_ < armoryInfo.length)
         {
            WriteUtils.writeTag(param1,2,8);
            WriteUtils.write$TYPE_MESSAGE(param1,armoryInfo[_loc2_]);
            _loc2_++;
         }
         _loc5_ = 0;
         while(_loc5_ < consumeArmoryIds.length)
         {
            WriteUtils.writeTag(param1,0,10);
            WriteUtils.write$TYPE_INT32(param1,consumeArmoryIds[_loc5_]);
            _loc5_++;
         }
         _loc3_ = 0;
         while(_loc3_ < resonatePos.length)
         {
            WriteUtils.writeTag(param1,2,11);
            WriteUtils.write$TYPE_MESSAGE(param1,resonatePos[_loc3_]);
            _loc3_++;
         }
      }
      
      final override public function readFromSlice(param1:IDataInput, param2:uint) : void
      {
         var _loc11_:* = 0;
         var _loc8_:ArtifactInfoMsg = null;
         var _loc5_:ArmoryInfoMsg = null;
         var _loc4_:ResonatePosMsg = null;
         var _loc12_:uint = 0;
         var _loc6_:uint = 0;
         var _loc3_:uint = 0;
         var _loc9_:uint = 0;
         var _loc7_:uint = 0;
         var _loc10_:uint = 0;
         while(param1.bytesAvailable > param2)
         {
            switch(((_loc11_ = ReadUtils.read$TYPE_UINT32(param1)) >>> 3) - 1)
            {
               case 0:
                  if(_loc12_ != 0)
                  {
                     throw new IOError("Bad data format: ArtifactMsg.op cannot be set twice.");
                  }
                  _loc12_++;
                  op = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 1:
                  if(_loc6_ != 0)
                  {
                     throw new IOError("Bad data format: ArtifactMsg.templateId cannot be set twice.");
                  }
                  _loc6_++;
                  templateId = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 2:
                  if(_loc3_ != 0)
                  {
                     throw new IOError("Bad data format: ArtifactMsg.count cannot be set twice.");
                  }
                  _loc3_++;
                  count = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 3:
                  if(_loc9_ != 0)
                  {
                     throw new IOError("Bad data format: ArtifactMsg.isEquip cannot be set twice.");
                  }
                  _loc9_++;
                  isEquip = ReadUtils.read$TYPE_BOOL(param1);
                  break;
               case 4:
                  _loc8_ = new ArtifactInfoMsg();
                  ReadUtils.read$TYPE_MESSAGE(param1,_loc8_);
                  infos.push(_loc8_);
                  break;
               case 5:
                  if(_loc7_ != 0)
                  {
                     throw new IOError("Bad data format: ArtifactMsg.armoryId cannot be set twice.");
                  }
                  _loc7_++;
                  armoryId = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 6:
                  if(_loc10_ != 0)
                  {
                     throw new IOError("Bad data format: ArtifactMsg.pos cannot be set twice.");
                  }
                  _loc10_++;
                  pos = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 7:
                  _loc5_ = new ArmoryInfoMsg();
                  ReadUtils.read$TYPE_MESSAGE(param1,_loc5_);
                  armoryInfo.push(_loc5_);
                  break;
               case 9:
                  if((_loc11_ & 7) == 2)
                  {
                     ReadUtils.readPackedRepeated(param1,ReadUtils.read$TYPE_INT32,consumeArmoryIds);
                  }
                  else
                  {
                     consumeArmoryIds.push(ReadUtils.read$TYPE_INT32(param1));
                  }
                  break;
               case 10:
                  _loc4_ = new ResonatePosMsg();
                  ReadUtils.read$TYPE_MESSAGE(param1,_loc4_);
                  resonatePos.push(_loc4_);
                  break;
               default:
                  ReadUtils.skip(param1,_loc11_ & 7);
            }
         }
      }
   }
}

