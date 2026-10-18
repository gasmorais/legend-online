package mvc.controler
{
   import com.pickgliss.ui.controls.Frame;
   import flash.utils.Dictionary;
   import managers.MysteryShopManager;
   import mvc.FrameController;
   import mvc.ModuleFrameInfo;
   import mvc.module.auction.MysteryShopModel;
   import mvc.module.shop.ShopGoodsInfo;
   import yishi.keyboard.KeyBoardRegister;
   import yishi.manager.TempleteManager;
   
   public class MysteryShopControler extends FrameController
   {
      
      public function MysteryShopControler()
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
         KeyBoardRegister.instance.keyEnable = false;
      }
      
      override public function get frameClassName() : String
      {
         return "auction.MysteryShopFrame";
      }
      
      override protected function exitFrame() : void
      {
         KeyBoardRegister.instance.keyEnable = true;
         super.exitFrame();
      }
      
      public function get frame() : Frame
      {
         return _frame;
      }
      
      public function initRareGoodsData() : void
      {
         model.rareGoodsList = [];
         var _loc1_:Dictionary = TempleteManager.instance.getMysteryShopTemplateDic();
         if(_loc1_)
         {
            for each(var _loc2_:ShopGoodsInfo in _loc1_)
            {
               if(_loc2_.IsHot)
               {
                  model.rareGoodsList.push(_loc2_);
               }
            }
         }
      }
      
      public function initExchangeGoodsData() : void
      {
         model.exchangeGoodsList = [];
         var _loc1_:Dictionary = TempleteManager.instance.getMysteryExchangeShopTemplateDic();
         if(_loc1_)
         {
            for each(var _loc2_:ShopGoodsInfo in _loc1_)
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
      
      public function get model() : MysteryShopModel
      {
         return MysteryShopManager.instance.model;
      }
   }
}

