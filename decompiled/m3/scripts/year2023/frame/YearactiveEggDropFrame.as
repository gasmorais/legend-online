package year2023.frame
{
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.instance.IManualSize;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.ui.controls.ScrollPanel;
   import com.pickgliss.ui.image.Scale9CornerImage;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import flash.geom.Rectangle;
   import manager.LanguageMgr;
   import year2023.item.YearactiveEggDropItem;
   import yishi.datas.ComponentGroupType;
   import yishi.datas.goods.GoodsInfo;
   import yishi.datas.templates.CommonDropTempInfo;
   import yishi.keyboard.KeyBoardRegister;
   import yishi.manager.TempleteManager;
   
   public class YearactiveEggDropFrame extends Frame implements IManualSize
   {
      
      private var _bg:Scale9CornerImage;
      
      private var _goodsListView:Sprite;
      
      private var _scrollPanel:ScrollPanel;
      
      public function YearactiveEggDropFrame()
      {
         super();
         initView();
         addEvent();
      }
      
      public function get viewRectangle() : Rectangle
      {
         return new Rectangle(0,0,583,245);
      }
      
      private function initView() : void
      {
         titleText = LanguageMgr.GetTranslation("bottle.view.BottleDropFrame.titleText");
         _bg = ComponentFactory.Instance.creatComponentByStylename("bottle.BottleDropFrame.Bg");
         _scrollPanel = ComponentFactory.Instance.creatComponentByStylename("bottle.BottleDropScrollPanel");
         addToContent(_bg);
         addToContent(_scrollPanel);
         initGoodsListView();
      }
      
      private function initGoodsListView() : void
      {
         var _loc8_:GoodsInfo = null;
         var _loc1_:YearactiveEggDropItem = null;
         var _loc3_:Bitmap = null;
         var _loc7_:int = 0;
         var _loc6_:int = 0;
         _goodsListView = new Sprite();
         var _loc5_:Array = [];
         var _loc4_:Array = TempleteManager.instance.yearActiveDropCate.getDropGoods();
         for each(var _loc2_:CommonDropTempInfo in _loc4_)
         {
            _loc8_ = new GoodsInfo();
            _loc8_.templateId = _loc2_.itemId;
            _loc8_.count = _loc2_.count;
            if(_loc8_.templateInfo)
            {
               _loc5_.push(_loc8_);
            }
         }
         _loc7_ = Math.ceil(_loc5_.length / 3);
         _loc5_.sort(sortFun);
         _loc6_ = 0;
         while(_loc6_ < _loc5_.length)
         {
            _loc1_ = new YearactiveEggDropItem();
            _loc1_.x = 6 + _loc6_ % 3 * _loc1_.displayWidth;
            _loc1_.y = int(_loc6_ / 3) * _loc1_.displayHeight;
            _loc1_.data = _loc5_[_loc6_];
            _goodsListView.addChild(_loc1_);
            if(_loc6_ % 3 == 0 && _loc6_ != _loc5_.length - 1)
            {
               _loc3_ = ComponentFactory.Instance.creatBitmap("asset.bottle.DropFrameLine");
               _loc3_.y = _loc1_.y + _loc1_.displayHeight - _loc3_.height;
               _goodsListView.addChild(_loc3_);
            }
            _loc6_++;
         }
         if(_loc7_ > 0)
         {
            _goodsListView.scrollRect = new Rectangle(0,0,541,_loc7_ * _loc1_.displayHeight);
         }
         _scrollPanel.setView(_goodsListView);
      }
      
      protected function sortFun(param1:GoodsInfo, param2:GoodsInfo) : Number
      {
         var _loc3_:int = int(param1.templateInfo.SonType);
         var _loc4_:int = int(param2.templateInfo.SonType);
         if(param1.templateInfo.Profile > param2.templateInfo.Profile)
         {
            return -1;
         }
         if(param1.templateInfo.Profile < param2.templateInfo.Profile)
         {
            return 1;
         }
         if(_loc3_ < _loc4_)
         {
            return -1;
         }
         if(_loc3_ > _loc4_)
         {
            return 1;
         }
         if(param1.templateId < param2.templateId)
         {
            return 1;
         }
         if(param1.templateId > param2.templateId)
         {
            return -1;
         }
         return 0;
      }
      
      private function addEvent() : void
      {
         addEventListener("response",__frameResponseHandler);
      }
      
      private function removeEvent() : void
      {
         removeEventListener("response",__frameResponseHandler);
      }
      
      private function __frameResponseHandler(param1:FrameEvent) : void
      {
         switch(int(param1.responseCode))
         {
            case 0:
            case 1:
               dispose();
         }
      }
      
      public function show() : void
      {
         KeyBoardRegister.instance.keyEnable = false;
         LayerManager.Instance.addToLayer(this,3,true,true,1);
      }
      
      override public function get groups() : Array
      {
         return [ComponentGroupType.NONE];
      }
      
      override public function dispose() : void
      {
         KeyBoardRegister.instance.keyEnable = true;
         removeEvent();
         ObjectUtils.disposeObject(_bg);
         _bg = null;
         ObjectUtils.disposeAllChildren(_goodsListView);
         ObjectUtils.disposeAllChildren(this);
         super.dispose();
      }
   }
}

