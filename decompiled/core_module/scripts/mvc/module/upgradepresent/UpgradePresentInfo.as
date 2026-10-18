package mvc.module.upgradepresent
{
   import manager.LanguageMgr;
   import mvc.module.shop.ShopGoodsInfo;
   import yishi.datas.playerinfo.PlayerModel;
   import yishi.datas.playerinfo.ThaneInfo;
   import yishi.manager.ArmyManager;
   import yishi.manager.PlayerManager;
   import yishi.manager.TempleteManager;
   import yishi.manager.UpgradePresentManager;
   import yishi.utils.DateFormatter;
   
   public class UpgradePresentInfo
   {
      
      public var area:int;
      
      public var endTime:Number;
      
      public var shopIdArr:Array;
      
      public var boughtCountArr:Array;
      
      public var isExpire:Boolean;
      
      public var limitCountArr:Array;
      
      public function UpgradePresentInfo()
      {
         super();
         limitCountArr = [];
         shopIdArr = [];
         boughtCountArr = [];
      }
      
      public function get isOpen() : Boolean
      {
         return thane.grades >= area;
      }
      
      public function get leftTimeStr() : String
      {
         var _loc1_:Number = endTime - playerModel.sysSecond;
         if(_loc1_ <= 0)
         {
            return LanguageMgr.GetTranslation("yishi.view.tips.goods.EquipTip.timeStr02");
         }
         return DateFormatter.getFullDateHtmlString(_loc1_,"#ff0000");
      }
      
      public function get isCanBuy() : Boolean
      {
         var _loc4_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         if(!isOpen)
         {
            return false;
         }
         if(isExpire)
         {
            return false;
         }
         var _loc1_:int = int(shopIdArr.length);
         _loc4_ = 0;
         while(_loc4_ < _loc1_)
         {
            _loc2_ = int(limitCountArr[_loc4_]);
            _loc3_ = int(boughtCountArr[_loc4_]);
            if(_loc2_ > _loc3_)
            {
               return true;
            }
            _loc4_++;
         }
         return false;
      }
      
      public function setPresentInfo() : void
      {
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         var _loc4_:ShopGoodsInfo = null;
         isExpire = endTime <= playerModel.sysSecond;
         limitCountArr = [];
         var _loc1_:int = int(shopIdArr.length);
         _loc2_ = 0;
         while(_loc2_ < _loc1_)
         {
            _loc3_ = int(shopIdArr[_loc2_]);
            _loc4_ = TempleteManager.instance.getUpgradePresentShopTemplateDic()[_loc3_];
            if(_loc4_)
            {
               limitCountArr.push(_loc4_.SellMaxCount);
            }
            _loc2_++;
         }
      }
      
      public function get rewardArr() : Array
      {
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         var _loc5_:ShopGoodsInfo = null;
         var _loc4_:Array = [];
         var _loc1_:int = int(shopIdArr.length);
         _loc2_ = 0;
         while(_loc2_ < _loc1_)
         {
            _loc3_ = int(shopIdArr[_loc2_]);
            _loc5_ = TempleteManager.instance.getUpgradePresentShopTemplateDic()[_loc3_];
            if(_loc5_)
            {
               _loc4_.push(TempleteManager.instance.upgradePresentBoxDropTempCate.getTemplateListByBoxId(_loc5_.ItemId));
            }
            _loc2_++;
         }
         return _loc4_;
      }
      
      public function get thane() : ThaneInfo
      {
         return ArmyManager.instance.thane;
      }
      
      public function get playerModel() : PlayerModel
      {
         return PlayerManager.instance.currentPlayerModel;
      }
      
      public function get model() : UpgradePresentModel
      {
         return UpgradePresentManager.instance.model;
      }
   }
}

