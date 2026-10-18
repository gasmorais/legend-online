package mvc.module.skytreasure
{
   import manager.LanguageMgr;
   import yishi.datas.goods.GoodsInfo;
   
   public class SkyTreasureExchangeItemInfo
   {
      
      private var _templateId:int;
      
      private var _limitType:int;
      
      private var _limitNum:int;
      
      private var _goodsInfo:GoodsInfo;
      
      private var _costNum:int;
      
      public function SkyTreasureExchangeItemInfo(param1:int, param2:int, param3:int, param4:int, param5:int)
      {
         super();
         _templateId = param1;
         _limitType = param3;
         _costNum = param5;
         _limitNum = param4;
         _goodsInfo = new GoodsInfo();
         _goodsInfo.templateId = param1;
         _goodsInfo.count = param2;
      }
      
      public function get limitType() : int
      {
         return _limitType;
      }
      
      public function get templateId() : int
      {
         return _templateId;
      }
      
      public function get limitNum() : int
      {
         return _limitNum;
      }
      
      public function get exchangeCostNum() : int
      {
         return _costNum;
      }
      
      public function get goodsInfo() : GoodsInfo
      {
         return _goodsInfo;
      }
      
      public function get LimitDesc() : String
      {
         var _loc1_:String = "";
         switch(_limitType)
         {
            case 0:
               _loc1_ = LanguageMgr.GetTranslation("SkyTreasureExchangeLimitType.NoLimitNum");
               break;
            case 1:
               _loc1_ = LanguageMgr.GetTranslation("SkyTreasureExchangeLimitType.LimitTotalNum");
               break;
            case 2:
               _loc1_ = LanguageMgr.GetTranslation("SkyTreasureExchangeLimitType.LimitDayNum");
         }
         return _loc1_;
      }
   }
}

