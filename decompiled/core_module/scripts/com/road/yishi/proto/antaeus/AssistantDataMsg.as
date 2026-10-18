package com.road.yishi.proto.antaeus
{
   import com.netease.protobuf.Message;
   import com.netease.protobuf.ReadUtils;
   import com.netease.protobuf.WriteUtils;
   import com.netease.protobuf.WritingBuffer;
   import flash.errors.IOError;
   import flash.utils.IDataInput;
   import flash.utils.IExternalizable;
   
   public final class AssistantDataMsg extends Message implements IExternalizable
   {
      
      private var player$field:AssistantPlayerShowMsg;
      
      private var pet$field:PetShowMsg;
      
      private var children$field:ChildrenShowMsg;
      
      private var slaveChild$field:SlaveChildShowMsg;
      
      private var artifact$field:ArtifactShowMsg;
      
      private var goddess$field:GoddessShowMsg;
      
      private var titan$field:TitanShowMsg;
      
      public function AssistantDataMsg()
      {
         super();
      }
      
      public function removePlayer() : void
      {
         player$field = null;
      }
      
      public function get hasPlayer() : Boolean
      {
         return player$field != null;
      }
      
      public function set player(param1:AssistantPlayerShowMsg) : void
      {
         player$field = param1;
      }
      
      public function get player() : AssistantPlayerShowMsg
      {
         return player$field;
      }
      
      public function removePet() : void
      {
         pet$field = null;
      }
      
      public function get hasPet() : Boolean
      {
         return pet$field != null;
      }
      
      public function set pet(param1:PetShowMsg) : void
      {
         pet$field = param1;
      }
      
      public function get pet() : PetShowMsg
      {
         return pet$field;
      }
      
      public function removeChildren() : void
      {
         children$field = null;
      }
      
      public function get hasChildren() : Boolean
      {
         return children$field != null;
      }
      
      public function set children(param1:ChildrenShowMsg) : void
      {
         children$field = param1;
      }
      
      public function get children() : ChildrenShowMsg
      {
         return children$field;
      }
      
      public function removeSlaveChild() : void
      {
         slaveChild$field = null;
      }
      
      public function get hasSlaveChild() : Boolean
      {
         return slaveChild$field != null;
      }
      
      public function set slaveChild(param1:SlaveChildShowMsg) : void
      {
         slaveChild$field = param1;
      }
      
      public function get slaveChild() : SlaveChildShowMsg
      {
         return slaveChild$field;
      }
      
      public function removeArtifact() : void
      {
         artifact$field = null;
      }
      
      public function get hasArtifact() : Boolean
      {
         return artifact$field != null;
      }
      
      public function set artifact(param1:ArtifactShowMsg) : void
      {
         artifact$field = param1;
      }
      
      public function get artifact() : ArtifactShowMsg
      {
         return artifact$field;
      }
      
      public function removeGoddess() : void
      {
         goddess$field = null;
      }
      
      public function get hasGoddess() : Boolean
      {
         return goddess$field != null;
      }
      
      public function set goddess(param1:GoddessShowMsg) : void
      {
         goddess$field = param1;
      }
      
      public function get goddess() : GoddessShowMsg
      {
         return goddess$field;
      }
      
      public function removeTitan() : void
      {
         titan$field = null;
      }
      
      public function get hasTitan() : Boolean
      {
         return titan$field != null;
      }
      
      public function set titan(param1:TitanShowMsg) : void
      {
         titan$field = param1;
      }
      
      public function get titan() : TitanShowMsg
      {
         return titan$field;
      }
      
      final override public function writeToBuffer(param1:WritingBuffer) : void
      {
         if(hasPlayer)
         {
            WriteUtils.writeTag(param1,2,1);
            WriteUtils.write$TYPE_MESSAGE(param1,player$field);
         }
         if(hasPet)
         {
            WriteUtils.writeTag(param1,2,2);
            WriteUtils.write$TYPE_MESSAGE(param1,pet$field);
         }
         if(hasChildren)
         {
            WriteUtils.writeTag(param1,2,3);
            WriteUtils.write$TYPE_MESSAGE(param1,children$field);
         }
         if(hasSlaveChild)
         {
            WriteUtils.writeTag(param1,2,4);
            WriteUtils.write$TYPE_MESSAGE(param1,slaveChild$field);
         }
         if(hasArtifact)
         {
            WriteUtils.writeTag(param1,2,5);
            WriteUtils.write$TYPE_MESSAGE(param1,artifact$field);
         }
         if(hasGoddess)
         {
            WriteUtils.writeTag(param1,2,6);
            WriteUtils.write$TYPE_MESSAGE(param1,goddess$field);
         }
         if(hasTitan)
         {
            WriteUtils.writeTag(param1,2,7);
            WriteUtils.write$TYPE_MESSAGE(param1,titan$field);
         }
      }
      
      final override public function readFromSlice(param1:IDataInput, param2:uint) : void
      {
         var _loc9_:* = 0;
         var _loc10_:uint = 0;
         var _loc7_:uint = 0;
         var _loc4_:uint = 0;
         var _loc6_:uint = 0;
         var _loc5_:uint = 0;
         var _loc8_:uint = 0;
         var _loc3_:uint = 0;
         while(param1.bytesAvailable > param2)
         {
            switch(((_loc9_ = ReadUtils.read$TYPE_UINT32(param1)) >>> 3) - 1)
            {
               case 0:
                  if(_loc10_ != 0)
                  {
                     throw new IOError("Bad data format: AssistantDataMsg.player cannot be set twice.");
                  }
                  _loc10_++;
                  player = new AssistantPlayerShowMsg();
                  ReadUtils.read$TYPE_MESSAGE(param1,player);
                  break;
               case 1:
                  if(_loc7_ != 0)
                  {
                     throw new IOError("Bad data format: AssistantDataMsg.pet cannot be set twice.");
                  }
                  _loc7_++;
                  pet = new PetShowMsg();
                  ReadUtils.read$TYPE_MESSAGE(param1,pet);
                  break;
               case 2:
                  if(_loc4_ != 0)
                  {
                     throw new IOError("Bad data format: AssistantDataMsg.children cannot be set twice.");
                  }
                  _loc4_++;
                  children = new ChildrenShowMsg();
                  ReadUtils.read$TYPE_MESSAGE(param1,children);
                  break;
               case 3:
                  if(_loc6_ != 0)
                  {
                     throw new IOError("Bad data format: AssistantDataMsg.slaveChild cannot be set twice.");
                  }
                  _loc6_++;
                  slaveChild = new SlaveChildShowMsg();
                  ReadUtils.read$TYPE_MESSAGE(param1,slaveChild);
                  break;
               case 4:
                  if(_loc5_ != 0)
                  {
                     throw new IOError("Bad data format: AssistantDataMsg.artifact cannot be set twice.");
                  }
                  _loc5_++;
                  artifact = new ArtifactShowMsg();
                  ReadUtils.read$TYPE_MESSAGE(param1,artifact);
                  break;
               case 5:
                  if(_loc8_ != 0)
                  {
                     throw new IOError("Bad data format: AssistantDataMsg.goddess cannot be set twice.");
                  }
                  _loc8_++;
                  goddess = new GoddessShowMsg();
                  ReadUtils.read$TYPE_MESSAGE(param1,goddess);
                  break;
               case 6:
                  if(_loc3_ != 0)
                  {
                     throw new IOError("Bad data format: AssistantDataMsg.titan cannot be set twice.");
                  }
                  _loc3_++;
                  titan = new TitanShowMsg();
                  ReadUtils.read$TYPE_MESSAGE(param1,titan);
                  break;
               default:
                  ReadUtils.skip(param1,_loc9_ & 7);
            }
         }
      }
   }
}

