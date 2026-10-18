package mvc.module.remotepet
{
   import events.RemotePetEvent;
   import flash.events.EventDispatcher;
   import flash.utils.clearTimeout;
   import flash.utils.setTimeout;
   import yishi.comm.PackageIn;
   import yishi.datas.templates.RemotePetTurnTemplateInfo;
   import yishi.manager.FrameControllerManager;
   import yishi.manager.SocketSceneBufferManager;
   import yishi.manager.TempleteManager;
   
   public class RemotePetModel extends EventDispatcher
   {
      
      public var isGet:Boolean;
      
      public var fristRst:Boolean = true;
      
      public var orderTime:Date;
      
      private var enterArr:Array = [1,2,3,7];
      
      public var mopupList:Array = [];
      
      public var lastOrder:int;
      
      private var _mopupCount:int;
      
      public var orderList:Vector.<RemotePetOrderInfo>;
      
      public var isFrist:Boolean = true;
      
      public var selectItem:RemotePetFriendInfo;
      
      public var friendList:Array;
      
      private var _turnInfo:RemotePetTurnInfo;
      
      private var _petListInfo:RemotePetListInfo;
      
      public var skillString:String;
      
      private var _rank:int;
      
      public function RemotePetModel()
      {
         super();
         _turnInfo = new RemotePetTurnInfo();
         _petListInfo = new RemotePetListInfo();
         selectItem = new RemotePetFriendInfo();
         selectItem = null;
         orderList = new Vector.<RemotePetOrderInfo>();
      }
      
      public function get remotePetSkill() : Array
      {
         var _loc1_:Array = null;
         var _loc2_:Array = [];
         if(skillString)
         {
            for each(var _loc3_:String in skillString.split("|"))
            {
               if(_loc3_)
               {
                  _loc1_ = _loc3_.split(",");
                  _loc2_.push(_loc1_[0]);
               }
            }
         }
         _loc2_.sort(16);
         return _loc2_;
      }
      
      public function get petListInfo() : RemotePetListInfo
      {
         return _petListInfo;
      }
      
      public function get turnInfo() : RemotePetTurnInfo
      {
         return _turnInfo;
      }
      
      public function petChange(param1:Object = null) : void
      {
         dispatchEvent(new RemotePetEvent("PET_CHANGE",param1));
      }
      
      public function commitTurnList() : void
      {
         dispatchEvent(new RemotePetEvent("Turn_LIST"));
      }
      
      public function commitFriend() : void
      {
         dispatchEvent(new RemotePetEvent("FRIEND_LIST"));
      }
      
      public function commit() : void
      {
         dispatchEvent(new RemotePetEvent("COMMIT"));
      }
      
      public function updateOrderList() : void
      {
         dispatchEvent(new RemotePetEvent("ORDERDATA_LOAD_COMPLETE"));
      }
      
      public function updateMopup(param1:Object = null) : void
      {
         dispatchEvent(new RemotePetEvent("UPDATEMOPUP",param1));
      }
      
      public function get maxMopupTurn() : int
      {
         var _loc1_:RemotePetTurnTemplateInfo = null;
         if(_turnInfo.maxTurn > 0)
         {
            _loc1_ = TempleteManager.instance.remotePetTemplateCate.getTemplateById(_turnInfo.maxTurn,1);
            return _loc1_.SweepIndex;
         }
         return 0;
      }
      
      public function updatePage() : void
      {
         dispatchEvent(new RemotePetEvent("PAGE_UPDATE"));
      }
      
      public function get mopupCount() : int
      {
         return _mopupCount;
      }
      
      public function set mopupCount(param1:int) : void
      {
         var id:int;
         var value:int = param1;
         if(_mopupCount == value)
         {
            return;
         }
         _mopupCount = value;
         if(_mopupCount > 0)
         {
            id = int(setTimeout(function():void
            {
               clearTimeout(id);
               SocketSceneBufferManager.instance.addPkgToBuffer(new PackageIn(),"SPACE_SCENE",enterSpaceShow);
            },1000));
         }
      }
      
      public function enterSpaceShow(param1:PackageIn) : void
      {
         FrameControllerManager.instance.openControllerByInfo("mopup",6);
      }
      
      public function get enterWarNum() : int
      {
         var _loc2_:int = 0;
         var _loc1_:int = 0;
         _loc2_ = 0;
         while(_loc2_ < enterArr.length)
         {
            if(_petListInfo.petList[enterArr[_loc2_]])
            {
               _loc1_++;
            }
            _loc2_++;
         }
         return _loc1_;
      }
      
      public function get rank() : int
      {
         return _rank;
      }
      
      public function set rank(param1:int) : void
      {
         if(_rank == param1)
         {
            return;
         }
         _rank = param1;
         dispatchEvent(new RemotePetEvent("PAGE_UPDATE"));
      }
   }
}

