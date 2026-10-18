package remainsexplore
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Bitmap;
   import flash.display.Shape;
   import manager.LanguageMgr;
   import mvc.module.remainsexplore.RemainsExploreModel;
   import yishi.manager.RemainsExploreManager;
   import yishi.manager.TempleteManager;
   
   public class RemainsExploreProgressView extends Component
   {
      
      private var _back:Bitmap;
      
      private var _pressImg:Bitmap;
      
      private var _shapeMask:Shape;
      
      private var _actValue:FilterFrameText;
      
      private var activeConfigArr:Array;
      
      private var maxActive:int = 100;
      
      private var _fetchItemDic:Array;
      
      private var _type:int = 1;
      
      public function RemainsExploreProgressView()
      {
         super();
         initView();
         refreshView();
      }
      
      private function initView() : void
      {
         _back = ComponentFactory.Instance.creatBitmap("asset.dayGuide.ActiveProgressBack");
         _pressImg = ComponentFactory.Instance.creatBitmap("asset.dayGuide.ActiveProgressImg");
         _shapeMask = new Shape();
         _shapeMask.graphics.beginFill(0);
         _shapeMask.graphics.drawRect(0,0,_pressImg.width,_pressImg.height);
         _shapeMask.graphics.endFill();
         _shapeMask.x = _pressImg.x;
         _shapeMask.y = _pressImg.y;
         _pressImg.mask = _shapeMask;
         _actValue = ComponentFactory.Instance.creatComponentByStylename("dayGuide.actValueTxt");
         addChild(_back);
         addChild(_pressImg);
         addChild(_shapeMask);
         addChild(_actValue);
         initFetchItem();
      }
      
      private function initFetchItem() : void
      {
         var _loc2_:int = 0;
         var _loc1_:RemainsExploreBoxItem = null;
         _fetchItemDic = [];
         _loc2_ = 1;
         while(_loc2_ < 6)
         {
            _loc1_ = ComponentFactory.Instance.creatCustomObject("remainsexplore.RemainsExploreBoxItem" + _loc2_);
            _loc1_.index = _loc2_;
            _loc1_.state = 0;
            _fetchItemDic.push(_loc1_);
            addChild(_loc1_);
            _loc2_++;
         }
      }
      
      public function refreshView() : void
      {
         var _loc2_:int = 0;
         var _loc1_:RemainsExploreBoxItem = null;
         _loc2_ = 0;
         while(_loc2_ < _fetchItemDic.length)
         {
            _loc1_ = _fetchItemDic[_loc2_] as RemainsExploreBoxItem;
            _loc1_.tipData = getLeedRewardTipsStr(_type,_loc2_ + 1);
            _loc1_.type = _type;
            _loc1_.state = model.getState(_type,_loc2_ + 1);
            _loc2_++;
         }
      }
      
      public function getLeedRewardTipsStr(param1:int, param2:int) : String
      {
         var _loc5_:int = 0;
         var _loc3_:Array = TempleteManager.instance.remainsExploreActivityDropTempCate.getTemplatesByTypeIndex(param1,param2);
         var _loc4_:String = LanguageMgr.GetTranslation("dayguide.LimitedSellView.ActiveBoxItemTips") + "\n";
         if(_loc3_ != null)
         {
            _loc5_ = 0;
            while(_loc5_ < _loc3_.length)
            {
               if(_loc5_ == _loc3_.length - 1)
               {
                  if(_loc3_[_loc5_].itemId < 0)
                  {
                     _loc4_ += getGoodsName(_loc3_[_loc5_].itemId) + _loc3_[_loc5_].count + "";
                  }
                  else if(_loc3_[_loc5_].itemId > 0)
                  {
                     _loc4_ += getGoodsName(_loc3_[_loc5_].itemId) + _loc3_[_loc5_].count + LanguageMgr.GetTranslation("shop.view.frame.BuyFrame.vipBuyInfo03");
                  }
               }
               else if(_loc3_[_loc5_].itemId < 0)
               {
                  _loc4_ += getGoodsName(_loc3_[_loc5_].itemId) + _loc3_[_loc5_].count + ",\n";
               }
               else if(_loc3_[_loc5_].itemId > 0)
               {
                  _loc4_ += getGoodsName(_loc3_[_loc5_].itemId) + _loc3_[_loc5_].count + LanguageMgr.GetTranslation("shop.view.frame.BuyFrame.vipBuyInfo03") + ",\n";
               }
               _loc5_++;
            }
         }
         return _loc4_;
      }
      
      private function getGoodsName(param1:int) : String
      {
         return TempleteManager.instance.goodsTemplateCate.getTemplateByID(param1).TemplateName;
      }
      
      private function get model() : RemainsExploreModel
      {
         return RemainsExploreManager.instance.model;
      }
      
      public function set type(param1:int) : void
      {
         _type = param1;
      }
      
      public function set data(param1:int) : void
      {
         _shapeMask.scaleX = param1 / maxActive;
         _actValue.text = param1.toString() + " / " + maxActive;
      }
      
      override public function dispose() : void
      {
         ObjectUtils.disposeObject(_back);
         _back = null;
         ObjectUtils.disposeObject(_pressImg);
         _pressImg = null;
         ObjectUtils.disposeObject(_shapeMask);
         _shapeMask = null;
         ObjectUtils.disposeObject(_actValue);
         _actValue = null;
         ObjectUtils.disposeAllChildren(this);
         super.dispose();
      }
   }
}

