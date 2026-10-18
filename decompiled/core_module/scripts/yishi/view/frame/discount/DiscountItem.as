package yishi.view.frame.discount
{
   import com.pickgliss.loader.LoaderManagerII;
   import com.pickgliss.loader.data.LoaderInfo;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.SelectedIconButton;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.ui.text.FilterFrameText;
   import flash.display.Bitmap;
   import flash.display.DisplayObject;
   import yishi.datas.templates.GoodsTemplateInfo;
   import yishi.filter.UIFilter;
   import yishi.manager.PathManager;
   import yishi.manager.TempleteManager;
   
   public class DiscountItem extends Component
   {
      
      public var selectBtn:SelectedIconButton;
      
      public var itemId:int;
      
      private var _text:FilterFrameText;
      
      private var _enable:Boolean = false;
      
      public function DiscountItem(param1:int)
      {
         itemId = param1;
         super();
      }
      
      public function get enable() : Boolean
      {
         return _enable;
      }
      
      public function set enable(param1:Boolean) : void
      {
         _enable = param1;
         if(param1)
         {
            this.filters = null;
         }
         else
         {
            this.filters = [UIFilter.getGrayFilter()];
         }
         selectBtn.enable = param1;
      }
      
      override protected function init() : void
      {
         var _loc2_:String = null;
         var _loc1_:Array = null;
         var _loc3_:DisplayObject = ComponentFactory.Instance.creat("asset.quickbuy.quanSmallBg");
         _loc3_.height = 108;
         this.addChild(_loc3_);
         selectBtn = ComponentFactory.Instance.creat("quickbuy.discountSelfSelectedBtn");
         this.addChild(selectBtn);
         _text = ComponentFactory.Instance.creatComponentByStylename("quickbuy.discountItemDes");
         this.addChild(_text);
         var _loc4_:GoodsTemplateInfo = TempleteManager.instance.goodsTemplateCate.getTemplateByID(itemId);
         if(itemId == 3171001 || itemId == 3172001 || itemId == 3173001)
         {
            _loc1_ = _loc4_.Description.split("，");
            if(_loc1_.length == 2)
            {
               _loc2_ = _loc1_[1];
            }
            else if(_loc1_.length == 3)
            {
               _loc2_ = _loc1_[1] + "\n" + _loc1_[2];
            }
            else if(_loc1_.length == 4)
            {
               _loc2_ = _loc1_[1] + "\n" + _loc1_[2] + "\n" + _loc1_[3];
            }
         }
         else
         {
            _loc2_ = _loc4_.Description;
         }
         _text.text = "【" + _loc4_.TemplateName + "】" + "\n" + _loc2_;
         var _loc5_:String = PathManager.resourcePath + "icon" + _loc4_.Icon;
         LoaderManagerII.instance.load(_loc5_,2,0,loadComplete);
      }
      
      private function loadComplete(param1:LoaderInfo, param2:Object) : void
      {
         if(param2 is Bitmap)
         {
            selectBtn.unselectedIcon = new Bitmap(Bitmap(param2).bitmapData);
            selectBtn.selectedIcon = new Bitmap(Bitmap(param2).bitmapData);
         }
      }
      
      override public function dispose() : void
      {
         super.dispose();
      }
   }
}

