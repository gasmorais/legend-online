package outyard.titan
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.ui.image.ScaleFrameImage;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Bitmap;
   import flash.utils.Dictionary;
   import yishi.datas.templates.OutyardTitanTemplateInfo;
   import yishi.filter.UIFilter;
   import yishi.interfaces.IFilterFormat;
   import yishi.manager.OutyardManager;
   import yishi.manager.TempleteManager;
   
   public class OutyardTitanPlayerView extends Component
   {
      
      private var _back:Bitmap;
      
      private var _item0:OutyardTitanPlayerItem;
      
      private var _item1:OutyardTitanPlayerItem;
      
      private var _item2:OutyardTitanPlayerItem;
      
      private var _item3:OutyardTitanPlayerItem;
      
      private var _box:ScaleFrameImage;
      
      private var _filter:IFilterFormat;
      
      public function OutyardTitanPlayerView()
      {
         super();
         initView();
         addEvent();
      }
      
      private function initView() : void
      {
         _back = ComponentFactory.Instance.creatBitmap("asset.outyard.titanPlayerBmp");
         _item0 = ComponentFactory.Instance.creatCustomObject("outyard.titan.OutyardTitanPlayerItem");
         _item0.x = 48;
         _item0.y = 3;
         _item1 = ComponentFactory.Instance.creatCustomObject("outyard.titan.OutyardTitanPlayerItem");
         _item1.x = 133;
         _item1.y = 3;
         _item2 = ComponentFactory.Instance.creatCustomObject("outyard.titan.OutyardTitanPlayerItem");
         _item2.x = 220;
         _item2.y = 3;
         _item3 = ComponentFactory.Instance.creatCustomObject("outyard.titan.OutyardTitanPlayerItem");
         _item3.x = 305;
         _item3.y = 3;
         addChild(_back);
         addChild(_item0);
         addChild(_item1);
         addChild(_item2);
         addChild(_item3);
         _filter = new UIFilter();
      }
      
      public function set index(param1:int) : void
      {
         var _loc6_:int = 0;
         var _loc2_:Array = OutyardManager.instance.titanModel.getBossInfoByType(param1);
         if(_loc2_ == null || _loc2_.length <= 0)
         {
            return;
         }
         _item0.data = _loc2_[0];
         _item1.data = _loc2_[1];
         _item2.data = _loc2_[2];
         _item3.data = _loc2_[3];
         _box = ComponentFactory.Instance.creatComponentByStylename("outyard.OutyardTitanPlayerItem.box" + param1);
         addChild(_box);
         var _loc3_:Array = [];
         var _loc7_:Dictionary = TempleteManager.instance.outyardTitanTemplateCate.getTemplates();
         for each(var _loc4_:OutyardTitanTemplateInfo in _loc7_)
         {
            if(_loc4_.level == param1)
            {
               _loc3_.push({
                  "itemId":_loc4_.itemId,
                  "count":_loc4_.count
               });
            }
         }
         var _loc5_:String = "2";
         _loc3_.sortOn("itemId",16);
         _loc6_ = 0;
         while(_loc6_ < _loc3_.length)
         {
            _loc5_ += "|1," + _loc3_[_loc6_].itemId + "," + _loc3_[_loc6_].count;
            _loc6_++;
         }
         _box.tipData = _loc5_;
         if(OutyardManager.instance.titanModel.titanlandMsg.curLevel < param1)
         {
            _box.setFrame(1);
            _filter.setGrayFilter(this);
         }
         else
         {
            _box.setFrame(2);
            _filter.setNormalFilter(this);
         }
      }
      
      private function addEvent() : void
      {
      }
      
      private function removeEvent() : void
      {
      }
      
      override public function dispose() : void
      {
         removeEvent();
         ObjectUtils.disposeObject(_back);
         _back = null;
         ObjectUtils.disposeObject(_item0);
         _item0 = null;
         ObjectUtils.disposeObject(_item1);
         _item1 = null;
         ObjectUtils.disposeObject(_item2);
         _item2 = null;
         ObjectUtils.disposeObject(_item3);
         _item3 = null;
         ObjectUtils.disposeObject(_box);
         _box = null;
         ObjectUtils.disposeObject(_filter);
         _filter = null;
         super.dispose();
      }
   }
}

