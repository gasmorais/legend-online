package mvc.module.shop
{
   import managers.ShopManager;
   import yishi.datas.playerinfo.PlayerModel;
   import yishi.datas.templates.GoodsTemplateInfo;
   import yishi.manager.PlayerManager;
   import yishi.manager.TempleteManager;
   
   public class MainShopInfo
   {
      
      public var id:int;
      
      private var _type:int;
      
      public var site:int;
      
      public var isGift:Boolean;
      
      public var shopId:int;
      
      public var templateId:int;
      
      public var counts:int;
      
      public var needVIPGrade:int;
      
      public var sortName:String;
      
      public var shopId1:int;
      
      public var templateId1:int;
      
      public var count1:int;
      
      public var shopId2:int;
      
      public var templateId2:int;
      
      public var count2:int;
      
      public var shopId3:int;
      
      public var templateId3:int;
      
      public var count3:int;
      
      public var shopId4:int;
      
      public var templateId4:int;
      
      public var count4:int;
      
      public var shopId5:int;
      
      public var templateId5:int;
      
      public var count5:int;
      
      public var shopId6:int;
      
      public var templateId6:int;
      
      public var count6:int;
      
      public var shopId7:int;
      
      public var templateId7:int;
      
      public var count7:int;
      
      public var shopId8:int;
      
      public var templateId8:int;
      
      public var count8:int;
      
      public var sortId:int;
      
      public var discount:Number;
      
      public var beginDate:Number;
      
      public var endDate:Number;
      
      public var currentCount:int;
      
      public var oneDayCount:int;
      
      public var oneCurrentCount:int;
      
      public var maxCount:int;
      
      public var maxCurrentDate:Number;
      
      public var url:String;
      
      public var names:String;
      
      public var isDiscount:int;
      
      private var _content:String;
      
      private var _price:int;
      
      private var _count:int = 0;
      
      public var limitCount:int = 0;
      
      private var _promotionCount:int = 0;
      
      public var promotionlimitCount:int = 0;
      
      private var _refreshInterval:int;
      
      public var level1:int;
      
      public var price1:int;
      
      public var level2:int;
      
      public var price2:int;
      
      public var level3:int;
      
      public var price3:int;
      
      public var sendDate:Number;
      
      public function MainShopInfo()
      {
         super();
      }
      
      public function get canTotalCount() : int
      {
         var _loc2_:Date = null;
         var _loc1_:Date = null;
         if(maxCount == -1)
         {
            return -1;
         }
         if(_type != 2)
         {
            _loc2_ = new Date();
            _loc2_.time = maxCurrentDate * 1000;
            _loc1_ = new Date();
            _loc1_.time = playerModel.sysCurTimeBySecond * 1000;
            if(_loc2_.fullYear == _loc1_.fullYear && _loc2_.month == _loc1_.month && _loc2_.day == _loc1_.day)
            {
               if(maxCount - currentCount < 0)
               {
                  return 0;
               }
               return maxCount - currentCount;
            }
            return maxCount;
         }
         if(maxCount - currentCount < 0)
         {
            return 0;
         }
         return maxCount - currentCount;
      }
      
      public function get canOneCount() : int
      {
         if(type == 1)
         {
            if(oneDayCount == -1)
            {
               return -1;
            }
            if(oneDayCount - oneCurrentCount > 0)
            {
               return oneDayCount - oneCurrentCount;
            }
            return 0;
         }
         if(type == 2)
         {
            return oneDayCount - count;
         }
         if(type == 5)
         {
            return oneDayCount - ShopManager.Instance.dayGiftCount;
         }
         if(type == 4)
         {
            return oneDayCount - count;
         }
         if(type == 6)
         {
            return oneDayCount - ShopManager.Instance.costGiftCount;
         }
         if(type == 7)
         {
            return oneDayCount - count;
         }
         return 0;
      }
      
      public function get canBuyNum() : int
      {
         return Math.min(canOneCount,canTotalCount);
      }
      
      public function get remainTime() : Number
      {
         var _loc1_:Number = NaN;
         if(beginDate < playerModel.sysCurTimeBySecond)
         {
            _loc1_ = endDate - playerModel.sysCurTimeBySecond;
            if(_loc1_ > 0)
            {
               return _loc1_;
            }
            return 0;
         }
         return 0;
      }
      
      public function setPrice(param1:int) : void
      {
         _price = param1;
      }
      
      public function setContent() : void
      {
         _content = "";
         var _loc1_:GoodsTemplateInfo = TempleteManager.instance.goodsTemplateCate.getTemplateByID(templateId);
         if(_loc1_)
         {
            _content += _loc1_.TemplateName;
            if(counts > 0)
            {
               _content += " x" + counts;
            }
         }
         _loc1_ = TempleteManager.instance.goodsTemplateCate.getTemplateByID(templateId1);
         if(_loc1_)
         {
            _content += "," + _loc1_.TemplateName;
            if(count1 > 0)
            {
               _content += " x" + count1;
            }
         }
         _loc1_ = TempleteManager.instance.goodsTemplateCate.getTemplateByID(templateId2);
         if(_loc1_)
         {
            _content += "," + _loc1_.TemplateName;
            if(count2 > 0)
            {
               _content += " x" + count2;
            }
         }
         _loc1_ = TempleteManager.instance.goodsTemplateCate.getTemplateByID(templateId3);
         if(_loc1_)
         {
            _content += "," + _loc1_.TemplateName;
            if(count3 > 0)
            {
               _content += " x" + count3;
            }
         }
         _loc1_ = TempleteManager.instance.goodsTemplateCate.getTemplateByID(templateId4);
         if(_loc1_)
         {
            _content += "," + _loc1_.TemplateName;
            if(count4 > 0)
            {
               _content += " x" + count4;
            }
         }
         _loc1_ = TempleteManager.instance.goodsTemplateCate.getTemplateByID(templateId5);
         if(_loc1_)
         {
            _content += "," + _loc1_.TemplateName;
            if(count5 > 0)
            {
               _content += " x" + count5;
            }
         }
         _loc1_ = TempleteManager.instance.goodsTemplateCate.getTemplateByID(templateId6);
         if(_loc1_)
         {
            _content += "," + _loc1_.TemplateName;
            if(count6 > 0)
            {
               _content += " x" + count6;
            }
         }
         _loc1_ = TempleteManager.instance.goodsTemplateCate.getTemplateByID(templateId7);
         if(_loc1_)
         {
            _content += "," + _loc1_.TemplateName;
            if(count7 > 0)
            {
               _content += " x" + count7;
            }
         }
         _loc1_ = TempleteManager.instance.goodsTemplateCate.getTemplateByID(templateId8);
         if(_loc1_)
         {
            _content += "," + _loc1_.TemplateName;
            if(count8 > 0)
            {
               _content += " x" + count8;
            }
         }
      }
      
      public function get content() : String
      {
         return _content;
      }
      
      public function get price() : int
      {
         return _price;
      }
      
      private function get playerModel() : PlayerModel
      {
         return PlayerManager.instance.currentPlayerModel;
      }
      
      public function get type() : int
      {
         return _type;
      }
      
      public function set type(param1:int) : void
      {
         _type = param1;
      }
      
      public function get count() : int
      {
         return _count;
      }
      
      public function get promotionCount() : int
      {
         return _promotionCount;
      }
      
      public function set refreshInterval(param1:int) : void
      {
         this._refreshInterval = param1;
      }
      
      public function get refreshInterval() : int
      {
         if(_refreshInterval <= 0)
         {
            return 3600;
         }
         return this._refreshInterval;
      }
      
      public function set count(param1:int) : void
      {
         _count = param1;
      }
      
      public function set promotionCount(param1:int) : void
      {
         _promotionCount = param1;
      }
   }
}

