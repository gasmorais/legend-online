package mvc.module.upgradepresent
{
   import flash.utils.Dictionary;
   import mvc.module.shop.ShopGoodsInfo;
   import yishi.datas.playerinfo.ThaneInfo;
   import yishi.manager.ArmyManager;
   import yishi.manager.TempleteManager;
   import yishi.utils.MsgMan;
   
   public class UpgradePresentModel
   {
      
      public var presentList:Array;
      
      private var areaTempDic:Dictionary;
      
      public var showMaxPage:int;
      
      public var infoTipNum:int;
      
      private var preInfoTipNum:int;
      
      public function UpgradePresentModel()
      {
         super();
         if(presentList == null)
         {
            presentList = [];
         }
         if(areaTempDic == null)
         {
            areaTempDic = new Dictionary(true);
         }
         setShopTempData();
      }
      
      private function setShopTempData() : void
      {
         var _loc2_:Dictionary = TempleteManager.instance.getUpgradePresentShopTemplateDic();
         for each(var _loc1_:ShopGoodsInfo in _loc2_)
         {
            if(areaTempDic[_loc1_.Area] == null)
            {
               areaTempDic[_loc1_.Area] = [];
            }
            areaTempDic[_loc1_.Area].push(_loc1_);
         }
      }
      
      public function getShopTempListByArea(param1:int) : Array
      {
         return areaTempDic[param1];
      }
      
      public function getPresentInfoByArea(param1:int) : UpgradePresentInfo
      {
         for each(var _loc2_:UpgradePresentInfo in presentList)
         {
            if(_loc2_.area == param1)
            {
               return _loc2_;
            }
         }
         return null;
      }
      
      public function setModelData(param1:Boolean = false) : void
      {
         showMaxPage = 0;
         infoTipNum = 0;
         for each(var _loc2_:UpgradePresentInfo in presentList)
         {
            if(param1)
            {
               _loc2_.setPresentInfo();
            }
            if(_loc2_.isCanBuy)
            {
               infoTipNum = infoTipNum + 1;
            }
            if(_loc2_.isOpen)
            {
               showMaxPage = showMaxPage + 1;
            }
         }
         if(param1 && preInfoTipNum != infoTipNum)
         {
            MsgMan.notifyObserver("UPGRADE_PRESNET_INFO_CHANGE");
         }
         preInfoTipNum = infoTipNum;
      }
      
      public function get isShowBtn() : Boolean
      {
         return infoTipNum > 0;
      }
      
      private function get thane() : ThaneInfo
      {
         return ArmyManager.instance.thane;
      }
   }
}

