package managers
{
   import com.road.yishi.proto.pet.PlayerPetOpMsg;
   import yishi.comm.ByteSocket;
   import yishi.comm.PackageOut;
   import yishi.service.managers.SocketManager;
   
   public class PetSocketOut
   {
      
      public function PetSocketOut()
      {
         super();
      }
      
      public static function sacrifice(param1:int) : void
      {
         var _loc3_:PackageOut = new PackageOut(8621);
         var _loc2_:PlayerPetOpMsg = new PlayerPetOpMsg();
         _loc2_.petId = param1;
         _loc2_.opType = 6;
         socket.sendProtobuffer(_loc3_,_loc2_);
      }
      
      public static function swallowPet(param1:int, param2:int, param3:int = -1) : void
      {
         var _loc5_:PackageOut = new PackageOut(8621);
         var _loc4_:PlayerPetOpMsg = new PlayerPetOpMsg();
         _loc4_.petId = param1;
         _loc4_.opType = 1;
         _loc4_.value = param2;
         _loc4_.payType = param3;
         socket.sendProtobuffer(_loc5_,_loc4_);
      }
      
      public static function enterWar(param1:int) : void
      {
         var _loc3_:PackageOut = new PackageOut(8621);
         var _loc2_:PlayerPetOpMsg = new PlayerPetOpMsg();
         _loc2_.petId = param1;
         _loc2_.opType = 9;
         socket.sendProtobuffer(_loc3_,_loc2_);
      }
      
      public static function rest(param1:int) : void
      {
         var _loc3_:PackageOut = new PackageOut(8621);
         var _loc2_:PlayerPetOpMsg = new PlayerPetOpMsg();
         _loc2_.petId = param1;
         _loc2_.opType = 10;
         socket.sendProtobuffer(_loc3_,_loc2_);
      }
      
      public static function addPoint(param1:int, param2:Array) : void
      {
         var _loc4_:int = 0;
         if(param2 == null || param2.length != 4)
         {
            return;
         }
         var _loc5_:PackageOut = new PackageOut(8621);
         var _loc3_:PlayerPetOpMsg = new PlayerPetOpMsg();
         _loc3_.petId = param1;
         _loc3_.opType = 2;
         _loc4_ = 0;
         while(_loc4_ < param2.length)
         {
            _loc3_.attributes.push(param2[_loc4_]);
            _loc4_++;
         }
         socket.sendProtobuffer(_loc5_,_loc3_);
      }
      
      public static function washPoint(param1:int, param2:Boolean) : void
      {
         var _loc4_:PackageOut = new PackageOut(8621);
         var _loc3_:PlayerPetOpMsg = new PlayerPetOpMsg();
         _loc3_.petId = param1;
         _loc3_.opType = 3;
         _loc3_.payType = 0;
         if(!param2)
         {
            _loc3_.payType = 1;
         }
         socket.sendProtobuffer(_loc4_,_loc3_);
      }
      
      public static function trainCoe(param1:int, param2:int = 1, param3:Boolean = true, param4:int = 0) : void
      {
         var _loc6_:PackageOut = new PackageOut(8621);
         var _loc5_:PlayerPetOpMsg = new PlayerPetOpMsg();
         _loc5_.petId = param1;
         _loc5_.opType = 7;
         _loc5_.value = param2;
         _loc5_.itemPos = param4;
         _loc5_.payType = 0;
         if(!param3)
         {
            _loc5_.payType = 1;
         }
         socket.sendProtobuffer(_loc6_,_loc5_);
      }
      
      public static function learnSkill(param1:int, param2:int, param3:int = 0, param4:Boolean = false) : void
      {
         var _loc6_:PackageOut = new PackageOut(8621);
         var _loc5_:PlayerPetOpMsg = new PlayerPetOpMsg();
         _loc5_.petId = param1;
         _loc5_.opType = 5;
         _loc5_.value = param3;
         _loc5_.skillId = param2;
         _loc5_.payType = param4 ? 0 : 1;
         socket.sendProtobuffer(_loc6_,_loc5_);
      }
      
      public static function quitSkill(param1:int, param2:int, param3:Boolean = false) : void
      {
         var _loc5_:PackageOut = new PackageOut(8621);
         var _loc4_:PlayerPetOpMsg = new PlayerPetOpMsg();
         _loc4_.petId = param1;
         _loc4_.opType = 18;
         _loc4_.skillId = param2;
         _loc4_.payType = param3 ? 0 : 1;
         socket.sendProtobuffer(_loc5_,_loc4_);
      }
      
      public static function trainResistance(param1:int, param2:int, param3:int) : void
      {
         var _loc5_:PackageOut = new PackageOut(8621);
         var _loc4_:PlayerPetOpMsg = new PlayerPetOpMsg();
         _loc4_.petId = param1;
         _loc4_.opType = 8;
         _loc4_.value = param2;
         _loc4_.itemPos = param3;
         socket.sendProtobuffer(_loc5_,_loc4_);
      }
      
      public static function trainGrowthRate(param1:int, param2:int = 1, param3:Boolean = true, param4:int = 0) : void
      {
         var _loc6_:PackageOut = new PackageOut(8621);
         var _loc5_:PlayerPetOpMsg = new PlayerPetOpMsg();
         _loc5_.petId = param1;
         _loc5_.opType = 4;
         _loc5_.value = param2;
         _loc5_.payType = 0;
         if(!param3)
         {
            _loc5_.payType = 1;
         }
         _loc5_.itemPos = param4;
         socket.sendProtobuffer(_loc6_,_loc5_);
      }
      
      public static function setSkillFastKey(param1:int, param2:String) : void
      {
         var _loc4_:PackageOut = new PackageOut(8621);
         var _loc3_:PlayerPetOpMsg = new PlayerPetOpMsg();
         _loc3_.petId = param1;
         _loc3_.opType = 11;
         _loc3_.petName = param2;
         socket.sendProtobuffer(_loc4_,_loc3_);
      }
      
      public static function addPetCarryNum(param1:int, param2:int = 0) : void
      {
         var _loc4_:PackageOut = new PackageOut(8621);
         var _loc3_:PlayerPetOpMsg = new PlayerPetOpMsg();
         _loc3_.opType = 12;
         _loc3_.payType = param2;
         _loc3_.value = param1;
         socket.sendProtobuffer(_loc4_,_loc3_);
      }
      
      public static function composePet(param1:int, param2:int = -1, param3:int = -1) : void
      {
         var _loc5_:PackageOut = new PackageOut(8621);
         var _loc4_:PlayerPetOpMsg = new PlayerPetOpMsg();
         _loc4_.opType = 13;
         _loc4_.petId = param1;
         _loc4_.skillId = param2;
         _loc4_.payType = param3;
         socket.sendProtobuffer(_loc5_,_loc4_);
      }
      
      public static function shiftToTop(param1:int) : void
      {
         var _loc3_:PackageOut = new PackageOut(8621);
         var _loc2_:PlayerPetOpMsg = new PlayerPetOpMsg();
         _loc2_.petId = param1;
         _loc2_.opType = 14;
         socket.sendProtobuffer(_loc3_,_loc2_);
      }
      
      public static function mixDoublePet(param1:int, param2:int, param3:int = -1, param4:int = -1) : void
      {
         var _loc6_:PackageOut = new PackageOut(8621);
         var _loc5_:PlayerPetOpMsg = new PlayerPetOpMsg();
         _loc5_.opType = 15;
         _loc5_.petId = param1;
         _loc5_.skillId = param3;
         _loc5_.value = param2;
         _loc5_.payType = param4;
         socket.sendProtobuffer(_loc6_,_loc5_);
      }
      
      public static function enterChildPet(param1:int, param2:int) : void
      {
         var _loc4_:PackageOut = new PackageOut(8621);
         var _loc3_:PlayerPetOpMsg = new PlayerPetOpMsg();
         _loc3_.opType = 16;
         _loc3_.petId = param1;
         _loc3_.fightType = param2;
         socket.sendProtobuffer(_loc4_,_loc3_);
      }
      
      public static function restChildPet(param1:int) : void
      {
         var _loc3_:PackageOut = new PackageOut(8621);
         var _loc2_:PlayerPetOpMsg = new PlayerPetOpMsg();
         _loc2_.opType = 17;
         _loc2_.petId = param1;
         socket.sendProtobuffer(_loc3_,_loc2_);
      }
      
      private static function get socket() : ByteSocket
      {
         return SocketManager.instance.socket;
      }
   }
}

