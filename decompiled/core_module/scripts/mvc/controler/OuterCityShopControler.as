package mvc.controler
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.Frame;
   import flash.events.Event;
   import flash.utils.Dictionary;
   import managers.OuterCityShopManager;
   import mvc.FrameController;
   import mvc.ModuleFrameInfo;
   import mvc.module.outercityshop.OuterCityShopGoodsInfo;
   import mvc.module.outercityshop.OuterCityShopModel;
   import yishi.manager.TempleteManager;
   
   public class OuterCityShopControler extends FrameController
   {
      
      private var _goodsFrame:Frame;
      
      public function OuterCityShopControler()
      {
         super();
      }
      
      override public function start(param1:ModuleFrameInfo = null) : void
      {
         super.start(param1);
      }
      
      override protected function showFrame() : void
      {
         super.showFrame();
         _frame["show"]();
      }
      
      public function get frame() : Frame
      {
         return _frame;
      }
      
      override public function get frameClassName() : String
      {
         return "outercityshop.OuterCityShopFrame";
      }
      
      public function openGoodsFrame() : void
      {
         _goodsFrame = ComponentFactory.Instance.creatComponentByStylename("outercityshop.goodsFrame");
         _goodsFrame.addEventListener("dispose",__goodsFrameHandler);
         _goodsFrame["show"]();
         initLookGoodsData();
      }
      
      private function __goodsFrameHandler(param1:Event) : void
      {
         _goodsFrame.removeEventListener("dispose",__goodsFrameHandler);
         _goodsFrame = null;
      }
      
      public function initExchangeGoodsData() : void
      {
         model.exchangeGoodsList = [];
         var _loc1_:Dictionary = TempleteManager.instance.outerCityShopExchangeTemplateDic;
         if(_loc1_)
         {
            for each(var _loc2_:OuterCityShopGoodsInfo in _loc1_)
            {
               model.exchangeGoodsList.push(_loc2_);
            }
         }
         model.exchangeGoodsList.sortOn(["Sort"],[16]);
         model.resetData();
         model.updateShowGoodsList();
      }
      
      public function pageBtnHandler(param1:Boolean) : void
      {
         if(param1 && model.currentPage > 1)
         {
            model.currentPage--;
         }
         else
         {
            if(!(!param1 && model.currentPage < model.totalPage))
            {
               return;
            }
            model.currentPage++;
         }
         model.updateShowGoodsList();
      }
      
      public function initLookGoodsData() : void
      {
         model.lookGoodsList = [];
         var _loc1_:Dictionary = TempleteManager.instance.outerCityShopRandomTemplateDic;
         if(_loc1_)
         {
            for each(var _loc2_:OuterCityShopGoodsInfo in _loc1_)
            {
               if(_loc2_.IsDrop == 1)
               {
                  model.lookGoodsList.push(_loc2_);
               }
            }
         }
         model.lookGoodsList.sortOn(["Sort"],[16]);
         model.resetLookData();
         model.updateShowLookGoodsList();
      }
      
      public function pageLookHandler(param1:Boolean) : void
      {
         if(param1 && model.currentLookPage > 1)
         {
            model.currentLookPage--;
         }
         else
         {
            if(!(!param1 && model.currentLookPage < model.totalLookPage))
            {
               return;
            }
            model.currentLookPage++;
         }
         model.updateShowLookGoodsList();
      }
      
      private function get model() : OuterCityShopModel
      {
         return OuterCityShopManager.instance.model;
      }
   }
}

