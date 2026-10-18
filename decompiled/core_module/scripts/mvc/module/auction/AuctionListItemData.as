package mvc.module.auction
{
   import com.road.pb.helper.item.ItemHelper;
   import com.road.yishi.proto.simple.SimpleItemInfoMsg;
   import flash.events.Event;
   import flash.events.EventDispatcher;
   import manager.LanguageMgr;
   import yishi.datas.goods.GoodsInfo;
   import yishi.manager.PlayerManager;
   
   [Event(name="change",type="flash.events.Event")]
   public class AuctionListItemData extends EventDispatcher
   {
      
      public var goodId:int;
      
      public var saler:String;
      
      public var hour:int;
      
      public var startTime:Date;
      
      public var fixedPrice:int = 10000;
      
      private var _auctioned:Boolean;
      
      public var selfPrice:int;
      
      private var _currPrice:int = 2000;
      
      private var _goodsInfo:GoodsInfo;
      
      public function AuctionListItemData()
      {
         super();
         _goodsInfo = new GoodsInfo();
      }
      
      public function get auctioned() : Boolean
      {
         return _auctioned;
      }
      
      public function set auctioned(param1:Boolean) : void
      {
         if(_auctioned != param1)
         {
            _auctioned = param1;
            dispatchEvent(new Event("change"));
         }
      }
      
      public function get currPrice() : int
      {
         return _currPrice;
      }
      
      public function get timeLeft() : String
      {
         var _loc1_:String = "";
         var _loc3_:Number = PlayerManager.instance.currentPlayerModel.nowDate - startTime.time;
         var _loc2_:Number = hour * 3600 * 1000 - _loc3_;
         _loc2_ /= 3600000;
         if(_loc2_ >= 12)
         {
            _loc1_ = LanguageMgr.GetTranslation("Auction.LeftTime1");
         }
         else if(_loc2_ >= 2 && _loc2_ < 12)
         {
            _loc1_ = LanguageMgr.GetTranslation("Auction.LeftTime2");
         }
         else if(_loc2_ >= 0.5 && _loc2_ < 2)
         {
            _loc1_ = LanguageMgr.GetTranslation("Auction.LeftTime3");
         }
         else
         {
            _loc1_ = LanguageMgr.GetTranslation("Auction.LeftTime4");
         }
         return _loc1_;
      }
      
      public function get grade() : int
      {
         if(_goodsInfo.petData && _goodsInfo.petData.template)
         {
            return _goodsInfo.petData.grade;
         }
         if(_goodsInfo.templateInfo)
         {
            return _goodsInfo.templateInfo.NeedGrades;
         }
         return 0;
      }
      
      public function get name() : String
      {
         if(_goodsInfo.petData && _goodsInfo.petData.template)
         {
            return _goodsInfo.petData.template.TemplateName;
         }
         if(_goodsInfo.templateInfo)
         {
            return _goodsInfo.templateInfo.TemplateName;
         }
         return "";
      }
      
      public function set currPrice(param1:int) : void
      {
         _currPrice = param1;
         dispatchEvent(new Event("change"));
      }
      
      public function initGoodsInfo(param1:SimpleItemInfoMsg) : void
      {
         _goodsInfo = ItemHelper.readGoodsInfo2(param1,_goodsInfo);
      }
      
      public function getGoodsInfo() : GoodsInfo
      {
         return _goodsInfo;
      }
   }
}

