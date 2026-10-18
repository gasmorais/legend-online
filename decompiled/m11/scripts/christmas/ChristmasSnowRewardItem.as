package christmas
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.container.HBox;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import flash.utils.Dictionary;
   import mvc.module.christmas.ChristmasModel;
   import yishi.datas.goods.GoodsInfo;
   import yishi.datas.templates.ChristmasActivitiesTempInfo;
   import yishi.datas.templates.ChristmasLotteryTempInfo;
   import yishi.manager.ChristmasManager;
   import yishi.manager.TempleteManager;
   import yishi.view.community.BaseItemView;
   
   public class ChristmasSnowRewardItem extends Sprite implements Disposeable
   {
      
      private var _bg:Bitmap;
      
      private var _hBox:HBox;
      
      private var _index:int;
      
      public function ChristmasSnowRewardItem(param1:int)
      {
         super();
         _index = param1;
         initView();
         refreshView();
      }
      
      private function initView() : void
      {
         _hBox = ComponentFactory.Instance.creatCustomObject("christmasPrayPreviewItem.hBox1");
         _hBox.scaleX = _hBox.scaleY = 1.2;
         addChild(_hBox);
      }
      
      public function refreshView() : void
      {
         var _loc4_:int = 0;
         var _loc8_:int = 0;
         var _loc2_:int = 0;
         var _loc14_:String = null;
         var _loc9_:ChristmasLotteryTempInfo = null;
         var _loc6_:int = 0;
         var _loc5_:ChristmasLotteryTempInfo = null;
         var _loc16_:GoodsInfo = null;
         var _loc3_:BaseItemView = null;
         _hBox.beginChanges();
         var _loc7_:Array = [];
         var _loc12_:Array = TempleteManager.instance.christmasActivitiesTempCate.getTemplatesByType(4);
         var _loc1_:Array = [];
         var _loc10_:Dictionary = new Dictionary();
         for each(var _loc11_:ChristmasActivitiesTempInfo in _loc12_)
         {
            _loc4_ = 1;
            while(_loc4_ <= 4)
            {
               if(_loc11_["Reward" + _loc4_] != 0)
               {
                  _loc8_ = int(_loc11_["Reward" + _loc4_]);
                  _loc2_ = int(_loc11_["Num" + _loc4_]);
                  _loc14_ = _loc8_ + "_" + _loc2_;
                  if(_loc10_[_loc14_] == undefined)
                  {
                     _loc9_ = new ChristmasLotteryTempInfo();
                     _loc9_.ItemId = _loc8_;
                     _loc9_.Num = _loc2_;
                     _loc1_.push(_loc9_);
                     _loc10_[_loc14_] = true;
                  }
               }
               _loc4_++;
            }
         }
         var _loc15_:int = (_index - 1) * 4;
         var _loc13_:int = _index * 4;
         _loc4_ = _loc15_;
         while(_loc4_ < _loc13_)
         {
            if(_loc1_[_loc4_])
            {
               _loc7_.push(_loc1_[_loc4_] as ChristmasLotteryTempInfo);
            }
            _loc4_++;
         }
         _loc6_ = 0;
         while(_loc6_ < _loc7_.length)
         {
            _loc5_ = _loc7_[_loc6_] as ChristmasLotteryTempInfo;
            _loc16_ = new GoodsInfo();
            _loc16_.templateId = _loc5_.ItemId;
            _loc16_.count = _loc5_.Num;
            _loc3_ = ComponentFactory.Instance.creatCustomObject("christmasPrayPreviewItem.goodsItemView");
            _loc3_.data = _loc16_;
            _hBox.addChild(_loc3_);
            _loc6_++;
         }
         _hBox.commitChanges();
      }
      
      private function get model() : ChristmasModel
      {
         return ChristmasManager.instance.model;
      }
      
      public function dispose() : void
      {
         ObjectUtils.disposeAllChildren(_hBox);
         _hBox = null;
      }
   }
}

