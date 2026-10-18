package christmas
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.container.HBox;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import mvc.module.christmas.ChristmasModel;
   import yishi.datas.goods.GoodsInfo;
   import yishi.datas.templates.ChristmasLotteryTempInfo;
   import yishi.manager.ChristmasManager;
   import yishi.manager.TempleteManager;
   import yishi.view.community.BaseItemView;
   
   public class ChristmasPrayPreviewItem extends Sprite implements Disposeable
   {
      
      private var _bg:Bitmap;
      
      private var _hBox:HBox;
      
      private var _index:int;
      
      public function ChristmasPrayPreviewItem(param1:int)
      {
         super();
         _index = param1;
         initView();
         refreshView();
      }
      
      private function initView() : void
      {
         _bg = ComponentFactory.Instance.creatBitmap("asset.ChristmasPrayPreviewItem.bg");
         _hBox = ComponentFactory.Instance.creatCustomObject("christmasPrayPreviewItem.hBox");
         addChild(_bg);
         addChild(_hBox);
      }
      
      public function refreshView() : void
      {
         var _loc3_:int = 0;
         var _loc5_:int = 0;
         var _loc4_:ChristmasLotteryTempInfo = null;
         var _loc9_:GoodsInfo = null;
         var _loc2_:BaseItemView = null;
         _hBox.beginChanges();
         var _loc6_:Array = [];
         var _loc1_:Array = TempleteManager.instance.christmasLotteryTempCate.getTemplatesByType(2);
         var _loc8_:int = (_index - 1) * 5;
         var _loc7_:int = _index * 5;
         _loc3_ = _loc8_;
         while(_loc3_ < _loc7_)
         {
            if(_loc1_[_loc3_])
            {
               _loc6_.push(_loc1_[_loc3_] as ChristmasLotteryTempInfo);
            }
            _loc3_++;
         }
         _loc5_ = 0;
         while(_loc5_ < _loc6_.length)
         {
            _loc4_ = _loc6_[_loc5_] as ChristmasLotteryTempInfo;
            _loc9_ = new GoodsInfo();
            _loc9_.templateId = _loc4_.ItemId;
            _loc9_.count = _loc4_.Num;
            _loc2_ = ComponentFactory.Instance.creatCustomObject("christmasPrayPreviewItem.goodsItemView");
            _loc2_.data = _loc9_;
            _hBox.addChild(_loc2_);
            _loc5_++;
         }
         _hBox.commitChanges();
      }
      
      private function get model() : ChristmasModel
      {
         return ChristmasManager.instance.model;
      }
      
      public function dispose() : void
      {
         ObjectUtils.disposeObject(_bg);
         _bg = null;
         ObjectUtils.disposeAllChildren(_hBox);
         _hBox = null;
      }
   }
}

