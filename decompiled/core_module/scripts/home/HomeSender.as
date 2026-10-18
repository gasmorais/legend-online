package home
{
   import com.road.yishi.proto.children.ChildrenOpMsg;
   import manager.LanguageMgr;
   import yishi.comm.PackageOut;
   import yishi.manager.ArmyManager;
   import yishi.service.managers.SocketManager;
   import yishi.view.tips.MessageTipManager;
   
   public class HomeSender
   {
      
      public static const UPGRADE_HOUSE:int = 1;
      
      public static const BUY_FURNITURE:int = 2;
      
      public static const FURNITURE:int = 3;
      
      public static const CONFIRM_COURUSER:int = 4;
      
      public static const UPGRADE_HOME:int = 5;
      
      public static const COURTYARD_FURNITURE:int = 6;
      
      public static const COURTYARD_GET_REWARD:int = 7;
      
      public static const COURTYARD_EMPLOY:int = 8;
      
      public static const COURTYARD_REQUEST_REWARD:int = 9;
      
      public static const MAID_RENEW:int = 10;
      
      public static const BUY_HOUSE:int = 1001;
      
      public static const ENTER_COURTYARD:int = 1002;
      
      public static const ENTER_HOUSE:int = 1003;
      
      public static const RANDOM_EVENT:int = 1004;
      
      public static const SELECT_HOME:int = 1005;
      
      public function HomeSender()
      {
         super();
      }
      
      public static function requestReward() : void
      {
         var _loc2_:PackageOut = new PackageOut(8873);
         var _loc1_:ChildrenOpMsg = new ChildrenOpMsg();
         _loc1_.opType = 9;
         SocketManager.instance.socket.sendProtobuffer(_loc2_,_loc1_);
      }
      
      public static function getReward() : void
      {
         var _loc2_:PackageOut = new PackageOut(8873);
         var _loc1_:ChildrenOpMsg = new ChildrenOpMsg();
         _loc1_.opType = 7;
         SocketManager.instance.socket.sendProtobuffer(_loc2_,_loc1_);
      }
      
      public static function reEmploy(param1:Boolean) : void
      {
         var _loc3_:PackageOut = new PackageOut(8873);
         var _loc2_:ChildrenOpMsg = new ChildrenOpMsg();
         _loc2_.opType = 10;
         if(param1)
         {
            _loc2_.payType = 0;
         }
         else
         {
            _loc2_.payType = 1;
         }
         SocketManager.instance.socket.sendProtobuffer(_loc3_,_loc2_);
      }
      
      public static function employ(param1:Boolean) : void
      {
         var _loc3_:PackageOut = new PackageOut(8873);
         var _loc2_:ChildrenOpMsg = new ChildrenOpMsg();
         _loc2_.opType = 8;
         if(param1)
         {
            _loc2_.payType = 0;
         }
         else
         {
            _loc2_.payType = 1;
         }
         SocketManager.instance.socket.sendProtobuffer(_loc3_,_loc2_);
      }
      
      public static function setFurnitureHouse(param1:Array) : void
      {
         var _loc3_:PackageOut = new PackageOut(8873);
         var _loc2_:ChildrenOpMsg = new ChildrenOpMsg();
         _loc2_.opType = 3;
         _loc2_.furniture = param1;
         SocketManager.instance.socket.sendProtobuffer(_loc3_,_loc2_);
      }
      
      public static function setFurnitureHome(param1:Array) : void
      {
         var _loc3_:PackageOut = new PackageOut(8873);
         var _loc2_:ChildrenOpMsg = new ChildrenOpMsg();
         _loc2_.opType = 6;
         _loc2_.furniture = param1;
         SocketManager.instance.socket.sendProtobuffer(_loc3_,_loc2_);
      }
      
      public static function enterHome(param1:int) : void
      {
         var _loc3_:PackageOut = new PackageOut(8873);
         var _loc2_:ChildrenOpMsg = new ChildrenOpMsg();
         _loc2_.opType = 1002;
         _loc2_.property1 = param1;
         SocketManager.instance.socket.sendProtobuffer(_loc3_,_loc2_);
      }
      
      public static function enterHouse(param1:int) : void
      {
         var _loc3_:PackageOut = new PackageOut(8873);
         var _loc2_:ChildrenOpMsg = new ChildrenOpMsg();
         _loc2_.opType = 1003;
         _loc2_.property1 = param1;
         SocketManager.instance.socket.sendProtobuffer(_loc3_,_loc2_);
      }
      
      public static function buyHouse() : void
      {
         if(ArmyManager.instance.thane.grades < 70)
         {
            MessageTipManager.instance().show(LanguageMgr.GetTranslation("home.HomeSender.enterHouse.Tip2",70));
            return;
         }
         var _loc2_:PackageOut = new PackageOut(8873);
         var _loc1_:ChildrenOpMsg = new ChildrenOpMsg();
         _loc1_.opType = 1001;
         SocketManager.instance.socket.sendProtobuffer(_loc2_,_loc1_);
      }
      
      public static function upgradeHouse(param1:Boolean = false) : void
      {
         var _loc3_:PackageOut = new PackageOut(8873);
         var _loc2_:ChildrenOpMsg = new ChildrenOpMsg();
         _loc2_.opType = 1;
         if(param1)
         {
            _loc2_.payType = 0;
         }
         else
         {
            _loc2_.payType = 1;
         }
         SocketManager.instance.socket.sendProtobuffer(_loc3_,_loc2_);
      }
      
      public static function upgradeHome(param1:Boolean = false) : void
      {
         var _loc3_:PackageOut = new PackageOut(8873);
         var _loc2_:ChildrenOpMsg = new ChildrenOpMsg();
         _loc2_.opType = 5;
         if(param1)
         {
            _loc2_.payType = 0;
         }
         else
         {
            _loc2_.payType = 1;
         }
         SocketManager.instance.socket.sendProtobuffer(_loc3_,_loc2_);
      }
      
      public static function buyFurniture(param1:int, param2:Boolean = true) : void
      {
         var _loc4_:PackageOut = new PackageOut(8873);
         var _loc3_:ChildrenOpMsg = new ChildrenOpMsg();
         _loc3_.opType = 2;
         _loc3_.property1 = param1;
         if(param2)
         {
            _loc3_.payType = 0;
         }
         else
         {
            _loc3_.payType = 1;
         }
         SocketManager.instance.socket.sendProtobuffer(_loc4_,_loc3_);
      }
      
      public static function confirmHomeMastre(param1:int) : void
      {
         var _loc3_:PackageOut = new PackageOut(8873);
         var _loc2_:ChildrenOpMsg = new ChildrenOpMsg();
         _loc2_.opType = 4;
         _loc2_.property1 = param1;
         SocketManager.instance.socket.sendProtobuffer(_loc3_,_loc2_);
      }
      
      public static function requestHomeInfoByUserId(param1:int) : void
      {
         var _loc3_:PackageOut = new PackageOut(8873);
         var _loc2_:ChildrenOpMsg = new ChildrenOpMsg();
         _loc2_.opType = 1005;
         _loc2_.property1 = param1;
         SocketManager.instance.socket.sendProtobuffer(_loc3_,_loc2_);
      }
      
      public static function clickFurniture(param1:int) : void
      {
         var _loc3_:PackageOut = new PackageOut(8873);
         var _loc2_:ChildrenOpMsg = new ChildrenOpMsg();
         _loc2_.opType = 1004;
         _loc2_.property1 = param1;
         SocketManager.instance.socket.sendProtobuffer(_loc3_,_loc2_);
      }
   }
}

