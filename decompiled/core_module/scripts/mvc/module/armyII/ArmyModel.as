package mvc.module.armyII
{
   import bag.view.BaseBagListView;
   import flash.events.EventDispatcher;
   import flash.utils.Dictionary;
   import yishi.datas.goods.GoodsInfo;
   import yishi.datas.playerinfo.PlayerInfo;
   import yishi.datas.playerinfo.ThaneInfo;
   import yishi.manager.ArmyManager;
   import yishi.manager.GoodsManager;
   import yishi.manager.PlayerManager;
   import yishi.manager.TempleteManager;
   import yishi.utils.SimpleDictionary;
   
   public class ArmyModel extends EventDispatcher
   {
      
      public static const RENTAL_PAGE_1:int = 5;
      
      public static const RENTAL_PAGE_2:int = 6;
      
      public static const PLAYER_BAG_COUNT:int = 56;
      
      public static const RENTAL_BAG_COUNT:int = 49;
      
      private var _currentOpenPanel:String;
      
      public var curBagType:int;
      
      public var curAcceptBagType:int;
      
      public var stoneBtnState:int = -1;
      
      public var oldEquip:SimpleDictionary;
      
      public var tempId1:int;
      
      public var count1:int;
      
      public var dragEnable:Boolean;
      
      public var addStrength:int;
      
      public var addAgility:int;
      
      public var addAbility:int;
      
      public var addPhysique:int;
      
      public var addCaptain:int;
      
      public var currentPage:int = 1;
      
      public var currentBag:BaseBagListView;
      
      public var currentSortType:int;
      
      private var _priceBagPerPage:int = 150;
      
      public var selectedStroeBag:Boolean = false;
      
      public function ArmyModel()
      {
         super();
         initData();
         _priceBagPerPage = int(TempleteManager.instance.getConfigInfoByConfigName("RentalBag_Per_Month").ConfigValue);
      }
      
      public function get priceBagPerPage() : int
      {
         return _priceBagPerPage;
      }
      
      public function get currentOpenPanel() : String
      {
         return _currentOpenPanel;
      }
      
      public function set currentOpenPanel(param1:String) : void
      {
         _currentOpenPanel = param1;
      }
      
      public function get uArmy() : UserArmy
      {
         return ArmyManager.instance.army;
      }
      
      private function get playerIno() : PlayerInfo
      {
         return PlayerManager.instance.currentPlayerModel.playerInfo;
      }
      
      private function initData() : void
      {
      }
      
      public function setCurrentPageByPos(param1:int) : void
      {
         if(param1 < 224)
         {
            currentPage = int(param1 / 56) + 1;
         }
         else if(param1 < 273)
         {
            currentPage = 5;
         }
         else if(param1 < 322)
         {
            currentPage = 6;
         }
      }
      
      public function autoAllocate() : void
      {
         var _loc2_:ArmyPawn = null;
         var _loc1_:Array = getCastlePawnByValue();
         if(_loc1_.length == 0)
         {
            return;
         }
         var _loc5_:ArmyPawn = uArmy.getPawnByIndex(0);
         var _loc4_:int = 0;
         var _loc3_:int = 0;
         if(_loc5_ && _loc5_.ownPawns != 0)
         {
            if(_loc5_.ownPawns >= thane.attackProrerty.totalConatArmy)
            {
               return;
            }
            _loc4_ = _loc5_.templateId;
            _loc3_ = getPawnNumber(_loc5_,null);
            if(_loc3_ == 0)
            {
               return;
            }
            uArmy.addArmyPawnCountByIndex(0,_loc3_);
         }
         else
         {
            _loc2_ = _loc1_[0] as ArmyPawn;
            _loc3_ = getPawnNumber(null,_loc2_);
            _loc4_ = _loc2_.templateId;
            uArmy.addNewPawnByIndex(0,_loc2_,_loc3_);
         }
         ArmyManager.instance.removePawnCountById(_loc4_,_loc3_);
      }
      
      private function getPawnNumber(param1:ArmyPawn, param2:ArmyPawn) : int
      {
         var _loc3_:int = 0;
         var _loc5_:int = 0;
         var _loc4_:int = int(param1 == null ? 0 : param1.ownPawns);
         if(!param2)
         {
            _loc5_ = getNewNumberByID(param1.templateId);
            _loc3_ = thane.attackProrerty.totalConatArmy / param1.templateInfo.NeedPopulation;
         }
         else
         {
            _loc5_ = getNewNumberByID(param2.templateId);
            _loc3_ = thane.attackProrerty.totalConatArmy / param2.templateInfo.NeedPopulation;
         }
         return _loc3_ - _loc4_ >= _loc5_ ? _loc5_ : _loc3_ - _loc4_;
      }
      
      public function getCastlePawnByValue() : Array
      {
         var _loc5_:Number = NaN;
         var _loc3_:int = 0;
         var _loc1_:Array = [];
         var _loc7_:Dictionary = new Dictionary();
         for each(var _loc4_:ArmyPawn in ArmyManager.instance.castlePawnList)
         {
            if(_loc4_ && _loc4_.ownPawns != 0)
            {
               _loc5_ = (_loc4_.attack + _loc4_.defence + _loc4_.magicAttack + _loc4_.magicDefence + _loc4_.live) * 50000 + int(_loc4_.templateInfo.NeedBuilding);
               _loc1_.push(_loc5_);
               _loc7_[_loc5_] = _loc4_;
            }
         }
         _loc1_.sort(0x10 | 2);
         var _loc6_:Array = [];
         var _loc2_:int = int(_loc1_.length);
         _loc3_ = 0;
         while(_loc3_ < _loc2_)
         {
            _loc6_.push(_loc7_[_loc1_[_loc3_]]);
            _loc3_++;
         }
         return _loc6_;
      }
      
      private function getNewNumberByID(param1:int) : int
      {
         if(ArmyManager.instance.getPawnById(param1))
         {
            return ArmyManager.instance.getPawnById(param1).ownPawns;
         }
         return 0;
      }
      
      public function hasEquipEffect(param1:String) : int
      {
         var _loc2_:SimpleDictionary = GoodsManager.instance.getHeroEquipListById(thane.id);
         for each(var _loc3_:GoodsInfo in _loc2_)
         {
            if(_loc3_.templateInfo[param1] > 0)
            {
               return 2;
            }
         }
         return 1;
      }
      
      public function hasAddedPoint() : Boolean
      {
         if(thane.baseProperty.addAgilityPoint + addAgility > 0)
         {
            return true;
         }
         if(thane.baseProperty.addIntellectPoint + addAbility > 0)
         {
            return true;
         }
         if(thane.baseProperty.addPowerPoint + addStrength > 0)
         {
            return true;
         }
         if(thane.baseProperty.addPhysiquePoint + addPhysique > 0)
         {
            return true;
         }
         if(thane.baseProperty.addCaptainPoint + addCaptain > 0)
         {
            return true;
         }
         return false;
      }
      
      private function get thane() : ThaneInfo
      {
         return ArmyManager.instance.thane;
      }
   }
}

